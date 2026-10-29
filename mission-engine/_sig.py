# -*- coding: utf-8 -*-
import inspect
from signals.bus import SignalBus
print("pull:", inspect.signature(SignalBus.pull))
src = inspect.getsource(SignalBus.pull)
print(src[:600])
