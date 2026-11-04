.class public final Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;
.super Ljava/lang/Object;
.source "BtFileReceiver.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000F\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0008\u0008\u0000\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0012\u001a\u00020\u0013J\u0006\u0010\u0014\u001a\u00020\u0015J\u0016\u0010\u0016\u001a\u00020\u00132\u0006\u0010\u0017\u001a\u00020\u00042\u0006\u0010\u0018\u001a\u00020\u0006J\u0006\u0010\u0019\u001a\u00020\u0013J\u000e\u0010\u001a\u001a\u00020\u00132\u0006\u0010\u001b\u001a\u00020\u000eJ\u0006\u0010\u001c\u001a\u00020\u0013R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000b\u001a\u0004\u0018\u00010\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\r\u001a\u0004\u0018\u00010\u000eX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000f\u001a\u00020\u0010X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0011\u001a\u00020\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001d"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;",
        "",
        "()V",
        "TAG",
        "",
        "fileLength",
        "",
        "isReceiving",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "job",
        "Lkotlinx/coroutines/Job;",
        "mFile",
        "Ljava/io/File;",
        "mListener",
        "Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;",
        "mPort",
        "",
        "saveDirectory",
        "close",
        "",
        "isReceivingFile",
        "",
        "onReceivingMateData",
        "fileName",
        "length",
        "resetReceiveState",
        "startReceiving",
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

.field private fileLength:J

.field private final isReceiving:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private job:Lkotlinx/coroutines/Job;

.field private mFile:Ljava/io/File;

.field private mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

.field private final mPort:I

.field private final saveDirectory:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    const-string v0, "BtFileReceiver"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->TAG:Ljava/lang/String;

    .line 18
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getP2pFileReceiverPort()I

    move-result v0

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->mPort:I

    .line 19
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

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->saveDirectory:Ljava/lang/String;

    .line 25
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->isReceiving:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 16
    return-void
.end method

.method public static final synthetic access$getMFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/io/File;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    .line 16
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->mFile:Ljava/io/File;

    return-object v0
.end method

.method public static final synthetic access$getMListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    .line 16
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    return-object v0
.end method

.method public static final synthetic access$getSaveDirectory$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    .line 16
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->saveDirectory:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    .line 16
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$isReceiving$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    .line 16
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->isReceiving:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method


# virtual methods
.method public final close()V
    .locals 3

    .line 131
    nop

    .line 132
    :try_start_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->setFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V

    .line 133
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->isReceiving:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 134
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->mFile:Ljava/io/File;

    .line 135
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    .line 136
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->job:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 137
    :catch_0
    move-exception v0

    .line 138
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 140
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->TAG:Ljava/lang/String;

    const-string v1, "close: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 141
    return-void
.end method

.method public final isReceivingFile()Z
    .locals 1

    .line 28
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->isReceiving:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    return v0
.end method

.method public final onReceivingMateData(Ljava/lang/String;J)V
    .locals 4
    .param p1, "fileName"    # Ljava/lang/String;
    .param p2, "length"    # J

    const-string v0, "fileName"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 113
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->saveDirectory:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x2f

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v1, v0

    .local v1, "$this$onReceivingMateData_u24lambda_u240":Ljava/io/File;
    const/4 v2, 0x0

    .line 114
    .local v2, "$i$a$-apply-BtFileReceiver$onReceivingMateData$1":I
    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    .line 115
    :cond_0
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    .line 116
    :cond_1
    nop

    .line 113
    .end local v1    # "$this$onReceivingMateData_u24lambda_u240":Ljava/io/File;
    .end local v2    # "$i$a$-apply-BtFileReceiver$onReceivingMateData$1":I
    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->mFile:Ljava/io/File;

    .line 117
    iput-wide p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->fileLength:J

    .line 118
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " startReceiving: filePath = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->mFile:Ljava/io/File;

    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_2
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 119
    return-void
.end method

.method public final resetReceiveState()V
    .locals 2

    .line 32
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->TAG:Ljava/lang/String;

    const-string v1, "resetReceiveState: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 33
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->isReceiving:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 34
    return-void
.end method

.method public final startReceiving(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;)V
    .locals 7
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 41
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "startReceiving:  isReceiving = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->isReceiving:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 42
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->isReceiving:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 43
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->TAG:Ljava/lang/String;

    const-string v1, "Currently receiving file, please try again later"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 44
    invoke-interface {p1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;->onFail()V

    .line 45
    return-void

    .line 47
    :cond_0
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->close()V

    .line 48
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    .line 49
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, p1, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->job:Lkotlinx/coroutines/Job;

    .line 109
    return-void
.end method

.method public final stopReceiving()V
    .locals 2

    .line 124
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->mListener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    if-eqz v0, :cond_2

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->mFile:Ljava/io/File;

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

    .line 125
    :cond_2
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->close()V

    .line 126
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->mFile:Ljava/io/File;

    invoke-static {v0}, Lcom/blankj/utilcode/util/FileUtils;->delete(Ljava/io/File;)Z

    .line 127
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->TAG:Ljava/lang/String;

    const-string v1, " stopReceiving: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 128
    return-void
.end method
