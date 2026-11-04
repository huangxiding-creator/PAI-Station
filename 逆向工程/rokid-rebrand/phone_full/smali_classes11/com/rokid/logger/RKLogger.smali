.class public Lcom/rokid/logger/RKLogger;
.super Ljava/lang/Object;
.source "RKLogger.java"


# static fields
.field private static emojis:[Ljava/lang/String;

.field private static enableEmoji:Z

.field public static filterLevel:I

.field private static isShowPid:Z

.field private static isShowTid:Z

.field private static logFilePath:Ljava/lang/String;

.field private static logger:Lorg/slf4j/Logger;

.field private static printTAG:Ljava/lang/String;

.field public static tag:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 30
    const/4 v0, 0x1

    sput v0, Lcom/rokid/logger/RKLogger;->filterLevel:I

    .line 31
    const-string v1, "Rokid_Logger"

    sput-object v1, Lcom/rokid/logger/RKLogger;->tag:Ljava/lang/String;

    .line 39
    sget-object v1, Lcom/rokid/logger/RKLogger;->tag:Ljava/lang/String;

    sput-object v1, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    .line 93
    const/4 v1, 0x0

    sput-boolean v1, Lcom/rokid/logger/RKLogger;->enableEmoji:Z

    .line 99
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

    sput-object v2, Lcom/rokid/logger/RKLogger;->emojis:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static varargs d(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 111
    invoke-static {p0, p1}, Lcom/rokid/logger/RKLogger;->debug(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 112
    return-void
.end method

.method public static varargs debug(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 131
    const/4 v0, 0x2

    invoke-static {v0, p0, p1}, Lcom/rokid/logger/RKLogger;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 132
    return-void
.end method

.method public static varargs e(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 123
    invoke-static {p0, p1}, Lcom/rokid/logger/RKLogger;->error(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 124
    return-void
.end method

.method public static enableEmoji(Z)V
    .locals 0
    .param p0, "enable"    # Z

    .line 96
    sput-boolean p0, Lcom/rokid/logger/RKLogger;->enableEmoji:Z

    .line 97
    return-void
.end method

.method public static varargs error(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 143
    const/4 v0, 0x5

    invoke-static {v0, p0, p1}, Lcom/rokid/logger/RKLogger;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 144
    return-void
.end method

.method private static varargs getLogInfo(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 4
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
    invoke-virtual {v0, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/Object;)Ljava/lang/StringBuffer;

    .line 150
    .end local v3    # "tempArg":Ljava/lang/Object;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 153
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static getSaveFilePath()Ljava/lang/String;
    .locals 1

    .line 257
    sget-object v0, Lcom/rokid/logger/RKLogger;->logger:Lorg/slf4j/Logger;

    if-eqz v0, :cond_0

    .line 258
    sget-object v0, Lcom/rokid/logger/RKLogger;->logFilePath:Ljava/lang/String;

    return-object v0

    .line 260
    :cond_0
    const-string v0, "Log saving to file is not enabled"

    return-object v0
.end method

.method public static varargs i(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 115
    invoke-static {p0, p1}, Lcom/rokid/logger/RKLogger;->info(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 116
    return-void
.end method

.method public static varargs info(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 135
    const/4 v0, 0x3

    invoke-static {v0, p0, p1}, Lcom/rokid/logger/RKLogger;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 136
    return-void
.end method

.method private static printLog(ILjava/lang/String;)V
    .locals 1
    .param p0, "level"    # I
    .param p1, "printLogInfo"    # Ljava/lang/String;

    .line 204
    packed-switch p0, :pswitch_data_0

    .line 221
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 218
    :pswitch_0
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 219
    goto :goto_0

    .line 215
    :pswitch_1
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 216
    goto :goto_0

    .line 212
    :pswitch_2
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 213
    goto :goto_0

    .line 209
    :pswitch_3
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 210
    goto :goto_0

    .line 206
    :pswitch_4
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 207
    nop

    .line 224
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

    .line 164
    sget v0, Lcom/rokid/logger/RKLogger;->filterLevel:I

    if-ge p0, v0, :cond_0

    .line 165
    return-void

    .line 170
    :cond_0
    const-string v0, "%"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    array-length v1, p2

    if-lez v1, :cond_1

    .line 172
    :try_start_0
    const-string v1, "%%"

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object p1, v0

    .line 173
    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 177
    .local v0, "printLogInfo":Ljava/lang/String;
    goto :goto_0

    .line 174
    .end local v0    # "printLogInfo":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 175
    .local v0, "e":Ljava/lang/Exception;
    invoke-static {p1, p2}, Lcom/rokid/logger/RKLogger;->getLogInfo(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 176
    .local v1, "printLogInfo":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 177
    .end local v0    # "e":Ljava/lang/Exception;
    move-object v0, v1

    goto :goto_0

    .line 179
    .end local v1    # "printLogInfo":Ljava/lang/String;
    :cond_1
    invoke-static {p1, p2}, Lcom/rokid/logger/RKLogger;->getLogInfo(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 183
    .local v0, "printLogInfo":Ljava/lang/String;
    :goto_0
    sget-boolean v1, Lcom/rokid/logger/RKLogger;->enableEmoji:Z

    if-eqz v1, :cond_2

    .line 184
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/rokid/logger/RKLogger;->emojis:[Ljava/lang/String;

    add-int/lit8 v3, p0, -0x1

    aget-object v2, v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/rokid/logger/RKLogger;->tag:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    .line 188
    :cond_2
    sget-object v1, Lcom/rokid/logger/RKLogger;->logger:Lorg/slf4j/Logger;

    if-eqz v1, :cond_5

    .line 190
    sget-boolean v1, Lcom/rokid/logger/RKLogger;->isShowTid:Z

    const-string v2, "["

    if-eqz v1, :cond_3

    .line 191
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

    sget-object v3, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    .line 193
    :cond_3
    sget-boolean v1, Lcom/rokid/logger/RKLogger;->isShowPid:Z

    if-eqz v1, :cond_4

    .line 194
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

    sget-object v2, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    .line 196
    :cond_4
    invoke-static {p0, v0}, Lcom/rokid/logger/RKLogger;->saveAndPrintLog(ILjava/lang/String;)V

    goto :goto_1

    .line 198
    :cond_5
    invoke-static {p0, v0}, Lcom/rokid/logger/RKLogger;->printLog(ILjava/lang/String;)V

    .line 201
    :goto_1
    return-void
.end method

.method private static saveAndPrintLog(ILjava/lang/String;)V
    .locals 1
    .param p0, "level"    # I
    .param p1, "message"    # Ljava/lang/String;

    .line 233
    packed-switch p0, :pswitch_data_0

    .line 250
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 247
    :pswitch_0
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/rokid/logger/RKLogger2;->error(Ljava/lang/String;Ljava/lang/String;)V

    .line 248
    goto :goto_0

    .line 244
    :pswitch_1
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/rokid/logger/RKLogger2;->warning(Ljava/lang/String;Ljava/lang/String;)V

    .line 245
    goto :goto_0

    .line 241
    :pswitch_2
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/rokid/logger/RKLogger2;->info(Ljava/lang/String;Ljava/lang/String;)V

    .line 242
    goto :goto_0

    .line 238
    :pswitch_3
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/rokid/logger/RKLogger2;->debug(Ljava/lang/String;Ljava/lang/String;)V

    .line 239
    goto :goto_0

    .line 235
    :pswitch_4
    sget-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/rokid/logger/RKLogger2;->verbose(Ljava/lang/String;Ljava/lang/String;)V

    .line 236
    nop

    .line 253
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

.method public static setEmojis([Ljava/lang/String;)V
    .locals 0
    .param p0, "emojis"    # [Ljava/lang/String;

    .line 102
    sput-object p0, Lcom/rokid/logger/RKLogger;->emojis:[Ljava/lang/String;

    .line 103
    return-void
.end method

.method public static setLogcatConfig(Landroid/content/Context;Lcom/rokid/logger/manager/LogcatConfig;)V
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "config"    # Lcom/rokid/logger/manager/LogcatConfig;

    .line 50
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getModule()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 51
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getModule()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/rokid/logger/RKLogger;->tag:Ljava/lang/String;

    .line 54
    :cond_0
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilterLevel()I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_1

    .line 55
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFilterLevel()I

    move-result v0

    sput v0, Lcom/rokid/logger/RKLogger;->filterLevel:I

    .line 57
    :cond_1
    sget-object v0, Lcom/rokid/logger/RKLogger;->tag:Ljava/lang/String;

    sput-object v0, Lcom/rokid/logger/RKLogger;->printTAG:Ljava/lang/String;

    .line 60
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->isSaveLogInfo()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 62
    sget-object v0, Landroid/os/Environment;->DIRECTORY_DOCUMENTS:Ljava/lang/String;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/rokid/logger/RKLogger;->logFilePath:Ljava/lang/String;

    .line 65
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 66
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/rokid/logger/RKLogger;->logFilePath:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "LogInfo"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "Log.txt"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/rokid/logger/RKLogger;->logFilePath:Ljava/lang/String;

    goto :goto_0

    .line 68
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/rokid/logger/RKLogger;->logFilePath:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/rokid/logger/RKLogger;->logFilePath:Ljava/lang/String;

    .line 71
    :goto_0
    sget-object v0, Lcom/rokid/logger/RKLogger;->logger:Lorg/slf4j/Logger;

    if-nez v0, :cond_3

    .line 72
    new-instance v0, Lde/mindpipe/android/logging/log4j/LogConfigurator;

    invoke-direct {v0}, Lde/mindpipe/android/logging/log4j/LogConfigurator;-><init>()V

    .line 73
    .local v0, "logConfigurator":Lde/mindpipe/android/logging/log4j/LogConfigurator;
    sget-object v2, Lcom/rokid/logger/RKLogger;->logFilePath:Ljava/lang/String;

    invoke-virtual {v0, v2}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setFileName(Ljava/lang/String;)V

    .line 74
    sget-object v2, Lorg/apache/log4j/Level;->TRACE:Lorg/apache/log4j/Level;

    invoke-virtual {v0, v2}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setRootLevel(Lorg/apache/log4j/Level;)V

    .line 75
    const-string v2, "org.apache"

    sget-object v3, Lorg/apache/log4j/Level;->TRACE:Lorg/apache/log4j/Level;

    invoke-virtual {v0, v2, v3}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setLevel(Ljava/lang/String;Lorg/apache/log4j/Level;)V

    .line 78
    const-string v2, "%d %-5p [%t] %m%n"

    invoke-virtual {v0, v2}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setFilePattern(Ljava/lang/String;)V

    .line 79
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileCacheSize()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setMaxFileSize(J)V

    .line 80
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->getFileNum()I

    move-result v2

    invoke-virtual {v0, v2}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setMaxBackupSize(I)V

    .line 81
    invoke-virtual {v0, v1}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->setImmediateFlush(Z)V

    .line 82
    invoke-virtual {v0}, Lde/mindpipe/android/logging/log4j/LogConfigurator;->configure()V

    .line 84
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->isShowPid()Z

    move-result v1

    sput-boolean v1, Lcom/rokid/logger/RKLogger;->isShowPid:Z

    .line 85
    invoke-virtual {p1}, Lcom/rokid/logger/manager/LogcatConfig;->isShowTid()Z

    move-result v1

    sput-boolean v1, Lcom/rokid/logger/RKLogger;->isShowTid:Z

    .line 87
    const-string v1, ""

    invoke-static {v1}, Lorg/slf4j/LoggerFactory;->getLogger(Ljava/lang/String;)Lorg/slf4j/Logger;

    move-result-object v1

    sput-object v1, Lcom/rokid/logger/RKLogger;->logger:Lorg/slf4j/Logger;

    .line 90
    .end local v0    # "logConfigurator":Lde/mindpipe/android/logging/log4j/LogConfigurator;
    :cond_3
    return-void
.end method

.method public static declared-synchronized setTAG(Ljava/lang/String;I)V
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "filterLevel"    # I

    const-class v0, Lcom/rokid/logger/RKLogger;

    monitor-enter v0

    .line 45
    :try_start_0
    sput-object p0, Lcom/rokid/logger/RKLogger;->tag:Ljava/lang/String;

    .line 46
    sput p1, Lcom/rokid/logger/RKLogger;->filterLevel:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 47
    monitor-exit v0

    return-void

    .line 44
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

    .line 107
    invoke-static {p0, p1}, Lcom/rokid/logger/RKLogger;->verbose(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 108
    return-void
.end method

.method public static varargs verbose(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 127
    const/4 v0, 0x1

    invoke-static {v0, p0, p1}, Lcom/rokid/logger/RKLogger;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 128
    return-void
.end method

.method public static varargs w(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 119
    invoke-static {p0, p1}, Lcom/rokid/logger/RKLogger;->warning(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 120
    return-void
.end method

.method public static varargs warning(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 139
    const/4 v0, 0x4

    invoke-static {v0, p0, p1}, Lcom/rokid/logger/RKLogger;->readyPrintLog(ILjava/lang/String;[Ljava/lang/Object;)V

    .line 140
    return-void
.end method
