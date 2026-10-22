# 视频 brief — 《发现隐患、预判风险》水利安全AI眼镜产品宣传片

- 状态：正式片已完成并通过 check_delivery（errors 0），50.0s / 1080×1920 / 30fps / -16.0 LUFS。
- 用户令（2026-10-22）：基于水利安全AI眼镜宣传官网和观澜后台页面做产品宣传片，题「发现隐患、预判风险」，发布到总包说视频号，封面须世界级审美。
- 风格选定：repo（产品自身设计语言）；方向 C「一线视角→驾驶舱」见 DIRECTION.md。
- 真实组件：官网真实页 iframe（public/site/index.html，仅注入动画冻结样式）；观澜 11 屏 + ai/trend 实拍帧（material/console/，2026-10-22 线上登录实拍）；现场照片/智能体界面为产品资料原件。
- 发布渠道：微信视频号「总包说」，slug=leqi_v1_am（videos/leqi_v1_am.mp4 + .json + .spec.json）。
- 封面：视频号取首帧 → poster=开场完成态（public/poster.png，含标尺刻度母题）；另出 3:4/16:9 双封面（covers/）。
- 配乐：代码合成（score_gen.py，92BPM D 小调，venv numpy/scipy/soundfile 清华镜像）；音效 skill 内置 11 WAV，±σ 落定 ding-dong 为全片母题音。
- 证据：evidence/（stills、contact-sheet、transition strips、audio-mix.json、component-imports.json）。
- 发布实录：首跑登录态过期 → video_relogin 有头扫码（企微已通知）→ 续发。
