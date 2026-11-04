.class final Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ClassicBlueToothClientManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->connectOtherBTServer(Landroid/bluetooth/BluetoothDevice;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/coroutines/jvm/internal/SuspendLambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Lkotlinx/coroutines/CoroutineScope;",
        "Lkotlin/coroutines/Continuation<",
        "-",
        "Lkotlin/Unit;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\u008a@"
    }
    d2 = {
        "<anonymous>",
        "",
        "Lkotlinx/coroutines/CoroutineScope;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.glasses.transport.sdk.server.bluetooth.client.ClassicBlueToothClientManager$connectOtherBTServer$4"
    f = "ClassicBlueToothClientManager.kt"
    i = {}
    l = {
        0x177
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $device:Landroid/bluetooth/BluetoothDevice;

.field label:I

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;",
            "Landroid/bluetooth/BluetoothDevice;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->$device:Landroid/bluetooth/BluetoothDevice;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p3}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/coroutines/Continuation<",
            "*>;)",
            "Lkotlin/coroutines/Continuation<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->$device:Landroid/bluetooth/BluetoothDevice;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CoroutineScope;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 9

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 371
    iget v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->label:I

    const/4 v2, 0x0

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;
    .local p1, "$result":Ljava/lang/Object;
    :try_start_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 380
    :catch_0
    move-exception v1

    goto :goto_1

    .line 371
    .end local v0    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 373
    .local v1, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;
    .restart local p1    # "$result":Ljava/lang/Object;
    nop

    .line 374
    :try_start_1
    iget-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->$device:Landroid/bluetooth/BluetoothDevice;

    sget-object v5, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    sget-object v6, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getSTREAM_TYPE()Ljava/lang/String;

    move-result-object v6

    sget-object v7, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getSPP_UUID_STREAM_STR()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v6, v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getBTUUid(Ljava/lang/String;Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/bluetooth/BluetoothDevice;->createRfcommSocketToServiceRecord(Ljava/util/UUID;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$setStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothSocket;)V

    .line 375
    iget-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getConnectOutTime$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)J

    move-result-wide v3

    new-instance v5, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4$1;

    iget-object v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-direct {v5, v6, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Lkotlin/coroutines/Continuation;)V

    check-cast v5, Lkotlin/jvm/functions/Function2;

    move-object v6, v1

    check-cast v6, Lkotlin/coroutines/Continuation;

    const/4 v7, 0x1

    iput v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->label:I

    invoke-static {v3, v4, v5, v6}, Lkotlinx/coroutines/TimeoutKt;->withTimeout(JLkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v3
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    if-ne v3, v0, :cond_0

    .line 371
    return-object v0

    .line 375
    :cond_0
    move-object v0, v1

    .line 378
    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;
    .restart local v0    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;
    :goto_0
    :try_start_2
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v3

    sget-object v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getSTREAM_TYPE()Ljava/lang/String;

    move-result-object v4

    invoke-static {v1, v3, v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$connected(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V

    .line 379
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v1

    const-string v3, "Stream Bt ServerConnection successful"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_2

    .line 380
    .end local v0    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;
    .restart local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;
    :catch_1
    move-exception v0

    move-object v8, v1

    move-object v1, v0

    move-object v0, v8

    .line 382
    .restart local v0    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;
    .local v1, "e":Ljava/lang/Exception;
    :goto_1
    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "streamSocket -- errorMessage = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    .end local v1    # "e":Ljava/lang/Exception;
    invoke-static {v3, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 383
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->close()V

    .line 384
    :cond_1
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$setStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothSocket;)V

    .line 387
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iget-object v2, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$connectOtherBTServer$4;->$device:Landroid/bluetooth/BluetoothDevice;

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$startStreamRetry(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;)V

    .line 389
    :goto_2
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
