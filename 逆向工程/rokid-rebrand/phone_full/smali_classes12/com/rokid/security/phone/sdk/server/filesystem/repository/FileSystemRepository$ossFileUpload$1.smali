.class final Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FileSystemRepository.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->ossFileUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLkotlin/jvm/functions/Function1;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Z)V
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
    value = "SMAP\nFileSystemRepository.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FileSystemRepository.kt\ncom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult\n*L\n1#1,467:1\n42#2,4:468\n42#2,4:472\n*S KotlinDebug\n*F\n+ 1 FileSystemRepository.kt\ncom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1\n*L\n202#1:468,4\n203#1:472,4\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.filesystem.repository.FileSystemRepository$ossFileUpload$1"
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
        0xc4,
        0xc6,
        0xce,
        0xd0
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
        "data"
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
        "L$4"
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

.field final synthetic $onProgressChanged:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Integer;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

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

.field L$9:Ljava/lang/Object;

.field Z$0:Z

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;


# direct methods
.method constructor <init>(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;ZLjava/lang/String;Lkotlin/jvm/functions/Function1;Ljava/lang/String;JLkotlin/coroutines/Continuation;)V
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
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Integer;",
            "Lkotlin/Unit;",
            ">;",
            "Ljava/lang/String;",
            "J",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$filePath:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iput-boolean p4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$isLog:Z

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$category:Ljava/lang/String;

    iput-object p6, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$onProgressChanged:Lkotlin/jvm/functions/Function1;

    iput-object p7, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$tag:Ljava/lang/String;

    iput-wide p8, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$captureTime:J

    const/4 v0, 0x2

    invoke-direct {p0, v0, p10}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 12
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

    new-instance v11, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$filePath:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iget-boolean v4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$isLog:Z

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$category:Ljava/lang/String;

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$onProgressChanged:Lkotlin/jvm/functions/Function1;

    iget-object v7, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$tag:Ljava/lang/String;

    iget-wide v8, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$captureTime:J

    move-object v0, v11

    move-object v10, p2

    invoke-direct/range {v0 .. v10}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;-><init>(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;ZLjava/lang/String;Lkotlin/jvm/functions/Function1;Ljava/lang/String;JLkotlin/coroutines/Continuation;)V

    check-cast v11, Lkotlin/coroutines/Continuation;

    return-object v11
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 28

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 151
    move-object/from16 v1, p0

    iget v2, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->label:I

    packed-switch v2, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v2, p0

    .local v2, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;
    move-object/from16 v4, p1

    .local v4, "$result":Ljava/lang/Object;
    const/4 v0, 0x0

    .local v0, "$i$a$-let-FileSystemRepository$ossFileUpload$1$1":I
    :try_start_0
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    goto/16 :goto_a

    .end local v0    # "$i$a$-let-FileSystemRepository$ossFileUpload$1$1":I
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;
    .end local v4    # "$result":Ljava/lang/Object;
    :pswitch_1
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;
    move-object/from16 v7, p1

    .local v7, "$result":Ljava/lang/Object;
    const/4 v8, 0x0

    .local v8, "$i$a$-let-FileSystemRepository$ossFileUpload$1$1":I
    iget-wide v9, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->J$0:J

    iget-boolean v11, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->Z$0:Z

    iget-object v12, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$9:Ljava/lang/Object;

    check-cast v12, Ljava/lang/String;

    iget-object v13, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$8:Ljava/lang/Object;

    check-cast v13, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iget-object v14, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$7:Ljava/lang/Object;

    check-cast v14, Lkotlin/jvm/functions/Function1;

    iget-object v15, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$6:Ljava/lang/Object;

    check-cast v15, Ljava/lang/String;

    iget-object v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$5:Ljava/lang/Object;

    check-cast v4, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v3, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$4:Ljava/lang/Object;

    check-cast v3, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    .local v3, "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    iget-object v6, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$3:Ljava/lang/Object;

    check-cast v6, Ljava/io/File;

    .local v6, "file":Ljava/io/File;
    iget-object v5, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$2:Ljava/lang/Object;

    check-cast v5, Lkotlin/jvm/internal/Ref$ObjectRef;

    .local v5, "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$1:Ljava/lang/Object;

    check-cast v1, Lkotlin/jvm/internal/Ref$LongRef;

    move-object/from16 p1, v1

    .local p1, "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$0:Ljava/lang/Object;

    check-cast v1, Lkotlin/jvm/internal/Ref$LongRef;

    .local v1, "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :try_start_1
    invoke-static {v7}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-object/from16 v18, v4

    move-object v4, v7

    move-wide/from16 v23, v9

    move-object/from16 v21, v12

    move-object/from16 v19, v13

    move-object v9, v3

    move-object v3, v5

    move-object/from16 v5, p1

    move/from16 v27, v11

    move-object v11, v0

    move v0, v8

    move/from16 v8, v27

    goto/16 :goto_8

    .line 235
    .end local v1    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v3    # "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .end local v5    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v6    # "file":Ljava/io/File;
    .end local v8    # "$i$a$-let-FileSystemRepository$ossFileUpload$1$1":I
    .end local p1    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    :catch_0
    move-exception v0

    move-object v4, v7

    goto/16 :goto_c

    .line 151
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;
    .end local v7    # "$result":Ljava/lang/Object;
    :pswitch_2
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$3:Ljava/lang/Object;

    check-cast v1, Ljava/io/File;

    .local v1, "file":Ljava/io/File;
    iget-object v3, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$2:Ljava/lang/Object;

    check-cast v3, Lkotlin/jvm/internal/Ref$ObjectRef;

    .local v3, "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object v5, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$1:Ljava/lang/Object;

    check-cast v5, Lkotlin/jvm/internal/Ref$LongRef;

    .local v5, "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    iget-object v6, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$0:Ljava/lang/Object;

    check-cast v6, Lkotlin/jvm/internal/Ref$LongRef;

    .local v6, "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :try_start_2
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v7, v4

    check-cast v7, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v7
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3

    const/4 v9, 0x1

    move-object/from16 v27, v6

    move-object v6, v1

    move-object/from16 v1, v27

    goto/16 :goto_5

    .end local v1    # "file":Ljava/io/File;
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;
    .end local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v6    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :pswitch_3
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$3:Ljava/lang/Object;

    check-cast v1, Ljava/io/File;

    .restart local v1    # "file":Ljava/io/File;
    iget-object v3, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$2:Ljava/lang/Object;

    check-cast v3, Lkotlin/jvm/internal/Ref$ObjectRef;

    .restart local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    iget-object v5, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$1:Ljava/lang/Object;

    check-cast v5, Lkotlin/jvm/internal/Ref$LongRef;

    .restart local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    iget-object v6, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$0:Ljava/lang/Object;

    check-cast v6, Lkotlin/jvm/internal/Ref$LongRef;

    .restart local v6    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :try_start_3
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v7, v4

    check-cast v7, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v7
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    const/4 v9, 0x1

    goto/16 :goto_4

    .end local v1    # "file":Ljava/io/File;
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;
    .end local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v6    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :pswitch_4
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;
    move-object/from16 v4, p1

    .line 153
    .restart local v4    # "$result":Ljava/lang/Object;
    new-instance v1, Lkotlin/jvm/internal/Ref$LongRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$LongRef;-><init>()V

    move-object v6, v1

    .line 154
    .restart local v6    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    new-instance v1, Lkotlin/jvm/internal/Ref$LongRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$LongRef;-><init>()V

    move-object v5, v1

    .line 155
    .restart local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v3, v1

    .line 157
    .restart local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    nop

    .line 158
    :try_start_4
    new-instance v1, Ljava/io/File;

    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$filePath:Ljava/lang/String;

    invoke-direct {v1, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 159
    .restart local v1    # "file":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v7

    const/4 v8, -0x1

    if-eqz v7, :cond_10

    .line 160
    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v7}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v7

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v10, "\u6587\u4ef6\u5b58\u5728 \u5927\u5c0f\u662f\uff1a"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v1}, Ljava/io/File;->length()J

    move-result-wide v10

    invoke-virtual {v9, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v7, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 163
    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v7}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v7

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v10, "\u5f00\u59cb\u9884\u5148\u8ba1\u7b97\u6587\u4ef6MD5: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$filePath:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v7, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 164
    sget-object v7, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    invoke-virtual {v7, v1}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->generateMD5(Ljava/io/File;)Ljava/lang/String;

    move-result-object v7

    iput-object v7, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 165
    iget-object v7, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v7, Ljava/lang/CharSequence;

    if-eqz v7, :cond_1

    invoke-interface {v7}, Ljava/lang/CharSequence;->length()I

    move-result v7

    if-nez v7, :cond_0

    goto :goto_0

    :cond_0
    const/4 v7, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v7, 0x1

    :goto_1
    if-eqz v7, :cond_2

    .line 166
    .end local v1    # "file":Ljava/io/File;
    .end local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v6    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u9884\u5148\u8ba1\u7b97MD5\u5931\u8d25\uff0c\u6587\u4ef6\u53ef\u80fd\u65e0\u6cd5\u8bfb\u53d6"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 167
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    invoke-static {v8}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v1

    const-string/jumbo v3, "\u6587\u4ef6MD5\u8ba1\u7b97\u5931\u8d25"

    invoke-interface {v0, v1, v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 168
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 170
    .restart local v1    # "file":Ljava/io/File;
    .restart local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v6    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :cond_2
    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v7}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "\u9884\u5148\u8ba1\u7b97MD5\u6210\u529f: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v9, Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 172
    sget-object v7, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    invoke-virtual {v7, v1}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->readAlbumMeta(Ljava/io/File;)Lkotlin/Pair;

    move-result-object v7

    .line 173
    .local v7, "meta":Lkotlin/Pair;
    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v8}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "SyncNativeSuccess->readAlbumMeta->"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 174
    if-eqz v7, :cond_3

    .line 175
    invoke-virtual {v7}, Lkotlin/Pair;->getFirst()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Number;

    invoke-virtual {v8}, Ljava/lang/Number;->longValue()J

    move-result-wide v8

    iput-wide v8, v6, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 176
    invoke-virtual {v7}, Lkotlin/Pair;->getSecond()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Number;

    invoke-virtual {v8}, Ljava/lang/Number;->longValue()J

    move-result-wide v8

    iput-wide v8, v5, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    goto :goto_2

    .line 178
    :cond_3
    invoke-virtual {v1}, Ljava/io/File;->lastModified()J

    move-result-wide v8

    .line 179
    .local v8, "t":J
    iput-wide v8, v6, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 180
    iput-wide v8, v5, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 183
    .end local v8    # "t":J
    :goto_2
    new-instance v8, Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v9

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ".json"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v8, v9, v10}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 184
    .local v8, "metaFile":Ljava/io/File;
    invoke-virtual {v8}, Ljava/io/File;->exists()Z

    move-result v9

    if-eqz v9, :cond_4

    .line 185
    invoke-virtual {v8}, Ljava/io/File;->delete()Z

    .line 188
    .end local v8    # "metaFile":Ljava/io/File;
    :cond_4
    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v8}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "ossFileUpload fileStartTime\uff1a"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-wide v10, v6, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    invoke-virtual {v9, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " fileEndTime:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-wide v10, v5, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    invoke-virtual {v9, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v9

    if-nez v7, :cond_5

    const/4 v7, 0x1

    goto :goto_3

    .end local v7    # "meta":Lkotlin/Pair;
    :cond_5
    const/4 v7, 0x0

    :goto_3
    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v8, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 195
    iget-boolean v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$isLog:Z

    if-eqz v7, :cond_7

    .line 196
    new-instance v7, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$ret$1;

    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v9, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$category:Ljava/lang/String;

    invoke-direct {v7, v8, v9}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$ret$1;-><init>(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/lang/String;)V

    check-cast v7, Lkotlin/jvm/functions/Function0;

    move-object v8, v2

    check-cast v8, Lkotlin/coroutines/Continuation;

    iput-object v6, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$0:Ljava/lang/Object;

    iput-object v5, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$1:Ljava/lang/Object;

    iput-object v3, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$2:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$3:Ljava/lang/Object;

    const/4 v9, 0x1

    iput v9, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->label:I

    invoke-static {v7, v8}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v7

    if-ne v7, v0, :cond_6

    .line 151
    return-object v0

    .line 196
    :cond_6
    :goto_4
    move-object/from16 v27, v6

    move-object v6, v1

    move-object/from16 v1, v27

    goto :goto_5

    .line 198
    :cond_7
    const/4 v9, 0x1

    new-instance v7, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$ret$2;

    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v10, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$category:Ljava/lang/String;

    invoke-direct {v7, v8, v10}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$ret$2;-><init>(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/lang/String;)V

    check-cast v7, Lkotlin/jvm/functions/Function0;

    move-object v8, v2

    check-cast v8, Lkotlin/coroutines/Continuation;

    iput-object v6, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$0:Ljava/lang/Object;

    iput-object v5, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$1:Ljava/lang/Object;

    iput-object v3, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$2:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$3:Ljava/lang/Object;

    const/4 v10, 0x2

    iput v10, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->label:I

    invoke-static {v7, v8}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v7
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3

    if-ne v7, v0, :cond_8

    .line 151
    return-object v0

    .line 198
    :cond_8
    move-object/from16 v27, v6

    move-object v6, v1

    move-object/from16 v1, v27

    .local v1, "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .local v6, "file":Ljava/io/File;
    :goto_5
    nop

    .line 195
    nop

    .line 201
    .local v7, "ret":Ljava/lang/Object;
    :try_start_5
    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v8}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v8

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "ossFileUpload "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-static {v7}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    const/16 v11, 0x20

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    filled-new-array {v10}, [Ljava/lang/Object;

    move-result-object v10

    invoke-static {v8, v10}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 202
    invoke-static {v7}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_f

    const/4 v8, 0x0

    .line 468
    .local v8, "$i$f$getOrNull-impl":I
    nop

    .line 469
    invoke-static {v7}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_9

    const/4 v10, 0x0

    goto :goto_6

    .line 470
    :cond_9
    move-object v10, v7

    .line 471
    :goto_6
    nop

    .line 202
    .end local v8    # "$i$f$getOrNull-impl":I
    if-eqz v10, :cond_f

    .line 203
    const/4 v8, 0x0

    .line 472
    .restart local v8    # "$i$f$getOrNull-impl":I
    nop

    .line 473
    invoke-static {v7}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_a

    const/4 v7, 0x0

    goto :goto_7

    .line 474
    :cond_a
    nop

    .line 475
    .end local v7    # "ret":Ljava/lang/Object;
    :goto_7
    nop

    .line 203
    .end local v8    # "$i$f$getOrNull-impl":I
    check-cast v7, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    .line 204
    .local v7, "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    if-eqz v7, :cond_e

    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v15, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$filePath:Ljava/lang/String;

    iget-boolean v10, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$isLog:Z

    iget-object v14, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$onProgressChanged:Lkotlin/jvm/functions/Function1;

    iget-object v13, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iget-object v12, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$tag:Ljava/lang/String;

    move/from16 p1, v10

    iget-wide v9, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$captureTime:J

    move-object/from16 v16, v7

    .local v16, "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    const/16 v17, 0x0

    .line 205
    .local v17, "$i$a$-let-FileSystemRepository$ossFileUpload$1$1":I
    invoke-static {v8}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v11
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2

    move-object/from16 v19, v4

    .end local v4    # "$result":Ljava/lang/Object;
    .local v19, "$result":Ljava/lang/Object;
    :try_start_6
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v20, v0

    const-string v0, "OSS STS info: "

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual/range {v16 .. v16}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getRegion()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v4, 0x20

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual/range {v16 .. v16}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getBucket()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    .end local v16    # "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    invoke-static {v11, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 206
    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$0:Ljava/lang/Object;

    iput-object v5, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$1:Ljava/lang/Object;

    iput-object v3, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$2:Ljava/lang/Object;

    iput-object v6, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$3:Ljava/lang/Object;

    iput-object v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$4:Ljava/lang/Object;

    iput-object v8, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$5:Ljava/lang/Object;

    iput-object v15, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$6:Ljava/lang/Object;

    iput-object v14, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$7:Ljava/lang/Object;

    iput-object v13, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$8:Ljava/lang/Object;

    iput-object v12, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$9:Ljava/lang/Object;

    move/from16 v0, p1

    iput-boolean v0, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->Z$0:Z

    iput-wide v9, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->J$0:J

    const/4 v4, 0x3

    iput v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->label:I

    invoke-static {v8, v6, v7, v2}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$uploadVideoThumbnailByOss(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/io/File;Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v4
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    move-object/from16 v11, v20

    if-ne v4, v11, :cond_b

    .line 151
    return-object v11

    .line 206
    :cond_b
    move-object/from16 v18, v8

    move-wide/from16 v23, v9

    move-object/from16 v21, v12

    move v8, v0

    move-object v9, v7

    move/from16 v0, v17

    move-object v7, v4

    move-object/from16 v4, v19

    move-object/from16 v19, v13

    .line 151
    .end local v7    # "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .end local v17    # "$i$a$-let-FileSystemRepository$ossFileUpload$1$1":I
    .end local v19    # "$result":Ljava/lang/Object;
    .restart local v0    # "$i$a$-let-FileSystemRepository$ossFileUpload$1$1":I
    .restart local v4    # "$result":Ljava/lang/Object;
    .local v9, "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    :goto_8
    :try_start_7
    move-object/from16 v22, v7

    check-cast v22, Ljava/lang/String;

    .line 208
    .local v22, "thumbnailsObjectKey":Ljava/lang/String;
    sget-object v7, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;

    new-instance v10, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$1;

    invoke-direct {v10, v14}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$1;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast v10, Lkotlin/jvm/functions/Function1;

    new-instance v12, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;

    move-object/from16 v16, v12

    move-object/from16 v17, v3

    move-object/from16 v20, v6

    move-object/from16 v25, v1

    move-object/from16 v26, v5

    invoke-direct/range {v16 .. v26}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Ljava/io/File;Ljava/lang/String;Ljava/lang/String;JLkotlin/jvm/internal/Ref$LongRef;Lkotlin/jvm/internal/Ref$LongRef;)V

    move-object/from16 v20, v12

    check-cast v20, Lkotlin/jvm/functions/Function3;

    .line 230
    .end local v1    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v6    # "file":Ljava/io/File;
    .end local v9    # "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .end local v22    # "thumbnailsObjectKey":Ljava/lang/String;
    if-eqz v8, :cond_c

    const/16 v21, 0x1

    goto :goto_9

    :cond_c
    const/16 v21, 0x0

    .line 208
    :goto_9
    const/4 v1, 0x0

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$0:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$1:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$2:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$3:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$4:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$5:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$6:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$7:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$8:Ljava/lang/Object;

    iput-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->L$9:Ljava/lang/Object;

    const/4 v1, 0x4

    iput v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->label:I

    move-object/from16 v16, v7

    move-object/from16 v17, v9

    move-object/from16 v18, v15

    move-object/from16 v19, v10

    move-object/from16 v22, v2

    invoke-virtual/range {v16 .. v22}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->ossUpload(Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function3;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v1
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3

    if-ne v1, v11, :cond_d

    .line 151
    return-object v11

    .line 231
    :cond_d
    :goto_a
    nop

    .line 204
    .end local v0    # "$i$a$-let-FileSystemRepository$ossFileUpload$1$1":I
    goto :goto_d

    .restart local v1    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v6    # "file":Ljava/io/File;
    .restart local v7    # "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    :cond_e
    move-object/from16 v19, v4

    .end local v1    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v6    # "file":Ljava/io/File;
    .end local v7    # "data":Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .restart local v19    # "$result":Ljava/lang/Object;
    goto :goto_b

    .line 202
    .end local v19    # "$result":Ljava/lang/Object;
    .restart local v1    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v6    # "file":Ljava/io/File;
    .local v7, "ret":Ljava/lang/Object;
    :cond_f
    move-object/from16 v19, v4

    .line 233
    .end local v1    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v6    # "file":Ljava/io/File;
    .end local v7    # "ret":Ljava/lang/Object;
    .restart local v19    # "$result":Ljava/lang/Object;
    :try_start_8
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    const/4 v1, -0x3

    invoke-static {v1}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v3

    const-string v1, "StsToken \u8c03\u7528\u5931\u8d25"

    invoke-interface {v0, v3, v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_1

    .line 239
    :goto_b
    move-object/from16 v4, v19

    goto :goto_d

    .line 235
    :catch_1
    move-exception v0

    move-object/from16 v4, v19

    goto :goto_c

    .end local v19    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    :catch_2
    move-exception v0

    move-object/from16 v19, v4

    .end local v4    # "$result":Ljava/lang/Object;
    .restart local v19    # "$result":Ljava/lang/Object;
    goto :goto_c

    .line 190
    .end local v19    # "$result":Ljava/lang/Object;
    .local v1, "file":Ljava/io/File;
    .restart local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .local v6, "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :cond_10
    :try_start_9
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v0

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "\u6587\u4ef6\u4e0d\u5b58\u5728 filePath\uff1a"

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v9, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$filePath:Ljava/lang/String;

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v0, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 191
    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    invoke-static {v8}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v7

    const-string/jumbo v8, "\u6587\u4ef6\u4e0d\u5b58\u5728"

    invoke-interface {v0, v7, v8}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 192
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_3

    return-object v0

    .line 235
    .end local v1    # "file":Ljava/io/File;
    .end local v3    # "preCalculatedMd5":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v5    # "fileEndTime":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v6    # "fileStartTime":Lkotlin/jvm/internal/Ref$LongRef;
    :catch_3
    move-exception v0

    .line 236
    .local v0, "e":Ljava/lang/Exception;
    :goto_c
    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    const/4 v3, -0x3

    invoke-static {v3}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ossFileUpload \u8c03\u7528\u5931\u8d25 "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v1, v3, v5}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 239
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_d
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
