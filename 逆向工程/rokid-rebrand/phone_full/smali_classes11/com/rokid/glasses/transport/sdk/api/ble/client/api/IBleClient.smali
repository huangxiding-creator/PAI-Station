.class public interface abstract Lcom/rokid/glasses/transport/sdk/api/ble/client/api/IBleClient;
.super Ljava/lang/Object;
.source "IBleClient.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/api/ble/client/api/IBleClient$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000N\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H&J\u0008\u0010\t\u001a\u00020\u0003H&J\u0008\u0010\n\u001a\u00020\u000bH&J\u0008\u0010\u000c\u001a\u00020\u0003H&J\u0010\u0010\r\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0010\u0010\u000e\u001a\u00020\u00032\u0006\u0010\u000f\u001a\u00020\u0010H&J\\\u0010\u0011\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0012\u001a\u00020\u00132%\u0008\u0002\u0010\u0014\u001a\u001f\u0012\u0013\u0012\u00110\u0016\u00a2\u0006\u000c\u0008\u0017\u0012\u0008\u0008\u0018\u0012\u0004\u0008\u0008(\u0019\u0012\u0004\u0012\u00020\u0003\u0018\u00010\u00152!\u0010\u001a\u001a\u001d\u0012\u0013\u0012\u00110\u001b\u00a2\u0006\u000c\u0008\u0017\u0012\u0008\u0008\u0018\u0012\u0004\u0008\u0008(\u001c\u0012\u0004\u0012\u00020\u00030\u0015H&J\u0008\u0010\u001d\u001a\u00020\u0003H&\u00a8\u0006\u001e"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/ble/client/api/IBleClient;",
        "",
        "addBleClientListener",
        "",
        "listener",
        "Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;",
        "connectToGattServer",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "disconnect",
        "isConnected",
        "",
        "release",
        "removeBleClientListener",
        "sendTextMessage",
        "data",
        "",
        "startScan",
        "timeoutMillis",
        "",
        "fail",
        "Lkotlin/Function1;",
        "",
        "Lkotlin/ParameterName;",
        "name",
        "errorCode",
        "onScanResult",
        "Landroid/bluetooth/le/ScanResult;",
        "result",
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
.method public abstract addBleClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V
.end method

.method public abstract connectToGattServer(Landroid/bluetooth/BluetoothDevice;)V
.end method

.method public abstract disconnect()V
.end method

.method public abstract isConnected()Z
.end method

.method public abstract release()V
.end method

.method public abstract removeBleClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V
.end method

.method public abstract sendTextMessage(Ljava/lang/String;)V
.end method

.method public abstract startScan(JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Integer;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Landroid/bluetooth/le/ScanResult;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract stopScan()V
.end method
