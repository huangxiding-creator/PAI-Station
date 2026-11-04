.class final Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "MinioCoreUtil.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->startUploadFile(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
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
        "Ljava/lang/Boolean;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nMinioCoreUtil.kt\nKotlin\n*S Kotlin\n*F\n+ 1 MinioCoreUtil.kt\ncom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2\n+ 2 ArraysJVM.kt\nkotlin/collections/ArraysKt__ArraysJVMKt\n*L\n1#1,172:1\n37#2,2:173\n*S KotlinDebug\n*F\n+ 1 MinioCoreUtil.kt\ncom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2\n*L\n148#1:173,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u000b\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\u008a@"
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
    c = "com.rokid.security.phone.sdk.server.filesystem.MinioCoreUtil$startUploadFile$2"
    f = "MinioCoreUtil.kt"
    i = {
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
        0x2
    }
    l = {
        0x53,
        0x68,
        0x96
    }
    m = "invokeSuspend"
    n = {
        "fileSize",
        "partSize",
        "count",
        "uploadId",
        "partList",
        "data",
        "raf",
        "fileSize",
        "partSize",
        "count",
        "i",
        "fileSize"
    }
    s = {
        "J$0",
        "J$1",
        "I$0",
        "L$0",
        "L$1",
        "L$2",
        "L$3",
        "J$0",
        "J$1",
        "I$0",
        "I$1",
        "J$0"
    }
.end annotation


# instance fields
.field final synthetic $bucketName:Ljava/lang/String;

.field final synthetic $filePath:Ljava/lang/String;

.field final synthetic $objectName:Ljava/lang/String;

.field final synthetic $onUploadComplate:Lkotlin/jvm/functions/Function3;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function3<",
            "Ljava/lang/Long;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $onUploadFail:Lkotlin/jvm/functions/Function2;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function2<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $region:Ljava/lang/String;

.field I$0:I

.field I$1:I

.field J$0:J

.field J$1:J

.field L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field label:I


# direct methods
.method constructor <init>(Ljava/lang/String;Lkotlin/jvm/functions/Function2;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function3<",
            "-",
            "Ljava/lang/Long;",
            "-",
            "Ljava/lang/String;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$filePath:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$onUploadFail:Lkotlin/jvm/functions/Function2;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$objectName:Ljava/lang/String;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$bucketName:Ljava/lang/String;

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$region:Ljava/lang/String;

    iput-object p6, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$onUploadComplate:Lkotlin/jvm/functions/Function3;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p7}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 9
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

    new-instance v8, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$filePath:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$onUploadFail:Lkotlin/jvm/functions/Function2;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$objectName:Ljava/lang/String;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$bucketName:Ljava/lang/String;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$region:Ljava/lang/String;

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$onUploadComplate:Lkotlin/jvm/functions/Function3;

    move-object v0, v8

    move-object v7, p2

    invoke-direct/range {v0 .. v7}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;-><init>(Ljava/lang/String;Lkotlin/jvm/functions/Function2;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/coroutines/Continuation;)V

    check-cast v8, Lkotlin/coroutines/Continuation;

    return-object v8
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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
            "Ljava/lang/Boolean;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 29

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 59
    move-object/from16 v1, p0

    iget v2, v1, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->label:I

    const/4 v5, 0x1

    packed-switch v2, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v2, p0

    .local v2, "this":Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;
    move-object/from16 v6, p1

    .local v6, "$result":Ljava/lang/Object;
    iget-wide v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->J$0:J

    .local v7, "fileSize":J
    :try_start_0
    invoke-static {v6}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_6

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;
    .end local v6    # "$result":Ljava/lang/Object;
    .end local v7    # "fileSize":J
    :pswitch_1
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;
    move-object/from16 v6, p1

    .restart local v6    # "$result":Ljava/lang/Object;
    iget v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->I$1:I

    .local v7, "i":I
    iget v8, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->I$0:I

    .local v8, "count":I
    iget-wide v9, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->J$1:J

    .local v9, "partSize":J
    iget-wide v11, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->J$0:J

    .local v11, "fileSize":J
    iget-object v13, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$3:Ljava/lang/Object;

    check-cast v13, Ljava/io/RandomAccessFile;

    .local v13, "raf":Ljava/io/RandomAccessFile;
    iget-object v14, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$2:Ljava/lang/Object;

    check-cast v14, [B

    .local v14, "data":[B
    iget-object v15, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$1:Ljava/lang/Object;

    check-cast v15, Ljava/util/List;

    .local v15, "partList":Ljava/util/List;
    iget-object v3, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$0:Ljava/lang/Object;

    check-cast v3, Ljava/lang/String;

    .local v3, "uploadId":Ljava/lang/String;
    :try_start_1
    invoke-static {v6}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object/from16 v17, v6

    move-object v5, v14

    move v14, v8

    move-wide v8, v9

    move-object v10, v13

    move-wide v12, v11

    move-object v11, v15

    goto/16 :goto_4

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;
    .end local v3    # "uploadId":Ljava/lang/String;
    .end local v6    # "$result":Ljava/lang/Object;
    .end local v7    # "i":I
    .end local v8    # "count":I
    .end local v9    # "partSize":J
    .end local v11    # "fileSize":J
    .end local v13    # "raf":Ljava/io/RandomAccessFile;
    .end local v14    # "data":[B
    .end local v15    # "partList":Ljava/util/List;
    :pswitch_2
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;
    move-object/from16 v6, p1

    .restart local v6    # "$result":Ljava/lang/Object;
    iget v3, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->I$0:I

    .local v3, "count":I
    iget-wide v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->J$1:J

    .local v7, "partSize":J
    iget-wide v9, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->J$0:J

    .local v9, "fileSize":J
    :try_start_2
    invoke-static {v6}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-wide v10, v9

    move-wide v8, v7

    move-object v7, v6

    goto/16 :goto_1

    .line 162
    .end local v3    # "count":I
    .end local v7    # "partSize":J
    .end local v9    # "fileSize":J
    :catchall_0
    move-exception v0

    goto/16 :goto_9

    .line 157
    :catch_0
    move-exception v0

    goto/16 :goto_7

    .line 59
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;
    .end local v6    # "$result":Ljava/lang/Object;
    :pswitch_3
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;
    move-object/from16 v6, p1

    .line 61
    .restart local v6    # "$result":Ljava/lang/Object;
    new-instance v3, Ljava/io/File;

    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$filePath:Ljava/lang/String;

    invoke-direct {v3, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 62
    .local v3, "file":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v7

    if-eqz v7, :cond_a

    invoke-virtual {v3}, Ljava/io/File;->isFile()Z

    move-result v7

    if-nez v7, :cond_0

    goto/16 :goto_a

    .line 67
    :cond_0
    invoke-virtual {v3}, Ljava/io/File;->length()J

    move-result-wide v9

    .line 68
    .end local v3    # "file":Ljava/io/File;
    .restart local v9    # "fileSize":J
    nop

    .line 69
    const-wide/32 v7, 0x6400000

    cmp-long v3, v9, v7

    if-gez v3, :cond_1

    .line 70
    const-wide/32 v7, 0x500000

    .restart local v7    # "partSize":J
    goto :goto_0

    .line 71
    .end local v7    # "partSize":J
    :cond_1
    const-wide/32 v7, 0x40000000

    cmp-long v3, v9, v7

    if-gez v3, :cond_2

    .line 72
    const-wide/32 v7, 0xa00000

    .restart local v7    # "partSize":J
    goto :goto_0

    .line 74
    .end local v7    # "partSize":J
    :cond_2
    const-wide/32 v7, 0x1400000

    .line 76
    .restart local v7    # "partSize":J
    :goto_0
    nop

    .line 77
    long-to-double v11, v9

    long-to-double v13, v7

    div-double/2addr v11, v13

    invoke-static {v11, v12}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v11

    double-to-int v3, v11

    .line 78
    .local v3, "count":I
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v11

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "minio objectName "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    iget-object v13, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$objectName:Ljava/lang/String;

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v11, v12}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 79
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v11

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "minio: fileSize:"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, " partSize:"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, " count:"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v11, v12}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 80
    nop

    .line 82
    :try_start_3
    sget-object v11, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

    invoke-virtual {v11}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->getClient()Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;

    move-result-object v16

    iget-object v11, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$bucketName:Ljava/lang/String;

    iget-object v12, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$region:Ljava/lang/String;

    iget-object v13, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$objectName:Ljava/lang/String;

    const/16 v20, 0x0

    const/16 v21, 0x0

    move-object/from16 v17, v11

    move-object/from16 v18, v12

    move-object/from16 v19, v13

    invoke-virtual/range {v16 .. v21}, Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;->createMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v11

    const-string v12, "client.createMultipartUp\u2026, objectName, null, null)"

    invoke-static {v11, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v11, Ljava/util/concurrent/CompletionStage;

    move-object v12, v2

    check-cast v12, Lkotlin/coroutines/Continuation;

    .line 83
    iput-wide v9, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->J$0:J

    iput-wide v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->J$1:J

    iput v3, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->I$0:I

    iput v5, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->label:I

    invoke-static {v11, v12}, Lkotlinx/coroutines/future/FutureKt;->await(Ljava/util/concurrent/CompletionStage;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v11
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-ne v11, v0, :cond_3

    .line 59
    return-object v0

    .line 83
    :cond_3
    move-wide/from16 v27, v7

    move-object v7, v6

    move-object v6, v11

    move-wide v10, v9

    move-wide/from16 v8, v27

    .line 59
    .end local v6    # "$result":Ljava/lang/Object;
    .end local v9    # "fileSize":J
    .local v7, "$result":Ljava/lang/Object;
    .local v8, "partSize":J
    .local v10, "fileSize":J
    :goto_1
    :try_start_4
    check-cast v6, Lio/minio/CreateMultipartUploadResponse;

    .line 81
    nop

    .line 84
    .local v6, "createResponse":Lio/minio/CreateMultipartUploadResponse;
    invoke-virtual {v6}, Lio/minio/CreateMultipartUploadResponse;->result()Lio/minio/messages/InitiateMultipartUploadResult;

    move-result-object v12

    invoke-virtual {v12}, Lio/minio/messages/InitiateMultipartUploadResult;->uploadId()Ljava/lang/String;

    move-result-object v12

    move-object v6, v12

    .line 85
    .local v6, "uploadId":Ljava/lang/String;
    new-instance v12, Ljava/util/ArrayList;

    invoke-direct {v12}, Ljava/util/ArrayList;-><init>()V

    check-cast v12, Ljava/util/List;

    .line 87
    .local v12, "partList":Ljava/util/List;
    long-to-int v13, v8

    new-array v13, v13, [B

    .line 88
    .local v13, "data":[B
    new-instance v14, Ljava/io/RandomAccessFile;

    iget-object v15, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$filePath:Ljava/lang/String;

    const-string v5, "r"

    invoke-direct {v14, v15, v5}, Ljava/io/RandomAccessFile;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    move-object v5, v14

    .line 89
    .local v5, "raf":Ljava/io/RandomAccessFile;
    const/4 v14, 0x1

    .local v14, "i":I
    move-object/from16 v17, v7

    if-gt v14, v3, :cond_7

    move v15, v14

    move v14, v3

    move-object v3, v6

    move-wide/from16 v27, v10

    move-object v10, v5

    move-object v11, v12

    move-object v5, v13

    move-wide/from16 v12, v27

    .line 90
    .end local v6    # "uploadId":Ljava/lang/String;
    .end local v7    # "$result":Ljava/lang/Object;
    .end local v13    # "data":[B
    .local v3, "uploadId":Ljava/lang/String;
    .local v5, "data":[B
    .local v10, "raf":Ljava/io/RandomAccessFile;
    .local v11, "partList":Ljava/util/List;
    .local v12, "fileSize":J
    .local v14, "count":I
    .local v15, "i":I
    .local v17, "$result":Ljava/lang/Object;
    :goto_2
    :try_start_5
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u5f00\u59cb\u8bfb\u53d6\u5e76\u4e0a\u4f20 "

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v6, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 91
    add-int/lit8 v4, v15, -0x1

    int-to-long v6, v4

    mul-long/2addr v6, v8

    .line 92
    .local v6, "skip":J
    invoke-virtual {v10, v6, v7}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 93
    .end local v6    # "skip":J
    if-ne v15, v14, :cond_4

    .line 94
    add-int/lit8 v4, v15, -0x1

    int-to-long v6, v4

    mul-long/2addr v6, v8

    sub-long v6, v12, v6

    .line 95
    .local v6, "remaining":J
    cmp-long v4, v6, v8

    if-gez v4, :cond_4

    .line 96
    .end local v5    # "data":[B
    .end local v8    # "partSize":J
    move-wide v4, v6

    .line 97
    .end local v6    # "remaining":J
    .local v4, "partSize":J
    long-to-int v6, v4

    new-array v6, v6, [B

    move-wide v8, v4

    move-object v4, v6

    .local v6, "data":[B
    goto :goto_3

    .line 100
    .end local v4    # "partSize":J
    .end local v6    # "data":[B
    .restart local v5    # "data":[B
    .restart local v8    # "partSize":J
    :cond_4
    move-object v4, v5

    .end local v5    # "data":[B
    .local v4, "data":[B
    :goto_3
    long-to-int v5, v8

    const/4 v6, 0x0

    invoke-virtual {v10, v4, v6, v5}, Ljava/io/RandomAccessFile;->readFully([BII)V

    .line 101
    sget-object v5, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->getClient()Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;

    move-result-object v5

    .line 102
    iget-object v6, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$bucketName:Ljava/lang/String;

    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$region:Ljava/lang/String;

    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$objectName:Ljava/lang/String;

    .line 103
    nop

    .line 101
    const/16 v19, 0x0

    const/16 v20, 0x0

    move-wide/from16 v21, v8

    .end local v8    # "partSize":J
    .local v21, "partSize":J
    move-object v8, v1

    move-object v9, v4

    move-object v1, v10

    move-object/from16 v23, v11

    .end local v10    # "raf":Ljava/io/RandomAccessFile;
    .end local v11    # "partList":Ljava/util/List;
    .local v1, "raf":Ljava/io/RandomAccessFile;
    .local v23, "partList":Ljava/util/List;
    move-wide/from16 v10, v21

    move-wide/from16 v24, v12

    .end local v12    # "fileSize":J
    .local v24, "fileSize":J
    move-object v12, v3

    move v13, v15

    move-object/from16 p1, v0

    move v0, v14

    .end local v14    # "count":I
    .local v0, "count":I
    move-object/from16 v14, v19

    move/from16 v26, v15

    .end local v15    # "i":I
    .local v26, "i":I
    move-object/from16 v15, v20

    invoke-virtual/range {v5 .. v15}, Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;->uploadPartAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;JLjava/lang/String;ILcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v5

    const-string v6, "client.uploadPartAsync(\n\u2026l, null\n                )"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v5, Ljava/util/concurrent/CompletionStage;

    move-object v6, v2

    check-cast v6, Lkotlin/coroutines/Continuation;

    .line 104
    iput-object v3, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$0:Ljava/lang/Object;

    move-object/from16 v12, v23

    .end local v23    # "partList":Ljava/util/List;
    .local v12, "partList":Ljava/util/List;
    iput-object v12, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$1:Ljava/lang/Object;

    iput-object v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$2:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$3:Ljava/lang/Object;

    move-wide/from16 v10, v24

    .end local v24    # "fileSize":J
    .local v10, "fileSize":J
    iput-wide v10, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->J$0:J

    move-wide/from16 v8, v21

    .end local v21    # "partSize":J
    .restart local v8    # "partSize":J
    iput-wide v8, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->J$1:J

    iput v0, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->I$0:I

    move/from16 v14, v26

    .end local v26    # "i":I
    .local v14, "i":I
    iput v14, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->I$1:I

    const/4 v7, 0x2

    iput v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->label:I

    invoke-static {v5, v6}, Lkotlinx/coroutines/future/FutureKt;->await(Ljava/util/concurrent/CompletionStage;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v6

    move-object/from16 v5, p1

    if-ne v6, v5, :cond_5

    .line 59
    return-object v5

    .line 104
    :cond_5
    move v7, v14

    move v14, v0

    move-object v0, v5

    move-object v5, v4

    move-wide/from16 v27, v10

    move-object v10, v1

    move-object v11, v12

    move-wide/from16 v12, v27

    .line 59
    .end local v0    # "count":I
    .end local v1    # "raf":Ljava/io/RandomAccessFile;
    .end local v4    # "data":[B
    .restart local v5    # "data":[B
    .local v7, "i":I
    .local v10, "raf":Ljava/io/RandomAccessFile;
    .restart local v11    # "partList":Ljava/util/List;
    .local v12, "fileSize":J
    .local v14, "count":I
    :goto_4
    check-cast v6, Lio/minio/UploadPartResponse;

    .line 101
    move-object v1, v6

    .line 106
    .local v1, "uploadResponse":Lio/minio/UploadPartResponse;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v4

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v15, "uploadResponse.partNumber "

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v1}, Lio/minio/UploadPartResponse;->partNumber()I

    move-result v15

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v15, "  "

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v1}, Lio/minio/UploadPartResponse;->etag()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v4, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 107
    new-instance v4, Lio/minio/messages/Part;

    invoke-virtual {v1}, Lio/minio/UploadPartResponse;->etag()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v7, v6}, Lio/minio/messages/Part;-><init>(ILjava/lang/String;)V

    invoke-interface {v11, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 89
    nop

    .end local v1    # "uploadResponse":Lio/minio/UploadPartResponse;
    if-eq v7, v14, :cond_6

    add-int/lit8 v15, v7, 0x1

    move-object/from16 v1, p0

    .end local v7    # "i":I
    .restart local v15    # "i":I
    goto/16 :goto_2

    .end local v15    # "i":I
    .restart local v7    # "i":I
    :cond_6
    move-object v7, v3

    goto :goto_5

    .line 162
    .end local v3    # "uploadId":Ljava/lang/String;
    .end local v5    # "data":[B
    .end local v7    # "i":I
    .end local v8    # "partSize":J
    .end local v10    # "raf":Ljava/io/RandomAccessFile;
    .end local v11    # "partList":Ljava/util/List;
    .end local v12    # "fileSize":J
    .end local v14    # "count":I
    :catchall_1
    move-exception v0

    move-object/from16 v6, v17

    goto/16 :goto_9

    .line 157
    :catch_1
    move-exception v0

    move-object/from16 v6, v17

    goto/16 :goto_7

    .line 89
    .end local v17    # "$result":Ljava/lang/Object;
    .local v3, "count":I
    .local v5, "raf":Ljava/io/RandomAccessFile;
    .local v6, "uploadId":Ljava/lang/String;
    .local v7, "$result":Ljava/lang/Object;
    .restart local v8    # "partSize":J
    .local v10, "fileSize":J
    .local v12, "partList":Ljava/util/List;
    .restart local v13    # "data":[B
    .local v14, "i":I
    :cond_7
    move-object v7, v6

    move-wide/from16 v27, v10

    move-object v11, v12

    move-wide/from16 v12, v27

    .line 145
    .end local v3    # "count":I
    .end local v5    # "raf":Ljava/io/RandomAccessFile;
    .end local v6    # "uploadId":Ljava/lang/String;
    .end local v8    # "partSize":J
    .end local v10    # "fileSize":J
    .end local v13    # "data":[B
    .end local v14    # "i":I
    .local v7, "uploadId":Ljava/lang/String;
    .restart local v11    # "partList":Ljava/util/List;
    .local v12, "fileSize":J
    .restart local v17    # "$result":Ljava/lang/Object;
    :goto_5
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "minio upload completed "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-interface {v11}, Ljava/util/List;->size()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 146
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->getClient()Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;

    move-result-object v3

    .line 147
    iget-object v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$bucketName:Ljava/lang/String;

    iget-object v5, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$region:Ljava/lang/String;

    .line 148
    iget-object v6, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$objectName:Ljava/lang/String;

    move-object v1, v11

    check-cast v1, Ljava/util/Collection;

    .end local v7    # "uploadId":Ljava/lang/String;
    .end local v11    # "partList":Ljava/util/List;
    .local v1, "$this$toTypedArray$iv":Ljava/util/Collection;
    const/4 v8, 0x0

    .line 173
    .local v8, "$i$f$toTypedArray":I
    move-object v9, v1

    .line 174
    .local v9, "thisCollection$iv":Ljava/util/Collection;
    const/4 v10, 0x0

    new-array v11, v10, [Lio/minio/messages/Part;

    invoke-interface {v9, v11}, Ljava/util/Collection;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v10

    .end local v1    # "$this$toTypedArray$iv":Ljava/util/Collection;
    .end local v8    # "$i$f$toTypedArray":I
    .end local v9    # "thisCollection$iv":Ljava/util/Collection;
    move-object v8, v10

    check-cast v8, [Lio/minio/messages/Part;

    .line 149
    nop

    .line 146
    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-virtual/range {v3 .. v10}, Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;->completeMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Lio/minio/messages/Part;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    const-string v3, "client.completeMultipart\u2026 null, null\n            )"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v1, Ljava/util/concurrent/CompletionStage;

    move-object v3, v2

    check-cast v3, Lkotlin/coroutines/Continuation;

    .line 150
    const/4 v4, 0x0

    iput-object v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$0:Ljava/lang/Object;

    iput-object v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$1:Ljava/lang/Object;

    iput-object v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$2:Ljava/lang/Object;

    iput-object v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->L$3:Ljava/lang/Object;

    iput-wide v12, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->J$0:J

    const/4 v4, 0x3

    iput v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->label:I

    invoke-static {v1, v3}, Lkotlinx/coroutines/future/FutureKt;->await(Ljava/util/concurrent/CompletionStage;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v1
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    if-ne v1, v0, :cond_8

    .line 59
    return-object v0

    .line 150
    :cond_8
    move-wide v7, v12

    move-object/from16 v6, v17

    .line 152
    .end local v12    # "fileSize":J
    .end local v17    # "$result":Ljava/lang/Object;
    .local v6, "$result":Ljava/lang/Object;
    .local v7, "fileSize":J
    :goto_6
    :try_start_6
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u5f00\u59cb\u5bf9\u6587\u4ef6\u8fdb\u884cMD5\u8ba1\u7b97"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 153
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$filePath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->generateMD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_9

    const-string v0, ""

    .line 154
    .local v0, "md5":Ljava/lang/String;
    :cond_9
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "MD5\u8ba1\u7b97\u5b8c\u6210 "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 155
    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$onUploadComplate:Lkotlin/jvm/functions/Function3;

    invoke-static {v7, v8}, Lkotlin/coroutines/jvm/internal/Boxing;->boxLong(J)Ljava/lang/Long;

    move-result-object v3

    iget-object v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$objectName:Ljava/lang/String;

    invoke-interface {v1, v3, v4, v0}, Lkotlin/jvm/functions/Function3;->invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_0
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 156
    nop

    .line 162
    .end local v0    # "md5":Ljava/lang/String;
    .end local v7    # "fileSize":J
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->getExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    .line 163
    const/4 v4, 0x1

    goto :goto_8

    .line 162
    .end local v6    # "$result":Ljava/lang/Object;
    .local v7, "$result":Ljava/lang/Object;
    :catchall_2
    move-exception v0

    move-object v6, v7

    goto :goto_9

    .line 157
    :catch_2
    move-exception v0

    move-object v6, v7

    .line 158
    .end local v7    # "$result":Ljava/lang/Object;
    .local v0, "e":Ljava/lang/Exception;
    .restart local v6    # "$result":Ljava/lang/Object;
    :goto_7
    :try_start_7
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Exception "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 159
    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$onUploadFail:Lkotlin/jvm/functions/Function2;

    const/4 v3, -0x1

    invoke-static {v3}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " startUploadFile fail  errorMsg = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v3, v4}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 160
    nop

    .line 162
    .end local v0    # "e":Ljava/lang/Exception;
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->getExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    .line 163
    const/4 v4, 0x0

    .line 162
    :goto_8
    invoke-static {v4}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v0

    .line 80
    return-object v0

    .line 162
    :goto_9
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->getExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    throw v0

    .line 63
    :cond_a
    :goto_a
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "\u6587\u4ef6\u4e0d\u5b58\u5728\u6216\u4e0d\u662f\u6709\u6548\u6587\u4ef6\uff1a"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$filePath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "MinIO-Path"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 64
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil$startUploadFile$2;->$onUploadFail:Lkotlin/jvm/functions/Function2;

    const/4 v1, -0x1

    invoke-static {v1}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v1

    const-string/jumbo v3, "\u6587\u4ef6\u4e0d\u5b58\u5728\u6216\u4e0d\u662f\u6709\u6548\u6587\u4ef6"

    invoke-interface {v0, v1, v3}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 65
    const/4 v1, 0x0

    invoke-static {v1}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
