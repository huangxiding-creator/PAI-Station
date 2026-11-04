.class public interface abstract Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
.super Ljava/lang/Object;
.source "IClassicClientListener.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00006\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0008\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H&J\u0018\u0010\t\u001a\u00020\u00032\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\rH&J\u0010\u0010\u000e\u001a\u00020\u00032\u0006\u0010\u000f\u001a\u00020\u0010H&J\u0010\u0010\u0011\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0010\u0010\u0012\u001a\u00020\u00032\u0006\u0010\u0013\u001a\u00020\u000bH&J\u0008\u0010\u0014\u001a\u00020\u0003H&J \u0010\u0015\u001a\u00020\u00032\u0006\u0010\u0016\u001a\u00020\u000b2\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0017\u001a\u00020\u000bH&\u00a8\u0006\u0018"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;",
        "",
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
        "sdk-api_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# virtual methods
.method public abstract onAudioReceived([B)V
.end method

.method public abstract onConnect(Z)V
.end method

.method public abstract onConnectionRejected(Ljava/lang/String;I)V
.end method

.method public abstract onDeviceFound(Landroid/bluetooth/BluetoothDevice;)V
.end method

.method public abstract onFileReceived([B)V
.end method

.method public abstract onMessageReceived(Ljava/lang/String;)V
.end method

.method public abstract onScanFinished()V
.end method

.method public abstract onStreamReceived(Ljava/lang/String;[BLjava/lang/String;)V
.end method
