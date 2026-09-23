# -*- coding: utf-8 -*-
"""P2 单卡微调（官方 notebook cell-8 适配 Quadro RTX 3000 6GB）。

与官方配方差异（均有 issue 依据）：
  - DDP→单卡；AMP→**fp32 全程**（#185：头输出 ~300× 编码器尺度，AMP 必炸）
  - 温度拟合用 **held-out**（#186：train-slice 拟合=过拟合）非训练切片
  - MICRO_BATCH=2 × GRAD_ACCUM=16（6GB 显存预算，等效批 32）
其余照抄：proper_reward(GRPO 式)+CE 引导、Sigma 0.4→0.1、Cosine LR、
滚动检查点、fp16 半存权重。

用法（晚间窗，服务已停时）:
  <laya-server>/venv/Scripts/python.exe finetune/train.py [--smoke]
产出: finetune/checkpoint-ft-v1/{model.safetensors,encoder/,tokenizer/,
       rl_agent_config.json,train_log.json}
"""
from __future__ import annotations

import json
import os
import random
import sys
import time
from pathlib import Path

import torch
from safetensors.torch import load_file, save_file
from transformers import AutoTokenizer
from huggingface_hub import snapshot_download

from laya.agent import _fix_tokenizer_config
from laya.common import QTYPES, build_model, proper_reward

FT = Path(__file__).resolve().parent
SVC = FT.parent
SUFFIX = os.environ.get("LAYA_DS_SUFFIX", "")   # "" | "_v2"（v2 扩标数据集）
OUT_DIR = FT / f"checkpoint-ft-v1{SUFFIX}"

EPOCHS = 4
MICRO_BATCH = 2
GRAD_ACCUM = 16
GROUP_SIZE = 4
LR_ENCODER = 2.5e-5
LR_HEAD = 1.0e-4
SIGMA_START = 0.4
SIGMA_END = 0.1


def collate_train_batch(items, pad_id):
    n, L = len(items), max(len(it["ids"]) for it in items)
    kmax = max(len(it["markers"]) for it in items)
    ids = torch.full((n, L), pad_id, dtype=torch.long)
    att = torch.zeros((n, L), dtype=torch.long)
    mpos = torch.zeros((n, kmax), dtype=torch.long)
    mmask = torch.zeros((n, kmax), dtype=torch.bool)
    target = torch.zeros((n, kmax), dtype=torch.float32)
    for i, it in enumerate(items):
        ids[i, : len(it["ids"])] = torch.tensor(it["ids"])
        att[i, : len(it["ids"])] = 1
        k = len(it["markers"])
        mpos[i, :k] = torch.tensor(it["markers"])
        mmask[i, :k] = True
        target[i, : len(it["target"])] = torch.tensor(
            it["target"], dtype=torch.float32)
    return {"input_ids": ids, "attention_mask": att, "marker_pos": mpos,
            "marker_mask": mmask, "target": target,
            "qtype": torch.tensor([it["qtype"] for it in items]),
            "label": torch.tensor([it["label"] for it in items])}


def fit_one_temp(sel):
    """LBFGS 温度拟合（held-out）。"""
    if len(sel) < 10:
        return 1.0
    kmax = max(len(z) for z, _ in sel)
    Z = torch.full((len(sel), kmax), -1e4)
    T = torch.zeros((len(sel), kmax))
    for i, (z, t) in enumerate(sel):
        Z[i, :len(z)] = torch.tensor(z)
        T[i, :len(t)] = torch.tensor(t, dtype=torch.float32)
    log_t = torch.zeros(1, requires_grad=True)
    opt = torch.optim.LBFGS([log_t], lr=0.1, max_iter=100)

    def closure():
        opt.zero_grad()
        loss = -(T * torch.log_softmax(Z / log_t.exp(), -1)).sum(-1).mean()
        loss.backward()
        return loss

    opt.step(closure)
    return float(torch.clamp(log_t.exp(), 0.1, 10.0).item())


def _base_model_dir() -> Path:
    d = snapshot_download("convaiinnovations/laya",
                          allow_patterns=["multilingual/*"])
    d = Path(d) / "multilingual"
    _fix_tokenizer_config(str(d))
    return d


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    smoke = "--smoke" in sys.argv
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    if device.type != "cuda":
        raise SystemExit("需要 CUDA（晚间窗独占显存训练）")

    model_dir = _base_model_dir()
    cfg = json.load(open(model_dir / "rl_agent_config.json", encoding="utf-8"))
    cfg["gradient_checkpointing"] = True
    cfg["max_tokens_per_batch"] = 4096
    cfg["max_len"] = 1024
    cfg["head_max_len"] = 256

    tok = AutoTokenizer.from_pretrained(str(model_dir / "tokenizer"))
    model = build_model(cfg, encoder_dir=str(model_dir / "encoder"))
    model.load_state_dict(load_file(str(model_dir / "model.safetensors")),
                          strict=True)
    model.encoder.gradient_checkpointing_enable(
        gradient_checkpointing_kwargs={"use_reentrant": False})
    model.head_checkpointing = True
    model.to(device)
    model.train()

    train_items = torch.load(FT / f"train_items{SUFFIX}.pt", weights_only=False)
    heldout_items = torch.load(FT / f"heldout_items{SUFFIX}.pt",
                               weights_only=False)
    if smoke:
        train_items, heldout_items = train_items[:16], heldout_items[:8]
        EPOCHS_S = 1
    else:
        EPOCHS_S = EPOCHS

    enc_params = [p for n, p in model.named_parameters() if "encoder." in n]
    head_params = [p for n, p in model.named_parameters() if "encoder." not in n]
    optimizer = torch.optim.AdamW(
        [{"params": enc_params, "lr": LR_ENCODER},
         {"params": head_params, "lr": LR_HEAD}], weight_decay=0.01)
    total_updates = max(
        1, (len(train_items) // (MICRO_BATCH * GRAD_ACCUM)) * EPOCHS_S)
    scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(
        optimizer, T_max=total_updates, eta_min=1e-6)

    print(f"[train] {len(train_items)} items | {EPOCHS_S} epochs | "
          f"fp32 | micro={MICRO_BATCH} accum={GRAD_ACCUM} | {device}",
          flush=True)
    log = {"started": time.strftime("%Y-%m-%dT%H:%M:%S"), "epochs": [],
           "smoke": smoke}
    t0 = time.time()

    for epoch in range(EPOCHS_S):
        random.seed(42 + epoch)
        random.shuffle(train_items)
        epoch_loss, n_batches = 0.0, 0
        accum_step = 0
        optimizer.zero_grad(set_to_none=True)
        progress = epoch / max(1, EPOCHS_S - 1)
        sigma = SIGMA_START + (SIGMA_END - SIGMA_START) * progress

        for b_idx in range(0, len(train_items), MICRO_BATCH):
            chunk = train_items[b_idx:b_idx + MICRO_BATCH]
            batch = collate_train_batch(chunk, tok.pad_token_id)
            logits, act = model(
                batch["input_ids"].to(device), batch["attention_mask"].to(device),
                batch["marker_pos"].to(device), batch["marker_mask"].to(device),
                batch["qtype"].to(device))
            logits = logits.float()
            mask = batch["marker_mask"].to(device)
            k = mask.sum(-1, keepdim=True).float()
            target = batch["target"].to(device)

            eps = torch.randn((GROUP_SIZE,) + logits.shape,
                              device=device) * sigma * mask
            eps = (eps - eps.sum(-1, keepdim=True) / k) * mask
            z = logits.detach().unsqueeze(0) + eps
            q = torch.softmax(z.masked_fill(~mask, -1e4), -1)
            with torch.no_grad():
                r = proper_reward(q, target.unsqueeze(0),
                                  batch["qtype"].to(device), mask,
                                  w_sph=0.75, w_rps=1.0)
                adv = r - r.mean(0, keepdim=True)
                adv = adv / (adv.std() + 1e-6)
            logp = -(((z - logits.unsqueeze(0)) ** 2) * mask).sum(-1) \
                / (2 * sigma ** 2)
            loss_rl = -(adv * logp).mean()
            loss_ce = -(target * torch.log_softmax(
                logits.masked_fill(~mask, -1e4), -1)).sum(-1).mean()
            loss = loss_rl + 1.0 * loss_ce + 0.0 * act.sum()
            loss.backward()                       # fp32：无 scaler
            accum_step += 1
            if accum_step % GRAD_ACCUM == 0 or \
                    (b_idx + MICRO_BATCH) >= len(train_items):
                torch.nn.utils.clip_grad_norm_(model.parameters(), 1.0)
                optimizer.step()
                scheduler.step()
                optimizer.zero_grad(set_to_none=True)
            epoch_loss += loss.item()
            n_batches += 1
            if n_batches % 20 == 0:
                print(f"  ep{epoch+1} step{n_batches} "
                      f"loss={loss.item():.4f} reward={r.mean().item():.3f} "
                      f"mem={torch.cuda.max_memory_allocated()/1e9:.2f}G",
                      flush=True)

        log["epochs"].append({"epoch": epoch + 1,
                              "avg_loss": epoch_loss / max(1, n_batches),
                              "seconds": round(time.time() - t0, 1)})
        print(f"=== Epoch {epoch+1}/{EPOCHS_S} "
              f"{time.time()-t0:.0f}s loss={epoch_loss/max(1,n_batches):.4f} ===",
              flush=True)
        _save(model, tok, cfg, OUT_DIR, epoch + 1, None)   # 滚动检查点

    # held-out 温度拟合（#186）
    print("[calib] held-out temperature fitting ...", flush=True)
    del optimizer, scheduler
    torch.cuda.empty_cache()
    model.eval()
    calib_preds = []
    with torch.no_grad():
        for c in range(0, len(heldout_items), 16):
            cb = collate_train_batch(heldout_items[c:c + 16], tok.pad_token_id)
            l_sub, _ = model(cb["input_ids"].to(device),
                             cb["attention_mask"].to(device),
                             cb["marker_pos"].to(device),
                             cb["marker_mask"].to(device),
                             cb["qtype"].to(device))
            l_np = l_sub.float().cpu().numpy()
            for r_i, it in enumerate(heldout_items[c:c + 16]):
                k = len(it["markers"])
                calib_preds.append((it["qtype"], l_np[r_i, :k], it["target"]))
    temps = [1.2, 1.2, 1.2]
    names = ["choice", "score", "noul"]
    for qt in range(3):
        sel = [(z, t) for q_type, z, t in calib_preds if q_type == qt]
        if sel:
            temps[qt] = fit_one_temp(sel)
    print(f"[calib] temps {dict(zip(names, [round(t,3) for t in temps]))}",
          flush=True)

    _save(model, tok, cfg, OUT_DIR, EPOCHS_S, temps)
    log["finished"] = time.strftime("%Y-%m-%dT%H:%M:%S")
    log["temps_heldout"] = dict(zip(names, [round(t, 4) for t in temps]))
    log["vram_peak_gb"] = round(torch.cuda.max_memory_allocated() / 1e9, 2)
    (FT / "train_log.json").write_text(
        json.dumps(log, ensure_ascii=False, indent=1), encoding="utf-8")
    print(json.dumps(log, ensure_ascii=False, indent=1))
    return 0


def _save(model, tok, cfg, out: Path, epoch, temps) -> None:
    out.mkdir(parents=True, exist_ok=True)
    sd = {k: v.half().contiguous().cpu()
          for k, v in model.state_dict().items()}
    save_file(sd, str(out / "model.safetensors"))
    model.encoder.config.save_pretrained(str(out / "encoder"))
    tok.save_pretrained(str(out / "tokenizer"))
    c = dict(cfg)
    c["fine_tuned"] = True
    c["model_name"] = "laya-zh-judgment-v1"
    if temps:
        c["temperature"] = temps
    with open(out / "rl_agent_config.json", "w", encoding="utf-8") as f:
        json.dump(c, f, indent=2)


if __name__ == "__main__":
    raise SystemExit(main())
