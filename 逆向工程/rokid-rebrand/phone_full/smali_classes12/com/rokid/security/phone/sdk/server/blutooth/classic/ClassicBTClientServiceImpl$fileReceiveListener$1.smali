.class public final Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$fileReceiveListener$1;
.super Ljava/lang/Object;
.source "ClassicBTClientServiceImpl.kt"

# interfaces
.implements Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0010\u0007\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0007\u001a\u00020\u0003H\u0016J\u0018\u0010\u0008\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\t\u001a\u00020\nH\u0016J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$fileReceiveListener$1",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;",
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


# direct methods
.method constructor <init>()V
    .locals 0

    .line 384
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Ljava/lang/String;)V
    .locals 1
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 386
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMFileReceiveListener$p()Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onCancel(Ljava/lang/String;)V

    .line 387
    :cond_0
    return-void
.end method

.method public onComplete(Ljava/lang/String;)V
    .locals 1
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 390
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMFileReceiveListener$p()Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onComplete(Ljava/lang/String;)V

    .line 391
    :cond_0
    return-void
.end method

.method public onFail()V
    .locals 1

    .line 394
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMFileReceiveListener$p()Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onFail()V

    .line 395
    :cond_0
    return-void
.end method

.method public onProgressChanged(Ljava/lang/String;F)V
    .locals 1
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "progress"    # F

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 398
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMFileReceiveListener$p()Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1, p2}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onProgressChanged(Ljava/lang/String;F)V

    .line 399
    :cond_0
    return-void
.end method

.method public onStart(Ljava/lang/String;)V
    .locals 1
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 402
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMFileReceiveListener$p()Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onStart(Ljava/lang/String;)V

    .line 403
    :cond_0
    return-void
.end method
