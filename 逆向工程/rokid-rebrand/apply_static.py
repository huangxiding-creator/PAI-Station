# -*- coding: utf-8 -*-
"""apply_static.py — RokidAI.apk 静态资源层品牌改造（水利安全AI眼镜定制版）

最小改动纪律：
  - 只改用户可见品牌串；URL/包名/SDK 标识一概不动（正则白名单制）
  - 图标/splash 全量替换为 V3 官网品牌资产
  - 顺序敏感：先 主页(tab)→排查，后 社区→主页，避免串键碰撞
幂等：可重复执行（值已是目标值时跳过）。仅动 apktool_out/。
"""
import re
import shutil
from pathlib import Path

ROOT = Path(r"E:\AI-Station\逆向工程\rokid-rebrand")
APK = ROOT / "apktool_out"
BRAND = ROOT / "brand"
APP_NAME = "水利安全AI眼镜"

REPORT = []


def edit_strings_xml(path: Path, rules, label):
    if not path.exists():
        return
    text = path.read_text(encoding="utf-8")
    orig = text
    n = 0
    for old, new in rules:
        if old in text:
            n += text.count(old)
            text = text.replace(old, new)
    if text != orig:
        path.write_text(text, encoding="utf-8")
    if n:
        REPORT.append(f"[{label}] {path.name}: {n} 处")


def main():
    zh = APK / "res" / "values-zh" / "strings.xml"
    default = APK / "res" / "values" / "strings.xml"
    ar = APK / "res" / "values-ar" / "strings.xml"

    # ── 中文串（顺序敏感）────────────────────────────
    zh_rules = [
        # 需求3: 主页 tab → 排查（先做，防碰撞）
        ('<string name="home_tab_glasses">主页</string>',
         '<string name="home_tab_glasses">排查</string>'),
        ('<string name="home_title">主页</string>',
         '<string name="home_title">排查</string>'),
        # 需求4: 社区 tab → 主页
        ('<string name="Community_tab">社区</string>',
         '<string name="Community_tab">主页</string>'),
        # 需求1: 应用名
        ('<string name="app_name_rokid">Rokid AI</string>',
         f'<string name="app_name_rokid">{APP_NAME}</string>'),
        ('<string name="app_name">Rokid AI</string>',
         f'<string name="app_name">{APP_NAME}</string>'),
        ('<string name="app_name_overseas">Hi Rokid</string>',
         f'<string name="app_name_overseas">{APP_NAME}</string>'),
        # 需求2: 唤醒词 乐奇→小禹（含语音示例）
        ('乐奇', '小禹'),
        # 需求1: 品牌串清扫（display 语境；功能标识不动）
        ('Rokid AI App', f'{APP_NAME} App'),
        ('Rokid App', f'{APP_NAME} App'),
        ('Rokid Glasses App', f'{APP_NAME} App'),
        ('Rokid AI 助手', '小禹 AI 助手'),
        ('Rokid 快捷操作', 'AI眼镜 快捷操作'),
        ('仅支持Rokid Glasses', '仅支持AI眼镜'),
        ('Rokid Glasses', 'AI眼镜'),
        ('Rokid ai glasses眼镜，不带显示款', 'AI眼镜，不带显示款'),
        ('Rokid glasses2眼镜，带显示款', 'AI眼镜，带显示款'),
        ('Rokid glasses眼镜，带显示款', 'AI眼镜，带显示款'),
        ('Bolon Glasses-Rokid Glasses-', 'AI眼镜-'),
        ('Rokid 应用', f'{APP_NAME} 应用'),
        ('若琪', '小禹'),
    ]
    edit_strings_xml(zh, zh_rules, "zh")
    edit_strings_xml(ar, [('乐奇', '小禹'), ('若琪', '小禹')], "ar")
    # 默认(英)串里的品牌名（display 语境）
    en_rules = [
        ('<string name="app_name">Account</string>',
         f'<string name="app_name">{APP_NAME}</string>'),
    ]
    edit_strings_xml(default, en_rules, "default")

    # ── 图标（单密度 ic_app.png 直接覆写）────────────
    for icon in ["ic_app.png"]:
        src, dst = BRAND / "LOGO.png", APK / "res" / "drawable" / icon
        if src.exists() and dst.exists():
            shutil.copyfile(src, dst)
            REPORT.append(f"[icon] {icon} ← LOGO.png (200x200)")

    # ── Splash 字标矢量 → 我们的 logo 位图引用 ────────
    splash = APK / "res" / "drawable" / "splash_logo.xml"
    if splash.exists():
        splash.write_text(
            '<?xml version="1.0" encoding="utf-8"?>\n'
            '<bitmap xmlns:android="http://schemas.android.com/apk/res/android"\n'
            '    android:src="@drawable/ic_app"\n'
            '    android:gravity="center" />\n', encoding="utf-8")
        REPORT.append("[splash] splash_logo.xml → ic_app 位图引用")

    # ── Rokid.txt 营销文 → 水利安全AI眼镜简介 ─────────
    for txt in ["Rokid.txt", "Rokid_en.txt"]:
        p = APK / "assets" / txt
        if p.exists():
            p.write_text(
                f"{APP_NAME}：为水利工程安全检查打造的专属AI眼镜应用。\n"
                "定量测距分析 · 视觉量化判定 · 六项机制智能落地工具。\n"
                "配套 V3.0 官网：http://47.120.43.20:8090/\n", encoding="utf-8")
            REPORT.append(f"[brand] assets/{txt} 重写")

    # ── jsbridge 乐奇 → 小禹 ─────────────────────────
    js = APK / "assets" / "jsbridge" / "main.js"
    if js.exists():
        t = js.read_text(encoding="utf-8")
        if "乐奇" in t:
            js.write_text(t.replace("乐奇", "小禹"), encoding="utf-8")
            REPORT.append("[jsbridge] main.js 乐奇→小禹")

    print("\n".join(REPORT) if REPORT else "no changes (already applied?)")
    # 残留审计
    left = []
    for loc in [zh, ar]:
        if loc.exists():
            t = loc.read_text(encoding="utf-8")
            for w in ["乐奇", "若琪"]:
                if w in t:
                    left.append(f"{loc.name}: {w}×{t.count(w)}")
    if left:
        print("[AUDIT-LEFT]", "; ".join(left))


if __name__ == "__main__":
    main()
