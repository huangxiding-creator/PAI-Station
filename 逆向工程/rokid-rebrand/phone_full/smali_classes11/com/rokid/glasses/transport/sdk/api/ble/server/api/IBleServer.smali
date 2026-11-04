.class public interface abstract Lcom/rokid/glasses/transport/sdk/api/ble/server/api/IBleServer;
.super Ljava/lang/Object;
.source "IBleServer.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0002\u0008\u0003\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u000e\u0010\u0006\u001a\u0008\u0012\u0004\u0012\u00020\u00080\u0007H&J\u0010\u0010\t\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0010\u0010\n\u001a\u00020\u00032\u0006\u0010\u000b\u001a\u00020\u000cH&J\u0008\u0010\r\u001a\u00020\u0003H&J\u0008\u0010\u000e\u001a\u00020\u0003H&\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/ble/server/api/IBleServer;",
        "",
        "addBleServerListener",
        "",
        "listener",
        "Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;",
        "getConnectDevices",
        "",
        "Landroid/bluetooth/BluetoothDevice;",
        "removeBleServerListener",
        "sendTextMessage",
        "msg",
        "",
        "startBleService",
        "stopBleService",
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
.method public abstract addBleServerListener(Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;)V
.end method

.method public abstract getConnectDevices()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/bluetooth/BluetoothDevice;",
            ">;"
        }
    .end annotation
.end method

.method public abstract removeBleServerListener(Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;)V
.end method

.method public abstract sendTextMessage(Ljava/lang/String;)V
.end method

.method public abstract startBleService()V
.end method

.method public abstract stopBleService()V
.end method
