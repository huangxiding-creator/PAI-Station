.class final Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ClassicBlueToothClientManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->write(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
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
    value = "SMAP\nClassicBlueToothClientManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBlueToothClientManager.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,1451:1\n1#2:1452\n*E\n"
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
    c = "com.rokid.glasses.transport.sdk.server.bluetooth.client.ClassicBlueToothClientManager$ConnectedThread$write$2"
    f = "ClassicBlueToothClientManager.kt"
    i = {
        0x2,
        0x2,
        0x2,
        0x3,
        0x3,
        0x3,
        0x3,
        0x3,
        0x3,
        0x4,
        0x4,
        0x4,
        0x4,
        0x4,
        0x4,
        0x4,
        0x4,
        0x5,
        0x6
    }
    l = {
        0x513,
        0x51a,
        0x52e,
        0x539,
        0x54f,
        0x55c,
        0x562
    }
    m = "invokeSuspend"
    n = {
        "fileInputStream",
        "bufferedOut",
        "fileSize",
        "fileInputStream",
        "bufferedOut",
        "buffer",
        "bytesRead",
        "totalSent",
        "totalSize",
        "fileInputStream",
        "bufferedOut",
        "buffer",
        "bytesRead",
        "totalSent",
        "totalSize",
        "roundedProgress",
        "currentTime",
        "fileInputStream",
        "fileInputStream"
    }
    s = {
        "L$0",
        "L$1",
        "J$0",
        "L$0",
        "L$1",
        "L$2",
        "L$3",
        "J$0",
        "J$1",
        "L$0",
        "L$1",
        "L$2",
        "L$3",
        "J$0",
        "J$1",
        "F$0",
        "J$2",
        "L$0",
        "L$0"
    }
.end annotation


# instance fields
.field final synthetic $PROGRESS_INTERVAL:I

.field final synthetic $dir:Ljava/lang/String;

.field final synthetic $file:Ljava/io/File;

.field final synthetic $lastProgressTime:Lkotlin/jvm/internal/Ref$LongRef;

.field final synthetic $lastProgressValue:Lkotlin/jvm/internal/Ref$FloatRef;

.field final synthetic $listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

.field F$0:F

.field J$0:J

.field J$1:J

.field J$2:J

.field private synthetic L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

.field final synthetic this$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Ljava/io/File;Ljava/lang/String;Lkotlin/jvm/internal/Ref$LongRef;ILkotlin/jvm/internal/Ref$FloatRef;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;",
            "Ljava/io/File;",
            "Ljava/lang/String;",
            "Lkotlin/jvm/internal/Ref$LongRef;",
            "I",
            "Lkotlin/jvm/internal/Ref$FloatRef;",
            "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iput-object p3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$file:Ljava/io/File;

    iput-object p4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$dir:Ljava/lang/String;

    iput-object p5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$lastProgressTime:Lkotlin/jvm/internal/Ref$LongRef;

    iput p6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$PROGRESS_INTERVAL:I

    iput-object p7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$lastProgressValue:Lkotlin/jvm/internal/Ref$FloatRef;

    iput-object p8, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p9}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 11
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

    new-instance v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$file:Ljava/io/File;

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$dir:Ljava/lang/String;

    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$lastProgressTime:Lkotlin/jvm/internal/Ref$LongRef;

    iget v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$PROGRESS_INTERVAL:I

    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$lastProgressValue:Lkotlin/jvm/internal/Ref$FloatRef;

    iget-object v8, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    move-object v0, v10

    move-object v9, p2

    invoke-direct/range {v0 .. v9}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Ljava/io/File;Ljava/lang/String;Lkotlin/jvm/internal/Ref$LongRef;ILkotlin/jvm/internal/Ref$FloatRef;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    iput-object p1, v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    check-cast v10, Lkotlin/coroutines/Continuation;

    return-object v10
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 23

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 1293
    move-object/from16 v2, p0

    iget v0, v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->label:I

    const/16 v3, 0x2000

    const/4 v5, 0x0

    packed-switch v0, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v1, p0

    .local v1, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    move-object/from16 v3, p1

    .local v3, "$result":Ljava/lang/Object;
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    move-object v4, v0

    check-cast v4, Ljava/io/FileInputStream;

    .local v4, "fileInputStream":Ljava/io/FileInputStream;
    :try_start_0
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_d

    .line 1382
    :catchall_0
    move-exception v0

    goto/16 :goto_f

    .line 1293
    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .end local v3    # "$result":Ljava/lang/Object;
    .end local v4    # "fileInputStream":Ljava/io/FileInputStream;
    :pswitch_1
    move-object/from16 v3, p0

    .local v3, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    move-object/from16 v4, p1

    .local v4, "$result":Ljava/lang/Object;
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    move-object v6, v0

    check-cast v6, Ljava/io/FileInputStream;

    .local v6, "fileInputStream":Ljava/io/FileInputStream;
    :try_start_1
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    goto/16 :goto_b

    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    :pswitch_2
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    move-object/from16 v6, p1

    .local v6, "$result":Ljava/lang/Object;
    iget-wide v7, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$2:J

    .local v7, "currentTime":J
    iget v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->F$0:F

    .local v0, "roundedProgress":F
    iget-wide v9, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$1:J

    .local v9, "totalSize":J
    iget-wide v11, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$0:J

    .local v11, "totalSent":J
    iget-object v13, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$3:Ljava/lang/Object;

    check-cast v13, Lkotlin/jvm/internal/Ref$IntRef;

    .local v13, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    iget-object v14, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$2:Ljava/lang/Object;

    check-cast v14, [B

    .local v14, "buffer":[B
    iget-object v15, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$1:Ljava/lang/Object;

    check-cast v15, Ljava/io/BufferedOutputStream;

    .local v15, "bufferedOut":Ljava/io/BufferedOutputStream;
    iget-object v4, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    check-cast v4, Ljava/io/FileInputStream;

    .local v4, "fileInputStream":Ljava/io/FileInputStream;
    :try_start_2
    invoke-static {v6}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object/from16 v20, v3

    move-object v3, v1

    move-object/from16 v1, v20

    move-wide/from16 v21, v11

    move-object v11, v4

    move-object v4, v6

    move-wide/from16 v5, v21

    goto/16 :goto_9

    .line 1382
    .end local v0    # "roundedProgress":F
    .end local v7    # "currentTime":J
    .end local v9    # "totalSize":J
    .end local v11    # "totalSent":J
    .end local v13    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v14    # "buffer":[B
    .end local v15    # "bufferedOut":Ljava/io/BufferedOutputStream;
    :catchall_1
    move-exception v0

    move-object v1, v3

    move-object v3, v6

    goto/16 :goto_f

    .line 1376
    :catch_0
    move-exception v0

    move-object/from16 v20, v6

    move-object v6, v1

    move-object v1, v3

    move-object/from16 v3, v20

    goto/16 :goto_c

    .line 1293
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .end local v4    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v6    # "$result":Ljava/lang/Object;
    :pswitch_3
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    move-object/from16 v4, p1

    .local v4, "$result":Ljava/lang/Object;
    iget-wide v6, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$1:J

    .local v6, "totalSize":J
    iget-wide v8, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$0:J

    .local v8, "totalSent":J
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$3:Ljava/lang/Object;

    check-cast v0, Lkotlin/jvm/internal/Ref$IntRef;

    .local v0, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    iget-object v10, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$2:Ljava/lang/Object;

    check-cast v10, [B

    .local v10, "buffer":[B
    iget-object v11, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$1:Ljava/lang/Object;

    check-cast v11, Ljava/io/BufferedOutputStream;

    .local v11, "bufferedOut":Ljava/io/BufferedOutputStream;
    iget-object v12, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    check-cast v12, Ljava/io/FileInputStream;

    .local v12, "fileInputStream":Ljava/io/FileInputStream;
    :try_start_3
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    move-wide/from16 v20, v6

    move-object v7, v12

    move-wide v12, v8

    move-wide/from16 v8, v20

    goto/16 :goto_6

    .line 1382
    .end local v0    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v6    # "totalSize":J
    .end local v8    # "totalSent":J
    .end local v10    # "buffer":[B
    .end local v11    # "bufferedOut":Ljava/io/BufferedOutputStream;
    :catchall_2
    move-exception v0

    move-object v1, v3

    move-object v3, v4

    move-object v4, v12

    goto/16 :goto_f

    .line 1376
    :catch_1
    move-exception v0

    move-object v6, v1

    move-object v1, v3

    move-object v3, v4

    move-object v4, v12

    goto/16 :goto_c

    .line 1293
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v12    # "fileInputStream":Ljava/io/FileInputStream;
    :pswitch_4
    move-object/from16 v4, p0

    .local v4, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    move-object/from16 v6, p1

    .local v6, "$result":Ljava/lang/Object;
    iget-wide v7, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$0:J

    .local v7, "fileSize":J
    iget-object v0, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$1:Ljava/lang/Object;

    check-cast v0, Ljava/io/BufferedOutputStream;

    .local v0, "bufferedOut":Ljava/io/BufferedOutputStream;
    iget-object v9, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    check-cast v9, Ljava/io/FileInputStream;

    .local v9, "fileInputStream":Ljava/io/FileInputStream;
    :try_start_4
    invoke-static {v6}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    move-object v11, v0

    move-wide/from16 v20, v7

    move-object v7, v9

    move-wide/from16 v9, v20

    goto/16 :goto_5

    .line 1382
    .end local v0    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .end local v7    # "fileSize":J
    :catchall_3
    move-exception v0

    move-object v1, v4

    move-object v3, v6

    move-object v4, v9

    goto/16 :goto_f

    .line 1376
    :catch_2
    move-exception v0

    move-object v3, v6

    move-object v6, v1

    move-object v1, v4

    move-object v4, v9

    goto/16 :goto_c

    .line 1293
    .end local v4    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .end local v6    # "$result":Ljava/lang/Object;
    .end local v9    # "fileInputStream":Ljava/io/FileInputStream;
    :pswitch_5
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    move-object/from16 v4, p1

    .local v4, "$result":Ljava/lang/Object;
    const/4 v0, 0x0

    .local v0, "$i$a$-run-ClassicBlueToothClientManager$ConnectedThread$write$2$outputStream$1":I
    const/4 v6, 0x0

    .local v6, "fileInputStream":Ljava/io/FileInputStream;
    :try_start_5
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_3

    .end local v0    # "$i$a$-run-ClassicBlueToothClientManager$ConnectedThread$write$2$outputStream$1":I
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    :pswitch_6
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    const/4 v6, 0x0

    .restart local v6    # "fileInputStream":Ljava/io/FileInputStream;
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_3
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    goto/16 :goto_1

    .line 1382
    :catchall_4
    move-exception v0

    move-object v1, v3

    move-object v3, v4

    move-object v4, v6

    goto/16 :goto_f

    .line 1376
    :catch_3
    move-exception v0

    move-object/from16 v20, v6

    move-object v6, v1

    move-object v1, v3

    move-object v3, v4

    move-object/from16 v4, v20

    goto/16 :goto_c

    .line 1293
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    :pswitch_7
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v4, p0

    .local v4, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    move-object/from16 v6, p1

    .local v6, "$result":Ljava/lang/Object;
    iget-object v0, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlinx/coroutines/CoroutineScope;

    .line 1294
    .local v0, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    const/4 v7, 0x0

    .line 1295
    .local v7, "fileInputStream":Ljava/io/FileInputStream;
    nop

    .line 1297
    :try_start_6
    iget-object v8, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    invoke-static {v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->access$getSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v8

    const/4 v9, 0x1

    if-eqz v8, :cond_0

    invoke-virtual {v8}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v8

    if-ne v8, v9, :cond_0

    move v8, v9

    goto :goto_0

    :cond_0
    const/4 v8, 0x0

    :goto_0
    if-nez v8, :cond_2

    .line 1298
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    iget-object v0, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "socket\u672a\u8fde\u63a5\uff0c\u7ec8\u6b62\u5199\u5165"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1299
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$1;

    iget-object v8, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    invoke-direct {v3, v8, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$1;-><init>(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    check-cast v3, Lkotlin/jvm/functions/Function2;

    move-object v8, v4

    check-cast v8, Lkotlin/coroutines/Continuation;

    iput v9, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->label:I

    invoke-static {v0, v3, v8}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_d
    .catchall {:try_start_6 .. :try_end_6} :catchall_b

    if-ne v0, v1, :cond_1

    .line 1293
    return-object v1

    .line 1299
    :cond_1
    move-object v3, v4

    move-object v4, v6

    move-object v6, v7

    .line 1302
    .end local v7    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v4, "$result":Ljava/lang/Object;
    .local v6, "fileInputStream":Ljava/io/FileInputStream;
    :goto_1
    :try_start_7
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3
    .catchall {:try_start_7 .. :try_end_7} :catchall_4

    .line 1382
    iget-object v1, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    invoke-static {v1, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lkotlinx/coroutines/Job;)V

    .line 1384
    nop

    .line 1302
    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    return-object v0

    .line 1304
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v4, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v6, "$result":Ljava/lang/Object;
    .restart local v7    # "fileInputStream":Ljava/io/FileInputStream;
    :cond_2
    :try_start_8
    iget-object v8, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    invoke-static {v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->access$getSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v8

    if-eqz v8, :cond_3

    invoke-virtual {v8}, Landroid/bluetooth/BluetoothSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v8

    goto :goto_2

    :cond_3
    move-object v8, v5

    :goto_2
    if-nez v8, :cond_5

    iget-object v3, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iget-object v8, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    const/4 v0, 0x0

    .line 1305
    .local v0, "$i$a$-run-ClassicBlueToothClientManager$ConnectedThread$write$2$outputStream$1":I
    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v3

    const-string v9, "outputStream\u4e3a\u7a7a\uff0c\u7ec8\u6b62\u5199\u5165"

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v3, v9}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1306
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v3

    check-cast v3, Lkotlin/coroutines/CoroutineContext;

    new-instance v9, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$outputStream$1$1;

    invoke-direct {v9, v8, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$outputStream$1$1;-><init>(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    check-cast v9, Lkotlin/jvm/functions/Function2;

    const/4 v8, 0x2

    iput v8, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->label:I

    invoke-static {v3, v9, v4}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v3
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_d
    .catchall {:try_start_8 .. :try_end_8} :catchall_b

    if-ne v3, v1, :cond_4

    .line 1293
    return-object v1

    .line 1306
    :cond_4
    move-object v3, v4

    move-object v4, v6

    move-object v6, v7

    .line 1309
    .end local v7    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v4, "$result":Ljava/lang/Object;
    .local v6, "fileInputStream":Ljava/io/FileInputStream;
    :goto_3
    :try_start_9
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_3
    .catchall {:try_start_9 .. :try_end_9} :catchall_4

    .line 1382
    .end local v0    # "$i$a$-run-ClassicBlueToothClientManager$ConnectedThread$write$2$outputStream$1":I
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    invoke-static {v0, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lkotlinx/coroutines/Job;)V

    .line 1384
    nop

    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    return-object v1

    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v4, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v6, "$result":Ljava/lang/Object;
    .restart local v7    # "fileInputStream":Ljava/io/FileInputStream;
    :cond_5
    move-object v0, v8

    .line 1313
    .local v0, "outputStream":Ljava/io/OutputStream;
    :try_start_a
    new-instance v8, Ljava/io/BufferedOutputStream;

    invoke-direct {v8, v0, v3}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;I)V

    move-object v0, v8

    .line 1316
    .local v0, "bufferedOut":Ljava/io/BufferedOutputStream;
    iget-object v8, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v8

    const-string v9, "write 01"

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1317
    new-instance v8, Ljava/io/FileInputStream;

    iget-object v9, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$file:Ljava/io/File;

    invoke-direct {v8, v9}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    move-object v7, v8

    .line 1319
    iget-object v8, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v8

    const-string v9, "write 1"

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1321
    iget-object v8, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$dir:Ljava/lang/String;

    if-nez v8, :cond_6

    iget-object v8, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$file:Ljava/io/File;

    invoke-virtual {v8}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v8

    goto :goto_4

    :cond_6
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v9, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$dir:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$file:Ljava/io/File;

    invoke-virtual {v9}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 1322
    .local v8, "fileName":Ljava/lang/String;
    :goto_4
    iget-object v9, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$file:Ljava/io/File;

    invoke-virtual {v9}, Ljava/io/File;->length()J

    move-result-wide v9

    .line 1323
    .local v9, "fileSize":J
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const/16 v12, 0x7c

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    move-object v8, v11

    .line 1324
    .local v8, "metaData":Ljava/lang/String;
    sget-object v11, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v8, v11}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v11

    const-string v12, "this as java.lang.String).getBytes(charset)"

    invoke-static {v11, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .end local v8    # "metaData":Ljava/lang/String;
    invoke-virtual {v0, v11}, Ljava/io/BufferedOutputStream;->write([B)V

    .line 1325
    invoke-virtual {v0}, Ljava/io/BufferedOutputStream;->flush()V

    .line 1326
    move-object v8, v4

    check-cast v8, Lkotlin/coroutines/Continuation;

    iput-object v7, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    iput-object v0, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$1:Ljava/lang/Object;

    iput-wide v9, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$0:J

    const/4 v11, 0x3

    iput v11, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->label:I

    const-wide/16 v11, 0x32

    invoke-static {v11, v12, v8}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v8

    if-ne v8, v1, :cond_7

    .line 1293
    return-object v1

    .line 1326
    :cond_7
    move-object v11, v0

    .line 1327
    .end local v0    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .restart local v11    # "bufferedOut":Ljava/io/BufferedOutputStream;
    :goto_5
    iget-object v0, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v8, "write 2"

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v0, v8}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1330
    const-wide/32 v12, 0x100000

    cmp-long v0, v9, v12

    if-lez v0, :cond_8

    const/high16 v3, 0x10000

    :cond_8
    move v0, v3

    .line 1331
    .local v0, "bufferSize":I
    new-array v3, v0, [B

    move-object v0, v3

    .line 1332
    .local v0, "buffer":[B
    new-instance v3, Lkotlin/jvm/internal/Ref$IntRef;

    invoke-direct {v3}, Lkotlin/jvm/internal/Ref$IntRef;-><init>()V

    .line 1333
    .local v3, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    const-wide/16 v12, 0x0

    .line 1334
    .local v12, "totalSent":J
    move-wide v8, v9

    .line 1337
    .end local v9    # "fileSize":J
    .local v8, "totalSize":J
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v10

    check-cast v10, Lkotlin/coroutines/CoroutineContext;

    new-instance v14, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$2;

    iget-object v15, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    invoke-direct {v14, v15, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$2;-><init>(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    check-cast v14, Lkotlin/jvm/functions/Function2;

    move-object v15, v4

    check-cast v15, Lkotlin/coroutines/Continuation;

    iput-object v7, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    iput-object v11, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$1:Ljava/lang/Object;

    iput-object v0, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$2:Ljava/lang/Object;

    iput-object v3, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$3:Ljava/lang/Object;

    iput-wide v12, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$0:J

    iput-wide v8, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$1:J

    const/4 v5, 0x4

    iput v5, v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->label:I

    invoke-static {v10, v14, v15}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v5
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_d
    .catchall {:try_start_a .. :try_end_a} :catchall_b

    if-ne v5, v1, :cond_9

    .line 1293
    return-object v1

    .line 1337
    :cond_9
    move-object v10, v0

    move-object v0, v3

    move-object v3, v4

    move-object v4, v6

    .line 1340
    .end local v6    # "$result":Ljava/lang/Object;
    .local v0, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v3, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v4, "$result":Ljava/lang/Object;
    .restart local v10    # "buffer":[B
    :goto_6
    :try_start_b
    iget-object v5, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "write 3"

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_c
    .catchall {:try_start_b .. :try_end_b} :catchall_a

    move-object v14, v10

    move-object v15, v11

    move-wide v9, v8

    move-object/from16 v20, v3

    move-object v3, v1

    move-object/from16 v1, v20

    .line 1342
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .end local v8    # "totalSize":J
    .end local v10    # "buffer":[B
    .end local v11    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .restart local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v9, "totalSize":J
    .restart local v14    # "buffer":[B
    .restart local v15    # "bufferedOut":Ljava/io/BufferedOutputStream;
    :goto_7
    :try_start_c
    invoke-virtual {v7, v14}, Ljava/io/FileInputStream;->read([B)I

    move-result v5

    move v6, v5

    .line 1452
    .local v6, "it":I
    const/4 v8, 0x0

    .line 1342
    .local v8, "$i$a$-also-ClassicBlueToothClientManager$ConnectedThread$write$2$3":I
    iput v6, v0, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    .end local v6    # "it":I
    .end local v8    # "$i$a$-also-ClassicBlueToothClientManager$ConnectedThread$write$2$3":I
    const/4 v6, -0x1

    if-eq v5, v6, :cond_d

    .line 1346
    iget v5, v0, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    const/4 v6, 0x0

    invoke-virtual {v15, v14, v6, v5}, Ljava/io/BufferedOutputStream;->write([BII)V

    .line 1347
    iget v5, v0, Lkotlin/jvm/internal/Ref$IntRef;->element:I
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_b
    .catchall {:try_start_c .. :try_end_c} :catchall_9

    move-object v8, v7

    .end local v7    # "fileInputStream":Ljava/io/FileInputStream;
    .local v8, "fileInputStream":Ljava/io/FileInputStream;
    int-to-long v6, v5

    add-long/2addr v12, v6

    .line 1350
    long-to-float v5, v12

    long-to-float v6, v9

    div-float/2addr v5, v6

    const/16 v6, 0x64

    int-to-float v6, v6

    mul-float/2addr v5, v6

    .line 1351
    .local v5, "progress":F
    mul-float/2addr v6, v5

    :try_start_d
    invoke-static {v6}, Lkotlin/math/MathKt;->roundToInt(F)I

    move-result v6

    int-to-float v6, v6

    const/high16 v7, 0x42c80000    # 100.0f

    div-float v5, v6, v7

    .line 1352
    .local v5, "roundedProgress":F
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v16

    move-wide/from16 v18, v16

    .line 1354
    .local v18, "currentTime":J
    iget-object v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$lastProgressTime:Lkotlin/jvm/internal/Ref$LongRef;
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_9
    .catchall {:try_start_d .. :try_end_d} :catchall_7

    move-object v11, v8

    .end local v8    # "fileInputStream":Ljava/io/FileInputStream;
    .local v11, "fileInputStream":Ljava/io/FileInputStream;
    :try_start_e
    iget-wide v7, v6, Lkotlin/jvm/internal/Ref$LongRef;->element:J
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_8
    .catchall {:try_start_e .. :try_end_e} :catchall_6

    move-object v6, v3

    move-wide/from16 v2, v18

    .end local v18    # "currentTime":J
    .local v2, "currentTime":J
    sub-long v18, v2, v7

    :try_start_f
    iget v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$PROGRESS_INTERVAL:I
    :try_end_f
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_7
    .catchall {:try_start_f .. :try_end_f} :catchall_6

    int-to-long v7, v7

    cmp-long v7, v18, v7

    if-gez v7, :cond_b

    .line 1355
    const/high16 v7, 0x42c80000    # 100.0f

    cmpl-float v7, v5, v7

    if-gez v7, :cond_b

    .line 1356
    :try_start_10
    iget-object v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$lastProgressValue:Lkotlin/jvm/internal/Ref$FloatRef;

    iget v7, v7, Lkotlin/jvm/internal/Ref$FloatRef;->element:F
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_4
    .catchall {:try_start_10 .. :try_end_10} :catchall_5

    sub-float v7, v5, v7

    const/high16 v8, 0x3f800000    # 1.0f

    cmpl-float v7, v7, v8

    if-ltz v7, :cond_a

    goto :goto_8

    :cond_a
    move-object/from16 v2, p0

    move-object v3, v6

    move-object v7, v11

    goto :goto_7

    .line 1376
    .end local v0    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v2    # "currentTime":J
    .end local v5    # "roundedProgress":F
    .end local v9    # "totalSize":J
    .end local v12    # "totalSent":J
    .end local v14    # "buffer":[B
    .end local v15    # "bufferedOut":Ljava/io/BufferedOutputStream;
    :catch_4
    move-exception v0

    move-object v3, v4

    move-object v4, v11

    goto/16 :goto_c

    .line 1359
    .restart local v0    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v2    # "currentTime":J
    .restart local v5    # "roundedProgress":F
    .restart local v9    # "totalSize":J
    .restart local v12    # "totalSent":J
    .restart local v14    # "buffer":[B
    .restart local v15    # "bufferedOut":Ljava/io/BufferedOutputStream;
    :cond_b
    :goto_8
    :try_start_11
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v7

    check-cast v7, Lkotlin/coroutines/CoroutineContext;

    new-instance v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$4;
    :try_end_11
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_7
    .catchall {:try_start_11 .. :try_end_11} :catchall_6

    move-object/from16 p1, v4

    .end local v4    # "$result":Ljava/lang/Object;
    .local p1, "$result":Ljava/lang/Object;
    :try_start_12
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;
    :try_end_12
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_a
    .catchall {:try_start_12 .. :try_end_12} :catchall_8

    move-object/from16 v16, v6

    const/4 v6, 0x0

    :try_start_13
    invoke-direct {v8, v4, v5, v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$4;-><init>(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;FLkotlin/coroutines/Continuation;)V

    check-cast v8, Lkotlin/jvm/functions/Function2;

    move-object v4, v1

    check-cast v4, Lkotlin/coroutines/Continuation;

    iput-object v11, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    iput-object v15, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$1:Ljava/lang/Object;

    iput-object v14, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$2:Ljava/lang/Object;

    iput-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$3:Ljava/lang/Object;

    iput-wide v12, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$0:J

    iput-wide v9, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$1:J

    iput v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->F$0:F

    iput-wide v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->J$2:J

    const/4 v6, 0x5

    iput v6, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->label:I

    invoke-static {v7, v8, v4}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v4
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_6
    .catchall {:try_start_13 .. :try_end_13} :catchall_8

    move-object/from16 v6, v16

    if-ne v4, v6, :cond_c

    .line 1293
    return-object v6

    .line 1359
    :cond_c
    move-object/from16 v4, p1

    move-wide v7, v2

    move-object v3, v6

    move-wide/from16 v20, v12

    move-object v13, v0

    move v0, v5

    move-wide/from16 v5, v20

    .line 1362
    .end local v2    # "currentTime":J
    .end local v12    # "totalSent":J
    .end local p1    # "$result":Ljava/lang/Object;
    .local v0, "roundedProgress":F
    .restart local v4    # "$result":Ljava/lang/Object;
    .local v5, "totalSent":J
    .local v7, "currentTime":J
    .restart local v13    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :goto_9
    :try_start_14
    iget-object v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$lastProgressTime:Lkotlin/jvm/internal/Ref$LongRef;

    iput-wide v7, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 1363
    .end local v7    # "currentTime":J
    iget-object v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$lastProgressValue:Lkotlin/jvm/internal/Ref$FloatRef;

    iput v0, v2, Lkotlin/jvm/internal/Ref$FloatRef;->element:F
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_5
    .catchall {:try_start_14 .. :try_end_14} :catchall_5

    move-object/from16 v2, p0

    move-object v7, v11

    move-object v0, v13

    move-wide v12, v5

    .end local v0    # "roundedProgress":F
    goto/16 :goto_7

    .line 1382
    .end local v5    # "totalSent":J
    .end local v9    # "totalSize":J
    .end local v13    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v14    # "buffer":[B
    .end local v15    # "bufferedOut":Ljava/io/BufferedOutputStream;
    :catchall_5
    move-exception v0

    move-object v3, v4

    move-object v4, v11

    goto/16 :goto_f

    .line 1376
    :catch_5
    move-exception v0

    move-object v6, v3

    move-object v3, v4

    move-object v4, v11

    goto/16 :goto_c

    .end local v4    # "$result":Ljava/lang/Object;
    .restart local p1    # "$result":Ljava/lang/Object;
    :catch_6
    move-exception v0

    move-object/from16 v6, v16

    move-object/from16 v3, p1

    move-object v4, v11

    goto/16 :goto_c

    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    :catch_7
    move-exception v0

    goto :goto_a

    .line 1382
    :catchall_6
    move-exception v0

    move-object/from16 p1, v4

    move-object/from16 v3, p1

    move-object v4, v11

    .end local v4    # "$result":Ljava/lang/Object;
    .restart local p1    # "$result":Ljava/lang/Object;
    goto/16 :goto_f

    .line 1376
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    :catch_8
    move-exception v0

    move-object v6, v3

    :goto_a
    move-object/from16 p1, v4

    move-object/from16 v3, p1

    move-object v4, v11

    .end local v4    # "$result":Ljava/lang/Object;
    .restart local p1    # "$result":Ljava/lang/Object;
    goto/16 :goto_c

    .line 1382
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v8    # "fileInputStream":Ljava/io/FileInputStream;
    :catchall_7
    move-exception v0

    move-object/from16 p1, v4

    move-object v11, v8

    move-object/from16 v3, p1

    move-object v4, v11

    .end local v4    # "$result":Ljava/lang/Object;
    .end local v8    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local p1    # "$result":Ljava/lang/Object;
    goto/16 :goto_f

    .line 1376
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v8    # "fileInputStream":Ljava/io/FileInputStream;
    :catch_9
    move-exception v0

    move-object v6, v3

    move-object/from16 p1, v4

    move-object v11, v8

    move-object/from16 v3, p1

    move-object v4, v11

    .end local v4    # "$result":Ljava/lang/Object;
    .end local v8    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local p1    # "$result":Ljava/lang/Object;
    goto/16 :goto_c

    .line 1342
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local p1    # "$result":Ljava/lang/Object;
    .local v0, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v4    # "$result":Ljava/lang/Object;
    .local v7, "fileInputStream":Ljava/io/FileInputStream;
    .restart local v9    # "totalSize":J
    .restart local v12    # "totalSent":J
    .restart local v14    # "buffer":[B
    .restart local v15    # "bufferedOut":Ljava/io/BufferedOutputStream;
    :cond_d
    move-object v6, v3

    move-object/from16 p1, v4

    move-object v11, v7

    .line 1368
    .end local v0    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v7    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v9    # "totalSize":J
    .end local v12    # "totalSent":J
    .end local v14    # "buffer":[B
    .restart local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local p1    # "$result":Ljava/lang/Object;
    :try_start_15
    invoke-virtual {v15}, Ljava/io/BufferedOutputStream;->flush()V

    .line 1369
    .end local v15    # "bufferedOut":Ljava/io/BufferedOutputStream;
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$1:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "write onComplete"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1372
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$5;

    iget-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    const/4 v4, 0x0

    invoke-direct {v2, v3, v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$5;-><init>(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    check-cast v2, Lkotlin/jvm/functions/Function2;

    move-object v3, v1

    check-cast v3, Lkotlin/coroutines/Continuation;

    iput-object v11, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    const/4 v4, 0x0

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$1:Ljava/lang/Object;

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$2:Ljava/lang/Object;

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$3:Ljava/lang/Object;

    const/4 v4, 0x6

    iput v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->label:I

    invoke-static {v0, v2, v3}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_15
    .catch Ljava/lang/Exception; {:try_start_15 .. :try_end_15} :catch_a
    .catchall {:try_start_15 .. :try_end_15} :catchall_8

    if-ne v0, v6, :cond_e

    .line 1293
    return-object v6

    .line 1372
    :cond_e
    move-object/from16 v4, p1

    move-object v3, v1

    move-object v6, v11

    .line 1382
    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .restart local v4    # "$result":Ljava/lang/Object;
    .local v6, "fileInputStream":Ljava/io/FileInputStream;
    :goto_b
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lkotlinx/coroutines/Job;)V

    .line 1384
    nop

    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    if-eqz v6, :cond_f

    invoke-virtual {v6}, Ljava/io/FileInputStream;->close()V

    .line 1387
    :cond_f
    goto/16 :goto_e

    .line 1382
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .end local v4    # "$result":Ljava/lang/Object;
    .restart local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .restart local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_8
    move-exception v0

    move-object/from16 v3, p1

    move-object v4, v11

    goto/16 :goto_f

    .line 1376
    :catch_a
    move-exception v0

    move-object/from16 v3, p1

    move-object v4, v11

    goto :goto_c

    .line 1382
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v7    # "fileInputStream":Ljava/io/FileInputStream;
    :catchall_9
    move-exception v0

    move-object/from16 p1, v4

    move-object v11, v7

    move-object/from16 v3, p1

    move-object v4, v11

    .end local v4    # "$result":Ljava/lang/Object;
    .end local v7    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local p1    # "$result":Ljava/lang/Object;
    goto/16 :goto_f

    .line 1376
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v7    # "fileInputStream":Ljava/io/FileInputStream;
    :catch_b
    move-exception v0

    move-object v6, v3

    move-object/from16 p1, v4

    move-object v11, v7

    move-object/from16 v3, p1

    move-object v4, v11

    .end local v4    # "$result":Ljava/lang/Object;
    .end local v7    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local p1    # "$result":Ljava/lang/Object;
    goto :goto_c

    .line 1382
    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v7    # "fileInputStream":Ljava/io/FileInputStream;
    :catchall_a
    move-exception v0

    move-object v1, v3

    move-object v3, v4

    move-object v4, v7

    goto :goto_f

    .line 1376
    :catch_c
    move-exception v0

    move-object v6, v1

    move-object v1, v3

    move-object v3, v4

    move-object v4, v7

    goto :goto_c

    .line 1382
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v4, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v6, "$result":Ljava/lang/Object;
    :catchall_b
    move-exception v0

    move-object v1, v4

    move-object v3, v6

    move-object v4, v7

    goto :goto_f

    .line 1376
    :catch_d
    move-exception v0

    move-object v3, v6

    move-object v6, v1

    move-object v1, v4

    move-object v4, v7

    .line 1377
    .end local v6    # "$result":Ljava/lang/Object;
    .end local v7    # "fileInputStream":Ljava/io/FileInputStream;
    .local v0, "e":Ljava/lang/Exception;
    .restart local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v3, "$result":Ljava/lang/Object;
    .local v4, "fileInputStream":Ljava/io/FileInputStream;
    :goto_c
    :try_start_16
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 1378
    .end local v0    # "e":Ljava/lang/Exception;
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$6;

    iget-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->$listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    const/4 v7, 0x0

    invoke-direct {v2, v5, v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2$6;-><init>(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    check-cast v2, Lkotlin/jvm/functions/Function2;

    move-object v5, v1

    check-cast v5, Lkotlin/coroutines/Continuation;

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$0:Ljava/lang/Object;

    const/4 v7, 0x0

    iput-object v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$1:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$2:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->L$3:Ljava/lang/Object;

    const/4 v7, 0x7

    iput v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->label:I

    invoke-static {v0, v2, v5}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_0

    if-ne v0, v6, :cond_10

    .line 1293
    return-object v6

    .line 1382
    :cond_10
    :goto_d
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    const/4 v2, 0x0

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lkotlinx/coroutines/Job;)V

    .line 1384
    nop

    .end local v4    # "fileInputStream":Ljava/io/FileInputStream;
    if-eqz v4, :cond_11

    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V

    .line 1387
    :cond_11
    move-object v4, v3

    move-object v3, v1

    .line 1388
    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v3, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v4, "$result":Ljava/lang/Object;
    :goto_e
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 1382
    .restart local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;
    .local v3, "$result":Ljava/lang/Object;
    .local v4, "fileInputStream":Ljava/io/FileInputStream;
    :goto_f
    iget-object v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    const/4 v5, 0x0

    invoke-static {v2, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lkotlinx/coroutines/Job;)V

    .line 1384
    nop

    .end local v4    # "fileInputStream":Ljava/io/FileInputStream;
    if-eqz v4, :cond_12

    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V

    :cond_12
    throw v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
