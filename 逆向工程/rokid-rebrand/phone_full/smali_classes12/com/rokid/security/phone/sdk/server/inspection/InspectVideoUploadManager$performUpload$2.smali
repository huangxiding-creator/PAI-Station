.class final Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "InspectVideoUploadManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->performUpload(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
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
    c = "com.rokid.security.phone.sdk.server.inspection.InspectVideoUploadManager$performUpload$2"
    f = "InspectVideoUploadManager.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $item:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;",
            "Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$item:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$item:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    invoke-direct {v0, v1, v2, v3, p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 14

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 90
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 91
    .local v0, "this":Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;
    .local p1, "$result":Ljava/lang/Object;
    new-instance v1, Ljava/io/File;

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$item:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getFilePath()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 92
    .local v1, "file":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    const/4 v3, -0x1

    if-nez v2, :cond_0

    .line 93
    .end local v1    # "file":Ljava/io/File;
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u26a0\ufe0f File not found: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$item:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getFilePath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 94
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$item:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$removeFromQueue(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;)V

    .line 95
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    invoke-static {v3}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "File not found"

    invoke-interface {v1, v2, v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 96
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    .line 100
    .restart local v1    # "file":Ljava/io/File;
    :cond_0
    sget-object v2, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v2

    .line 101
    .local v2, "headers":Ljava/util/concurrent/ConcurrentHashMap;
    const-string/jumbo v4, "x-user-authorization"

    invoke-virtual {v2, v4}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    const/4 v6, 0x1

    if-eqz v4, :cond_2

    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v4

    if-nez v4, :cond_1

    goto :goto_0

    :cond_1
    move v4, v5

    goto :goto_1

    :cond_2
    :goto_0
    move v4, v6

    :goto_1
    xor-int/2addr v4, v6

    .line 102
    .local v4, "hasUser":Z
    const-string/jumbo v7, "x-app-authorization"

    invoke-virtual {v2, v7}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/CharSequence;

    if-eqz v7, :cond_4

    invoke-interface {v7}, Ljava/lang/CharSequence;->length()I

    move-result v7

    if-nez v7, :cond_3

    goto :goto_2

    :cond_3
    move v7, v5

    goto :goto_3

    :cond_4
    :goto_2
    move v7, v6

    :goto_3
    xor-int/2addr v7, v6

    .line 103
    .local v7, "hasApp":Z
    const-string v8, "X-Agent"

    invoke-virtual {v2, v8}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/CharSequence;

    .end local v2    # "headers":Ljava/util/concurrent/ConcurrentHashMap;
    if-eqz v8, :cond_6

    invoke-interface {v8}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_5

    goto :goto_4

    :cond_5
    move v2, v5

    goto :goto_5

    :cond_6
    :goto_4
    move v2, v6

    :goto_5
    xor-int/2addr v2, v6

    .line 104
    .local v2, "hasAgent":Z
    if-eqz v7, :cond_9

    if-nez v2, :cond_7

    goto :goto_7

    .line 114
    .end local v2    # "hasAgent":Z
    .end local v4    # "hasUser":Z
    .end local v7    # "hasApp":Z
    :cond_7
    const-string v2, "inspection_video"

    .line 115
    .local v2, "tag":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/io/File;->lastModified()J

    move-result-wide v3

    .line 117
    .local v3, "fileTime":J
    iget-object v5, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Ljava/lang/String;

    move-result-object v5

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Uploading "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " for session "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$item:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getSessionId()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v5, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 118
    .end local v1    # "file":Ljava/io/File;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->useMinio()Z

    move-result v1

    if-eqz v1, :cond_8

    .line 119
    sget-object v8, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$item:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getFilePath()Ljava/lang/String;

    move-result-object v9

    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$item:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getSessionId()Ljava/lang/String;

    move-result-object v11

    move-object v10, v2

    move-wide v12, v3

    invoke-virtual/range {v8 .. v13}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->minioFileUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    goto :goto_6

    .line 121
    :cond_8
    sget-object v8, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$item:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getFilePath()Ljava/lang/String;

    move-result-object v9

    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$item:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getSessionId()Ljava/lang/String;

    move-result-object v11

    move-object v10, v2

    move-wide v12, v3

    invoke-virtual/range {v8 .. v13}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->ossFileUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    .line 123
    .end local v2    # "tag":Ljava/lang/String;
    .end local v3    # "fileTime":J
    :goto_6
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    invoke-static {v6}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-interface {v1, v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onSuccess(Ljava/lang/Object;)V

    .line 124
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    .line 106
    .local v2, "hasAgent":Z
    .restart local v4    # "hasUser":Z
    .restart local v7    # "hasApp":Z
    :cond_9
    :goto_7
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Ljava/lang/String;

    move-result-object v1

    .line 107
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "\u23f8\ufe0f SDK headers not ready, delay upload. hasUser="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    if-eqz v4, :cond_a

    move v4, v6

    goto :goto_8

    :cond_a
    move v4, v5

    .end local v4    # "hasUser":Z
    :goto_8
    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v8, " hasApp="

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    if-eqz v7, :cond_b

    move v7, v6

    goto :goto_9

    :cond_b
    move v7, v5

    .end local v7    # "hasApp":Z
    :goto_9
    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v7, " hasAgent="

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    if-eqz v2, :cond_c

    move v5, v6

    nop

    .end local v2    # "hasAgent":Z
    :cond_c
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 105
    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 109
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    invoke-static {v3}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "SDK headers not ready"

    invoke-interface {v1, v2, v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 111
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
