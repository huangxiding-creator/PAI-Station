.class public final Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;
.super Ljava/lang/Object;
.source "FileReceiver.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000J\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0007\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0005\u0008\u0000\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0014\u001a\u00020\u0015J\u0006\u0010\u0016\u001a\u00020\u0017J\u0016\u0010\u0018\u001a\u00020\u00152\u0006\u0010\u0019\u001a\u00020\u00042\u0006\u0010\u001a\u001a\u00020\rJ\u0006\u0010\u001b\u001a\u00020\u0015R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0006X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0008\u001a\u0004\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\n\u001a\u0004\u0018\u00010\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000c\u001a\u0004\u0018\u00010\rX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000f\u001a\u00020\u0010X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0011\u001a\u00020\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0012\u001a\u0004\u0018\u00010\u0013X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;",
        "",
        "()V",
        "TAG",
        "",
        "connectTimeout",
        "",
        "ioTimeout",
        "job",
        "Lkotlinx/coroutines/Job;",
        "mFile",
        "Ljava/io/File;",
        "mListener",
        "Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;",
        "mPort",
        "progressUpdateThreshold",
        "",
        "saveDirectory",
        "socket",
        "Ljava/net/Socket;",
        "close",
        "",
        "isReceivingFile",
        "",
        "startReceiving",
        "serverIp",
        "listener",
        "stopReceiving",
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

.field private final connectTimeout:I

.field private final ioTimeout:I

.field private job:Lkotlinx/coroutines/Job;

.field private mFile:Ljava/io/File;

.field private mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

.field private mPort:I

.field private final progressUpdateThreshold:F

.field private final saveDirectory:Ljava/lang/String;

.field private socket:Ljava/net/Socket;


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    const-string v0, "FileReceiver"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->TAG:Ljava/lang/String;

    .line 20
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getP2pFileReceiverPort()I

    move-result v0

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->mPort:I

    .line 21
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    :cond_0
    if-nez v2, :cond_1

    const-string v2, ""

    :cond_1
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/receiver"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->saveDirectory:Ljava/lang/String;

    .line 26
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->progressUpdateThreshold:F

    .line 27
    const/16 v0, 0x2710

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->connectTimeout:I

    .line 28
    const/16 v0, 0x4e20

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->ioTimeout:I

    .line 18
    return-void
.end method

.method public static final synthetic access$getConnectTimeout$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    .line 18
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->connectTimeout:I

    return v0
.end method

.method public static final synthetic access$getIoTimeout$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    .line 18
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->ioTimeout:I

    return v0
.end method

.method public static final synthetic access$getMFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/io/File;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    .line 18
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->mFile:Ljava/io/File;

    return-object v0
.end method

.method public static final synthetic access$getMPort$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    .line 18
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->mPort:I

    return v0
.end method

.method public static final synthetic access$getProgressUpdateThreshold$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)F
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    .line 18
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->progressUpdateThreshold:F

    return v0
.end method

.method public static final synthetic access$getSaveDirectory$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    .line 18
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->saveDirectory:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getSocket$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/net/Socket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    .line 18
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->socket:Ljava/net/Socket;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    .line 18
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$setMFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;Ljava/io/File;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;
    .param p1, "<set-?>"    # Ljava/io/File;

    .line 18
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->mFile:Ljava/io/File;

    return-void
.end method

.method public static final synthetic access$setSocket$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;Ljava/net/Socket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;
    .param p1, "<set-?>"    # Ljava/net/Socket;

    .line 18
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->socket:Ljava/net/Socket;

    return-void
.end method


# virtual methods
.method public final close()V
    .locals 3

    .line 131
    nop

    .line 132
    const/4 v0, 0x0

    :try_start_0
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    .line 133
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->mFile:Ljava/io/File;

    .line 134
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->job:Lkotlinx/coroutines/Job;

    if-eqz v1, :cond_0

    const/4 v2, 0x1

    invoke-static {v1, v0, v2, v0}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 135
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->socket:Ljava/net/Socket;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 136
    :catch_0
    move-exception v0

    .line 137
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 139
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->TAG:Ljava/lang/String;

    const-string v1, " FileReceiver closed"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 140
    return-void
.end method

.method public final isReceivingFile()Z
    .locals 3

    .line 31
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->job:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    move v1, v2

    :cond_0
    return v1
.end method

.method public final startReceiving(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;)V
    .locals 7
    .param p1, "serverIp"    # Ljava/lang/String;
    .param p2, "listener"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    const-string/jumbo v0, "serverIp"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 37
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getP2pFileReceiverPort()I

    move-result v0

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->mPort:I

    .line 39
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->job:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    move v1, v2

    :cond_0
    if-eqz v1, :cond_1

    .line 40
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->TAG:Ljava/lang/String;

    const-string v1, "Currently receiving file, please try again later"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 41
    invoke-interface {p2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;->onFail()V

    .line 42
    return-void

    .line 44
    :cond_1
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->close()V

    .line 45
    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    .line 46
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, p1, p2, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->job:Lkotlinx/coroutines/Job;

    .line 121
    return-void
.end method

.method public final stopReceiving()V
    .locals 2

    .line 124
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "stopReceiving: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 125
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    if-eqz v0, :cond_2

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->mFile:Ljava/io/File;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    if-nez v1, :cond_1

    const-string v1, ""

    :cond_1
    invoke-interface {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;->onCancel(Ljava/lang/String;)V

    .line 126
    :cond_2
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->close()V

    .line 127
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->mFile:Ljava/io/File;

    invoke-static {v0}, Lcom/blankj/utilcode/util/FileUtils;->delete(Ljava/io/File;)Z

    .line 128
    return-void
.end method
