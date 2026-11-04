.class public final Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;
.super Ljava/lang/Object;
.source "BleClientManager.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u00a5\u0001\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010#\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0005*\u0001\u001b\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010/\u001a\u0002002\u0006\u00101\u001a\u00020!J\u0008\u00102\u001a\u00020\u001eH\u0002J\u0010\u00103\u001a\u0002002\u0006\u00104\u001a\u000205H\u0007J\u0008\u00106\u001a\u000200H\u0007J\u0008\u00107\u001a\u00020\u001eH\u0002J\u0008\u00108\u001a\u00020\u001eH\u0002J\u0006\u0010\u001d\u001a\u00020\u001eJ\u001c\u00109\u001a\u0002002\u0008\u0010:\u001a\u0004\u0018\u00010\u000f2\u0008\u0010;\u001a\u0004\u0018\u00010<H\u0003J\u0006\u0010=\u001a\u000200J\u000e\u0010>\u001a\u0002002\u0006\u00101\u001a\u00020!J\\\u0010?\u001a\u0002002\u0008\u0008\u0002\u0010@\u001a\u00020A2%\u0008\u0002\u0010B\u001a\u001f\u0012\u0013\u0012\u00110D\u00a2\u0006\u000c\u0008E\u0012\u0008\u0008F\u0012\u0004\u0008\u0008(G\u0012\u0004\u0012\u000200\u0018\u00010C2!\u0010H\u001a\u001d\u0012\u0013\u0012\u00110I\u00a2\u0006\u000c\u0008E\u0012\u0008\u0008F\u0012\u0004\u0008\u0008(J\u0012\u0004\u0012\u0002000CH\u0007J\u0008\u0010K\u001a\u000200H\u0007J\u0010\u0010L\u001a\u0002002\u0006\u0010M\u001a\u00020\tH\u0007R\u0016\u0010\u0003\u001a\n \u0005*\u0004\u0018\u00010\u00040\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u0006\u001a\n \u0005*\u0004\u0018\u00010\u00040\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u0007\u001a\n \u0005*\u0004\u0018\u00010\u00040\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\tX\u0082D\u00a2\u0006\u0002\n\u0000R\u0016\u0010\n\u001a\u0004\u0018\u00010\u000b8BX\u0082\u0004\u00a2\u0006\u0006\u001a\u0004\u0008\u000c\u0010\rR\u0010\u0010\u000e\u001a\u0004\u0018\u00010\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u0010\u001a\u0004\u0018\u00010\u00118BX\u0082\u0004\u00a2\u0006\u0006\u001a\u0004\u0008\u0012\u0010\u0013R#\u0010\u0014\u001a\n \u0005*\u0004\u0018\u00010\u00150\u00158BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0018\u0010\u0019\u001a\u0004\u0008\u0016\u0010\u0017R\u0010\u0010\u001a\u001a\u00020\u001bX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u001cR\u000e\u0010\u001d\u001a\u00020\u001eX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u001f\u001a\u0008\u0012\u0004\u0012\u00020!0 X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\"\u001a\u0008\u0012\u0004\u0012\u00020!0#X\u0082\u0004\u00a2\u0006\u0002\n\u0000R#\u0010$\u001a\n \u0005*\u0004\u0018\u00010%0%8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008(\u0010\u0019\u001a\u0004\u0008&\u0010\'R\u000e\u0010)\u001a\u00020*X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010+\u001a\u0004\u0018\u00010,X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010-\u001a\u00020.X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006N"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;",
        "",
        "()V",
        "CCCD_UUID",
        "Ljava/util/UUID;",
        "kotlin.jvm.PlatformType",
        "CHARACTERISTIC_UUID",
        "SERVICE_UUID",
        "TAG",
        "",
        "bluetoothAdapter",
        "Landroid/bluetooth/BluetoothAdapter;",
        "getBluetoothAdapter",
        "()Landroid/bluetooth/BluetoothAdapter;",
        "bluetoothGatt",
        "Landroid/bluetooth/BluetoothGatt;",
        "bluetoothLeScanner",
        "Landroid/bluetooth/le/BluetoothLeScanner;",
        "getBluetoothLeScanner",
        "()Landroid/bluetooth/le/BluetoothLeScanner;",
        "bluetoothManager",
        "Landroid/bluetooth/BluetoothManager;",
        "getBluetoothManager",
        "()Landroid/bluetooth/BluetoothManager;",
        "bluetoothManager$delegate",
        "Lkotlin/Lazy;",
        "gattCallback",
        "com/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1",
        "Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;",
        "isConnected",
        "",
        "mBleClientListeners",
        "",
        "Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;",
        "mBleServerListeners",
        "",
        "mContext",
        "Landroid/app/Application;",
        "getMContext",
        "()Landroid/app/Application;",
        "mContext$delegate",
        "mainHandler",
        "Landroid/os/Handler;",
        "scanCallback",
        "Landroid/bluetooth/le/ScanCallback;",
        "stopScanRunnable",
        "Ljava/lang/Runnable;",
        "addBleClientListener",
        "",
        "listener",
        "check",
        "connectToGattServer",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "disconnect",
        "isBleSupported",
        "isBluetoothEnabled",
        "openNotify",
        "gatt",
        "characteristic",
        "Landroid/bluetooth/BluetoothGattCharacteristic;",
        "release",
        "removeBleClientListener",
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
        "writeCharacteristic",
        "msg",
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


# instance fields
.field private final CCCD_UUID:Ljava/util/UUID;

.field private final CHARACTERISTIC_UUID:Ljava/util/UUID;

.field private final SERVICE_UUID:Ljava/util/UUID;

.field private final TAG:Ljava/lang/String;

.field private bluetoothGatt:Landroid/bluetooth/BluetoothGatt;

.field private final bluetoothManager$delegate:Lkotlin/Lazy;

.field private final gattCallback:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;

.field private isConnected:Z

.field private final mBleClientListeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;",
            ">;"
        }
    .end annotation
.end field

.field private final mBleServerListeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;",
            ">;"
        }
    .end annotation
.end field

.field private final mContext$delegate:Lkotlin/Lazy;

.field private final mainHandler:Landroid/os/Handler;

.field private scanCallback:Landroid/bluetooth/le/ScanCallback;

.field private final stopScanRunnable:Ljava/lang/Runnable;


# direct methods
.method public static synthetic $r8$lambda$9h6EytE806aEFew4-RXnrJSuMtE(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)V
    .locals 0

    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->stopScanRunnable$lambda$0(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    const-string v0, "BleClientManager"

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->TAG:Ljava/lang/String;

    .line 29
    const-string v0, "00001eb1-0000-1000-8000-00805f9b34fb"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->SERVICE_UUID:Ljava/util/UUID;

    .line 30
    const-string v0, "00001eb1-0000-1000-8000-00805f9b34aa"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->CHARACTERISTIC_UUID:Ljava/util/UUID;

    .line 31
    const-string v0, "00002902-0000-1000-8000-00805f9b34fb"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->CCCD_UUID:Ljava/util/UUID;

    .line 32
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$mContext$2;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$mContext$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mContext$delegate:Lkotlin/Lazy;

    .line 35
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$bluetoothManager$2;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$bluetoothManager$2;-><init>(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->bluetoothManager$delegate:Lkotlin/Lazy;

    .line 45
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mBleServerListeners:Ljava/util/Set;

    .line 48
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mainHandler:Landroid/os/Handler;

    .line 51
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mBleClientListeners:Ljava/util/List;

    .line 116
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->stopScanRunnable:Ljava/lang/Runnable;

    .line 198
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->gattCallback:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;

    .line 26
    return-void
.end method

.method public static final synthetic access$getCHARACTERISTIC_UUID$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/util/UUID;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    .line 26
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->CHARACTERISTIC_UUID:Ljava/util/UUID;

    return-object v0
.end method

.method public static final synthetic access$getMBleClientListeners$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/util/List;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    .line 26
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mBleClientListeners:Ljava/util/List;

    return-object v0
.end method

.method public static final synthetic access$getMContext(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Landroid/app/Application;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    .line 26
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->getMContext()Landroid/app/Application;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getSERVICE_UUID$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/util/UUID;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    .line 26
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->SERVICE_UUID:Ljava/util/UUID;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    .line 26
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$openNotify(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;Landroid/bluetooth/BluetoothGatt;Landroid/bluetooth/BluetoothGattCharacteristic;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;
    .param p2, "characteristic"    # Landroid/bluetooth/BluetoothGattCharacteristic;

    .line 26
    invoke-direct {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->openNotify(Landroid/bluetooth/BluetoothGatt;Landroid/bluetooth/BluetoothGattCharacteristic;)V

    return-void
.end method

.method public static final synthetic access$setBluetoothGatt$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;Landroid/bluetooth/BluetoothGatt;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;
    .param p1, "<set-?>"    # Landroid/bluetooth/BluetoothGatt;

    .line 26
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->bluetoothGatt:Landroid/bluetooth/BluetoothGatt;

    return-void
.end method

.method public static final synthetic access$setConnected$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;
    .param p1, "<set-?>"    # Z

    .line 26
    iput-boolean p1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->isConnected:Z

    return-void
.end method

.method private final check()Z
    .locals 3

    .line 62
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->isBleSupported()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 63
    const-string v0, " \u8bbe\u5907\u4e0d\u652f\u6301 Ble \u84dd\u7259"

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 64
    return v1

    .line 67
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->isBluetoothEnabled()Z

    move-result v0

    if-nez v0, :cond_1

    .line 68
    const-string v0, "\u84dd\u7259\u672a\u5f00\u542f"

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 69
    return v1

    .line 72
    :cond_1
    const/4 v0, 0x1

    return v0
.end method

.method private final getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;
    .locals 1

    .line 39
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->getBluetoothManager()Landroid/bluetooth/BluetoothManager;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothManager;->getAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method private final getBluetoothLeScanner()Landroid/bluetooth/le/BluetoothLeScanner;
    .locals 1

    .line 42
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getBluetoothLeScanner()Landroid/bluetooth/le/BluetoothLeScanner;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method private final getBluetoothManager()Landroid/bluetooth/BluetoothManager;
    .locals 1

    .line 35
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->bluetoothManager$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothManager;

    return-object v0
.end method

.method private final getMContext()Landroid/app/Application;
    .locals 1

    .line 32
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mContext$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Application;

    return-object v0
.end method

.method private final isBleSupported()Z
    .locals 2

    .line 54
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->getMContext()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.hardware.bluetooth_le"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method private final isBluetoothEnabled()Z
    .locals 3

    .line 58
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    move v1, v2

    :cond_0
    return v1
.end method

.method private final openNotify(Landroid/bluetooth/BluetoothGatt;Landroid/bluetooth/BluetoothGattCharacteristic;)V
    .locals 2
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;
    .param p2, "characteristic"    # Landroid/bluetooth/BluetoothGattCharacteristic;

    .line 192
    if-eqz p1, :cond_0

    const/4 v0, 0x1

    invoke-virtual {p1, p2, v0}, Landroid/bluetooth/BluetoothGatt;->setCharacteristicNotification(Landroid/bluetooth/BluetoothGattCharacteristic;Z)Z

    .line 193
    :cond_0
    if-eqz p2, :cond_1

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->CCCD_UUID:Ljava/util/UUID;

    invoke-virtual {p2, v0}, Landroid/bluetooth/BluetoothGattCharacteristic;->getDescriptor(Ljava/util/UUID;)Landroid/bluetooth/BluetoothGattDescriptor;

    move-result-object v0

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    .line 194
    .local v0, "descriptor":Landroid/bluetooth/BluetoothGattDescriptor;
    :goto_0
    if-nez v0, :cond_2

    goto :goto_1

    :cond_2
    sget-object v1, Landroid/bluetooth/BluetoothGattDescriptor;->ENABLE_NOTIFICATION_VALUE:[B

    invoke-virtual {v0, v1}, Landroid/bluetooth/BluetoothGattDescriptor;->setValue([B)Z

    .line 195
    :goto_1
    if-eqz p1, :cond_3

    invoke-virtual {p1, v0}, Landroid/bluetooth/BluetoothGatt;->writeDescriptor(Landroid/bluetooth/BluetoothGattDescriptor;)Z

    .line 196
    :cond_3
    return-void
.end method

.method public static synthetic startScan$default(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 77
    and-int/lit8 p6, p5, 0x1

    if-eqz p6, :cond_0

    const-wide/16 p1, 0x4e20

    :cond_0
    and-int/lit8 p5, p5, 0x2

    if-eqz p5, :cond_1

    const/4 p3, 0x0

    :cond_1
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->startScan(JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method private static final stopScanRunnable$lambda$0(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)V
    .locals 1
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 117
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->stopScan()V

    .line 118
    return-void
.end method


# virtual methods
.method public final addBleClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 155
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mBleClientListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 156
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mBleClientListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 158
    :cond_0
    return-void
.end method

.method public final connectToGattServer(Landroid/bluetooth/BluetoothDevice;)V
    .locals 3
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 133
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " connectToGattServer:  device = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 134
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->check()Z

    move-result v0

    if-nez v0, :cond_0

    .line 135
    return-void

    .line 138
    :cond_0
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->disconnect()V

    .line 139
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->getMContext()Landroid/app/Application;

    move-result-object v0

    check-cast v0, Landroid/content/Context;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->gattCallback:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;

    check-cast v1, Landroid/bluetooth/BluetoothGattCallback;

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2, v1}, Landroid/bluetooth/BluetoothDevice;->connectGatt(Landroid/content/Context;ZLandroid/bluetooth/BluetoothGattCallback;)Landroid/bluetooth/BluetoothGatt;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->bluetoothGatt:Landroid/bluetooth/BluetoothGatt;

    .line 140
    return-void
.end method

.method public final disconnect()V
    .locals 2

    .line 144
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->TAG:Ljava/lang/String;

    const-string v1, " disconnect"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 145
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->check()Z

    move-result v0

    if-nez v0, :cond_0

    .line 146
    return-void

    .line 148
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->bluetoothGatt:Landroid/bluetooth/BluetoothGatt;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothGatt;->disconnect()V

    .line 149
    :cond_1
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->bluetoothGatt:Landroid/bluetooth/BluetoothGatt;

    .line 150
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->isConnected:Z

    .line 151
    return-void
.end method

.method public final isConnected()Z
    .locals 1

    .line 165
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->isConnected:Z

    return v0
.end method

.method public final release()V
    .locals 2

    .line 169
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->TAG:Ljava/lang/String;

    const-string v1, " release"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 170
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->stopScan()V

    .line 171
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->disconnect()V

    .line 172
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mBleClientListeners:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 173
    return-void
.end method

.method public final removeBleClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 161
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mBleClientListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 162
    return-void
.end method

.method public final startScan(JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
    .locals 5
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

    .line 78
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->check()Z

    move-result v0

    if-nez v0, :cond_0

    .line 79
    return-void

    .line 81
    :cond_0
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->stopScan()V

    .line 82
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mainHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->stopScanRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 83
    new-instance v0, Landroid/bluetooth/le/ScanFilter$Builder;

    invoke-direct {v0}, Landroid/bluetooth/le/ScanFilter$Builder;-><init>()V

    .line 84
    new-instance v1, Landroid/os/ParcelUuid;

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->SERVICE_UUID:Ljava/util/UUID;

    invoke-direct {v1, v2}, Landroid/os/ParcelUuid;-><init>(Ljava/util/UUID;)V

    invoke-virtual {v0, v1}, Landroid/bluetooth/le/ScanFilter$Builder;->setServiceUuid(Landroid/os/ParcelUuid;)Landroid/bluetooth/le/ScanFilter$Builder;

    move-result-object v0

    .line 85
    invoke-virtual {v0}, Landroid/bluetooth/le/ScanFilter$Builder;->build()Landroid/bluetooth/le/ScanFilter;

    move-result-object v0

    .line 83
    nop

    .line 86
    .local v0, "filter":Landroid/bluetooth/le/ScanFilter;
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    .line 89
    .local v1, "filters":Ljava/util/List;
    new-instance v2, Landroid/bluetooth/le/ScanSettings$Builder;

    invoke-direct {v2}, Landroid/bluetooth/le/ScanSettings$Builder;-><init>()V

    .line 90
    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Landroid/bluetooth/le/ScanSettings$Builder;->setScanMode(I)Landroid/bluetooth/le/ScanSettings$Builder;

    move-result-object v2

    .line 91
    invoke-virtual {v2}, Landroid/bluetooth/le/ScanSettings$Builder;->build()Landroid/bluetooth/le/ScanSettings;

    move-result-object v2

    .line 89
    nop

    .line 93
    .local v2, "scanSettings":Landroid/bluetooth/le/ScanSettings;
    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$startScan$1;

    invoke-direct {v3, p0, p4, p3}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$startScan$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V

    check-cast v3, Landroid/bluetooth/le/ScanCallback;

    iput-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->scanCallback:Landroid/bluetooth/le/ScanCallback;

    .line 110
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->getBluetoothLeScanner()Landroid/bluetooth/le/BluetoothLeScanner;

    move-result-object v3

    if-eqz v3, :cond_1

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->scanCallback:Landroid/bluetooth/le/ScanCallback;

    invoke-virtual {v3, v1, v2, v4}, Landroid/bluetooth/le/BluetoothLeScanner;->startScan(Ljava/util/List;Landroid/bluetooth/le/ScanSettings;Landroid/bluetooth/le/ScanCallback;)V

    .line 111
    :cond_1
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->TAG:Ljava/lang/String;

    const-string v4, " \u5f00\u59cb\u626b\u63cf"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 113
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->mainHandler:Landroid/os/Handler;

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->stopScanRunnable:Ljava/lang/Runnable;

    invoke-virtual {v3, v4, p1, p2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 114
    return-void
.end method

.method public final stopScan()V
    .locals 2

    .line 123
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->TAG:Ljava/lang/String;

    const-string v1, " \u505c\u6b62\u626b\u63cf"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 124
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->check()Z

    move-result v0

    if-nez v0, :cond_0

    .line 125
    return-void

    .line 127
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->getBluetoothLeScanner()Landroid/bluetooth/le/BluetoothLeScanner;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->scanCallback:Landroid/bluetooth/le/ScanCallback;

    invoke-virtual {v0, v1}, Landroid/bluetooth/le/BluetoothLeScanner;->stopScan(Landroid/bluetooth/le/ScanCallback;)V

    .line 128
    :cond_1
    return-void
.end method

.method public final writeCharacteristic(Ljava/lang/String;)V
    .locals 4
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 177
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->bluetoothGatt:Landroid/bluetooth/BluetoothGatt;

    if-eqz v0, :cond_2

    .line 178
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->bluetoothGatt:Landroid/bluetooth/BluetoothGatt;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->SERVICE_UUID:Ljava/util/UUID;

    invoke-virtual {v0, v2}, Landroid/bluetooth/BluetoothGatt;->getService(Ljava/util/UUID;)Landroid/bluetooth/BluetoothGattService;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    .line 179
    .local v0, "service":Landroid/bluetooth/BluetoothGattService;
    :goto_0
    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->CHARACTERISTIC_UUID:Ljava/util/UUID;

    invoke-virtual {v0, v1}, Landroid/bluetooth/BluetoothGattService;->getCharacteristic(Ljava/util/UUID;)Landroid/bluetooth/BluetoothGattCharacteristic;

    move-result-object v1

    .line 180
    .local v1, "characteristic":Landroid/bluetooth/BluetoothGattCharacteristic;
    :cond_1
    if-eqz v1, :cond_3

    .line 181
    sget-object v2, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v2

    const-string v3, "this as java.lang.String).getBytes(charset)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/bluetooth/BluetoothGattCharacteristic;->setValue([B)Z

    .line 182
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->bluetoothGatt:Landroid/bluetooth/BluetoothGatt;

    if-eqz v2, :cond_3

    invoke-virtual {v2, v1}, Landroid/bluetooth/BluetoothGatt;->writeCharacteristic(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    goto :goto_1

    .line 185
    .end local v0    # "service":Landroid/bluetooth/BluetoothGattService;
    .end local v1    # "characteristic":Landroid/bluetooth/BluetoothGattCharacteristic;
    :cond_2
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->TAG:Ljava/lang/String;

    const-string v1, " ble \u670d\u52a1\u672a\u8fde\u63a5"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 187
    :cond_3
    :goto_1
    return-void
.end method
