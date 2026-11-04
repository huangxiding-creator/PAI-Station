.class public final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$LocalBinder;
.super Landroid/os/Binder;
.source "ClassicBluetoothService.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x11
    name = "LocalBinder"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\u0008\u0086\u0004\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0003\u001a\u00020\u0004\u00a8\u0006\u0005"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$LocalBinder;",
        "Landroid/os/Binder;",
        "(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V",
        "getService",
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;",
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
.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;


# direct methods
.method public constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 0
    .param p1, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 167
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$LocalBinder;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    return-void
.end method


# virtual methods
.method public final getService()Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .locals 1

    .line 168
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$LocalBinder;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    return-object v0
.end method
