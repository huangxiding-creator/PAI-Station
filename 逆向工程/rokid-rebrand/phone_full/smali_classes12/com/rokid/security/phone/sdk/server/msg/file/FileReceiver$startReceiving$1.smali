.class final Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FileReceiver.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->startReceiving(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;)V
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
    c = "com.rokid.security.phone.sdk.server.msg.file.FileReceiver$startReceiving$1"
    f = "FileReceiver.kt"
    i = {
        0x0,
        0x1,
        0x1,
        0x1,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2
    }
    l = {
        0x37,
        0x45,
        0x5c,
        0x66,
        0x6c,
        0x74
    }
    m = "invokeSuspend"
    n = {
        "$this$launch",
        "$this$launch",
        "dataInputStream",
        "fileLength",
        "$this$launch",
        "dataInputStream",
        "fileOutputStream",
        "buffer",
        "fileLength",
        "totalBytesRead",
        "currentProgress"
    }
    s = {
        "L$0",
        "L$0",
        "L$4",
        "J$0",
        "L$0",
        "L$4",
        "L$6",
        "L$7",
        "J$0",
        "J$1",
        "F$0"
    }
.end annotation


# instance fields
.field final synthetic $listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

.field final synthetic $serverIp:Ljava/lang/String;

.field F$0:F

.field J$0:J

.field J$1:J

.field private synthetic L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field L$4:Ljava/lang/Object;

.field L$5:Ljava/lang/Object;

.field L$6:Ljava/lang/Object;

.field L$7:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->$serverIp:Ljava/lang/String;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->$listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p4}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 4
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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->$serverIp:Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->$listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    invoke-direct {v0, v1, v2, v3, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;Lkotlin/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 26

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 46
    move-object/from16 v2, p0

    iget v0, v2, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v1, p0

    .local v1, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    move-object/from16 v3, p1

    .local v3, "$result":Ljava/lang/Object;
    :try_start_0
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_11

    .line 118
    :catchall_0
    move-exception v0

    goto/16 :goto_12

    .line 46
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v3    # "$result":Ljava/lang/Object;
    :pswitch_1
    move-object/from16 v3, p0

    .local v3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    move-object/from16 v5, p1

    .local v5, "$result":Ljava/lang/Object;
    const/4 v6, 0x0

    .local v6, "$i$a$-use-FileReceiver$startReceiving$1$3":I
    const/4 v0, 0x0

    .local v0, "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    iget-object v7, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$1:Ljava/lang/Object;

    check-cast v7, Ljava/io/Closeable;

    iget-object v8, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    check-cast v8, Ljava/io/Closeable;

    :try_start_1
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    const/4 v4, 0x0

    const/4 v9, 0x0

    goto/16 :goto_a

    .end local v0    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v6    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :pswitch_2
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    move-object/from16 v5, p1

    .restart local v5    # "$result":Ljava/lang/Object;
    const/4 v6, 0x0

    .restart local v6    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    const/4 v0, 0x0

    .restart local v0    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    iget-object v7, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$1:Ljava/lang/Object;

    check-cast v7, Ljava/io/Closeable;

    iget-object v8, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    check-cast v8, Ljava/io/Closeable;

    :try_start_2
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    const/4 v4, 0x0

    const/16 v20, 0x0

    goto/16 :goto_9

    .line 77
    .end local v0    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    :catchall_1
    move-exception v0

    move-object v2, v0

    goto/16 :goto_e

    .line 46
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v6    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :pswitch_3
    move-object/from16 v5, p0

    .local v5, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    move-object/from16 v6, p1

    .local v6, "$result":Ljava/lang/Object;
    const/4 v7, 0x0

    .local v7, "$i$a$-use-FileReceiver$startReceiving$1$3":I
    const/4 v0, 0x0

    .restart local v0    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    iget v8, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->F$0:F

    .local v8, "currentProgress":F
    iget-wide v9, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->J$1:J

    .local v9, "totalBytesRead":J
    iget-wide v11, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->J$0:J

    .local v11, "fileLength":J
    iget-object v13, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$7:Ljava/lang/Object;

    check-cast v13, [B

    .local v13, "buffer":[B
    iget-object v14, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$6:Ljava/lang/Object;

    check-cast v14, Ljava/io/FileOutputStream;

    .local v14, "fileOutputStream":Ljava/io/FileOutputStream;
    iget-object v15, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$5:Ljava/lang/Object;

    check-cast v15, Ljava/io/Closeable;

    iget-object v3, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$4:Ljava/lang/Object;

    check-cast v3, Ljava/io/DataInputStream;

    .local v3, "dataInputStream":Ljava/io/DataInputStream;
    iget-object v4, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$3:Ljava/lang/Object;

    check-cast v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    move/from16 p1, v0

    .end local v0    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .local p1, "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    iget-object v0, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$2:Ljava/lang/Object;

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    move-object/from16 v16, v0

    iget-object v0, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$1:Ljava/lang/Object;

    move-object/from16 v17, v0

    check-cast v17, Ljava/io/Closeable;

    iget-object v0, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlinx/coroutines/CoroutineScope;

    .local v0, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_3
    invoke-static {v6}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    move-wide/from16 v18, v9

    move-object v2, v14

    move-object/from16 v10, v16

    const/16 v20, 0x0

    const/16 v22, 0x0

    move/from16 v14, p1

    move-object v9, v4

    move-object v4, v5

    move-object/from16 v24, v13

    move v13, v7

    move-object v7, v15

    move-object/from16 v15, v24

    goto/16 :goto_6

    .line 77
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v3    # "dataInputStream":Ljava/io/DataInputStream;
    .end local v8    # "currentProgress":F
    .end local v9    # "totalBytesRead":J
    .end local v11    # "fileLength":J
    .end local v13    # "buffer":[B
    .end local v14    # "fileOutputStream":Ljava/io/FileOutputStream;
    .end local p1    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    :catchall_2
    move-exception v0

    move-object v2, v0

    move-object v3, v5

    move-object v5, v6

    move v6, v7

    move-object v7, v15

    move-object/from16 v8, v17

    goto/16 :goto_e

    .line 46
    .end local v5    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v6    # "$result":Ljava/lang/Object;
    .end local v7    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :pswitch_4
    move-object/from16 v3, p0

    .local v3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    move-object/from16 v4, p1

    .local v4, "$result":Ljava/lang/Object;
    const/4 v0, 0x0

    .local v0, "$i$a$-use-FileReceiver$startReceiving$1$3":I
    iget-wide v5, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->J$0:J

    .local v5, "fileLength":J
    iget-object v7, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$4:Ljava/lang/Object;

    check-cast v7, Ljava/io/DataInputStream;

    .local v7, "dataInputStream":Ljava/io/DataInputStream;
    iget-object v8, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$3:Ljava/lang/Object;

    check-cast v8, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    iget-object v9, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$2:Ljava/lang/Object;

    check-cast v9, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    iget-object v10, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$1:Ljava/lang/Object;

    check-cast v10, Ljava/io/Closeable;

    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    check-cast v11, Lkotlinx/coroutines/CoroutineScope;

    .local v11, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_4
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    move-object/from16 v24, v7

    move v7, v0

    move-object/from16 v0, v24

    move-object/from16 v25, v9

    move-object v9, v8

    move-object v8, v10

    move-object/from16 v10, v25

    goto/16 :goto_3

    .line 61
    .end local v0    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .end local v5    # "fileLength":J
    .end local v7    # "dataInputStream":Ljava/io/DataInputStream;
    .end local v11    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_3
    move-exception v0

    move-object v2, v1

    move-object v1, v3

    move-object v3, v4

    :goto_0
    move-object v4, v0

    goto/16 :goto_f

    .line 46
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v4    # "$result":Ljava/lang/Object;
    :pswitch_5
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlinx/coroutines/CoroutineScope;

    .local v0, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_5
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_f

    move-object v11, v0

    const/4 v8, 0x1

    goto/16 :goto_1

    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v4    # "$result":Ljava/lang/Object;
    :pswitch_6
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlinx/coroutines/CoroutineScope;

    .line 47
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    nop

    .line 48
    :try_start_6
    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "startReceiving: serverIp = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->$serverIp:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ", mPort = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    invoke-static {v7}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getMPort$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 50
    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    new-instance v6, Ljava/net/Socket;

    invoke-direct {v6}, Ljava/net/Socket;-><init>()V

    iget-object v7, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->$serverIp:Ljava/lang/String;

    iget-object v8, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    move-object v9, v6

    .local v9, "$this$invokeSuspend_u24lambda_u240":Ljava/net/Socket;
    const/4 v10, 0x0

    .line 51
    .local v10, "$i$a$-apply-FileReceiver$startReceiving$1$1":I
    new-instance v11, Ljava/net/InetSocketAddress;

    invoke-static {v8}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getMPort$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)I

    move-result v12

    invoke-direct {v11, v7, v12}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    check-cast v11, Ljava/net/SocketAddress;

    invoke-static {v8}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getConnectTimeout$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)I

    move-result v7

    invoke-virtual {v9, v11, v7}, Ljava/net/Socket;->connect(Ljava/net/SocketAddress;I)V

    .line 52
    invoke-static {v8}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getIoTimeout$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)I

    move-result v7

    invoke-virtual {v9, v7}, Ljava/net/Socket;->setSoTimeout(I)V

    .line 53
    nop

    .line 50
    .end local v9    # "$this$invokeSuspend_u24lambda_u240":Ljava/net/Socket;
    .end local v10    # "$i$a$-apply-FileReceiver$startReceiving$1$1":I
    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$setSocket$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;Ljava/net/Socket;)V

    .line 55
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v5

    check-cast v5, Lkotlin/coroutines/CoroutineContext;

    new-instance v6, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$2;

    iget-object v7, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    iget-object v8, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->$listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    const/4 v9, 0x0

    invoke-direct {v6, v7, v8, v9}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;Lkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/jvm/functions/Function2;

    move-object v7, v3

    check-cast v7, Lkotlin/coroutines/Continuation;

    iput-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    const/4 v8, 0x1

    iput v8, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->label:I

    invoke-static {v5, v6, v7}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v5

    if-ne v5, v1, :cond_0

    .line 46
    return-object v1

    .line 55
    :cond_0
    move-object v11, v0

    .line 61
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v11    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_1
    new-instance v0, Ljava/io/DataInputStream;

    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getSocket$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/net/Socket;

    move-result-object v5

    if-eqz v5, :cond_1

    invoke-virtual {v5}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    goto :goto_2

    :cond_1
    const/4 v5, 0x0

    :goto_2
    invoke-direct {v0, v5}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    move-object v10, v0

    check-cast v10, Ljava/io/Closeable;

    iget-object v9, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->$listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1
    .catchall {:try_start_6 .. :try_end_6} :catchall_f

    :try_start_7
    move-object v5, v10

    check-cast v5, Ljava/io/DataInputStream;

    move-object v7, v5

    .restart local v7    # "dataInputStream":Ljava/io/DataInputStream;
    const/4 v5, 0x0

    .line 62
    .local v5, "$i$a$-use-FileReceiver$startReceiving$1$3":I
    invoke-virtual {v7}, Ljava/io/DataInputStream;->readUTF()Ljava/lang/String;

    move-result-object v6

    .line 63
    .local v6, "fileName":Ljava/lang/String;
    invoke-virtual {v7}, Ljava/io/DataInputStream;->readLong()J

    move-result-wide v12

    .line 65
    .local v12, "fileLength":J
    new-instance v14, Ljava/io/File;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v9}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getSaveDirectory$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v15, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const/16 v15, 0x2f

    invoke-virtual {v8, v15}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v14, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .end local v6    # "fileName":Ljava/lang/String;
    move-object v6, v14

    .local v6, "$this$invokeSuspend_u24lambda_u243_u24lambda_u241":Ljava/io/File;
    const/4 v8, 0x0

    .line 66
    .local v8, "$i$a$-apply-FileReceiver$startReceiving$1$3$1":I
    invoke-virtual {v6}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v15

    if-eqz v15, :cond_2

    invoke-virtual {v15}, Ljava/io/File;->mkdirs()Z

    move-result v15

    invoke-static {v15}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    .line 67
    :cond_2
    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v15

    if-eqz v15, :cond_3

    invoke-virtual {v6}, Ljava/io/File;->delete()Z

    .line 68
    .end local v6    # "$this$invokeSuspend_u24lambda_u243_u24lambda_u241":Ljava/io/File;
    :cond_3
    nop

    .line 65
    .end local v8    # "$i$a$-apply-FileReceiver$startReceiving$1$3$1":I
    invoke-static {v9, v14}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$setMFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;Ljava/io/File;)V

    .line 69
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v6

    check-cast v6, Lkotlin/coroutines/CoroutineContext;

    new-instance v8, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$3$2;

    const/4 v14, 0x0

    invoke-direct {v8, v9, v0, v14}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$3$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;Lkotlin/coroutines/Continuation;)V

    check-cast v8, Lkotlin/jvm/functions/Function2;

    iput-object v11, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    iput-object v10, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$1:Ljava/lang/Object;

    iput-object v9, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$2:Ljava/lang/Object;

    iput-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$3:Ljava/lang/Object;

    iput-object v7, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$4:Ljava/lang/Object;

    iput-wide v12, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->J$0:J

    const/4 v14, 0x2

    iput v14, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->label:I

    invoke-static {v6, v8, v3}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v6
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    if-ne v6, v1, :cond_4

    .line 46
    return-object v1

    .line 69
    :cond_4
    move-object v8, v10

    move-object v10, v9

    move-object v9, v0

    move-object v0, v7

    move v7, v5

    move-wide v5, v12

    .line 74
    .end local v12    # "fileLength":J
    .local v0, "dataInputStream":Ljava/io/DataInputStream;
    .local v5, "fileLength":J
    .local v7, "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :goto_3
    :try_start_8
    invoke-static {v10}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/lang/String;

    move-result-object v12

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, " startReceiving: filePath = "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-static {v10}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getMFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/io/File;

    move-result-object v14

    if-eqz v14, :cond_5

    invoke-virtual {v14}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v14

    goto :goto_4

    :cond_5
    const/4 v14, 0x0

    :goto_4
    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    filled-new-array {v13}, [Ljava/lang/Object;

    move-result-object v13

    invoke-static {v12, v13}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 77
    new-instance v12, Ljava/io/FileOutputStream;

    invoke-static {v10}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getMFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/io/File;

    move-result-object v13

    invoke-direct {v12, v13}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    check-cast v12, Ljava/io/Closeable;
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_d

    :try_start_9
    move-object v13, v12

    check-cast v13, Ljava/io/FileOutputStream;

    .local v13, "fileOutputStream":Ljava/io/FileOutputStream;
    const/4 v14, 0x0

    .line 78
    .local v14, "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    const/16 v15, 0x1000

    new-array v15, v15, [B
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_a

    .line 80
    .local v15, "buffer":[B
    const-wide/16 v16, 0x0

    .line 81
    .local v16, "totalBytesRead":J
    const/high16 v18, -0x40800000    # -1.0f

    move-object/from16 p1, v4

    move-object v2, v13

    move-object v4, v3

    move v13, v7

    move-object v7, v12

    const/4 v12, 0x0

    move-object v3, v0

    move-object v0, v11

    const/4 v11, 0x0

    .line 83
    .end local v7    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .end local v11    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v0, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v2, "fileOutputStream":Ljava/io/FileOutputStream;
    .local v3, "dataInputStream":Ljava/io/DataInputStream;
    .local v4, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .local v13, "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .local v18, "lastProgress":F
    .local p1, "$result":Ljava/lang/Object;
    :goto_5
    cmp-long v19, v16, v5

    move-object/from16 v20, v11

    if-gez v19, :cond_9

    :try_start_a
    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->isActive(Lkotlinx/coroutines/CoroutineScope;)Z

    move-result v19

    if-eqz v19, :cond_9

    .line 84
    invoke-virtual {v3, v15}, Ljava/io/DataInputStream;->read([B)I

    move-result v19

    move/from16 v21, v19

    .line 85
    .local v21, "bytesRead":I
    const/4 v11, -0x1

    move-object/from16 v22, v12

    move/from16 v12, v21

    .end local v21    # "bytesRead":I
    .local v12, "bytesRead":I
    if-eq v12, v11, :cond_8

    .line 87
    const/4 v11, 0x0

    invoke-virtual {v2, v15, v11, v12}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_6

    .line 88
    move/from16 v21, v13

    move/from16 v19, v14

    .end local v13    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .end local v14    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .local v19, "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .local v21, "$i$a$-use-FileReceiver$startReceiving$1$3":I
    int-to-long v13, v12

    add-long v11, v16, v13

    .line 90
    .end local v12    # "bytesRead":I
    .end local v16    # "totalBytesRead":J
    .local v11, "totalBytesRead":J
    long-to-float v13, v11

    long-to-float v14, v5

    div-float/2addr v13, v14

    const/16 v14, 0x64

    int-to-float v14, v14

    mul-float/2addr v13, v14

    .line 91
    .local v13, "currentProgress":F
    sub-float v14, v13, v18

    :try_start_b
    invoke-static {v14}, Ljava/lang/Math;->abs(F)F

    move-result v14

    invoke-static {v10}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getProgressUpdateThreshold$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)F

    move-result v16

    cmpl-float v14, v14, v16

    if-ltz v14, :cond_7

    .line 92
    .end local v18    # "lastProgress":F
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v14

    check-cast v14, Lkotlin/coroutines/CoroutineContext;
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_5

    move-object/from16 v23, v1

    :try_start_c
    new-instance v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$3$3$1;

    move-object/from16 v16, v14

    const/4 v14, 0x0

    invoke-direct {v1, v10, v13, v9, v14}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$3$3$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;FLcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;Lkotlin/coroutines/Continuation;)V

    check-cast v1, Lkotlin/jvm/functions/Function2;

    iput-object v0, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    iput-object v8, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$1:Ljava/lang/Object;

    iput-object v10, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$2:Ljava/lang/Object;

    iput-object v9, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$3:Ljava/lang/Object;

    iput-object v3, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$4:Ljava/lang/Object;

    iput-object v7, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$5:Ljava/lang/Object;

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$6:Ljava/lang/Object;

    iput-object v15, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$7:Ljava/lang/Object;

    iput-wide v5, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->J$0:J

    iput-wide v11, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->J$1:J

    iput v13, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->F$0:F

    const/4 v14, 0x3

    iput v14, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->label:I

    move-object/from16 v14, v16

    invoke-static {v14, v1, v4}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v1
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_4

    move-object/from16 v14, v23

    if-ne v1, v14, :cond_6

    .line 46
    return-object v14

    .line 92
    :cond_6
    move-object/from16 v17, v8

    move v8, v13

    move-object v1, v14

    move/from16 v14, v19

    move/from16 v13, v21

    move-wide/from16 v18, v11

    move-wide v11, v5

    move-object/from16 v6, p1

    .line 96
    .end local v5    # "fileLength":J
    .end local v19    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .end local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .end local p1    # "$result":Ljava/lang/Object;
    .local v6, "$result":Ljava/lang/Object;
    .local v8, "currentProgress":F
    .local v11, "fileLength":J
    .local v13, "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local v14    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .local v18, "totalBytesRead":J
    :goto_6
    move v5, v8

    move-object/from16 p1, v6

    move-object/from16 v8, v17

    move-wide/from16 v16, v18

    move/from16 v18, v5

    move-wide v5, v11

    move-object/from16 v11, v20

    move-object/from16 v12, v22

    .end local v8    # "currentProgress":F
    .local v5, "lastProgress":F
    goto/16 :goto_5

    .line 77
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v2    # "fileOutputStream":Ljava/io/FileOutputStream;
    .end local v3    # "dataInputStream":Ljava/io/DataInputStream;
    .end local v5    # "lastProgress":F
    .end local v6    # "$result":Ljava/lang/Object;
    .end local v11    # "fileLength":J
    .end local v13    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .end local v14    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .end local v15    # "buffer":[B
    .end local v18    # "totalBytesRead":J
    .restart local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_4
    move-exception v0

    move-object/from16 v14, v23

    goto/16 :goto_c

    .line 91
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v2    # "fileOutputStream":Ljava/io/FileOutputStream;
    .restart local v3    # "dataInputStream":Ljava/io/DataInputStream;
    .local v5, "fileLength":J
    .local v11, "totalBytesRead":J
    .local v13, "currentProgress":F
    .restart local v15    # "buffer":[B
    .local v18, "lastProgress":F
    .restart local v19    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    :cond_7
    move-object v14, v1

    move-wide/from16 v16, v11

    move/from16 v14, v19

    move-object/from16 v11, v20

    move/from16 v13, v21

    move-object/from16 v12, v22

    goto/16 :goto_5

    .line 77
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v2    # "fileOutputStream":Ljava/io/FileOutputStream;
    .end local v3    # "dataInputStream":Ljava/io/DataInputStream;
    .end local v5    # "fileLength":J
    .end local v11    # "totalBytesRead":J
    .end local v13    # "currentProgress":F
    .end local v15    # "buffer":[B
    .end local v18    # "lastProgress":F
    .end local v19    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    :catchall_5
    move-exception v0

    move-object v14, v1

    move-object/from16 v5, p1

    move-object v2, v0

    move-object v3, v4

    goto/16 :goto_d

    .line 85
    .end local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v2    # "fileOutputStream":Ljava/io/FileOutputStream;
    .restart local v3    # "dataInputStream":Ljava/io/DataInputStream;
    .restart local v5    # "fileLength":J
    .restart local v12    # "bytesRead":I
    .local v13, "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local v14    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .restart local v15    # "buffer":[B
    .restart local v16    # "totalBytesRead":J
    .restart local v18    # "lastProgress":F
    :cond_8
    move/from16 v21, v13

    move/from16 v19, v14

    const/4 v11, 0x0

    move-object v14, v1

    .end local v13    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .end local v14    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .restart local v19    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .restart local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    goto :goto_7

    .line 77
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v2    # "fileOutputStream":Ljava/io/FileOutputStream;
    .end local v3    # "dataInputStream":Ljava/io/DataInputStream;
    .end local v5    # "fileLength":J
    .end local v12    # "bytesRead":I
    .end local v15    # "buffer":[B
    .end local v16    # "totalBytesRead":J
    .end local v18    # "lastProgress":F
    .end local v19    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .end local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local v13    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :catchall_6
    move-exception v0

    move-object v14, v1

    move/from16 v21, v13

    move-object/from16 v5, p1

    move-object v2, v0

    move-object v3, v4

    move/from16 v6, v21

    .end local v13    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    goto/16 :goto_e

    .line 83
    .end local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v2    # "fileOutputStream":Ljava/io/FileOutputStream;
    .restart local v3    # "dataInputStream":Ljava/io/DataInputStream;
    .restart local v5    # "fileLength":J
    .restart local v13    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local v14    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .restart local v15    # "buffer":[B
    .restart local v16    # "totalBytesRead":J
    .restart local v18    # "lastProgress":F
    :cond_9
    move-object/from16 v22, v12

    move/from16 v21, v13

    move/from16 v19, v14

    const/4 v11, 0x0

    move-object v14, v1

    .line 101
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v2    # "fileOutputStream":Ljava/io/FileOutputStream;
    .end local v3    # "dataInputStream":Ljava/io/DataInputStream;
    .end local v13    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .end local v14    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .end local v15    # "buffer":[B
    .end local v16    # "totalBytesRead":J
    .end local v18    # "lastProgress":F
    .restart local v19    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .restart local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :goto_7
    :try_start_d
    invoke-static {v10}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getMFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_a

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v0

    cmp-long v0, v0, v5

    if-nez v0, :cond_a

    const/4 v3, 0x1

    goto :goto_8

    :cond_a
    move v3, v11

    .end local v5    # "fileLength":J
    :goto_8
    if-eqz v3, :cond_c

    .line 102
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$3$3$2;

    const/4 v2, 0x0

    invoke-direct {v1, v10, v9, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$3$3$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;Lkotlin/coroutines/Continuation;)V

    check-cast v1, Lkotlin/jvm/functions/Function2;

    iput-object v8, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    iput-object v7, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$1:Ljava/lang/Object;

    const/4 v2, 0x0

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$2:Ljava/lang/Object;

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$3:Ljava/lang/Object;

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$4:Ljava/lang/Object;

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$5:Ljava/lang/Object;

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$6:Ljava/lang/Object;

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$7:Ljava/lang/Object;

    const/4 v2, 0x4

    iput v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->label:I

    invoke-static {v0, v1, v4}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    if-ne v0, v14, :cond_b

    .line 46
    return-object v14

    .line 102
    :cond_b
    move-object/from16 v5, p1

    move-object v3, v4

    move-object v1, v14

    move/from16 v0, v19

    move/from16 v6, v21

    move-object/from16 v4, v22

    .end local v4    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v19    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .end local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .end local p1    # "$result":Ljava/lang/Object;
    .local v0, "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .local v3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .local v5, "$result":Ljava/lang/Object;
    .local v6, "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :goto_9
    move-object v2, v1

    move-object v1, v3

    move-object v3, v5

    move-object/from16 v0, v20

    goto :goto_b

    .line 107
    .end local v0    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v6    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local v4    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .restart local v19    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .restart local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local p1    # "$result":Ljava/lang/Object;
    :cond_c
    invoke-static {v10}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getMFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/io/File;

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/FileUtils;->delete(Ljava/io/File;)Z

    .line 108
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$3$3$3;

    const/4 v2, 0x0

    invoke-direct {v1, v9, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$3$3$3;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;Lkotlin/coroutines/Continuation;)V

    check-cast v1, Lkotlin/jvm/functions/Function2;

    iput-object v8, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    iput-object v7, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$1:Ljava/lang/Object;

    const/4 v2, 0x0

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$2:Ljava/lang/Object;

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$3:Ljava/lang/Object;

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$4:Ljava/lang/Object;

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$5:Ljava/lang/Object;

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$6:Ljava/lang/Object;

    iput-object v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$7:Ljava/lang/Object;

    const/4 v2, 0x5

    iput v2, v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->label:I

    invoke-static {v0, v1, v4}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_9

    if-ne v0, v14, :cond_d

    .line 46
    return-object v14

    .line 108
    :cond_d
    move-object/from16 v5, p1

    move-object v3, v4

    move-object v1, v14

    move/from16 v0, v19

    move-object/from16 v4, v20

    move/from16 v6, v21

    move-object/from16 v9, v22

    .line 110
    .end local v4    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v19    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .end local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v0    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .restart local v5    # "$result":Ljava/lang/Object;
    .restart local v6    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :goto_a
    move-object v2, v1

    move-object v1, v3

    move-object v0, v4

    move-object v3, v5

    move-object v4, v9

    .end local v0    # "$i$a$-use-FileReceiver$startReceiving$1$3$3":I
    .end local v5    # "$result":Ljava/lang/Object;
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .local v3, "$result":Ljava/lang/Object;
    :goto_b
    :try_start_e
    sget-object v5, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_8

    .line 77
    :try_start_f
    invoke-static {v7, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 111
    nop

    .end local v6    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_7

    .line 61
    :try_start_10
    invoke-static {v8, v0}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_0
    .catchall {:try_start_10 .. :try_end_10} :catchall_0

    goto/16 :goto_11

    :catchall_7
    move-exception v0

    move-object v4, v0

    move-object v10, v8

    goto :goto_f

    .line 77
    .restart local v6    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :catchall_8
    move-exception v0

    move-object v5, v3

    move-object v3, v1

    move-object v1, v2

    move-object v2, v0

    goto :goto_e

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v3    # "$result":Ljava/lang/Object;
    .end local v6    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local v4    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .restart local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_9
    move-exception v0

    :goto_c
    move-object/from16 v5, p1

    move-object v2, v0

    move-object v3, v4

    move-object v1, v14

    :goto_d
    move/from16 v6, v21

    goto :goto_e

    .end local v21    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .end local p1    # "$result":Ljava/lang/Object;
    .local v3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .local v4, "$result":Ljava/lang/Object;
    .restart local v7    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :catchall_a
    move-exception v0

    move-object v2, v0

    move-object v5, v4

    move v6, v7

    move-object v7, v12

    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v7    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :goto_e
    :try_start_11
    throw v2
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_b

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .restart local v5    # "$result":Ljava/lang/Object;
    .restart local v6    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    :catchall_b
    move-exception v0

    move-object v4, v0

    :try_start_12
    invoke-static {v7, v2}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v5    # "$result":Ljava/lang/Object;
    throw v4
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_c

    .line 61
    .end local v6    # "$i$a$-use-FileReceiver$startReceiving$1$3":I
    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .restart local v5    # "$result":Ljava/lang/Object;
    :catchall_c
    move-exception v0

    move-object v4, v0

    move-object v2, v1

    move-object v1, v3

    move-object v3, v5

    move-object v10, v8

    goto :goto_f

    .end local v5    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    :catchall_d
    move-exception v0

    move-object v2, v1

    move-object v1, v3

    move-object v3, v4

    move-object v10, v8

    goto/16 :goto_0

    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v4    # "$result":Ljava/lang/Object;
    :goto_f
    :try_start_13
    throw v4
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_e

    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .local v3, "$result":Ljava/lang/Object;
    :catchall_e
    move-exception v0

    move-object v5, v0

    :try_start_14
    invoke-static {v10, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .end local v3    # "$result":Ljava/lang/Object;
    throw v5
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_0
    .catchall {:try_start_14 .. :try_end_14} :catchall_0

    .line 112
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .restart local v3    # "$result":Ljava/lang/Object;
    :catch_0
    move-exception v0

    goto :goto_10

    .line 118
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .local v3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .restart local v4    # "$result":Ljava/lang/Object;
    :catchall_f
    move-exception v0

    move-object v1, v3

    move-object v3, v4

    goto :goto_12

    .line 112
    :catch_1
    move-exception v0

    move-object v2, v1

    move-object v1, v3

    move-object v3, v4

    .line 113
    .end local v4    # "$result":Ljava/lang/Object;
    .local v0, "e":Ljava/lang/Exception;
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;
    .local v3, "$result":Ljava/lang/Object;
    :goto_10
    :try_start_15
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 114
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "File receive failed: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    .end local v0    # "e":Ljava/lang/Exception;
    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 115
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->access$getMFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;)Ljava/io/File;

    move-result-object v0

    invoke-static {v0}, Lcom/blankj/utilcode/util/FileUtils;->delete(Ljava/io/File;)Z

    .line 116
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$4;

    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->$listener:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    const/4 v6, 0x0

    invoke-direct {v4, v5, v6}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1$4;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;Lkotlin/coroutines/Continuation;)V

    check-cast v4, Lkotlin/jvm/functions/Function2;

    move-object v5, v1

    check-cast v5, Lkotlin/coroutines/Continuation;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$0:Ljava/lang/Object;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$1:Ljava/lang/Object;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$2:Ljava/lang/Object;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$3:Ljava/lang/Object;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$4:Ljava/lang/Object;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$5:Ljava/lang/Object;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$6:Ljava/lang/Object;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->L$7:Ljava/lang/Object;

    const/4 v6, 0x6

    iput v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->label:I

    invoke-static {v0, v4, v5}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_0

    if-ne v0, v2, :cond_e

    .line 46
    return-object v2

    .line 118
    :cond_e
    :goto_11
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->close()V

    .line 119
    nop

    .line 120
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 118
    :goto_12
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver$startReceiving$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->close()V

    throw v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
