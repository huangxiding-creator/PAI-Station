# -*- coding: utf-8 -*-
"""wenshu_bt_extract 单测——夹具造 mini 年度 zip，覆盖分类/断点/封顶/原子写。"""
import csv
import io
import json
import sys
import zipfile
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import wenshu_bt_extract as wbe  # noqa: E402

HEADER = ["原始链接", "案号", "案件名称", "法院", "所属地区", "案件类型", "案件类型编码",
          "来源", "审理程序", "裁判日期", "公开日期", "当事人", "案由", "法律依据", "全文"]


def _row(name, parties, cause, full):
    return ["http://x", "(2013)川01民初1号", name, "成都市中级人民法院", "四川", "民事",
            "1", "裁判文书网", "一审", "2013-01-01", "2013-02-01", parties, cause, "", full]


def _make_zip(path, rows):
    buf = io.StringIO()
    w = csv.writer(buf, lineterminator="\n")
    w.writerow(HEADER)
    for r in rows:
        w.writerow(r)
    data = "﻿".encode() + buf.getvalue().encode("utf-8")
    with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as z:
        z.writestr("2013年裁判文书数据_马克数据网/2013年01月裁判文书数据.csv", data)
        z.writestr("2013年裁判文书数据_马克数据网/数据来源.html", "<html></html>")


TERMS = (["四川电力设计咨询", "四川院"], ["中国电建"], [])


def test_classify_t1_company():
    row = _row("建设工程施工合同纠纷", "四川电力设计咨询有限责任公司", "合同纠纷", "全文提及四川电力设计咨询")
    assert wbe.classify(row, TERMS, {}) == "T1"


def test_classify_t2_peer():
    row = _row("建设工程施工合同纠纷", "中国电建集团某某工程有限公司", "合同纠纷", "施工合同正文")
    assert wbe.classify(row, TERMS, {}) == "T2"


def test_classify_t2_fulltext_mention_rejected():
    # 1006 质检实锤：离婚案正文偶然提及「电力设计院」≠ 同业对标资料（弹药门语义）
    row = _row("离婚纠纷", "张某与李某", "离婚纠纷", "正文提及电力设计院一次")
    assert wbe.classify(row, TERMS, {}) is None


def test_classify_t3_epc_combo():
    row = _row("建设工程施工合同纠纷", "某公司", "合同纠纷", "工程总承包范围含光伏电站")
    assert wbe.classify(row, TERMS, {}) == "T3"


def test_classify_t3_capped():
    caps = {"t3_used": wbe.DEFAULT_T3_CAP}
    row = _row("x", "y", "z", "EPC 总承包合同")
    assert wbe.classify(row, TERMS, caps) is None


def test_classify_reject_generic():
    row = _row("民间借贷纠纷", "张某", "借贷", "借款未还")
    assert wbe.classify(row, TERMS, {}) is None


def test_classify_epc_without_energy_rejected():
    row = _row("x", "y", "z", "工程总承包房建项目")  # A 命中但 B 未命中
    assert wbe.classify(row, TERMS, {}) is None


def test_process_csv_writes_matches_and_manifest(tmp_path):
    zp = tmp_path / "2013年裁判文书数据.zip"
    _make_zip(str(zp), [
        _row("借贷", "张三", "借贷", "无关文本"),
        _row("合同", "四川电力设计咨询有限责任公司", "施工", "正文"),
        _row("光伏", "某公司", "合同", "总承包含风电场"),
    ])
    out = tmp_path / "out"
    st = wbe.process_csv(str(zp), "2013年裁判文书数据_马克数据网/2013年01月裁判文书数据.csv",
                         TERMS, str(out), caps={"t3_used": 0}, full_keep_t1=True)
    assert st["scanned"] == 3
    assert st["t1"] == 1 and st["t3"] == 0
    jf = out / "2013_01.jsonl"
    assert jf.exists()
    rec = json.loads(jf.read_text(encoding="utf-8").splitlines()[0])
    assert rec["tier"] == "T1"
    assert rec["case"]["案号"] == "(2013)川01民初1号"
    assert rec["meta"]["zip"] == "2013年裁判文书数据.zip"
    man = (out / "manifest.jsonl").read_text(encoding="utf-8").strip().splitlines()
    assert json.loads(man[-1])["status"] == "done"


def test_process_csv_atomic_and_resumable(tmp_path):
    zp = tmp_path / "2013年裁判文书数据.zip"
    _make_zip(str(zp), [_row("借贷", "张三", "借贷", "无关")])
    out = tmp_path / "out"
    st = wbe.process_csv(str(zp), "2013年裁判文书数据_马克数据网/2013年01月裁判文书数据.csv",
                         TERMS, str(out), caps={"t3_used": 0}, full_keep_t1=True)
    assert st["scanned"] == 1
    assert not (out / "2013_01.jsonl.part").exists()  # part 已 rename
    done = wbe.load_done(str(out))
    assert "2013年裁判文书数据.zip::2013年裁判文书数据_马克数据网/2013年01月裁判文书数据.csv" in done


def test_t2_fulltext_truncated(tmp_path):
    zp = tmp_path / "2013年裁判文书数据.zip"
    _make_zip(str(zp), [_row("合同", "中国电建某某公司", "施工", "正文" + "长" * 50000)])
    out = tmp_path / "out"
    wbe.process_csv(str(zp), "2013年裁判文书数据_马克数据网/2013年01月裁判文书数据.csv",
                    TERMS, str(out), caps={"t3_used": 0}, full_keep_t1=True)
    rec = json.loads((out / "2013_01.jsonl").read_text(encoding="utf-8").splitlines()[0])
    assert len(rec["全文"]) <= 30000 + 100  # 截断容差（截断后可能再拼 hit 上下文）


def test_year_filter():
    assert wbe.year_of("2019年裁判文书数据.zip") == 2019
    assert wbe.year_of("数据说明.txt") is None
