.class public Lcom/rokid/security/phone/sdk/base/utils/log/L;
.super Ljava/lang/Object;
.source "L.java"


# static fields
.field private static emojis:[Ljava/lang/String;

.field private static enableEmoji:Z

.field public static filterLevel:I

.field private static isShowPid:Z

.field private static isShowTid:Z

.field private static logFilePath:Ljava/lang/String;

.field private static logger:Lorg/apache/log4j/Logger;

.field private static printTAG:Ljava/lang/String;

.field public static tag:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 25
    const/4 v0, 0x1

    sput v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->filterLevel:I

    .line 26
    const-string v1, "Mobile-SDK"

    sput-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->tag:Ljava/lang/String;

    .line 30
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->tag:Ljava/lang/String;

    sput-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    .line 33
    const/4 v1, 0x0

    sput-boolean v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->enableEmoji:Z

    .line 34
    const/4 v2, 0x5

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, " \ud83d\udc3b "

    aput-object v3, v2, v1

    const-string v1, " \ud83d\udc25 "

    aput-object v1, v2, v0

    const/4 v0, 0x2

    const-string v1, " \ud83d\udc38 "

    aput-object v1, v2, v0

    const/4 v0, 0x3

    const-string v1, " \ud83c\udf26 "

    aput-object v1, v2, v0

    const/4 v0, 0x4

    const-string v1, " \ud83d\udc94 "

    aput-object v1, v2, v0

    sput-object v2, Lcom/rokid/security/phone/sdk/base/utils/log/L;->emojis:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static varargs d(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 115
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->debug(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 116
    return-void
.end method

.method public static varargs debug(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 135
    const/4 v0, 0x2

    invoke-static {v0, p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 136
    return-void
.end method

.method public static varargs e(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 127
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->error(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 128
    return-void
.end method

.method public static enableEmoji(Z)V
    .locals 0
    .param p0, "enable"    # Z

    .line 269
    sput-boolean p0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->enableEmoji:Z

    .line 270
    return-void
.end method

.method public static varargs error(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 147
    const/4 v0, 0x5

    invoke-static {v0, p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 148
    return-void
.end method

.method private static varargs getLogInfo(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 5
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 152
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0, p0}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .line 153
    .local v0, "stringBuffer":Ljava/lang/StringBuffer;
    array-length v1, p1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, p1, v2

    .line 154
    .local v3, "tempArg":Ljava/lang/Object;
    const-string v4, " "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 155
    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    .line 153
    .end local v3    # "tempArg":Ljava/lang/Object;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 157
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static getSaveFilePath()Ljava/lang/String;
    .locals 1

    .line 260
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logFilePath:Ljava/lang/String;

    goto :goto_0

    :cond_0
    const-string v0, "Log saving to file is not enabled"

    :goto_0
    return-object v0
.end method

.method public static varargs i(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 119
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->info(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 120
    return-void
.end method

.method public static varargs info(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 139
    const/4 v0, 0x3

    invoke-static {v0, p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 140
    return-void
.end method

.method private static initIndependentAppender(Landroid/content/Context;Lcom/rokid/logger/manager/LogcatConfig;)V
    .locals 11
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "config"    # Lcom/rokid/logger/manager/LogcatConfig;

    .line 60
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilePath()Ljava/lang/String;

    move-result-object v0

    .line 62
    .local v0, "configuredFilePath":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 63
    sget-object v1, Landroid/os/Environment;->DIRECTORY_DOCUMENTS:Ljava/lang/String;

    invoke-virtual {p0, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 64
    .local v1, "externalDocDir":Ljava/io/File;
    if-nez v1, :cond_0

    .line 65
    sget-object v2, Lcom/rokid/security/phone/sdk/base/utils/log/L;->tag:Ljava/lang/String;

    const-string v3, "External storage unavailable, cannot create log file"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 66
    return-void

    .line 69
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 70
    .local v1, "resolvedLogFilePath":Ljava/lang/String;
    goto :goto_0

    .line 71
    .end local v1    # "resolvedLogFilePath":Ljava/lang/String;
    :cond_1
    move-object v1, v0

    .line 74
    .restart local v1    # "resolvedLogFilePath":Ljava/lang/String;
    :goto_0
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 75
    .local v2, "logFile":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v3

    .line 76
    .local v3, "parentDir":Ljava/io/File;
    if-eqz v3, :cond_2

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v4

    if-nez v4, :cond_2

    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    move-result v4

    if-nez v4, :cond_2

    .line 77
    sget-object v4, Lcom/rokid/security/phone/sdk/base/utils/log/L;->tag:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Failed to create log directory: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 78
    return-void

    .line 80
    :cond_2
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    sput-object v4, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logFilePath:Ljava/lang/String;

    .line 83
    new-instance v4, Lorg/apache/log4j/PatternLayout;

    const-string v5, "%d %-5p [%t] %m%n"

    invoke-direct {v4, v5}, Lorg/apache/log4j/PatternLayout;-><init>(Ljava/lang/String;)V

    .line 87
    .local v4, "layout":Lorg/apache/log4j/PatternLayout;
    :try_start_0
    new-instance v5, Lorg/apache/log4j/RollingFileAppender;

    invoke-direct {v5}, Lorg/apache/log4j/RollingFileAppender;-><init>()V

    .line 88
    .local v5, "fileAppender":Lorg/apache/log4j/RollingFileAppender;
    const-string v6, "Mobile_SDK_Appender"

    invoke-virtual {v5, v6}, Lorg/apache/log4j/RollingFileAppender;->setName(Ljava/lang/String;)V

    .line 89
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lorg/apache/log4j/RollingFileAppender;->setFile(Ljava/lang/String;)V

    .line 90
    invoke-virtual {v5, v4}, Lorg/apache/log4j/RollingFileAppender;->setLayout(Lorg/apache/log4j/Layout;)V

    .line 91
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileCacheSize()J

    move-result-wide v7

    const-wide/16 v9, 0x400

    div-long/2addr v7, v9

    div-long/2addr v7, v9

    invoke-virtual {v6, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "MB"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lorg/apache/log4j/RollingFileAppender;->setMaxFileSize(Ljava/lang/String;)V

    .line 92
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileNum()I

    move-result v6

    invoke-virtual {v5, v6}, Lorg/apache/log4j/RollingFileAppender;->setMaxBackupIndex(I)V

    .line 93
    const/4 v6, 0x1

    invoke-virtual {v5, v6}, Lorg/apache/log4j/RollingFileAppender;->setImmediateFlush(Z)V

    .line 94
    invoke-virtual {v5, v6}, Lorg/apache/log4j/RollingFileAppender;->setAppend(Z)V

    .line 95
    invoke-virtual {v5}, Lorg/apache/log4j/RollingFileAppender;->activateOptions()V

    .line 98
    sget-object v6, Lcom/rokid/security/phone/sdk/base/utils/log/L;->tag:Ljava/lang/String;

    invoke-static {v6}, Lorg/apache/log4j/Logger;->getLogger(Ljava/lang/String;)Lorg/apache/log4j/Logger;

    move-result-object v6

    sput-object v6, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    .line 99
    sget-object v6, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    const/4 v7, 0x0

    invoke-virtual {v6, v7}, Lorg/apache/log4j/Logger;->setAdditivity(Z)V

    .line 100
    sget-object v6, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    sget-object v7, Lorg/apache/log4j/Level;->DEBUG:Lorg/apache/log4j/Level;

    invoke-virtual {v6, v7}, Lorg/apache/log4j/Logger;->setLevel(Lorg/apache/log4j/Level;)V

    .line 101
    sget-object v6, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v6, v5}, Lorg/apache/log4j/Logger;->addAppender(Lorg/apache/log4j/Appender;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 106
    .end local v5    # "fileAppender":Lorg/apache/log4j/RollingFileAppender;
    goto :goto_1

    .line 103
    :catch_0
    move-exception v5

    .line 104
    .local v5, "e":Ljava/lang/Exception;
    sget-object v6, Lcom/rokid/security/phone/sdk/base/utils/log/L;->tag:Ljava/lang/String;

    const-string v7, "Failed to create independent log appender"

    invoke-static {v6, v7, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 105
    const-string v6, "SL Appender init error"

    invoke-static {v6, v5}, Lorg/apache/log4j/helpers/LogLog;->error(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 107
    .end local v5    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method private static printLog(ILjava/lang/String;)V
    .locals 1
    .param p0, "level"    # I
    .param p1, "printLogInfo"    # Ljava/lang/String;

    .line 211
    packed-switch p0, :pswitch_data_0

    .line 228
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 225
    :pswitch_0
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 226
    goto :goto_0

    .line 222
    :pswitch_1
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 223
    goto :goto_0

    .line 219
    :pswitch_2
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 220
    goto :goto_0

    .line 216
    :pswitch_3
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 217
    goto :goto_0

    .line 213
    :pswitch_4
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 214
    nop

    .line 230
    :goto_0
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static varargs readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V
    .locals 4
    .param p0, "level"    # I
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 168
    sget v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->filterLevel:I

    if-ge p0, v0, :cond_0

    .line 169
    return-void

    .line 174
    :cond_0
    const-string v0, "%"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    array-length v1, p2

    if-lez v1, :cond_1

    .line 176
    :try_start_0
    const-string v1, "%%"

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object p1, v0

    .line 177
    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 181
    .local v0, "printLogInfo":Ljava/lang/String;
    goto :goto_0

    .line 178
    .end local v0    # "printLogInfo":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 179
    .local v0, "e":Ljava/lang/Exception;
    invoke-static {p1, p2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->getLogInfo(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 180
    .local v1, "printLogInfo":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 181
    .end local v0    # "e":Ljava/lang/Exception;
    move-object v0, v1

    goto :goto_0

    .line 183
    .end local v1    # "printLogInfo":Ljava/lang/String;
    :cond_1
    invoke-static {p1, p2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->getLogInfo(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 187
    .local v0, "printLogInfo":Ljava/lang/String;
    :goto_0
    sget-boolean v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->enableEmoji:Z

    if-eqz v1, :cond_2

    .line 188
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/rokid/security/phone/sdk/base/utils/log/L;->emojis:[Ljava/lang/String;

    add-int/lit8 v3, p0, -0x1

    aget-object v2, v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/phone/sdk/base/utils/log/L;->tag:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    .line 192
    :cond_2
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    if-eqz v1, :cond_5

    .line 194
    sget-boolean v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->isShowTid:Z

    const-string v2, "["

    if-eqz v1, :cond_3

    .line 195
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Landroid/os/Process;->myTid()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "]"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v3, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    .line 197
    :cond_3
    sget-boolean v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->isShowPid:Z

    if-eqz v1, :cond_4

    .line 198
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]-"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    .line 203
    :cond_4
    invoke-static {p0, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->saveAndPrintLog(ILjava/lang/String;)V

    goto :goto_1

    .line 205
    :cond_5
    invoke-static {p0, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printLog(ILjava/lang/String;)V

    .line 208
    :goto_1
    return-void
.end method

.method private static saveAndPrintLog(ILjava/lang/String;)V
    .locals 2
    .param p0, "level"    # I
    .param p1, "message"    # Ljava/lang/String;

    .line 234
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "  "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 235
    .local v0, "message2":Ljava/lang/String;
    packed-switch p0, :pswitch_data_0

    .line 252
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, p1}, Lorg/apache/log4j/Logger;->trace(Ljava/lang/Object;)V

    goto :goto_0

    .line 249
    :pswitch_0
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, v0}, Lorg/apache/log4j/Logger;->error(Ljava/lang/Object;)V

    .line 250
    goto :goto_0

    .line 246
    :pswitch_1
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, v0}, Lorg/apache/log4j/Logger;->warn(Ljava/lang/Object;)V

    .line 247
    goto :goto_0

    .line 243
    :pswitch_2
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, v0}, Lorg/apache/log4j/Logger;->info(Ljava/lang/Object;)V

    .line 244
    goto :goto_0

    .line 240
    :pswitch_3
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, v0}, Lorg/apache/log4j/Logger;->debug(Ljava/lang/Object;)V

    .line 241
    goto :goto_0

    .line 237
    :pswitch_4
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, v0}, Lorg/apache/log4j/Logger;->trace(Ljava/lang/Object;)V

    .line 238
    nop

    .line 255
    :goto_0
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printLog(ILjava/lang/String;)V

    .line 256
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static setEmojis([Ljava/lang/String;)V
    .locals 0
    .param p0, "emojis"    # [Ljava/lang/String;

    .line 273
    if-eqz p0, :cond_0

    .line 274
    sput-object p0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->emojis:[Ljava/lang/String;

    .line 276
    :cond_0
    return-void
.end method

.method public static setLogcatConfig(Landroid/content/Context;Lcom/rokid/logger/manager/LogcatConfig;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "config"    # Lcom/rokid/logger/manager/LogcatConfig;

    .line 39
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getModule()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 40
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getModule()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->tag:Ljava/lang/String;

    .line 42
    :cond_0
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilterLevel()I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_1

    .line 43
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilterLevel()I

    move-result v0

    sput v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->filterLevel:I

    .line 45
    :cond_1
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->tag:Ljava/lang/String;

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->printTAG:Ljava/lang/String;

    .line 46
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->isShowPid()Z

    move-result v0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->isShowPid:Z

    .line 47
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->isShowTid()Z

    move-result v0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->isShowTid:Z

    .line 50
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->isSaveLogInfo()Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->logger:Lorg/apache/log4j/Logger;

    if-nez v0, :cond_2

    .line 51
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->initIndependentAppender(Landroid/content/Context;Lcom/rokid/logger/manager/LogcatConfig;)V

    .line 53
    :cond_2
    return-void
.end method

.method public static declared-synchronized setTAG(Ljava/lang/String;I)V
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "filterLevel"    # I

    const-class v0, Lcom/rokid/security/phone/sdk/base/utils/log/L;

    monitor-enter v0

    .line 264
    :try_start_0
    sput-object p0, Lcom/rokid/security/phone/sdk/base/utils/log/L;->tag:Ljava/lang/String;

    .line 265
    sput p1, Lcom/rokid/security/phone/sdk/base/utils/log/L;->filterLevel:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 266
    monitor-exit v0

    return-void

    .line 263
    .end local p0    # "tag":Ljava/lang/String;
    .end local p1    # "filterLevel":I
    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static varargs v(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 111
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->verbose(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 112
    return-void
.end method

.method public static varargs verbose(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 131
    const/4 v0, 0x1

    invoke-static {v0, p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 132
    return-void
.end method

.method public static varargs w(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 123
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->warning(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 124
    return-void
.end method

.method public static varargs warning(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 143
    const/4 v0, 0x4

    invoke-static {v0, p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 144
    return-void
.end method
