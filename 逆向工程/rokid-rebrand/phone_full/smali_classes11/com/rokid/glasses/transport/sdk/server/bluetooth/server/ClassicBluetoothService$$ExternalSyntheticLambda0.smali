.class public final synthetic Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

.field public final synthetic f$1:Landroid/bluetooth/BluetoothSocket;


# direct methods
.method public synthetic constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$$ExternalSyntheticLambda0;->f$1:Landroid/bluetooth/BluetoothSocket;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$$ExternalSyntheticLambda0;->f$1:Landroid/bluetooth/BluetoothSocket;

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->$r8$lambda$zmqtOSK-yR9A53FV07Bdb16nR-Q(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V

    return-void
.end method
