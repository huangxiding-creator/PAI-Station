.class final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;
.super Lkotlin/coroutines/jvm/internal/ContinuationImpl;
.source "ClassicBluetoothService.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->rejectNewConnection(Landroid/bluetooth/BluetoothSocket;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.glasses.transport.sdk.server.bluetooth.server.ClassicBluetoothService"
    f = "ClassicBluetoothService.kt"
    i = {
        0x0,
        0x0
    }
    l = {
        0x271
    }
    m = "rejectNewConnection"
    n = {
        "this",
        "socket"
    }
    s = {
        "L$0",
        "L$1"
    }
.end annotation


# instance fields
.field L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field label:I

.field synthetic result:Ljava/lang/Object;

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-direct {p0, p2}, Lkotlin/coroutines/jvm/internal/ContinuationImpl;-><init>(Lkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->result:Ljava/lang/Object;

    iget v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->label:I

    const/high16 v1, -0x80000000

    or-int/2addr v0, v1

    iput v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->label:I

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    const/4 v1, 0x0

    move-object v2, p0

    check-cast v2, Lkotlin/coroutines/Continuation;

    invoke-static {v0, v1, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$rejectNewConnection(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
