.class final Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FileSystemRepository.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->uploadVideoThumbnailByMinio(Ljava/io/File;Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
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
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u0004\u0018\u00010\u0001*\u00020\u0002H\u008a@"
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
    c = "com.rokid.security.phone.sdk.server.filesystem.repository.FileSystemRepository$uploadVideoThumbnailByMinio$2"
    f = "FileSystemRepository.kt"
    i = {}
    l = {
        0x19e
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $data:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

.field final synthetic $file:Ljava/io/File;

.field final synthetic $thumbnailsObjectKey:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;


# direct methods
.method constructor <init>(Ljava/io/File;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->$file:Ljava/io/File;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->$data:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->$thumbnailsObjectKey:Lkotlin/jvm/internal/Ref$ObjectRef;

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

    new-instance v6, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->$file:Ljava/io/File;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->$data:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->$thumbnailsObjectKey:Lkotlin/jvm/internal/Ref$ObjectRef;

    move-object v0, v6

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;-><init>(Ljava/io/File;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/coroutines/Continuation;

    return-object v6
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 14

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 404
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;
    .local p1, "$result":Ljava/lang/Object;
    const/4 v1, 0x0

    .local v1, "$i$a$-let-FileSystemRepository$uploadVideoThumbnailByMinio$2$1":I
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_0

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;
    .end local v1    # "$i$a$-let-FileSystemRepository$uploadVideoThumbnailByMinio$2$1":I
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 405
    .local v1, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;
    .restart local p1    # "$result":Ljava/lang/Object;
    sget-object v2, Lcom/rokid/security/phone/sdk/base/utils/other/VideoThumbnailUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/VideoThumbnailUtils;

    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->$file:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    const-string v4, "file.absolutePath"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/other/VideoThumbnailUtils;->getVideoFirstFrame(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v2

    .line 406
    .local v2, "bitmap":Landroid/graphics/Bitmap;
    if-eqz v2, :cond_4

    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->$file:Ljava/io/File;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->$data:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->$thumbnailsObjectKey:Lkotlin/jvm/internal/Ref$ObjectRef;

    .local v2, "it":Landroid/graphics/Bitmap;
    const/4 v11, 0x0

    .line 407
    .local v11, "$i$a$-let-FileSystemRepository$uploadVideoThumbnailByMinio$2$1":I
    new-instance v7, Ljava/io/File;

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v8

    invoke-virtual {v8}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/utils/MD5Util;->MD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v9, "_thumb.jpg"

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v7, v8, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    move-object v12, v7

    .line 408
    .local v12, "bitmapFile":Ljava/io/File;
    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v3

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v8, "uploadVideoThumbnailByMinio bitmapFile "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v12}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v3, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 409
    const/4 v3, 0x0

    .line 410
    .local v3, "saved":Z
    invoke-virtual {v12}, Ljava/io/File;->exists()Z

    move-result v7

    if-nez v7, :cond_0

    .line 411
    .end local v3    # "saved":Z
    sget-object v3, Lcom/rokid/security/phone/sdk/base/utils/other/VideoThumbnailUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/VideoThumbnailUtils;

    invoke-virtual {v3, v2, v12}, Lcom/rokid/security/phone/sdk/base/utils/other/VideoThumbnailUtils;->saveBitmapToFile(Landroid/graphics/Bitmap;Ljava/io/File;)Z

    move-result v3

    .line 413
    .end local v2    # "it":Landroid/graphics/Bitmap;
    .restart local v3    # "saved":Z
    :cond_0
    if-nez v3, :cond_1

    invoke-virtual {v12}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 414
    .end local v3    # "saved":Z
    :cond_1
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

    invoke-virtual {v12}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    const-string v3, "bitmapFile.absolutePath"

    invoke-static {v7, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2$1$1;

    invoke-direct {v3, v6, v12, v4}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2$1$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/io/File;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)V

    move-object v6, v3

    check-cast v6, Lkotlin/jvm/functions/Function3;

    sget-object v3, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2$1$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2$1$2;

    move-object v8, v3

    check-cast v8, Lkotlin/jvm/functions/Function2;

    const/4 v3, 0x1

    iput v3, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;->label:I

    const/4 v9, 0x0

    const/16 v10, 0x10

    const/4 v13, 0x0

    move-object v3, v5

    move-object v4, v7

    move-object v5, v6

    move-object v6, v8

    move v7, v9

    move-object v8, v1

    move v9, v10

    move-object v10, v13

    invoke-static/range {v2 .. v10}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->uploadFile$default(Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function2;ZLkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .end local v12    # "bitmapFile":Ljava/io/File;
    if-ne v2, v0, :cond_2

    .line 404
    return-object v0

    .line 414
    :cond_2
    move-object v0, v1

    move v1, v11

    .line 433
    .end local v11    # "$i$a$-let-FileSystemRepository$uploadVideoThumbnailByMinio$2$1":I
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;
    .local v1, "$i$a$-let-FileSystemRepository$uploadVideoThumbnailByMinio$2$1":I
    :goto_0
    move-object v1, v0

    .line 406
    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;
    .local v1, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$2;
    :cond_3
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_1

    :cond_4
    const/4 v0, 0x0

    :goto_1
    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
