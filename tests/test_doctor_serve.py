"""M0.5 doctor 自检与 serve 心跳（可注入循环上限，不真驻留）。"""
import json
import os

from paistation.main import doctor, serve


def _write_ini(tmp_path):
    p = tmp_path / "pai.ini"
    p.write_text(f"[sense]\nwatch_dirs = {tmp_path}\n", encoding="utf-8")
    return str(p)


def test_doctor_all_green(tmp_path, monkeypatch):
    monkeypatch.delenv("PAI_LLM_KEY", raising=False)
    # 造一个本地 secret ini 让 key 检查通过（不碰真实密钥）
    secret = tmp_path / "llm.secret.ini"
    secret.write_text("[llm]\napi_key = " + "k" * 49 + "\n", encoding="utf-8")
    results = doctor(_write_ini(tmp_path),
                     secret_ini=str(secret), data_dir=str(tmp_path / "data"))
    assert all(ok for _, ok in results)
    assert len(results) >= 4  # config/key/deps/data 至少四项


def test_doctor_bad_config(tmp_path, monkeypatch):
    monkeypatch.delenv("PAI_LLM_KEY", raising=False)
    p = tmp_path / "pai.ini"
    p.write_text("[llm]\nupgrade_confidence = 0.3\n", encoding="utf-8")
    results = doctor(str(p), secret_ini=str(tmp_path / "none.ini"),
                     data_dir=str(tmp_path / "data"))
    assert results[0][0].startswith("配置校验") and results[0][1] is False


def test_serve_heartbeats_then_exits(tmp_path):
    ini = _write_ini(tmp_path)
    db = str(tmp_path / "audit.db")
    serve(ini, db=db, max_ticks=3, interval=0.01)
    from paistation.security.audit import AuditLog
    a = AuditLog(db)
    rows = a.query(action="heartbeat")
    a.close()
    assert len(rows) == 3
    assert json.loads(json.dumps(rows[0]["detail"]))["pid"] == os.getpid()
