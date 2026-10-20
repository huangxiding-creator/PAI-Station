@echo off
chcp 65001 >nul
cd /d E:\AI-Station
set PY=C:\Users\91216\AppData\Local\Programs\Python\Python313F\python.exe
set LOG=E:\AI-Station\ammo_pool\EPC-SCHED\completeness\legs_round1.log

echo [%date% %time%] EPC-SCHED Round1 legs start > %LOG%

echo === leg1 anysearch === >> %LOG%
%PY% -X utf8 reforge_factory\harvest_anysearch.py --campaign EPC-SCHED >> %LOG% 2>&1

echo === leg2 gap === >> %LOG%
%PY% -X utf8 reforge_factory\harvest_gap.py --campaign EPC-SCHED >> %LOG% 2>&1

echo === leg3 academic === >> %LOG%
%PY% -X utf8 reforge_factory\harvest_academic.py --campaign EPC-SCHED >> %LOG% 2>&1

echo === leg4 zh_search_pro === >> %LOG%
%PY% -X utf8 reforge_factory\harvest_zh_search_pro.py --campaign EPC-SCHED >> %LOG% 2>&1

echo === leg5 govlist === >> %LOG%
%PY% -X utf8 reforge_factory\harvest_govlist.py --campaign EPC-SCHED >> %LOG% 2>&1

echo === leg6 video === >> %LOG%
%PY% -X utf8 reforge_factory\harvest_video.py --campaign EPC-SCHED >> %LOG% 2>&1

echo [%date% %time%] Round1 done >> %LOG%
