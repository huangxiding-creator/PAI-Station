.class public final Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;
.super Ljava/lang/Object;
.source "ApkOperator.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/filesystem/api/IApkFileOperate;


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u001a\u0010\u000f\u001a\u00020\u00102\u0006\u0010\u000b\u001a\u00020\u000c2\u0008\u0010\u0011\u001a\u0004\u0018\u00010\u000eH\u0016J\u0010\u0010\u0012\u001a\u00020\u00102\u0006\u0010\u000b\u001a\u00020\u000cH\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0005\u001a\u00020\u00068BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\t\u0010\n\u001a\u0004\u0008\u0007\u0010\u0008R\u0010\u0010\u000b\u001a\u0004\u0018\u00010\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\r\u001a\u0004\u0018\u00010\u000eX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0013"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;",
        "Lcom/rokid/security/phone/sdk/api/filesystem/api/IApkFileOperate;",
        "()V",
        "TAG",
        "",
        "apkSender",
        "Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;",
        "getApkSender",
        "()Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;",
        "apkSender$delegate",
        "Lkotlin/Lazy;",
        "file",
        "Ljava/io/File;",
        "mListener",
        "Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;",
        "sendFile",
        "",
        "listener",
        "startSendApk",
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

.field private final apkSender$delegate:Lkotlin/Lazy;

.field private file:Ljava/io/File;

.field private mListener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 10
    const-string v0, "ApkOperator"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->TAG:Ljava/lang/String;

    .line 11
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$apkSender$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$apkSender$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->apkSender$delegate:Lkotlin/Lazy;

    .line 9
    return-void
.end method

.method public static final synthetic access$getApkSender(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;)Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    .line 9
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->getApkSender()Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getMListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;)Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    .line 9
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->mListener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    .line 9
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$setFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;Ljava/io/File;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;
    .param p1, "<set-?>"    # Ljava/io/File;

    .line 9
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->file:Ljava/io/File;

    return-void
.end method

.method public static final synthetic access$setMListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    .line 9
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->mListener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    return-void
.end method

.method public static final synthetic access$startSendApk(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;Ljava/io/File;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;
    .param p1, "file"    # Ljava/io/File;

    .line 9
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->startSendApk(Ljava/io/File;)V

    return-void
.end method

.method private final getApkSender()Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->apkSender$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    return-object v0
.end method

.method private final startSendApk(Ljava/io/File;)V
    .locals 2
    .param p1, "file"    # Ljava/io/File;

    .line 39
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;

    invoke-direct {v1, p0, p1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;Ljava/io/File;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V

    .line 53
    return-void
.end method


# virtual methods
.method public sendFile(Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;)V
    .locals 2
    .param p1, "file"    # Ljava/io/File;
    .param p2, "listener"    # Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    const-string v0, "file"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendApk"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 21
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    .line 22
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "send APK: file not exist"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 23
    if-eqz p2, :cond_0

    const-string v0, "file not exist"

    invoke-interface {p2, v0}, Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;->onError(Ljava/lang/String;)V

    .line 24
    :cond_0
    return-void

    .line 26
    :cond_1
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;

    invoke-direct {v1, p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$sendFile$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect(Lkotlin/jvm/functions/Function1;)V

    .line 36
    return-void
.end method
