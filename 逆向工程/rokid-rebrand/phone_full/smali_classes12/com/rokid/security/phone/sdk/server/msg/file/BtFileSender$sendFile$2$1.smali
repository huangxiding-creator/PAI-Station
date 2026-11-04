.class public final Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;
.super Ljava/lang/Object;
.source "BtFileSender.kt"

# interfaces
.implements Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0007\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0008\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0006\u001a\u00020\u0005H\u0016J\u0010\u0010\u0007\u001a\u00020\u00052\u0006\u0010\u0008\u001a\u00020\tH\u0016J\u0008\u0010\n\u001a\u00020\u0005H\u0016R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000b"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;",
        "lastProgressTime",
        "",
        "onComplete",
        "",
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
.field final synthetic $appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

.field final synthetic $file:Ljava/io/File;

.field final synthetic $generation:J

.field final synthetic $onResult:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field private lastProgressTime:J

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Ljava/io/File;Lkotlin/jvm/functions/Function1;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;
    .param p2, "$generation"    # J
    .param p4, "$appListener"    # Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .param p5, "$file"    # Ljava/io/File;
    .param p6, "$onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;",
            "J",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            "Ljava/io/File;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iput-wide p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$generation:J

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$file:Ljava/io/File;

    iput-object p6, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$onResult:Lkotlin/jvm/functions/Function1;

    .line 62
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel()V
    .locals 0

    .line 62
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener$DefaultImpls;->onCancel(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V

    return-void
.end method

.method public onComplete()V
    .locals 7

    .line 83
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$generation:J

    invoke-static {v0, v1, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$isCurrent(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;J)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 84
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$isSending$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 85
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    .line 87
    .local v0, "path":Ljava/lang/String;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$generation:J

    new-instance v4, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onComplete$1;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$onResult:Lkotlin/jvm/functions/Function1;

    invoke-direct {v4, v5, v0, v6}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onComplete$1;-><init>(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Ljava/lang/String;Lkotlin/jvm/functions/Function1;)V

    check-cast v4, Lkotlin/jvm/functions/Function0;

    invoke-static {v1, v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$notifyApp(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLkotlin/jvm/functions/Function0;)V

    .line 91
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "onComplete: transport"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 92
    return-void
.end method

.method public onFail()V
    .locals 6

    .line 95
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$generation:J

    invoke-static {v0, v1, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$isCurrent(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;J)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 96
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$isSending$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 97
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$generation:J

    new-instance v3, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onFail$1;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$onResult:Lkotlin/jvm/functions/Function1;

    invoke-direct {v3, v4, v5}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onFail$1;-><init>(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V

    check-cast v3, Lkotlin/jvm/functions/Function0;

    invoke-static {v0, v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$notifyApp(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLkotlin/jvm/functions/Function0;)V

    .line 101
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u53d1\u9001\u6587\u4ef6\u5931\u8d25: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 102
    return-void
.end method

.method public onProgressChanged(F)V
    .locals 7
    .param p1, "progress"    # F

    .line 73
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$generation:J

    invoke-static {v0, v1, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$isCurrent(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;J)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 74
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 75
    .local v0, "currentTime":J
    iget-wide v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->lastProgressTime:J

    sub-long v2, v0, v2

    const-wide/16 v4, 0x64

    cmp-long v2, v2, v4

    if-ltz v2, :cond_1

    .line 76
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$generation:J

    new-instance v5, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onProgressChanged$1;

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    invoke-direct {v5, v6, p1}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onProgressChanged$1;-><init>(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;F)V

    check-cast v5, Lkotlin/jvm/functions/Function0;

    invoke-static {v2, v3, v4, v5}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$notifyApp(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLkotlin/jvm/functions/Function0;)V

    .line 77
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onProgressChanged: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 78
    iput-wide v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->lastProgressTime:J

    .line 80
    :cond_1
    return-void
.end method

.method public onStart()V
    .locals 5

    .line 64
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$generation:J

    invoke-static {v0, v1, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$isCurrent(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;J)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 65
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$isSending$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 66
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$generation:J

    new-instance v3, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onStart$1;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    invoke-direct {v3, v4}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onStart$1;-><init>(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V

    check-cast v3, Lkotlin/jvm/functions/Function0;

    invoke-static {v0, v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$notifyApp(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLkotlin/jvm/functions/Function0;)V

    .line 67
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "onStart: transport"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 68
    return-void
.end method
