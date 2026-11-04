.class public final Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;
.super Ljava/lang/Object;
.source "BleClientWrapper.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000V\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0006\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eJ\u000e\u0010\u000f\u001a\u00020\u000c2\u0006\u0010\u0010\u001a\u00020\u0011J\u0006\u0010\u0012\u001a\u00020\u000cJ\u0006\u0010\u0013\u001a\u00020\u0014J\u0006\u0010\u0015\u001a\u00020\u000cJ\u000e\u0010\u0016\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eJ\u000e\u0010\u0017\u001a\u00020\u000c2\u0006\u0010\u0018\u001a\u00020\u0004JX\u0010\u0019\u001a\u00020\u000c2\u0006\u0010\u001a\u001a\u00020\u001b2%\u0008\u0002\u0010\u001c\u001a\u001f\u0012\u0013\u0012\u00110\u001e\u00a2\u0006\u000c\u0008\u001f\u0012\u0008\u0008 \u0012\u0004\u0008\u0008(!\u0012\u0004\u0012\u00020\u000c\u0018\u00010\u001d2!\u0010\"\u001a\u001d\u0012\u0013\u0012\u00110#\u00a2\u0006\u000c\u0008\u001f\u0012\u0008\u0008 \u0012\u0004\u0008\u0008($\u0012\u0004\u0012\u00020\u000c0\u001dJ\u0006\u0010%\u001a\u00020\u000cR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u001d\u0010\u0005\u001a\u0004\u0018\u00010\u00068BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\t\u0010\n\u001a\u0004\u0008\u0007\u0010\u0008\u00a8\u0006&"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;",
        "",
        "()V",
        "TAG",
        "",
        "mAbsBleClientService",
        "Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;",
        "getMAbsBleClientService",
        "()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;",
        "mAbsBleClientService$delegate",
        "Lkotlin/Lazy;",
        "addClientListener",
        "",
        "listener",
        "Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;",
        "connectToServer",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "disconnect",
        "isConnected",
        "",
        "release",
        "removeClientListener",
        "sendTextMessage",
        "data",
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


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;

.field private static final TAG:Ljava/lang/String; = "ClassicBTClientWrapper"

.field private static final mAbsBleClientService$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;

    .line 17
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper$mAbsBleClientService$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper$mAbsBleClientService$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->mAbsBleClientService$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final getMAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;
    .locals 1

    .line 17
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->mAbsBleClientService$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;

    return-object v0
.end method

.method public static synthetic startScan$default(Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 24
    and-int/lit8 p5, p5, 0x2

    if-eqz p5, :cond_0

    const/4 p3, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->startScan(JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V

    return-void
.end method


# virtual methods
.method public final addClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 48
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->getMAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;->addBleClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V

    .line 49
    :cond_0
    return-void
.end method

.method public final connectToServer(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->getMAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;->connectToGattServer(Landroid/bluetooth/BluetoothDevice;)V

    .line 35
    :cond_0
    return-void
.end method

.method public final disconnect()V
    .locals 1

    .line 38
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->getMAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;->disconnect()V

    .line 39
    :cond_0
    return-void
.end method

.method public final isConnected()Z
    .locals 3

    .line 56
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->getMAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;->isConnected()Z

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    move v1, v2

    :cond_0
    return v1
.end method

.method public final release()V
    .locals 1

    .line 60
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->getMAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;->release()V

    .line 61
    :cond_0
    return-void
.end method

.method public final removeClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->getMAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;->removeBleClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V

    .line 53
    :cond_0
    return-void
.end method

.method public final sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->getMAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;->sendTextMessage(Ljava/lang/String;)V

    .line 43
    :cond_0
    return-void
.end method

.method public final startScan(JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "timeoutMillis"    # J
    .param p3, "fail"    # Lkotlin/jvm/functions/Function1;
    .param p4, "onScanResult"    # Lkotlin/jvm/functions/Function1;
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

    const-string v0, "onScanResult"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->getMAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;->startScan(JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V

    .line 27
    :cond_0
    return-void
.end method

.method public final stopScan()V
    .locals 1

    .line 30
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->getMAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;->stopScan()V

    .line 31
    :cond_0
    return-void
.end method
