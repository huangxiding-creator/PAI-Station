import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumOptions
co = ChromiumOptions()
print('default address:', repr(co.address))
co.set_address('127.0.0.1:9334')
print('after set:', repr(co.address))
import DrissionPage
print('version:', DrissionPage.__version__)
