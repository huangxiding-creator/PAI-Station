@echo off
cd /d E:\AI-Station
py -3 -m pytest -q kb_factory\harvest_engine\tests\test_book118_images.py -s -k paid > E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_t23_live_paid_run3.log 2>&1
