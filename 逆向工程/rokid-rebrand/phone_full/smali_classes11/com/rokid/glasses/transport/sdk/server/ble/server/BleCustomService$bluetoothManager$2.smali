.class final Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$bluetoothManager$2;
.super Lkotlin/jvm/internal/Lambda;
.source "BleCustomService.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function0<",
        "Landroid/bluetooth/BluetoothManager;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0010\u0000\u001a\n \u0002*\u0004\u0018\u00010\u00010\u0001H\n\u00a2\u0006\u0002\u0008\u0003"
    }
    d2 = {
        "<anonymous>",
        "Landroid/bluetooth/BluetoothManager;",
        "kotlin.jvm.PlatformType",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$bluetoothManager$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final invoke()Landroid/bluetooth/BluetoothManager;
    .locals 2

    .line 47
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$bluetoothManager$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-class v1, Landroid/bluetooth/BluetoothManager;

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothManager;

    return-object v0
.end method

.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 46
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$bluetoothManager$2;->invoke()Landroid/bluetooth/BluetoothManager;

    move-result-object v0

    return-object v0
.end method
