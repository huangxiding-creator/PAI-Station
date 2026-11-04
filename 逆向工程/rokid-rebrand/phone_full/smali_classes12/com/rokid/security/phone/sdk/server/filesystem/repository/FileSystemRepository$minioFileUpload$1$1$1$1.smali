.class final Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FileSystemRepository.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1;->invoke(JLjava/lang/String;Ljava/lang/String;)V
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
    value = "SMAP\nFileSystemRepository.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FileSystemRepository.kt\ncom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult\n*L\n1#1,467:1\n42#2,4:468\n42#2,4:472\n42#2,4:476\n*S KotlinDebug\n*F\n+ 1 FileSystemRepository.kt\ncom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1\n*L\n302#1:468,4\n303#1:472,4\n304#1:476,4\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.filesystem.repository.FileSystemRepository$minioFileUpload$1$1$1$1"
    f = "FileSystemRepository.kt"
    i = {}
    l = {
        0x129
    }
    m = "invokeSuspend"
    n = {}
    s = {}
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

.field final synthetic $file:Ljava/io/File;

.field final synthetic $fileEndTime:Lkotlin/jvm/internal/Ref$LongRef;

.field final synthetic $fileSize:J

.field final synthetic $fileStartTime:Lkotlin/jvm/internal/Ref$LongRef;

.field final synthetic $md5:Ljava/lang/String;

.field final synthetic $objectKey:Ljava/lang/String;

.field final synthetic $preCalculatedMd5:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $tag:Ljava/lang/String;

.field final synthetic $thumbnailsObjectKey:Ljava/lang/String;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Ljava/io/File;Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;JLkotlin/jvm/internal/Ref$LongRef;Lkotlin/jvm/internal/Ref$LongRef;Lkotlin/coroutines/Continuation;)V
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
            ">;",
            "Ljava/io/File;",
            "Ljava/lang/String;",
            "J",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "J",
            "Lkotlin/jvm/internal/Ref$LongRef;",
            "Lkotlin/jvm/internal/Ref$LongRef;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;",
            ">;)V"
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    iput-object v1, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$preCalculatedMd5:Lkotlin/jvm/internal/Ref$ObjectRef;

    move-object/from16 v2, p2

    iput-object v2, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$md5:Ljava/lang/String;

    move-object/from16 v3, p3

    iput-object v3, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    move-object/from16 v4, p4

    iput-object v4, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    move-object/from16 v5, p5

    iput-object v5, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$file:Ljava/io/File;

    move-object/from16 v6, p6

    iput-object v6, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$tag:Ljava/lang/String;

    move-wide/from16 v7, p7

    iput-wide v7, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$fileSize:J

    move-object/from16 v9, p9

    iput-object v9, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$objectKey:Ljava/lang/String;

    move-object/from16 v10, p10

    iput-object v10, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$thumbnailsObjectKey:Ljava/lang/String;

    move-wide/from16 v11, p11

    iput-wide v11, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$captureTime:J

    move-object/from16 v13, p13

    iput-object v13, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$fileStartTime:Lkotlin/jvm/internal/Ref$LongRef;

    move-object/from16 v14, p14

    iput-object v14, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$fileEndTime:Lkotlin/jvm/internal/Ref$LongRef;

    const/4 v15, 0x2

    move-object/from16 v1, p15

    invoke-direct {v0, v15, v1}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 18
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

    move-object/from16 v0, p0

    new-instance v17, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$preCalculatedMd5:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$md5:Ljava/lang/String;

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v5, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iget-object v6, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$file:Ljava/io/File;

    iget-object v7, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$tag:Ljava/lang/String;

    iget-wide v8, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$fileSize:J

    iget-object v10, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$objectKey:Ljava/lang/String;

    iget-object v11, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$thumbnailsObjectKey:Ljava/lang/String;

    iget-wide v12, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$captureTime:J

    iget-object v14, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$fileStartTime:Lkotlin/jvm/internal/Ref$LongRef;

    iget-object v15, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$fileEndTime:Lkotlin/jvm/internal/Ref$LongRef;

    move-object/from16 v1, v17

    move-object/from16 v16, p2

    invoke-direct/range {v1 .. v16}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Ljava/io/File;Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;JLkotlin/jvm/internal/Ref$LongRef;Lkotlin/jvm/internal/Ref$LongRef;Lkotlin/coroutines/Continuation;)V

    check-cast v17, Lkotlin/coroutines/Continuation;

    return-object v17
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 19

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 292
    move-object/from16 v1, p0

    iget v2, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->label:I

    packed-switch v2, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;
    move-object/from16 v2, p1

    .local v2, "$result":Ljava/lang/Object;
    invoke-static {v2}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v3, v2

    check-cast v3, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v3

    goto/16 :goto_1

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;
    .end local v2    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v2, p0

    .local v2, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;
    move-object/from16 v3, p1

    .line 294
    .local v3, "$result":Ljava/lang/Object;
    iget-object v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$preCalculatedMd5:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v4, v4, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v4, Ljava/lang/String;

    if-nez v4, :cond_0

    iget-object v4, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$md5:Ljava/lang/String;

    .line 295
    .local v4, "finalMd5":Ljava/lang/String;
    :cond_0
    iget-object v5, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "\u4f7f\u7528MD5: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " (preCalculated="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$preCalculatedMd5:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v7, v7, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    if-eqz v7, :cond_1

    const/4 v7, 0x1

    goto :goto_0

    :cond_1
    const/4 v7, 0x0

    :goto_0
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const/16 v7, 0x29

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 297
    new-instance v18, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;

    iget-object v6, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$file:Ljava/io/File;

    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$tag:Ljava/lang/String;

    iget-wide v9, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$fileSize:J

    iget-object v11, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$objectKey:Ljava/lang/String;

    iget-object v13, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$thumbnailsObjectKey:Ljava/lang/String;

    iget-wide v14, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$captureTime:J

    iget-object v12, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$fileStartTime:Lkotlin/jvm/internal/Ref$LongRef;

    iget-object v5, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$fileEndTime:Lkotlin/jvm/internal/Ref$LongRef;

    move-object/from16 v17, v5

    move-object/from16 v5, v18

    move-object/from16 v16, v12

    move-object v12, v4

    const/4 v1, 0x1

    invoke-direct/range {v5 .. v17}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;-><init>(Ljava/io/File;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;JLkotlin/jvm/internal/Ref$LongRef;Lkotlin/jvm/internal/Ref$LongRef;)V

    move-object/from16 v5, v18

    check-cast v5, Lkotlin/jvm/functions/Function0;

    move-object v6, v2

    check-cast v6, Lkotlin/coroutines/Continuation;

    iput v1, v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->label:I

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2Kt;->api2Call(Lkotlin/jvm/functions/Function0;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v1

    .end local v4    # "finalMd5":Ljava/lang/String;
    if-ne v1, v0, :cond_2

    .line 292
    return-object v0

    .line 297
    :cond_2
    move-object v0, v2

    move-object v2, v3

    move-object v3, v1

    .end local v3    # "$result":Ljava/lang/Object;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;
    .local v2, "$result":Ljava/lang/Object;
    :goto_1
    move-object v1, v3

    .line 302
    .local v1, "ret":Ljava/lang/Object;
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_9

    const/4 v3, 0x0

    .line 468
    .local v3, "$i$f$getOrNull-impl":I
    nop

    .line 469
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v4

    const/4 v5, 0x0

    if-eqz v4, :cond_3

    move-object v4, v5

    goto :goto_2

    .line 470
    :cond_3
    move-object v4, v1

    .line 471
    :goto_2
    nop

    .line 302
    .end local v3    # "$i$f$getOrNull-impl":I
    if-eqz v4, :cond_9

    .line 303
    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\u4fdd\u5b58minio\u4e0a\u4f20\u4fe1\u606f\u5b8c\u6210 "

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/4 v6, 0x0

    .line 472
    .local v6, "$i$f$getOrNull-impl":I
    nop

    .line 473
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    move-object v7, v5

    goto :goto_3

    .line 474
    :cond_4
    move-object v7, v1

    .line 475
    :goto_3
    nop

    .line 303
    .end local v6    # "$i$f$getOrNull-impl":I
    check-cast v7, Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;

    if-eqz v7, :cond_5

    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;->getId()Ljava/lang/String;

    move-result-object v6

    goto :goto_4

    :cond_5
    move-object v6, v5

    :goto_4
    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/16 v6, 0x3a

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    const/4 v6, 0x0

    .line 472
    .restart local v6    # "$i$f$getOrNull-impl":I
    nop

    .line 473
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_6

    move-object v7, v5

    goto :goto_5

    .line 474
    :cond_6
    move-object v7, v1

    .line 475
    :goto_5
    nop

    .line 303
    .end local v6    # "$i$f$getOrNull-impl":I
    check-cast v7, Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;

    if-eqz v7, :cond_7

    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;->getUrl()Ljava/lang/String;

    move-result-object v6

    goto :goto_6

    :cond_7
    move-object v6, v5

    :goto_6
    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 304
    const/4 v3, 0x0

    .line 476
    .restart local v3    # "$i$f$getOrNull-impl":I
    nop

    .line 477
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_8

    move-object v1, v5

    goto :goto_7

    .line 478
    :cond_8
    nop

    .line 479
    .end local v1    # "ret":Ljava/lang/Object;
    :goto_7
    nop

    .line 304
    .end local v3    # "$i$f$getOrNull-impl":I
    check-cast v1, Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;

    if-eqz v1, :cond_a

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .local v1, "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;
    const/4 v4, 0x0

    .line 305
    .local v4, "$i$a$-let-FileSystemRepository$minioFileUpload$1$1$1$1$1":I
    invoke-interface {v3, v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onSuccess(Ljava/lang/Object;)V

    .line 306
    nop

    .line 304
    .end local v1    # "it":Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;
    .end local v4    # "$i$a$-let-FileSystemRepository$minioFileUpload$1$1$1$1$1":I
    goto :goto_8

    .line 308
    :cond_9
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    const/4 v3, -0x2

    invoke-static {v3}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v3

    const-string v4, "minio\u4e0a\u4f20\u4fe1\u606f\u5931\u8d25"

    invoke-interface {v1, v3, v4}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 310
    :cond_a
    :goto_8
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
