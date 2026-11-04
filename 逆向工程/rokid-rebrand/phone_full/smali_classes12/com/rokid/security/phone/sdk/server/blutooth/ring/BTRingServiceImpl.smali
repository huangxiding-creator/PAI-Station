.class public final Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/AbsBluetoothRingService;
.source "BTRingServiceImpl.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBTRingServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BTRingServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,257:1\n1855#2,2:258\n1855#2,2:260\n*S KotlinDebug\n*F\n+ 1 BTRingServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl\n*L\n92#1:258,2\n241#1:260,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000n\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u000c\n\u0002\u0010\t\n\u0002\u0008\u0004*\u0002\u0012\u0017\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010 \u001a\u00020!2\u0006\u0010\"\u001a\u00020\u0010H\u0016J\u0010\u0010#\u001a\u00020!2\u0006\u0010$\u001a\u00020%H\u0016J\u0008\u0010&\u001a\u00020!H\u0016J\u0010\u0010\'\u001a\u00020!2\u0006\u0010(\u001a\u00020\u001aH\u0002J\u0006\u0010)\u001a\u00020!J\u0006\u0010*\u001a\u00020\u001aJ\u0010\u0010+\u001a\u00020!2\u0006\u0010,\u001a\u00020\tH\u0002J\u0006\u0010-\u001a\u00020!J\u0010\u0010.\u001a\u00020!2\u0006\u0010\"\u001a\u00020\u0010H\u0016J\u001e\u0010/\u001a\u00020!2\u000c\u00100\u001a\u0008\u0012\u0004\u0012\u00020\t0\u001f2\u0006\u00101\u001a\u000202H\u0017J\u0010\u00103\u001a\u00020!2\u0006\u00101\u001a\u000202H\u0007J\u0008\u00104\u001a\u00020!H\u0017J\u0006\u00105\u001a\u00020!R\u0019\u0010\u0003\u001a\n \u0005*\u0004\u0018\u00010\u00040\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0006\u0010\u0007R\u000e\u0010\u0008\u001a\u00020\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\n\u001a\u0004\u0018\u00010\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000c\u001a\u0004\u0018\u00010\rX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u000e\u001a\u0008\u0012\u0004\u0012\u00020\u00100\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0011\u001a\u00020\u0012X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0013R\u000e\u0010\u0014\u001a\u00020\u0015X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0016\u001a\u00020\u0017X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0018R\u000e\u0010\u0019\u001a\u00020\u001aX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001b\u001a\u00020\u001aX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001c\u001a\u00020\u001dX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u001e\u001a\u0008\u0012\u0004\u0012\u00020\t0\u001fX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u00066"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/AbsBluetoothRingService;",
        "()V",
        "MY_UUID",
        "Ljava/util/UUID;",
        "kotlin.jvm.PlatformType",
        "getMY_UUID",
        "()Ljava/util/UUID;",
        "TAG",
        "",
        "bluetoothAdapter",
        "Landroid/bluetooth/BluetoothAdapter;",
        "btRingExtra",
        "Lcom/rokid/security/sdk/base/common/RingExtra;",
        "mIBTRingClientListenerList",
        "",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$mInterMessageListener$1;",
        "mainHandler",
        "Landroid/os/Handler;",
        "receiver",
        "com/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1",
        "Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1;",
        "receiverRegistered",
        "",
        "scanStarted",
        "scanTimeout",
        "Ljava/lang/Runnable;",
        "trustedDeviceNamePrefixes",
        "",
        "addClientListener",
        "",
        "listener",
        "connectToServer",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "disconnect",
        "finishScan",
        "cancelDiscovery",
        "initBTRingService",
        "isScanning",
        "parseMessage",
        "msg",
        "registerReceiver",
        "removeClientListener",
        "startScan",
        "deviceNameFilter",
        "timeoutMillis",
        "",
        "startToScan",
        "stopScan",
        "unregisterReceiver",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;

.field private static final MY_UUID:Ljava/util/UUID;

.field private static TAG:Ljava/lang/String;

.field private static bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

.field private static btRingExtra:Lcom/rokid/security/sdk/base/common/RingExtra;

.field private static mIBTRingClientListenerList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;",
            ">;"
        }
    .end annotation
.end field

.field private static final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$mInterMessageListener$1;

.field private static final mainHandler:Landroid/os/Handler;

.field private static final receiver:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1;

.field private static receiverRegistered:Z

.field private static scanStarted:Z

.field private static final scanTimeout:Ljava/lang/Runnable;

.field private static trustedDeviceNamePrefixes:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$7QzDawJb1kxOKC1e5eNYDbnezaE()V
    .locals 0

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->scanTimeout$lambda$0()V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;

    .line 52
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mIBTRingClientListenerList:Ljava/util/List;

    .line 53
    invoke-static {}, Lkotlin/collections/CollectionsKt;->emptyList()Ljava/util/List;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->trustedDeviceNamePrefixes:Ljava/util/List;

    .line 55
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mainHandler:Landroid/os/Handler;

    .line 56
    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$$ExternalSyntheticLambda0;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->scanTimeout:Ljava/lang/Runnable;

    .line 60
    const-string v0, "BTRingServiceImpl::"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->TAG:Ljava/lang/String;

    .line 73
    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$mInterMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$mInterMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$mInterMessageListener$1;

    .line 130
    const-string v0, "00001101-0000-1000-8000-00805F9B34FB"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->MY_UUID:Ljava/util/UUID;

    .line 161
    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->receiver:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 47
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/AbsBluetoothRingService;-><init>()V

    return-void
.end method

.method public static final synthetic access$finishScan(Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;
    .param p1, "cancelDiscovery"    # Z

    .line 47
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->finishScan(Z)V

    return-void
.end method

.method public static final synthetic access$getMIBTRingClientListenerList$p()Ljava/util/List;
    .locals 1

    .line 47
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mIBTRingClientListenerList:Ljava/util/List;

    return-object v0
.end method

.method public static final synthetic access$getTrustedDeviceNamePrefixes$p()Ljava/util/List;
    .locals 1

    .line 47
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->trustedDeviceNamePrefixes:Ljava/util/List;

    return-object v0
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;
    .param p1, "msg"    # Ljava/lang/String;

    .line 47
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method private final finishScan(Z)V
    .locals 6
    .param p1, "cancelDiscovery"    # Z

    .line 235
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mainHandler:Landroid/os/Handler;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->scanTimeout:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 236
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->scanStarted:Z

    if-nez v0, :cond_0

    return-void

    .line 237
    :cond_0
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->scanStarted:Z

    .line 238
    if-eqz p1, :cond_2

    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothAdapter;->isDiscovering()Z

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_1

    move v0, v2

    :cond_1
    if-eqz v0, :cond_2

    .line 239
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->cancelDiscovery()Z

    .line 241
    :cond_2
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mIBTRingClientListenerList:Ljava/util/List;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 260
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;
    const/4 v5, 0x0

    .line 241
    .local v5, "$i$a$-forEach-BTRingServiceImpl$finishScan$1":I
    invoke-interface {v4}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;->onScanFinished()V

    .line 260
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;
    .end local v5    # "$i$a$-forEach-BTRingServiceImpl$finishScan$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 261
    :cond_3
    nop

    .line 242
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 9
    .param p1, "msg"    # Ljava/lang/String;

    .line 85
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "BLUETOOTH_RING"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v2, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 86
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "parseMessage msg:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 87
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v1, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 88
    .local v0, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    const/4 v1, 0x0

    .local v1, "curExtra":Ljava/lang/Object;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v3

    const-class v4, Lcom/rokid/security/sdk/base/common/RingExtra;

    invoke-virtual {v2, v3, v4}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    .line 90
    move-object v2, v1

    check-cast v2, Lcom/rokid/security/sdk/base/common/RingExtra;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/RingExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "onConnect"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 91
    move-object v2, v1

    check-cast v2, Lcom/rokid/security/sdk/base/common/RingExtra;

    sput-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->btRingExtra:Lcom/rokid/security/sdk/base/common/RingExtra;

    .line 92
    sget-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mIBTRingClientListenerList:Ljava/util/List;

    check-cast v2, Ljava/lang/Iterable;

    .local v2, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 258
    .local v3, "$i$f$forEach":I
    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .local v5, "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;

    .local v6, "listener":Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;
    const/4 v7, 0x0

    .line 93
    .local v7, "$i$a$-forEach-BTRingServiceImpl$parseMessage$1":I
    const-string v8, "curExtra"

    invoke-static {v1, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v8, v1

    check-cast v8, Lcom/rokid/security/sdk/base/common/RingExtra;

    invoke-interface {v6, v8}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;->onConnect(Lcom/rokid/security/sdk/base/common/RingExtra;)V

    .line 94
    nop

    .line 258
    .end local v6    # "listener":Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;
    .end local v7    # "$i$a$-forEach-BTRingServiceImpl$parseMessage$1":I
    nop

    .end local v5    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 259
    :cond_0
    nop

    .line 97
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v1    # "curExtra":Ljava/lang/Object;
    .end local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$forEach":I
    :cond_1
    return-void
.end method

.method private static final scanTimeout$lambda$0()V
    .locals 2

    .line 56
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->finishScan(Z)V

    return-void
.end method


# virtual methods
.method public addClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;)V
    .locals 2
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 119
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mIBTRingClientListenerList:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 120
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->btRingExtra:Lcom/rokid/security/sdk/base/common/RingExtra;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->btRingExtra:Lcom/rokid/security/sdk/base/common/RingExtra;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RingExtra;->getMethodName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onConnect"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 121
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->btRingExtra:Lcom/rokid/security/sdk/base/common/RingExtra;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-interface {p1, v0}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;->onConnect(Lcom/rokid/security/sdk/base/common/RingExtra;)V

    .line 123
    :cond_0
    return-void
.end method

.method public connectToServer(Landroid/bluetooth/BluetoothDevice;)V
    .locals 10
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 132
    invoke-super {p0, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/AbsBluetoothRingService;->connectToServer(Landroid/bluetooth/BluetoothDevice;)V

    .line 133
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "connectToServer"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 134
    new-instance v0, Lcom/rokid/security/sdk/base/common/RingExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/RingExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$connectToServer_u24lambda_u242":Lcom/rokid/security/sdk/base/common/RingExtra;
    const/4 v2, 0x0

    .line 135
    .local v2, "$i$a$-apply-BTRingServiceImpl$connectToServer$extra$1":I
    const-string v3, "connectRing"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/RingExtra;->setMethodName(Ljava/lang/String;)V

    .line 136
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v3

    const-string v4, "device.address"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/RingExtra;->setAddress(Ljava/lang/String;)V

    .line 137
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object v3

    const-string v4, "device.name"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/RingExtra;->setName(Ljava/lang/String;)V

    .line 138
    nop

    .line 134
    .end local v1    # "$this$connectToServer_u24lambda_u242":Lcom/rokid/security/sdk/base/common/RingExtra;
    .end local v2    # "$i$a$-apply-BTRingServiceImpl$connectToServer$extra$1":I
    nop

    .line 139
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/RingExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 140
    .local v1, "extraJson":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraJson"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "BLUETOOTH_RING"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 142
    return-void
.end method

.method public disconnect()V
    .locals 10

    .line 146
    invoke-super {p0}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/AbsBluetoothRingService;->disconnect()V

    .line 147
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "disconnect"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 148
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->unregisterReceiver()V

    .line 150
    new-instance v0, Lcom/rokid/security/sdk/base/common/RingExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/RingExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$disconnect_u24lambda_u243":Lcom/rokid/security/sdk/base/common/RingExtra;
    const/4 v2, 0x0

    .line 151
    .local v2, "$i$a$-apply-BTRingServiceImpl$disconnect$extra$1":I
    const-string v3, "disConnectRing"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/RingExtra;->setMethodName(Ljava/lang/String;)V

    .line 152
    nop

    .line 150
    .end local v1    # "$this$disconnect_u24lambda_u243":Lcom/rokid/security/sdk/base/common/RingExtra;
    .end local v2    # "$i$a$-apply-BTRingServiceImpl$disconnect$extra$1":I
    nop

    .line 153
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/RingExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 154
    .local v1, "extraJson":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraJson"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "BLUETOOTH_RING"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 155
    return-void
.end method

.method public final getMY_UUID()Ljava/util/UUID;
    .locals 1

    .line 130
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->MY_UUID:Ljava/util/UUID;

    return-object v0
.end method

.method public final initBTRingService()V
    .locals 3

    .line 64
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->TAG:Ljava/lang/String;

    const-string v1, "initBTRingService"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 65
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    const-string v1, "bluetooth"

    invoke-virtual {v0, v1}, Landroid/app/Application;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type android.bluetooth.BluetoothManager"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/bluetooth/BluetoothManager;

    .line 66
    .local v0, "bluetoothManager":Landroid/bluetooth/BluetoothManager;
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothManager;->getAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v1

    sput-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    .line 68
    sget-object v1, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$mInterMessageListener$1;

    check-cast v2, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v1, v2}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 69
    return-void
.end method

.method public final isScanning()Z
    .locals 1

    .line 249
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->scanStarted:Z

    return v0
.end method

.method public final registerReceiver()V
    .locals 4

    .line 191
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->receiverRegistered:Z

    if-eqz v0, :cond_0

    return-void

    .line 193
    :cond_0
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    move-object v1, v0

    .local v1, "$this$registerReceiver_u24lambda_u244":Landroid/content/IntentFilter;
    const/4 v2, 0x0

    .line 194
    .local v2, "$i$a$-apply-BTRingServiceImpl$registerReceiver$filter$1":I
    const-string v3, "android.bluetooth.device.action.FOUND"

    invoke-virtual {v1, v3}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 195
    const-string v3, "android.bluetooth.adapter.action.DISCOVERY_FINISHED"

    invoke-virtual {v1, v3}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 196
    nop

    .line 193
    .end local v1    # "$this$registerReceiver_u24lambda_u244":Landroid/content/IntentFilter;
    .end local v2    # "$i$a$-apply-BTRingServiceImpl$registerReceiver$filter$1":I
    nop

    .line 197
    .local v0, "filter":Landroid/content/IntentFilter;
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->receiver:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1;

    check-cast v2, Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/app/Application;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 198
    const/4 v1, 0x1

    sput-boolean v1, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->receiverRegistered:Z

    .line 199
    return-void
.end method

.method public removeClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 127
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mIBTRingClientListenerList:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 128
    return-void
.end method

.method public startScan(Ljava/util/List;J)V
    .locals 2
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

    const-string v0, "deviceNameFilter"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 103
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "startScan"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 104
    sput-object p1, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->trustedDeviceNamePrefixes:Ljava/util/List;

    .line 105
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->registerReceiver()V

    .line 106
    invoke-virtual {p0, p2, p3}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->startToScan(J)V

    .line 107
    return-void
.end method

.method public final startToScan(J)V
    .locals 4
    .param p1, "timeoutMillis"    # J

    .line 218
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz v0, :cond_5

    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_2

    .line 221
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mainHandler:Landroid/os/Handler;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->scanTimeout:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 223
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isDiscovering()Z

    move-result v0

    if-ne v0, v1, :cond_1

    move v0, v1

    goto :goto_0

    :cond_1
    move v0, v2

    :goto_0
    if-eqz v0, :cond_2

    .line 224
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->cancelDiscovery()Z

    .line 228
    :cond_2
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->bluetoothAdapter:Landroid/bluetooth/BluetoothAdapter;

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->startDiscovery()Z

    move-result v0

    if-ne v0, v1, :cond_3

    goto :goto_1

    :cond_3
    move v1, v2

    :goto_1
    sput-boolean v1, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->scanStarted:Z

    .line 229
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->scanStarted:Z

    if-eqz v0, :cond_4

    .line 230
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->mainHandler:Landroid/os/Handler;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->scanTimeout:Ljava/lang/Runnable;

    const-wide/16 v2, 0x3e8

    invoke-static {p1, p2, v2, v3}, Lkotlin/ranges/RangesKt;->coerceAtLeast(JJ)J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 232
    :cond_4
    return-void

    .line 219
    :cond_5
    :goto_2
    return-void
.end method

.method public stopScan()V
    .locals 2

    .line 112
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "stopScan"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 113
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->finishScan(Z)V

    .line 114
    return-void
.end method

.method public final unregisterReceiver()V
    .locals 5

    .line 205
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->receiverRegistered:Z

    if-nez v0, :cond_0

    return-void

    .line 206
    :cond_0
    nop

    .line 207
    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->receiver:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1;

    check-cast v2, Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2}, Landroid/app/Application;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 211
    :goto_0
    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->receiverRegistered:Z

    .line 212
    goto :goto_1

    .line 211
    :catchall_0
    move-exception v1

    goto :goto_2

    .line 208
    :catch_0
    move-exception v1

    .line 209
    .local v1, "e":Ljava/lang/IllegalArgumentException;
    :try_start_1
    sget-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "unregister receiver ignored type="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

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
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .end local v1    # "e":Ljava/lang/IllegalArgumentException;
    goto :goto_0

    .line 213
    :goto_1
    return-void

    .line 211
    :goto_2
    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->receiverRegistered:Z

    throw v1
.end method
