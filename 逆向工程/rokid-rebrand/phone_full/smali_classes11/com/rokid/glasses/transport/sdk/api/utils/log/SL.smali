.class public Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;
.super Ljava/lang/Object;
.source "SL.java"


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

    sput v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->filterLevel:I

    .line 26
    const-string v1, "Transport-SDK"

    sput-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->tag:Ljava/lang/String;

    .line 30
    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->tag:Ljava/lang/String;

    sput-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    .line 33
    const/4 v1, 0x0

    sput-boolean v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->enableEmoji:Z

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

    sput-object v2, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->emojis:[Ljava/lang/String;

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

    .line 112
    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->debug(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 113
    return-void
.end method

.method public static varargs debug(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 132
    const/4 v0, 0x2

    invoke-static {v0, p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 133
    return-void
.end method

.method public static varargs e(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 124
    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->error(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 125
    return-void
.end method

.method public static enableEmoji(Z)V
    .locals 0
    .param p0, "enable"    # Z

    .line 266
    sput-boolean p0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->enableEmoji:Z

    .line 267
    return-void
.end method

.method public static varargs error(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 144
    const/4 v0, 0x5

    invoke-static {v0, p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 145
    return-void
.end method

.method private static varargs getLogInfo(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 5
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 149
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0, p0}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .line 150
    .local v0, "stringBuffer":Ljava/lang/StringBuffer;
    array-length v1, p1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, p1, v2

    .line 151
    .local v3, "tempArg":Ljava/lang/Object;
    const-string v4, " "

    invoke-virtual {v0, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 152
    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    .line 150
    .end local v3    # "tempArg":Ljava/lang/Object;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 154
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static getSaveFilePath()Ljava/lang/String;
    .locals 1

    .line 257
    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logFilePath:Ljava/lang/String;

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

    .line 116
    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->info(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 117
    return-void
.end method

.method public static varargs info(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 136
    const/4 v0, 0x3

    invoke-static {v0, p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 137
    return-void
.end method

.method private static initIndependentAppender(Landroid/content/Context;Lcom/rokid/logger/manager/LogcatConfig;)V
    .locals 9
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "config"    # Lcom/rokid/logger/manager/LogcatConfig;

    .line 60
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilePath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    .line 64
    const/4 v0, 0x0

    .line 65
    .local v0, "logFilePath":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilePath()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 66
    sget-object v1, Landroid/os/Environment;->DIRECTORY_DOCUMENTS:Ljava/lang/String;

    invoke-virtual {p0, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 67
    .local v1, "externalDocDir":Ljava/io/File;
    if-nez v1, :cond_0

    .line 68
    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->tag:Ljava/lang/String;

    const-string v3, "External storage unavailable, cannot create log file"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 69
    return-void

    .line 72
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

    move-result-object v0

    .line 73
    .end local v1    # "externalDocDir":Ljava/io/File;
    goto :goto_0

    .line 74
    :cond_1
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilePath()Ljava/lang/String;

    move-result-object v0

    .line 77
    :goto_0
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 80
    .local v1, "logFile":Ljava/io/File;
    new-instance v2, Lorg/apache/log4j/PatternLayout;

    const-string v3, "%d %-5p [%t] %m%n"

    invoke-direct {v2, v3}, Lorg/apache/log4j/PatternLayout;-><init>(Ljava/lang/String;)V

    .line 84
    .local v2, "layout":Lorg/apache/log4j/PatternLayout;
    :try_start_0
    new-instance v3, Lorg/apache/log4j/RollingFileAppender;

    invoke-direct {v3}, Lorg/apache/log4j/RollingFileAppender;-><init>()V

    .line 85
    .local v3, "fileAppender":Lorg/apache/log4j/RollingFileAppender;
    const-string v4, "SL_Appender"

    invoke-virtual {v3, v4}, Lorg/apache/log4j/RollingFileAppender;->setName(Ljava/lang/String;)V

    .line 86
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lorg/apache/log4j/RollingFileAppender;->setFile(Ljava/lang/String;)V

    .line 87
    invoke-virtual {v3, v2}, Lorg/apache/log4j/RollingFileAppender;->setLayout(Lorg/apache/log4j/Layout;)V

    .line 88
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileCacheSize()J

    move-result-wide v5

    const-wide/16 v7, 0x400

    div-long/2addr v5, v7

    div-long/2addr v5, v7

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "MB"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lorg/apache/log4j/RollingFileAppender;->setMaxFileSize(Ljava/lang/String;)V

    .line 89
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileNum()I

    move-result v4

    invoke-virtual {v3, v4}, Lorg/apache/log4j/RollingFileAppender;->setMaxBackupIndex(I)V

    .line 90
    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Lorg/apache/log4j/RollingFileAppender;->setImmediateFlush(Z)V

    .line 91
    invoke-virtual {v3, v4}, Lorg/apache/log4j/RollingFileAppender;->setAppend(Z)V

    .line 92
    invoke-virtual {v3}, Lorg/apache/log4j/RollingFileAppender;->activateOptions()V

    .line 95
    sget-object v4, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->tag:Ljava/lang/String;

    invoke-static {v4}, Lorg/apache/log4j/Logger;->getLogger(Ljava/lang/String;)Lorg/apache/log4j/Logger;

    move-result-object v4

    sput-object v4, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    .line 96
    sget-object v4, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Lorg/apache/log4j/Logger;->setAdditivity(Z)V

    .line 97
    sget-object v4, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    sget-object v5, Lorg/apache/log4j/Level;->DEBUG:Lorg/apache/log4j/Level;

    invoke-virtual {v4, v5}, Lorg/apache/log4j/Logger;->setLevel(Lorg/apache/log4j/Level;)V

    .line 98
    sget-object v4, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v4, v3}, Lorg/apache/log4j/Logger;->addAppender(Lorg/apache/log4j/Appender;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 103
    .end local v3    # "fileAppender":Lorg/apache/log4j/RollingFileAppender;
    goto :goto_1

    .line 100
    :catch_0
    move-exception v3

    .line 101
    .local v3, "e":Ljava/lang/Exception;
    sget-object v4, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->tag:Ljava/lang/String;

    const-string v5, "Failed to create independent log appender"

    invoke-static {v4, v5, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 102
    const-string v4, "SL Appender init error"

    invoke-static {v4, v3}, Lorg/apache/log4j/helpers/LogLog;->error(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 104
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method private static printLog(ILjava/lang/String;)V
    .locals 1
    .param p0, "level"    # I
    .param p1, "printLogInfo"    # Ljava/lang/String;

    .line 208
    packed-switch p0, :pswitch_data_0

    .line 225
    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 222
    :pswitch_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 223
    goto :goto_0

    .line 219
    :pswitch_1
    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 220
    goto :goto_0

    .line 216
    :pswitch_2
    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 217
    goto :goto_0

    .line 213
    :pswitch_3
    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 214
    goto :goto_0

    .line 210
    :pswitch_4
    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 211
    nop

    .line 227
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

    .line 165
    sget v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->filterLevel:I

    if-ge p0, v0, :cond_0

    .line 166
    return-void

    .line 171
    :cond_0
    const-string v0, "%"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    array-length v1, p2

    if-lez v1, :cond_1

    .line 173
    :try_start_0
    const-string v1, "%%"

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object p1, v0

    .line 174
    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 178
    .local v0, "printLogInfo":Ljava/lang/String;
    goto :goto_0

    .line 175
    .end local v0    # "printLogInfo":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 176
    .local v0, "e":Ljava/lang/Exception;
    invoke-static {p1, p2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->getLogInfo(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 177
    .local v1, "printLogInfo":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 178
    .end local v0    # "e":Ljava/lang/Exception;
    move-object v0, v1

    goto :goto_0

    .line 180
    .end local v1    # "printLogInfo":Ljava/lang/String;
    :cond_1
    invoke-static {p1, p2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->getLogInfo(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 184
    .local v0, "printLogInfo":Ljava/lang/String;
    :goto_0
    sget-boolean v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->enableEmoji:Z

    if-eqz v1, :cond_2

    .line 185
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->emojis:[Ljava/lang/String;

    add-int/lit8 v3, p0, -0x1

    aget-object v2, v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->tag:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    .line 189
    :cond_2
    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    if-eqz v1, :cond_5

    .line 191
    sget-boolean v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->isShowTid:Z

    const-string v2, "["

    if-eqz v1, :cond_3

    .line 192
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

    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    .line 194
    :cond_3
    sget-boolean v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->isShowPid:Z

    if-eqz v1, :cond_4

    .line 195
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

    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    .line 200
    :cond_4
    invoke-static {p0, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->saveAndPrintLog(ILjava/lang/String;)V

    goto :goto_1

    .line 202
    :cond_5
    invoke-static {p0, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printLog(ILjava/lang/String;)V

    .line 205
    :goto_1
    return-void
.end method

.method private static saveAndPrintLog(ILjava/lang/String;)V
    .locals 2
    .param p0, "level"    # I
    .param p1, "message"    # Ljava/lang/String;

    .line 231
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "  "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 232
    .local v0, "message2":Ljava/lang/String;
    packed-switch p0, :pswitch_data_0

    .line 249
    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, p1}, Lorg/apache/log4j/Logger;->trace(Ljava/lang/Object;)V

    goto :goto_0

    .line 246
    :pswitch_0
    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, v0}, Lorg/apache/log4j/Logger;->error(Ljava/lang/Object;)V

    .line 247
    goto :goto_0

    .line 243
    :pswitch_1
    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, v0}, Lorg/apache/log4j/Logger;->warn(Ljava/lang/Object;)V

    .line 244
    goto :goto_0

    .line 240
    :pswitch_2
    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, v0}, Lorg/apache/log4j/Logger;->info(Ljava/lang/Object;)V

    .line 241
    goto :goto_0

    .line 237
    :pswitch_3
    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, v0}, Lorg/apache/log4j/Logger;->debug(Ljava/lang/Object;)V

    .line 238
    goto :goto_0

    .line 234
    :pswitch_4
    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    invoke-virtual {v1, v0}, Lorg/apache/log4j/Logger;->trace(Ljava/lang/Object;)V

    .line 235
    nop

    .line 252
    :goto_0
    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printLog(ILjava/lang/String;)V

    .line 253
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

    .line 270
    if-eqz p0, :cond_0

    .line 271
    sput-object p0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->emojis:[Ljava/lang/String;

    .line 273
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

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->tag:Ljava/lang/String;

    .line 42
    :cond_0
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilterLevel()I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_1

    .line 43
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilterLevel()I

    move-result v0

    sput v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->filterLevel:I

    .line 45
    :cond_1
    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->tag:Ljava/lang/String;

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->printTAG:Ljava/lang/String;

    .line 46
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->isShowPid()Z

    move-result v0

    sput-boolean v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->isShowPid:Z

    .line 47
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->isShowTid()Z

    move-result v0

    sput-boolean v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->isShowTid:Z

    .line 50
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->isSaveLogInfo()Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->logger:Lorg/apache/log4j/Logger;

    if-nez v0, :cond_2

    .line 51
    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->initIndependentAppender(Landroid/content/Context;Lcom/rokid/logger/manager/LogcatConfig;)V

    .line 53
    :cond_2
    return-void
.end method

.method public static declared-synchronized setTAG(Ljava/lang/String;I)V
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "filterLevel"    # I

    const-class v0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;

    monitor-enter v0

    .line 261
    :try_start_0
    sput-object p0, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->tag:Ljava/lang/String;

    .line 262
    sput p1, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->filterLevel:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 263
    monitor-exit v0

    return-void

    .line 260
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

    .line 108
    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->verbose(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 109
    return-void
.end method

.method public static varargs verbose(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 128
    const/4 v0, 0x1

    invoke-static {v0, p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 129
    return-void
.end method

.method public static varargs w(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 120
    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->warning(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 121
    return-void
.end method

.method public static varargs warning(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 140
    const/4 v0, 0x4

    invoke-static {v0, p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 141
    return-void
.end method
