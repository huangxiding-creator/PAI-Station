.class final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ClassicBluetoothService.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->sendStreamBroadcast(Ljava/lang/String;[BLjava/lang/String;)V
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
    value = "SMAP\nClassicBluetoothService.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBluetoothService.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1\n+ 2 Mutex.kt\nkotlinx/coroutines/sync/MutexKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,1582:1\n120#2,8:1583\n129#2:1593\n1855#3,2:1591\n*S KotlinDebug\n*F\n+ 1 ClassicBluetoothService.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1\n*L\n783#1:1583,8\n783#1:1593\n784#1:1591,2\n*E\n"
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
    c = "com.rokid.glasses.transport.sdk.server.bluetooth.server.ClassicBluetoothService$sendStreamBroadcast$1"
    f = "ClassicBluetoothService.kt"
    i = {
        0x0
    }
    l = {
        0x634
    }
    m = "invokeSuspend"
    n = {
        "$this$withLock_u24default$iv"
    }
    s = {
        "L$0"
    }
.end annotation


# instance fields
.field final synthetic $bytes:[B

.field final synthetic $clientId:Ljava/lang/String;

.field final synthetic $tag:Ljava/lang/String;

.field L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field L$4:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Ljava/lang/String;Ljava/lang/String;[BLkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "[B",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->$tag:Ljava/lang/String;

    iput-object p3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->$clientId:Ljava/lang/String;

    iput-object p4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->$bytes:[B

    const/4 v0, 0x2

    invoke-direct {p0, v0, p5}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 7
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

    new-instance v6, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->$tag:Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->$clientId:Ljava/lang/String;

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->$bytes:[B

    move-object v0, v6

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Ljava/lang/String;Ljava/lang/String;[BLkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/coroutines/Continuation;

    return-object v6
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 19

    const-string v1, "ClassicBluetoothService "

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 782
    move-object/from16 v2, p0

    iget v3, v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->label:I

    const/4 v4, 0x1

    packed-switch v3, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v0, p0

    .local v0, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    move-object/from16 v3, p1

    .local v3, "$result":Ljava/lang/Object;
    const/4 v5, 0x0

    .local v5, "$i$f$withLock":I
    iget-object v6, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->L$4:Ljava/lang/Object;

    check-cast v6, [B

    iget-object v7, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->L$3:Ljava/lang/Object;

    check-cast v7, Ljava/lang/String;

    iget-object v8, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->L$2:Ljava/lang/Object;

    check-cast v8, Ljava/lang/String;

    iget-object v9, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->L$1:Ljava/lang/Object;

    check-cast v9, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    const/4 v10, 0x0

    .local v10, "owner$iv":Ljava/lang/Object;
    iget-object v11, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->L$0:Ljava/lang/Object;

    check-cast v11, Lkotlinx/coroutines/sync/Mutex;

    .local v11, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move v12, v5

    move-object v5, v3

    move-object v3, v0

    goto :goto_0

    .end local v0    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    .end local v3    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$withLock":I
    .end local v10    # "owner$iv":Ljava/lang/Object;
    .end local v11    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :pswitch_1
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v3, p0

    .local v3, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    move-object/from16 v5, p1

    .line 783
    .local v5, "$result":Ljava/lang/Object;
    iget-object v6, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMWriteMutex$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v11

    .restart local v11    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    iget-object v9, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v8, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->$tag:Ljava/lang/String;

    iget-object v7, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->$clientId:Ljava/lang/String;

    iget-object v6, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->$bytes:[B

    .line 1583
    const/4 v10, 0x0

    .restart local v10    # "owner$iv":Ljava/lang/Object;
    const/4 v12, 0x0

    .line 1584
    .local v12, "$i$f$withLock":I
    nop

    .line 1588
    move-object v13, v3

    check-cast v13, Lkotlin/coroutines/Continuation;

    iput-object v11, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->L$0:Ljava/lang/Object;

    iput-object v9, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->L$1:Ljava/lang/Object;

    iput-object v8, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->L$2:Ljava/lang/Object;

    iput-object v7, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->L$3:Ljava/lang/Object;

    iput-object v6, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->L$4:Ljava/lang/Object;

    iput v4, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;->label:I

    invoke-interface {v11, v10, v13}, Lkotlinx/coroutines/sync/Mutex;->lock(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v13

    if-ne v13, v0, :cond_0

    .line 782
    return-object v0

    .line 1589
    :cond_0
    :goto_0
    nop

    .line 1590
    const/4 v13, 0x0

    .line 784
    .local v13, "$i$a$-withLock$default-ClassicBluetoothService$sendStreamBroadcast$1$1":I
    :try_start_0
    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedStreamSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v14, 0x0

    .line 1591
    .local v14, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v15

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    :goto_1
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .local v0, "element$iv":Ljava/lang/Object;
    move-object/from16 v16, v0

    check-cast v16, Landroid/bluetooth/BluetoothSocket;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-object/from16 v0, v16

    .local v0, "socket":Landroid/bluetooth/BluetoothSocket;
    const/16 v16, 0x0

    .line 785
    .local v16, "$i$a$-forEach-ClassicBluetoothService$sendStreamBroadcast$1$1$1":I
    nop

    .line 787
    :try_start_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "sendStreamBroadcast-->"

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMConnectedStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v4

    invoke-static {v0, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v4
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-object/from16 p1, v3

    const/4 v3, 0x1

    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    .local p1, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    if-ne v4, v3, :cond_2

    const/4 v3, 0x1

    goto :goto_2

    .end local p1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    :cond_1
    move-object/from16 p1, v3

    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    .restart local p1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    :cond_2
    const/4 v3, 0x0

    :goto_2
    :try_start_2
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 788
    invoke-static {v9}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMConnectedStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v2

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_3

    .line 789
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    move-object v0, v2

    .line 791
    .local v0, "outputStream":Ljava/io/OutputStream;
    new-instance v2, Ljava/io/BufferedOutputStream;

    const/16 v4, 0x2000

    invoke-direct {v2, v0, v4}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;I)V

    .line 793
    .local v2, "bufferedOut":Ljava/io/BufferedOutputStream;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/16 v3, 0x7c

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    array-length v4, v6

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\\u2063\\u2064\\u2065"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 794
    .local v3, "metaData":Ljava/lang/String;
    sget-object v4, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v3, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    move-object/from16 v17, v0

    .end local v0    # "outputStream":Ljava/io/OutputStream;
    .local v17, "outputStream":Ljava/io/OutputStream;
    const-string v0, "this as java.lang.String).getBytes(charset)"

    invoke-static {v4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v0, v4

    .line 796
    .local v0, "metaDataBytes":[B
    invoke-virtual {v2, v0}, Ljava/io/BufferedOutputStream;->write([B)V

    .line 797
    invoke-virtual {v2, v6}, Ljava/io/BufferedOutputStream;->write([B)V

    .line 798
    invoke-virtual {v2}, Ljava/io/BufferedOutputStream;->flush()V

    .line 799
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v18, v0

    .end local v0    # "metaDataBytes":[B
    .local v18, "metaDataBytes":[B
    const-string v0, "Stream\u6570\u636e\u53d1\u9001\u5b8c\u6210 - tag:"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, ", size:"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    array-length v4, v6

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .end local v2    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .end local v3    # "metaData":Ljava/lang/String;
    .end local v17    # "outputStream":Ljava/io/OutputStream;
    .end local v18    # "metaDataBytes":[B
    goto :goto_4

    .line 802
    :catch_0
    move-exception v0

    goto :goto_3

    .end local p1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    .local v3, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    :catch_1
    move-exception v0

    move-object/from16 p1, v3

    .line 803
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    .local v0, "e":Ljava/io/IOException;
    .restart local p1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    :goto_3
    :try_start_3
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 804
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Send Stream failed  errMessag = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 806
    .end local v0    # "e":Ljava/io/IOException;
    :cond_3
    :goto_4
    nop

    .line 1591
    .end local v16    # "$i$a$-forEach-ClassicBluetoothService$sendStreamBroadcast$1$1$1":I
    move-object/from16 v2, p0

    move-object/from16 v3, p1

    const/4 v4, 0x1

    goto/16 :goto_1

    .line 1592
    .end local p1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    :cond_4
    move-object/from16 p1, v3

    .line 807
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    .end local v14    # "$i$f$forEach":I
    .restart local p1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    nop

    .end local v13    # "$i$a$-withLock$default-ClassicBluetoothService$sendStreamBroadcast$1$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1590
    nop

    .line 1593
    invoke-interface {v11, v10}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    .line 1590
    .end local v10    # "owner$iv":Ljava/lang/Object;
    .end local v11    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    nop

    .line 809
    .end local v12    # "$i$f$withLock":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 1593
    .restart local v10    # "owner$iv":Ljava/lang/Object;
    .restart local v11    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .restart local v12    # "$i$f$withLock":I
    :catchall_0
    move-exception v0

    goto :goto_5

    .end local p1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    :catchall_1
    move-exception v0

    move-object/from16 p1, v3

    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    .restart local p1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;
    :goto_5
    invoke-interface {v11, v10}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    throw v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
