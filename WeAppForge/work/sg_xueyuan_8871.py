# -*- coding: utf-8 -*-
"""安全组 8871 放行工具（用户 2026-09-28 明确授权自行开闸；RL #34）。
用法:
  python sg_xueyuan_8871.py check   # 查实例安全组与 8871 现有规则
  python sg_xueyuan_8871.py open    # 放行 8871/tcp 0.0.0.0/0（幂等：已存在则跳过）
  python sg_xueyuan_8871.py close   # 撤销 8871 规则（回退用）
红线: 只动 8871 端口规则；不碰其它端口/其它安全组。
"""
import json
import os
import subprocess
import sys

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
PORT = "8871/8871"
DESC = "xueyuan-engine"
NO_WINDOW = 0x08000000


def cli(*args, timeout=60):
    env = {k: v for k, v in os.environ.items()
           if k.upper() not in ("HTTP_PROXY", "HTTPS_PROXY", "ALL_PROXY")}
    p = subprocess.run(["aliyun", "ecs", *args], capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=timeout,
                       env=env, creationflags=NO_WINDOW)
    if p.returncode != 0:
        raise RuntimeError(f"aliyun {args[0]} 失败: {(p.stderr or '')[:300]}")
    return p.stdout


def sg_id():
    out = cli("DescribeInstanceAttribute", "--RegionId", REGION,
              "--InstanceId", INSTANCE)
    sgs = json.loads(out).get("SecurityGroupIds", {}).get("SecurityGroupId", [])
    if not sgs:
        raise RuntimeError("实例无安全组")
    return sgs[0]


def rules(sid):
    out = cli("DescribeSecurityGroupAttribute", "--RegionId", REGION,
              "--SecurityGroupId", sid, "--Direction", "ingress")
    return json.loads(out).get("Permissions", {}).get("Permission", [])


def find(sid):
    return [r for r in rules(sid)
            if r.get("PortRange") == PORT and r.get("IpProtocol") == "tcp"
            and r.get("SourceCidrIp") == "0.0.0.0/0"]


def main():
    action = sys.argv[1] if len(sys.argv) > 1 else "check"
    sid = sg_id()
    print(f"安全组: {sid}")
    if action == "check":
        hit = find(sid)
        print(f"8871/tcp 0.0.0.0/0 规则: {'已存在 ' + json.dumps(hit, ensure_ascii=False) if hit else '不存在'}")
        return 0
    if action == "open":
        if find(sid):
            print("已存在，幂等跳过")
            return 0
        cli("AuthorizeSecurityGroup", "--RegionId", REGION, "--SecurityGroupId", sid,
            "--IpProtocol", "tcp", "--PortRange", PORT, "--SourceCidrIp", "0.0.0.0/0",
            "--Description", DESC)
        import time
        for _ in range(5):  # 规则传播延迟：开闸后立即读可能扑空（2026-09-28 实测），轮询 ≤20s
            time.sleep(4)
            if find(sid):
                print(f"已放行并复核: {json.dumps(find(sid)[0], ensure_ascii=False)}")
                return 0
        raise RuntimeError("放行调用成功但 20s 内复核未见规则（可能是更长传播延迟，稍后 check 确认）")
    if action == "close":
        for r in find(sid):
            cli("RevokeSecurityGroup", "--RegionId", REGION, "--SecurityGroupId", sid,
                "--IpProtocol", "tcp", "--PortRange", PORT,
                "--SourceCidrIp", "0.0.0.0/0")
        print("已撤销 8871 公网规则（本机/ufw 不受影响）")
        return 0
    print(__doc__)
    return 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as e:  # noqa: BLE001
        print(f"FAIL: {e}", file=sys.stderr)
        sys.exit(2)
