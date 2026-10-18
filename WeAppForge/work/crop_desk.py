# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from PIL import Image

img = Image.open('E:/AI-Station/WeAppForge/work/desk_now.png')
w, h = img.size
print('desk size:', w, h)
# 右显示器 ≈ 后半段
right = img.crop((w // 2, 0, w, h))
right = right.resize((right.width * 2, right.height * 2), Image.LANCZOS)
right.save('E:/AI-Station/WeAppForge/work/desk_right_2x.png')
print('saved desk_right_2x.png', right.size)
