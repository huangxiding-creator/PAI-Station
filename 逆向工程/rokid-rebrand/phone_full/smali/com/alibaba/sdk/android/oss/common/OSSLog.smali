.class public Lcom/alibaba/sdk/android/oss/common/OSSLog;
.super Ljava/lang/Object;
.source "OSSLog.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "OSS-Android-SDK"

.field private static enableLog:Z

.field private static logPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

.field private static nopLogPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 11
    const/4 v0, 0x0

    sput-boolean v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->enableLog:Z

    .line 13
    new-instance v0, Lcom/alibaba/sdk/android/oss/common/DefaultLogPrinter;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/oss/common/DefaultLogPrinter;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    .line 15
    new-instance v0, Lcom/alibaba/sdk/android/oss/common/OSSLog$1;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog$1;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->nopLogPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static disableLog()V
    .locals 1

    .line 32
    const/4 v0, 0x0

    sput-boolean v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->enableLog:Z

    .line 33
    return-void
.end method

.method public static enableLog()V
    .locals 1

    .line 25
    const/4 v0, 0x1

    sput-boolean v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->enableLog:Z

    .line 26
    return-void
.end method

.method public static getLogPrinter()Lcom/alibaba/sdk/android/oss/common/LogPrinter;
    .locals 1

    .line 162
    sget-object v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    return-object v0
.end method

.method public static isEnableLog()Z
    .locals 1

    .line 39
    sget-boolean v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->enableLog:Z

    return v0
.end method

.method private static log2Local(Ljava/lang/String;Z)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "write2local"    # Z

    .line 156
    if-eqz p1, :cond_0

    .line 157
    invoke-static {}, Lcom/alibaba/sdk/android/oss/common/OSSLogToFileUtils;->getInstance()Lcom/alibaba/sdk/android/oss/common/OSSLogToFileUtils;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/oss/common/OSSLogToFileUtils;->write(Ljava/lang/Object;)V

    .line 159
    :cond_0
    return-void
.end method

.method public static logDebug(Ljava/lang/String;)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;

    .line 96
    const-string v0, "OSS-Android-SDK"

    invoke-static {v0, p0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;Ljava/lang/String;)V

    .line 97
    return-void
.end method

.method public static logDebug(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "msg"    # Ljava/lang/String;

    .line 100
    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 101
    return-void
.end method

.method public static logDebug(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 2
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "write2local"    # Z

    .line 114
    sget-boolean v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->enableLog:Z

    if-eqz v0, :cond_0

    .line 115
    sget-object v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    sget-object v1, Lcom/alibaba/sdk/android/oss/common/LogLevel;->DEBUG:Lcom/alibaba/sdk/android/oss/common/LogLevel;

    invoke-interface {v0, v1, p1}, Lcom/alibaba/sdk/android/oss/common/LogPrinter;->log(Lcom/alibaba/sdk/android/oss/common/LogLevel;Ljava/lang/String;)V

    .line 116
    invoke-static {p1, p2}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->log2Local(Ljava/lang/String;Z)V

    .line 118
    :cond_0
    return-void
.end method

.method public static logDebug(Ljava/lang/String;Z)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "write2local"    # Z

    .line 110
    const-string v0, "OSS-Android-SDK"

    invoke-static {v0, p0, p1}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 111
    return-void
.end method

.method public static logError(Ljava/lang/String;)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;

    .line 126
    const-string v0, "OSS-Android-SDK"

    invoke-static {v0, p0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logError(Ljava/lang/String;Ljava/lang/String;)V

    .line 127
    return-void
.end method

.method public static logError(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "msg"    # Ljava/lang/String;

    .line 130
    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logError(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 131
    return-void
.end method

.method public static logError(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 2
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "write2local"    # Z

    .line 143
    sget-boolean v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->enableLog:Z

    if-eqz v0, :cond_0

    .line 144
    sget-object v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    sget-object v1, Lcom/alibaba/sdk/android/oss/common/LogLevel;->ERROR:Lcom/alibaba/sdk/android/oss/common/LogLevel;

    invoke-interface {v0, v1, p1}, Lcom/alibaba/sdk/android/oss/common/LogPrinter;->log(Lcom/alibaba/sdk/android/oss/common/LogLevel;Ljava/lang/String;)V

    .line 145
    invoke-static {p1, p2}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->log2Local(Ljava/lang/String;Z)V

    .line 147
    :cond_0
    return-void
.end method

.method public static logError(Ljava/lang/String;Z)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "write2local"    # Z

    .line 139
    const-string v0, "OSS-Android-SDK"

    invoke-static {v0, p0, p1}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logError(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 140
    return-void
.end method

.method public static logInfo(Ljava/lang/String;)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;

    .line 48
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logInfo(Ljava/lang/String;Z)V

    .line 49
    return-void
.end method

.method public static logInfo(Ljava/lang/String;Z)V
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "write2local"    # Z

    .line 52
    sget-boolean v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->enableLog:Z

    if-eqz v0, :cond_0

    .line 53
    sget-object v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    sget-object v1, Lcom/alibaba/sdk/android/oss/common/LogLevel;->INFO:Lcom/alibaba/sdk/android/oss/common/LogLevel;

    invoke-interface {v0, v1, p0}, Lcom/alibaba/sdk/android/oss/common/LogPrinter;->log(Lcom/alibaba/sdk/android/oss/common/LogLevel;Ljava/lang/String;)V

    .line 54
    invoke-static {p0, p1}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->log2Local(Ljava/lang/String;Z)V

    .line 56
    :cond_0
    return-void
.end method

.method public static logThrowable2Local(Ljava/lang/Throwable;)V
    .locals 1
    .param p0, "throwable"    # Ljava/lang/Throwable;

    .line 150
    sget-boolean v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->enableLog:Z

    if-eqz v0, :cond_0

    .line 151
    invoke-static {}, Lcom/alibaba/sdk/android/oss/common/OSSLogToFileUtils;->getInstance()Lcom/alibaba/sdk/android/oss/common/OSSLogToFileUtils;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/oss/common/OSSLogToFileUtils;->write(Ljava/lang/Object;)V

    .line 153
    :cond_0
    return-void
.end method

.method public static logVerbose(Ljava/lang/String;)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;

    .line 64
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logVerbose(Ljava/lang/String;Z)V

    .line 65
    return-void
.end method

.method public static logVerbose(Ljava/lang/String;Z)V
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "write2local"    # Z

    .line 68
    sget-boolean v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->enableLog:Z

    if-eqz v0, :cond_0

    .line 69
    sget-object v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    sget-object v1, Lcom/alibaba/sdk/android/oss/common/LogLevel;->VERBOSE:Lcom/alibaba/sdk/android/oss/common/LogLevel;

    invoke-interface {v0, v1, p0}, Lcom/alibaba/sdk/android/oss/common/LogPrinter;->log(Lcom/alibaba/sdk/android/oss/common/LogLevel;Ljava/lang/String;)V

    .line 70
    invoke-static {p0, p1}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->log2Local(Ljava/lang/String;Z)V

    .line 72
    :cond_0
    return-void
.end method

.method public static logWarn(Ljava/lang/String;)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;

    .line 80
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logWarn(Ljava/lang/String;Z)V

    .line 81
    return-void
.end method

.method public static logWarn(Ljava/lang/String;Z)V
    .locals 2
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "write2local"    # Z

    .line 84
    sget-boolean v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->enableLog:Z

    if-eqz v0, :cond_0

    .line 85
    sget-object v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    sget-object v1, Lcom/alibaba/sdk/android/oss/common/LogLevel;->WARN:Lcom/alibaba/sdk/android/oss/common/LogLevel;

    invoke-interface {v0, v1, p0}, Lcom/alibaba/sdk/android/oss/common/LogPrinter;->log(Lcom/alibaba/sdk/android/oss/common/LogLevel;Ljava/lang/String;)V

    .line 86
    invoke-static {p0, p1}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->log2Local(Ljava/lang/String;Z)V

    .line 88
    :cond_0
    return-void
.end method

.method public static setLogPrinter(Lcom/alibaba/sdk/android/oss/common/LogPrinter;)V
    .locals 1
    .param p0, "logPrinter"    # Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    .line 166
    if-nez p0, :cond_0

    .line 167
    sget-object v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->nopLogPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    sput-object v0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    goto :goto_0

    .line 169
    :cond_0
    sput-object p0, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logPrinter:Lcom/alibaba/sdk/android/oss/common/LogPrinter;

    .line 171
    :goto_0
    return-void
.end method
