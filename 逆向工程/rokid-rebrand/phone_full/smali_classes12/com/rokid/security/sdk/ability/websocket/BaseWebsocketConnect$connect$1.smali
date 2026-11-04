.class final Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "BaseWebsocketConnect.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->connect(Lcom/rokid/security/sdk/ability/bean/BaseConfig;)V
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
    value = "SMAP\nBaseWebsocketConnect.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BaseWebsocketConnect.kt\ncom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1\n+ 2 Mutex.kt\nkotlinx/coroutines/sync/MutexKt\n+ 3 _Maps.kt\nkotlin/collections/MapsKt___MapsKt\n*L\n1#1,419:1\n120#2,10:420\n215#3,2:430\n*S KotlinDebug\n*F\n+ 1 BaseWebsocketConnect.kt\ncom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1\n*L\n178#1:420,10\n196#1:430,2\n*E\n"
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
    c = "com.rokid.security.sdk.ability.websocket.BaseWebsocketConnect$connect$1"
    f = "BaseWebsocketConnect.kt"
    i = {
        0x0,
        0x1
    }
    l = {
        0x1a9,
        0xb6
    }
    m = "invokeSuspend"
    n = {
        "$this$withLock_u24default$iv",
        "$this$withLock_u24default$iv"
    }
    s = {
        "L$0",
        "L$0"
    }
.end annotation


# instance fields
.field final synthetic $config:Lcom/rokid/security/sdk/ability/bean/BaseConfig;

.field L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lcom/rokid/security/sdk/ability/bean/BaseConfig;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;",
            "Lcom/rokid/security/sdk/ability/bean/BaseConfig;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->$config:Lcom/rokid/security/sdk/ability/bean/BaseConfig;

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

    new-instance v0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->$config:Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;-><init>(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lcom/rokid/security/sdk/ability/bean/BaseConfig;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 17

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 177
    move-object/from16 v1, p0

    iget v2, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->label:I

    const/4 v3, 0x1

    packed-switch v2, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v2, p0

    .local v2, "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;
    move-object/from16 v4, p1

    .local v4, "$result":Ljava/lang/Object;
    const/4 v5, 0x0

    .local v5, "$i$f$withLock":I
    const/4 v0, 0x0

    .local v0, "$i$a$-withLock$default-BaseWebsocketConnect$connect$1$1":I
    iget-object v6, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$2:Ljava/lang/Object;

    check-cast v6, Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    iget-object v7, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$1:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    const/4 v8, 0x0

    .local v8, "owner$iv":Ljava/lang/Object;
    iget-object v9, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$0:Ljava/lang/Object;

    check-cast v9, Lkotlinx/coroutines/sync/Mutex;

    .local v9, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :try_start_0
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_1

    .line 429
    .end local v0    # "$i$a$-withLock$default-BaseWebsocketConnect$connect$1$1":I
    :catchall_0
    move-exception v0

    goto/16 :goto_4

    .line 177
    .end local v2    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$withLock":I
    .end local v8    # "owner$iv":Ljava/lang/Object;
    .end local v9    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :pswitch_1
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    const/4 v5, 0x0

    .restart local v5    # "$i$f$withLock":I
    iget-object v6, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$2:Ljava/lang/Object;

    check-cast v6, Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    iget-object v7, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$1:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    const/4 v8, 0x0

    .restart local v8    # "owner$iv":Ljava/lang/Object;
    iget-object v9, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$0:Ljava/lang/Object;

    check-cast v9, Lkotlinx/coroutines/sync/Mutex;

    .restart local v9    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_0

    .end local v2    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$withLock":I
    .end local v8    # "owner$iv":Ljava/lang/Object;
    .end local v9    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :pswitch_2
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;
    move-object/from16 v4, p1

    .line 178
    .restart local v4    # "$result":Ljava/lang/Object;
    iget-object v5, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->getConnectMutex()Lkotlinx/coroutines/sync/Mutex;

    move-result-object v5

    .local v5, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    iget-object v6, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    iget-object v7, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->$config:Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    .line 420
    const/4 v8, 0x0

    .restart local v8    # "owner$iv":Ljava/lang/Object;
    const/4 v9, 0x0

    .line 421
    .local v9, "$i$f$withLock":I
    nop

    .line 425
    move-object v10, v2

    check-cast v10, Lkotlin/coroutines/Continuation;

    iput-object v5, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$0:Ljava/lang/Object;

    iput-object v6, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$1:Ljava/lang/Object;

    iput-object v7, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$2:Ljava/lang/Object;

    iput v3, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->label:I

    invoke-interface {v5, v8, v10}, Lkotlinx/coroutines/sync/Mutex;->lock(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v10

    if-ne v10, v0, :cond_0

    .line 177
    return-object v0

    .line 425
    :cond_0
    move v15, v9

    move-object v9, v5

    move v5, v15

    move-object/from16 v16, v7

    move-object v7, v6

    move-object/from16 v6, v16

    .line 426
    .local v5, "$i$f$withLock":I
    .local v9, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :goto_0
    nop

    .line 427
    const/4 v10, 0x0

    .line 179
    .local v10, "$i$a$-withLock$default-BaseWebsocketConnect$connect$1$1":I
    :try_start_1
    invoke-static {v7}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getRecJob$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Lkotlinx/coroutines/Job;

    move-result-object v11

    if-eqz v11, :cond_1

    const/4 v12, 0x0

    invoke-static {v11, v12, v3, v12}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 180
    :cond_1
    invoke-static {v7}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$cleanupWebSocket(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)V

    .line 182
    iput-object v9, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$0:Ljava/lang/Object;

    iput-object v7, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$1:Ljava/lang/Object;

    iput-object v6, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->L$2:Ljava/lang/Object;

    const/4 v11, 0x2

    iput v11, v2, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;->label:I

    const-wide/16 v11, 0x12c

    invoke-static {v11, v12, v2}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v11

    if-ne v11, v0, :cond_2

    .line 177
    return-object v0

    .line 182
    :cond_2
    move v0, v10

    .line 183
    .end local v10    # "$i$a$-withLock$default-BaseWebsocketConnect$connect$1$1":I
    .restart local v0    # "$i$a$-withLock$default-BaseWebsocketConnect$connect$1$1":I
    :goto_1
    invoke-static {v7}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isClosed$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v10

    invoke-virtual {v10}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v10

    if-nez v10, :cond_6

    .line 185
    sget-object v10, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v10}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->ensureBusinessHeaders()V

    .line 186
    sget-object v10, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v10}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v10

    check-cast v10, Ljava/util/Map;

    invoke-virtual {v7, v10}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->setMHeaderMap(Ljava/util/Map;)V

    .line 187
    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getServerUrl()Ljava/lang/String;

    move-result-object v10

    if-nez v10, :cond_3

    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 429
    .end local v0    # "$i$a$-withLock$default-BaseWebsocketConnect$connect$1$1":I
    .end local v5    # "$i$f$withLock":I
    .end local v8    # "owner$iv":Ljava/lang/Object;
    .end local v9    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    invoke-interface {v9, v8}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    return-object v3

    .restart local v0    # "$i$a$-withLock$default-BaseWebsocketConnect$connect$1$1":I
    .restart local v5    # "$i$f$withLock":I
    .restart local v8    # "owner$iv":Ljava/lang/Object;
    .restart local v9    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :cond_3
    nop

    .line 189
    .local v10, "serverUrl":Ljava/lang/String;
    :try_start_2
    invoke-static {v7, v10}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$buildPrefixedWebSocketUrl(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    move-object v10, v11

    .line 190
    invoke-static {v7}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getTAG$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/lang/String;

    move-result-object v11

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "connect endpointConfigured="

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    move-object v13, v10

    check-cast v13, Ljava/lang/CharSequence;

    invoke-static {v13}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v13

    if-nez v13, :cond_4

    goto :goto_2

    :cond_4
    const/4 v3, 0x0

    :goto_2
    invoke-virtual {v12, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v11, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 191
    invoke-virtual {v7, v6}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->setConfig(Lcom/rokid/security/sdk/ability/bean/BaseConfig;)V

    .line 193
    new-instance v3, Lokhttp3/Request$Builder;

    invoke-direct {v3}, Lokhttp3/Request$Builder;-><init>()V

    .line 194
    invoke-virtual {v3, v10}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v3

    .line 193
    .end local v10    # "serverUrl":Ljava/lang/String;
    nop

    .line 196
    .local v3, "requestBuilder":Lokhttp3/Request$Builder;
    invoke-virtual {v7}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->getMHeaderMap()Ljava/util/Map;

    move-result-object v6

    .local v6, "$this$forEach$iv":Ljava/util/Map;
    const/4 v10, 0x0

    .line 430
    .local v10, "$i$f$forEach":I
    invoke-interface {v6}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v11

    invoke-interface {v11}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v11

    .end local v6    # "$this$forEach$iv":Ljava/util/Map;
    :goto_3
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_5

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Map$Entry;

    .local v6, "element$iv":Ljava/util/Map$Entry;
    const/4 v12, 0x0

    .line 196
    .local v12, "$i$a$-forEach-BaseWebsocketConnect$connect$1$1$1":I
    invoke-interface {v6}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    .local v13, "key":Ljava/lang/String;
    invoke-interface {v6}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .line 197
    .local v14, "value":Ljava/lang/String;
    invoke-virtual {v3, v13, v14}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 198
    nop

    .end local v6    # "element$iv":Ljava/util/Map$Entry;
    .end local v12    # "$i$a$-forEach-BaseWebsocketConnect$connect$1$1$1":I
    .end local v13    # "key":Ljava/lang/String;
    .end local v14    # "value":Ljava/lang/String;
    goto :goto_3

    .line 431
    :cond_5
    nop

    .line 199
    .end local v10    # "$i$f$forEach":I
    invoke-static {v7}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getTAG$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/lang/String;

    move-result-object v6

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "WebSocket headers added count="

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v7}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->getMHeaderMap()Ljava/util/Map;

    move-result-object v11

    invoke-interface {v11}, Ljava/util/Map;->size()I

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    filled-new-array {v10}, [Ljava/lang/Object;

    move-result-object v10

    invoke-static {v6, v10}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 200
    invoke-virtual {v3}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v6

    .line 201
    .local v6, "request":Lokhttp3/Request;
    const-string v10, "request"

    invoke-static {v6, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {v7, v6}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$openWebSocket(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/Request;)V

    .line 202
    nop

    .end local v0    # "$i$a$-withLock$default-BaseWebsocketConnect$connect$1$1":I
    .end local v3    # "requestBuilder":Lokhttp3/Request$Builder;
    .end local v6    # "request":Lokhttp3/Request;
    :cond_6
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 427
    nop

    .line 429
    invoke-interface {v9, v8}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    .line 427
    .end local v8    # "owner$iv":Ljava/lang/Object;
    .end local v9    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    nop

    .line 203
    .end local v5    # "$i$f$withLock":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 429
    .restart local v5    # "$i$f$withLock":I
    .restart local v8    # "owner$iv":Ljava/lang/Object;
    .restart local v9    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :goto_4
    invoke-interface {v9, v8}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    throw v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
