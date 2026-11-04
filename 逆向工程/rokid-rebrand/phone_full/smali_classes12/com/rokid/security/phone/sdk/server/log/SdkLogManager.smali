.class public final Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;
.super Ljava/lang/Object;
.source "SdkLogManager.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nSdkLogManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 SdkLogManager.kt\ncom/rokid/security/phone/sdk/server/log/SdkLogManager\n+ 2 ReadWrite.kt\nkotlin/io/TextStreamsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 4 _Sequences.kt\nkotlin/sequences/SequencesKt___SequencesKt\n+ 5 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,317:1\n52#2:318\n1#3:319\n1295#4:320\n1296#4:324\n1747#5,3:321\n1855#5,2:325\n*S KotlinDebug\n*F\n+ 1 SdkLogManager.kt\ncom/rokid/security/phone/sdk/server/log/SdkLogManager\n*L\n135#1:318\n135#1:319\n136#1:320\n136#1:324\n137#1:321,3\n152#1:325,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000G\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010 \n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u000e*\u0001\u000e\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0013\u001a\u00020\u00142\u0006\u0010\u0015\u001a\u00020\u0016H\u0002J\u0018\u0010\u0017\u001a\u00020\u00142\u0006\u0010\u0018\u001a\u00020\u00192\u0006\u0010\u001a\u001a\u00020\u0004H\u0002J\u0006\u0010\u001b\u001a\u00020\u0014J\u0010\u0010\u001c\u001a\u00020\u00142\u0006\u0010\u001d\u001a\u00020\u0004H\u0002J\u0006\u0010\u001e\u001a\u00020\u0014J(\u0010\u001f\u001a\u00020\u00142\u0006\u0010 \u001a\u00020\u00122\u0006\u0010!\u001a\u00020\u00042\u0006\u0010\u0015\u001a\u00020\u00162\u0006\u0010\"\u001a\u00020\u0004H\u0002J\u0018\u0010#\u001a\u00020\u00142\u0006\u0010\u0015\u001a\u00020\u00162\u0006\u0010$\u001a\u00020\u0004H\u0002J\u0014\u0010%\u001a\u00020\u00142\u000c\u0010&\u001a\u0008\u0012\u0004\u0012\u00020\u00120\u0011R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0007\u001a\u00020\u00088BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000b\u0010\u000c\u001a\u0004\u0008\t\u0010\nR\u0010\u0010\r\u001a\u00020\u000eX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u000fR\u0016\u0010\u0010\u001a\n\u0012\u0004\u0012\u00020\u0012\u0018\u00010\u0011X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\'"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;",
        "",
        "()V",
        "TAG",
        "",
        "gb28181LogcatKeywords",
        "",
        "mFileSystemRepository",
        "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
        "getMFileSystemRepository",
        "()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
        "mFileSystemRepository$delegate",
        "Lkotlin/Lazy;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/log/SdkLogManager$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$mInterMessageListener$1;",
        "mUploadSDKLogCallback",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "",
        "compressorZip",
        "",
        "extra",
        "Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;",
        "dumpGb28181Logcat",
        "logDir",
        "Ljava/io/File;",
        "fileName",
        "init",
        "parseMessage",
        "msg",
        "release",
        "startUploadGlassSdkLog",
        "isPhoneLogUploadSuccess",
        "time",
        "category",
        "startUploadSDKLog",
        "zipFile",
        "uploadSDKLog",
        "callback",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private final TAG:Ljava/lang/String;

.field private final gb28181LogcatKeywords:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final mFileSystemRepository$delegate:Lkotlin/Lazy;

.field private final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$mInterMessageListener$1;

.field private mUploadSDKLogCallback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    const-string v0, "SdkLogManager"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    .line 37
    nop

    .line 38
    const/16 v0, 0xa

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "GB28181"

    aput-object v2, v0, v1

    .line 39
    const-string v1, "GB28181Lib"

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 38
    nop

    .line 40
    const-string v1, "GB28181GlassService"

    const/4 v2, 0x2

    aput-object v1, v0, v2

    .line 38
    nop

    .line 41
    const-string v1, "RKSipEngine"

    const/4 v2, 0x3

    aput-object v1, v0, v2

    .line 38
    nop

    .line 42
    const-string/jumbo v1, "zhf_sip"

    const/4 v2, 0x4

    aput-object v1, v0, v2

    .line 38
    nop

    .line 43
    const-string v1, "SipUA"

    const/4 v2, 0x5

    aput-object v1, v0, v2

    .line 38
    nop

    .line 44
    const-string v1, "UdpTransport"

    const/4 v2, 0x6

    aput-object v1, v0, v2

    .line 38
    nop

    .line 45
    const-string v1, "RegisterAgent"

    const/4 v2, 0x7

    aput-object v1, v0, v2

    .line 38
    nop

    .line 46
    const-string v1, "SipProvider"

    const/16 v2, 0x8

    aput-object v1, v0, v2

    .line 38
    nop

    .line 47
    const-string v1, "Receiver"

    const/16 v2, 0x9

    aput-object v1, v0, v2

    .line 38
    nop

    .line 37
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->gb28181LogcatKeywords:Ljava/util/List;

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$mFileSystemRepository$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$mFileSystemRepository$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mFileSystemRepository$delegate:Lkotlin/Lazy;

    .line 51
    new-instance v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$mInterMessageListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$mInterMessageListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$mInterMessageListener$1;

    .line 35
    return-void
.end method

.method public static final synthetic access$dumpGb28181Logcat(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;Ljava/io/File;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;
    .param p1, "logDir"    # Ljava/io/File;
    .param p2, "fileName"    # Ljava/lang/String;

    .line 35
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->dumpGb28181Logcat(Ljava/io/File;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$getMUploadSDKLogCallback$p(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;)Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mUploadSDKLogCallback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;
    .param p1, "msg"    # Ljava/lang/String;

    .line 35
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$startUploadGlassSdkLog(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;ZLjava/lang/String;Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;
    .param p1, "isPhoneLogUploadSuccess"    # Z
    .param p2, "time"    # Ljava/lang/String;
    .param p3, "extra"    # Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;
    .param p4, "category"    # Ljava/lang/String;

    .line 35
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->startUploadGlassSdkLog(ZLjava/lang/String;Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$startUploadSDKLog(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;
    .param p2, "zipFile"    # Ljava/lang/String;

    .line 35
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->startUploadSDKLog(Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V

    return-void
.end method

.method private final compressorZip(Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;)V
    .locals 12
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;

    .line 114
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    sget-object v2, Landroid/os/Environment;->DIRECTORY_DOCUMENTS:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v2

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "mobileLog"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 115
    .local v0, "phoneLogFileDir":Ljava/lang/String;
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 116
    .local v5, "sourceDir":Ljava/io/File;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v3

    sget-object v4, Landroid/os/Environment;->DIRECTORY_DOCUMENTS:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v3

    if-eqz v3, :cond_1

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    :cond_1
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "mobileLog.zip"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 117
    .local v1, "zipFile":Ljava/lang/String;
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v2

    new-instance v9, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$compressorZip$1;

    const/4 v8, 0x0

    move-object v3, v9

    move-object v4, p0

    move-object v6, v1

    move-object v7, p1

    invoke-direct/range {v3 .. v8}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$compressorZip$1;-><init>(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;Ljava/io/File;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Lkotlin/coroutines/Continuation;)V

    check-cast v9, Lkotlin/jvm/functions/Function2;

    const/4 v10, 0x3

    const/4 v11, 0x0

    const/4 v7, 0x0

    move-object v6, v2

    invoke-static/range {v6 .. v11}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 123
    return-void
.end method

.method private final dumpGb28181Logcat(Ljava/io/File;Ljava/lang/String;)V
    .locals 29
    .param p1, "logDir"    # Ljava/io/File;
    .param p2, "fileName"    # Ljava/lang/String;

    .line 126
    move-object/from16 v1, p0

    const-string v0, "append(\'\\n\')"

    const-string v2, "append(value)"

    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->mkdirs()Z

    move-result v3

    if-nez v3, :cond_0

    .line 127
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "dumpGb28181Logcat: \u65e0\u6cd5\u521b\u5efa\u65e5\u5fd7\u76ee\u5f55 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 128
    return-void

    .line 130
    :cond_0
    new-instance v3, Ljava/io/File;

    move-object/from16 v4, p1

    move-object/from16 v5, p2

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 131
    .local v3, "outputFile":Ljava/io/File;
    new-instance v6, Ljava/util/ArrayDeque;

    invoke-direct {v6}, Ljava/util/ArrayDeque;-><init>()V

    .line 132
    .local v6, "matchedLines":Ljava/util/ArrayDeque;
    const/4 v7, 0x0

    .line 133
    .local v7, "process":Ljava/lang/Process;
    nop

    .line 134
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v8

    const/4 v9, 0x4

    new-array v9, v9, [Ljava/lang/String;

    const-string v10, "logcat"

    const/4 v11, 0x0

    aput-object v10, v9, v11

    const-string v10, "-d"

    const/4 v12, 0x1

    aput-object v10, v9, v12

    const-string v10, "-v"

    const/4 v13, 0x2

    aput-object v10, v9, v13

    const-string/jumbo v10, "threadtime"

    const/4 v13, 0x3

    aput-object v10, v9, v13

    invoke-virtual {v8, v9}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v8

    move-object v7, v8

    .line 135
    invoke-virtual {v7}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v8

    const-string v9, "process.inputStream"

    invoke-static {v8, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v9, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    new-instance v10, Ljava/io/InputStreamReader;

    invoke-direct {v10, v8, v9}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    check-cast v10, Ljava/io/Reader;

    instance-of v8, v10, Ljava/io/BufferedReader;

    const/16 v9, 0x2000

    if-eqz v8, :cond_1

    check-cast v10, Ljava/io/BufferedReader;

    goto :goto_0

    :cond_1
    new-instance v8, Ljava/io/BufferedReader;

    invoke-direct {v8, v10, v9}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V

    move-object v10, v8

    :goto_0
    check-cast v10, Ljava/io/Reader;

    move-object v8, v10

    .local v8, "$this$useLines$iv":Ljava/io/Reader;
    const/4 v10, 0x0

    .line 318
    .local v10, "$i$f$useLines":I
    instance-of v13, v8, Ljava/io/BufferedReader;

    if-eqz v13, :cond_2

    move-object v13, v8

    check-cast v13, Ljava/io/BufferedReader;

    goto :goto_1

    :cond_2
    new-instance v13, Ljava/io/BufferedReader;

    invoke-direct {v13, v8, v9}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;I)V

    :goto_1
    check-cast v13, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_6

    :try_start_1
    move-object v14, v13

    check-cast v14, Ljava/io/BufferedReader;

    .line 319
    .local v14, "it$iv":Ljava/io/BufferedReader;
    const/4 v15, 0x0

    .line 318
    .local v15, "$i$a$-use-TextStreamsKt$useLines$1$iv":I
    invoke-static {v14}, Lkotlin/io/TextStreamsKt;->lineSequence(Ljava/io/BufferedReader;)Lkotlin/sequences/Sequence;

    move-result-object v16

    .local v16, "lines":Lkotlin/sequences/Sequence;
    const/16 v17, 0x0

    .line 136
    .local v17, "$i$a$-useLines-SdkLogManager$dumpGb28181Logcat$1":I
    move-object/from16 v18, v16

    .local v18, "$this$forEach$iv":Lkotlin/sequences/Sequence;
    const/16 v19, 0x0

    .line 320
    .local v19, "$i$f$forEach":I
    invoke-interface/range {v18 .. v18}, Lkotlin/sequences/Sequence;->iterator()Ljava/util/Iterator;

    move-result-object v20

    :goto_2
    invoke-interface/range {v20 .. v20}, Ljava/util/Iterator;->hasNext()Z

    move-result v21

    if-eqz v21, :cond_8

    invoke-interface/range {v20 .. v20}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v21

    .local v21, "element$iv":Ljava/lang/Object;
    move-object/from16 v22, v21

    check-cast v22, Ljava/lang/String;

    move-object/from16 v23, v22

    .local v23, "line":Ljava/lang/String;
    const/16 v22, 0x0

    .line 137
    .local v22, "$i$a$-forEach-SdkLogManager$dumpGb28181Logcat$1$1":I
    iget-object v11, v1, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->gb28181LogcatKeywords:Ljava/util/List;

    check-cast v11, Ljava/lang/Iterable;

    .local v11, "$this$any$iv":Ljava/lang/Iterable;
    const/16 v24, 0x0

    .line 321
    .local v24, "$i$f$any":I
    instance-of v9, v11, Ljava/util/Collection;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    if-eqz v9, :cond_3

    :try_start_2
    move-object v9, v11

    check-cast v9, Ljava/util/Collection;

    invoke-interface {v9}, Ljava/util/Collection;->isEmpty()Z

    move-result v9
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz v9, :cond_3

    const/4 v4, 0x0

    move-object/from16 v28, v23

    move-object/from16 v23, v8

    move v8, v12

    move-object/from16 v12, v28

    goto :goto_4

    .line 318
    .end local v11    # "$this$any$iv":Ljava/lang/Iterable;
    .end local v14    # "it$iv":Ljava/io/BufferedReader;
    .end local v15    # "$i$a$-use-TextStreamsKt$useLines$1$iv":I
    .end local v16    # "lines":Lkotlin/sequences/Sequence;
    .end local v17    # "$i$a$-useLines-SdkLogManager$dumpGb28181Logcat$1":I
    .end local v18    # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .end local v19    # "$i$f$forEach":I
    .end local v21    # "element$iv":Ljava/lang/Object;
    .end local v22    # "$i$a$-forEach-SdkLogManager$dumpGb28181Logcat$1$1":I
    .end local v23    # "line":Ljava/lang/String;
    .end local v24    # "$i$f$any":I
    :catchall_0
    move-exception v0

    move-object v2, v0

    move-object/from16 v23, v8

    goto/16 :goto_8

    .line 322
    .restart local v11    # "$this$any$iv":Ljava/lang/Iterable;
    .restart local v14    # "it$iv":Ljava/io/BufferedReader;
    .restart local v15    # "$i$a$-use-TextStreamsKt$useLines$1$iv":I
    .restart local v16    # "lines":Lkotlin/sequences/Sequence;
    .restart local v17    # "$i$a$-useLines-SdkLogManager$dumpGb28181Logcat$1":I
    .restart local v18    # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .restart local v19    # "$i$f$forEach":I
    .restart local v21    # "element$iv":Ljava/lang/Object;
    .restart local v22    # "$i$a$-forEach-SdkLogManager$dumpGb28181Logcat$1$1":I
    .restart local v23    # "line":Ljava/lang/String;
    .restart local v24    # "$i$f$any":I
    :cond_3
    :try_start_3
    invoke-interface {v11}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_3
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v25

    if-eqz v25, :cond_5

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v25

    .local v25, "element$iv":Ljava/lang/Object;
    move-object/from16 v26, v25

    check-cast v26, Ljava/lang/String;

    .local v26, "keyword":Ljava/lang/String;
    const/16 v27, 0x0

    .line 138
    .local v27, "$i$a$-any-SdkLogManager$dumpGb28181Logcat$1$1$1":I
    move-object/from16 v12, v23

    .end local v23    # "line":Ljava/lang/String;
    .local v12, "line":Ljava/lang/String;
    move-object v4, v12

    check-cast v4, Ljava/lang/CharSequence;

    move-object/from16 v5, v26

    check-cast v5, Ljava/lang/CharSequence;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_4

    move-object/from16 v23, v8

    const/4 v8, 0x1

    .end local v8    # "$this$useLines$iv":Ljava/io/Reader;
    .local v23, "$this$useLines$iv":Ljava/io/Reader;
    :try_start_4
    invoke-static {v4, v5, v8}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v4

    .line 322
    .end local v26    # "keyword":Ljava/lang/String;
    .end local v27    # "$i$a$-any-SdkLogManager$dumpGb28181Logcat$1$1$1":I
    if-eqz v4, :cond_4

    move v4, v8

    goto :goto_4

    :cond_4
    move-object/from16 v4, p1

    move-object/from16 v5, p2

    move-object/from16 v28, v12

    move v12, v8

    move-object/from16 v8, v23

    move-object/from16 v23, v28

    goto :goto_3

    .line 323
    .end local v12    # "line":Ljava/lang/String;
    .end local v25    # "element$iv":Ljava/lang/Object;
    .restart local v8    # "$this$useLines$iv":Ljava/io/Reader;
    .local v23, "line":Ljava/lang/String;
    :cond_5
    move-object/from16 v28, v23

    move-object/from16 v23, v8

    move v8, v12

    move-object/from16 v12, v28

    .end local v8    # "$this$useLines$iv":Ljava/io/Reader;
    .restart local v12    # "line":Ljava/lang/String;
    .local v23, "$this$useLines$iv":Ljava/io/Reader;
    const/4 v4, 0x0

    .line 137
    .end local v11    # "$this$any$iv":Ljava/lang/Iterable;
    .end local v24    # "$i$f$any":I
    :goto_4
    if-eqz v4, :cond_7

    .line 140
    invoke-virtual {v6}, Ljava/util/ArrayDeque;->size()I

    move-result v4

    const/16 v5, 0xfa0

    if-lt v4, v5, :cond_6

    .line 141
    invoke-virtual {v6}, Ljava/util/ArrayDeque;->removeFirst()Ljava/lang/Object;

    .line 143
    :cond_6
    invoke-virtual {v6, v12}, Ljava/util/ArrayDeque;->addLast(Ljava/lang/Object;)V

    .line 145
    :cond_7
    nop

    .line 320
    .end local v12    # "line":Ljava/lang/String;
    .end local v22    # "$i$a$-forEach-SdkLogManager$dumpGb28181Logcat$1$1":I
    move-object/from16 v4, p1

    move-object/from16 v5, p2

    move v12, v8

    move-object/from16 v8, v23

    const/16 v9, 0x2000

    const/4 v11, 0x0

    .end local v21    # "element$iv":Ljava/lang/Object;
    goto/16 :goto_2

    .line 324
    .end local v23    # "$this$useLines$iv":Ljava/io/Reader;
    .restart local v8    # "$this$useLines$iv":Ljava/io/Reader;
    :cond_8
    move-object/from16 v23, v8

    .line 146
    .end local v8    # "$this$useLines$iv":Ljava/io/Reader;
    .end local v18    # "$this$forEach$iv":Lkotlin/sequences/Sequence;
    .end local v19    # "$i$f$forEach":I
    .restart local v23    # "$this$useLines$iv":Ljava/io/Reader;
    nop

    .end local v16    # "lines":Lkotlin/sequences/Sequence;
    .end local v17    # "$i$a$-useLines-SdkLogManager$dumpGb28181Logcat$1":I
    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    .line 318
    .end local v14    # "it$iv":Ljava/io/BufferedReader;
    .end local v15    # "$i$a$-use-TextStreamsKt$useLines$1$iv":I
    const/4 v4, 0x0

    :try_start_5
    invoke-static {v13, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 147
    .end local v10    # "$i$f$useLines":I
    .end local v23    # "$this$useLines$iv":Ljava/io/Reader;
    sget-object v5, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    new-instance v8, Ljava/io/OutputStreamWriter;

    new-instance v9, Ljava/io/FileOutputStream;

    invoke-direct {v9, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    check-cast v9, Ljava/io/OutputStream;

    invoke-direct {v8, v9, v5}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/nio/charset/Charset;)V

    check-cast v8, Ljava/io/Writer;

    instance-of v5, v8, Ljava/io/BufferedWriter;

    if-eqz v5, :cond_9

    check-cast v8, Ljava/io/BufferedWriter;

    goto :goto_5

    :cond_9
    new-instance v5, Ljava/io/BufferedWriter;

    const/16 v9, 0x2000

    invoke-direct {v5, v8, v9}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;I)V

    move-object v8, v5

    :goto_5
    check-cast v8, Ljava/io/Closeable;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_6

    :try_start_6
    move-object v5, v8

    check-cast v5, Ljava/io/BufferedWriter;

    .local v5, "writer":Ljava/io/BufferedWriter;
    const/4 v9, 0x0

    .line 148
    .local v9, "$i$a$-use-SdkLogManager$dumpGb28181Logcat$2":I
    move-object v10, v5

    check-cast v10, Ljava/lang/Appendable;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "GB28181 phone logcat snapshot ts="

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v12

    invoke-virtual {v11, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    check-cast v11, Ljava/lang/CharSequence;

    invoke-interface {v10, v11}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v10

    invoke-static {v10, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v11, 0xa

    invoke-interface {v10, v11}, Ljava/lang/Appendable;->append(C)Ljava/lang/Appendable;

    move-result-object v10

    invoke-static {v10, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 149
    invoke-virtual {v6}, Ljava/util/ArrayDeque;->isEmpty()Z

    move-result v10

    if-eqz v10, :cond_a

    .line 150
    move-object v10, v5

    check-cast v10, Ljava/lang/Appendable;

    const-string v12, "No GB28181-related logcat lines matched the filter."

    check-cast v12, Ljava/lang/CharSequence;

    invoke-interface {v10, v12}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v10

    invoke-static {v10, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v10, v11}, Ljava/lang/Appendable;->append(C)Ljava/lang/Appendable;

    move-result-object v2

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_7

    .line 152
    :cond_a
    move-object v10, v6

    check-cast v10, Ljava/lang/Iterable;

    .local v10, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v12, 0x0

    .line 325
    .local v12, "$i$f$forEach":I
    invoke-interface {v10}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v13

    :goto_6
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_b

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    .local v14, "element$iv":Ljava/lang/Object;
    move-object v15, v14

    check-cast v15, Ljava/lang/String;

    .local v15, "it":Ljava/lang/String;
    const/16 v16, 0x0

    .line 152
    .local v16, "$i$a$-forEach-SdkLogManager$dumpGb28181Logcat$2$1":I
    move-object v4, v5

    check-cast v4, Ljava/lang/Appendable;

    move-object v11, v15

    check-cast v11, Ljava/lang/CharSequence;

    invoke-interface {v4, v11}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v4

    invoke-static {v4, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v11, 0xa

    invoke-interface {v4, v11}, Ljava/lang/Appendable;->append(C)Ljava/lang/Appendable;

    move-result-object v4

    invoke-static {v4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 325
    .end local v15    # "it":Ljava/lang/String;
    .end local v16    # "$i$a$-forEach-SdkLogManager$dumpGb28181Logcat$2$1":I
    const/4 v4, 0x0

    .end local v14    # "element$iv":Ljava/lang/Object;
    goto :goto_6

    .line 326
    :cond_b
    nop

    .end local v10    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v12    # "$i$f$forEach":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 149
    :goto_7
    nop

    .line 147
    .end local v5    # "writer":Ljava/io/BufferedWriter;
    .end local v9    # "$i$a$-use-SdkLogManager$dumpGb28181Logcat$2":I
    const/4 v0, 0x0

    :try_start_7
    invoke-static {v8, v0}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 155
    invoke-virtual {v7}, Ljava/lang/Process;->waitFor()I

    move-result v0

    .line 157
    .local v0, "exitCode":I
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    .line 158
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "dumpGb28181Logcat: \u5bfc\u51fa\u5b8c\u6210 exitCode = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", lines = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v6}, Ljava/util/ArrayDeque;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", file = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    .line 156
    invoke-static {v2, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_0
    .catchall {:try_start_7 .. :try_end_7} :catchall_6

    .line 163
    .end local v0    # "exitCode":I
    if-eqz v7, :cond_c

    goto :goto_9

    .line 147
    :catchall_1
    move-exception v0

    move-object v2, v0

    .end local v3    # "outputFile":Ljava/io/File;
    .end local v6    # "matchedLines":Ljava/util/ArrayDeque;
    .end local v7    # "process":Ljava/lang/Process;
    .end local p1    # "logDir":Ljava/io/File;
    .end local p2    # "fileName":Ljava/lang/String;
    :try_start_8
    throw v2
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    .restart local v3    # "outputFile":Ljava/io/File;
    .restart local v6    # "matchedLines":Ljava/util/ArrayDeque;
    .restart local v7    # "process":Ljava/lang/Process;
    .restart local p1    # "logDir":Ljava/io/File;
    .restart local p2    # "fileName":Ljava/lang/String;
    :catchall_2
    move-exception v0

    move-object v4, v0

    :try_start_9
    invoke-static {v8, v2}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v3    # "outputFile":Ljava/io/File;
    .end local v6    # "matchedLines":Ljava/util/ArrayDeque;
    .end local v7    # "process":Ljava/lang/Process;
    .end local p1    # "logDir":Ljava/io/File;
    .end local p2    # "fileName":Ljava/lang/String;
    throw v4
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_0
    .catchall {:try_start_9 .. :try_end_9} :catchall_6

    .line 318
    .restart local v3    # "outputFile":Ljava/io/File;
    .restart local v6    # "matchedLines":Ljava/util/ArrayDeque;
    .restart local v7    # "process":Ljava/lang/Process;
    .local v10, "$i$f$useLines":I
    .restart local v23    # "$this$useLines$iv":Ljava/io/Reader;
    .restart local p1    # "logDir":Ljava/io/File;
    .restart local p2    # "fileName":Ljava/lang/String;
    :catchall_3
    move-exception v0

    move-object v2, v0

    goto :goto_8

    .end local v23    # "$this$useLines$iv":Ljava/io/Reader;
    .restart local v8    # "$this$useLines$iv":Ljava/io/Reader;
    :catchall_4
    move-exception v0

    move-object/from16 v23, v8

    move-object v2, v0

    .end local v3    # "outputFile":Ljava/io/File;
    .end local v6    # "matchedLines":Ljava/util/ArrayDeque;
    .end local v7    # "process":Ljava/lang/Process;
    .end local v8    # "$this$useLines$iv":Ljava/io/Reader;
    .end local v10    # "$i$f$useLines":I
    .end local p1    # "logDir":Ljava/io/File;
    .end local p2    # "fileName":Ljava/lang/String;
    :goto_8
    :try_start_a
    throw v2
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_5

    .restart local v3    # "outputFile":Ljava/io/File;
    .restart local v6    # "matchedLines":Ljava/util/ArrayDeque;
    .restart local v7    # "process":Ljava/lang/Process;
    .restart local v10    # "$i$f$useLines":I
    .restart local v23    # "$this$useLines$iv":Ljava/io/Reader;
    .restart local p1    # "logDir":Ljava/io/File;
    .restart local p2    # "fileName":Ljava/lang/String;
    :catchall_5
    move-exception v0

    move-object v4, v0

    :try_start_b
    invoke-static {v13, v2}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v3    # "outputFile":Ljava/io/File;
    .end local v6    # "matchedLines":Ljava/util/ArrayDeque;
    .end local v7    # "process":Ljava/lang/Process;
    .end local p1    # "logDir":Ljava/io/File;
    .end local p2    # "fileName":Ljava/lang/String;
    throw v4
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_0
    .catchall {:try_start_b .. :try_end_b} :catchall_6

    .line 163
    .end local v10    # "$i$f$useLines":I
    .end local v23    # "$this$useLines$iv":Ljava/io/Reader;
    .restart local v3    # "outputFile":Ljava/io/File;
    .restart local v6    # "matchedLines":Ljava/util/ArrayDeque;
    .restart local v7    # "process":Ljava/lang/Process;
    .restart local p1    # "logDir":Ljava/io/File;
    .restart local p2    # "fileName":Ljava/lang/String;
    :catchall_6
    move-exception v0

    goto :goto_a

    .line 160
    :catch_0
    move-exception v0

    .line 161
    .local v0, "e":Ljava/lang/Exception;
    :try_start_c
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "dumpGb28181Logcat: \u5bfc\u51fa\u5931\u8d25 "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_6

    .line 163
    .end local v0    # "e":Ljava/lang/Exception;
    if-eqz v7, :cond_c

    :goto_9
    invoke-virtual {v7}, Ljava/lang/Process;->destroy()V

    .line 164
    :cond_c
    nop

    .line 165
    return-void

    .line 163
    :goto_a
    if-eqz v7, :cond_d

    invoke-virtual {v7}, Ljava/lang/Process;->destroy()V

    :cond_d
    throw v0
.end method

.method private final getMFileSystemRepository()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;
    .locals 1

    .line 49
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mFileSystemRepository$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    return-object v0
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 6
    .param p1, "msg"    # Ljava/lang/String;

    .line 63
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "COLLECT_SDK_LOG"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v0, v2, v5, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 64
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 65
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 66
    const-string v1, "extra"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 67
    .local v1, "extraJson":Ljava/lang/String;
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    if-eqz v2, :cond_0

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    const/4 v5, 0x1

    :cond_1
    if-nez v5, :cond_2

    .line 68
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 69
    .local v2, "extraJsonObject":Lorg/json/JSONObject;
    const-string v3, "methodName"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 70
    .local v3, "methodName":Ljava/lang/String;
    nop

    .line 72
    const-string v4, "Collect_Glass_SDK_Log_Response"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 74
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    const-class v5, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;

    invoke-virtual {v4, v1, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;

    .line 73
    nop

    .line 75
    .local v4, "extra":Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;
    if-eqz v4, :cond_2

    .line 76
    invoke-direct {p0, v4}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->compressorZip(Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;)V

    .line 83
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "extraJson":Ljava/lang/String;
    .end local v2    # "extraJsonObject":Lorg/json/JSONObject;
    .end local v3    # "methodName":Ljava/lang/String;
    .end local v4    # "extra":Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;
    :cond_2
    return-void
.end method

.method private final startUploadGlassSdkLog(ZLjava/lang/String;Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V
    .locals 16
    .param p1, "isPhoneLogUploadSuccess"    # Z
    .param p2, "time"    # Ljava/lang/String;
    .param p3, "extra"    # Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;
    .param p4, "category"    # Ljava/lang/String;

    .line 232
    move-object/from16 v0, p0

    move/from16 v1, p1

    invoke-virtual/range {p3 .. p3}, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->isSuccess()Z

    move-result v2

    const/4 v3, 0x1

    .line 303
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    .line 232
    const-string/jumbo v4, "\u65e5\u5fd7\u4e0a\u4f20\u5931\u8d25"

    const/4 v5, -0x2

    .line 306
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 232
    if-eqz v2, :cond_5

    .line 234
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v6

    const/4 v7, 0x0

    invoke-virtual {v6, v7}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v6

    if-eqz v6, :cond_0

    invoke-virtual {v6}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    :cond_0
    if-nez v7, :cond_1

    .line 235
    const-string v7, ""

    .line 234
    :cond_1
    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 235
    nop

    .line 234
    const-string v6, "/receiver"

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 235
    invoke-virtual/range {p3 .. p3}, Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;->getFilePath()Ljava/lang/String;

    move-result-object v6

    .line 234
    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 236
    .local v2, "logFilePath":Ljava/lang/String;
    iget-object v6, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "glass\u7aef\u65e5\u5fd7\u6587\u4ef6\u8def\u5f84 logFilePath = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v6, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 237
    new-instance v6, Ljava/io/File;

    invoke-direct {v6, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v15, v6

    .line 238
    .local v15, "glassLogFile":Ljava/io/File;
    invoke-virtual {v15}, Ljava/io/File;->exists()Z

    move-result v6

    if-eqz v6, :cond_3

    .line 239
    const-string v3, "LogManager"

    .line 240
    .local v3, "tag":Ljava/lang/String;
    invoke-virtual {v15}, Ljava/io/File;->lastModified()J

    move-result-wide v4

    .line 241
    .local v4, "captureTime":J
    sget-object v6, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getEnvType()Ljava/lang/String;

    move-result-object v6

    const-string v7, "custom"

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 242
    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->getMFileSystemRepository()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    move-result-object v6

    .line 243
    nop

    .line 244
    nop

    .line 245
    nop

    .line 246
    new-instance v7, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadGlassSdkLog$1;

    invoke-direct {v7, v0, v1}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadGlassSdkLog$1;-><init>(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;Z)V

    move-object v12, v7

    check-cast v12, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 263
    nop

    .line 242
    const/4 v13, 0x1

    move-object v7, v2

    move-object v8, v3

    move-object/from16 v9, p4

    move-wide v10, v4

    invoke-virtual/range {v6 .. v13}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->minioFileUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Z)V

    goto/16 :goto_0

    .line 265
    :cond_2
    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->getMFileSystemRepository()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    move-result-object v6

    .line 266
    nop

    .line 267
    nop

    .line 265
    sget-object v7, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadGlassSdkLog$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadGlassSdkLog$2;

    move-object v12, v7

    check-cast v12, Lkotlin/jvm/functions/Function1;

    .line 271
    new-instance v7, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadGlassSdkLog$3;

    invoke-direct {v7, v0, v1}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadGlassSdkLog$3;-><init>(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;Z)V

    move-object v13, v7

    check-cast v13, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 288
    nop

    .line 265
    const/4 v14, 0x1

    move-object v7, v2

    move-object v8, v3

    move-object/from16 v9, p4

    move-wide v10, v4

    invoke-virtual/range {v6 .. v14}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->ossFileUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLkotlin/jvm/functions/Function1;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Z)V

    .end local v3    # "tag":Ljava/lang/String;
    .end local v4    # "captureTime":J
    goto :goto_0

    .line 291
    :cond_3
    if-eqz v1, :cond_4

    .line 292
    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    const-string/jumbo v5, "\u624b\u673a\u7aef\u65e5\u5fd7\u4e0a\u4f20\u6210\u529f,glass \u7aef\u65e5\u5fd7\u6587\u4ef6\u4e0d\u5b58\u5728 "

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 293
    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mUploadSDKLogCallback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    if-eqz v4, :cond_7

    invoke-interface {v4, v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onSuccess(Ljava/lang/Object;)V

    goto :goto_0

    .line 295
    :cond_4
    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    const-string v6, "glass \u7aef\u65e5\u5fd7\u6587\u4ef6\u4e0d\u5b58\u5728 "

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v3, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 296
    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mUploadSDKLogCallback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    if-eqz v3, :cond_7

    invoke-interface {v3, v5, v4}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    goto :goto_0

    .line 301
    .end local v2    # "logFilePath":Ljava/lang/String;
    .end local v15    # "glassLogFile":Ljava/io/File;
    :cond_5
    if-eqz v1, :cond_6

    .line 302
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    const-string/jumbo v4, "\u624b\u673a\u7aef\u65e5\u5fd7\u4e0a\u4f20\u6210\u529f,\u83b7\u53d6glass \u7aef\u65e5\u5fd7\u5931\u8d25 "

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 303
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mUploadSDKLogCallback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    if-eqz v2, :cond_7

    invoke-interface {v2, v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onSuccess(Ljava/lang/Object;)V

    goto :goto_0

    .line 305
    :cond_6
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    const-string/jumbo v3, "\u83b7\u53d6glass \u7aef\u65e5\u5fd7\u5931\u8d25 "

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 306
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mUploadSDKLogCallback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    if-eqz v2, :cond_7

    invoke-interface {v2, v5, v4}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 309
    :cond_7
    :goto_0
    return-void
.end method

.method private final startUploadSDKLog(Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V
    .locals 21
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;
    .param p2, "zipFile"    # Ljava/lang/String;

    .line 170
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    sget-object v2, Lcom/rokid/security/phone/sdk/base/utils/other/TimeUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/TimeUtils;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/other/TimeUtils;->getTimeStr1(J)Ljava/lang/String;

    move-result-object v2

    .line 171
    .local v2, "time":Ljava/lang/String;
    move-object/from16 v12, p2

    .line 172
    .local v12, "logFilePath":Ljava/lang/String;
    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u624b\u673a\u7aef\u65e5\u5fd7\u6587\u4ef6\u8def\u5f84 logFilePath = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 173
    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v12}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v13, v3

    .line 175
    .local v13, "phoneLogFile":Ljava/io/File;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/device/DeviceInfoManager;->getGlassDeviceInfo()Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;

    move-result-object v3

    const/4 v4, 0x0

    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lcom/rokid/security/sdk/base/common/out/GlassDeviceInfo;->getDeviceId()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_0
    move-object v3, v4

    :goto_0
    move-object v14, v3

    .line 176
    .local v14, "glassSN":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v5, Lcom/rokid/security/sdk/ability/auth/UserManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserManager;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/ability/auth/UserManager;->getUserInfo()Lcom/rokid/security/sdk/base/common/outside/UserInfo;

    move-result-object v5

    if-eqz v5, :cond_1

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/outside/UserInfo;->getUserName()Ljava/lang/String;

    move-result-object v4

    :cond_1
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x5f

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    .line 177
    .local v15, "flag":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "sdkLog/"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x2f

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    .line 178
    .local v11, "category":Ljava/lang/String;
    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "startUploadSDKLog: category = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 180
    invoke-virtual {v13}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 181
    const-string v16, "LogManager"

    .line 182
    .local v16, "tag":Ljava/lang/String;
    invoke-virtual {v13}, Ljava/io/File;->lastModified()J

    move-result-wide v17

    .line 183
    .local v17, "captureTime":J
    sget-object v3, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getEnvType()Ljava/lang/String;

    move-result-object v3

    const-string v4, "custom"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 184
    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->getMFileSystemRepository()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    move-result-object v3

    .line 185
    nop

    .line 186
    nop

    .line 187
    nop

    .line 188
    new-instance v4, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;

    invoke-direct {v4, v0, v2, v1, v11}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;-><init>(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V

    move-object v9, v4

    check-cast v9, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 198
    nop

    .line 184
    const/4 v10, 0x1

    move-object v4, v12

    move-object/from16 v5, v16

    move-object v6, v11

    move-wide/from16 v7, v17

    invoke-virtual/range {v3 .. v10}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->minioFileUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Z)V

    move-object/from16 v20, v12

    move-object v12, v11

    goto :goto_1

    .line 200
    :cond_2
    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->getMFileSystemRepository()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    move-result-object v3

    .line 201
    nop

    .line 202
    nop

    .line 200
    sget-object v4, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$2;

    move-object v9, v4

    check-cast v9, Lkotlin/jvm/functions/Function1;

    .line 205
    new-instance v4, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$3;

    invoke-direct {v4, v0, v2, v1, v11}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$3;-><init>(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V

    move-object v10, v4

    check-cast v10, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 215
    nop

    .line 200
    const/16 v19, 0x1

    move-object v4, v12

    move-object/from16 v5, v16

    move-object v6, v11

    move-wide/from16 v7, v17

    move-object/from16 v20, v12

    move-object v12, v11

    .end local v11    # "category":Ljava/lang/String;
    .local v12, "category":Ljava/lang/String;
    .local v20, "logFilePath":Ljava/lang/String;
    move/from16 v11, v19

    invoke-virtual/range {v3 .. v11}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->ossFileUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLkotlin/jvm/functions/Function1;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Z)V

    .end local v16    # "tag":Ljava/lang/String;
    .end local v17    # "captureTime":J
    goto :goto_1

    .line 218
    .end local v20    # "logFilePath":Ljava/lang/String;
    .restart local v11    # "category":Ljava/lang/String;
    .local v12, "logFilePath":Ljava/lang/String;
    :cond_3
    move-object/from16 v20, v12

    move-object v12, v11

    .end local v11    # "category":Ljava/lang/String;
    .local v12, "category":Ljava/lang/String;
    .restart local v20    # "logFilePath":Ljava/lang/String;
    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    const-string v4, "MobileSdkLog.txt \u624b\u673a\u7aefSDK\u65e5\u5fd7\u6587\u4ef6\u4e0d\u5b58\u5728"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 220
    const/4 v3, 0x0

    invoke-direct {v0, v3, v2, v1, v12}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->startUploadGlassSdkLog(ZLjava/lang/String;Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V

    .line 223
    :goto_1
    return-void
.end method


# virtual methods
.method public final init()V
    .locals 2

    .line 87
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 88
    return-void
.end method

.method public final release()V
    .locals 2

    .line 313
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mUploadSDKLogCallback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 314
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 315
    return-void
.end method

.method public final uploadSDKLog(Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .locals 10
    .param p1, "callback"    # Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    const-string/jumbo v0, "\u84dd\u7259\u672a\u8fde\u63a5,\u8bf7\u5148\u8fde\u63a5\u773c\u955c\u8bbe\u5907"

    const-string v1, "callback"

    invoke-static {p1, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 93
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->mUploadSDKLogCallback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 94
    nop

    .line 96
    :try_start_0
    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isConnected()Z

    move-result v1

    if-nez v1, :cond_0

    .line 97
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->TAG:Ljava/lang/String;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 98
    const/4 v1, -0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {p1, v1, v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 99
    return-void

    .line 103
    :cond_0
    new-instance v0, Lcom/rokid/security/sdk/base/common/RequestCollectLogExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/RequestCollectLogExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$uploadSDKLog_u24lambda_u240":Lcom/rokid/security/sdk/base/common/RequestCollectLogExtra;
    const/4 v2, 0x0

    .line 104
    .local v2, "$i$a$-apply-SdkLogManager$uploadSDKLog$requestCollectLogExtra$1":I
    const-string v3, "Request_Collect_Glass_SDK_Log"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/RequestCollectLogExtra;->setMethodName(Ljava/lang/String;)V

    .line 105
    nop

    .line 103
    .end local v1    # "$this$uploadSDKLog_u24lambda_u240":Lcom/rokid/security/sdk/base/common/RequestCollectLogExtra;
    .end local v2    # "$i$a$-apply-SdkLogManager$uploadSDKLog$requestCollectLogExtra$1":I
    nop

    .line 106
    .local v0, "requestCollectLogExtra":Lcom/rokid/security/sdk/base/common/RequestCollectLogExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 107
    .local v1, "extra":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "COLLECT_SDK_LOG"

    const-string v4, "extra"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "requestCollectLogExtra":Lcom/rokid/security/sdk/base/common/RequestCollectLogExtra;
    .end local v1    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 108
    :catch_0
    move-exception v0

    .line 109
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 111
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method
