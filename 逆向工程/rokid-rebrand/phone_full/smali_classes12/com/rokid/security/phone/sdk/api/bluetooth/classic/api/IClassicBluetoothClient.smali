.class public interface abstract Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/IClassicBluetoothClient;
.super Ljava/lang/Object;
.source "IClassicBluetoothClient.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/IClassicBluetoothClient$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00006\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u000b\n\u0002\u0010\t\n\u0002\u0008\u0002\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J3\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u00082!\u0010\t\u001a\u001d\u0012\u0013\u0012\u00110\u000b\u00a2\u0006\u000c\u0008\u000c\u0012\u0008\u0008\r\u0012\u0004\u0008\u0008(\u000e\u0012\u0004\u0012\u00020\u00030\nH&J\u0008\u0010\u000f\u001a\u00020\u0003H&J\u0008\u0010\u0010\u001a\u00020\u000bH&J\u0008\u0010\u0011\u001a\u00020\u000bH&J\u0008\u0010\u0012\u001a\u00020\u000bH&J\u0008\u0010\u0013\u001a\u00020\u000bH&J\u0008\u0010\u0014\u001a\u00020\u000bH&J\u0010\u0010\u0015\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0012\u0010\u0016\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0017\u001a\u00020\u0018H&J\u0008\u0010\u0019\u001a\u00020\u0003H&\u00a8\u0006\u001a"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/IClassicBluetoothClient;",
        "",
        "addClientListener",
        "",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;",
        "connectToServer",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "action",
        "Lkotlin/Function1;",
        "",
        "Lkotlin/ParameterName;",
        "name",
        "isConnect",
        "disconnect",
        "isAudioChanelConnect",
        "isConnected",
        "isFileChanelConnect",
        "isMessageChanelConnect",
        "isStreamChanelConnect",
        "removeClientListener",
        "startScan",
        "timeoutMillis",
        "",
        "stopScan",
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
.method public abstract addClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;)V
.end method

.method public abstract connectToServer(Landroid/bluetooth/BluetoothDevice;Lkotlin/jvm/functions/Function1;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/bluetooth/BluetoothDevice;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract disconnect()V
.end method

.method public abstract isAudioChanelConnect()Z
.end method

.method public abstract isConnected()Z
.end method

.method public abstract isFileChanelConnect()Z
.end method

.method public abstract isMessageChanelConnect()Z
.end method

.method public abstract isStreamChanelConnect()Z
.end method

.method public abstract removeClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;)V
.end method

.method public abstract startScan(J)V
.end method

.method public abstract stopScan()V
.end method
