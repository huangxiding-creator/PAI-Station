.class public interface abstract Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;
.super Ljava/lang/Object;
.source "IBluetoothRing.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00002\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010 \n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0002\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H\u0016J\u0008\u0010\t\u001a\u00020\u0003H\u0016J\u0010\u0010\n\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\"\u0010\u000b\u001a\u00020\u00032\u000e\u0008\u0002\u0010\u000c\u001a\u0008\u0012\u0004\u0012\u00020\u000e0\r2\u0008\u0008\u0002\u0010\u000f\u001a\u00020\u0010H\u0016J\u0008\u0010\u0011\u001a\u00020\u0003H\u0016\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;",
        "",
        "addClientListener",
        "",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;",
        "connectToServer",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "disconnect",
        "removeClientListener",
        "startScan",
        "deviceNameFilter",
        "",
        "",
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
.method public abstract addClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;)V
.end method

.method public abstract connectToServer(Landroid/bluetooth/BluetoothDevice;)V
.end method

.method public abstract disconnect()V
.end method

.method public abstract removeClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;)V
.end method

.method public abstract startScan(Ljava/util/List;J)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;J)V"
        }
    .end annotation
.end method

.method public abstract stopScan()V
.end method
