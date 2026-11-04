.class final Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "P2PGOManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;->invoke(Ljava/util/List;)V
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
    value = "SMAP\nP2PGOManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PGOManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2\n+ 2 Mutex.kt\nkotlinx/coroutines/sync/MutexKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,771:1\n120#2,10:772\n1855#3,2:782\n1855#3,2:784\n*S KotlinDebug\n*F\n+ 1 P2PGOManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2\n*L\n162#1:772,10\n221#1:782,2\n199#1:784,2\n*E\n"
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
    c = "com.rokid.glasses.transport.sdk.server.wifip2p.groupowner.P2PGOManager$registerReceiver$1$onReceive$3$2"
    f = "P2PGOManager.kt"
    i = {
        0x0,
        0x1,
        0x2,
        0x3,
        0x3,
        0x3
    }
    l = {
        0x309,
        0xa3,
        0xa4,
        0xcd
    }
    m = "invokeSuspend"
    n = {
        "$this$withLock_u24default$iv",
        "$this$withLock_u24default$iv",
        "$this$withLock_u24default$iv",
        "$this$withLock_u24default$iv",
        "hostAddress",
        "count"
    }
    s = {
        "L$0",
        "L$0",
        "L$0",
        "L$0",
        "L$2",
        "I$0"
    }
.end annotation


# instance fields
.field I$0:I

.field L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;


# direct methods
.method public static synthetic $r8$lambda$wBVTff76kZbIy7ZNRx3xyk-F2u8(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->invokeSuspend$lambda$3$lambda$1(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/net/wifi/p2p/WifiP2pInfo;)V

    return-void
.end method

.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p2}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method

.method private static final invokeSuspend$lambda$3$lambda$1(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 7
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;
    .param p1, "$hostAddress"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p2, "it"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 177
    iget-boolean v0, p2, Landroid/net/wifi/p2p/WifiP2pInfo;->groupFormed:Z

    if-eqz v0, :cond_4

    iget-boolean v0, p2, Landroid/net/wifi/p2p/WifiP2pInfo;->isGroupOwner:Z

    if-eqz v0, :cond_4

    .line 178
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMSocketServerChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->isServerRunning()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 179
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " initWebsocketServer \u5df2\u7ecf\u542f\u52a8\u4e86, \u4e0d\u9700\u8981\u91cd\u590d\u542f\u52a8"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    .line 182
    :cond_0
    iget-object v0, p2, Landroid/net/wifi/p2p/WifiP2pInfo;->groupOwnerAddress:Ljava/net/InetAddress;

    .line 183
    .local v0, "groupOwnerAddress":Ljava/net/InetAddress;
    if-nez v0, :cond_1

    .line 184
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "groupOwnerAddress \u4e3a\u7a7a\uff0cWebsocketServer\u65e0\u6cd5\u542f\u52a8"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 185
    return-void

    .line 187
    :cond_1
    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    .line 188
    .local v1, "hostAddress2":Ljava/lang/String;
    if-nez v1, :cond_2

    .line 189
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "hostAddress \u4e3a\u7a7a\uff0cWebsocketServer\u65e0\u6cd5\u542f\u52a8"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 190
    return-void

    .line 192
    :cond_2
    iput-object v1, p1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 193
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMSocketServerChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    move-result-object v2

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->close()V

    .line 194
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMSocketServerChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    move-result-object v2

    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMSocketServerListener$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$mSocketServerListener$1;

    move-result-object v3

    check-cast v3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    invoke-virtual {v2, v3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->setSocketServerListener(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;)V

    .line 195
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMSocketServerChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->initWebsocketServer(Ljava/lang/String;)V

    .line 196
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v2

    const-string v3, " initWebsocketServer \u542f\u52a8"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 199
    .end local v0    # "groupOwnerAddress":Ljava/net/InetAddress;
    .end local v1    # "hostAddress2":Ljava/lang/String;
    :goto_0
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 784
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .local v4, "it2":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/4 v5, 0x0

    .line 200
    .local v5, "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$3$2$1$1$1":I
    const-string v6, "it"

    invoke-static {p2, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v4, p2}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onConnectionInfoAvailable(Landroid/net/wifi/p2p/WifiP2pInfo;)V

    .line 201
    nop

    .line 784
    .end local v4    # "it2":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v5    # "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$3$2$1$1$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 785
    :cond_3
    nop

    .line 203
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    :cond_4
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

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-direct {v0, v1, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 17

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 161
    move-object/from16 v1, p0

    iget v2, v1, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->label:I

    const/4 v3, 0x0

    const/4 v4, 0x1

    packed-switch v2, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v2, p0

    .local v2, "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;
    move-object/from16 v5, p1

    .local v5, "$result":Ljava/lang/Object;
    const/4 v6, 0x0

    .local v6, "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    const/4 v7, 0x0

    .local v7, "$i$f$withLock":I
    iget v8, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->I$0:I

    .local v8, "count":I
    iget-object v9, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$2:Ljava/lang/Object;

    check-cast v9, Lkotlin/jvm/internal/Ref$ObjectRef;

    .local v9, "hostAddress":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object v10, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$1:Ljava/lang/Object;

    check-cast v10, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    const/4 v11, 0x0

    .local v11, "owner$iv":Ljava/lang/Object;
    iget-object v12, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$0:Ljava/lang/Object;

    check-cast v12, Lkotlinx/coroutines/sync/Mutex;

    .local v12, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :try_start_0
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move/from16 v16, v6

    move-object v6, v5

    move v5, v8

    move v8, v7

    move/from16 v7, v16

    goto/16 :goto_6

    .end local v2    # "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v6    # "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    .end local v7    # "$i$f$withLock":I
    .end local v8    # "count":I
    .end local v9    # "hostAddress":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v11    # "owner$iv":Ljava/lang/Object;
    .end local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :pswitch_1
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;
    move-object/from16 v5, p1

    .restart local v5    # "$result":Ljava/lang/Object;
    const/4 v7, 0x0

    .restart local v7    # "$i$f$withLock":I
    const/4 v6, 0x0

    .restart local v6    # "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    iget-object v8, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$1:Ljava/lang/Object;

    check-cast v8, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    iget-object v9, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$0:Ljava/lang/Object;

    check-cast v9, Lkotlinx/coroutines/sync/Mutex;

    const/4 v10, 0x0

    :try_start_1
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object v12, v9

    move-object v9, v8

    move v8, v7

    move v7, v6

    move-object v6, v5

    goto/16 :goto_2

    .line 781
    .end local v6    # "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    :catchall_0
    move-exception v0

    move-object v12, v9

    .restart local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    move-object v11, v10

    .restart local v11    # "owner$iv":Ljava/lang/Object;
    goto/16 :goto_b

    .line 161
    .end local v2    # "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v7    # "$i$f$withLock":I
    .end local v11    # "owner$iv":Ljava/lang/Object;
    .end local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :pswitch_2
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;
    move-object/from16 v5, p1

    .restart local v5    # "$result":Ljava/lang/Object;
    const/4 v7, 0x0

    .restart local v7    # "$i$f$withLock":I
    const/4 v6, 0x0

    .restart local v6    # "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    iget-object v8, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$1:Ljava/lang/Object;

    check-cast v8, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    const/4 v11, 0x0

    .restart local v11    # "owner$iv":Ljava/lang/Object;
    iget-object v9, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$0:Ljava/lang/Object;

    move-object v12, v9

    check-cast v12, Lkotlinx/coroutines/sync/Mutex;

    .restart local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :try_start_2
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_1

    .line 781
    .end local v6    # "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    :catchall_1
    move-exception v0

    goto/16 :goto_b

    .line 161
    .end local v2    # "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v7    # "$i$f$withLock":I
    .end local v11    # "owner$iv":Ljava/lang/Object;
    .end local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :pswitch_3
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;
    move-object/from16 v5, p1

    .restart local v5    # "$result":Ljava/lang/Object;
    const/4 v6, 0x0

    .local v6, "$i$f$withLock":I
    iget-object v7, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$1:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    const/4 v8, 0x0

    .local v8, "owner$iv":Ljava/lang/Object;
    iget-object v9, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$0:Ljava/lang/Object;

    check-cast v9, Lkotlinx/coroutines/sync/Mutex;

    .local v9, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v11, v8

    move-object v12, v9

    goto :goto_0

    .end local v2    # "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v6    # "$i$f$withLock":I
    .end local v8    # "owner$iv":Ljava/lang/Object;
    .end local v9    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :pswitch_4
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;
    move-object/from16 v5, p1

    .line 162
    .restart local v5    # "$result":Ljava/lang/Object;
    iget-object v6, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMutex$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v6

    .local v6, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    iget-object v7, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    .line 772
    const/4 v8, 0x0

    .restart local v8    # "owner$iv":Ljava/lang/Object;
    const/4 v9, 0x0

    .line 773
    .local v9, "$i$f$withLock":I
    nop

    .line 777
    move-object v10, v2

    check-cast v10, Lkotlin/coroutines/Continuation;

    iput-object v6, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$0:Ljava/lang/Object;

    iput-object v7, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$1:Ljava/lang/Object;

    iput v4, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->label:I

    invoke-interface {v6, v8, v10}, Lkotlinx/coroutines/sync/Mutex;->lock(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v10

    if-ne v10, v0, :cond_0

    .line 161
    return-object v0

    .line 777
    :cond_0
    move-object v12, v6

    move-object v11, v8

    move v6, v9

    .line 778
    .end local v8    # "owner$iv":Ljava/lang/Object;
    .end local v9    # "$i$f$withLock":I
    .local v6, "$i$f$withLock":I
    .restart local v11    # "owner$iv":Ljava/lang/Object;
    .restart local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :goto_0
    nop

    .line 779
    const/4 v8, 0x0

    .line 163
    .local v8, "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    :try_start_3
    iput-object v12, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$0:Ljava/lang/Object;

    iput-object v7, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$1:Ljava/lang/Object;

    const/4 v9, 0x2

    iput v9, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->label:I

    const-wide/16 v9, 0x1f4

    invoke-static {v9, v10, v2}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v9
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_5

    if-ne v9, v0, :cond_1

    .line 161
    return-object v0

    .line 163
    :cond_1
    move-object/from16 v16, v7

    move v7, v6

    move v6, v8

    move-object/from16 v8, v16

    .line 164
    .end local v8    # "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    .local v6, "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    .restart local v7    # "$i$f$withLock":I
    :goto_1
    :try_start_4
    iput-object v12, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$0:Ljava/lang/Object;

    iput-object v8, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$1:Ljava/lang/Object;

    const/4 v9, 0x3

    iput v9, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->label:I

    invoke-static {v8, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getGroupInfoSuspend(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v9
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    if-ne v9, v0, :cond_2

    .line 161
    return-object v0

    .line 164
    :cond_2
    move-object v10, v11

    move/from16 v16, v6

    move-object v6, v5

    move-object v5, v9

    move-object v9, v8

    move v8, v7

    move/from16 v7, v16

    .line 161
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v11    # "owner$iv":Ljava/lang/Object;
    .end local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .local v6, "$result":Ljava/lang/Object;
    .local v7, "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    .local v8, "$i$f$withLock":I
    :goto_2
    :try_start_5
    check-cast v5, Landroid/net/wifi/p2p/WifiP2pGroup;

    .line 165
    .local v5, "group":Landroid/net/wifi/p2p/WifiP2pGroup;
    if-eqz v5, :cond_c

    .line 166
    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v11

    new-array v13, v4, [Ljava/lang/Object;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "  onGroupInfoAvailable:  \u7ec4\u6240\u6709\u8005: "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    aput-object v14, v13, v3

    invoke-static {v11, v13}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 167
    invoke-virtual {v5}, Landroid/net/wifi/p2p/WifiP2pGroup;->getOwner()Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v11

    invoke-static {v9, v11}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$setMGroupOwner$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Landroid/net/wifi/p2p/WifiP2pDevice;)V

    .line 169
    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMSocketServerChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    move-result-object v11

    invoke-virtual {v11}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->isServerRunning()Z

    move-result v11

    if-eqz v11, :cond_3

    .line 170
    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v0

    new-array v4, v4, [Ljava/lang/Object;

    const-string v9, "WebsocketServer \u5df2\u7ecf\u542f\u52a8\u4e86, \u4e0d\u9700\u8981\u91cd\u590d\u542f\u52a8"

    aput-object v9, v4, v3

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 171
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    .line 781
    .end local v5    # "group":Landroid/net/wifi/p2p/WifiP2pGroup;
    .end local v7    # "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    .end local v8    # "$i$f$withLock":I
    invoke-interface {v12, v10}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    return-object v0

    .line 169
    .restart local v7    # "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    .restart local v8    # "$i$f$withLock":I
    .restart local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :cond_3
    move-object v11, v10

    .line 173
    .restart local v11    # "owner$iv":Ljava/lang/Object;
    const/4 v5, 0x5

    .line 174
    .local v5, "count":I
    :try_start_6
    new-instance v10, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v10}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object/from16 v16, v10

    move-object v10, v9

    move-object/from16 v9, v16

    .line 175
    .local v9, "hostAddress":Lkotlin/jvm/internal/Ref$ObjectRef;
    :cond_4
    :goto_3
    add-int/lit8 v13, v5, -0x1

    .end local v5    # "count":I
    .local v13, "count":I
    if-ltz v5, :cond_a

    iget-object v5, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, Ljava/lang/CharSequence;

    if-eqz v5, :cond_6

    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v5

    if-nez v5, :cond_5

    goto :goto_4

    :cond_5
    move v5, v3

    goto :goto_5

    :cond_6
    :goto_4
    move v5, v4

    :goto_5
    if-eqz v5, :cond_a

    .line 176
    invoke-static {v10}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getWifiP2pManager(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v5

    invoke-static {v10}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getWifiP2pChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v14

    new-instance v15, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2$$ExternalSyntheticLambda0;

    invoke-direct {v15, v10, v9}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/internal/Ref$ObjectRef;)V

    invoke-virtual {v5, v14, v15}, Landroid/net/wifi/p2p/WifiP2pManager;->requestConnectionInfo(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ConnectionInfoListener;)V

    .line 205
    iput-object v12, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$0:Ljava/lang/Object;

    iput-object v10, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$1:Ljava/lang/Object;

    iput-object v9, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->L$2:Ljava/lang/Object;

    iput v13, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->I$0:I

    const/4 v5, 0x4

    iput v5, v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;->label:I

    const-wide/16 v14, 0x3e8

    invoke-static {v14, v15, v2}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v5

    if-ne v5, v0, :cond_7

    .line 161
    return-object v0

    .line 205
    :cond_7
    move v5, v13

    .line 206
    .end local v13    # "count":I
    .restart local v5    # "count":I
    :goto_6
    iget-object v13, v9, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v13, Ljava/lang/CharSequence;

    if-eqz v13, :cond_9

    invoke-interface {v13}, Ljava/lang/CharSequence;->length()I

    move-result v13

    if-nez v13, :cond_8

    goto :goto_7

    :cond_8
    move v13, v3

    goto :goto_8

    :cond_9
    :goto_7
    move v13, v4

    :goto_8
    if-eqz v13, :cond_4

    .line 207
    invoke-static {v10}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v13

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, " hostAddress is null delay 1000m  Count = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    filled-new-array {v14}, [Ljava/lang/Object;

    move-result-object v14

    invoke-static {v13, v14}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_3

    .line 781
    .end local v5    # "count":I
    .end local v7    # "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    .end local v9    # "hostAddress":Lkotlin/jvm/internal/Ref$ObjectRef;
    :catchall_2
    move-exception v0

    move-object v5, v6

    move v7, v8

    goto :goto_b

    .line 210
    .restart local v7    # "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    :cond_a
    invoke-static {v10}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMSocketServerChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->isServerRunning()Z

    move-result v0

    if-nez v0, :cond_b

    .line 211
    invoke-static {v10}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "\u672a\u83b7\u53d6hostAddress, WebsocketServer \u65e0\u6cd5\u542f\u52a8"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 227
    :cond_b
    move-object v5, v6

    goto :goto_a

    .line 165
    .end local v11    # "owner$iv":Ljava/lang/Object;
    :cond_c
    move-object v11, v10

    .line 215
    .restart local v11    # "owner$iv":Ljava/lang/Object;
    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v0

    const-string v4, "onGroupInfoAvailable: group = null"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 220
    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMSocketServerChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->close()V

    .line 221
    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 782
    .local v4, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    :goto_9
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_d

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .local v0, "element$iv":Ljava/lang/Object;
    move-object v9, v0

    check-cast v9, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .local v9, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/4 v10, 0x0

    .line 222
    .local v10, "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$3$2$1$2":I
    invoke-interface {v9, v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onWifiP2pEnabled(Z)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 223
    nop

    .line 782
    .end local v0    # "element$iv":Ljava/lang/Object;
    .end local v9    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v10    # "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$3$2$1$2":I
    goto :goto_9

    .line 783
    :cond_d
    move-object v5, v6

    .line 227
    .end local v4    # "$i$f$forEach":I
    .end local v6    # "$result":Ljava/lang/Object;
    .local v5, "$result":Ljava/lang/Object;
    :goto_a
    nop

    .end local v7    # "$i$a$-withLock$default-P2PGOManager$registerReceiver$1$onReceive$3$2$1":I
    :try_start_7
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    .line 779
    nop

    .line 781
    invoke-interface {v12, v11}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    .line 779
    .end local v11    # "owner$iv":Ljava/lang/Object;
    .end local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    nop

    .line 228
    .end local v8    # "$i$f$withLock":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 781
    .restart local v8    # "$i$f$withLock":I
    .restart local v11    # "owner$iv":Ljava/lang/Object;
    .restart local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :catchall_3
    move-exception v0

    move v7, v8

    goto :goto_b

    .end local v5    # "$result":Ljava/lang/Object;
    .end local v11    # "owner$iv":Ljava/lang/Object;
    .end local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .restart local v6    # "$result":Ljava/lang/Object;
    :catchall_4
    move-exception v0

    .restart local v12    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    move-object v11, v10

    move-object v5, v6

    move v7, v8

    .restart local v11    # "owner$iv":Ljava/lang/Object;
    goto :goto_b

    .end local v8    # "$i$f$withLock":I
    .restart local v5    # "$result":Ljava/lang/Object;
    .local v6, "$i$f$withLock":I
    :catchall_5
    move-exception v0

    move v7, v6

    .end local v6    # "$i$f$withLock":I
    .local v7, "$i$f$withLock":I
    :goto_b
    invoke-interface {v12, v11}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    throw v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
