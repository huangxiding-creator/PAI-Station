"""M2.6 账号安全四件套：节流+冷却+日限额+熔断（账号安全第一红线）。"""
from paistation.sense.cloud.rate import RateLimiter


class FakeClock:
    def __init__(self, now=1000.0):
        self.now = now

    def __call__(self) -> float:
        return self.now

    def advance(self, s: float) -> None:
        self.now += s


def _limiter(clock, **kw):
    d = dict(min_interval_s=2.0, daily_cap=3, cooldown_s=300.0,
             breaker_threshold=3, breaker_reset_s=1800.0)
    d.update(kw)
    return RateLimiter("测试连接器", clock=clock, **d)


def test_throttle_min_interval():
    clk = FakeClock()
    rl = _limiter(clk)
    assert rl.try_acquire() is True      # 首次放行
    assert rl.try_acquire() is False     # 2s 内节流拒绝
    clk.advance(2.1)
    assert rl.try_acquire() is True


def test_daily_cap_blocks_until_next_day():
    clk = FakeClock()
    rl = _limiter(clk, min_interval_s=0, daily_cap=2)
    assert rl.try_acquire() and rl.try_acquire()
    clk.advance(10)
    assert rl.try_acquire() is False     # 当日限额已满
    clk.advance(86400)                   # 跨天重置
    assert rl.try_acquire() is True


def test_cooldown_after_failure():
    clk = FakeClock()
    rl = _limiter(clk)
    assert rl.try_acquire() is True
    rl.report(False)
    clk.advance(10)
    assert rl.try_acquire() is False     # 冷却中（300s）
    clk.advance(300)
    assert rl.try_acquire() is True      # 冷却期满放行


def test_breaker_opens_after_consecutive_failures():
    clk = FakeClock()
    rl = _limiter(clk)
    for _ in range(3):
        rl.report(False)
    clk.advance(400)                     # 冷却已过（300s）
    assert rl.try_acquire() is False     # 熔断仍开（1800s 窗口）
    clk.advance(1800)
    assert rl.try_acquire() is True      # 熔断窗口过，放一次探针


def test_success_resets_failure_streak():
    clk = FakeClock()
    rl = _limiter(clk)
    rl.report(False)
    rl.report(False)
    rl.report(True)                      # 成功清零连败（防熔断误开）
    clk.advance(301)                     # 单次失败的冷却期满
    assert rl.try_acquire() is True      # 若连败未被清零将在此前熔断


def test_denied_acquire_consumes_no_quota():
    clk = FakeClock()
    rl = _limiter(clk, min_interval_s=0, daily_cap=1)
    assert rl.try_acquire() is True
    rl.report(False)
    clk.advance(2)                       # 节流过了但冷却没过
    assert rl.try_acquire() is False
    clk.advance(86400)                   # 跨天（冷却与限额都重置）
    assert rl.try_acquire() is True      # 限额没被拒绝消耗掉
