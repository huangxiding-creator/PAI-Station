.class public final Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;
.super Landroid/app/Service;
.source "BleCustomService.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$Companion;,
        Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$LocalBinder;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBleCustomService.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BleCustomService.kt\ncom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,355:1\n1855#2,2:356\n*S KotlinDebug\n*F\n+ 1 BleCustomService.kt\ncom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService\n*L\n156#1:356,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000f\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010 \n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0002\u0008\t*\u0002\u0015\u0018\u0018\u0000 /2\u00020\u0001:\u0002/0B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\u001c\u001a\u00020\u001dH\u0002J\u000c\u0010\u001e\u001a\u0008\u0012\u0004\u0012\u00020\u00130\u001fJ\u0010\u0010 \u001a\u00020!2\u0006\u0010\"\u001a\u00020#H\u0016J\u0008\u0010$\u001a\u00020\u001dH\u0016J\u0008\u0010%\u001a\u00020\u001dH\u0017J\u0010\u0010&\u001a\u00020\u001d2\u0006\u0010\'\u001a\u00020(H\u0007J\u000e\u0010)\u001a\u00020\u001d2\u0006\u0010*\u001a\u00020\u001bJ\u0008\u0010+\u001a\u00020\u001dH\u0003J\u0008\u0010,\u001a\u00020\u001dH\u0003J\u0008\u0010-\u001a\u00020\u001dH\u0002J\u0008\u0010.\u001a\u00020\u001dH\u0003R\u0014\u0010\u0003\u001a\u00020\u00048BX\u0082\u0004\u00a2\u0006\u0006\u001a\u0004\u0008\u0005\u0010\u0006R\u0012\u0010\u0007\u001a\u00060\u0008R\u00020\u0000X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u000b\u001a\u00020\u000c8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000f\u0010\u0010\u001a\u0004\u0008\r\u0010\u000eR\u0014\u0010\u0011\u001a\u0008\u0012\u0004\u0012\u00020\u00130\u0012X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0014\u001a\u00020\u0015X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0016R\u0010\u0010\u0017\u001a\u00020\u0018X\u0082\u000e\u00a2\u0006\u0004\n\u0002\u0010\u0019R\u0010\u0010\u001a\u001a\u0004\u0018\u00010\u001bX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u00061"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;",
        "Landroid/app/Service;",
        "()V",
        "advertiser",
        "Landroid/bluetooth/le/BluetoothLeAdvertiser;",
        "getAdvertiser",
        "()Landroid/bluetooth/le/BluetoothLeAdvertiser;",
        "binder",
        "Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$LocalBinder;",
        "bluetoothGattServer",
        "Landroid/bluetooth/BluetoothGattServer;",
        "bluetoothManager",
        "Landroid/bluetooth/BluetoothManager;",
        "getBluetoothManager",
        "()Landroid/bluetooth/BluetoothManager;",
        "bluetoothManager$delegate",
        "Lkotlin/Lazy;",
        "connectedDevices",
        "",
        "Landroid/bluetooth/BluetoothDevice;",
        "gattServerCallback",
        "com/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1",
        "Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;",
        "mAdvertiseCallback",
        "com/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$mAdvertiseCallback$1",
        "Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$mAdvertiseCallback$1;",
        "serverListener",
        "Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;",
        "createNotificationChannel",
        "",
        "getConnectDevices",
        "",
        "onBind",
        "Landroid/os/IBinder;",
        "intent",
        "Landroid/content/Intent;",
        "onCreate",
        "onDestroy",
        "sendNotification",
        "data",
        "",
        "setServerListener",
        "listener",
        "setupGattService",
        "startAdvertising",
        "startInForeground",
        "stopAdvertising",
        "Companion",
        "LocalBinder",
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
.field private static final CCCD_UUID:Ljava/util/UUID;

.field private static final CHANNEL:Ljava/lang/String; = "gatt_server_channel"

.field private static final CHARACTERISTIC_UUID:Ljava/util/UUID;

.field public static final Companion:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$Companion;

.field private static final SERVICE_UUID:Ljava/util/UUID;

.field private static final TAG:Ljava/lang/String; = "BleCustomService"


# instance fields
.field private final binder:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$LocalBinder;

.field private bluetoothGattServer:Landroid/bluetooth/BluetoothGattServer;

.field private final bluetoothManager$delegate:Lkotlin/Lazy;

.field private final connectedDevices:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/bluetooth/BluetoothDevice;",
            ">;"
        }
    .end annotation
.end field

.field private final gattServerCallback:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;

.field private mAdvertiseCallback:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$mAdvertiseCallback$1;

.field private serverListener:Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->Companion:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$Companion;

    .line 36
    const-string v0, "00001eb1-0000-1000-8000-00805f9b34fb"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->SERVICE_UUID:Ljava/util/UUID;

    .line 38
    const-string v0, "00001eb1-0000-1000-8000-00805f9b34aa"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->CHARACTERISTIC_UUID:Ljava/util/UUID;

    .line 40
    const-string v0, "00002902-0000-1000-8000-00805f9b34fb"

    invoke-static {v0}, Ljava/util/UUID;->fromString(Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v0

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->CCCD_UUID:Ljava/util/UUID;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 32
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 45
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$LocalBinder;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$LocalBinder;-><init>(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->binder:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$LocalBinder;

    .line 46
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$bluetoothManager$2;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$bluetoothManager$2;-><init>(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->bluetoothManager$delegate:Lkotlin/Lazy;

    .line 53
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->connectedDevices:Ljava/util/List;

    .line 179
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$mAdvertiseCallback$1;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$mAdvertiseCallback$1;-><init>()V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->mAdvertiseCallback:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$mAdvertiseCallback$1;

    .line 189
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->gattServerCallback:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;

    .line 32
    return-void
.end method

.method public static final synthetic access$getBluetoothGattServer$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)Landroid/bluetooth/BluetoothGattServer;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    .line 32
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->bluetoothGattServer:Landroid/bluetooth/BluetoothGattServer;

    return-object v0
.end method

.method public static final synthetic access$getCCCD_UUID$cp()Ljava/util/UUID;
    .locals 1

    .line 32
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->CCCD_UUID:Ljava/util/UUID;

    return-object v0
.end method

.method public static final synthetic access$getCHARACTERISTIC_UUID$cp()Ljava/util/UUID;
    .locals 1

    .line 32
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->CHARACTERISTIC_UUID:Ljava/util/UUID;

    return-object v0
.end method

.method public static final synthetic access$getConnectedDevices$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)Ljava/util/List;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    .line 32
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->connectedDevices:Ljava/util/List;

    return-object v0
.end method

.method public static final synthetic access$getServerListener$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    .line 32
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->serverListener:Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;

    return-object v0
.end method

.method public static final synthetic access$startAdvertising(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    .line 32
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->startAdvertising()V

    return-void
.end method

.method public static final synthetic access$stopAdvertising(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    .line 32
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->stopAdvertising()V

    return-void
.end method

.method private final createNotificationChannel()V
    .locals 3

    .line 90
    new-instance v0, Landroidx/core/app/NotificationChannelCompat$Builder;

    .line 91
    nop

    .line 92
    nop

    .line 90
    const-string v1, "gatt_server_channel"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Landroidx/core/app/NotificationChannelCompat$Builder;-><init>(Ljava/lang/String;I)V

    .line 94
    const-string v1, "GATT Server channel"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationChannelCompat$Builder;->setName(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationChannelCompat$Builder;

    move-result-object v0

    .line 95
    const-string v1, "Channel for the GATT server sample"

    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationChannelCompat$Builder;->setDescription(Ljava/lang/String;)Landroidx/core/app/NotificationChannelCompat$Builder;

    move-result-object v0

    .line 96
    invoke-virtual {v0}, Landroidx/core/app/NotificationChannelCompat$Builder;->build()Landroidx/core/app/NotificationChannelCompat;

    move-result-object v0

    const-string v1, "Builder(\n            com\u2026le\")\n            .build()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 90
    nop

    .line 97
    .local v0, "channel":Landroidx/core/app/NotificationChannelCompat;
    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-static {v1}, Landroidx/core/app/NotificationManagerCompat;->from(Landroid/content/Context;)Landroidx/core/app/NotificationManagerCompat;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/core/app/NotificationManagerCompat;->createNotificationChannel(Landroidx/core/app/NotificationChannelCompat;)V

    .line 98
    return-void
.end method

.method private final getAdvertiser()Landroid/bluetooth/le/BluetoothLeAdvertiser;
    .locals 2

    .line 50
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->getBluetoothManager()Landroid/bluetooth/BluetoothManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothManager;->getAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->getBluetoothLeAdvertiser()Landroid/bluetooth/le/BluetoothLeAdvertiser;

    move-result-object v0

    const-string v1, "bluetoothManager.adapter.bluetoothLeAdvertiser"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method private final getBluetoothManager()Landroid/bluetooth/BluetoothManager;
    .locals 2

    .line 46
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->bluetoothManager$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    const-string v1, "<get-bluetoothManager>(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/bluetooth/BluetoothManager;

    return-object v0
.end method

.method private final setupGattService()V
    .locals 5

    .line 102
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->getBluetoothManager()Landroid/bluetooth/BluetoothManager;

    move-result-object v0

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->gattServerCallback:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;

    check-cast v2, Landroid/bluetooth/BluetoothGattServerCallback;

    invoke-virtual {v0, v1, v2}, Landroid/bluetooth/BluetoothManager;->openGattServer(Landroid/content/Context;Landroid/bluetooth/BluetoothGattServerCallback;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->bluetoothGattServer:Landroid/bluetooth/BluetoothGattServer;

    .line 103
    new-instance v0, Landroid/bluetooth/BluetoothGattService;

    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->SERVICE_UUID:Ljava/util/UUID;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Landroid/bluetooth/BluetoothGattService;-><init>(Ljava/util/UUID;I)V

    .line 105
    .local v0, "service":Landroid/bluetooth/BluetoothGattService;
    new-instance v1, Landroid/bluetooth/BluetoothGattCharacteristic;

    .line 106
    sget-object v2, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->CHARACTERISTIC_UUID:Ljava/util/UUID;

    .line 107
    nop

    .line 110
    nop

    .line 105
    const/16 v3, 0x1a

    const/16 v4, 0x11

    invoke-direct {v1, v2, v3, v4}, Landroid/bluetooth/BluetoothGattCharacteristic;-><init>(Ljava/util/UUID;II)V

    .line 114
    .local v1, "characteristic":Landroid/bluetooth/BluetoothGattCharacteristic;
    new-instance v2, Landroid/bluetooth/BluetoothGattDescriptor;

    .line 115
    sget-object v3, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->CCCD_UUID:Ljava/util/UUID;

    .line 116
    nop

    .line 114
    invoke-direct {v2, v3, v4}, Landroid/bluetooth/BluetoothGattDescriptor;-><init>(Ljava/util/UUID;I)V

    .line 118
    .local v2, "cccd":Landroid/bluetooth/BluetoothGattDescriptor;
    invoke-virtual {v1, v2}, Landroid/bluetooth/BluetoothGattCharacteristic;->addDescriptor(Landroid/bluetooth/BluetoothGattDescriptor;)Z

    .line 120
    invoke-virtual {v0, v1}, Landroid/bluetooth/BluetoothGattService;->addCharacteristic(Landroid/bluetooth/BluetoothGattCharacteristic;)Z

    .line 121
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->bluetoothGattServer:Landroid/bluetooth/BluetoothGattServer;

    if-eqz v3, :cond_0

    invoke-virtual {v3, v0}, Landroid/bluetooth/BluetoothGattServer;->addService(Landroid/bluetooth/BluetoothGattService;)Z

    .line 122
    :cond_0
    return-void
.end method

.method private final startAdvertising()V
    .locals 4

    .line 127
    const/4 v0, 0x0

    new-array v1, v0, [Ljava/lang/Object;

    const-string v2, " startAdvertising"

    invoke-static {v2, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 129
    new-instance v1, Landroid/bluetooth/le/AdvertiseSettings$Builder;

    invoke-direct {v1}, Landroid/bluetooth/le/AdvertiseSettings$Builder;-><init>()V

    .line 130
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->setAdvertiseMode(I)Landroid/bluetooth/le/AdvertiseSettings$Builder;

    move-result-object v1

    .line 131
    const/4 v3, 0x2

    invoke-virtual {v1, v3}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->setTxPowerLevel(I)Landroid/bluetooth/le/AdvertiseSettings$Builder;

    move-result-object v1

    .line 132
    invoke-virtual {v1, v2}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->setConnectable(Z)Landroid/bluetooth/le/AdvertiseSettings$Builder;

    move-result-object v1

    .line 133
    invoke-virtual {v1, v0}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->setTimeout(I)Landroid/bluetooth/le/AdvertiseSettings$Builder;

    move-result-object v0

    .line 134
    invoke-virtual {v0}, Landroid/bluetooth/le/AdvertiseSettings$Builder;->build()Landroid/bluetooth/le/AdvertiseSettings;

    move-result-object v0

    .line 129
    nop

    .line 136
    .local v0, "settings":Landroid/bluetooth/le/AdvertiseSettings;
    new-instance v1, Landroid/bluetooth/le/AdvertiseData$Builder;

    invoke-direct {v1}, Landroid/bluetooth/le/AdvertiseData$Builder;-><init>()V

    .line 137
    invoke-virtual {v1, v2}, Landroid/bluetooth/le/AdvertiseData$Builder;->setIncludeDeviceName(Z)Landroid/bluetooth/le/AdvertiseData$Builder;

    move-result-object v1

    .line 138
    new-instance v2, Landroid/os/ParcelUuid;

    sget-object v3, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->SERVICE_UUID:Ljava/util/UUID;

    invoke-direct {v2, v3}, Landroid/os/ParcelUuid;-><init>(Ljava/util/UUID;)V

    invoke-virtual {v1, v2}, Landroid/bluetooth/le/AdvertiseData$Builder;->addServiceUuid(Landroid/os/ParcelUuid;)Landroid/bluetooth/le/AdvertiseData$Builder;

    move-result-object v1

    .line 139
    invoke-virtual {v1}, Landroid/bluetooth/le/AdvertiseData$Builder;->build()Landroid/bluetooth/le/AdvertiseData;

    move-result-object v1

    .line 136
    nop

    .line 142
    .local v1, "data":Landroid/bluetooth/le/AdvertiseData;
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->getAdvertiser()Landroid/bluetooth/le/BluetoothLeAdvertiser;

    move-result-object v2

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->mAdvertiseCallback:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$mAdvertiseCallback$1;

    check-cast v3, Landroid/bluetooth/le/AdvertiseCallback;

    invoke-virtual {v2, v0, v1, v3}, Landroid/bluetooth/le/BluetoothLeAdvertiser;->startAdvertising(Landroid/bluetooth/le/AdvertiseSettings;Landroid/bluetooth/le/AdvertiseData;Landroid/bluetooth/le/AdvertiseCallback;)V

    .line 143
    return-void
.end method

.method private final startInForeground()V
    .locals 4

    .line 69
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->createNotificationChannel()V

    .line 71
    new-instance v0, Landroidx/core/app/NotificationCompat$Builder;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    .line 72
    nop

    .line 71
    const-string v2, "gatt_server_channel"

    invoke-direct {v0, v1, v2}, Landroidx/core/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 74
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget v1, v1, Landroid/content/pm/ApplicationInfo;->icon:I

    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationCompat$Builder;->setSmallIcon(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 75
    const-string v1, "GATT Server"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 76
    const-string v1, "Running..."

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 77
    invoke-virtual {v0}, Landroidx/core/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    const-string v1, "Builder(this,\n          \u2026..\")\n            .build()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 71
    nop

    .line 78
    .local v0, "notification":Landroid/app/Notification;
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    const/16 v3, 0x64

    if-lt v1, v2, :cond_0

    .line 79
    nop

    .line 80
    nop

    .line 81
    nop

    .line 82
    nop

    .line 79
    const/16 v1, 0x10

    invoke-virtual {p0, v3, v0, v1}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->startForeground(ILandroid/app/Notification;I)V

    goto :goto_0

    .line 85
    :cond_0
    invoke-virtual {p0, v3, v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->startForeground(ILandroid/app/Notification;)V

    .line 87
    :goto_0
    return-void
.end method

.method private final stopAdvertising()V
    .locals 2

    .line 147
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " stopAdvertising"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 148
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->getAdvertiser()Landroid/bluetooth/le/BluetoothLeAdvertiser;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->mAdvertiseCallback:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$mAdvertiseCallback$1;

    check-cast v1, Landroid/bluetooth/le/AdvertiseCallback;

    invoke-virtual {v0, v1}, Landroid/bluetooth/le/BluetoothLeAdvertiser;->stopAdvertising(Landroid/bluetooth/le/AdvertiseCallback;)V

    .line 149
    return-void
.end method


# virtual methods
.method public final getConnectDevices()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/bluetooth/BluetoothDevice;",
            ">;"
        }
    .end annotation

    .line 167
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->connectedDevices:Ljava/util/List;

    check-cast v0, Ljava/lang/Iterable;

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->toList(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    const-string v0, "intent"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 55
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->binder:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$LocalBinder;

    check-cast v0, Landroid/os/IBinder;

    return-object v0
.end method

.method public onCreate()V
    .locals 0

    .line 62
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 63
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->startInForeground()V

    .line 64
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->setupGattService()V

    .line 65
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->startAdvertising()V

    .line 66
    return-void
.end method

.method public onDestroy()V
    .locals 2

    .line 172
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 173
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->bluetoothGattServer:Landroid/bluetooth/BluetoothGattServer;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothGattServer;->close()V

    .line 174
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->connectedDevices:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 175
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->stopAdvertising()V

    .line 176
    const-string v0, " onDestroy: "

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "BleCustomService"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 177
    return-void
.end method

.method public final sendNotification(Ljava/lang/String;)V
    .locals 12
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 153
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->bluetoothGattServer:Landroid/bluetooth/BluetoothGattServer;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    sget-object v2, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->SERVICE_UUID:Ljava/util/UUID;

    invoke-virtual {v0, v2}, Landroid/bluetooth/BluetoothGattServer;->getService(Ljava/util/UUID;)Landroid/bluetooth/BluetoothGattService;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    .line 154
    .local v0, "service":Landroid/bluetooth/BluetoothGattService;
    :goto_0
    if-eqz v0, :cond_1

    sget-object v2, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->CHARACTERISTIC_UUID:Ljava/util/UUID;

    invoke-virtual {v0, v2}, Landroid/bluetooth/BluetoothGattService;->getCharacteristic(Ljava/util/UUID;)Landroid/bluetooth/BluetoothGattCharacteristic;

    move-result-object v2

    goto :goto_1

    :cond_1
    move-object v2, v1

    .line 155
    .local v2, "characteristic":Landroid/bluetooth/BluetoothGattCharacteristic;
    :goto_1
    if-nez v2, :cond_2

    goto :goto_2

    :cond_2
    sget-object v3, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v3

    const-string v4, "this as java.lang.String).getBytes(charset)"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Landroid/bluetooth/BluetoothGattCharacteristic;->setValue([B)Z

    .line 156
    :goto_2
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->connectedDevices:Ljava/util/List;

    check-cast v3, Ljava/lang/Iterable;

    .local v3, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 356
    .local v4, "$i$f$forEach":I
    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_3
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    .local v6, "element$iv":Ljava/lang/Object;
    move-object v7, v6

    check-cast v7, Landroid/bluetooth/BluetoothDevice;

    .local v7, "device":Landroid/bluetooth/BluetoothDevice;
    const/4 v8, 0x0

    .line 157
    .local v8, "$i$a$-forEach-BleCustomService$sendNotification$1":I
    iget-object v9, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->bluetoothGattServer:Landroid/bluetooth/BluetoothGattServer;

    if-eqz v9, :cond_3

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    const/4 v10, 0x0

    invoke-virtual {v9, v7, v2, v10}, Landroid/bluetooth/BluetoothGattServer;->notifyCharacteristicChanged(Landroid/bluetooth/BluetoothDevice;Landroid/bluetooth/BluetoothGattCharacteristic;Z)Z

    move-result v9

    invoke-static {v9}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v9

    goto :goto_4

    :cond_3
    move-object v9, v1

    .line 158
    .local v9, "ret":Ljava/lang/Boolean;
    :goto_4
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "sendNotification: ret = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    const-string v11, "BleCustomService"

    invoke-static {v11, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 159
    nop

    .line 356
    .end local v7    # "device":Landroid/bluetooth/BluetoothDevice;
    .end local v8    # "$i$a$-forEach-BleCustomService$sendNotification$1":I
    .end local v9    # "ret":Ljava/lang/Boolean;
    nop

    .end local v6    # "element$iv":Ljava/lang/Object;
    goto :goto_3

    .line 357
    :cond_4
    nop

    .line 160
    .end local v3    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v4    # "$i$f$forEach":I
    return-void
.end method

.method public final setServerListener(Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 163
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->serverListener:Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;

    .line 164
    return-void
.end method
