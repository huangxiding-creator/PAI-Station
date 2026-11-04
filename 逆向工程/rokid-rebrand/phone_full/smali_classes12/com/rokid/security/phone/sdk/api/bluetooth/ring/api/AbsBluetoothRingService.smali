.class public abstract Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/AbsBluetoothRingService;
.super Lcom/rokid/security/phone/sdk/api/base/MicroCaseService;
.source "AbsBluetoothRingService.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0010\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008&\u0018\u00002\u00020\u00012\u00020\u0002B\u0005\u00a2\u0006\u0002\u0010\u0003\u00a8\u0006\u0004"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/AbsBluetoothRingService;",
        "Lcom/rokid/security/phone/sdk/api/base/MicroCaseService;",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;",
        "()V",
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


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/base/MicroCaseService;-><init>()V

    return-void
.end method


# virtual methods
.method public addClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;

    .line 12
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing$DefaultImpls;->addClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;)V

    return-void
.end method

.method public connectToServer(Landroid/bluetooth/BluetoothDevice;)V
    .locals 0
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .line 12
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing$DefaultImpls;->connectToServer(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;Landroid/bluetooth/BluetoothDevice;)V

    return-void
.end method

.method public disconnect()V
    .locals 0

    .line 12
    invoke-static {p0}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing$DefaultImpls;->disconnect(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;)V

    return-void
.end method

.method public removeClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;

    .line 12
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing$DefaultImpls;->removeClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;)V

    return-void
.end method

.method public startScan(Ljava/util/List;J)V
    .locals 0
    .param p1, "deviceNameFilter"    # Ljava/util/List;
    .param p2, "timeoutMillis"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;J)V"
        }
    .end annotation

    .line 12
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing$DefaultImpls;->startScan(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;Ljava/util/List;J)V

    return-void
.end method

.method public stopScan()V
    .locals 0

    .line 12
    invoke-static {p0}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing$DefaultImpls;->stopScan(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;)V

    return-void
.end method
