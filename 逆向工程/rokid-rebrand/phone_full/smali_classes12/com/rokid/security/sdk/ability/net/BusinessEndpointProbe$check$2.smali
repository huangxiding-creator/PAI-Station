.class final Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "BusinessEndpointProbe.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->check(Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
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
        "Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBusinessEndpointProbe.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BusinessEndpointProbe.kt\ncom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,108:1\n1#2:109\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\u008a@"
    }
    d2 = {
        "<anonymous>",
        "Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;",
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
    c = "com.rokid.security.sdk.ability.net.BusinessEndpointProbe$check$2"
    f = "BusinessEndpointProbe.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field private synthetic L$0:Ljava/lang/Object;

.field label:I


# direct methods
.method constructor <init>(Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x2

    invoke-direct {p0, v0, p1}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 1
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

    new-instance v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;

    invoke-direct {v0, p2}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;-><init>(Lkotlin/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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
            "Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 18

    const-string v1, " error="

    const-string v2, "BusinessEndpointProbe"

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 40
    move-object/from16 v3, p0

    iget v0, v3, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v4, p0

    .local v4, "this":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;
    move-object/from16 v5, p1

    .local v5, "$result":Ljava/lang/Object;
    iget-object v0, v4, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlinx/coroutines/CoroutineScope;

    .line 41
    .local v0, "$this$withContext":Lkotlinx/coroutines/CoroutineScope;
    sget-object v6, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->INSTANCE:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;

    invoke-static {v6}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->access$parseEndpoint(Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;)Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;

    move-result-object v6

    if-nez v6, :cond_0

    .end local v0    # "$this$withContext":Lkotlinx/coroutines/CoroutineScope;
    sget-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;->INVALID_ENDPOINT:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;

    return-object v0

    .line 42
    .restart local v0    # "$this$withContext":Lkotlinx/coroutines/CoroutineScope;
    .local v6, "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    :cond_0
    nop

    .line 47
    nop

    .end local v0    # "$this$withContext":Lkotlinx/coroutines/CoroutineScope;
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    .line 109
    const/4 v0, 0x0

    .line 47
    .local v0, "$i$a$-runCatching-BusinessEndpointProbe$check$2$context$1":I
    invoke-static {}, Lcom/rokid/security/sdk/ability/util/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object v7

    .end local v0    # "$i$a$-runCatching-BusinessEndpointProbe$check$2$context$1":I
    invoke-static {v7}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    sget-object v7, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    :goto_0
    invoke-static {v0}, Lkotlin/Result;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    const/4 v0, 0x0

    :cond_1
    check-cast v0, Landroid/app/Application;

    if-nez v0, :cond_2

    .line 48
    .end local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    sget-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;->SKIPPED:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;

    return-object v0

    .line 49
    .local v0, "context":Landroid/app/Application;
    .restart local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    :cond_2
    const-string v7, "connectivity"

    invoke-virtual {v0, v7}, Landroid/app/Application;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    .end local v0    # "context":Landroid/app/Application;
    instance-of v0, v7, Landroid/net/ConnectivityManager;

    if-eqz v0, :cond_3

    check-cast v7, Landroid/net/ConnectivityManager;

    goto :goto_1

    :cond_3
    const/4 v7, 0x0

    :goto_1
    if-nez v7, :cond_4

    .line 50
    .end local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    sget-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;->SKIPPED:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;

    return-object v0

    .line 49
    .restart local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    :cond_4
    move-object v0, v7

    .line 51
    .local v0, "cm":Landroid/net/ConnectivityManager;
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetwork()Landroid/net/Network;

    move-result-object v0

    .end local v0    # "cm":Landroid/net/ConnectivityManager;
    if-nez v0, :cond_5

    .end local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    sget-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;->NO_NETWORK:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;

    return-object v0

    .restart local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    :cond_5
    move-object v7, v0

    .line 52
    .local v7, "network":Landroid/net/Network;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;->getHost()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v9, 0x3a

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;->getPort()I

    move-result v10

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v10, 0x7c

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 53
    .local v10, "endpointKey":Ljava/lang/String;
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v11

    .line 54
    .local v11, "now":J
    invoke-static {}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->access$getLastReachableKey$p()Ljava/lang/String;

    move-result-object v0

    invoke-static {v10, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-static {}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->access$getLastReachableElapsed$p()J

    move-result-wide v13

    sub-long v13, v11, v13

    const-wide/16 v15, 0x3a98

    cmp-long v0, v13, v15

    if-gez v0, :cond_6

    .line 55
    .end local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    .end local v7    # "network":Landroid/net/Network;
    .end local v10    # "endpointKey":Ljava/lang/String;
    .end local v11    # "now":J
    sget-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;->REACHABLE:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;

    return-object v0

    .line 58
    .restart local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    .restart local v7    # "network":Landroid/net/Network;
    .restart local v10    # "endpointKey":Ljava/lang/String;
    :cond_6
    nop

    .line 59
    :try_start_1
    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;->getHost()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0}, Landroid/net/Network;->getAllByName(Ljava/lang/String;)[Ljava/net/InetAddress;

    move-result-object v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_5

    .line 58
    move-object v11, v0

    .line 64
    .local v11, "addresses":[Ljava/net/InetAddress;
    const-string v0, "addresses"

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    array-length v0, v11

    const/4 v12, 0x0

    if-nez v0, :cond_7

    const/4 v0, 0x1

    goto :goto_2

    :cond_7
    move v0, v12

    :goto_2
    if-eqz v0, :cond_8

    sget-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;->DNS_FAILED:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;

    return-object v0

    .line 66
    :cond_8
    const/4 v0, 0x0

    .line 67
    .local v0, "lastError":Ljava/lang/Throwable;
    nop

    .end local v11    # "addresses":[Ljava/net/InetAddress;
    array-length v13, v11

    :goto_3
    const-string v14, " port="

    if-ge v12, v13, :cond_9

    .end local v0    # "lastError":Ljava/lang/Throwable;
    aget-object v0, v11, v12

    .line 68
    .local v0, "address":Ljava/net/InetAddress;
    nop

    .line 69
    :try_start_2
    invoke-virtual {v7}, Landroid/net/Network;->getSocketFactory()Ljavax/net/SocketFactory;

    move-result-object v15

    invoke-virtual {v15}, Ljavax/net/SocketFactory;->createSocket()Ljava/net/Socket;

    move-result-object v15

    check-cast v15, Ljava/io/Closeable;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_4

    :try_start_3
    move-object/from16 v16, v15

    check-cast v16, Ljava/net/Socket;

    move-object/from16 p1, v16

    .local p1, "socket":Ljava/net/Socket;
    const/16 v16, 0x0

    .line 70
    .local v16, "$i$a$-use-BusinessEndpointProbe$check$2$1":I
    new-instance v9, Ljava/net/InetSocketAddress;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;->getPort()I

    move-result v8

    invoke-direct {v9, v0, v8}, Ljava/net/InetSocketAddress;-><init>(Ljava/net/InetAddress;I)V

    check-cast v9, Ljava/net/SocketAddress;

    const/16 v8, 0x7d0

    move-object/from16 v17, v0

    move-object/from16 v0, p1

    .end local p1    # "socket":Ljava/net/Socket;
    .local v0, "socket":Ljava/net/Socket;
    .local v17, "address":Ljava/net/InetAddress;
    invoke-virtual {v0, v9, v8}, Ljava/net/Socket;->connect(Ljava/net/SocketAddress;I)V

    .line 71
    .end local v17    # "address":Ljava/net/InetAddress;
    nop

    .end local v0    # "socket":Ljava/net/Socket;
    .end local v16    # "$i$a$-use-BusinessEndpointProbe$check$2$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 69
    const/4 v8, 0x0

    :try_start_4
    invoke-static {v15, v8}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 72
    sget-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->INSTANCE:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;

    invoke-static {v10}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->access$setLastReachableKey$p(Ljava/lang/String;)V

    .line 73
    sget-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->INSTANCE:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v15

    invoke-static/range {v15 .. v16}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->access$setLastReachableElapsed$p(J)V

    .line 74
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "endpoint reachable host="

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;->getHost()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;->getPort()I

    move-result v9

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v2, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 75
    sget-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;->REACHABLE:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    return-object v0

    .line 69
    :catchall_1
    move-exception v0

    const/4 v8, 0x0

    move-object v9, v0

    .end local v4    # "this":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    .end local v7    # "network":Landroid/net/Network;
    .end local v10    # "endpointKey":Ljava/lang/String;
    :try_start_5
    throw v9
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .restart local v4    # "this":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;
    .restart local v5    # "$result":Ljava/lang/Object;
    .restart local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    .restart local v7    # "network":Landroid/net/Network;
    .restart local v10    # "endpointKey":Ljava/lang/String;
    :catchall_2
    move-exception v0

    move-object v14, v0

    :try_start_6
    invoke-static {v15, v9}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v4    # "this":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    .end local v7    # "network":Landroid/net/Network;
    .end local v10    # "endpointKey":Ljava/lang/String;
    throw v14
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 76
    .restart local v4    # "this":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;
    .restart local v5    # "$result":Ljava/lang/Object;
    .restart local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    .restart local v7    # "network":Landroid/net/Network;
    .restart local v10    # "endpointKey":Ljava/lang/String;
    :catchall_3
    move-exception v0

    goto :goto_4

    :catchall_4
    move-exception v0

    const/4 v8, 0x0

    .line 77
    .local v0, "t":Ljava/lang/Throwable;
    :goto_4
    nop

    .line 67
    .local v0, "lastError":Ljava/lang/Throwable;
    add-int/lit8 v12, v12, 0x1

    const/16 v9, 0x3a

    goto/16 :goto_3

    :cond_9
    const/4 v8, 0x0

    .line 81
    .end local v7    # "network":Landroid/net/Network;
    .end local v10    # "endpointKey":Ljava/lang/String;
    nop

    .line 82
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "connect failed host="

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;->getHost()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;->getPort()I

    move-result v9

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 83
    .end local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    if-eqz v0, :cond_a

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    if-eqz v6, :cond_a

    invoke-virtual {v6}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v6

    goto :goto_5

    :cond_a
    move-object v6, v8

    .line 82
    :goto_5
    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v6, 0x3a

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 83
    nop

    .end local v0    # "lastError":Ljava/lang/Throwable;
    if-eqz v0, :cond_b

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v8

    .line 82
    :cond_b
    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    .line 80
    invoke-static {v2, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 85
    sget-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;->CONNECT_FAILED:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;

    return-object v0

    .line 60
    .restart local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    :catchall_5
    move-exception v0

    .line 61
    .local v0, "t":Ljava/lang/Throwable;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "DNS failed host="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;->getHost()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v7, 0x3a

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .end local v6    # "endpoint":Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 62
    sget-object v1, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;->DNS_FAILED:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
