.class public final Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing$DefaultImpls;
.super Ljava/lang/Object;
.source "IBluetoothRing.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DefaultImpls"
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static addClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    return-void
.end method

.method public static connectToServer(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;Landroid/bluetooth/BluetoothDevice;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 32
    return-void
.end method

.method public static disconnect(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;

    .line 37
    return-void
.end method

.method public static removeClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 48
    return-void
.end method

.method public static startScan(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;Ljava/util/List;J)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;
    .param p1, "deviceNameFilter"    # Ljava/util/List;
    .param p2, "timeoutMillis"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;J)V"
        }
    .end annotation

    const-string v0, "deviceNameFilter"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    return-void
.end method

.method public static synthetic startScan$default(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;Ljava/util/List;JILjava/lang/Object;)V
    .locals 0

    .line 18
    if-nez p5, :cond_2

    and-int/lit8 p5, p4, 0x1

    if-eqz p5, :cond_0

    .line 19
    const-string p1, "D01"

    invoke-static {p1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    .line 18
    :cond_0
    and-int/lit8 p4, p4, 0x2

    if-eqz p4, :cond_1

    .line 20
    const-wide/16 p2, 0x4e20

    .line 18
    :cond_1
    invoke-interface {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;->startScan(Ljava/util/List;J)V

    return-void

    :cond_2
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: startScan"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static stopScan(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBluetoothRing;

    .line 26
    return-void
.end method
