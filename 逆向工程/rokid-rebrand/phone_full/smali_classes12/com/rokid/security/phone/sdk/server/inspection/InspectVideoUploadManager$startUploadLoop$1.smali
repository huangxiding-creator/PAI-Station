.class final Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "InspectVideoUploadManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->startUploadLoop()Lkotlinx/coroutines/Job;
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

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nInspectVideoUploadManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 InspectVideoUploadManager.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 Mutex.kt\nkotlinx/coroutines/sync/MutexKt\n*L\n1#1,259:1\n1#2:260\n120#3,10:261\n*S KotlinDebug\n*F\n+ 1 InspectVideoUploadManager.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1\n*L\n65#1:261,10\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.inspection.InspectVideoUploadManager$startUploadLoop$1"
    f = "InspectVideoUploadManager.kt"
    i = {
        0x0,
        0x0,
        0x0,
        0x1,
        0x1,
        0x1,
        0x2
    }
    l = {
        0x10a,
        0x44,
        0x55
    }
    m = "invokeSuspend"
    n = {
        "$this$launch",
        "nextVideo",
        "$this$withLock_u24default$iv",
        "$this$launch",
        "nextVideo",
        "$this$withLock_u24default$iv",
        "$this$launch"
    }
    s = {
        "L$0",
        "L$1",
        "L$2",
        "L$0",
        "L$1",
        "L$2",
        "L$0"
    }
.end annotation


# instance fields
.field private synthetic L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    invoke-direct {v0, v1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;Lkotlin/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 14

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 59
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->label:I

    const/4 v2, 0x0

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v1, p0

    .local v1, "this":Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    check-cast v3, Lkotlinx/coroutines/CoroutineScope;

    .local v3, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_9

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;
    .end local v3    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    move-object v1, p0

    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    const/4 v3, 0x0

    .local v3, "$i$f$withLock":I
    const/4 v4, 0x0

    .local v4, "$i$a$-withLock$default-InspectVideoUploadManager$startUploadLoop$1$1":I
    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$3:Ljava/lang/Object;

    check-cast v5, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    const/4 v6, 0x0

    .local v6, "owner$iv":Ljava/lang/Object;
    iget-object v7, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$2:Ljava/lang/Object;

    check-cast v7, Lkotlinx/coroutines/sync/Mutex;

    .local v7, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    iget-object v8, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$1:Ljava/lang/Object;

    check-cast v8, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    .local v8, "nextVideo":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    iget-object v9, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    check-cast v9, Lkotlinx/coroutines/CoroutineScope;

    .local v9, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_4

    .line 270
    .end local v4    # "$i$a$-withLock$default-InspectVideoUploadManager$startUploadLoop$1$1":I
    .end local v8    # "nextVideo":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    .end local v9    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_0
    move-exception v0

    goto/16 :goto_7

    .line 79
    .restart local v4    # "$i$a$-withLock$default-InspectVideoUploadManager$startUploadLoop$1$1":I
    .restart local v8    # "nextVideo":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    .restart local v9    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catch_0
    move-exception v10

    goto/16 :goto_5

    .line 59
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;
    .end local v3    # "$i$f$withLock":I
    .end local v4    # "$i$a$-withLock$default-InspectVideoUploadManager$startUploadLoop$1$1":I
    .end local v6    # "owner$iv":Ljava/lang/Object;
    .end local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .end local v8    # "nextVideo":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    .end local v9    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_2
    move-object v1, p0

    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    const/4 v3, 0x0

    .restart local v3    # "$i$f$withLock":I
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$3:Ljava/lang/Object;

    check-cast v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    const/4 v5, 0x0

    .local v5, "owner$iv":Ljava/lang/Object;
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$2:Ljava/lang/Object;

    check-cast v6, Lkotlinx/coroutines/sync/Mutex;

    .local v6, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    iget-object v7, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$1:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    .local v7, "nextVideo":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    iget-object v8, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    check-cast v8, Lkotlinx/coroutines/CoroutineScope;

    .local v8, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v9, v8

    move-object v8, v7

    move-object v7, v6

    move-object v6, v5

    move-object v5, v4

    goto/16 :goto_3

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;
    .end local v3    # "$i$f$withLock":I
    .end local v5    # "owner$iv":Ljava/lang/Object;
    .end local v6    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .end local v7    # "nextVideo":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    .end local v8    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_3
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    check-cast v3, Lkotlinx/coroutines/CoroutineScope;

    .line 60
    .local v3, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_0
    invoke-static {v3}, Lkotlinx/coroutines/CoroutineScopeKt;->isActive(Lkotlinx/coroutines/CoroutineScope;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 61
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->getUploadEnabled()Lkotlinx/coroutines/flow/StateFlow;

    move-result-object v4

    invoke-interface {v4}, Lkotlinx/coroutines/flow/StateFlow;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Boolean;

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    if-eqz v4, :cond_4

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$getGetIsInspection$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Lkotlin/jvm/functions/Function0;

    move-result-object v4

    invoke-interface {v4}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Boolean;

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    if-nez v4, :cond_4

    .line 62
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$getVideoQueue$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Ljava/util/List;

    move-result-object v4

    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    monitor-enter v4

    .line 260
    const/4 v6, 0x0

    .line 62
    .local v6, "$i$a$-synchronized-InspectVideoUploadManager$startUploadLoop$1$nextVideo$1":I
    :try_start_1
    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$getVideoQueue$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Ljava/util/List;

    move-result-object v5

    invoke-static {v5}, Lkotlin/collections/CollectionsKt;->firstOrNull(Ljava/util/List;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .end local v6    # "$i$a$-synchronized-InspectVideoUploadManager$startUploadLoop$1$nextVideo$1":I
    monitor-exit v4

    move-object v4, v5

    .line 63
    .local v4, "nextVideo":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "startUploadLoop "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    if-eqz v4, :cond_0

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->isUploading()Z

    move-result v7

    invoke-static {v7}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v7

    goto :goto_1

    :cond_0
    move-object v7, v2

    :goto_1
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const/16 v7, 0x20

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v6

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getFilePath()Ljava/lang/String;

    move-result-object v7

    goto :goto_2

    :cond_1
    move-object v7, v2

    :goto_2
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 64
    if-eqz v4, :cond_4

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->isUploading()Z

    move-result v5

    if-nez v5, :cond_4

    .line 65
    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$getUploadMutex$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v5

    .local v5, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    .line 261
    const/4 v7, 0x0

    .local v7, "owner$iv":Ljava/lang/Object;
    const/4 v8, 0x0

    .line 262
    .local v8, "$i$f$withLock":I
    nop

    .line 266
    move-object v9, v1

    check-cast v9, Lkotlin/coroutines/Continuation;

    iput-object v3, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    iput-object v4, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$1:Ljava/lang/Object;

    iput-object v5, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$2:Ljava/lang/Object;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$3:Ljava/lang/Object;

    const/4 v10, 0x1

    iput v10, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->label:I

    invoke-interface {v5, v7, v9}, Lkotlinx/coroutines/sync/Mutex;->lock(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v9

    if-ne v9, v0, :cond_2

    .line 59
    return-object v0

    .line 266
    :cond_2
    move-object v9, v3

    move v3, v8

    move-object v8, v4

    move-object v13, v7

    move-object v7, v5

    move-object v5, v6

    move-object v6, v13

    .line 267
    .end local v4    # "nextVideo":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    .end local v5    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .local v3, "$i$f$withLock":I
    .local v6, "owner$iv":Ljava/lang/Object;
    .local v7, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .local v8, "nextVideo":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    .restart local v9    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_3
    nop

    .line 268
    const/4 v4, 0x0

    .line 66
    .local v4, "$i$a$-withLock$default-InspectVideoUploadManager$startUploadLoop$1$1":I
    nop

    .line 67
    :try_start_2
    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Ljava/lang/String;

    move-result-object v10

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "\u2b06\ufe0f Requesting upload for "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getFilePath()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 68
    new-instance v10, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1$1$1;

    invoke-direct {v10, v8}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1$1$1;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;)V

    check-cast v10, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iput-object v9, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    iput-object v8, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$1:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$2:Ljava/lang/Object;

    iput-object v5, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$3:Ljava/lang/Object;

    const/4 v11, 0x2

    iput v11, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->label:I

    invoke-static {v5, v8, v10, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$performUpload(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v10

    if-ne v10, v0, :cond_3

    .line 59
    return-object v0

    .line 68
    :cond_3
    :goto_4
    sget-object v5, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_6

    .line 80
    .local v10, "e":Ljava/lang/Exception;
    :goto_5
    :try_start_3
    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Ljava/lang/String;

    move-result-object v5

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "\u274c Upload dispatch failed for "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getFilePath()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v12, v10

    check-cast v12, Ljava/lang/Throwable;

    invoke-static {v5, v11, v12}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v5

    invoke-static {v5}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 66
    .end local v8    # "nextVideo":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    .end local v10    # "e":Ljava/lang/Exception;
    :goto_6
    nop

    .line 268
    .end local v4    # "$i$a$-withLock$default-InspectVideoUploadManager$startUploadLoop$1$1":I
    nop

    .line 270
    invoke-interface {v7, v6}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    .line 268
    .end local v6    # "owner$iv":Ljava/lang/Object;
    .end local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    move-object v3, v9

    goto :goto_8

    .line 270
    .end local v9    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v6    # "owner$iv":Ljava/lang/Object;
    .restart local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :goto_7
    invoke-interface {v7, v6}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    throw v0

    .line 62
    .end local v3    # "$i$f$withLock":I
    .end local v6    # "owner$iv":Ljava/lang/Object;
    .end local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :catchall_1
    move-exception v0

    monitor-exit v4

    throw v0

    .line 85
    .local v3, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :cond_4
    :goto_8
    move-object v4, v1

    check-cast v4, Lkotlin/coroutines/Continuation;

    iput-object v3, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    iput-object v2, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$1:Ljava/lang/Object;

    iput-object v2, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$2:Ljava/lang/Object;

    iput-object v2, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->L$3:Ljava/lang/Object;

    const/4 v5, 0x3

    iput v5, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->label:I

    const-wide/16 v5, 0x1388

    invoke-static {v5, v6, v4}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v4

    if-ne v4, v0, :cond_5

    .line 59
    return-object v0

    .line 85
    :cond_5
    :goto_9
    goto/16 :goto_0

    .line 87
    :cond_6
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
