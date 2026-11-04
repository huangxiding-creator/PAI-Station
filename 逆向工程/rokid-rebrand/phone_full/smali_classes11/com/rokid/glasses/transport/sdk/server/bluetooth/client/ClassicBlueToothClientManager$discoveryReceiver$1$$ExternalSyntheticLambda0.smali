.class public final synthetic Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

.field public final synthetic f$1:Landroid/bluetooth/BluetoothDevice;


# direct methods
.method public synthetic constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1$$ExternalSyntheticLambda0;->f$1:Landroid/bluetooth/BluetoothDevice;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1$$ExternalSyntheticLambda0;->f$1:Landroid/bluetooth/BluetoothDevice;

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1;->$r8$lambda$fNtCXweCLbJVh_5fmnnnPmGKv9k(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;)V

    return-void
.end method
