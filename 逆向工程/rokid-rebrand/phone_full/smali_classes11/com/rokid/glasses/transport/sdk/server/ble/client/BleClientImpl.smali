.class public final Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;
.super Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;
.source "BleClientImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000X\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u000cH\u0016J\u0010\u0010\r\u001a\u00020\n2\u0006\u0010\u000e\u001a\u00020\u000fH\u0016J\u0008\u0010\u0010\u001a\u00020\nH\u0016J\u0008\u0010\u0011\u001a\u00020\u0012H\u0016J\u0008\u0010\u0013\u001a\u00020\nH\u0016J\u0010\u0010\u0014\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u000cH\u0016J\u0010\u0010\u0015\u001a\u00020\n2\u0006\u0010\u0016\u001a\u00020\u0017H\u0016JX\u0010\u0018\u001a\u00020\n2\u0006\u0010\u0019\u001a\u00020\u001a2#\u0010\u001b\u001a\u001f\u0012\u0013\u0012\u00110\u001d\u00a2\u0006\u000c\u0008\u001e\u0012\u0008\u0008\u001f\u0012\u0004\u0008\u0008( \u0012\u0004\u0012\u00020\n\u0018\u00010\u001c2!\u0010!\u001a\u001d\u0012\u0013\u0012\u00110\"\u00a2\u0006\u000c\u0008\u001e\u0012\u0008\u0008\u001f\u0012\u0004\u0008\u0008(#\u0012\u0004\u0012\u00020\n0\u001cH\u0016J\u0008\u0010$\u001a\u00020\nH\u0016R\u001b\u0010\u0003\u001a\u00020\u00048BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0007\u0010\u0008\u001a\u0004\u0008\u0005\u0010\u0006\u00a8\u0006%"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;",
        "Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;",
        "()V",
        "mBleClientManager",
        "Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;",
        "getMBleClientManager",
        "()Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;",
        "mBleClientManager$delegate",
        "Lkotlin/Lazy;",
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
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

.field private static final mBleClientManager$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    .line 9
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl$mBleClientManager$2;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl$mBleClientManager$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->mBleClientManager$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;-><init>()V

    return-void
.end method

.method private final getMBleClientManager()Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;
    .locals 1

    .line 9
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->mBleClientManager$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    return-object v0
.end method


# virtual methods
.method public addBleClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 38
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->getMBleClientManager()Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->addBleClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V

    .line 39
    return-void
.end method

.method public connectToGattServer(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->getMBleClientManager()Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->connectToGattServer(Landroid/bluetooth/BluetoothDevice;)V

    .line 27
    return-void
.end method

.method public disconnect()V
    .locals 1

    .line 30
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->getMBleClientManager()Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->disconnect()V

    .line 31
    return-void
.end method

.method public isConnected()Z
    .locals 1

    .line 46
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->getMBleClientManager()Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->isConnected()Z

    move-result v0

    return v0
.end method

.method public release()V
    .locals 1

    .line 50
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->getMBleClientManager()Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->release()V

    .line 51
    return-void
.end method

.method public removeBleClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->getMBleClientManager()Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->addBleClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V

    .line 43
    return-void
.end method

.method public sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->getMBleClientManager()Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->writeCharacteristic(Ljava/lang/String;)V

    .line 35
    return-void
.end method

.method public startScan(JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
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

    .line 18
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->getMBleClientManager()Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->startScan(JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V

    .line 19
    return-void
.end method

.method public stopScan()V
    .locals 1

    .line 22
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientImpl;->getMBleClientManager()Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->stopScan()V

    .line 23
    return-void
.end method
