.class final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ClassicBluetoothService.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->sendFileBroadcast(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
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
    value = "SMAP\nClassicBluetoothService.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBluetoothService.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,1582:1\n1855#2:1583\n1856#2:1585\n1#3:1584\n*S KotlinDebug\n*F\n+ 1 ClassicBluetoothService.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1\n*L\n826#1:1583\n826#1:1585\n*E\n"
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
    c = "com.rokid.glasses.transport.sdk.server.bluetooth.server.ClassicBluetoothService$sendFileBroadcast$1"
    f = "ClassicBluetoothService.kt"
    i = {
        0x0,
        0x0,
        0x0,
        0x0,
        0x0,
        0x0,
        0x1,
        0x1,
        0x1,
        0x1,
        0x1,
        0x1,
        0x1,
        0x1,
        0x1,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x3,
        0x3,
        0x3,
        0x4,
        0x4,
        0x4,
        0x5
    }
    l = {
        0x35a,
        0x365,
        0x37d,
        0x387,
        0x38e,
        0x39c
    }
    m = "invokeSuspend"
    n = {
        "$this$launch",
        "bufferedOut",
        "fileInputStream",
        "bufferedIn",
        "isFailed",
        "fileSize",
        "$this$launch",
        "bufferedOut",
        "fileInputStream",
        "bufferedIn",
        "buffer",
        "bytesRead",
        "isFailed",
        "totalSent",
        "totalSize",
        "$this$launch",
        "bufferedOut",
        "fileInputStream",
        "bufferedIn",
        "buffer",
        "bytesRead",
        "isFailed",
        "totalSent",
        "totalSize",
        "roundedProgress",
        "currentTime",
        "$this$launch",
        "fileInputStream",
        "isFailed",
        "$this$launch",
        "fileInputStream",
        "isFailed",
        "$this$launch"
    }
    s = {
        "L$0",
        "L$8",
        "L$9",
        "L$10",
        "I$1",
        "J$0",
        "L$0",
        "L$8",
        "L$9",
        "L$10",
        "L$11",
        "L$12",
        "I$1",
        "J$0",
        "J$1",
        "L$0",
        "L$8",
        "L$9",
        "L$10",
        "L$11",
        "L$12",
        "I$1",
        "J$0",
        "J$1",
        "F$0",
        "J$2",
        "L$0",
        "L$8",
        "I$1",
        "L$0",
        "L$8",
        "I$1",
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

.field I$0:I

.field I$1:I

.field J$0:J

.field J$1:J

.field J$2:J

.field private synthetic L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$10:Ljava/lang/Object;

.field L$11:Ljava/lang/Object;

.field L$12:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field L$4:Ljava/lang/Object;

.field L$5:Ljava/lang/Object;

.field L$6:Ljava/lang/Object;

.field L$7:Ljava/lang/Object;

.field L$8:Ljava/lang/Object;

.field L$9:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Ljava/io/File;Ljava/lang/String;Lkotlin/jvm/internal/Ref$LongRef;ILkotlin/jvm/internal/Ref$FloatRef;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;",
            "Ljava/io/File;",
            "Ljava/lang/String;",
            "Lkotlin/jvm/internal/Ref$LongRef;",
            "I",
            "Lkotlin/jvm/internal/Ref$FloatRef;",
            "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$file:Ljava/io/File;

    iput-object p3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$dir:Ljava/lang/String;

    iput-object p4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$lastProgressTime:Lkotlin/jvm/internal/Ref$LongRef;

    iput p5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$PROGRESS_INTERVAL:I

    iput-object p6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$lastProgressValue:Lkotlin/jvm/internal/Ref$FloatRef;

    iput-object p7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p8}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 10
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

    new-instance v9, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$file:Ljava/io/File;

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$dir:Ljava/lang/String;

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$lastProgressTime:Lkotlin/jvm/internal/Ref$LongRef;

    iget v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$PROGRESS_INTERVAL:I

    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$lastProgressValue:Lkotlin/jvm/internal/Ref$FloatRef;

    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    move-object v0, v9

    move-object v8, p2

    invoke-direct/range {v0 .. v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Ljava/io/File;Ljava/lang/String;Lkotlin/jvm/internal/Ref$LongRef;ILkotlin/jvm/internal/Ref$FloatRef;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    iput-object p1, v9, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    check-cast v9, Lkotlin/coroutines/Continuation;

    return-object v9
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 39

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 824
    move-object/from16 v2, p0

    iget v0, v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->label:I

    const-string v6, "ClassicBluetoothService "

    packed-switch v0, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v8, p0

    .local v8, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    move-object/from16 v9, p1

    .local v9, "$result":Ljava/lang/Object;
    const/4 v10, 0x0

    .local v10, "$i$f$forEach":I
    const/4 v11, 0x0

    .local v11, "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    iget v0, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I

    iget-object v12, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;

    check-cast v12, Ljava/util/Iterator;

    iget-object v13, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;

    check-cast v13, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    iget-object v14, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    check-cast v14, Lkotlin/jvm/internal/Ref$FloatRef;

    iget-object v15, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;

    check-cast v15, Lkotlin/jvm/internal/Ref$LongRef;

    iget-object v4, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    check-cast v4, Ljava/lang/String;

    iget-object v3, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;

    check-cast v3, Ljava/io/File;

    iget-object v7, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v5, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    check-cast v5, Lkotlinx/coroutines/CoroutineScope;

    .local v5, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_0
    invoke-static {v9}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v2, v9

    move-object v9, v6

    goto/16 :goto_2c

    .line 931
    .end local v5    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_0
    move-exception v0

    goto/16 :goto_2e

    .line 824
    .end local v8    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v9    # "$result":Ljava/lang/Object;
    .end local v10    # "$i$f$forEach":I
    .end local v11    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    :pswitch_1
    move-object/from16 v3, p0

    .local v3, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    move-object/from16 v4, p1

    .local v4, "$result":Ljava/lang/Object;
    const/4 v5, 0x0

    .local v5, "$i$f$forEach":I
    const/4 v7, 0x0

    .local v7, "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    iget v8, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$1:I

    .local v8, "isFailed":Z
    iget v9, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$8:Ljava/lang/Object;

    move-object v10, v0

    check-cast v10, Ljava/io/FileInputStream;

    .local v10, "fileInputStream":Ljava/io/FileInputStream;
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;

    move-object v11, v0

    check-cast v11, Ljava/util/Iterator;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;

    move-object v12, v0

    check-cast v12, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    move-object v13, v0

    check-cast v13, Lkotlin/jvm/internal/Ref$FloatRef;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;

    move-object v14, v0

    check-cast v14, Lkotlin/jvm/internal/Ref$LongRef;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    move-object v15, v0

    check-cast v15, Ljava/lang/String;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;

    move-object/from16 v18, v0

    check-cast v18, Ljava/io/File;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;

    move-object/from16 v19, v0

    check-cast v19, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    move-object/from16 v20, v0

    check-cast v20, Lkotlinx/coroutines/CoroutineScope;

    .local v20, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_1
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-object/from16 v28, v6

    goto/16 :goto_24

    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$forEach":I
    .end local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v8    # "isFailed":Z
    .end local v10    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :pswitch_2
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    const/4 v5, 0x0

    .restart local v5    # "$i$f$forEach":I
    const/4 v7, 0x0

    .restart local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    iget v8, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$1:I

    .restart local v8    # "isFailed":Z
    iget v9, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$8:Ljava/lang/Object;

    move-object v10, v0

    check-cast v10, Ljava/io/FileInputStream;

    .restart local v10    # "fileInputStream":Ljava/io/FileInputStream;
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;

    move-object v11, v0

    check-cast v11, Ljava/util/Iterator;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;

    move-object v12, v0

    check-cast v12, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    move-object v13, v0

    check-cast v13, Lkotlin/jvm/internal/Ref$FloatRef;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;

    move-object v14, v0

    check-cast v14, Lkotlin/jvm/internal/Ref$LongRef;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    move-object v15, v0

    check-cast v15, Ljava/lang/String;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;

    move-object/from16 v18, v0

    check-cast v18, Ljava/io/File;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;

    move-object/from16 v19, v0

    check-cast v19, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    move-object/from16 v20, v0

    check-cast v20, Lkotlinx/coroutines/CoroutineScope;

    .restart local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_2
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object/from16 v28, v6

    move v2, v9

    move-object v9, v4

    move-object v4, v15

    move-object v15, v11

    move v11, v7

    move-object/from16 v7, v19

    goto/16 :goto_13

    .line 916
    :catchall_1
    move-exception v0

    move-object/from16 v28, v6

    move-object/from16 v32, v15

    move-object v15, v11

    move v11, v9

    move-object v9, v4

    move-object/from16 v4, v18

    move/from16 v18, v7

    move-object/from16 v7, v19

    move/from16 v19, v5

    goto/16 :goto_28

    .line 907
    :catch_0
    move-exception v0

    move-object/from16 v28, v6

    move-object/from16 v2, v18

    move-object/from16 v6, v19

    move/from16 v18, v7

    move-object v7, v1

    move-object/from16 v1, v20

    goto/16 :goto_23

    .line 824
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$forEach":I
    .end local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v8    # "isFailed":Z
    .end local v10    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :pswitch_3
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    const/4 v5, 0x0

    .restart local v5    # "$i$f$forEach":I
    const/4 v7, 0x0

    .restart local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    iget-wide v8, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$2:J

    .local v8, "currentTime":J
    iget v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->F$0:F

    .local v0, "roundedProgress":F
    iget-wide v10, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$1:J

    .local v10, "totalSize":J
    iget-wide v12, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$0:J

    .local v12, "totalSent":J
    iget v14, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$1:I

    .local v14, "isFailed":Z
    iget v15, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I

    move/from16 v18, v0

    .end local v0    # "roundedProgress":F
    .local v18, "roundedProgress":F
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$12:Ljava/lang/Object;

    check-cast v0, Lkotlin/jvm/internal/Ref$IntRef;

    move-object/from16 p1, v0

    .local p1, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$11:Ljava/lang/Object;

    check-cast v0, [B

    move-object/from16 v19, v0

    .local v19, "buffer":[B
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$10:Ljava/lang/Object;

    check-cast v0, Ljava/io/BufferedInputStream;

    move-object/from16 v20, v0

    .local v20, "bufferedIn":Ljava/io/BufferedInputStream;
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$9:Ljava/lang/Object;

    move-object/from16 v21, v0

    check-cast v21, Ljava/io/FileInputStream;

    .local v21, "fileInputStream":Ljava/io/FileInputStream;
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$8:Ljava/lang/Object;

    check-cast v0, Ljava/io/BufferedOutputStream;

    move-object/from16 v22, v0

    .local v22, "bufferedOut":Ljava/io/BufferedOutputStream;
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;

    move-object/from16 v23, v0

    check-cast v23, Ljava/util/Iterator;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;

    move-object/from16 v24, v0

    check-cast v24, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    move-object/from16 v25, v0

    check-cast v25, Lkotlin/jvm/internal/Ref$FloatRef;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;

    move-object/from16 v26, v0

    check-cast v26, Lkotlin/jvm/internal/Ref$LongRef;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    move-object/from16 v27, v0

    check-cast v27, Ljava/lang/String;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;

    move-object/from16 v28, v0

    check-cast v28, Ljava/io/File;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;

    move-object/from16 v29, v0

    check-cast v29, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    move-object/from16 v30, v0

    check-cast v30, Lkotlinx/coroutines/CoroutineScope;

    .local v30, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_3
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    move/from16 v0, v18

    move-object/from16 v2, v25

    move-object/from16 v25, v28

    move-object/from16 v28, v6

    move-wide/from16 v17, v12

    move-object/from16 v6, v19

    move-object/from16 v13, v21

    move-object/from16 v21, v1

    move/from16 v19, v5

    move-wide v11, v10

    move-object/from16 v1, v26

    move-object/from16 v5, v27

    move-object v10, v3

    move-object/from16 v3, v22

    move-object/from16 v36, v20

    move/from16 v20, v7

    move-object/from16 v7, v29

    move-object/from16 v29, v36

    move-object/from16 v37, v23

    move/from16 v23, v14

    move-object/from16 v14, v24

    move-object/from16 v24, v37

    goto/16 :goto_b

    .line 916
    .end local v8    # "currentTime":J
    .end local v10    # "totalSize":J
    .end local v12    # "totalSent":J
    .end local v18    # "roundedProgress":F
    .end local v19    # "buffer":[B
    .end local v20    # "bufferedIn":Ljava/io/BufferedInputStream;
    .end local v22    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .end local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :catchall_2
    move-exception v0

    move-object v9, v4

    move/from16 v19, v5

    move/from16 v18, v7

    move v8, v14

    move v11, v15

    move-object/from16 v10, v21

    move-object/from16 v15, v23

    move-object/from16 v12, v24

    move-object/from16 v13, v25

    move-object/from16 v14, v26

    move-object/from16 v32, v27

    move-object/from16 v4, v28

    move-object/from16 v7, v29

    move-object/from16 v20, v30

    move-object/from16 v28, v6

    goto/16 :goto_28

    .line 907
    :catch_1
    move-exception v0

    move/from16 v18, v7

    move v8, v14

    move v9, v15

    move-object/from16 v10, v21

    move-object/from16 v11, v23

    move-object/from16 v12, v24

    move-object/from16 v13, v25

    move-object/from16 v14, v26

    move-object/from16 v15, v27

    move-object/from16 v2, v28

    move-object v7, v1

    move-object/from16 v28, v6

    move-object/from16 v6, v29

    move-object/from16 v1, v30

    goto/16 :goto_23

    .line 824
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$forEach":I
    .end local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v14    # "isFailed":Z
    .end local v21    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v30    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :pswitch_4
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    const/4 v5, 0x0

    .restart local v5    # "$i$f$forEach":I
    const/4 v7, 0x0

    .restart local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    iget-wide v8, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$1:J

    .local v8, "totalSize":J
    iget-wide v10, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$0:J

    .local v10, "totalSent":J
    iget v12, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$1:I

    .local v12, "isFailed":Z
    iget v13, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$12:Ljava/lang/Object;

    check-cast v0, Lkotlin/jvm/internal/Ref$IntRef;

    .local v0, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    iget-object v14, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$11:Ljava/lang/Object;

    check-cast v14, [B

    .local v14, "buffer":[B
    iget-object v15, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$10:Ljava/lang/Object;

    check-cast v15, Ljava/io/BufferedInputStream;

    move-object/from16 p1, v0

    .end local v0    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v15, "bufferedIn":Ljava/io/BufferedInputStream;
    .restart local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$9:Ljava/lang/Object;

    move-object/from16 v18, v0

    check-cast v18, Ljava/io/FileInputStream;

    .local v18, "fileInputStream":Ljava/io/FileInputStream;
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$8:Ljava/lang/Object;

    check-cast v0, Ljava/io/BufferedOutputStream;

    move-object/from16 v19, v0

    .local v19, "bufferedOut":Ljava/io/BufferedOutputStream;
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;

    move-object/from16 v20, v0

    check-cast v20, Ljava/util/Iterator;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;

    move-object/from16 v21, v0

    check-cast v21, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    move-object/from16 v22, v0

    check-cast v22, Lkotlin/jvm/internal/Ref$FloatRef;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;

    move-object/from16 v23, v0

    check-cast v23, Lkotlin/jvm/internal/Ref$LongRef;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    move-object/from16 v24, v0

    check-cast v24, Ljava/lang/String;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;

    move-object/from16 v25, v0

    check-cast v25, Ljava/io/File;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;

    move-object/from16 v26, v0

    check-cast v26, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    move-object/from16 v27, v0

    check-cast v27, Lkotlinx/coroutines/CoroutineScope;

    .local v27, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_4
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    move-object/from16 v17, v15

    move-object/from16 v0, v19

    move-object/from16 v15, v21

    move-object/from16 v2, v23

    move-object/from16 v23, p1

    move-object/from16 v21, v6

    move-object v6, v14

    move-object/from16 v14, v20

    move-object/from16 v20, v27

    move-wide/from16 v27, v8

    move v8, v12

    move v9, v13

    move-object/from16 v13, v22

    move-wide v11, v10

    move-object/from16 v10, v18

    move-object/from16 v18, v25

    goto/16 :goto_6

    .line 916
    .end local v8    # "totalSize":J
    .end local v10    # "totalSent":J
    .end local v14    # "buffer":[B
    .end local v15    # "bufferedIn":Ljava/io/BufferedInputStream;
    .end local v19    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .end local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :catchall_3
    move-exception v0

    move-object v9, v4

    move/from16 v19, v5

    move-object/from16 v28, v6

    move v8, v12

    move v11, v13

    move-object/from16 v10, v18

    move-object/from16 v15, v20

    move-object/from16 v12, v21

    move-object/from16 v13, v22

    move-object/from16 v14, v23

    move-object/from16 v32, v24

    move-object/from16 v4, v25

    move-object/from16 v20, v27

    move/from16 v18, v7

    move-object/from16 v7, v26

    goto/16 :goto_28

    .line 907
    :catch_2
    move-exception v0

    move-object/from16 v28, v6

    move v8, v12

    move v9, v13

    move-object/from16 v10, v18

    move-object/from16 v11, v20

    move-object/from16 v12, v21

    move-object/from16 v13, v22

    move-object/from16 v14, v23

    move-object/from16 v15, v24

    move-object/from16 v2, v25

    move-object/from16 v6, v26

    move/from16 v18, v7

    move-object v7, v1

    move-object/from16 v1, v27

    goto/16 :goto_23

    .line 824
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$forEach":I
    .end local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v12    # "isFailed":Z
    .end local v18    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v27    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :pswitch_5
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    const/4 v5, 0x0

    .restart local v5    # "$i$f$forEach":I
    const/4 v7, 0x0

    .restart local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    iget-wide v8, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$0:J

    .local v8, "fileSize":J
    iget v10, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$1:I

    .local v10, "isFailed":Z
    iget v11, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$10:Ljava/lang/Object;

    check-cast v0, Ljava/io/BufferedInputStream;

    .local v0, "bufferedIn":Ljava/io/BufferedInputStream;
    iget-object v12, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$9:Ljava/lang/Object;

    check-cast v12, Ljava/io/FileInputStream;

    .local v12, "fileInputStream":Ljava/io/FileInputStream;
    iget-object v13, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$8:Ljava/lang/Object;

    check-cast v13, Ljava/io/BufferedOutputStream;

    .local v13, "bufferedOut":Ljava/io/BufferedOutputStream;
    iget-object v14, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;

    check-cast v14, Ljava/util/Iterator;

    iget-object v15, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;

    check-cast v15, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    move-object/from16 p1, v0

    .end local v0    # "bufferedIn":Ljava/io/BufferedInputStream;
    .local p1, "bufferedIn":Ljava/io/BufferedInputStream;
    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    move-object/from16 v18, v0

    check-cast v18, Lkotlin/jvm/internal/Ref$FloatRef;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;

    move-object/from16 v19, v0

    check-cast v19, Lkotlin/jvm/internal/Ref$LongRef;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    move-object/from16 v20, v0

    check-cast v20, Ljava/lang/String;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;

    move-object/from16 v21, v0

    check-cast v21, Ljava/io/File;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;

    move-object/from16 v22, v0

    check-cast v22, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    move-object/from16 v23, v0

    check-cast v23, Lkotlinx/coroutines/CoroutineScope;

    .local v23, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_5
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_3
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    move/from16 v17, v5

    move-object v0, v13

    move-object/from16 v13, v18

    move-object/from16 v2, v19

    move-object/from16 v5, v21

    move-object/from16 v19, v1

    move-object/from16 v21, v6

    move/from16 v18, v7

    move-object/from16 v6, v20

    move-object/from16 v1, v22

    move-object/from16 v7, v23

    move-object/from16 v36, v4

    move-object/from16 v4, p1

    move-object/from16 p1, v36

    goto/16 :goto_4

    .line 916
    .end local v8    # "fileSize":J
    .end local v13    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .end local p1    # "bufferedIn":Ljava/io/BufferedInputStream;
    :catchall_4
    move-exception v0

    move-object v9, v4

    move-object/from16 v28, v6

    move v8, v10

    move-object v10, v12

    move-object v12, v15

    move-object/from16 v13, v18

    move-object/from16 v32, v20

    move-object/from16 v4, v21

    move-object/from16 v20, v23

    move/from16 v18, v7

    move-object v15, v14

    move-object/from16 v14, v19

    move-object/from16 v7, v22

    move/from16 v19, v5

    goto/16 :goto_28

    .line 907
    :catch_3
    move-exception v0

    move-object/from16 v28, v6

    move v8, v10

    move v9, v11

    move-object v10, v12

    move-object v11, v14

    move-object v12, v15

    move-object/from16 v13, v18

    move-object/from16 v14, v19

    move-object/from16 v15, v20

    move-object/from16 v2, v21

    move-object/from16 v6, v22

    move/from16 v18, v7

    move-object v7, v1

    move-object/from16 v1, v23

    goto/16 :goto_23

    .line 824
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$forEach":I
    .end local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v10    # "isFailed":Z
    .end local v12    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v23    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :pswitch_6
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v0, p0

    .local v0, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    move-object/from16 v3, p1

    .local v3, "$result":Ljava/lang/Object;
    iget-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    check-cast v4, Lkotlinx/coroutines/CoroutineScope;

    .line 826
    .local v4, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    iget-object v5, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedFileSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v5

    check-cast v5, Ljava/lang/Iterable;

    .local v5, "$this$forEach$iv":Ljava/lang/Iterable;
    iget-object v7, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    iget-object v8, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$file:Ljava/io/File;

    iget-object v9, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$dir:Ljava/lang/String;

    iget-object v10, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$lastProgressTime:Lkotlin/jvm/internal/Ref$LongRef;

    iget v11, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$PROGRESS_INTERVAL:I

    iget-object v12, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$lastProgressValue:Lkotlin/jvm/internal/Ref$FloatRef;

    iget-object v13, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->$listener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    const/4 v14, 0x0

    .line 1583
    .local v14, "$i$f$forEach":I
    invoke-interface {v5}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v15

    move-object v5, v4

    move-object v4, v8

    move-object v8, v0

    move-object/from16 v36, v9

    move-object v9, v3

    move-object/from16 v3, v36

    move/from16 v37, v14

    move-object v14, v10

    move/from16 v10, v37

    move-object/from16 v38, v13

    move-object v13, v12

    move-object/from16 v12, v38

    .end local v0    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v3    # "$result":Ljava/lang/Object;
    .end local v4    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v14    # "$i$f$forEach":I
    .local v5, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v8, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .restart local v9    # "$result":Ljava/lang/Object;
    .local v10, "$i$f$forEach":I
    :goto_0
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_18

    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .local v0, "element$iv":Ljava/lang/Object;
    check-cast v0, Landroid/bluetooth/BluetoothSocket;

    .local v0, "socket":Landroid/bluetooth/BluetoothSocket;
    const/16 v18, 0x0

    .line 828
    .local v18, "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 p1, v9

    .end local v9    # "$result":Ljava/lang/Object;
    .local p1, "$result":Ljava/lang/Object;
    const-string v9, "sendFileBroadcast-->"

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMConnectedFileSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v9

    invoke-static {v0, v9}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v9

    move/from16 v19, v10

    const/4 v10, 0x1

    .end local v10    # "$i$f$forEach":I
    .local v19, "$i$f$forEach":I
    if-ne v9, v10, :cond_1

    const/4 v9, 0x1

    goto :goto_1

    .end local v19    # "$i$f$forEach":I
    .restart local v10    # "$i$f$forEach":I
    :cond_0
    move/from16 v19, v10

    .end local v10    # "$i$f$forEach":I
    .restart local v19    # "$i$f$forEach":I
    :cond_1
    const/4 v9, 0x0

    :goto_1
    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v6, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 830
    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMConnectedFileSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;

    move-result-object v2

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_17

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v2

    const/4 v9, 0x1

    if-ne v2, v9, :cond_17

    .line 831
    const/4 v2, 0x0

    .line 833
    .local v2, "isFailed":Z
    nop

    .line 834
    :try_start_6
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v9
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_2c
    .catchall {:try_start_6 .. :try_end_6} :catchall_30

    if-nez v9, :cond_2

    .line 835
    .end local v0    # "socket":Landroid/bluetooth/BluetoothSocket;
    :try_start_7
    const-string v0, "socket\u672a\u8fde\u63a5\uff0c\u8df3\u8fc7"

    invoke-static {v6, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_4
    .catchall {:try_start_7 .. :try_end_7} :catchall_5

    .line 836
    nop

    .line 931
    .end local v2    # "isFailed":Z
    const/4 v2, 0x0

    invoke-static {v7, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlinx/coroutines/Job;)V

    .line 836
    goto :goto_2

    .line 931
    .end local v5    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_5
    move-exception v0

    move-object/from16 v9, p1

    move/from16 v11, v18

    move/from16 v10, v19

    goto/16 :goto_2e

    .line 920
    .restart local v2    # "isFailed":Z
    .restart local v5    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catch_4
    move-exception v0

    move-object/from16 v9, p1

    move-object/from16 v28, v6

    move/from16 v10, v19

    move-object v6, v0

    move v0, v11

    move/from16 v11, v18

    move-object/from16 v36, v4

    move-object v4, v3

    move-object/from16 v3, v36

    move-object/from16 v37, v13

    move-object v13, v12

    move-object v12, v15

    move-object v15, v14

    move-object/from16 v14, v37

    goto/16 :goto_2a

    .line 838
    .restart local v0    # "socket":Landroid/bluetooth/BluetoothSocket;
    :cond_2
    :try_start_8
    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v9
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_2c
    .catchall {:try_start_8 .. :try_end_8} :catchall_30

    .end local v0    # "socket":Landroid/bluetooth/BluetoothSocket;
    if-nez v9, :cond_3

    const/4 v0, 0x0

    .line 839
    .local v0, "$i$a$-run-ClassicBluetoothService$sendFileBroadcast$1$1$outputStream$1":I
    :try_start_9
    const-string v9, "outputStream\u4e3a\u7a7a\uff0c\u8df3\u8fc7"

    invoke-static {v6, v9}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_4
    .catchall {:try_start_9 .. :try_end_9} :catchall_5

    .line 840
    nop

    .line 931
    .end local v0    # "$i$a$-run-ClassicBluetoothService$sendFileBroadcast$1$1$outputStream$1":I
    .end local v2    # "isFailed":Z
    const/4 v2, 0x0

    invoke-static {v7, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlinx/coroutines/Job;)V

    .line 1583
    .end local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    :goto_2
    move-object/from16 v2, p1

    move-object v9, v6

    move-object/from16 v17, v7

    move/from16 v10, v19

    move-object v7, v1

    const/4 v1, 0x0

    goto/16 :goto_30

    .line 931
    .restart local v2    # "isFailed":Z
    .restart local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    :cond_3
    move-object v0, v9

    .line 843
    .local v0, "outputStream":Ljava/io/OutputStream;
    :try_start_a
    new-instance v9, Ljava/io/BufferedOutputStream;

    const/16 v10, 0x2000

    invoke-direct {v9, v0, v10}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;I)V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_2c
    .catchall {:try_start_a .. :try_end_a} :catchall_30

    move-object v0, v9

    .line 845
    .local v0, "bufferedOut":Ljava/io/BufferedOutputStream;
    const/4 v9, 0x0

    .line 846
    .local v9, "fileInputStream":Ljava/io/FileInputStream;
    nop

    .line 847
    :try_start_b
    new-instance v10, Ljava/io/FileInputStream;

    invoke-direct {v10, v4}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_29
    .catchall {:try_start_b .. :try_end_b} :catchall_2a

    .line 849
    .end local v9    # "fileInputStream":Ljava/io/FileInputStream;
    .local v10, "fileInputStream":Ljava/io/FileInputStream;
    :try_start_c
    new-instance v9, Ljava/io/BufferedInputStream;
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_28
    .catchall {:try_start_c .. :try_end_c} :catchall_29

    move-object/from16 v20, v1

    :try_start_d
    move-object v1, v10

    check-cast v1, Ljava/io/InputStream;

    invoke-direct {v9, v1}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    move-object v1, v9

    .line 851
    .local v1, "bufferedIn":Ljava/io/BufferedInputStream;
    const-string v9, "write 1"

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v6, v9}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_27
    .catchall {:try_start_d .. :try_end_d} :catchall_28

    .line 853
    if-nez v3, :cond_4

    :try_start_e
    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v9
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_5
    .catchall {:try_start_e .. :try_end_e} :catchall_6

    move-object/from16 v21, v6

    goto :goto_3

    .line 916
    .end local v0    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .end local v1    # "bufferedIn":Ljava/io/BufferedInputStream;
    :catchall_6
    move-exception v0

    move-object/from16 v9, p1

    move-object/from16 v32, v3

    move-object/from16 v28, v6

    move-object v3, v8

    move-object/from16 v1, v20

    move v8, v2

    move-object/from16 v20, v5

    goto/16 :goto_28

    .line 907
    :catch_5
    move-exception v0

    move-object v1, v5

    move-object/from16 v28, v6

    move-object v6, v7

    move v9, v11

    move-object v11, v15

    move/from16 v5, v19

    move-object/from16 v7, v20

    move-object v15, v3

    move-object v3, v8

    move v8, v2

    move-object v2, v4

    move-object/from16 v4, p1

    goto/16 :goto_23

    .line 853
    .restart local v0    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .restart local v1    # "bufferedIn":Ljava/io/BufferedInputStream;
    :cond_4
    :try_start_f
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9
    :try_end_f
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_27
    .catchall {:try_start_f .. :try_end_f} :catchall_28

    move-object/from16 v21, v6

    :try_start_10
    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    :goto_3
    move-object v6, v9

    .line 854
    .local v6, "fileName":Ljava/lang/String;
    invoke-virtual {v4}, Ljava/io/File;->length()J

    move-result-wide v22

    move-wide/from16 v24, v22

    .line 855
    .local v24, "fileSize":J
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    move-object/from16 v22, v6

    .end local v6    # "fileName":Ljava/lang/String;
    .local v22, "fileName":Ljava/lang/String;
    const/16 v6, 0x7c

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v6
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_26
    .catchall {:try_start_10 .. :try_end_10} :catchall_27

    move-object v9, v1

    move/from16 v23, v2

    move-wide/from16 v1, v24

    .end local v2    # "isFailed":Z
    .end local v24    # "fileSize":J
    .local v1, "fileSize":J
    .local v9, "bufferedIn":Ljava/io/BufferedInputStream;
    .local v23, "isFailed":Z
    :try_start_11
    invoke-virtual {v6, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 856
    .end local v22    # "fileName":Ljava/lang/String;
    .local v6, "metaData":Ljava/lang/String;
    move-wide/from16 v24, v1

    .end local v1    # "fileSize":J
    .restart local v24    # "fileSize":J
    sget-object v1, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v6, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    const-string v2, "this as java.lang.String).getBytes(charset)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .end local v6    # "metaData":Ljava/lang/String;
    invoke-virtual {v0, v1}, Ljava/io/BufferedOutputStream;->write([B)V

    .line 857
    invoke-virtual {v0}, Ljava/io/BufferedOutputStream;->flush()V

    .line 858
    iput-object v5, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    iput-object v7, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;

    iput-object v4, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;

    iput-object v3, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    iput-object v14, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;

    iput-object v13, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    iput-object v12, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;

    iput-object v15, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;

    iput-object v0, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$8:Ljava/lang/Object;

    iput-object v10, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$9:Ljava/lang/Object;

    iput-object v9, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$10:Ljava/lang/Object;

    const/4 v1, 0x0

    iput-object v1, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$11:Ljava/lang/Object;

    iput-object v1, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$12:Ljava/lang/Object;

    iput v11, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I
    :try_end_11
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_25
    .catchall {:try_start_11 .. :try_end_11} :catchall_26

    move/from16 v1, v23

    .end local v23    # "isFailed":Z
    .local v1, "isFailed":Z
    :try_start_12
    iput v1, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$1:I
    :try_end_12
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_24
    .catchall {:try_start_12 .. :try_end_12} :catchall_25

    move-object v2, v0

    move/from16 v23, v1

    move-wide/from16 v0, v24

    .end local v1    # "isFailed":Z
    .end local v24    # "fileSize":J
    .local v0, "fileSize":J
    .local v2, "bufferedOut":Ljava/io/BufferedOutputStream;
    .restart local v23    # "isFailed":Z
    :try_start_13
    iput-wide v0, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$0:J

    const/4 v6, 0x1

    iput v6, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->label:I
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_25
    .catchall {:try_start_13 .. :try_end_13} :catchall_26

    move-object/from16 v17, v7

    const-wide/16 v6, 0x32

    :try_start_14
    invoke-static {v6, v7, v8}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v6
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_23
    .catchall {:try_start_14 .. :try_end_14} :catchall_24

    move-object/from16 v7, v20

    if-ne v6, v7, :cond_5

    .line 824
    return-object v7

    .line 858
    :cond_5
    move-object v6, v3

    move-object v3, v8

    move-wide/from16 v36, v0

    move-object v0, v2

    move-object v2, v14

    move-object v14, v15

    move-object/from16 v1, v17

    move/from16 v17, v19

    move-object/from16 v19, v7

    move-object v15, v12

    move-object v7, v5

    move-object v12, v10

    move/from16 v10, v23

    move-object v5, v4

    move-object v4, v9

    move-wide/from16 v8, v36

    .line 860
    .end local v2    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .end local v5    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v9    # "bufferedIn":Ljava/io/BufferedInputStream;
    .end local v19    # "$i$f$forEach":I
    .end local v23    # "isFailed":Z
    .local v0, "bufferedOut":Ljava/io/BufferedOutputStream;
    .local v3, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .local v4, "bufferedIn":Ljava/io/BufferedInputStream;
    .local v7, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v8, "fileSize":J
    .local v10, "isFailed":Z
    .restart local v12    # "fileInputStream":Ljava/io/FileInputStream;
    .local v17, "$i$f$forEach":I
    :goto_4
    :try_start_15
    const-string v20, "write 2"
    :try_end_15
    .catch Ljava/lang/Exception; {:try_start_15 .. :try_end_15} :catch_22
    .catchall {:try_start_15 .. :try_end_15} :catchall_23

    move/from16 v23, v10

    .end local v10    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    :try_start_16
    filled-new-array/range {v20 .. v20}, [Ljava/lang/Object;

    move-result-object v10
    :try_end_16
    .catch Ljava/lang/Exception; {:try_start_16 .. :try_end_16} :catch_21
    .catchall {:try_start_16 .. :try_end_16} :catchall_22

    move/from16 v20, v11

    move-object/from16 v11, v21

    :try_start_17
    invoke-static {v11, v10}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_17
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_17} :catch_20
    .catchall {:try_start_17 .. :try_end_17} :catchall_21

    .line 862
    const-wide/32 v24, 0x100000

    cmp-long v10, v8, v24

    if-lez v10, :cond_6

    const/high16 v10, 0x10000

    goto :goto_5

    :cond_6
    const/16 v10, 0x2000

    .line 863
    .local v10, "bufferSize":I
    :goto_5
    move-object/from16 v21, v11

    :try_start_18
    new-array v11, v10, [B

    move-object v10, v11

    .line 864
    .local v10, "buffer":[B
    new-instance v11, Lkotlin/jvm/internal/Ref$IntRef;

    invoke-direct {v11}, Lkotlin/jvm/internal/Ref$IntRef;-><init>()V

    .line 865
    .local v11, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    move-object/from16 v24, v10

    move-object/from16 v25, v11

    .end local v10    # "buffer":[B
    .end local v11    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v24, "buffer":[B
    .local v25, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    const-wide/16 v10, 0x0

    .line 866
    .local v10, "totalSent":J
    nop

    .line 869
    .local v8, "totalSize":J
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v26

    move-wide/from16 v27, v8

    .end local v8    # "totalSize":J
    .local v27, "totalSize":J
    move-object/from16 v8, v26

    check-cast v8, Lkotlin/coroutines/CoroutineContext;

    new-instance v9, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1$1$1;

    move-object/from16 v26, v8

    const/4 v8, 0x0

    invoke-direct {v9, v15, v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1$1$1;-><init>(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    check-cast v9, Lkotlin/jvm/functions/Function2;

    iput-object v7, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    iput-object v1, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;

    iput-object v5, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;

    iput-object v6, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    iput-object v2, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;

    iput-object v13, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    iput-object v15, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;

    iput-object v14, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;

    iput-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$8:Ljava/lang/Object;

    iput-object v12, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$9:Ljava/lang/Object;

    iput-object v4, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$10:Ljava/lang/Object;

    move-object/from16 v8, v24

    .end local v24    # "buffer":[B
    .local v8, "buffer":[B
    iput-object v8, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$11:Ljava/lang/Object;

    move-object/from16 v24, v0

    move-object/from16 v0, v25

    .end local v25    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v0, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v24, "bufferedOut":Ljava/io/BufferedOutputStream;
    iput-object v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$12:Ljava/lang/Object;
    :try_end_18
    .catch Ljava/lang/Exception; {:try_start_18 .. :try_end_18} :catch_1f
    .catchall {:try_start_18 .. :try_end_18} :catchall_20

    move-object/from16 v25, v1

    move/from16 v1, v20

    :try_start_19
    iput v1, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I
    :try_end_19
    .catch Ljava/lang/Exception; {:try_start_19 .. :try_end_19} :catch_1e
    .catchall {:try_start_19 .. :try_end_19} :catchall_1f

    move/from16 v20, v1

    move/from16 v1, v23

    .end local v23    # "isFailed":Z
    .restart local v1    # "isFailed":Z
    :try_start_1a
    iput v1, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$1:I

    iput-wide v10, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$0:J
    :try_end_1a
    .catch Ljava/lang/Exception; {:try_start_1a .. :try_end_1a} :catch_1d
    .catchall {:try_start_1a .. :try_end_1a} :catchall_1e

    move-object/from16 v23, v0

    move/from16 v29, v1

    move-wide/from16 v0, v27

    .end local v1    # "isFailed":Z
    .end local v27    # "totalSize":J
    .local v0, "totalSize":J
    .local v23, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v29, "isFailed":Z
    :try_start_1b
    iput-wide v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$1:J

    move-wide/from16 v27, v0

    .end local v0    # "totalSize":J
    .restart local v27    # "totalSize":J
    const/4 v0, 0x2

    iput v0, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->label:I

    move-object/from16 v0, v26

    invoke-static {v0, v9, v3}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_1b
    .catch Ljava/lang/Exception; {:try_start_1b .. :try_end_1b} :catch_1c
    .catchall {:try_start_1b .. :try_end_1b} :catchall_1d

    move-object/from16 v1, v19

    if-ne v0, v1, :cond_7

    .line 824
    return-object v1

    .line 869
    :cond_7
    move/from16 v9, v20

    move-object/from16 v0, v24

    move-object/from16 v26, v25

    move-object/from16 v24, v6

    move-object/from16 v20, v7

    move-object v6, v8

    move/from16 v7, v18

    move/from16 v8, v29

    move-object/from16 v18, v5

    move/from16 v5, v17

    move-object/from16 v17, v4

    move-object/from16 v4, p1

    move-wide/from16 v36, v10

    move-object v10, v12

    move-wide/from16 v11, v36

    .line 872
    .end local v12    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v24    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .end local v29    # "isFailed":Z
    .end local p1    # "$result":Ljava/lang/Object;
    .local v0, "bufferedOut":Ljava/io/BufferedOutputStream;
    .local v4, "$result":Ljava/lang/Object;
    .local v5, "$i$f$forEach":I
    .local v6, "buffer":[B
    .local v7, "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .local v8, "isFailed":Z
    .local v10, "fileInputStream":Ljava/io/FileInputStream;
    .local v11, "totalSent":J
    .local v17, "bufferedIn":Ljava/io/BufferedInputStream;
    .local v20, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_6
    :try_start_1c
    const-string v19, "write 3"

    move-object/from16 p1, v0

    .end local v0    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .local p1, "bufferedOut":Ljava/io/BufferedOutputStream;
    filled-new-array/range {v19 .. v19}, [Ljava/lang/Object;

    move-result-object v0
    :try_end_1c
    .catch Ljava/lang/Exception; {:try_start_1c .. :try_end_1c} :catch_1b
    .catchall {:try_start_1c .. :try_end_1c} :catchall_1c

    move-object/from16 v19, v1

    move-object/from16 v1, v21

    :try_start_1d
    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1d
    .catch Ljava/lang/Exception; {:try_start_1d .. :try_end_1d} :catch_1a
    .catchall {:try_start_1d .. :try_end_1d} :catchall_1b

    move-object/from16 v0, v17

    move-object/from16 v21, v19

    move-object/from16 v25, v20

    move/from16 v19, v5

    move/from16 v20, v7

    move-object/from16 v5, v24

    move-object/from16 v7, v26

    move-object/from16 v24, v14

    move-object v14, v15

    move-object v15, v13

    move-object v13, v10

    move-object/from16 v10, v18

    move-wide/from16 v17, v11

    move-wide/from16 v11, v27

    move-object/from16 v36, v3

    move-object/from16 v3, p1

    move-object/from16 p1, v4

    move-object v4, v2

    move-object/from16 v2, v23

    move/from16 v23, v8

    move-object/from16 v8, v36

    .line 874
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$forEach":I
    .end local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v10    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v27    # "totalSize":J
    .local v0, "bufferedIn":Ljava/io/BufferedInputStream;
    .local v2, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v3, "bufferedOut":Ljava/io/BufferedOutputStream;
    .local v8, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .local v11, "totalSize":J
    .local v13, "fileInputStream":Ljava/io/FileInputStream;
    .local v17, "totalSent":J
    .restart local v19    # "$i$f$forEach":I
    .local v20, "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .local v23, "isFailed":Z
    .local v25, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local p1, "$result":Ljava/lang/Object;
    :goto_7
    move-object/from16 v26, v5

    :try_start_1e
    invoke-virtual {v0, v6}, Ljava/io/BufferedInputStream;->read([B)I

    move-result v5

    move/from16 v27, v5

    .line 1584
    .local v27, "it":I
    const/16 v28, 0x0

    .line 874
    .local v28, "$i$a$-also-ClassicBluetoothService$sendFileBroadcast$1$1$2":I
    move-object/from16 v29, v0

    move/from16 v0, v27

    .end local v27    # "it":I
    .local v0, "it":I
    .local v29, "bufferedIn":Ljava/io/BufferedInputStream;
    iput v0, v2, Lkotlin/jvm/internal/Ref$IntRef;->element:I
    :try_end_1e
    .catch Ljava/lang/Exception; {:try_start_1e .. :try_end_1e} :catch_19
    .catchall {:try_start_1e .. :try_end_1e} :catchall_1a

    .end local v0    # "it":I
    .end local v28    # "$i$a$-also-ClassicBluetoothService$sendFileBroadcast$1$1$2":I
    const/4 v0, -0x1

    if-eq v5, v0, :cond_d

    .line 876
    :try_start_1f
    invoke-static/range {v25 .. v25}, Lkotlinx/coroutines/CoroutineScopeKt;->isActive(Lkotlinx/coroutines/CoroutineScope;)Z

    move-result v0
    :try_end_1f
    .catch Ljava/lang/Exception; {:try_start_1f .. :try_end_1f} :catch_11
    .catchall {:try_start_1f .. :try_end_1f} :catchall_12

    if-nez v0, :cond_9

    .line 877
    .end local v3    # "bufferedOut":Ljava/io/BufferedOutputStream;
    :try_start_20
    const-string v0, "\u53d1\u9001\u88ab\u53d6\u6d88"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 878
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_20
    .catch Ljava/lang/Exception; {:try_start_20 .. :try_end_20} :catch_7
    .catchall {:try_start_20 .. :try_end_20} :catchall_8

    .line 916
    .end local v2    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v6    # "buffer":[B
    .end local v11    # "totalSize":J
    .end local v17    # "totalSent":J
    .end local v29    # "bufferedIn":Ljava/io/BufferedInputStream;
    nop

    .end local v13    # "fileInputStream":Ljava/io/FileInputStream;
    if-eqz v13, :cond_8

    :try_start_21
    invoke-virtual {v13}, Ljava/io/FileInputStream;->close()V

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_21
    .catch Ljava/io/IOException; {:try_start_21 .. :try_end_21} :catch_6
    .catchall {:try_start_21 .. :try_end_21} :catchall_7

    goto :goto_8

    .line 931
    .end local v23    # "isFailed":Z
    .end local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_7
    move-exception v0

    move-object/from16 v9, p1

    move/from16 v10, v19

    move/from16 v11, v20

    goto/16 :goto_2e

    .line 920
    .restart local v23    # "isFailed":Z
    .restart local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catch_6
    move-exception v0

    move-object v6, v0

    move-object/from16 v28, v1

    move v0, v9

    move-object v3, v10

    move-object v13, v14

    move-object v14, v15

    move/from16 v10, v19

    move/from16 v11, v20

    move-object/from16 v1, v21

    move/from16 v2, v23

    move-object/from16 v12, v24

    move-object/from16 v5, v25

    move-object/from16 v9, p1

    move-object v15, v4

    move-object/from16 v4, v26

    goto/16 :goto_2a

    .line 931
    :cond_8
    :goto_8
    const/4 v1, 0x0

    .end local v23    # "isFailed":Z
    .end local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    invoke-static {v7, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlinx/coroutines/Job;)V

    .line 878
    return-object v0

    .line 916
    .restart local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v23    # "isFailed":Z
    .restart local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_8
    move-exception v0

    move-object/from16 v28, v1

    :goto_9
    move-object v3, v8

    move v11, v9

    move-object v12, v14

    move/from16 v18, v20

    move-object/from16 v1, v21

    move/from16 v8, v23

    move-object/from16 v20, v25

    move-object/from16 v32, v26

    move-object/from16 v9, p1

    move-object v14, v4

    move-object v4, v10

    move-object v10, v13

    move-object v13, v15

    move-object/from16 v15, v24

    goto/16 :goto_28

    .line 907
    :catch_7
    move-exception v0

    move-object/from16 v28, v1

    move-object v6, v7

    move-object v3, v8

    move-object v2, v10

    move-object v10, v13

    move-object v12, v14

    move-object v13, v15

    move/from16 v5, v19

    move/from16 v18, v20

    move-object/from16 v7, v21

    move/from16 v8, v23

    move-object/from16 v11, v24

    move-object/from16 v1, v25

    move-object/from16 v15, v26

    move-object v14, v4

    move-object/from16 v4, p1

    goto/16 :goto_23

    .line 881
    .restart local v2    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v3    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .restart local v6    # "buffer":[B
    .restart local v11    # "totalSize":J
    .restart local v17    # "totalSent":J
    .restart local v29    # "bufferedIn":Ljava/io/BufferedInputStream;
    :cond_9
    :try_start_22
    iget v0, v2, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    const/4 v5, 0x0

    invoke-virtual {v3, v6, v5, v0}, Ljava/io/BufferedOutputStream;->write([BII)V

    .line 882
    iget v0, v2, Lkotlin/jvm/internal/Ref$IntRef;->element:I
    :try_end_22
    .catch Ljava/lang/Exception; {:try_start_22 .. :try_end_22} :catch_11
    .catchall {:try_start_22 .. :try_end_22} :catchall_12

    move-object/from16 v16, v6

    .end local v6    # "buffer":[B
    .local v16, "buffer":[B
    int-to-long v5, v0

    add-long v5, v17, v5

    .line 885
    .end local v17    # "totalSent":J
    .local v5, "totalSent":J
    long-to-float v0, v5

    move-object/from16 v28, v1

    long-to-float v1, v11

    div-float/2addr v0, v1

    const/16 v1, 0x64

    int-to-float v1, v1

    mul-float/2addr v0, v1

    .line 886
    .local v0, "progress":F
    mul-float/2addr v1, v0

    :try_start_23
    invoke-static {v1}, Lkotlin/math/MathKt;->roundToInt(F)I

    move-result v1

    int-to-float v1, v1

    const/high16 v17, 0x42c80000    # 100.0f

    div-float v0, v1, v17

    .line 887
    .local v0, "roundedProgress":F
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v30

    move-wide/from16 v32, v30

    .line 888
    .local v32, "currentTime":J
    move-wide/from16 v30, v11

    .end local v11    # "totalSize":J
    .local v30, "totalSize":J
    iget-wide v11, v4, Lkotlin/jvm/internal/Ref$LongRef;->element:J
    :try_end_23
    .catch Ljava/lang/Exception; {:try_start_23 .. :try_end_23} :catch_10
    .catchall {:try_start_23 .. :try_end_23} :catchall_11

    move-wide/from16 v34, v5

    move-wide/from16 v5, v32

    .end local v32    # "currentTime":J
    .local v5, "currentTime":J
    .local v34, "totalSent":J
    sub-long v32, v5, v11

    int-to-long v11, v9

    cmp-long v1, v32, v11

    if-gez v1, :cond_b

    .line 889
    cmpl-float v1, v0, v17

    if-gez v1, :cond_b

    .line 890
    :try_start_24
    iget v1, v15, Lkotlin/jvm/internal/Ref$FloatRef;->element:F
    :try_end_24
    .catch Ljava/lang/Exception; {:try_start_24 .. :try_end_24} :catch_8
    .catchall {:try_start_24 .. :try_end_24} :catchall_9

    sub-float v1, v0, v1

    const/high16 v11, 0x3f800000    # 1.0f

    cmpl-float v1, v1, v11

    if-ltz v1, :cond_a

    goto :goto_a

    :cond_a
    move-object/from16 v6, v16

    move-object/from16 v5, v26

    move-object/from16 v1, v28

    move-object/from16 v0, v29

    move-wide/from16 v11, v30

    move-wide/from16 v17, v34

    goto/16 :goto_7

    .line 916
    .end local v0    # "roundedProgress":F
    .end local v2    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v3    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .end local v5    # "currentTime":J
    .end local v16    # "buffer":[B
    .end local v29    # "bufferedIn":Ljava/io/BufferedInputStream;
    .end local v30    # "totalSize":J
    .end local v34    # "totalSent":J
    :catchall_9
    move-exception v0

    goto/16 :goto_9

    .line 907
    :catch_8
    move-exception v0

    move-object v6, v7

    move-object v3, v8

    move-object v2, v10

    move-object v10, v13

    move-object v12, v14

    move-object v13, v15

    move/from16 v5, v19

    move/from16 v18, v20

    move-object/from16 v7, v21

    move/from16 v8, v23

    move-object/from16 v11, v24

    move-object/from16 v1, v25

    move-object/from16 v15, v26

    move-object v14, v4

    move-object/from16 v4, p1

    goto/16 :goto_23

    .line 893
    .restart local v0    # "roundedProgress":F
    .restart local v2    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v3    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .restart local v5    # "currentTime":J
    .restart local v16    # "buffer":[B
    .restart local v29    # "bufferedIn":Ljava/io/BufferedInputStream;
    .restart local v30    # "totalSize":J
    .restart local v34    # "totalSent":J
    :cond_b
    :goto_a
    :try_start_25
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v1

    check-cast v1, Lkotlin/coroutines/CoroutineContext;

    new-instance v11, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1$1$3;

    const/4 v12, 0x0

    invoke-direct {v11, v14, v0, v12}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1$1$3;-><init>(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;FLkotlin/coroutines/Continuation;)V

    check-cast v11, Lkotlin/jvm/functions/Function2;
    :try_end_25
    .catch Ljava/lang/Exception; {:try_start_25 .. :try_end_25} :catch_10
    .catchall {:try_start_25 .. :try_end_25} :catchall_11

    move-object/from16 v12, v25

    .end local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v12, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_26
    iput-object v12, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    iput-object v7, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;

    iput-object v10, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;
    :try_end_26
    .catch Ljava/lang/Exception; {:try_start_26 .. :try_end_26} :catch_f
    .catchall {:try_start_26 .. :try_end_26} :catchall_10

    move-object/from16 v25, v10

    move-object/from16 v10, v26

    :try_start_27
    iput-object v10, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    iput-object v4, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;

    iput-object v15, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    iput-object v14, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;
    :try_end_27
    .catch Ljava/lang/Exception; {:try_start_27 .. :try_end_27} :catch_e
    .catchall {:try_start_27 .. :try_end_27} :catchall_f

    move-object/from16 v26, v15

    move-object/from16 v15, v24

    :try_start_28
    iput-object v15, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;

    iput-object v3, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$8:Ljava/lang/Object;

    iput-object v13, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$9:Ljava/lang/Object;
    :try_end_28
    .catch Ljava/lang/Exception; {:try_start_28 .. :try_end_28} :catch_d
    .catchall {:try_start_28 .. :try_end_28} :catchall_e

    move-object/from16 v24, v13

    move-object/from16 v13, v29

    .end local v29    # "bufferedIn":Ljava/io/BufferedInputStream;
    .local v13, "bufferedIn":Ljava/io/BufferedInputStream;
    .local v24, "fileInputStream":Ljava/io/FileInputStream;
    :try_start_29
    iput-object v13, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$10:Ljava/lang/Object;

    move-object/from16 v29, v13

    move-object/from16 v13, v16

    .end local v16    # "buffer":[B
    .local v13, "buffer":[B
    .restart local v29    # "bufferedIn":Ljava/io/BufferedInputStream;
    iput-object v13, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$11:Ljava/lang/Object;

    iput-object v2, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$12:Ljava/lang/Object;

    iput v9, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I
    :try_end_29
    .catch Ljava/lang/Exception; {:try_start_29 .. :try_end_29} :catch_c
    .catchall {:try_start_29 .. :try_end_29} :catchall_d

    move-object/from16 v16, v2

    move/from16 v2, v23

    .end local v23    # "isFailed":Z
    .local v2, "isFailed":Z
    .local v16, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :try_start_2a
    iput v2, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$1:I
    :try_end_2a
    .catch Ljava/lang/Exception; {:try_start_2a .. :try_end_2a} :catch_b
    .catchall {:try_start_2a .. :try_end_2a} :catchall_c

    move/from16 v23, v9

    move-object/from16 v32, v10

    move-wide/from16 v9, v34

    .end local v34    # "totalSent":J
    .local v9, "totalSent":J
    :try_start_2b
    iput-wide v9, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$0:J

    move-wide/from16 v34, v9

    move-wide/from16 v9, v30

    .end local v30    # "totalSize":J
    .local v9, "totalSize":J
    .restart local v34    # "totalSent":J
    iput-wide v9, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$1:J

    iput v0, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->F$0:F

    iput-wide v5, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->J$2:J

    move/from16 v17, v0

    .end local v0    # "roundedProgress":F
    .local v17, "roundedProgress":F
    const/4 v0, 0x3

    iput v0, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->label:I

    invoke-static {v1, v11, v8}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_2b
    .catch Ljava/lang/Exception; {:try_start_2b .. :try_end_2b} :catch_a
    .catchall {:try_start_2b .. :try_end_2b} :catchall_b

    move-object/from16 v1, v21

    if-ne v0, v1, :cond_c

    .line 824
    return-object v1

    .line 893
    :cond_c
    move-object/from16 v21, v1

    move-object v1, v4

    move-object/from16 v30, v12

    move/from16 v0, v17

    move-wide/from16 v17, v34

    move-object/from16 v4, p1

    move-wide v11, v9

    move-object/from16 p1, v16

    move-object v10, v8

    move-wide v8, v5

    move-object v6, v13

    move-object/from16 v13, v24

    move-object/from16 v5, v32

    move-object/from16 v24, v15

    move/from16 v15, v23

    move/from16 v23, v2

    move-object/from16 v2, v26

    .line 896
    .end local v2    # "isFailed":Z
    .end local v5    # "currentTime":J
    .end local v9    # "totalSize":J
    .end local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v16    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v24    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v34    # "totalSent":J
    .restart local v0    # "roundedProgress":F
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v6    # "buffer":[B
    .local v8, "currentTime":J
    .local v10, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .restart local v11    # "totalSize":J
    .local v13, "fileInputStream":Ljava/io/FileInputStream;
    .local v17, "totalSent":J
    .restart local v23    # "isFailed":Z
    .local v30, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local p1, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :goto_b
    :try_start_2c
    iput-wide v8, v1, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 897
    iput v0, v2, Lkotlin/jvm/internal/Ref$FloatRef;->element:F
    :try_end_2c
    .catch Ljava/lang/Exception; {:try_start_2c .. :try_end_2c} :catch_9
    .catchall {:try_start_2c .. :try_end_2c} :catchall_a

    move-object v8, v10

    move v9, v15

    move-object/from16 v10, v25

    move-object/from16 v0, v29

    move-object/from16 v25, v30

    move-object v15, v2

    move-object/from16 v2, p1

    move-object/from16 p1, v4

    move-object v4, v1

    move-object/from16 v1, v28

    .end local v0    # "roundedProgress":F
    .end local v8    # "currentTime":J
    goto/16 :goto_7

    .line 916
    .end local v3    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .end local v6    # "buffer":[B
    .end local v11    # "totalSize":J
    .end local v17    # "totalSent":J
    .end local v29    # "bufferedIn":Ljava/io/BufferedInputStream;
    .end local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :catchall_a
    move-exception v0

    move-object v9, v4

    move-object/from16 v32, v5

    move-object v3, v10

    move-object v10, v13

    move-object v12, v14

    move v11, v15

    move/from16 v18, v20

    move/from16 v8, v23

    move-object/from16 v15, v24

    move-object/from16 v4, v25

    move-object/from16 v20, v30

    move-object v14, v1

    move-object v13, v2

    move-object/from16 v1, v21

    goto/16 :goto_28

    .line 907
    :catch_9
    move-exception v0

    move-object v6, v7

    move-object v3, v10

    move-object v10, v13

    move-object v12, v14

    move v9, v15

    move/from16 v18, v20

    move-object/from16 v7, v21

    move/from16 v8, v23

    move-object/from16 v11, v24

    move-object v14, v1

    move-object v13, v2

    move-object v15, v5

    move/from16 v5, v19

    move-object/from16 v2, v25

    move-object/from16 v1, v30

    goto/16 :goto_23

    .line 916
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v10    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v23    # "isFailed":Z
    .end local v30    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v2    # "isFailed":Z
    .local v8, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .restart local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v24    # "fileInputStream":Ljava/io/FileInputStream;
    .local p1, "$result":Ljava/lang/Object;
    :catchall_b
    move-exception v0

    goto :goto_c

    .line 907
    :catch_a
    move-exception v0

    move-object/from16 v1, v21

    move-object v6, v7

    move-object v3, v8

    move-object v11, v15

    move/from16 v5, v19

    move/from16 v18, v20

    move/from16 v9, v23

    move-object/from16 v10, v24

    move-object/from16 v13, v26

    move-object/from16 v15, v32

    move-object v7, v1

    move v8, v2

    move-object v1, v12

    move-object v12, v14

    move-object/from16 v2, v25

    move-object v14, v4

    move-object/from16 v4, p1

    goto/16 :goto_23

    .line 916
    :catchall_c
    move-exception v0

    move/from16 v23, v9

    move-object/from16 v32, v10

    :goto_c
    move-object/from16 v1, v21

    move-object/from16 v9, p1

    move-object v3, v8

    move/from16 v18, v20

    move/from16 v11, v23

    move-object/from16 v10, v24

    move-object/from16 v13, v26

    move v8, v2

    move-object/from16 v20, v12

    move-object v12, v14

    move-object v14, v4

    move-object/from16 v4, v25

    goto/16 :goto_28

    .line 907
    :catch_b
    move-exception v0

    move/from16 v23, v9

    move-object/from16 v32, v10

    move-object/from16 v1, v21

    move-object v6, v7

    move-object v3, v8

    move-object v11, v15

    move/from16 v5, v19

    move/from16 v18, v20

    move-object/from16 v10, v24

    move-object/from16 v13, v26

    move-object/from16 v15, v32

    move-object v7, v1

    move v8, v2

    move-object v1, v12

    move-object v12, v14

    move-object/from16 v2, v25

    move-object v14, v4

    move-object/from16 v4, p1

    goto/16 :goto_23

    .line 916
    .end local v2    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    :catchall_d
    move-exception v0

    move-object/from16 v32, v10

    move-object/from16 v1, v21

    move/from16 v2, v23

    move/from16 v23, v9

    move-object/from16 v9, p1

    move-object v3, v8

    move/from16 v18, v20

    move/from16 v11, v23

    move-object/from16 v10, v24

    move-object/from16 v13, v26

    move v8, v2

    move-object/from16 v20, v12

    move-object v12, v14

    move-object v14, v4

    move-object/from16 v4, v25

    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    goto/16 :goto_28

    .line 907
    .end local v2    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    :catch_c
    move-exception v0

    move-object/from16 v32, v10

    move-object/from16 v1, v21

    move/from16 v2, v23

    move/from16 v23, v9

    move-object v6, v7

    move-object v3, v8

    move-object v11, v15

    move/from16 v5, v19

    move/from16 v18, v20

    move-object/from16 v10, v24

    move-object/from16 v13, v26

    move-object/from16 v15, v32

    move-object v7, v1

    move v8, v2

    move-object v1, v12

    move-object v12, v14

    move-object/from16 v2, v25

    move-object v14, v4

    move-object/from16 v4, p1

    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    goto/16 :goto_23

    .line 916
    .end local v2    # "isFailed":Z
    .end local v24    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v23    # "isFailed":Z
    :catchall_e
    move-exception v0

    move-object/from16 v32, v10

    move-object/from16 v24, v13

    move-object/from16 v1, v21

    move/from16 v2, v23

    move/from16 v23, v9

    goto :goto_e

    .line 907
    :catch_d
    move-exception v0

    move-object/from16 v32, v10

    move-object/from16 v24, v13

    move-object/from16 v1, v21

    move/from16 v2, v23

    move/from16 v23, v9

    goto/16 :goto_10

    .line 916
    :catchall_f
    move-exception v0

    move-object/from16 v32, v10

    move-object/from16 v26, v15

    move-object/from16 v1, v21

    move/from16 v2, v23

    move-object/from16 v15, v24

    move/from16 v23, v9

    goto :goto_d

    .line 907
    :catch_e
    move-exception v0

    move-object/from16 v32, v10

    move-object/from16 v26, v15

    move-object/from16 v1, v21

    move/from16 v2, v23

    move-object/from16 v15, v24

    move/from16 v23, v9

    goto :goto_f

    .line 916
    :catchall_10
    move-exception v0

    move-object/from16 v25, v10

    move-object/from16 v1, v21

    move/from16 v2, v23

    move-object/from16 v32, v26

    move/from16 v23, v9

    move-object/from16 v26, v15

    move-object/from16 v15, v24

    :goto_d
    move-object/from16 v24, v13

    :goto_e
    move-object/from16 v9, p1

    move-object v3, v8

    move/from16 v18, v20

    move/from16 v11, v23

    move-object/from16 v10, v24

    move-object/from16 v13, v26

    move v8, v2

    move-object/from16 v20, v12

    move-object v12, v14

    move-object v14, v4

    move-object/from16 v4, v25

    .end local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    .restart local v24    # "fileInputStream":Ljava/io/FileInputStream;
    goto/16 :goto_28

    .line 907
    .end local v2    # "isFailed":Z
    .end local v24    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v23    # "isFailed":Z
    :catch_f
    move-exception v0

    move-object/from16 v25, v10

    move-object/from16 v1, v21

    move/from16 v2, v23

    move-object/from16 v32, v26

    move/from16 v23, v9

    move-object/from16 v26, v15

    move-object/from16 v15, v24

    :goto_f
    move-object/from16 v24, v13

    :goto_10
    move-object v6, v7

    move-object v3, v8

    move-object v11, v15

    move/from16 v5, v19

    move/from16 v18, v20

    move-object/from16 v10, v24

    move-object/from16 v13, v26

    move-object/from16 v15, v32

    move-object v7, v1

    move v8, v2

    move-object v1, v12

    move-object v12, v14

    move-object/from16 v2, v25

    move-object v14, v4

    move-object/from16 v4, p1

    .end local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    .restart local v24    # "fileInputStream":Ljava/io/FileInputStream;
    goto/16 :goto_23

    .line 916
    .end local v2    # "isFailed":Z
    .end local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v24    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v23    # "isFailed":Z
    .restart local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_11
    move-exception v0

    goto :goto_11

    .line 907
    :catch_10
    move-exception v0

    goto :goto_12

    .line 916
    :catchall_12
    move-exception v0

    move-object/from16 v28, v1

    :goto_11
    move-object/from16 v1, v21

    move/from16 v2, v23

    move-object/from16 v12, v25

    move-object/from16 v32, v26

    move/from16 v23, v9

    move-object/from16 v25, v10

    move-object/from16 v26, v15

    move-object/from16 v15, v24

    move-object/from16 v24, v13

    move-object/from16 v9, p1

    move-object v3, v8

    move/from16 v18, v20

    move/from16 v11, v23

    move-object/from16 v10, v24

    move-object/from16 v13, v26

    move v8, v2

    move-object/from16 v20, v12

    move-object v12, v14

    move-object v14, v4

    move-object/from16 v4, v25

    .end local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v23    # "isFailed":Z
    .end local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v2    # "isFailed":Z
    .restart local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v24    # "fileInputStream":Ljava/io/FileInputStream;
    goto/16 :goto_28

    .line 907
    .end local v2    # "isFailed":Z
    .end local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v24    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v23    # "isFailed":Z
    .restart local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catch_11
    move-exception v0

    move-object/from16 v28, v1

    :goto_12
    move-object/from16 v1, v21

    move/from16 v2, v23

    move-object/from16 v12, v25

    move-object/from16 v32, v26

    move/from16 v23, v9

    move-object/from16 v25, v10

    move-object/from16 v26, v15

    move-object/from16 v15, v24

    move-object/from16 v24, v13

    move-object v6, v7

    move-object v3, v8

    move-object v11, v15

    move/from16 v5, v19

    move/from16 v18, v20

    move-object/from16 v10, v24

    move-object/from16 v13, v26

    move-object/from16 v15, v32

    move-object v7, v1

    move v8, v2

    move-object v1, v12

    move-object v12, v14

    move-object/from16 v2, v25

    move-object v14, v4

    move-object/from16 v4, p1

    .end local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v23    # "isFailed":Z
    .end local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v2    # "isFailed":Z
    .restart local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v24    # "fileInputStream":Ljava/io/FileInputStream;
    goto/16 :goto_23

    .line 874
    .end local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v24    # "fileInputStream":Ljava/io/FileInputStream;
    .local v2, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v3    # "bufferedOut":Ljava/io/BufferedOutputStream;
    .restart local v6    # "buffer":[B
    .restart local v11    # "totalSize":J
    .restart local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v17    # "totalSent":J
    .restart local v23    # "isFailed":Z
    .restart local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v29    # "bufferedIn":Ljava/io/BufferedInputStream;
    :cond_d
    move-object/from16 v28, v1

    move-object/from16 v16, v2

    move-object/from16 v1, v21

    move/from16 v2, v23

    move-object/from16 v32, v26

    move/from16 v23, v9

    move-object/from16 v26, v15

    move-object/from16 v15, v24

    move-object/from16 v24, v13

    move-object v13, v6

    move-object/from16 v36, v25

    move-object/from16 v25, v10

    move-wide v9, v11

    move-object/from16 v12, v36

    .line 900
    .end local v6    # "buffer":[B
    .end local v11    # "totalSize":J
    .end local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v17    # "totalSent":J
    .end local v23    # "isFailed":Z
    .end local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v29    # "bufferedIn":Ljava/io/BufferedInputStream;
    .local v2, "isFailed":Z
    .restart local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v24    # "fileInputStream":Ljava/io/FileInputStream;
    :try_start_2d
    invoke-virtual {v3}, Ljava/io/BufferedOutputStream;->flush()V

    .line 903
    .end local v3    # "bufferedOut":Ljava/io/BufferedOutputStream;
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1$1$4;

    const/4 v5, 0x0

    invoke-direct {v3, v14, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1$1$4;-><init>(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    check-cast v3, Lkotlin/jvm/functions/Function2;

    iput-object v12, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    iput-object v7, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;
    :try_end_2d
    .catch Ljava/lang/Exception; {:try_start_2d .. :try_end_2d} :catch_18
    .catchall {:try_start_2d .. :try_end_2d} :catchall_19

    move-object/from16 v10, v25

    :try_start_2e
    iput-object v10, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;
    :try_end_2e
    .catch Ljava/lang/Exception; {:try_start_2e .. :try_end_2e} :catch_17
    .catchall {:try_start_2e .. :try_end_2e} :catchall_18

    move-object/from16 v5, v32

    :try_start_2f
    iput-object v5, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    iput-object v4, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;
    :try_end_2f
    .catch Ljava/lang/Exception; {:try_start_2f .. :try_end_2f} :catch_16
    .catchall {:try_start_2f .. :try_end_2f} :catchall_17

    move-object/from16 v13, v26

    :try_start_30
    iput-object v13, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    iput-object v14, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;

    iput-object v15, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;
    :try_end_30
    .catch Ljava/lang/Exception; {:try_start_30 .. :try_end_30} :catch_15
    .catchall {:try_start_30 .. :try_end_30} :catchall_16

    move-object/from16 v6, v24

    .end local v24    # "fileInputStream":Ljava/io/FileInputStream;
    .local v6, "fileInputStream":Ljava/io/FileInputStream;
    :try_start_31
    iput-object v6, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$8:Ljava/lang/Object;

    const/4 v9, 0x0

    iput-object v9, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$9:Ljava/lang/Object;

    iput-object v9, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$10:Ljava/lang/Object;

    iput-object v9, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$11:Ljava/lang/Object;

    iput-object v9, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$12:Ljava/lang/Object;
    :try_end_31
    .catch Ljava/lang/Exception; {:try_start_31 .. :try_end_31} :catch_14
    .catchall {:try_start_31 .. :try_end_31} :catchall_15

    move/from16 v9, v23

    :try_start_32
    iput v9, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I

    iput v2, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$1:I

    const/4 v11, 0x4

    iput v11, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->label:I

    invoke-static {v0, v3, v8}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_32
    .catch Ljava/lang/Exception; {:try_start_32 .. :try_end_32} :catch_13
    .catchall {:try_start_32 .. :try_end_32} :catchall_14

    if-ne v0, v1, :cond_e

    .line 824
    return-object v1

    .line 903
    :cond_e
    move-object v3, v8

    move-object/from16 v18, v10

    move/from16 v11, v20

    move v8, v2

    move-object v10, v6

    move v2, v9

    move-object/from16 v20, v12

    move-object v12, v14

    move-object/from16 v9, p1

    move-object v14, v4

    move-object v4, v5

    move/from16 v5, v19

    .line 916
    .end local v2    # "isFailed":Z
    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v19    # "$i$f$forEach":I
    .end local p1    # "$result":Ljava/lang/Object;
    .local v3, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .local v5, "$i$f$forEach":I
    .local v8, "isFailed":Z
    .local v9, "$result":Ljava/lang/Object;
    .local v10, "fileInputStream":Ljava/io/FileInputStream;
    .local v11, "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .local v20, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_13
    nop

    .end local v10    # "fileInputStream":Ljava/io/FileInputStream;
    if-eqz v10, :cond_f

    :try_start_33
    invoke-virtual {v10}, Ljava/io/FileInputStream;->close()V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_33
    .catch Ljava/io/IOException; {:try_start_33 .. :try_end_33} :catch_12
    .catchall {:try_start_33 .. :try_end_33} :catchall_13

    goto :goto_14

    .line 931
    .end local v8    # "isFailed":Z
    .end local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_13
    move-exception v0

    move-object v8, v3

    move v10, v5

    goto/16 :goto_2e

    .line 920
    .restart local v8    # "isFailed":Z
    .restart local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catch_12
    move-exception v0

    move-object v6, v0

    move v0, v2

    move v10, v5

    move v2, v8

    move-object/from16 v5, v20

    move-object v8, v3

    move-object/from16 v3, v18

    move-object/from16 v36, v13

    move-object v13, v12

    move-object v12, v15

    move-object v15, v14

    move-object/from16 v14, v36

    goto/16 :goto_2a

    .line 919
    :cond_f
    :goto_14
    move-object v8, v3

    move-object v3, v4

    move v10, v5

    move-object/from16 v4, v18

    move-object/from16 v5, v20

    move/from16 v18, v11

    move v11, v2

    goto/16 :goto_27

    .line 916
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v5    # "$i$f$forEach":I
    .end local v9    # "$result":Ljava/lang/Object;
    .end local v11    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .restart local v2    # "isFailed":Z
    .restart local v6    # "fileInputStream":Ljava/io/FileInputStream;
    .local v8, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .restart local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v19    # "$i$f$forEach":I
    .local v20, "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_14
    move-exception v0

    goto :goto_15

    .line 907
    :catch_13
    move-exception v0

    move-object v3, v8

    move-object v11, v15

    move/from16 v18, v20

    move v8, v2

    move-object v15, v5

    move-object v2, v10

    move/from16 v5, v19

    move-object v10, v6

    move-object v6, v7

    move-object v7, v1

    move-object v1, v12

    move-object v12, v14

    move-object v14, v4

    move-object/from16 v4, p1

    goto/16 :goto_23

    .line 916
    :catchall_15
    move-exception v0

    move/from16 v9, v23

    :goto_15
    move-object/from16 v32, v5

    move-object v3, v8

    move v11, v9

    move/from16 v18, v20

    move-object/from16 v9, p1

    move v8, v2

    move-object/from16 v20, v12

    move-object v12, v14

    move-object v14, v4

    move-object v4, v10

    move-object v10, v6

    goto/16 :goto_28

    .line 907
    :catch_14
    move-exception v0

    move/from16 v9, v23

    move-object v3, v8

    move-object v11, v15

    move/from16 v18, v20

    move v8, v2

    move-object v15, v5

    move-object v2, v10

    move/from16 v5, v19

    move-object v10, v6

    move-object v6, v7

    move-object v7, v1

    move-object v1, v12

    move-object v12, v14

    move-object v14, v4

    move-object/from16 v4, p1

    goto/16 :goto_23

    .line 916
    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v24    # "fileInputStream":Ljava/io/FileInputStream;
    :catchall_16
    move-exception v0

    move/from16 v9, v23

    move-object/from16 v6, v24

    goto :goto_16

    .line 907
    :catch_15
    move-exception v0

    move/from16 v9, v23

    move-object/from16 v6, v24

    goto :goto_1a

    .line 916
    :catchall_17
    move-exception v0

    move/from16 v9, v23

    move-object/from16 v6, v24

    move-object/from16 v13, v26

    :goto_16
    move-object/from16 v32, v5

    goto :goto_18

    .line 907
    :catch_16
    move-exception v0

    move/from16 v9, v23

    move-object/from16 v6, v24

    move-object/from16 v13, v26

    goto :goto_1a

    .line 916
    :catchall_18
    move-exception v0

    move/from16 v9, v23

    move-object/from16 v6, v24

    goto :goto_17

    .line 907
    :catch_17
    move-exception v0

    move/from16 v9, v23

    move-object/from16 v6, v24

    goto :goto_19

    .line 916
    :catchall_19
    move-exception v0

    move/from16 v9, v23

    move-object/from16 v6, v24

    move-object/from16 v10, v25

    :goto_17
    move-object/from16 v13, v26

    move-object/from16 v5, v32

    :goto_18
    move-object v3, v8

    move v11, v9

    move/from16 v18, v20

    move-object/from16 v9, p1

    move v8, v2

    move-object/from16 v20, v12

    move-object v12, v14

    move-object v14, v4

    move-object v4, v10

    move-object v10, v6

    .end local v24    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v6    # "fileInputStream":Ljava/io/FileInputStream;
    goto/16 :goto_28

    .line 907
    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v24    # "fileInputStream":Ljava/io/FileInputStream;
    :catch_18
    move-exception v0

    move/from16 v9, v23

    move-object/from16 v6, v24

    move-object/from16 v10, v25

    :goto_19
    move-object/from16 v13, v26

    move-object/from16 v5, v32

    :goto_1a
    move-object v3, v8

    move-object v11, v15

    move/from16 v18, v20

    move v8, v2

    move-object v15, v5

    move-object v2, v10

    move/from16 v5, v19

    move-object v10, v6

    move-object v6, v7

    move-object v7, v1

    move-object v1, v12

    move-object v12, v14

    move-object v14, v4

    move-object/from16 v4, p1

    .end local v24    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v6    # "fileInputStream":Ljava/io/FileInputStream;
    goto/16 :goto_23

    .line 916
    .end local v2    # "isFailed":Z
    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v23    # "isFailed":Z
    .restart local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_1a
    move-exception v0

    move-object/from16 v28, v1

    move-object v6, v13

    move-object v13, v15

    move-object/from16 v1, v21

    move/from16 v2, v23

    move-object/from16 v15, v24

    move-object/from16 v12, v25

    move-object/from16 v5, v26

    move-object/from16 v32, v5

    move-object v3, v8

    move v11, v9

    move/from16 v18, v20

    move-object/from16 v9, p1

    move v8, v2

    move-object/from16 v20, v12

    move-object v12, v14

    move-object v14, v4

    move-object v4, v10

    move-object v10, v6

    .end local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v23    # "isFailed":Z
    .end local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v2    # "isFailed":Z
    .restart local v6    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    goto/16 :goto_28

    .line 907
    .end local v2    # "isFailed":Z
    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v23    # "isFailed":Z
    .restart local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catch_19
    move-exception v0

    move-object/from16 v28, v1

    move-object v6, v13

    move-object v13, v15

    move-object/from16 v1, v21

    move/from16 v2, v23

    move-object/from16 v15, v24

    move-object/from16 v12, v25

    move-object/from16 v5, v26

    move-object v3, v8

    move-object v11, v15

    move/from16 v18, v20

    move v8, v2

    move-object v15, v5

    move-object v2, v10

    move/from16 v5, v19

    move-object v10, v6

    move-object v6, v7

    move-object v7, v1

    move-object v1, v12

    move-object v12, v14

    move-object v14, v4

    move-object/from16 v4, p1

    .end local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v23    # "isFailed":Z
    .end local v25    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v2    # "isFailed":Z
    .restart local v6    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    goto/16 :goto_23

    .line 916
    .end local v2    # "isFailed":Z
    .end local v6    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v19    # "$i$f$forEach":I
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v5    # "$i$f$forEach":I
    .restart local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .local v8, "isFailed":Z
    .restart local v10    # "fileInputStream":Ljava/io/FileInputStream;
    .local v20, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_1b
    move-exception v0

    move-object/from16 v28, v1

    const/4 v1, 0x0

    move v11, v9

    move-object v12, v15

    move-object/from16 v1, v19

    move-object/from16 v32, v24

    move-object v9, v4

    move/from16 v19, v5

    move-object v15, v14

    move-object/from16 v4, v18

    move-object v14, v2

    move/from16 v18, v7

    move-object/from16 v7, v26

    goto/16 :goto_28

    .line 907
    :catch_1a
    move-exception v0

    move-object/from16 v28, v1

    goto :goto_1b

    .line 916
    :catchall_1c
    move-exception v0

    move-object/from16 v19, v1

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move v11, v9

    move-object v12, v15

    move-object/from16 v1, v19

    move-object/from16 v32, v24

    move-object v9, v4

    move/from16 v19, v5

    move-object v15, v14

    move-object/from16 v4, v18

    move-object v14, v2

    move/from16 v18, v7

    move-object/from16 v7, v26

    goto/16 :goto_28

    .line 907
    :catch_1b
    move-exception v0

    move-object/from16 v19, v1

    move-object/from16 v28, v21

    :goto_1b
    const/4 v1, 0x0

    move-object v11, v14

    move-object v12, v15

    move-object/from16 v1, v20

    move-object/from16 v15, v24

    move-object/from16 v6, v26

    move-object v14, v2

    move-object/from16 v2, v18

    move/from16 v18, v7

    move-object/from16 v7, v19

    goto/16 :goto_23

    .line 916
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$forEach":I
    .end local v8    # "isFailed":Z
    .end local v10    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v7, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v12, "fileInputStream":Ljava/io/FileInputStream;
    .local v17, "$i$f$forEach":I
    .restart local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .local v29, "isFailed":Z
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_1d
    move-exception v0

    move-object/from16 v4, v19

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object/from16 v9, p1

    move-object v1, v4

    move-object v4, v5

    move-object/from16 v32, v6

    move-object v10, v12

    move-object v12, v15

    move/from16 v19, v17

    move/from16 v11, v20

    move/from16 v8, v29

    move-object/from16 v20, v7

    move-object v15, v14

    move-object/from16 v7, v25

    move-object v14, v2

    goto/16 :goto_28

    .line 907
    :catch_1c
    move-exception v0

    move-object/from16 v4, v19

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object v1, v7

    move-object v10, v12

    move-object v11, v14

    move-object v12, v15

    move/from16 v9, v20

    move/from16 v8, v29

    move-object v14, v2

    move-object v7, v4

    move-object v2, v5

    move-object v15, v6

    move/from16 v5, v17

    move-object/from16 v6, v25

    move-object/from16 v4, p1

    goto/16 :goto_23

    .line 916
    .end local v29    # "isFailed":Z
    .restart local v1    # "isFailed":Z
    :catchall_1e
    move-exception v0

    move/from16 v29, v1

    move-object/from16 v4, v19

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object/from16 v9, p1

    move-object v1, v4

    move-object v4, v5

    move-object/from16 v32, v6

    move-object v10, v12

    move-object v12, v15

    move/from16 v19, v17

    move/from16 v11, v20

    move/from16 v8, v29

    move-object/from16 v20, v7

    move-object v15, v14

    move-object/from16 v7, v25

    move-object v14, v2

    .end local v1    # "isFailed":Z
    .restart local v29    # "isFailed":Z
    goto/16 :goto_28

    .line 907
    .end local v29    # "isFailed":Z
    .restart local v1    # "isFailed":Z
    :catch_1d
    move-exception v0

    move/from16 v29, v1

    move-object/from16 v4, v19

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object v1, v7

    move-object v10, v12

    move-object v11, v14

    move-object v12, v15

    move/from16 v9, v20

    move/from16 v8, v29

    move-object v14, v2

    move-object v7, v4

    move-object v2, v5

    move-object v15, v6

    move/from16 v5, v17

    move-object/from16 v6, v25

    move-object/from16 v4, p1

    .end local v1    # "isFailed":Z
    .restart local v29    # "isFailed":Z
    goto/16 :goto_23

    .line 916
    .end local v29    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    :catchall_1f
    move-exception v0

    move/from16 v20, v1

    goto :goto_1c

    .line 907
    :catch_1e
    move-exception v0

    move/from16 v20, v1

    goto/16 :goto_1f

    .line 916
    :catchall_20
    move-exception v0

    move-object/from16 v25, v1

    :goto_1c
    move-object/from16 v4, v19

    move-object/from16 v28, v21

    goto :goto_1d

    .line 907
    :catch_1f
    move-exception v0

    move-object/from16 v25, v1

    goto :goto_1f

    .line 916
    :catchall_21
    move-exception v0

    move-object/from16 v25, v1

    move-object/from16 v28, v11

    move-object/from16 v4, v19

    :goto_1d
    move/from16 v29, v23

    const/4 v1, 0x0

    move-object/from16 v9, p1

    move-object v1, v4

    move-object v4, v5

    move-object/from16 v32, v6

    move-object v10, v12

    move-object v12, v15

    move/from16 v19, v17

    move/from16 v11, v20

    goto :goto_1e

    .line 907
    :catch_20
    move-exception v0

    move-object/from16 v25, v1

    move-object/from16 v28, v11

    move-object/from16 v4, v19

    goto :goto_20

    .line 916
    :catchall_22
    move-exception v0

    move-object/from16 v25, v1

    move/from16 v20, v11

    move-object/from16 v4, v19

    move-object/from16 v28, v21

    move/from16 v29, v23

    const/4 v1, 0x0

    move-object/from16 v9, p1

    move-object v1, v4

    move-object v4, v5

    move-object/from16 v32, v6

    move-object v10, v12

    move-object v12, v15

    move/from16 v19, v17

    :goto_1e
    move/from16 v8, v29

    move-object/from16 v20, v7

    move-object v15, v14

    move-object/from16 v7, v25

    move-object v14, v2

    .end local v23    # "isFailed":Z
    .restart local v29    # "isFailed":Z
    goto/16 :goto_28

    .line 907
    .end local v29    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    :catch_21
    move-exception v0

    move-object/from16 v25, v1

    move/from16 v20, v11

    :goto_1f
    move-object/from16 v4, v19

    move-object/from16 v28, v21

    :goto_20
    move/from16 v29, v23

    const/4 v1, 0x0

    move-object v1, v7

    move-object v10, v12

    move-object v11, v14

    move-object v12, v15

    move/from16 v9, v20

    move/from16 v8, v29

    move-object v14, v2

    move-object v7, v4

    move-object v2, v5

    move-object v15, v6

    move/from16 v5, v17

    move-object/from16 v6, v25

    move-object/from16 v4, p1

    .end local v23    # "isFailed":Z
    .restart local v29    # "isFailed":Z
    goto/16 :goto_23

    .line 916
    .end local v29    # "isFailed":Z
    .local v10, "isFailed":Z
    :catchall_23
    move-exception v0

    move-object/from16 v25, v1

    move/from16 v29, v10

    move/from16 v20, v11

    move-object/from16 v4, v19

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object/from16 v9, p1

    move-object v1, v4

    move-object v4, v5

    move-object/from16 v32, v6

    move-object v10, v12

    move-object v12, v15

    move/from16 v19, v17

    move/from16 v8, v29

    move-object/from16 v20, v7

    move-object v15, v14

    move-object/from16 v7, v25

    move-object v14, v2

    .end local v10    # "isFailed":Z
    .restart local v29    # "isFailed":Z
    goto/16 :goto_28

    .line 907
    .end local v29    # "isFailed":Z
    .restart local v10    # "isFailed":Z
    :catch_22
    move-exception v0

    move-object/from16 v25, v1

    move/from16 v29, v10

    move/from16 v20, v11

    move-object/from16 v4, v19

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object v1, v7

    move-object v10, v12

    move-object v11, v14

    move-object v12, v15

    move/from16 v9, v20

    move/from16 v8, v29

    move-object v14, v2

    move-object v7, v4

    move-object v2, v5

    move-object v15, v6

    move/from16 v5, v17

    move-object/from16 v6, v25

    move-object/from16 v4, p1

    .end local v10    # "isFailed":Z
    .restart local v29    # "isFailed":Z
    goto/16 :goto_23

    .line 916
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v7    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v12    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v17    # "$i$f$forEach":I
    .end local v29    # "isFailed":Z
    .local v5, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v8, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .local v10, "fileInputStream":Ljava/io/FileInputStream;
    .restart local v19    # "$i$f$forEach":I
    .restart local v23    # "isFailed":Z
    :catchall_24
    move-exception v0

    goto :goto_21

    .line 907
    :catch_23
    move-exception v0

    goto :goto_22

    .line 916
    .end local v23    # "isFailed":Z
    .restart local v1    # "isFailed":Z
    :catchall_25
    move-exception v0

    move/from16 v23, v1

    move-object/from16 v17, v7

    move-object/from16 v7, v20

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object/from16 v9, p1

    move-object/from16 v32, v3

    move-object/from16 v20, v5

    move-object v1, v7

    move-object v3, v8

    move-object/from16 v7, v17

    move/from16 v8, v23

    .end local v1    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    goto/16 :goto_28

    .line 907
    .end local v23    # "isFailed":Z
    .restart local v1    # "isFailed":Z
    :catch_24
    move-exception v0

    move/from16 v23, v1

    move-object/from16 v17, v7

    move-object/from16 v7, v20

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object v2, v4

    move-object v1, v5

    move v9, v11

    move-object v11, v15

    move-object/from16 v6, v17

    move/from16 v5, v19

    move-object/from16 v4, p1

    move-object v15, v3

    move-object v3, v8

    move/from16 v8, v23

    .end local v1    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    goto/16 :goto_23

    .line 916
    :catchall_26
    move-exception v0

    move-object/from16 v17, v7

    :goto_21
    move-object/from16 v7, v20

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object/from16 v9, p1

    move-object/from16 v32, v3

    move-object/from16 v20, v5

    move-object v1, v7

    move-object v3, v8

    move-object/from16 v7, v17

    move/from16 v8, v23

    goto/16 :goto_28

    .line 907
    :catch_25
    move-exception v0

    move-object/from16 v17, v7

    :goto_22
    move-object/from16 v7, v20

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object v2, v4

    move-object v1, v5

    move v9, v11

    move-object v11, v15

    move-object/from16 v6, v17

    move/from16 v5, v19

    move-object/from16 v4, p1

    move-object v15, v3

    move-object v3, v8

    move/from16 v8, v23

    goto/16 :goto_23

    .line 916
    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    :catchall_27
    move-exception v0

    move/from16 v23, v2

    move-object/from16 v17, v7

    move-object/from16 v7, v20

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object/from16 v9, p1

    move-object/from16 v32, v3

    move-object/from16 v20, v5

    move-object v1, v7

    move-object v3, v8

    move-object/from16 v7, v17

    move/from16 v8, v23

    .end local v2    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    goto/16 :goto_28

    .line 907
    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    :catch_26
    move-exception v0

    move/from16 v23, v2

    move-object/from16 v17, v7

    move-object/from16 v7, v20

    move-object/from16 v28, v21

    const/4 v1, 0x0

    move-object v2, v4

    move-object v1, v5

    move v9, v11

    move-object v11, v15

    move-object/from16 v6, v17

    move/from16 v5, v19

    move-object/from16 v4, p1

    move-object v15, v3

    move-object v3, v8

    move/from16 v8, v23

    .end local v2    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    goto/16 :goto_23

    .line 916
    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    :catchall_28
    move-exception v0

    move/from16 v23, v2

    move-object/from16 v28, v6

    move-object/from16 v17, v7

    move-object/from16 v7, v20

    const/4 v1, 0x0

    move-object/from16 v9, p1

    move-object/from16 v32, v3

    move-object/from16 v20, v5

    move-object v1, v7

    move-object v3, v8

    move-object/from16 v7, v17

    move/from16 v8, v23

    .end local v2    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    goto/16 :goto_28

    .line 907
    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    :catch_27
    move-exception v0

    move/from16 v23, v2

    move-object/from16 v28, v6

    move-object/from16 v17, v7

    move-object/from16 v7, v20

    const/4 v1, 0x0

    move-object v2, v4

    move-object v1, v5

    move v9, v11

    move-object v11, v15

    move-object/from16 v6, v17

    move/from16 v5, v19

    move-object/from16 v4, p1

    move-object v15, v3

    move-object v3, v8

    move/from16 v8, v23

    .end local v2    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    goto/16 :goto_23

    .line 916
    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    :catchall_29
    move-exception v0

    move/from16 v23, v2

    move-object/from16 v28, v6

    move-object/from16 v17, v7

    move-object v7, v1

    const/4 v1, 0x0

    move-object/from16 v9, p1

    move-object/from16 v32, v3

    move-object/from16 v20, v5

    move-object v1, v7

    move-object v3, v8

    move-object/from16 v7, v17

    move/from16 v8, v23

    .end local v2    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    goto/16 :goto_28

    .line 907
    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    :catch_28
    move-exception v0

    move/from16 v23, v2

    move-object/from16 v28, v6

    move-object/from16 v17, v7

    move-object v7, v1

    const/4 v1, 0x0

    move-object v2, v4

    move-object v1, v5

    move v9, v11

    move-object v11, v15

    move-object/from16 v6, v17

    move/from16 v5, v19

    move-object/from16 v4, p1

    move-object v15, v3

    move-object v3, v8

    move/from16 v8, v23

    .end local v2    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    goto :goto_23

    .line 916
    .end local v10    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    .local v9, "fileInputStream":Ljava/io/FileInputStream;
    :catchall_2a
    move-exception v0

    move/from16 v23, v2

    move-object/from16 v28, v6

    move-object/from16 v17, v7

    move-object v7, v1

    const/4 v1, 0x0

    move-object/from16 v32, v3

    move-object/from16 v20, v5

    move-object v1, v7

    move-object v3, v8

    move-object v10, v9

    move-object/from16 v7, v17

    move/from16 v8, v23

    move-object/from16 v9, p1

    .end local v2    # "isFailed":Z
    .restart local v23    # "isFailed":Z
    goto/16 :goto_28

    .line 907
    .end local v23    # "isFailed":Z
    .restart local v2    # "isFailed":Z
    :catch_29
    move-exception v0

    move/from16 v23, v2

    move-object/from16 v28, v6

    move-object/from16 v17, v7

    move-object v7, v1

    const/4 v1, 0x0

    move-object v2, v4

    move-object v1, v5

    move-object v10, v9

    move v9, v11

    move-object v11, v15

    move-object/from16 v6, v17

    move/from16 v5, v19

    move-object/from16 v4, p1

    move-object v15, v3

    move-object v3, v8

    move/from16 v8, v23

    .line 908
    .end local v2    # "isFailed":Z
    .end local v9    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v19    # "$i$f$forEach":I
    .end local p1    # "$result":Ljava/lang/Object;
    .local v0, "e":Ljava/lang/Exception;
    .local v1, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .restart local v4    # "$result":Ljava/lang/Object;
    .local v5, "$i$f$forEach":I
    .local v8, "isFailed":Z
    .restart local v10    # "fileInputStream":Ljava/io/FileInputStream;
    :goto_23
    :try_start_34
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 909
    .end local v0    # "e":Ljava/lang/Exception;
    if-nez v8, :cond_11

    .line 910
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;
    :try_end_34
    .catchall {:try_start_34 .. :try_end_34} :catchall_2e

    move-object/from16 p1, v4

    .end local v4    # "$result":Ljava/lang/Object;
    .restart local p1    # "$result":Ljava/lang/Object;
    :try_start_35
    new-instance v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1$1$5;
    :try_end_35
    .catchall {:try_start_35 .. :try_end_35} :catchall_2c

    move/from16 v17, v5

    const/4 v5, 0x0

    .end local v5    # "$i$f$forEach":I
    .restart local v17    # "$i$f$forEach":I
    :try_start_36
    invoke-direct {v4, v12, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1$1$5;-><init>(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    check-cast v4, Lkotlin/jvm/functions/Function2;

    iput-object v1, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    iput-object v6, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;

    iput-object v2, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;

    iput-object v15, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    iput-object v14, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;

    iput-object v13, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    iput-object v12, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;

    iput-object v11, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;

    iput-object v10, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$8:Ljava/lang/Object;

    const/4 v5, 0x0

    iput-object v5, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$9:Ljava/lang/Object;

    iput-object v5, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$10:Ljava/lang/Object;

    iput-object v5, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$11:Ljava/lang/Object;

    iput-object v5, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$12:Ljava/lang/Object;

    iput v9, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I

    iput v8, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$1:I

    const/4 v5, 0x5

    iput v5, v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->label:I

    invoke-static {v0, v4, v3}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_36
    .catchall {:try_start_36 .. :try_end_36} :catchall_2b

    if-ne v0, v7, :cond_10

    .line 824
    return-object v7

    .line 910
    :cond_10
    move-object/from16 v4, p1

    move-object/from16 v20, v1

    move-object/from16 v19, v6

    move-object v1, v7

    move/from16 v5, v17

    move/from16 v7, v18

    move-object/from16 v18, v2

    .line 913
    .end local v1    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v17    # "$i$f$forEach":I
    .end local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v5    # "$i$f$forEach":I
    .local v7, "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .restart local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_24
    const/4 v0, 0x1

    move v2, v0

    move-object v8, v3

    move/from16 v17, v5

    move-object v5, v11

    move-object v3, v1

    move v11, v7

    move-object/from16 v7, v19

    move-object/from16 v1, v20

    move/from16 v36, v9

    move-object v9, v4

    move/from16 v4, v36

    .end local v8    # "isFailed":Z
    .local v0, "isFailed":Z
    goto :goto_25

    .line 916
    .end local v0    # "isFailed":Z
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$forEach":I
    .end local v7    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v1    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v8    # "isFailed":Z
    .restart local v17    # "$i$f$forEach":I
    .restart local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_2b
    move-exception v0

    move-object/from16 v20, v1

    move-object v4, v2

    move-object v1, v7

    move-object/from16 v32, v15

    move/from16 v19, v17

    move-object v7, v6

    move-object v15, v11

    move v11, v9

    move-object/from16 v9, p1

    goto/16 :goto_28

    .end local v17    # "$i$f$forEach":I
    .restart local v5    # "$i$f$forEach":I
    :catchall_2c
    move-exception v0

    move/from16 v17, v5

    move-object/from16 v20, v1

    move-object v4, v2

    move-object v1, v7

    move-object/from16 v32, v15

    move/from16 v19, v17

    move-object v7, v6

    move-object v15, v11

    move v11, v9

    move-object/from16 v9, p1

    .end local v5    # "$i$f$forEach":I
    .restart local v17    # "$i$f$forEach":I
    goto/16 :goto_28

    .line 909
    .end local v17    # "$i$f$forEach":I
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v5    # "$i$f$forEach":I
    :cond_11
    move-object/from16 p1, v4

    move/from16 v17, v5

    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$forEach":I
    .restart local v17    # "$i$f$forEach":I
    .restart local p1    # "$result":Ljava/lang/Object;
    move v4, v9

    move-object v5, v11

    move/from16 v11, v18

    move-object/from16 v9, p1

    move-object/from16 v18, v2

    move v2, v8

    move-object v8, v3

    move-object v3, v7

    move-object v7, v6

    .line 916
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v2    # "isFailed":Z
    .local v8, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .local v9, "$result":Ljava/lang/Object;
    .restart local v11    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    :goto_25
    nop

    .end local v10    # "fileInputStream":Ljava/io/FileInputStream;
    if-eqz v10, :cond_12

    :try_start_37
    invoke-virtual {v10}, Ljava/io/FileInputStream;->close()V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_37
    .catch Ljava/io/IOException; {:try_start_37 .. :try_end_37} :catch_2a
    .catchall {:try_start_37 .. :try_end_37} :catchall_2d

    goto :goto_26

    .line 931
    .end local v1    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v2    # "isFailed":Z
    :catchall_2d
    move-exception v0

    move/from16 v10, v17

    goto/16 :goto_2e

    .line 920
    .restart local v1    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v2    # "isFailed":Z
    :catch_2a
    move-exception v0

    move-object v6, v0

    move v0, v4

    move-object v4, v15

    move/from16 v10, v17

    move-object v15, v14

    move-object v14, v13

    move-object v13, v12

    move-object v12, v5

    move-object v5, v1

    move-object v1, v3

    move-object/from16 v3, v18

    goto/16 :goto_2a

    .line 919
    :cond_12
    :goto_26
    move/from16 v10, v17

    move-object/from16 v36, v5

    move-object v5, v1

    move-object v1, v3

    move-object v3, v15

    move-object/from16 v15, v36

    move/from16 v37, v11

    move v11, v4

    move-object/from16 v4, v18

    move/from16 v18, v37

    .line 931
    .end local v1    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v2    # "isFailed":Z
    .end local v11    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v17    # "$i$f$forEach":I
    .local v5, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v10, "$i$f$forEach":I
    .restart local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    :goto_27
    const/4 v2, 0x0

    invoke-static {v7, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlinx/coroutines/Job;)V

    .line 932
    move-object/from16 v17, v7

    move-object v2, v9

    move-object/from16 v9, v28

    move-object v7, v1

    const/4 v1, 0x0

    goto/16 :goto_2f

    .line 916
    .end local v9    # "$result":Ljava/lang/Object;
    .restart local v1    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .restart local v4    # "$result":Ljava/lang/Object;
    .local v5, "$i$f$forEach":I
    .local v8, "isFailed":Z
    .local v10, "fileInputStream":Ljava/io/FileInputStream;
    :catchall_2e
    move-exception v0

    move-object/from16 p1, v4

    move/from16 v17, v5

    move-object/from16 v20, v1

    move-object v4, v2

    move-object v1, v7

    move-object/from16 v32, v15

    move/from16 v19, v17

    move-object v7, v6

    move-object v15, v11

    move v11, v9

    move-object/from16 v9, p1

    .end local v1    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "$i$f$forEach":I
    .end local v10    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v9    # "$result":Ljava/lang/Object;
    .restart local v19    # "$i$f$forEach":I
    .restart local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_28
    if-eqz v10, :cond_13

    :try_start_38
    invoke-virtual {v10}, Ljava/io/FileInputStream;->close()V

    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_29

    .line 931
    .end local v8    # "isFailed":Z
    .end local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_2f
    move-exception v0

    move-object v8, v3

    move/from16 v11, v18

    move/from16 v10, v19

    goto/16 :goto_2e

    .line 920
    .restart local v8    # "isFailed":Z
    .restart local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catch_2b
    move-exception v0

    move-object v6, v0

    move v2, v8

    move v0, v11

    move/from16 v11, v18

    move/from16 v10, v19

    move-object/from16 v5, v20

    move-object v8, v3

    move-object v3, v4

    move-object/from16 v4, v32

    move-object/from16 v36, v13

    move-object v13, v12

    move-object v12, v15

    move-object v15, v14

    move-object/from16 v14, v36

    goto :goto_2a

    .line 916
    .end local v3    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .end local v8    # "isFailed":Z
    .end local v9    # "$result":Ljava/lang/Object;
    .end local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v19    # "$i$f$forEach":I
    .end local v20    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :cond_13
    :goto_29
    throw v0
    :try_end_38
    .catch Ljava/io/IOException; {:try_start_38 .. :try_end_38} :catch_2b
    .catchall {:try_start_38 .. :try_end_38} :catchall_2f

    .line 931
    .local v8, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;
    .restart local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .restart local v19    # "$i$f$forEach":I
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_30
    move-exception v0

    move-object/from16 v17, v7

    move-object/from16 v9, p1

    move/from16 v11, v18

    move/from16 v10, v19

    goto/16 :goto_2e

    .line 920
    .restart local v2    # "isFailed":Z
    .local v5, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catch_2c
    move-exception v0

    move/from16 v23, v2

    move-object/from16 v28, v6

    move-object/from16 v17, v7

    move-object v7, v1

    move-object/from16 v9, p1

    move-object v6, v0

    move v0, v11

    move-object/from16 v7, v17

    move/from16 v11, v18

    move/from16 v10, v19

    move-object/from16 v36, v4

    move-object v4, v3

    move-object/from16 v3, v36

    move-object/from16 v37, v13

    move-object v13, v12

    move-object v12, v15

    move-object v15, v14

    move-object/from16 v14, v37

    .line 921
    .end local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v19    # "$i$f$forEach":I
    .end local p1    # "$result":Ljava/lang/Object;
    .local v6, "e":Ljava/io/IOException;
    .restart local v9    # "$result":Ljava/lang/Object;
    .local v10, "$i$f$forEach":I
    .restart local v11    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    :goto_2a
    :try_start_39
    invoke-virtual {v6}, Ljava/io/IOException;->printStackTrace()V
    :try_end_39
    .catchall {:try_start_39 .. :try_end_39} :catchall_33

    .line 922
    move-object/from16 p1, v9

    .end local v9    # "$result":Ljava/lang/Object;
    .restart local p1    # "$result":Ljava/lang/Object;
    :try_start_3a
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_3a
    .catchall {:try_start_3a .. :try_end_3a} :catchall_32

    move/from16 v17, v10

    .end local v10    # "$i$f$forEach":I
    .restart local v17    # "$i$f$forEach":I
    :try_start_3b
    const-string v10, "Send File failed  errMessag = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v6}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ", isFailed = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    if-eqz v2, :cond_14

    const/4 v10, 0x1

    goto :goto_2b

    .end local v6    # "e":Ljava/io/IOException;
    :cond_14
    const/4 v10, 0x0

    :goto_2b
    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    move-object/from16 v9, v28

    invoke-static {v9, v6}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 923
    if-nez v2, :cond_16

    .line 924
    .end local v2    # "isFailed":Z
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v2

    check-cast v2, Lkotlin/coroutines/CoroutineContext;

    new-instance v6, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1$1$6;

    const/4 v10, 0x0

    invoke-direct {v6, v13, v10}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1$1$6;-><init>(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/jvm/functions/Function2;

    iput-object v5, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$0:Ljava/lang/Object;

    iput-object v7, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$1:Ljava/lang/Object;

    iput-object v3, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$2:Ljava/lang/Object;

    iput-object v4, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$3:Ljava/lang/Object;

    iput-object v15, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$4:Ljava/lang/Object;

    iput-object v14, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$5:Ljava/lang/Object;

    iput-object v13, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$6:Ljava/lang/Object;

    iput-object v12, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$7:Ljava/lang/Object;

    const/4 v10, 0x0

    iput-object v10, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$8:Ljava/lang/Object;

    iput-object v10, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$9:Ljava/lang/Object;

    iput-object v10, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$10:Ljava/lang/Object;

    iput-object v10, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$11:Ljava/lang/Object;

    iput-object v10, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->L$12:Ljava/lang/Object;

    iput v0, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->I$0:I

    const/4 v10, 0x6

    iput v10, v8, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;->label:I

    invoke-static {v2, v6, v8}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2
    :try_end_3b
    .catchall {:try_start_3b .. :try_end_3b} :catchall_31

    if-ne v2, v1, :cond_15

    .line 824
    return-object v1

    .line 924
    :cond_15
    move-object/from16 v2, p1

    move/from16 v10, v17

    .line 927
    .end local v17    # "$i$f$forEach":I
    .end local p1    # "$result":Ljava/lang/Object;
    .local v2, "$result":Ljava/lang/Object;
    .restart local v10    # "$i$f$forEach":I
    :goto_2c
    move/from16 v18, v11

    move v11, v0

    move-object/from16 v36, v4

    move-object v4, v3

    move-object/from16 v3, v36

    move-object/from16 v37, v15

    move-object v15, v12

    move-object v12, v13

    move-object v13, v14

    move-object/from16 v14, v37

    goto :goto_2d

    .line 923
    .end local v10    # "$i$f$forEach":I
    .local v2, "isFailed":Z
    .restart local v17    # "$i$f$forEach":I
    .restart local p1    # "$result":Ljava/lang/Object;
    :cond_16
    move-object/from16 v2, p1

    move/from16 v18, v11

    move/from16 v10, v17

    move v11, v0

    move-object/from16 v36, v4

    move-object v4, v3

    move-object/from16 v3, v36

    move-object/from16 v37, v15

    move-object v15, v12

    move-object v12, v13

    move-object v13, v14

    move-object/from16 v14, v37

    .line 931
    .end local v11    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .end local v17    # "$i$f$forEach":I
    .end local p1    # "$result":Ljava/lang/Object;
    .local v2, "$result":Ljava/lang/Object;
    .restart local v10    # "$i$f$forEach":I
    .restart local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    :goto_2d
    const/4 v6, 0x0

    invoke-static {v7, v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlinx/coroutines/Job;)V

    .line 932
    move-object/from16 v17, v7

    move-object v7, v1

    const/4 v1, 0x0

    goto :goto_2f

    .line 931
    .end local v2    # "$result":Ljava/lang/Object;
    .end local v5    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v10    # "$i$f$forEach":I
    .end local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .restart local v11    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .restart local v17    # "$i$f$forEach":I
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_31
    move-exception v0

    move-object/from16 v9, p1

    move/from16 v10, v17

    goto :goto_2e

    .end local v17    # "$i$f$forEach":I
    .restart local v10    # "$i$f$forEach":I
    :catchall_32
    move-exception v0

    move/from16 v17, v10

    move-object/from16 v9, p1

    .end local v10    # "$i$f$forEach":I
    .restart local v17    # "$i$f$forEach":I
    goto :goto_2e

    .end local v17    # "$i$f$forEach":I
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v9    # "$result":Ljava/lang/Object;
    .restart local v10    # "$i$f$forEach":I
    :catchall_33
    move-exception v0

    move-object/from16 p1, v9

    move/from16 v17, v10

    :goto_2e
    const/4 v1, 0x0

    invoke-static {v7, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlinx/coroutines/Job;)V

    throw v0

    .line 830
    .end local v9    # "$result":Ljava/lang/Object;
    .end local v10    # "$i$f$forEach":I
    .end local v11    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .local v0, "socket":Landroid/bluetooth/BluetoothSocket;
    .restart local v5    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    .restart local v19    # "$i$f$forEach":I
    .restart local p1    # "$result":Ljava/lang/Object;
    :cond_17
    move-object v9, v6

    move-object/from16 v17, v7

    move-object v7, v1

    const/4 v1, 0x0

    .line 935
    .end local v0    # "socket":Landroid/bluetooth/BluetoothSocket;
    move-object/from16 v2, p1

    move/from16 v10, v19

    .end local v19    # "$i$f$forEach":I
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v2    # "$result":Ljava/lang/Object;
    .restart local v10    # "$i$f$forEach":I
    :goto_2f
    nop

    .line 1583
    .end local v18    # "$i$a$-forEach-ClassicBluetoothService$sendFileBroadcast$1$1":I
    :goto_30
    move-object v1, v7

    move-object v6, v9

    move-object/from16 v7, v17

    move-object v9, v2

    move-object/from16 v2, p0

    goto/16 :goto_0

    .line 1585
    .end local v2    # "$result":Ljava/lang/Object;
    .restart local v9    # "$result":Ljava/lang/Object;
    :cond_18
    nop

    .line 936
    .end local v10    # "$i$f$forEach":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

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
