# -*- coding: utf-8 -*-
"""《发现隐患、预判风险》配乐 — 代码合成（借 score-example-cinematic 手法，不照搬曲子）
92 BPM · D 小调 · 50.0s · 48kHz 立体声
段落（对齐 plan 镜头边界）：
  0.0-5.87  intro  sub脉冲+pad渐强（水位线升起）
  5.87-11.74 metrics 和弦铺底+轻拍点
  11.74-18.26 scan   pluck琶音进入+riser
  18.26-24.78 verdict impact落鼓+暗和声
  24.78-30.65 loop   六音pluck动机（配节点点亮）+hat
  30.65-36.52 hub    全奏（kick+hat+arp）
  36.52-43.70 predict 全奏+16分arp加密+riser
  43.70-50.0  close  终和弦Dm(add9)+长尾
"""
import numpy as np
from scipy import signal as sg
import soundfile as sf

SR = 48000
DUR = 50.0
BPM = 92.0
BEAT = 60.0 / BPM
N = int(SR * DUR)
t_all = np.arange(N) / SR

rng = np.random.default_rng(20261022)  # 固定种子，可复现

mix = np.zeros(N)


def add(sig, at):
    i0 = int(at * SR)
    i1 = min(N, i0 + len(sig))
    if i0 < N:
        mix[i0:i1] += sig[: i1 - i0]


def env_ad(n, a, d, curve=4.0):
    """attack-decay 包络"""
    e = np.ones(n)
    na = max(1, int(a * SR))
    nd = max(1, int(d * SR))
    na = min(na, n); nd = min(nd, n)
    e[:na] = np.linspace(0, 1, na)
    if nd < n:
        e[-nd:] *= np.exp(-curve * np.linspace(0, 1, nd))
    return e


# ---------- 乐器 ----------
def sub(freq, dur, gain):
    n = int(dur * SR)
    tt = np.arange(n) / SR
    s = np.sin(2 * np.pi * freq * tt) * env_ad(n, 0.005, dur * 0.8)
    return s * gain


def saw_stack(freqs, dur, gain, detune=0.003, lp=1800):
    """detuned saw pad → lowpass"""
    n = int(dur * SR)
    tt = np.arange(n) / SR
    out = np.zeros(n)
    for f in freqs:
        for dt in (-detune, 0.0, detune):
            ff = f * (1 + dt)
            out += sg.sawtooth(2 * np.pi * ff * tt)
    out /= (len(freqs) * 3)
    b, a = sg.butter(2, lp / (SR / 2), 'low')
    out = sg.lfilter(b, a, out)
    out *= env_ad(n, min(0.5, dur * 0.3), dur * 0.5, curve=2.0)
    return out * gain


def pluck(freq, dur, gain):
    """三角+锯混合拨弦，快衰减"""
    n = int(dur * SR)
    tt = np.arange(n) / SR
    s = 0.6 * sg.sawtooth(2 * np.pi * freq * tt) + 0.4 * np.abs(sg.sawtooth(2 * np.pi * freq * tt)) * 2 - 1
    b, a = sg.butter(2, 3200 / (SR / 2), 'low')
    s = sg.lfilter(b, a, s)
    e = np.exp(-6.5 * tt / dur) * np.minimum(1, tt / 0.004)
    return s * e * gain


def kick(gain=0.9):
    n = int(0.16 * SR)
    tt = np.arange(n) / SR
    f = 120 * np.exp(-tt * 18) + 44
    ph = 2 * np.pi * np.cumsum(f) / SR
    return np.sin(ph) * np.exp(-tt * 22) * gain


def hat(gain=0.16):
    n = int(0.05 * SR)
    noise = rng.standard_normal(n)
    b, a = sg.butter(2, 6500 / (SR / 2), 'high')
    return sg.lfilter(b, a, noise) * np.exp(-np.arange(n) / SR * 60) * gain


def tick(gain=0.2):
    n = int(0.03 * SR)
    noise = rng.standard_normal(n)
    b, a = sg.butter(2, [2400 / (SR / 2), 3800 / (SR / 2)], 'band')
    return sg.lfilter(b, a, noise) * np.exp(-np.arange(n) / SR * 90) * gain


def riser(dur, gain):
    n = int(dur * SR)
    tt = np.arange(n) / SR
    noise = rng.standard_normal(n)
    # 扫频带通：400→4500Hz
    out = np.zeros(n)
    steps = 24
    for k in range(steps):
        i0 = k * n // steps; i1 = (k + 1) * n // steps
        f = 400 * (4500 / 400) ** (k / (steps - 1))
        b, a = sg.butter(2, [f * 0.8 / (SR / 2), f * 1.25 / (SR / 2)], 'band')
        out[i0:i1] = sg.lfilter(b, a, noise[i0:i1])
    out *= (tt / dur) ** 2.2 * gain
    return out


def impact(gain=1.0):
    n = int(0.8 * SR)
    tt = np.arange(n) / SR
    thump = np.sin(2 * np.pi * 52 * tt) * np.exp(-tt * 6)
    noise = rng.standard_normal(n) * np.exp(-tt * 10) * 0.25
    b, a = sg.butter(2, 900 / (SR / 2), 'low')
    return (thump + sg.lfilter(b, a, noise)) * gain


# ---------- 音高（D 小调）----------
D1, D2, D3, F3, A3, D4, E4, F4, G4, A4, C5, D5 = 36.71, 73.42, 146.83, 174.61, 220.0, 293.66, 329.63, 349.23, 392.0, 440.0, 523.25, 587.33
Bb2, Bb3 = 116.54, 233.08
G3 = 196.0
C4 = 261.63

# ---------- 段落编排 ----------
# intro 0-5.87：sub 每拍 + pad Dm 渐强 + 水位riser(短)
for k in range(9):
    add(sub(D1, 0.6, 0.34 if k else 0.22), k * BEAT)
add(saw_stack([D3, F3, A3], 6.1, 0.16, lp=1400), 0.0)
add(riser(2.4, 0.10), 0.2)

# metrics 5.87-11.74：和弦 Dm→Bb→F→C 各两拍 + tick
chords = [(D3, F3, A3), (Bb3, D4, F4), (F3, A3, C4), (C4, E4, G4)]
for ci, ch in enumerate(chords):
    add(saw_stack(list(ch), 2 * BEAT + 0.3, 0.15), 5.87 + ci * 2 * BEAT)
for k in range(9, 18):
    add(tick(0.10), k * BEAT)
    add(sub(D1, 0.5, 0.26), k * BEAT)

# scan 11.74-18.26：pluck 琶音 8 分 + pad + riser 进判定
arp_notes = [D4, F4, A4, D5]
step8 = BEAT / 2
k8 = int(np.ceil(11.74 / step8))
idx8 = 0
while k8 * step8 < 18.0:
    add(pluck(arp_notes[idx8 % 4], 0.5, 0.20), k8 * step8)
    idx8 += 1
    k8 += 1
add(saw_stack([D3, F3, A3], 4.0, 0.13), 11.74)
add(saw_stack([G3, Bb3, D4], 2.4, 0.12), 15.86)
add(riser(1.56, 0.16), 16.7)

# verdict 18.26-24.78：impact + kick 每拍 + 暗和声 Dm→Gm
add(impact(0.9), 18.26)
for k in range(int(round(18.26 / BEAT)), int(round(24.7 / BEAT))):
    add(kick(0.62), k * BEAT)
    add(sub(D1, 0.5, 0.30), k * BEAT)
add(saw_stack([D3, F3, A3], 3.3, 0.13, lp=1200), 18.26)
add(saw_stack([G3, Bb3, D4], 3.2, 0.12, lp=1200), 21.5)

# loop 24.78-30.65：六音 pluck 动机（对节点 25.58/26.08/.../28.08）+ hat 8 分
motif = [D4, F4, A4, G4, F4, D4]
for mi, f in enumerate(motif):
    add(pluck(f, 0.8, 0.26), 25.58 + mi * 0.5)
add(saw_stack([Bb3, D4, F4], 5.0, 0.12), 24.78)
for k in range(int(round(24.78 / (BEAT / 2))), int(round(30.4 / (BEAT / 2)))):
    add(hat(0.13), k * BEAT / 2)
add(sub(D1, 0.5, 0.28), 24.78); add(sub(D1, 0.5, 0.28), 24.78 + 2 * BEAT); add(sub(D1, 0.5, 0.28), 24.78 + 4 * BEAT)
add(pluck(D5, 1.2, 0.22), 28.98)   # 环线闭合 resolve 配合 sfx

# hub 30.65-36.52：全奏
add(impact(0.55), 30.65)
add(saw_stack([D3, A3, D4], 5.4, 0.15), 30.65)
for k in range(int(round(30.65 / BEAT)), int(round(36.3 / BEAT))):
    add(kick(0.6), k * BEAT)
    add(sub(D1, 0.5, 0.30), k * BEAT)
    add(hat(0.14), k * BEAT + BEAT / 2)
for k in range(int(round(30.65 / (BEAT / 2))), int(round(36.3 / (BEAT / 2)))):
    idx = int((k * BEAT / 2 - 30.65) / (BEAT / 2))
    add(pluck(arp_notes[idx % 4] / 1 if idx % 2 == 0 else arp_notes[idx % 4] * 2, 0.4, 0.10), k * BEAT / 2)

# predict 36.52-43.70：全奏加密（16 分 arp）+ riser
add(saw_stack([F3, A3, C5], 3.6, 0.15), 36.52)
add(saw_stack([Bb3, D4, F4], 3.6, 0.14), 40.2)
for k in range(int(round(36.52 / BEAT)), int(round(43.4 / BEAT))):
    add(kick(0.58), k * BEAT)
    add(sub(D1, 0.5, 0.28), k * BEAT)
    add(hat(0.13), k * BEAT + BEAT / 4)
    add(hat(0.10), k * BEAT + 3 * BEAT / 4)
step16 = BEAT / 4
k16 = int(round(36.52 / step16))
while k16 * step16 < 43.3:
    idx = k16 % 8
    seq = [D4, F4, A4, D5, A4, F4, E4, F4]
    add(pluck(seq[idx], 0.3, 0.085), k16 * step16)
    k16 += 1
add(riser(1.3, 0.15), 42.4)

# close 43.70-50.0：终和弦 Dm(add9) + 长尾淡出
add(impact(0.7), 43.70)
add(saw_stack([D3, A3, D4, E4, F4], 6.4, 0.17, lp=1500), 43.70)
for f in (D4, F4, A4):
    add(pluck(f, 1.6, 0.16), 44.5)
add(sub(D1, 2.0, 0.24), 43.70)

# ---------- 卷积混响（生成 IR） ----------
ir_len = int(1.4 * SR)
ir = rng.standard_normal(ir_len) * np.exp(-np.arange(ir_len) / SR * 3.2)
ir[: int(0.01 * SR)] *= np.linspace(0, 1, int(0.01 * SR))
b, a = sg.butter(2, 5500 / (SR / 2), 'low')
ir = sg.lfilter(b, a, ir)
ir /= np.max(np.abs(ir)) * 6
wet = sg.fftconvolve(mix, ir)[:N]
out = mix + wet * 0.30

# ---------- 母带 ----------
fade = np.ones(N)
f0 = int(48.5 * SR)
fade[f0:] = np.linspace(1, 0, N - f0) ** 1.5
out *= fade
out = np.tanh(out * 1.25)          # soft clip
out /= np.max(np.abs(out)) / (10 ** (-1.2 / 20))

# 立体声：微宽（8ms 延迟差）
delay = int(0.008 * SR)
L = out.copy()
R = np.concatenate([np.zeros(delay), out[:-delay]])
stereo = np.stack([L * 0.5 + R * 0.5, L * 0.5 + R * 0.5], axis=1)
stereo[:, 0] = out * 0.96
stereo[:, 1] = np.concatenate([np.zeros(delay), out[:-delay]]) * 0.96 + out * 0.04

sf.write('assets/music.wav', stereo, SR, subtype='PCM_16')
peak = 20 * np.log10(np.max(np.abs(stereo)))
rms = 20 * np.log10(np.sqrt(np.mean(stereo ** 2)))
print(f'music.wav written: peak {peak:.1f} dBFS, rms {rms:.1f} dBFS, {DUR}s')
