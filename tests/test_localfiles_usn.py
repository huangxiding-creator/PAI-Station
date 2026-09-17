"""USN readjournal CSV 解析：真机夹具（E: 盘 2026-09-17 实采）+ 合成场景。"""
import json
from pathlib import Path

from paistation.sense.localfiles import usn

FIXTURE = Path(__file__).parent / "fixtures" / "usn_sample.json"

META = """USN 日志 ID    : 0x01d79edaa5ad830a
第一个 USN     : 5846859776
下一个 USN     : 5888153560
开始 USN       : 0
最低主要版本   : Supported=2, requested=2
最高主要版本   : Supported=4, requested=4

Usn,文件名,文件名长度,原因编号,原因,时间戳,文件属性编号,文件属性,文件 ID,父文件 ID,源信息号,源信息,安全 ID,主要版本,次要版本,记录长度,盘区数,剩余盘区,盘区,偏移量,长度
"""


def _real_records():
    d = json.loads(FIXTURE.read_text(encoding="utf-8"))
    lines = d["records"] + d["rename_samples"]
    lines.sort(key=lambda ln: int(ln.split(",", 1)[0]))  # 拼接后按 Usn 复原序
    return META + "\n".join(lines)


def test_parse_real_csv_fixture():
    recs = usn.parse_csv(_real_records())
    assert len(recs) == 26  # 20 常规 + 6 重命名实线全解析
    assert all(isinstance(r.file_id, int) for r in recs)
    assert recs == sorted(recs, key=lambda r: r.usn)  # 文件序保持


def test_parse_csv_since_cursor_filters_early():
    text = _real_records()
    all_recs = usn.parse_csv(text)
    mid = all_recs[len(all_recs) // 2].usn
    tail = usn.parse_csv(text, since_usn=mid)
    assert tail and all(r.usn > mid for r in tail)
    assert len(tail) < len(all_recs)


def test_rename_pair_synthesized_from_real_lines():
    """真机 rename 对：同文件 ID 连接 tmp→正式名（conductor.lock）。"""
    moves, news = usn.synthesize_moves(usn.parse_csv(_real_records()))
    pair = [m for m in moves if m.new_name == "conductor.lock"
            and m.old_name.endswith(".tmp")]
    assert pair, "真机 rename 对未配出"
    m = pair[0]
    assert not m.cross_dir  # 同父目录改名
    assert m.file_id == 0x1400000009B539


def test_chained_renames_link():
    """a→b→c 链式改名自然配对成两跳。"""
    base = ('{usn},"{name}",{nlen},0x{reason:x},"x","2026/9/17 4:37:29",'
            '0x20,"存档",0000000000000000001400000009b539,'
            '0000000000000000002800000009b465,0x0,"*无*",0,3,0,104')
    text = META + "\n".join([
        base.format(usn=100, name="a.tmp", nlen=7, reason=usn.REASON_RENAME_OLD_NAME),
        base.format(usn=104, name="b.mid", nlen=7, reason=usn.REASON_RENAME_NEW_NAME),
        base.format(usn=108, name="c.final", nlen=8,
                    reason=usn.REASON_RENAME_NEW_NAME),
    ])
    # 构造第二条 OLD 缺失的链：b→c 只有 NEW（a→b 有对）
    moves, news = usn.synthesize_moves(usn.parse_csv(text))
    assert len(moves) == 1 and moves[0].old_name == "a.tmp" \
        and moves[0].new_name == "b.mid"
    assert len(news) == 1 and news[0].name == "c.final"


def test_cross_dir_move_detected():
    base = ('{usn},"{name}",6,0x{reason:x},"x","2026/9/17 4:37:29",'
            '0x20,"存档",{fid},{pid},0x0,"*无*",0,3,0,104')
    text = META + "\n".join([
        base.format(usn=10, name="mv.doc", reason=usn.REASON_RENAME_OLD_NAME,
                    fid=0xAA, pid=0x100),
        base.format(usn=14, name="mv.doc", reason=usn.REASON_RENAME_NEW_NAME,
                    fid=0xAA, pid=0x200),
    ])
    moves, _ = usn.synthesize_moves(usn.parse_csv(text))
    assert len(moves) == 1 and moves[0].cross_dir  # 父 ID 变=跨目录移动


def test_classify_noise_dropped():
    r = usn.UsnRecord(usn=1, name="f", reasons=usn.REASON_CLOSE,
                      file_id=1, parent_id=2, ts="")
    assert usn.classify(r) is None  # 纯 CLOSE 噪音
    r2 = usn.UsnRecord(usn=2, name="f", reasons=usn.REASON_CLOSE
                       | usn.REASON_BASIC_INFO_CHANGE, file_id=1,
                       parent_id=2, ts="")
    assert usn.classify(r2) is None  # CLOSE+基本信息仍噪音
    r3 = usn.UsnRecord(usn=3, name="f", reasons=usn.REASON_FILE_DELETE
                       | usn.REASON_CLOSE, file_id=1, parent_id=2, ts="")
    assert usn.classify(r3) == "deleted"


def test_meta_and_gap_check():
    meta = usn.parse_meta(META)
    assert meta == {"first_usn": 5846859776, "next_usn": 5888153560}
    assert usn.gap_check(5846859775, meta)   # 游标早于最早记录=回卷
    assert not usn.gap_check(5846859776, meta)
    assert not usn.gap_check(0, {"first_usn": None})  # 元信息缺席不误报


# ---------- 记录 → 队列事件（父目录 FRN 反解，零库存依赖） ----------
# chr(92)=反斜杠：heredoc/传输层对反斜杠+数字/字母序列会吞字，禁直写

BS = chr(92)
IN_DIR = "E:" + BS + "AI-Station" + BS + "tmp"
D_DIR = "D:" + BS + "20 白龟湖项目" + BS + "docs"
DIR_FRN = {0x2800000009b465: IN_DIR, 0x100: D_DIR}
DOM = ("E:" + BS + "AI-Station" + BS,
       "D:" + BS + "20 白龟湖项目" + BS)


def _rec(usn_, name, reasons, fid, pid):
    return usn.UsnRecord(usn=usn_, name=name, reasons=reasons,
                         file_id=fid, parent_id=pid, ts="t")


def test_resolve_events_rename_pair_to_queue_event():
    recs = [
        _rec(10, "a.tmp", usn.REASON_RENAME_OLD_NAME, 0x14, 0x2800000009b465),
        _rec(14, "a.md", usn.REASON_RENAME_NEW_NAME, 0x14, 0x2800000009b465),
    ]
    evs = usn.resolve_events(recs, DIR_FRN, DOM)
    assert evs == [{"path": IN_DIR + BS + "a.tmp",
                    "op": "renamed", "dest": IN_DIR + BS + "a.md"}]


def test_resolve_events_cross_dir_move():
    recs = [
        _rec(10, "mv.pdf", usn.REASON_RENAME_OLD_NAME, 0x14,
             0x2800000009b465),
        _rec(14, "mv.pdf", usn.REASON_RENAME_NEW_NAME, 0x14, 0x100),
    ]
    evs = usn.resolve_events(recs, DIR_FRN, DOM)
    assert evs and evs[0]["dest"] == D_DIR + BS + "mv.pdf"


def test_resolve_events_domain_filter_and_dedup():
    recs = [
        _rec(1, "in.md", usn.REASON_FILE_CREATE | usn.REASON_CLOSE,
             0x1, 0x2800000009b465),
        _rec(2, "in.md", usn.REASON_FILE_CREATE | usn.REASON_CLOSE,
             0x1, 0x2800000009b465),  # 重复同类事件去重
        _rec(3, "out.md", usn.REASON_FILE_CREATE, 0x2, 0x999),  # 域外父目录
        _rec(4, "noise.md", usn.REASON_CLOSE, 0x3, 0x2800000009b465),
        _rec(5, "del.md", usn.REASON_FILE_DELETE, 0x4, 0x100),
    ]
    evs = usn.resolve_events(recs, DIR_FRN, DOM)
    ops = {(e["path"], e["op"]) for e in evs}
    assert (IN_DIR + BS + "in.md", "created") in ops
    assert (D_DIR + BS + "del.md", "deleted") in ops
    assert len(evs) == 2  # 域外丢/噪音丢/重复去重


def test_resolve_events_rename_new_without_old_is_created():
    recs = [_rec(10, "lonely.md", usn.REASON_RENAME_NEW_NAME,
                 0x14, 0x2800000009b465)]
    evs = usn.resolve_events(recs, DIR_FRN, DOM)
    assert evs == [{"path": IN_DIR + BS + "lonely.md", "op": "created"}]


def test_build_dir_frn_map_real(tmp_path):
    (tmp_path / "sub1" / "deep").mkdir(parents=True)
    (tmp_path / "sub2").mkdir()
    m = usn.build_dir_frn_map([str(tmp_path)])
    paths = set(m.values())
    assert str(tmp_path) in paths
    assert str(tmp_path / "sub1") in paths
    assert str(tmp_path / "sub1" / "deep") in paths
    assert str(tmp_path / "sub2") in paths
    assert all(isinstance(k, int) and k > 0 for k in m)
