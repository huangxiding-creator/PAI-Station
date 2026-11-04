.class final Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;
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
    c = "com.rokid.security.phone.sdk.server.filesystem.repository.FileSystemRepository$uploadVideoThumbnailByMinio$3"
    f = "FileSystemRepository.kt"
    i = {}
    l = {
        0x1b9
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
.method constructor <init>(Ljava/io/File;Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->$file:Ljava/io/File;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->$data:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->$thumbnailsObjectKey:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

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

    new-instance v6, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->$file:Ljava/io/File;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->$data:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->$thumbnailsObjectKey:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    move-object v0, v6

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;-><init>(Ljava/io/File;Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/coroutines/Continuation;

    return-object v6
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 14

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 437
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;
    .local p1, "$result":Ljava/lang/Object;
    const/4 v1, 0x0

    .local v1, "$i$a$-let-FileSystemRepository$uploadVideoThumbnailByMinio$3$1":I
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_0

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;
    .end local v1    # "$i$a$-let-FileSystemRepository$uploadVideoThumbnailByMinio$3$1":I
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 438
    .local v1, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;
    .restart local p1    # "$result":Ljava/lang/Object;
    sget-object v2, Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;

    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object v3

    const-string v4, "getApplicationContext()"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v3, Landroid/content/Context;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->$file:Ljava/io/File;

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    const-string v5, "file.absolutePath"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2, v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;->generateThumbnail(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 439
    .local v11, "thumbnailPath":Ljava/lang/String;
    if-eqz v11, :cond_2

    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->$data:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->$thumbnailsObjectKey:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    move-object v12, v11

    .local v12, "bitmapFilePath":Ljava/lang/String;
    const/4 v13, 0x0

    .line 440
    .local v13, "$i$a$-let-FileSystemRepository$uploadVideoThumbnailByMinio$3$1":I
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v12}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 441
    sget-object v5, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;

    new-instance v6, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3$1$1;

    invoke-direct {v6, v2, v11, v4, v12}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3$1$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/lang/String;)V

    check-cast v6, Lkotlin/jvm/functions/Function3;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3$1$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3$1$2;

    move-object v7, v2

    check-cast v7, Lkotlin/jvm/functions/Function2;

    const/4 v2, 0x1

    iput v2, v1, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;->label:I

    const/4 v8, 0x0

    const/16 v9, 0x10

    const/4 v10, 0x0

    move-object v2, v5

    move-object v4, v12

    move-object v5, v6

    move-object v6, v7

    move v7, v8

    move-object v8, v1

    invoke-static/range {v2 .. v10}, Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;->uploadFile$default(Lcom/rokid/security/phone/sdk/server/filesystem/MinioCoreUtil;Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function2;ZLkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .end local v11    # "thumbnailPath":Ljava/lang/String;
    .end local v12    # "bitmapFilePath":Ljava/lang/String;
    if-ne v2, v0, :cond_0

    .line 437
    return-object v0

    .line 441
    :cond_0
    move-object v0, v1

    move v1, v13

    .line 460
    .end local v13    # "$i$a$-let-FileSystemRepository$uploadVideoThumbnailByMinio$3$1":I
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;
    .local v1, "$i$a$-let-FileSystemRepository$uploadVideoThumbnailByMinio$3$1":I
    :goto_0
    move-object v1, v0

    .line 439
    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;
    .local v1, "this":Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByMinio$3;
    :cond_1
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_1

    :cond_2
    const/4 v0, 0x0

    :goto_1
    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
