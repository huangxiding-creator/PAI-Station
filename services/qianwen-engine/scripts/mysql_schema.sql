-- 总包千问引擎 · CloudBase MySQL 库表（v0.8.0 云托管迁移）
-- 与 qianwen_engine/store.py 运行时自举 DDL（_SCHEMA 的 mysql 变体）保持同步：
-- 引擎首连会 CREATE TABLE IF NOT EXISTS 自举，本文件供运维预建/巡检/重建使用。
-- criticisms 在引擎里是运行时惰性建表（save_criticism 首用即建），此处一并提供；
-- pay_log v0.8.0 起已转正进 _SCHEMA（导出收费对账流水，带 openid 索引）。
-- 约定：utf8mb4；DATETIME 读取由引擎按文本口径解码（与 sqlite 字符串一致）；
-- answers.rowid 为真实自增列，对齐 sqlite 隐式 rowid 的插入序（history 排序语义）。

CREATE TABLE IF NOT EXISTS users (
    openid VARCHAR(64) PRIMARY KEY,
    unionid VARCHAR(128) DEFAULT '',
    nickname VARCHAR(255) DEFAULT '',
    free_used INT DEFAULT 0,
    bonus_earned INT DEFAULT 0,
    bonus_used INT DEFAULT 0,
    quota_day VARCHAR(10) DEFAULT '',
    like_day VARCHAR(10) DEFAULT '',
    like_granted INT DEFAULT 0,
    opt_day VARCHAR(10) DEFAULT '',
    opt_used INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS answers (
    id VARCHAR(32) PRIMARY KEY,
    openid VARCHAR(64) NOT NULL,
    question TEXT NOT NULL,
    answer_full MEDIUMTEXT,
    citations MEDIUMTEXT,
    via VARCHAR(16) DEFAULT 'kb',
    status VARCHAR(16) DEFAULT 'ready',
    unlocked INT DEFAULT 0,
    liked INT DEFAULT 0,
    criticized INT DEFAULT 0,
    elapsed_sec DOUBLE DEFAULT 0,
    views INT DEFAULT 0,
    shares INT DEFAULT 0,
    error_text TEXT,
    out_trade_no VARCHAR(64) DEFAULT '',
    paid INT DEFAULT 0,
    tldr TEXT,
    related TEXT,
    shared INT DEFAULT 0,
    export_paid INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    rowid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    UNIQUE KEY uk_answers_rowid (rowid),
    KEY idx_answers_openid (openid, created_at DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS mp_session (
    openid VARCHAR(64) PRIMARY KEY,
    session_key VARCHAR(255) NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS rewards (
    id INT PRIMARY KEY AUTO_INCREMENT,
    openid VARCHAR(64) NOT NULL,
    aid VARCHAR(32) NOT NULL,
    action VARCHAR(16) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_rewards_openid_aid_action (openid, aid, action)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS pot_items (
    aid VARCHAR(32) PRIMARY KEY,
    sort INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS followups (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aid VARCHAR(32) NOT NULL,
    openid VARCHAR(64) NOT NULL,
    question TEXT NOT NULL,
    answer MEDIUMTEXT,
    status VARCHAR(16) NOT NULL DEFAULT 'pending',   -- pending|ready|error
    error_text MEDIUMTEXT,
    created_at DOUBLE,
    KEY idx_followups_aid_openid (aid, openid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS posters (
    aid VARCHAR(32) PRIMARY KEY,
    png LONGBLOB,
    created_at DOUBLE,
    env VARCHAR(16) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS pot_reports (
    aid VARCHAR(32) NOT NULL,
    openid VARCHAR(64) NOT NULL,
    reason TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (aid, openid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS citations_ft (
    aid VARCHAR(32) NOT NULL,
    n INT NOT NULL,
    text MEDIUMTEXT NOT NULL,
    created_at DOUBLE,
    PRIMARY KEY (aid, n)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 运行时惰性建表（引擎侧同定义；此处预建便于一次性灌数/巡检）；
-- pay_log 已于 v0.8.0 转正进 _SCHEMA（下列定义与 store.py 一致）

CREATE TABLE IF NOT EXISTS pay_log (
    aid VARCHAR(32) NOT NULL,
    openid VARCHAR(64) NOT NULL,
    out_trade_no VARCHAR(64) DEFAULT '',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    KEY idx_paylog_openid (openid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- v0.8.0 支付订单表（审计 CRITICAL-2/HIGH-3/MEDIUM-4）：签名即落单，
-- 回调凭单+微信查单核验；批量单 aid_list=签名时刻未解锁快照。
CREATE TABLE IF NOT EXISTS pay_order (
    out_trade_no VARCHAR(64) NOT NULL PRIMARY KEY,
    openid VARCHAR(64) NOT NULL,
    kind VARCHAR(8) NOT NULL,
    aid VARCHAR(32) DEFAULT '',
    aid_list TEXT,
    buy_quantity INT NOT NULL,
    total_fen INT NOT NULL,
    status VARCHAR(8) DEFAULT 'signed',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    paid_at DATETIME NULL,
    rowid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    UNIQUE KEY uk_payorder_rowid (rowid),
    KEY idx_payorder_openid (openid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS criticisms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aid TEXT,
    openid TEXT,
    text TEXT,
    score INT,
    refund_tier TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
