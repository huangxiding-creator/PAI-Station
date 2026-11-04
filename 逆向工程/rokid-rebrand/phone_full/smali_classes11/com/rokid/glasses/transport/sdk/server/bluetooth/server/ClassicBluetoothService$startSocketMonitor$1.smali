.class final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ClassicBluetoothService.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startSocketMonitor()V
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
    c = "com.rokid.glasses.transport.sdk.server.bluetooth.server.ClassicBluetoothService$startSocketMonitor$1"
    f = "ClassicBluetoothService.kt"
    i = {
        0x0
    }
    l = {
        0x245
    }
    m = "invokeSuspend"
    n = {
        "$this$launch"
    }
    s = {
        "L$0"
    }
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
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

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

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-direct {v0, v1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 10

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 579
    iget v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->label:I

    const/4 v2, 0x1

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v1, p0

    .local v1, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->L$0:Ljava/lang/Object;

    check-cast v3, Lkotlinx/coroutines/CoroutineScope;

    .local v3, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_1

    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;
    .end local v3    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .restart local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    iget-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->L$0:Ljava/lang/Object;

    check-cast v3, Lkotlinx/coroutines/CoroutineScope;

    .line 580
    .restart local v3    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :cond_0
    :goto_0
    invoke-static {v3}, Lkotlinx/coroutines/CoroutineScopeKt;->isActive(Lkotlinx/coroutines/CoroutineScope;)Z

    move-result v4

    if-eqz v4, :cond_d

    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isMonitorRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Z

    move-result v4

    if-eqz v4, :cond_d

    .line 581
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMonitorInterval$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)J

    move-result-wide v4

    move-object v6, v1

    check-cast v6, Lkotlin/coroutines/Continuation;

    iput-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->L$0:Ljava/lang/Object;

    iput v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->label:I

    invoke-static {v4, v5, v6}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v4

    if-ne v4, v0, :cond_1

    .line 579
    return-object v0

    .line 582
    :cond_1
    :goto_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "---MonitorSocket messageRunState = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isMessageServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v5

    invoke-virtual {v5}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", audioRunState = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isAudioServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v5

    invoke-virtual {v5}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", streamRunState = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isStreamServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v5

    invoke-virtual {v5}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", fileRunState = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isFileServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v5

    invoke-virtual {v5}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    const-string v5, "ClassicBluetoothService "

    invoke-static {v5, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 584
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isMessageServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v4

    const/4 v6, 0x0

    const-string v7, ",isActive = "

    const/4 v8, 0x0

    if-nez v4, :cond_4

    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerSocketJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;

    move-result-object v4

    if-eqz v4, :cond_2

    invoke-interface {v4}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v4

    if-ne v4, v2, :cond_2

    move v4, v2

    goto :goto_2

    :cond_2
    move v4, v8

    :goto_2
    if-nez v4, :cond_4

    .line 585
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, " isMessageServerRunning = "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v8, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isMessageServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v8

    invoke-virtual {v8}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v8

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerSocketJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;

    move-result-object v7

    if-eqz v7, :cond_3

    invoke-interface {v7}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v6

    invoke-static {v6}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v6

    :cond_3
    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, ", Message server socket is not alive, restarting..."

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v5, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 586
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$restartServer(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    goto/16 :goto_0

    .line 588
    :cond_4
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isAudioServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v4

    if-nez v4, :cond_7

    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerSocketAudioJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;

    move-result-object v4

    if-eqz v4, :cond_5

    invoke-interface {v4}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v4

    if-ne v4, v2, :cond_5

    move v4, v2

    goto :goto_3

    :cond_5
    move v4, v8

    :goto_3
    if-nez v4, :cond_7

    .line 589
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, " isAudioServerRunning = "

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v9, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isAudioServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v9

    invoke-virtual {v9}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v9

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v9, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerSocketAudioJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;

    move-result-object v9

    if-eqz v9, :cond_6

    invoke-interface {v9}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v9

    invoke-static {v9}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v9

    goto :goto_4

    :cond_6
    move-object v9, v6

    :goto_4
    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v9, ",  Audio server socket is not alive, restarting..."

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v5, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 590
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$startAudioServer(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    .line 592
    :cond_7
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isStreamServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v4

    if-nez v4, :cond_a

    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerSocketStreamJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;

    move-result-object v4

    if-eqz v4, :cond_8

    invoke-interface {v4}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v4

    if-ne v4, v2, :cond_8

    move v4, v2

    goto :goto_5

    :cond_8
    move v4, v8

    :goto_5
    if-nez v4, :cond_a

    .line 593
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, " isStreamServerRunning = "

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v9, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isStreamServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v9

    invoke-virtual {v9}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v9

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v9, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerSocketStreamJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;

    move-result-object v9

    if-eqz v9, :cond_9

    invoke-interface {v9}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v9

    invoke-static {v9}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v9

    goto :goto_6

    :cond_9
    move-object v9, v6

    :goto_6
    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v9, ",  Stream server socket is not alive, restarting..."

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v5, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 594
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$startStreamServer(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    .line 596
    :cond_a
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isFileServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v4

    if-nez v4, :cond_0

    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerSocketFileJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;

    move-result-object v4

    if-eqz v4, :cond_b

    invoke-interface {v4}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v4

    if-ne v4, v2, :cond_b

    move v8, v2

    :cond_b
    if-nez v8, :cond_0

    .line 597
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, " isFileServerRunning = "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v8, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$isFileServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v8

    invoke-virtual {v8}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v8

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerSocketFileJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;

    move-result-object v7

    if-eqz v7, :cond_c

    invoke-interface {v7}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v6

    invoke-static {v6}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v6

    :cond_c
    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, ",  File server socket is not alive, restarting..."

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v5, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 598
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$startFileServer(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    goto/16 :goto_0

    .line 602
    .end local v3    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :cond_d
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
