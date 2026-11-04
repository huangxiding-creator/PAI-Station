.class public final synthetic Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Landroid/bluetooth/BluetoothSocket;

.field public final synthetic f$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;


# direct methods
.method public synthetic constructor <init>(Landroid/bluetooth/BluetoothSocket;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1$$ExternalSyntheticLambda0;->f$0:Landroid/bluetooth/BluetoothSocket;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1$$ExternalSyntheticLambda0;->f$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1$$ExternalSyntheticLambda0;->f$0:Landroid/bluetooth/BluetoothSocket;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1$$ExternalSyntheticLambda0;->f$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->$r8$lambda$EK6hs5xwcoNhzP4B-LJLl3it_vw(Landroid/bluetooth/BluetoothSocket;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    return-void
.end method
