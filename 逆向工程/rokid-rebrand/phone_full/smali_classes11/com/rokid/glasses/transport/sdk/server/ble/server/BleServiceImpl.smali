.class public final Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;
.super Lcom/rokid/glasses/transport/sdk/api/ble/server/api/AbsBleService;
.source "BleServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000B\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010#\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0006*\u0002\u000b\u000e\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0010\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0007H\u0016J\u000e\u0010\u0013\u001a\u0008\u0012\u0004\u0012\u00020\u00150\u0014H\u0016J\u0010\u0010\u0016\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0007H\u0016J\u0010\u0010\u0017\u001a\u00020\u00112\u0006\u0010\u0018\u001a\u00020\u0004H\u0016J\u0008\u0010\u0019\u001a\u00020\u0011H\u0016J\u0008\u0010\u001a\u001a\u00020\u0011H\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0008\u001a\u0004\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\n\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0004\n\u0002\u0010\u000cR\u0010\u0010\r\u001a\u00020\u000eX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u000f\u00a8\u0006\u001b"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;",
        "Lcom/rokid/glasses/transport/sdk/api/ble/server/api/AbsBleService;",
        "()V",
        "TAG",
        "",
        "mBleServerListeners",
        "",
        "Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;",
        "mBleService",
        "Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;",
        "mServerListener",
        "com/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1",
        "Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1;",
        "serviceConnection",
        "com/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$serviceConnection$1",
        "Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$serviceConnection$1;",
        "addBleServerListener",
        "",
        "listener",
        "getConnectDevices",
        "",
        "Landroid/bluetooth/BluetoothDevice;",
        "removeBleServerListener",
        "sendTextMessage",
        "msg",
        "startBleService",
        "stopBleService",
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
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;

.field private static final TAG:Ljava/lang/String;

.field private static final mBleServerListeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;",
            ">;"
        }
    .end annotation
.end field

.field private static mBleService:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

.field private static mServerListener:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1;

.field private static final serviceConnection:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$serviceConnection$1;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;

    .line 16
    const-string v0, "BleServiceImpl"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->TAG:Ljava/lang/String;

    .line 18
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mBleServerListeners:Ljava/util/Set;

    .line 20
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$serviceConnection$1;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$serviceConnection$1;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->serviceConnection:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$serviceConnection$1;

    .line 65
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mServerListener:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/api/ble/server/api/AbsBleService;-><init>()V

    return-void
.end method

.method public static final synthetic access$getMBleServerListeners$p()Ljava/util/Set;
    .locals 1

    .line 15
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mBleServerListeners:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getMBleService$p()Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;
    .locals 1

    .line 15
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mBleService:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    return-object v0
.end method

.method public static final synthetic access$getMServerListener$p()Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1;
    .locals 1

    .line 15
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mServerListener:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 15
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$setMBleService$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)V
    .locals 0
    .param p0, "<set-?>"    # Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    .line 15
    sput-object p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mBleService:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    return-void
.end method


# virtual methods
.method public addBleServerListener(Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 45
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mBleServerListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 46
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mBleServerListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 49
    :cond_0
    return-void
.end method

.method public getConnectDevices()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/bluetooth/BluetoothDevice;",
            ">;"
        }
    .end annotation

    .line 56
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mBleService:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->getConnectDevices()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    :cond_1
    return-object v0
.end method

.method public removeBleServerListener(Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/ble/server/callback/IBleServerListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mBleServerListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 53
    return-void
.end method

.method public sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 41
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mBleService:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->sendNotification(Ljava/lang/String;)V

    .line 42
    :cond_0
    return-void
.end method

.method public startBleService()V
    .locals 4

    .line 35
    new-instance v0, Landroid/content/Intent;

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    check-cast v1, Landroid/content/Context;

    const-class v2, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 36
    .local v0, "intent":Landroid/content/Intent;
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    check-cast v1, Landroid/content/Context;

    invoke-static {v1, v0}, Landroidx/core/content/ContextCompat;->startForegroundService(Landroid/content/Context;Landroid/content/Intent;)V

    .line 37
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    sget-object v2, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->serviceConnection:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$serviceConnection$1;

    check-cast v2, Landroid/content/ServiceConnection;

    const/4 v3, 0x1

    invoke-virtual {v1, v0, v2, v3}, Landroid/app/Application;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    .line 38
    return-void
.end method

.method public stopBleService()V
    .locals 2

    .line 60
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->serviceConnection:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$serviceConnection$1;

    check-cast v1, Landroid/content/ServiceConnection;

    invoke-virtual {v0, v1}, Landroid/app/Application;->unbindService(Landroid/content/ServiceConnection;)V

    .line 61
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->mBleService:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->stopSelf()V

    .line 62
    :cond_0
    return-void
.end method
