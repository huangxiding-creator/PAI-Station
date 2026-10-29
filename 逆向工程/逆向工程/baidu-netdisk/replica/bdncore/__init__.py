# -*- coding: utf-8 -*-
"""bdncore：百度网盘客户端 8.2.5 协议核心库（只读 W3 + 写/传输 W4 + 路由/体检/镜像/分享 W5）。

- 凭据：Cookie BDUSS+STOKEN（JSON 字段直读，含 '-' 无正则），输出全掩码
- 通道：pan.baidu.com（跨域 d.pcs/pcs 绝对 URL 已支持），UA=原生腿 netdisk;8.2.5
- 防护：3 次指数退避重试、控制面节流(并发≤2/间隔≥1.5s)、errno 熔断器、翻页护栏
- 写面（W4）：mkdir/filemanager 四合一/上传三段(precreate+superfile2+create)/
  metas?dlink=1/filediff 全参；传输引擎数据面并发≤8、分片≤4MB（CT11 红线）、断点续传
- W5：router 读写路由表+读面 api→xpan 降级；doctor 八针复验/协议漂移检测；
  mirror 增量镜像（远端只增不删）；share pset/cancel/surlinfo + 转存链三步
"""
from .errors import (BdnApiError, BdnAuthError, BdnCircuitOpen, BdnError,
                     BdnNetworkError, CIRCUIT_ERRNOS, ERRNO_MAP, describe)
from .session import BdnSession, Throttle, mask
from .api import BdnApi
from .transfer import (BdnTransferError, DownloadEngine, UploadEngine,
                       block_md5s, block_ranges, choose_block_size, md5_file,
                       slice_md5_file)
from .router import (READ_CHAINS, WRITE_FAMILY, BdpanSubprocessChannel,
                     RoutedApi, should_fallback)
from .doctor import run_doctor
from .mirror import MirrorEngine

__version__ = "0.3.0"

__all__ = [
    "BdnApiError", "BdnAuthError", "BdnCircuitOpen", "BdnError",
    "BdnNetworkError", "CIRCUIT_ERRNOS", "ERRNO_MAP", "describe",
    "BdnSession", "Throttle", "mask", "BdnApi",
    "BdnTransferError", "UploadEngine", "DownloadEngine",
    "block_md5s", "block_ranges", "choose_block_size", "md5_file",
    "slice_md5_file",
    "READ_CHAINS", "WRITE_FAMILY", "BdpanSubprocessChannel", "RoutedApi",
    "should_fallback", "run_doctor", "MirrorEngine", "__version__",
]
