.class public final Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$serviceConnection$1;
.super Ljava/lang/Object;
.source "BleServiceImpl.kt"

# interfaces
.implements Landroid/content/ServiceConnection;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001f\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u001c\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0008\u0010\u0006\u001a\u0004\u0018\u00010\u0007H\u0016J\u0012\u0010\u0008\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H\u0016\u00a8\u0006\t"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$serviceConnection$1",
        "Landroid/content/ServiceConnection;",
        "onServiceConnected",
        "",
        "name",
        "Landroid/content/ComponentName;",
        "service",
        "Landroid/os/IBinder;",
        "onServiceDisconnected",
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


# direct methods
.method constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 3
    .param p1, "name"    # Landroid/content/ComponentName;
    .param p2, "service"    # Landroid/os/IBinder;

    .line 22
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, " onServiceConnected: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 23
    const-string v0, "null cannot be cast to non-null type com.rokid.glasses.transport.sdk.server.ble.server.BleCustomService.LocalBinder"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v0, p2

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$LocalBinder;

    .line 24
    .local v0, "binder":Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$LocalBinder;
    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$LocalBinder;->getService()Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    move-result-object v1

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->access$setMBleService$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)V

    .line 25
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->access$getMBleService$p()Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->access$getMServerListener$p()Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl$mServerListener$1;

    move-result-object v2

    check-cast v2, Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;

    invoke-virtual {v1, v2}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->setServerListener(Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;)V

    .line 26
    :cond_0
    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 2
    .param p1, "name"    # Landroid/content/ComponentName;

    .line 29
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string v1, " onServiceDisconnected: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 31
    return-void
.end method
