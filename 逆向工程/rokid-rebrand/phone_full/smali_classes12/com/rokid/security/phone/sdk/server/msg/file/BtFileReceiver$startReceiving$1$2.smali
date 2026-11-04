.class public final Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;
.super Ljava/lang/Object;
.source "BtFileReceiver.kt"

# interfaces
.implements Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\'\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0010\u0007\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016J\u0010\u0010\u0008\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016J\u0008\u0010\t\u001a\u00020\u0005H\u0016J\u0018\u0010\n\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u000b\u001a\u00020\u000cH\u0016J\u0010\u0010\r\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000e"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;",
        "lastProgressTime",
        "",
        "onCancel",
        "",
        "filePath",
        "",
        "onComplete",
        "onFail",
        "onProgressChanged",
        "progress",
        "",
        "onStart",
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
.field final synthetic $listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

.field private lastProgressTime:J

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;
    .param p2, "$listener"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->$listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Ljava/lang/String;)V
    .locals 3
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 60
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onCancel: filePath = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 61
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->setFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V

    .line 62
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->access$isReceiving$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 63
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->$listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    invoke-interface {v0, p1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;->onCancel(Ljava/lang/String;)V

    .line 64
    return-void
.end method

.method public onComplete(Ljava/lang/String;)V
    .locals 3
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 67
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onComplete: filePath = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 68
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->setFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V

    .line 69
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->access$isReceiving$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 70
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->$listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    invoke-interface {v0, p1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;->onComplete(Ljava/lang/String;)V

    .line 71
    return-void
.end method

.method public onFail()V
    .locals 2

    .line 74
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "onFail: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 75
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->setFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V

    .line 76
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->access$isReceiving$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 77
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->$listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    invoke-interface {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;->onFail()V

    .line 78
    return-void
.end method

.method public onProgressChanged(Ljava/lang/String;F)V
    .locals 7
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "progress"    # F

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 83
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onProgressChanged: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", filePath = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 84
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 87
    .local v0, "currentTime":J
    iget-wide v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->lastProgressTime:J

    sub-long v3, v0, v3

    const-wide/16 v5, 0x64

    cmp-long v3, v3, v5

    if-ltz v3, :cond_1

    .line 88
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->access$getMListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-interface {v3, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;->onProgressChanged(Ljava/lang/String;F)V

    .line 89
    :cond_0
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "onProgressChanged2: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 91
    iput-wide v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->lastProgressTime:J

    .line 93
    :cond_1
    return-void
.end method

.method public onStart(Ljava/lang/String;)V
    .locals 3
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 96
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onStart: \u5f00\u59cb\u63a5\u53d7\u6587\u4ef6: filePath = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 97
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->access$isReceiving$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 98
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver$startReceiving$1$2;->$listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    invoke-interface {v0, p1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;->onStart(Ljava/lang/String;)V

    .line 99
    return-void
.end method
