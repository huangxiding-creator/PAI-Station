.class final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ClassicBluetoothService.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startMessageServer()V
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
    c = "com.rokid.glasses.transport.sdk.server.bluetooth.server.ClassicBluetoothService$startMessageServer$1"
    f = "ClassicBluetoothService.kt"
    i = {
        0x0,
        0x0,
        0x0,
        0x0,
        0x1
    }
    l = {
        0x14f,
        0x167
    }
    m = "invokeSuspend"
    n = {
        "$this$launch",
        "socket",
        "it",
        "shouldReject",
        "$this$launch"
    }
    s = {
        "L$0",
        "L$1",
        "L$3",
        "L$4",
        "L$0"
    }
.end annotation


# instance fields
.field private synthetic L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field L$4:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;


# direct methods
.method public static synthetic $r8$lambda$EK6hs5xwcoNhzP4B-LJLl3it_vw(Landroid/bluetooth/BluetoothSocket;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->invokeSuspend$lambda$1$lambda$0(Landroid/bluetooth/BluetoothSocket;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    return-void
.end method

.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p2}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method

.method private static final invokeSuspend$lambda$1$lambda$0(Landroid/bluetooth/BluetoothSocket;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 3
    .param p0, "$socket"    # Landroid/bluetooth/BluetoothSocket;
    .param p1, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 353
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Message Socket onClientConnected -- hashcode = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Landroid/bluetooth/BluetoothSocket;->hashCode()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ClassicBluetoothService "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 354
    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Landroid/bluetooth/BluetoothSocket;->getRemoteDevice()Landroid/bluetooth/BluetoothDevice;

    move-result-object v1

    const-string v2, "socket.remoteDevice"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;->onClientConnected(Landroid/bluetooth/BluetoothDevice;)V

    .line 355
    :cond_0
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

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-direct {v0, v1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 14

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 322
    iget v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->label:I

    const/4 v2, 0x1

    const-string v3, "ClassicBluetoothService "

    const/4 v4, 0x0

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v1, p0

    .local v1, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;
    .local p1, "$result":Ljava/lang/Object;
    const/4 v5, 0x0

    .local v5, "$i$a$-let-ClassicBluetoothService$startMessageServer$1$1":I
    iget-object v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$0:Ljava/lang/Object;

    check-cast v6, Lkotlinx/coroutines/CoroutineScope;

    .local v6, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_5

    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;
    .end local v5    # "$i$a$-let-ClassicBluetoothService$startMessageServer$1$1":I
    .end local v6    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    move-object v1, p0

    .restart local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    const/4 v5, 0x0

    .restart local v5    # "$i$a$-let-ClassicBluetoothService$startMessageServer$1$1":I
    iget-object v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$4:Ljava/lang/Object;

    check-cast v6, Lkotlin/jvm/internal/Ref$BooleanRef;

    .local v6, "shouldReject":Lkotlin/jvm/internal/Ref$BooleanRef;
    iget-object v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$3:Ljava/lang/Object;

    check-cast v7, Landroid/bluetooth/BluetoothSocket;

    .local v7, "it":Landroid/bluetooth/BluetoothSocket;
    iget-object v8, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$2:Ljava/lang/Object;

    check-cast v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v9, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$1:Ljava/lang/Object;

    check-cast v9, Landroid/bluetooth/BluetoothSocket;

    .local v9, "socket":Landroid/bluetooth/BluetoothSocket;
    iget-object v10, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$0:Ljava/lang/Object;

    check-cast v10, Lkotlinx/coroutines/CoroutineScope;

    .local v10, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_4

    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;
    .end local v5    # "$i$a$-let-ClassicBluetoothService$startMessageServer$1$1":I
    .end local v6    # "shouldReject":Lkotlin/jvm/internal/Ref$BooleanRef;
    .end local v7    # "it":Landroid/bluetooth/BluetoothSocket;
    .end local v9    # "socket":Landroid/bluetooth/BluetoothSocket;
    .end local v10    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_2
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .restart local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    iget-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$0:Ljava/lang/Object;

    check-cast v5, Lkotlinx/coroutines/CoroutineScope;

    .line 323
    .local v5, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    nop

    .line 324
    :try_start_2
    iget-object v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isMessageServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 325
    iget-object v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getBluetoothAdapter(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothAdapter;

    move-result-object v7

    if-eqz v7, :cond_0

    .line 326
    const-string v8, "RokidClassicService"

    .line 327
    sget-object v9, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    sget-object v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v10}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getMESSAGE_TYPE()Ljava/lang/String;

    move-result-object v10

    sget-object v11, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v11}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getSPP_UUID_STR()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v10, v11}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getBTUUid(Ljava/lang/String;Ljava/lang/String;)Ljava/util/UUID;

    move-result-object v9

    .line 325
    invoke-virtual {v7, v8, v9}, Landroid/bluetooth/BluetoothAdapter;->listenUsingRfcommWithServiceRecord(Ljava/lang/String;Ljava/util/UUID;)Landroid/bluetooth/BluetoothServerSocket;

    move-result-object v7

    goto :goto_0

    :cond_0
    move-object v7, v4

    :goto_0
    invoke-static {v6, v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$setServerMessageSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothServerSocket;)V

    .line 329
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Message Bt Server \u5df2\u542f\u52a8 -- hashcode = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerMessageSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothServerSocket;

    move-result-object v7

    if-eqz v7, :cond_1

    invoke-virtual {v7}, Ljava/lang/Object;->hashCode()I

    move-result v7

    goto :goto_1

    :cond_1
    const/4 v7, 0x0

    :goto_1
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v3, v6}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 330
    :goto_2
    iget-object v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isMessageServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v6

    invoke-virtual {v6}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v6

    if-eqz v6, :cond_7

    invoke-static {v5}, Lkotlinx/coroutines/CoroutineScopeKt;->isActive(Lkotlinx/coroutines/CoroutineScope;)Z

    move-result v6

    if-eqz v6, :cond_7

    .line 331
    iget-object v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerMessageSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothServerSocket;

    move-result-object v6

    if-eqz v6, :cond_2

    invoke-virtual {v6}, Landroid/bluetooth/BluetoothServerSocket;->accept()Landroid/bluetooth/BluetoothSocket;

    move-result-object v6

    goto :goto_3

    :cond_2
    move-object v6, v4

    :goto_3
    move-object v9, v6

    .line 332
    .restart local v9    # "socket":Landroid/bluetooth/BluetoothSocket;
    if-eqz v9, :cond_6

    iget-object v8, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    move-object v7, v9

    .restart local v7    # "it":Landroid/bluetooth/BluetoothSocket;
    const/4 v6, 0x0

    .line 333
    .local v6, "$i$a$-let-ClassicBluetoothService$startMessageServer$1$1":I
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "connectedMessageSockets size = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-static {v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedMessageSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v11

    invoke-virtual {v11}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " ---- 111"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    filled-new-array {v10}, [Ljava/lang/Object;

    move-result-object v10

    invoke-static {v3, v10}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 334
    new-instance v10, Lkotlin/jvm/internal/Ref$BooleanRef;

    invoke-direct {v10}, Lkotlin/jvm/internal/Ref$BooleanRef;-><init>()V

    .line 335
    .local v10, "shouldReject":Lkotlin/jvm/internal/Ref$BooleanRef;
    invoke-static {v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMMutex$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v11

    new-instance v12, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1$1$1;

    invoke-direct {v12, v8, v9, v10, v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1$1$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Lkotlin/jvm/internal/Ref$BooleanRef;Lkotlin/coroutines/Continuation;)V

    check-cast v12, Lkotlin/jvm/functions/Function1;

    iput-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$0:Ljava/lang/Object;

    iput-object v9, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$1:Ljava/lang/Object;

    iput-object v8, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$2:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$3:Ljava/lang/Object;

    iput-object v10, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$4:Ljava/lang/Object;

    iput v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->label:I

    invoke-static {v8, v11, v12, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$withLockSafe(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlinx/coroutines/sync/Mutex;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v11

    if-ne v11, v0, :cond_3

    .line 322
    return-object v0

    .line 335
    :cond_3
    move-object v13, v10

    move-object v10, v5

    move v5, v6

    move-object v6, v13

    .line 350
    .local v5, "$i$a$-let-ClassicBluetoothService$startMessageServer$1$1":I
    .local v6, "shouldReject":Lkotlin/jvm/internal/Ref$BooleanRef;
    .local v10, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_4
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Message Socket shouldReject = "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-boolean v12, v6, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v11

    invoke-static {v3, v11}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 351
    iget-boolean v11, v6, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    if-nez v11, :cond_4

    .line 352
    .end local v6    # "shouldReject":Lkotlin/jvm/internal/Ref$BooleanRef;
    invoke-static {v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMainHandler$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/os/Handler;

    move-result-object v6

    new-instance v11, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1$$ExternalSyntheticLambda0;

    invoke-direct {v11, v9, v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1$$ExternalSyntheticLambda0;-><init>(Landroid/bluetooth/BluetoothSocket;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    invoke-virtual {v6, v11}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 356
    nop

    .end local v9    # "socket":Landroid/bluetooth/BluetoothSocket;
    sget-object v6, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getMESSAGE_TYPE()Ljava/lang/String;

    move-result-object v6

    invoke-static {v8, v7, v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$handleConnectedSocket(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V

    move-object v5, v10

    goto :goto_6

    .line 359
    .end local v7    # "it":Landroid/bluetooth/BluetoothSocket;
    .restart local v9    # "socket":Landroid/bluetooth/BluetoothSocket;
    :cond_4
    iput-object v10, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$0:Ljava/lang/Object;

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$1:Ljava/lang/Object;

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$2:Ljava/lang/Object;

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$3:Ljava/lang/Object;

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->L$4:Ljava/lang/Object;

    const/4 v6, 0x2

    iput v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->label:I

    invoke-static {v8, v9, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$rejectNewConnection(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v6
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .end local v9    # "socket":Landroid/bluetooth/BluetoothSocket;
    if-ne v6, v0, :cond_5

    .line 322
    return-object v0

    .line 359
    :cond_5
    move-object v6, v10

    .line 361
    .end local v10    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v6, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_5
    move-object v5, v6

    .line 332
    .end local v6    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v5, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_6
    goto/16 :goto_2

    :cond_6
    goto/16 :goto_2

    .line 364
    .end local v5    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catch_0
    move-exception v0

    .line 365
    .local v0, "e":Ljava/io/IOException;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Message Server socket closed: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v3, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 366
    iget-object v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$release(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    .line 368
    .end local v0    # "e":Ljava/io/IOException;
    :cond_7
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
