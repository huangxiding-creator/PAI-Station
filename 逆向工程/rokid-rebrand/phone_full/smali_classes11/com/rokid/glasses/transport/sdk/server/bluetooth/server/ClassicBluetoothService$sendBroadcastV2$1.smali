.class final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ClassicBluetoothService.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->sendBroadcastV2(Ljava/lang/String;)V
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
    value = "SMAP\nClassicBluetoothService.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBluetoothService.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,1582:1\n1855#2,2:1583\n*S KotlinDebug\n*F\n+ 1 ClassicBluetoothService.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1\n*L\n731#1:1583,2\n*E\n"
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
    c = "com.rokid.glasses.transport.sdk.server.bluetooth.server.ClassicBluetoothService$sendBroadcastV2$1"
    f = "ClassicBluetoothService.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $message:Ljava/lang/String;

.field label:I

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;->$message:Ljava/lang/String;

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

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;->$message:Ljava/lang/String;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 13

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 729
    iget v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 730
    .local v0, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;
    .local p1, "$result":Ljava/lang/Object;
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v2, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;->$message:Ljava/lang/String;

    monitor-enter v1

    const/4 v4, 0x0

    .line 731
    .local v4, "$i$a$-synchronized-ClassicBluetoothService$sendBroadcastV2$1$1":I
    :try_start_0
    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedMessageSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v5

    check-cast v5, Ljava/lang/Iterable;

    .local v5, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v6, 0x0

    .line 1583
    .local v6, "$i$f$forEach":I
    invoke-interface {v5}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v7

    .end local v5    # "$this$forEach$iv":Ljava/lang/Iterable;
    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .local v5, "element$iv":Ljava/lang/Object;
    move-object v8, v5

    check-cast v8, Landroid/bluetooth/BluetoothSocket;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v5, v8

    .local v5, "socket":Landroid/bluetooth/BluetoothSocket;
    const/4 v8, 0x0

    .line 732
    .local v8, "$i$a$-forEach-ClassicBluetoothService$sendBroadcastV2$1$1$1":I
    nop

    .line 733
    :try_start_1
    const-string v9, "ClassicBluetoothService "

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "sendBroadcastV2-->"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMConnectedMessageSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v11

    invoke-static {v5, v11}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v11

    const/4 v12, 0x1

    if-eqz v11, :cond_0

    invoke-virtual {v5}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v11

    if-ne v11, v12, :cond_0

    move v11, v12

    goto :goto_1

    :cond_0
    const/4 v11, 0x0

    :goto_1
    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 734
    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMConnectedMessageSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v9

    invoke-static {v5, v9}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_3

    invoke-virtual {v5}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v9

    if-ne v9, v12, :cond_3

    .line 735
    invoke-virtual {v5}, Landroid/bluetooth/BluetoothSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v9

    .line 736
    .local v9, "outputStream":Ljava/io/OutputStream;
    sget-object v10, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v3, v10}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v10

    const-string v11, "this as java.lang.String).getBytes(charset)"

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 737
    .local v10, "payload":[B
    array-length v11, v10

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMaxBytes2$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)I

    move-result v12

    if-lt v11, v12, :cond_1

    .line 738
    const-string v11, "ClassicBluetoothService "

    const-string v12, "sendBroadcast Fail -- Data payload size exceeds 300kb"

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v11, v12}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 739
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .end local v4    # "$i$a$-synchronized-ClassicBluetoothService$sendBroadcastV2$1$1":I
    .end local v5    # "socket":Landroid/bluetooth/BluetoothSocket;
    .end local v6    # "$i$f$forEach":I
    .end local v8    # "$i$a$-forEach-ClassicBluetoothService$sendBroadcastV2$1$1$1":I
    .end local v9    # "outputStream":Ljava/io/OutputStream;
    .end local v10    # "payload":[B
    monitor-exit v1

    return-object v2

    .line 741
    .restart local v4    # "$i$a$-synchronized-ClassicBluetoothService$sendBroadcastV2$1$1":I
    .restart local v6    # "$i$f$forEach":I
    .restart local v8    # "$i$a$-forEach-ClassicBluetoothService$sendBroadcastV2$1$1$1":I
    .restart local v9    # "outputStream":Ljava/io/OutputStream;
    .restart local v10    # "payload":[B
    :cond_1
    :try_start_2
    array-length v5, v10

    add-int/lit8 v5, v5, 0x6

    invoke-static {v5}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v5

    .line 742
    .local v5, "buffer":Ljava/nio/ByteBuffer;
    const/4 v11, -0x2

    invoke-virtual {v5, v11}, Ljava/nio/ByteBuffer;->putShort(S)Ljava/nio/ByteBuffer;

    .line 743
    array-length v11, v10

    invoke-virtual {v5, v11}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 744
    invoke-virtual {v5, v10}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 745
    nop

    .end local v10    # "payload":[B
    if-eqz v9, :cond_2

    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/io/OutputStream;->write([B)V

    nop

    .line 746
    .end local v5    # "buffer":Ljava/nio/ByteBuffer;
    :cond_2
    if-eqz v9, :cond_3

    invoke-virtual {v9}, Ljava/io/OutputStream;->flush()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_2

    .line 749
    .end local v9    # "outputStream":Ljava/io/OutputStream;
    :catch_0
    move-exception v5

    .line 750
    .local v5, "e":Ljava/io/IOException;
    :try_start_3
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    .line 751
    const-string v9, "ClassicBluetoothService "

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Send messgeV2 failed  errMessag = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v5}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    filled-new-array {v10}, [Ljava/lang/Object;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 753
    .end local v5    # "e":Ljava/io/IOException;
    :cond_3
    :goto_2
    nop

    .line 1583
    .end local v8    # "$i$a$-forEach-ClassicBluetoothService$sendBroadcastV2$1$1$1":I
    goto/16 :goto_0

    .line 1584
    :cond_4
    nop

    .line 754
    .end local v6    # "$i$f$forEach":I
    nop

    .end local v4    # "$i$a$-synchronized-ClassicBluetoothService$sendBroadcastV2$1$1":I
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 730
    monitor-exit v1

    .line 755
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    .line 730
    :catchall_0
    move-exception v2

    monitor-exit v1

    throw v2

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
