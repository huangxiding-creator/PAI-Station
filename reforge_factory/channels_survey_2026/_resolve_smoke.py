# -*- coding: utf-8 -*-
import sys,importlib.util
sys.stdout.reconfigure(encoding='utf-8')
spec=importlib.util.spec_from_file_location('cm','E:/AI-Station/reforge_factory/completeness/channel_matrix.py')
cm=importlib.util.module_from_spec(spec); spec.loader.exec_module(cm)
for lbl in ['nasa_images','noaa_nws','mojeek.com','tiangong.cn','so.com','4get.ca','bing.com','google.com','dangdang','metaso','ecb_sdw','hn_algolia_api']:
    r=cm.resolve_engine(lbl)
    print(lbl,'->',sorted(r.get('channels',[]))[:4],(r.get('notes') or '')[:40])
print('CHANNEL_ALIASES keys after merge:',len(cm.CHANNEL_ALIASES))
