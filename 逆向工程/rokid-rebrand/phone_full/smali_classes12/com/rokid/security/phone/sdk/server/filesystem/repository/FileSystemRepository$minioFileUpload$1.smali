.class final Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FileSystemRepository.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->minioFileUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Z)V
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
    value = "SMAP\nFileSystemRepository.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FileSystemRepository.kt\ncom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult\n*L\n1#1,467:1\n42#2,4:468\n42#2,4:472\n*S KotlinDebug\n*F\n+ 1 FileSystemRepository.kt\ncom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1\n*L\n284#1:468,4\n285#1:472,4\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.filesystem.repository.FileSystemRepository$minioFileUpload$1"
    f = "FileSystemRepository.kt"
    i = {
        0x0,
        0x0,
        0x0,
        0x0,
        0x1,
        0x1,
        0x1,
        0x1,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2
    }
    l = {
        0x116,
        0x118,
        0x120,
        0x122
    }
    m = "invokeSuspend"
    n = {
        "fileStartTime",
        "fileEndTime",
        "preCalculatedMd5",
        "file",
        "fileStartTime",
        "fileEndTime",
        "preCalculatedMd5",
        "file",
        "fileStartTime",
        "fileEndTime",
        "preCalculatedMd5",
        "file",
        "it"
    }
    s = {
        "L$0",
        "L$1",
        "L$2",
        "L$3",
        "L$0",
        "L$1",
        "L$2",
        "L$3",
        "L$0",
        "L$1",
        "L$2",
        "L$3",
        "L$8"
    }
.end annotation


# instance fields
.field final synthetic $callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $captureTime:J

.field final synthetic $category:Ljava/lang/String;

.field final synthetic $filePath:Ljava/lang/String;

.field final synthetic $isLog:Z

.field final synthetic $tag:Ljava/lang/String;

.field J$0:J

.field L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field L$4:Ljava/lang/Object;

.field L$5:Ljava/lang/Object;

.field L$6:Ljava/lang/Object;

.field L$7:Ljava/lang/Object;

.field L$8:Ljava/lang/Object;

.field Z$0:Z

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;


# direct methods
.method constructor <init>(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;ZLjava/lang/String;Ljava/lang/String;JLkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
            ">;Z",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "J",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$filePath:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iput-boolean p4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$isLog:Z

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$category:Ljava/lang/String;

    iput-object p6, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$tag:Ljava/lang/String;

    iput-wide p7, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$captureTime:J

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

    new-instance v10, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$filePath:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iget-boolean v4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$isLog:Z

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$category:Ljava/lang/String;

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$tag:Ljava/lang/String;

    iget-wide v7, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$captureTime:J

    move-object v0, v10

    move-object v9, p2

    invoke-direct/range {v0 .. v9}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;-><init>(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;ZLjava/lang/String;Ljava/lang/String;JLkotlin/coroutines/Continuation;)V

    check-cast v10, Lkotlin/coroutines/Continuation;

    return-object v10
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 31

    const-string/jumbo v0, "\u6587\u4ef6\u4e0d\u5b58\u5728"

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 243
    move-object/from16 v2, p0

    iget v3, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->label:I

    packed-switch v3, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v1, p0

    .local v1, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    move-object/from16 v3, p1

    .local v3, "$result":Ljava/lang/Object;
    const/4 v0, 0x0

    .local v0, "$i$a$-let-FileSystemRepository$minioFileUpload$1$1":I
    :try_start_0
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_9

    .line 319
    .end local v0    # "$i$a$-let-FileSystemRepository$minioFileUpload$1$1":I
    :catch_0
    move-exception v0

    goto/16 :goto_b

    .line 243
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .end local v3    # "$result":Ljava/lang/Object;
    :pswitch_1
    move-object/from16 v3, p0

    .local v3, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    move-object/from16 v8, p1

    .local v8, "$result":Ljava/lang/Object;
    const/4 v0, 0x0

    .restart local v0    # "$i$a$-let-FileSystemRepository$minioFileUpload$1$1":I
    iget-wide v9, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->J$0:J

    iget-boolean v11, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->Z$0:Z

    iget-object v12, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$8:Ljava/lang/Object;

    check-cast v12, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    .local v12, "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    iget-object v13, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$7:Ljava/lang/Object;

    check-cast v13, Ljava/lang/String;

    iget-object v14, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$6:Ljava/lang/Object;

    check-cast v14, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iget-object v15, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$5:Ljava/lang/Object;

    check-cast v15, Ljava/lang/String;

    iget-object v4, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$4:Ljava/lang/Object;

    check-cast v4, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$3:Ljava/lang/Object;

    check-cast v5, Ljava/io/File;

    .local v5, "file":Ljava/io/File;
    iget-object v7, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$2:Ljava/lang/Object;

    check-cast v7, Lkotlin/jvm/internal/Ref$ObjectRef;

    .local v7, "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object v6, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$1:Ljava/lang/Object;

    check-cast v6, Lkotlin/jvm/internal/Ref$LongRef;

    move/from16 p1, v0

    .end local v0    # "$i$a$-let-FileSystemRepository$minioFileUpload$1$1":I
    .local v6, "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .local p1, "$i$a$-let-FileSystemRepository$minioFileUpload$1$1":I
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlin/jvm/internal/Ref$LongRef;

    .local v0, "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :try_start_1
    invoke-static {v8}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move/from16 v17, p1

    move-object/from16 v21, v4

    move-object/from16 v18, v8

    move-wide/from16 v26, v9

    move-object/from16 v24, v13

    move-object v4, v15

    move-object v9, v3

    move-object v3, v12

    goto/16 :goto_7

    .line 319
    .end local v0    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v5    # "file":Ljava/io/File;
    .end local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v7    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v12    # "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .end local p1    # "$i$a$-let-FileSystemRepository$minioFileUpload$1$1":I
    :catch_1
    move-exception v0

    move-object v1, v3

    move-object v3, v8

    goto/16 :goto_b

    .line 243
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .end local v8    # "$result":Ljava/lang/Object;
    :pswitch_2
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    move-object/from16 v4, p1

    .local v4, "$result":Ljava/lang/Object;
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$3:Ljava/lang/Object;

    check-cast v0, Ljava/io/File;

    .local v0, "file":Ljava/io/File;
    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$2:Ljava/lang/Object;

    check-cast v5, Lkotlin/jvm/internal/Ref$ObjectRef;

    .local v5, "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object v6, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$1:Ljava/lang/Object;

    check-cast v6, Lkotlin/jvm/internal/Ref$LongRef;

    .restart local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    iget-object v7, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$0:Ljava/lang/Object;

    check-cast v7, Lkotlin/jvm/internal/Ref$LongRef;

    .local v7, "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :try_start_2
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v8, v4

    check-cast v8, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v8
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_5

    const/4 v10, 0x1

    move-object/from16 v30, v5

    move-object v5, v0

    move-object v0, v7

    move-object/from16 v7, v30

    goto/16 :goto_4

    .end local v0    # "file":Ljava/io/File;
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v7    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :pswitch_3
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$3:Ljava/lang/Object;

    check-cast v0, Ljava/io/File;

    .restart local v0    # "file":Ljava/io/File;
    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$2:Ljava/lang/Object;

    check-cast v5, Lkotlin/jvm/internal/Ref$ObjectRef;

    .restart local v5    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object v6, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$1:Ljava/lang/Object;

    check-cast v6, Lkotlin/jvm/internal/Ref$LongRef;

    .restart local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    iget-object v7, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$0:Ljava/lang/Object;

    check-cast v7, Lkotlin/jvm/internal/Ref$LongRef;

    .restart local v7    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :try_start_3
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v8, v4

    check-cast v8, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v8
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_5

    const/4 v10, 0x1

    goto/16 :goto_3

    .end local v0    # "file":Ljava/io/File;
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v7    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :pswitch_4
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    move-object/from16 v4, p1

    .line 244
    .restart local v4    # "$result":Ljava/lang/Object;
    new-instance v5, Lkotlin/jvm/internal/Ref$LongRef;

    invoke-direct {v5}, Lkotlin/jvm/internal/Ref$LongRef;-><init>()V

    move-object v7, v5

    .line 245
    .restart local v7    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    new-instance v5, Lkotlin/jvm/internal/Ref$LongRef;

    invoke-direct {v5}, Lkotlin/jvm/internal/Ref$LongRef;-><init>()V

    move-object v6, v5

    .line 246
    .restart local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    new-instance v5, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v5}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 248
    .restart local v5    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    nop

    .line 249
    :try_start_4
    new-instance v8, Ljava/io/File;

    iget-object v9, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$filePath:Ljava/lang/String;

    invoke-direct {v8, v9}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 250
    .local v8, "file":Ljava/io/File;
    invoke-virtual {v8}, Ljava/io/File;->exists()Z

    move-result v9

    const/4 v10, -0x1

    if-eqz v9, :cond_e

    .line 251
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v0

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v11, "\u6587\u4ef6\u5b58\u5728 \u5927\u5c0f\u662f\uff1a"

    invoke-virtual {v9, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v8}, Ljava/io/File;->length()J

    move-result-wide v11

    invoke-virtual {v9, v11, v12}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v0, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 254
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v0

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v11, "\u5f00\u59cb\u9884\u5148\u8ba1\u7b97\u6587\u4ef6MD5: "

    invoke-virtual {v9, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$filePath:Ljava/lang/String;

    invoke-virtual {v9, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v0, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 255
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    invoke-virtual {v0, v8}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->generateMD5(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v5, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 256
    iget-object v0, v5, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v0, Ljava/lang/CharSequence;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    if-eqz v0, :cond_2

    .line 257
    .end local v5    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v7    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v8    # "file":Ljava/io/File;
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u9884\u5148\u8ba1\u7b97MD5\u5931\u8d25\uff0c\u6587\u4ef6\u53ef\u80fd\u65e0\u6cd5\u8bfb\u53d6"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 258
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    invoke-static {v10}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v1

    const-string/jumbo v5, "\u6587\u4ef6MD5\u8ba1\u7b97\u5931\u8d25"

    invoke-interface {v0, v1, v5}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 259
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 261
    .restart local v5    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v7    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v8    # "file":Ljava/io/File;
    :cond_2
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v0

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v10, "\u9884\u5148\u8ba1\u7b97MD5\u6210\u529f: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, v5, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v10, Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v0, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 263
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    invoke-virtual {v0, v8}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->readAlbumMeta(Ljava/io/File;)Lkotlin/Pair;

    move-result-object v0

    .line 264
    .local v0, "meta":Lkotlin/Pair;
    if-eqz v0, :cond_3

    .line 265
    invoke-virtual {v0}, Lkotlin/Pair;->getFirst()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Number;

    invoke-virtual {v9}, Ljava/lang/Number;->longValue()J

    move-result-wide v9

    iput-wide v9, v7, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 266
    invoke-virtual {v0}, Lkotlin/Pair;->getSecond()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Number;

    invoke-virtual {v9}, Ljava/lang/Number;->longValue()J

    move-result-wide v9

    iput-wide v9, v6, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    goto :goto_2

    .line 268
    .end local v0    # "meta":Lkotlin/Pair;
    :cond_3
    invoke-virtual {v8}, Ljava/io/File;->lastModified()J

    move-result-wide v9

    .line 269
    .local v9, "t":J
    iput-wide v9, v7, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 270
    iput-wide v9, v6, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 277
    .end local v9    # "t":J
    :goto_2
    iget-boolean v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$isLog:Z

    if-eqz v0, :cond_5

    .line 278
    new-instance v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$ret$1;

    iget-object v9, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v10, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$category:Ljava/lang/String;

    invoke-direct {v0, v9, v10}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$ret$1;-><init>(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/lang/String;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    move-object v9, v3

    check-cast v9, Lkotlin/coroutines/Continuation;

    iput-object v7, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$0:Ljava/lang/Object;

    iput-object v6, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$1:Ljava/lang/Object;

    iput-object v5, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$2:Ljava/lang/Object;

    iput-object v8, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$3:Ljava/lang/Object;

    const/4 v10, 0x1

    iput v10, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->label:I

    invoke-static {v0, v9}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    if-ne v0, v1, :cond_4

    .line 243
    return-object v1

    .line 278
    :cond_4
    move-object/from16 v30, v8

    move-object v8, v0

    move-object/from16 v0, v30

    .end local v8    # "file":Ljava/io/File;
    .local v0, "file":Ljava/io/File;
    :goto_3
    move-object/from16 v30, v5

    move-object v5, v0

    move-object v0, v7

    move-object/from16 v7, v30

    goto :goto_4

    .line 280
    .end local v0    # "file":Ljava/io/File;
    .restart local v8    # "file":Ljava/io/File;
    :cond_5
    const/4 v10, 0x1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$ret$2;

    iget-object v9, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$category:Ljava/lang/String;

    invoke-direct {v0, v9, v11}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$ret$2;-><init>(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/lang/String;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    move-object v9, v3

    check-cast v9, Lkotlin/coroutines/Continuation;

    iput-object v7, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$0:Ljava/lang/Object;

    iput-object v6, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$1:Ljava/lang/Object;

    iput-object v5, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$2:Ljava/lang/Object;

    iput-object v8, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$3:Ljava/lang/Object;

    const/4 v11, 0x2

    iput v11, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->label:I

    invoke-static {v0, v9}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_5

    if-ne v0, v1, :cond_6

    .line 243
    return-object v1

    .line 280
    :cond_6
    move-object/from16 v30, v8

    move-object v8, v0

    move-object v0, v7

    move-object v7, v5

    move-object/from16 v5, v30

    .end local v8    # "file":Ljava/io/File;
    .local v0, "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .local v5, "file":Ljava/io/File;
    .local v7, "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    :goto_4
    nop

    .line 277
    nop

    .line 283
    .local v8, "ret":Ljava/lang/Object;
    :try_start_5
    iget-object v9, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v9}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v9

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "minioFileUpload "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-static {v8}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v11

    const/16 v12, 0x20

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v11

    invoke-static {v9, v11}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 284
    invoke-static {v8}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_d

    const/4 v9, 0x0

    .line 468
    .local v9, "$i$f$getOrNull-impl":I
    nop

    .line 469
    invoke-static {v8}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_7

    const/4 v11, 0x0

    goto :goto_5

    .line 470
    :cond_7
    move-object v11, v8

    .line 471
    :goto_5
    nop

    .line 284
    .end local v9    # "$i$f$getOrNull-impl":I
    if-eqz v11, :cond_d

    .line 285
    const/4 v9, 0x0

    .line 472
    .restart local v9    # "$i$f$getOrNull-impl":I
    nop

    .line 473
    invoke-static {v8}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_8

    const/4 v8, 0x0

    goto :goto_6

    .line 474
    :cond_8
    nop

    .line 475
    .end local v8    # "ret":Ljava/lang/Object;
    :goto_6
    nop

    .line 285
    .end local v9    # "$i$f$getOrNull-impl":I
    check-cast v8, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    .line 286
    .local v8, "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    if-eqz v8, :cond_c

    iget-object v9, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v15, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$filePath:Ljava/lang/String;

    iget-boolean v11, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$isLog:Z

    iget-object v14, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iget-object v13, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$tag:Ljava/lang/String;

    move/from16 p1, v11

    iget-wide v10, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$captureTime:J

    move-object/from16 v16, v8

    .local v16, "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    const/16 v17, 0x0

    .line 287
    .local v17, "$i$a$-let-FileSystemRepository$minioFileUpload$1$1":I
    invoke-static {v9}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v12

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4

    move-object/from16 v18, v4

    .end local v4    # "$result":Ljava/lang/Object;
    .local v18, "$result":Ljava/lang/Object;
    :try_start_6
    const-string v4, "minio STS info endPoint:"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {v16 .. v16}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getEndpoint()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v4, 0x20

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v12, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 288
    iput-object v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$0:Ljava/lang/Object;

    iput-object v6, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$1:Ljava/lang/Object;

    iput-object v7, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$2:Ljava/lang/Object;

    iput-object v5, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$3:Ljava/lang/Object;

    iput-object v9, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$4:Ljava/lang/Object;

    iput-object v15, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$5:Ljava/lang/Object;

    iput-object v14, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$6:Ljava/lang/Object;

    iput-object v13, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$7:Ljava/lang/Object;

    move-object/from16 v2, v16

    .end local v16    # "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .local v2, "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    iput-object v2, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$8:Ljava/lang/Object;

    move/from16 v4, p1

    iput-boolean v4, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->Z$0:Z

    iput-wide v10, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->J$0:J

    const/4 v12, 0x3

    iput v12, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->label:I

    invoke-static {v9, v5, v8, v3}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$uploadVideoThumbnailByMinio(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/io/File;Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v12
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_3

    .end local v8    # "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    if-ne v12, v1, :cond_9

    .line 243
    return-object v1

    .line 288
    :cond_9
    move-object/from16 v21, v9

    move-wide/from16 v26, v10

    move-object v8, v12

    move-object/from16 v24, v13

    move-object v9, v3

    move v11, v4

    move-object v4, v15

    move-object v3, v2

    .line 243
    .end local v2    # "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .local v3, "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .local v9, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    :goto_7
    :try_start_7
    move-object/from16 v25, v8

    check-cast v25, Ljava/lang/String;

    .line 290
    .local v25, "thumbnailsObjectKey":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

    new-instance v8, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1;

    move-object/from16 v19, v8

    move-object/from16 v20, v7

    move-object/from16 v22, v14

    move-object/from16 v23, v5

    move-object/from16 v28, v0

    move-object/from16 v29, v6

    invoke-direct/range {v19 .. v29}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Ljava/io/File;Ljava/lang/String;Ljava/lang/String;JLkotlin/jvm/internal/Ref$LongRef;Lkotlin/jvm/internal/Ref$LongRef;)V

    check-cast v8, Lkotlin/jvm/functions/Function3;

    new-instance v10, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$2;

    invoke-direct {v10, v14}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$2;-><init>(Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V

    check-cast v10, Lkotlin/jvm/functions/Function2;

    .line 314
    .end local v0    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v3    # "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .end local v5    # "file":Ljava/io/File;
    .end local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v7    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v25    # "thumbnailsObjectKey":Ljava/lang/String;
    if-eqz v11, :cond_a

    const/4 v7, 0x1

    goto :goto_8

    :cond_a
    const/4 v7, 0x0

    .line 290
    :goto_8
    const/4 v0, 0x0

    iput-object v0, v9, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$0:Ljava/lang/Object;

    iput-object v0, v9, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$1:Ljava/lang/Object;

    iput-object v0, v9, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$2:Ljava/lang/Object;

    iput-object v0, v9, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$3:Ljava/lang/Object;

    iput-object v0, v9, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$4:Ljava/lang/Object;

    iput-object v0, v9, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$5:Ljava/lang/Object;

    iput-object v0, v9, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$6:Ljava/lang/Object;

    iput-object v0, v9, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$7:Ljava/lang/Object;

    iput-object v0, v9, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->L$8:Ljava/lang/Object;

    const/4 v0, 0x4

    iput v0, v9, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->label:I

    move-object v5, v8

    move-object v6, v10

    move-object v8, v9

    invoke-virtual/range {v2 .. v8}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->uploadFile(Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function2;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2

    if-ne v0, v1, :cond_b

    .line 243
    return-object v1

    .line 290
    :cond_b
    move-object v1, v9

    move/from16 v0, v17

    move-object/from16 v3, v18

    .line 315
    .end local v9    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .end local v17    # "$i$a$-let-FileSystemRepository$minioFileUpload$1$1":I
    .end local v18    # "$result":Ljava/lang/Object;
    .local v0, "$i$a$-let-FileSystemRepository$minioFileUpload$1$1":I
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .local v3, "$result":Ljava/lang/Object;
    :goto_9
    nop

    .line 286
    .end local v0    # "$i$a$-let-FileSystemRepository$minioFileUpload$1$1":I
    move-object v4, v3

    move-object v3, v1

    goto/16 :goto_c

    .line 319
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .end local v3    # "$result":Ljava/lang/Object;
    .restart local v9    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .restart local v18    # "$result":Ljava/lang/Object;
    :catch_2
    move-exception v0

    move-object v1, v9

    move-object/from16 v3, v18

    goto :goto_b

    .line 286
    .end local v9    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .end local v18    # "$result":Ljava/lang/Object;
    .local v0, "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .local v3, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v5    # "file":Ljava/io/File;
    .restart local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v7    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v8    # "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    :cond_c
    move-object/from16 v18, v4

    .end local v0    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "file":Ljava/io/File;
    .end local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v7    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v8    # "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .restart local v18    # "$result":Ljava/lang/Object;
    goto :goto_a

    .line 284
    .end local v18    # "$result":Ljava/lang/Object;
    .restart local v0    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v5    # "file":Ljava/io/File;
    .restart local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v7    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .local v8, "ret":Ljava/lang/Object;
    :cond_d
    move-object/from16 v18, v4

    .line 317
    .end local v0    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "file":Ljava/io/File;
    .end local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v7    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v8    # "ret":Ljava/lang/Object;
    .restart local v18    # "$result":Ljava/lang/Object;
    :try_start_8
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    const/4 v1, -0x3

    invoke-static {v1}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v1, "StsToken \u8c03\u7528\u5931\u8d25"

    invoke-interface {v0, v2, v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_3

    .line 323
    :goto_a
    move-object/from16 v4, v18

    goto :goto_c

    .line 319
    :catch_3
    move-exception v0

    move-object v1, v3

    move-object/from16 v3, v18

    goto :goto_b

    .end local v18    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    :catch_4
    move-exception v0

    move-object/from16 v18, v4

    move-object v1, v3

    move-object/from16 v3, v18

    .end local v4    # "$result":Ljava/lang/Object;
    .restart local v18    # "$result":Ljava/lang/Object;
    goto :goto_b

    .line 273
    .end local v18    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    .local v5, "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .local v7, "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .local v8, "file":Ljava/io/File;
    :cond_e
    :try_start_9
    iget-object v1, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v1

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 274
    iget-object v1, v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    invoke-static {v10}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2, v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 275
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_5

    return-object v0

    .line 319
    .end local v5    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v6    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v7    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v8    # "file":Ljava/io/File;
    :catch_5
    move-exception v0

    move-object v1, v3

    move-object v3, v4

    .line 320
    .end local v4    # "$result":Ljava/lang/Object;
    .local v0, "e":Ljava/lang/Exception;
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .local v3, "$result":Ljava/lang/Object;
    :goto_b
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    const/4 v4, -0x3

    invoke-static {v4}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "minioFileUpload \u8c03\u7528\u5931\u8d25 "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v2, v4, v5}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    move-object v4, v3

    move-object v3, v1

    .line 323
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .local v3, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1;
    .restart local v4    # "$result":Ljava/lang/Object;
    :goto_c
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
