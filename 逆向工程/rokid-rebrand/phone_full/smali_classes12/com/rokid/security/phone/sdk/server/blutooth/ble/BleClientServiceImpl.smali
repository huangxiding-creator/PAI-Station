.class public final Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/bluetooth/ble/api/AbsBleClientService;
.source "BleClientServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000a\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010#\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0003*\u0001\t\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u0005H\u0016J\u0010\u0010\u000e\u001a\u00020\u000c2\u0006\u0010\u000f\u001a\u00020\u0010H\u0016J\u0008\u0010\u0011\u001a\u00020\u000cH\u0016J\u0008\u0010\u0012\u001a\u00020\u0013H\u0016J\u0008\u0010\u0014\u001a\u00020\u000cH\u0016J\u0010\u0010\u0015\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u0005H\u0016J\u0010\u0010\u0016\u001a\u00020\u000c2\u0006\u0010\u0017\u001a\u00020\u0018H\u0016J\u000e\u0010\u0019\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u0007JX\u0010\u001a\u001a\u00020\u000c2\u0006\u0010\u001b\u001a\u00020\u001c2#\u0010\u001d\u001a\u001f\u0012\u0013\u0012\u00110\u001f\u00a2\u0006\u000c\u0008 \u0012\u0008\u0008!\u0012\u0004\u0008\u0008(\"\u0012\u0004\u0012\u00020\u000c\u0018\u00010\u001e2!\u0010#\u001a\u001d\u0012\u0013\u0012\u00110$\u00a2\u0006\u000c\u0008 \u0012\u0008\u0008!\u0012\u0004\u0008\u0008(%\u0012\u0004\u0012\u00020\u000c0\u001eH\u0016J\u0008\u0010&\u001a\u00020\u000cH\u0016R\u0014\u0010\u0003\u001a\u0008\u0012\u0004\u0012\u00020\u00050\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0006\u001a\u0004\u0018\u00010\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0008\u001a\u00020\tX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\n\u00a8\u0006\'"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/ble/api/AbsBleClientService;",
        "()V",
        "mIBleClientListeners",
        "",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleBTClientListener;",
        "mIBleMessageListener",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener;",
        "mIClassicClientListener",
        "com/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl$mIClassicClientListener$1",
        "Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl$mIClassicClientListener$1;",
        "addBleClientListener",
        "",
        "listener",
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
        "setBleMessageListener",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;

.field private static final mIBleClientListeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleBTClientListener;",
            ">;"
        }
    .end annotation
.end field

.field private static mIBleMessageListener:Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener;

.field private static final mIClassicClientListener:Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl$mIClassicClientListener$1;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;

    .line 18
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->mIBleClientListeners:Ljava/util/Set;

    .line 66
    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl$mIClassicClientListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl$mIClassicClientListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->mIClassicClientListener:Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl$mIClassicClientListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/bluetooth/ble/api/AbsBleClientService;-><init>()V

    return-void
.end method

.method public static final synthetic access$getMIBleClientListeners$p()Ljava/util/Set;
    .locals 1

    .line 15
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->mIBleClientListeners:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getMIBleMessageListener$p()Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener;
    .locals 1

    .line 15
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->mIBleMessageListener:Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener;

    return-object v0
.end method


# virtual methods
.method public addBleClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleBTClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleBTClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 44
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->mIBleClientListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 45
    return-void
.end method

.method public connectToGattServer(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 32
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->connectToServer(Landroid/bluetooth/BluetoothDevice;)V

    .line 33
    return-void
.end method

.method public disconnect()V
    .locals 1

    .line 36
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->disconnect()V

    .line 37
    return-void
.end method

.method public isConnected()Z
    .locals 1

    .line 58
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->isConnected()Z

    move-result v0

    return v0
.end method

.method public release()V
    .locals 1

    .line 62
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->release()V

    .line 63
    return-void
.end method

.method public removeBleClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleBTClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleBTClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 48
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->mIBleClientListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 49
    return-void
.end method

.method public sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 40
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->sendTextMessage(Ljava/lang/String;)V

    .line 41
    return-void
.end method

.method public final setBleMessageListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    sput-object p1, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->mIBleMessageListener:Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener;

    .line 53
    return-void
.end method

.method public startScan(JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
    .locals 2
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

    .line 23
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->startScan(JLkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V

    .line 24
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl;->mIClassicClientListener:Lcom/rokid/security/phone/sdk/server/blutooth/ble/BleClientServiceImpl$mIClassicClientListener$1;

    check-cast v1, Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->addClientListener(Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;)V

    .line 25
    return-void
.end method

.method public stopScan()V
    .locals 1

    .line 28
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/BleClientWrapper;->stopScan()V

    .line 29
    return-void
.end method
