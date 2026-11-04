.class final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ClassicBluetoothService.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startStreamServer()V
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
    c = "com.rokid.glasses.transport.sdk.server.bluetooth.server.ClassicBluetoothService$startStreamServer$1"
    f = "ClassicBluetoothService.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field private synthetic L$0:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p2}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 2
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

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-direct {v0, v1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 11

    const-string v0, "ClassicBluetoothService "

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 460
    iget v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .local v1, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->L$0:Ljava/lang/Object;

    check-cast v2, Lkotlinx/coroutines/CoroutineScope;

    .line 461
    .local v2, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    nop

    .line 462
    const/4 v3, 0x0

    const/4 v4, 0x0

    :try_start_0
    iget-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isStreamServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v5

    const/4 v6, 0x1

    invoke-virtual {v5, v6}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 463
    iget-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getBluetoothAdapter(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothAdapter;

    move-result-object v6

    if-eqz v6, :cond_0

    .line 464
    const-string v7, "RokidClassicService"

    .line 465
    sget-object v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    sget-object v9, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v9}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getSTREAM_TYPE()Ljava/lang/String;

    move-result-object v9

    sget-object v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v10}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getSPP_UUID_STREAM_STR()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v8, v9, v10}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getBTUUid(Ljava/lang/String;Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v8

    .line 463
    invoke-virtual {v6, v7, v8}, Landroid/bluetooth/BluetoothAdapter;->listenUsingRfcommWithServiceRecord(Ljava/lang/String;Ljava/util/UUID;)Landroid/bluetooth/BluetoothServerSocket;

    move-result-object v6

    goto :goto_0

    :cond_0
    move-object v6, v4

    :goto_0
    invoke-static {v5, v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$setServerStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothServerSocket;)V

    .line 467
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Stream startServer socket -- hashcode = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothServerSocket;

    move-result-object v6

    if-eqz v6, :cond_1

    invoke-virtual {v6}, Ljava/lang/Object;->hashCode()I

    move-result v6

    goto :goto_1

    :cond_1
    move v6, v3

    :goto_1
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v0, v5}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 469
    :goto_2
    iget-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isStreamServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v5

    invoke-virtual {v5}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v5

    if-eqz v5, :cond_7

    invoke-static {v2}, Lkotlinx/coroutines/CoroutineScopeKt;->isActive(Lkotlinx/coroutines/CoroutineScope;)Z

    move-result v5

    if-eqz v5, :cond_7

    .line 470
    iget-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothServerSocket;

    move-result-object v5

    if-eqz v5, :cond_2

    invoke-virtual {v5}, Landroid/bluetooth/BluetoothServerSocket;->accept()Landroid/bluetooth/BluetoothSocket;

    move-result-object v5

    goto :goto_3

    :cond_2
    move-object v5, v4

    .line 471
    .local v5, "socket":Landroid/bluetooth/BluetoothSocket;
    :goto_3
    if-eqz v5, :cond_3

    iget-object v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    move-object v7, v5

    .local v7, "it":Landroid/bluetooth/BluetoothSocket;
    const/4 v8, 0x0

    .line 472
    .local v8, "$i$a$-let-ClassicBluetoothService$startStreamServer$1$1":I
    invoke-static {v6, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$setMConnectedStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V

    .line 473
    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedStreamSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v9

    invoke-virtual {v9, v5}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 474
    nop

    .end local v5    # "socket":Landroid/bluetooth/BluetoothSocket;
    sget-object v5, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getSTREAM_TYPE()Ljava/lang/String;

    move-result-object v5

    invoke-static {v6, v7, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$handleConnectedSocket(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 475
    nop

    .line 471
    .end local v7    # "it":Landroid/bluetooth/BluetoothSocket;
    .end local v8    # "$i$a$-let-ClassicBluetoothService$startStreamServer$1$1":I
    goto :goto_2

    :cond_3
    goto :goto_2

    .line 477
    .end local v2    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catch_0
    move-exception v2

    .line 478
    .local v2, "e":Ljava/io/IOException;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Stream Server socket closed: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v2}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    .end local v2    # "e":Ljava/io/IOException;
    invoke-static {v0, v5}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 479
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isStreamServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 480
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedStreamSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    iget-object v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMConnectedStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 481
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedStreamSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    iget-object v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMConnectedStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 483
    :cond_4
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMConnectedStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->close()V

    .line 484
    :cond_5
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$setMConnectedStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V

    .line 485
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothServerSocket;

    move-result-object v0

    if-eqz v0, :cond_6

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothServerSocket;->close()V

    .line 486
    :cond_6
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$setServerStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothServerSocket;)V

    .line 488
    :cond_7
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
