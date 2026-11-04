.class public final Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;
.source "ClassicBTClientServiceImpl.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nClassicBTClientServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBTClientServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,410:1\n1#2:411\n1855#3,2:412\n1855#3,2:414\n1855#3,2:416\n*S KotlinDebug\n*F\n+ 1 ClassicBTClientServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl\n*L\n339#1:412,2\n348#1:414,2\n377#1:416,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u009a\u0001\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010#\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0014\n\u0002\u0010\u0012\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u000c*\u0004\u000e\u0015\u001d\"\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010+\u001a\u00020,2\u0006\u0010-\u001a\u00020\u0019H\u0016J\u0008\u0010.\u001a\u00020,H\u0002J\u0008\u0010/\u001a\u00020,H\u0002J3\u00100\u001a\u00020,2\u0006\u00101\u001a\u0002022!\u00103\u001a\u001d\u0012\u0013\u0012\u00110%\u00a2\u0006\u000c\u00085\u0012\u0008\u00086\u0012\u0004\u0008\u0008(7\u0012\u0004\u0012\u00020,04H\u0016J\u0008\u00108\u001a\u00020,H\u0016J\u0008\u00109\u001a\u00020,H\u0002J\u0010\u0010:\u001a\u00020%2\u0006\u0010;\u001a\u00020\u0006H\u0002J\u0006\u0010<\u001a\u00020,J\u0008\u0010=\u001a\u00020%H\u0016J\u0008\u0010>\u001a\u00020%H\u0016J\u0008\u0010?\u001a\u00020%H\u0016J\u0008\u0010@\u001a\u00020%H\u0016J\u0008\u0010A\u001a\u00020%H\u0016J\u0010\u0010B\u001a\u00020,2\u0006\u00101\u001a\u000202H\u0002J\u0008\u0010C\u001a\u00020,H\u0002J\u0006\u0010D\u001a\u00020,J\u0008\u0010E\u001a\u00020,H\u0002J\u0006\u0010F\u001a\u00020,J\u0010\u0010G\u001a\u00020,2\u0006\u0010-\u001a\u00020\u0019H\u0016J\u000e\u0010H\u001a\u00020,2\u0006\u0010I\u001a\u00020JJ \u0010K\u001a\u00020,2\u0008\u0010L\u001a\u0004\u0018\u00010\u00062\u0006\u0010M\u001a\u00020N2\u0006\u0010-\u001a\u00020OJ\u000e\u0010P\u001a\u00020,2\u0006\u0010Q\u001a\u00020\u0006J\u000e\u0010R\u001a\u00020,2\u0006\u0010-\u001a\u00020\u001bJ\u0010\u0010S\u001a\u00020,2\u0008\u0010-\u001a\u0004\u0018\u00010\u0013J\u000e\u0010T\u001a\u00020,2\u0006\u0010U\u001a\u00020\u0006J\u0010\u0010V\u001a\u00020,2\u0006\u0010W\u001a\u00020\u0004H\u0016J\u0006\u0010X\u001a\u00020,J\u0008\u0010Y\u001a\u00020,H\u0016J\u0008\u0010Z\u001a\u00020,H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001d\u0010\u0007\u001a\u0004\u0018\u00010\u00088BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000b\u0010\u000c\u001a\u0004\u0008\t\u0010\nR\u0010\u0010\r\u001a\u00020\u000eX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u000fR\u000e\u0010\u0010\u001a\u00020\u0011X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0012\u001a\u0004\u0018\u00010\u0013X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0014\u001a\u00020\u0015X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0016R\u0014\u0010\u0017\u001a\u0008\u0012\u0004\u0012\u00020\u00190\u0018X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u001a\u001a\u0004\u0018\u00010\u001bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u001c\u001a\u00020\u001dX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u001eR\u000e\u0010\u001f\u001a\u00020 X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010!\u001a\u00020\"X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010#R\u000e\u0010$\u001a\u00020%X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010&\u001a\u00020\'X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010(\u001a\u00020)X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010*\u001a\u00020%X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006["
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;",
        "()V",
        "SCAN_TIMEOUT_GRACE_MS",
        "",
        "TAG",
        "",
        "bluetoothAdapter",
        "Landroid/bluetooth/BluetoothAdapter;",
        "getBluetoothAdapter",
        "()Landroid/bluetooth/BluetoothAdapter;",
        "bluetoothAdapter$delegate",
        "Lkotlin/Lazy;",
        "fileReceiveListener",
        "com/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$fileReceiveListener$1",
        "Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$fileReceiveListener$1;",
        "isScanning",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "mFileReceiveListener",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;",
        "mIAuthListener",
        "com/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1",
        "Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1;",
        "mIClassicBTClientListeners",
        "",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;",
        "mIClassicBTMessageListener",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;",
        "mIClassicClientListener",
        "com/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1",
        "Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1;",
        "mainHandler",
        "Landroid/os/Handler;",
        "scanReceiver",
        "com/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$scanReceiver$1",
        "Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$scanReceiver$1;",
        "scanReceiverRegistered",
        "",
        "scanTimeoutRunnable",
        "Ljava/lang/Runnable;",
        "transportListenerLock",
        "",
        "transportListenersAttached",
        "addClientListener",
        "",
        "listener",
        "cancelNativeDiscovery",
        "completeScan",
        "connectToServer",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "action",
        "Lkotlin/Function1;",
        "Lkotlin/ParameterName;",
        "name",
        "isConnect",
        "disconnect",
        "emitBondedDevices",
        "ensureTransportListenersAttached",
        "reason",
        "init",
        "isAudioChanelConnect",
        "isConnected",
        "isFileChanelConnect",
        "isMessageChanelConnect",
        "isStreamChanelConnect",
        "notifyDeviceFound",
        "notifyScanFinished",
        "onTransportReady",
        "registerScanReceiver",
        "release",
        "removeClientListener",
        "sendClassBTAudioData",
        "audio",
        "",
        "sendClassBTFileData",
        "dir",
        "file",
        "Ljava/io/File;",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;",
        "sendClassBTTextMessage",
        "data",
        "setClassicBTMessageListener",
        "setFileReceiveListener",
        "setSaveFileDirectory",
        "saveDirectory",
        "startScan",
        "timeoutMillis",
        "stopClassBTFileSend",
        "stopScan",
        "unregisterScanReceiver",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

.field private static final SCAN_TIMEOUT_GRACE_MS:J = 0x3e8L

.field private static TAG:Ljava/lang/String;

.field private static final bluetoothAdapter$delegate:Lkotlin/Lazy;

.field private static final fileReceiveListener:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$fileReceiveListener$1;

.field private static final isScanning:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static mFileReceiveListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

.field private static final mIAuthListener:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1;

.field private static final mIClassicBTClientListeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;",
            ">;"
        }
    .end annotation
.end field

.field private static mIClassicBTMessageListener:Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;

.field private static final mIClassicClientListener:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1;

.field private static final mainHandler:Landroid/os/Handler;

.field private static final scanReceiver:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$scanReceiver$1;

.field private static scanReceiverRegistered:Z

.field private static final scanTimeoutRunnable:Ljava/lang/Runnable;

.field private static final transportListenerLock:Ljava/lang/Object;

.field private static volatile transportListenersAttached:Z


# direct methods
.method public static synthetic $r8$lambda$EAC6tAkwLkkhISVR7_GEnEvikwE()V
    .locals 0

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanTimeoutRunnable$lambda$0()V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    .line 38
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicBTClientListeners:Ljava/util/Set;

    .line 42
    const-string v0, "ClassicBTClientServiceImpl::"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    .line 44
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mainHandler:Landroid/os/Handler;

    .line 45
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isScanning:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 46
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->transportListenerLock:Ljava/lang/Object;

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$bluetoothAdapter$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$bluetoothAdapter$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->bluetoothAdapter$delegate:Lkotlin/Lazy;

    .line 51
    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$$ExternalSyntheticLambda0;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanTimeoutRunnable:Ljava/lang/Runnable;

    .line 59
    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$scanReceiver$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$scanReceiver$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanReceiver:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$scanReceiver$1;

    .line 80
    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIAuthListener:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1;

    .line 268
    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicClientListener:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1;

    .line 384
    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$fileReceiveListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$fileReceiveListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->fileReceiveListener:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$fileReceiveListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;-><init>()V

    return-void
.end method

.method public static final synthetic access$completeScan(Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    .line 35
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->completeScan()V

    return-void
.end method

.method public static final synthetic access$getBluetoothAdapter(Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;)Landroid/bluetooth/BluetoothAdapter;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    .line 35
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getMFileReceiveListener$p()Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .locals 1

    .line 35
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mFileReceiveListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    return-object v0
.end method

.method public static final synthetic access$getMIClassicBTClientListeners$p()Ljava/util/Set;
    .locals 1

    .line 35
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicBTClientListeners:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getMIClassicBTMessageListener$p()Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;
    .locals 1

    .line 35
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicBTMessageListener:Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 35
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$isScanning$p()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    .line 35
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isScanning:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public static final synthetic access$notifyDeviceFound(Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;Landroid/bluetooth/BluetoothDevice;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .line 35
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->notifyDeviceFound(Landroid/bluetooth/BluetoothDevice;)V

    return-void
.end method

.method private final cancelNativeDiscovery()V
    .locals 5

    .line 369
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    .local v0, "$this$cancelNativeDiscovery_u24lambda_u2410":Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
    const/4 v1, 0x0

    .line 370
    .local v1, "$i$a$-runCatching-ClassicBTClientServiceImpl$cancelNativeDiscovery$1":I
    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v2

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Landroid/bluetooth/BluetoothAdapter;->isDiscovering()Z

    move-result v2

    const/4 v4, 0x1

    if-ne v2, v4, :cond_0

    move v3, v4

    :cond_0
    if-eqz v3, :cond_1

    .line 371
    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Landroid/bluetooth/BluetoothAdapter;->cancelDiscovery()Z

    .line 373
    :cond_1
    nop

    .end local v0    # "$this$cancelNativeDiscovery_u24lambda_u2410":Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
    .end local v1    # "$i$a$-runCatching-ClassicBTClientServiceImpl$cancelNativeDiscovery$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 369
    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 373
    :goto_0
    invoke-static {v0}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 411
    .local v0, "it":Ljava/lang/Throwable;
    const/4 v1, 0x0

    .line 373
    .local v1, "$i$a$-onFailure-ClassicBTClientServiceImpl$cancelNativeDiscovery$2":I
    sget-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "cancel discovery ignored type="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 374
    .end local v0    # "it":Ljava/lang/Throwable;
    .end local v1    # "$i$a$-onFailure-ClassicBTClientServiceImpl$cancelNativeDiscovery$2":I
    :cond_2
    return-void
.end method

.method private final completeScan()V
    .locals 3

    .line 331
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mainHandler:Landroid/os/Handler;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanTimeoutRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 332
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isScanning:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 333
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->unregisterScanReceiver()V

    .line 334
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->notifyScanFinished()V

    .line 336
    :cond_0
    return-void
.end method

.method private final emitBondedDevices()V
    .locals 6

    .line 345
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    .line 411
    .local v0, "$this$emitBondedDevices_u24lambda_u245":Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
    const/4 v1, 0x0

    .line 345
    .local v1, "$i$a$-runCatching-ClassicBTClientServiceImpl$emitBondedDevices$1":I
    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Landroid/bluetooth/BluetoothAdapter;->getBondedDevices()Ljava/util/Set;

    move-result-object v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    if-nez v2, :cond_1

    invoke-static {}, Lkotlin/collections/SetsKt;->emptySet()Ljava/util/Set;

    move-result-object v2

    .end local v0    # "$this$emitBondedDevices_u24lambda_u245":Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
    .end local v1    # "$i$a$-runCatching-ClassicBTClientServiceImpl$emitBondedDevices$1":I
    :cond_1
    invoke-static {v2}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 346
    :goto_1
    invoke-static {v0}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 411
    .local v1, "it":Ljava/lang/Throwable;
    const/4 v2, 0x0

    .line 346
    .local v2, "$i$a$-onFailure-ClassicBTClientServiceImpl$emitBondedDevices$2":I
    sget-object v3, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "read bonded devices failed type="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 347
    .end local v1    # "it":Ljava/lang/Throwable;
    .end local v2    # "$i$a$-onFailure-ClassicBTClientServiceImpl$emitBondedDevices$2":I
    :cond_2
    invoke-static {}, Lkotlin/collections/SetsKt;->emptySet()Ljava/util/Set;

    move-result-object v1

    invoke-static {v0}, Lkotlin/Result;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    move-object v0, v1

    :cond_3
    check-cast v0, Ljava/lang/Iterable;

    .line 348
    nop

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 414
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Landroid/bluetooth/BluetoothDevice;

    .local v4, "p0":Landroid/bluetooth/BluetoothDevice;
    const/4 v5, 0x0

    .line 348
    .local v5, "$i$a$-forEach-ClassicBTClientServiceImpl$emitBondedDevices$3":I
    invoke-direct {p0, v4}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->notifyDeviceFound(Landroid/bluetooth/BluetoothDevice;)V

    .line 414
    .end local v4    # "p0":Landroid/bluetooth/BluetoothDevice;
    .end local v5    # "$i$a$-forEach-ClassicBTClientServiceImpl$emitBondedDevices$3":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 415
    :cond_4
    nop

    .line 349
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method private final ensureTransportListenersAttached(Ljava/lang/String;)Z
    .locals 6
    .param p1, "reason"    # Ljava/lang/String;

    .line 250
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->transportListenersAttached:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    .line 251
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->transportListenerLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v2, 0x0

    .line 252
    .local v2, "$i$a$-synchronized-ClassicBTClientServiceImpl$ensureTransportListenersAttached$1":I
    :try_start_0
    sget-boolean v3, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->transportListenersAttached:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v3, :cond_1

    .end local v2    # "$i$a$-synchronized-ClassicBTClientServiceImpl$ensureTransportListenersAttached$1":I
    monitor-exit v0

    return v1

    .line 253
    .restart local v2    # "$i$a$-synchronized-ClassicBTClientServiceImpl$ensureTransportListenersAttached$1":I
    :cond_1
    :try_start_1
    sget-object v3, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    .line 254
    sget-object v4, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicClientListener:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1;

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    .line 255
    sget-object v5, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->fileReceiveListener:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$fileReceiveListener$1;

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    .line 253
    invoke-virtual {v3, v4, v5}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->attachListeners(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)Z

    move-result v3

    .line 257
    .local v3, "attached":Z
    if-eqz v3, :cond_2

    .line 258
    sput-boolean v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->transportListenersAttached:Z

    .line 259
    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "classic bluetooth transport listeners attached reason="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    .line 261
    :cond_2
    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "classic bluetooth transport not ready reason="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 263
    :goto_0
    nop

    .end local v2    # "$i$a$-synchronized-ClassicBTClientServiceImpl$ensureTransportListenersAttached$1":I
    .end local v3    # "attached":Z
    monitor-exit v0

    return v3

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private final getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->bluetoothAdapter$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothAdapter;

    return-object v0
.end method

.method private final notifyDeviceFound(Landroid/bluetooth/BluetoothDevice;)V
    .locals 6
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .line 339
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicBTClientListeners:Ljava/util/Set;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 412
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    const/4 v5, 0x0

    .line 340
    .local v5, "$i$a$-forEach-ClassicBTClientServiceImpl$notifyDeviceFound$1":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;->onDeviceFound(Landroid/bluetooth/BluetoothDevice;)V

    .line 341
    nop

    .line 412
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    .end local v5    # "$i$a$-forEach-ClassicBTClientServiceImpl$notifyDeviceFound$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 413
    :cond_0
    nop

    .line 342
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method private final notifyScanFinished()V
    .locals 6

    .line 377
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicBTClientListeners:Ljava/util/Set;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 416
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    const/4 v5, 0x0

    .line 378
    .local v5, "$i$a$-forEach-ClassicBTClientServiceImpl$notifyScanFinished$1":I
    invoke-interface {v4}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;->onScanFinished()V

    .line 379
    nop

    .line 416
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    .end local v5    # "$i$a$-forEach-ClassicBTClientServiceImpl$notifyScanFinished$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 417
    :cond_0
    nop

    .line 380
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method private final registerScanReceiver()V
    .locals 4

    .line 352
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanReceiverRegistered:Z

    if-eqz v0, :cond_0

    return-void

    .line 353
    :cond_0
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    move-object v1, v0

    .local v1, "$this$registerScanReceiver_u24lambda_u247":Landroid/content/IntentFilter;
    const/4 v2, 0x0

    .line 354
    .local v2, "$i$a$-apply-ClassicBTClientServiceImpl$registerScanReceiver$filter$1":I
    const-string v3, "android.bluetooth.device.action.FOUND"

    invoke-virtual {v1, v3}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 355
    const-string v3, "android.bluetooth.adapter.action.DISCOVERY_FINISHED"

    invoke-virtual {v1, v3}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 356
    nop

    .line 353
    .end local v1    # "$this$registerScanReceiver_u24lambda_u247":Landroid/content/IntentFilter;
    .end local v2    # "$i$a$-apply-ClassicBTClientServiceImpl$registerScanReceiver$filter$1":I
    nop

    .line 357
    .local v0, "filter":Landroid/content/IntentFilter;
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanReceiver:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$scanReceiver$1;

    check-cast v2, Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/app/Application;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 358
    const/4 v1, 0x1

    sput-boolean v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanReceiverRegistered:Z

    .line 359
    return-void
.end method

.method private static final scanTimeoutRunnable$lambda$0()V
    .locals 3

    .line 52
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isScanning:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 53
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "classic bluetooth scan timed out; stopping discovery"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 54
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->cancelNativeDiscovery()V

    .line 55
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->unregisterScanReceiver()V

    .line 56
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->notifyScanFinished()V

    .line 58
    :cond_0
    return-void
.end method

.method private final unregisterScanReceiver()V
    .locals 5

    .line 362
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanReceiverRegistered:Z

    if-nez v0, :cond_0

    return-void

    .line 363
    :cond_0
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    .line 411
    .local v0, "$this$unregisterScanReceiver_u24lambda_u248":Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
    const/4 v1, 0x0

    .line 363
    .local v1, "$i$a$-runCatching-ClassicBTClientServiceImpl$unregisterScanReceiver$1":I
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v2

    sget-object v3, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanReceiver:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$scanReceiver$1;

    check-cast v3, Landroid/content/BroadcastReceiver;

    invoke-virtual {v2, v3}, Landroid/app/Application;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .end local v0    # "$this$unregisterScanReceiver_u24lambda_u248":Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
    .end local v1    # "$i$a$-runCatching-ClassicBTClientServiceImpl$unregisterScanReceiver$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 364
    :goto_0
    invoke-static {v0}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 411
    .local v0, "it":Ljava/lang/Throwable;
    const/4 v1, 0x0

    .line 364
    .local v1, "$i$a$-onFailure-ClassicBTClientServiceImpl$unregisterScanReceiver$2":I
    sget-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "unregister scan receiver ignored type="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 365
    .end local v0    # "it":Ljava/lang/Throwable;
    .end local v1    # "$i$a$-onFailure-ClassicBTClientServiceImpl$unregisterScanReceiver$2":I
    :cond_1
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanReceiverRegistered:Z

    .line 366
    return-void
.end method


# virtual methods
.method public addClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 166
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicBTClientListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 167
    return-void
.end method

.method public connectToServer(Landroid/bluetooth/BluetoothDevice;Lkotlin/jvm/functions/Function1;)V
    .locals 4
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "action"    # Lkotlin/jvm/functions/Function1;
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

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "action"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 146
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "connectToServer"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 147
    const-string v0, "connect"

    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->ensureTransportListenersAttached(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    .line 149
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    .line 147
    if-nez v0, :cond_0

    .line 148
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "connect rejected: classic bluetooth transport is not ready"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 149
    invoke-interface {p2, v2}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 150
    return-void

    .line 152
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0, p1, p2}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->connectToServer(Landroid/bluetooth/BluetoothDevice;Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 153
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string v3, "connect rejected: classic bluetooth service disappeared"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 154
    sput-boolean v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->transportListenersAttached:Z

    .line 155
    invoke-interface {p2, v2}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 157
    :cond_1
    return-void
.end method

.method public disconnect()V
    .locals 2

    .line 160
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "disconnect"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 161
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->INSTANCE:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->onTransportDisconnected()V

    .line 162
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->disconnect()V

    .line 163
    return-void
.end method

.method public final init()V
    .locals 3

    .line 102
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "init"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 103
    invoke-direct {p0, v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->ensureTransportListenersAttached(Ljava/lang/String;)Z

    .line 104
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIAuthListener:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->addAuthListener(Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;)V

    .line 105
    return-void
.end method

.method public isAudioChanelConnect()Z
    .locals 1

    .line 223
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->isAudioChanelConnect()Z

    move-result v0

    return v0
.end method

.method public isConnected()Z
    .locals 1

    .line 215
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->isConnected()Z

    move-result v0

    return v0
.end method

.method public isFileChanelConnect()Z
    .locals 1

    .line 227
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->isFileChanelConnect()Z

    move-result v0

    return v0
.end method

.method public isMessageChanelConnect()Z
    .locals 1

    .line 219
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->isMessageChanelConnect()Z

    move-result v0

    return v0
.end method

.method public isStreamChanelConnect()Z
    .locals 1

    .line 231
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->isStreamChanelConnect()Z

    move-result v0

    return v0
.end method

.method public final onTransportReady()V
    .locals 2

    .line 109
    const-string/jumbo v0, "transport_ready"

    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->ensureTransportListenersAttached(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 110
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "transport initialized but classic bluetooth service is unavailable"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 112
    :cond_0
    return-void
.end method

.method public final release()V
    .locals 3

    .line 235
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "release"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 236
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->INSTANCE:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->onTransportDisconnected()V

    .line 237
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mainHandler:Landroid/os/Handler;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanTimeoutRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 238
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isScanning:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 239
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->cancelNativeDiscovery()V

    .line 240
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->unregisterScanReceiver()V

    .line 241
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->disconnect()V

    .line 242
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicBTClientListeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 243
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicClientListener:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1;

    check-cast v2, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    invoke-virtual {v0, v2}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->removeClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V

    .line 244
    sput-boolean v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->transportListenersAttached:Z

    .line 245
    sget-object v0, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIAuthListener:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIAuthListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/auth/AuthServiceImpl;->removeAuthListener(Lcom/rokid/security/phone/sdk/server/auth/IAuthListener;)V

    .line 247
    return-void
.end method

.method public removeClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 170
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicBTClientListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 171
    return-void
.end method

.method public final sendClassBTAudioData([B)V
    .locals 1
    .param p1, "audio"    # [B

    const-string v0, "audio"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 198
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->sendAudioData([B)V

    .line 199
    return-void
.end method

.method public final sendClassBTFileData(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
    .locals 1
    .param p1, "dir"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    const-string v0, "file"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 205
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->sendFileData(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V

    .line 206
    return-void
.end method

.method public final sendClassBTTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 190
    sget-object v0, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->isNeedUseSendMessageV2()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 191
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->sendTextMessageV2(Ljava/lang/String;)V

    goto :goto_0

    .line 193
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->sendTextMessage(Ljava/lang/String;)V

    .line 195
    :goto_0
    return-void
.end method

.method public final setClassicBTMessageListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 186
    sput-object p1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mIClassicBTMessageListener:Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;

    .line 187
    return-void
.end method

.method public final setFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    .line 175
    sput-object p1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mFileReceiveListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    .line 177
    return-void
.end method

.method public final setSaveFileDirectory(Ljava/lang/String;)V
    .locals 1
    .param p1, "saveDirectory"    # Ljava/lang/String;

    const-string/jumbo v0, "saveDirectory"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 181
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->setSaveFileDirectory(Ljava/lang/String;)V

    .line 182
    return-void
.end method

.method public startScan(J)V
    .locals 11
    .param p1, "timeoutMillis"    # J

    .line 115
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isScanning:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    .line 116
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "startScan ignored: discovery already active"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 117
    return-void

    .line 119
    :cond_0
    const-wide/16 v3, 0x3e8

    invoke-static {p1, p2, v3, v4}, Lkotlin/ranges/RangesKt;->coerceAtLeast(JJ)J

    move-result-wide v5

    .line 120
    .local v5, "safeTimeoutMillis":J
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v8, "startScan timeoutMs="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v0, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 121
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mainHandler:Landroid/os/Handler;

    sget-object v7, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanTimeoutRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v7}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 122
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->registerScanReceiver()V

    .line 123
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->emitBondedDevices()V

    .line 124
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->cancelNativeDiscovery()V

    .line 125
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    .line 411
    .local v0, "$this$startScan_u24lambda_u241":Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
    const/4 v7, 0x0

    .line 125
    .local v7, "$i$a$-runCatching-ClassicBTClientServiceImpl$startScan$started$1":I
    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v8

    if-eqz v8, :cond_1

    invoke-virtual {v8}, Landroid/bluetooth/BluetoothAdapter;->startDiscovery()Z

    move-result v8

    if-ne v8, v2, :cond_1

    goto :goto_0

    :cond_1
    move v2, v1

    .end local v0    # "$this$startScan_u24lambda_u241":Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
    .end local v7    # "$i$a$-runCatching-ClassicBTClientServiceImpl$startScan$started$1":I
    :goto_0
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    sget-object v2, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 126
    :goto_1
    invoke-static {v0}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v2

    if-eqz v2, :cond_2

    .line 411
    .local v2, "it":Ljava/lang/Throwable;
    const/4 v7, 0x0

    .line 126
    .local v7, "$i$a$-onFailure-ClassicBTClientServiceImpl$startScan$started$2":I
    sget-object v8, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "native classic discovery failed type="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 127
    .end local v2    # "it":Ljava/lang/Throwable;
    .end local v7    # "$i$a$-onFailure-ClassicBTClientServiceImpl$startScan$started$2":I
    :cond_2
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-static {v0}, Lkotlin/Result;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    move-object v0, v1

    :cond_3
    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 125
    nop

    .line 128
    .local v0, "started":Z
    if-nez v0, :cond_4

    .line 129
    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string v2, "native classic discovery was not started"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 130
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->completeScan()V

    .line 131
    return-void

    .line 133
    :cond_4
    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string v2, "native classic discovery started"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 134
    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mainHandler:Landroid/os/Handler;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanTimeoutRunnable:Ljava/lang/Runnable;

    add-long/2addr v3, v5

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 135
    return-void
.end method

.method public final stopClassBTFileSend()V
    .locals 1

    .line 209
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->stopFileSend()V

    .line 210
    return-void
.end method

.method public stopScan()V
    .locals 2

    .line 138
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "stopScan"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 139
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->mainHandler:Landroid/os/Handler;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->scanTimeoutRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 140
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isScanning:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 141
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->cancelNativeDiscovery()V

    .line 142
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->unregisterScanReceiver()V

    .line 143
    return-void
.end method
