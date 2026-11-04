.class public final Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mIClassicClientListener$1;
.super Ljava/lang/Object;
.source "AuthServiceImpl.kt"

# interfaces
.implements Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00007\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0008*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H\u0016J\u0018\u0010\t\u001a\u00020\u00032\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\rH\u0016J\u0010\u0010\u000e\u001a\u00020\u00032\u0006\u0010\u000f\u001a\u00020\u0010H\u0016J\u0010\u0010\u0011\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0012\u001a\u00020\u00032\u0006\u0010\u0013\u001a\u00020\u000bH\u0016J\u0008\u0010\u0014\u001a\u00020\u0003H\u0016J \u0010\u0015\u001a\u00020\u00032\u0006\u0010\u0016\u001a\u00020\u000b2\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0017\u001a\u00020\u000bH\u0016\u00a8\u0006\u0018"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/auth/AuthServiceImpl$mIClassicClientListener$1",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;",
        "onAudioReceived",
        "",
        "data",
        "",
        "onConnect",
        "state",
        "",
        "onConnectionRejected",
        "reason",
        "",
        "code",
        "",
        "onDeviceFound",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "onFileReceived",
        "onMessageReceived",
        "message",
        "onScanFinished",
        "onStreamReceived",
        "tag",
        "clientId",
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

    .line 204
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioReceived([B)V
    .locals 1
    .param p1, "data"    # [B

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 207
    return-void
.end method

.method public onConnect(Z)V
    .locals 2
    .param p1, "state"    # Z

    .line 210
    if-nez p1, :cond_0

    .line 211
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->access$setAuthSuccess$p(Z)V

    .line 212
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->access$setMPubKeyInfo$p(Lcom/rokid/security/sdk/base/common/auth/PubKeyInfo;)V

    .line 213
    sget-object v1, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->access$setSessionKey$p([B)V

    .line 215
    :cond_0
    return-void
.end method

.method public onConnectionRejected(Ljava/lang/String;I)V
    .locals 1
    .param p1, "reason"    # Ljava/lang/String;
    .param p2, "code"    # I

    const-string v0, "reason"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 219
    return-void
.end method

.method public onDeviceFound(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 223
    return-void
.end method

.method public onFileReceived([B)V
    .locals 1
    .param p1, "data"    # [B

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 227
    return-void
.end method

.method public onMessageReceived(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 231
    return-void
.end method

.method public onScanFinished()V
    .locals 0

    .line 235
    return-void
.end method

.method public onStreamReceived(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 239
    return-void
.end method
