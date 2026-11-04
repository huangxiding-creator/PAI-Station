.class final Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FileDownloadServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->getDownloadFileApi(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/filedownload/AppDownloadInfo;
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
    c = "com.rokid.security.phone.sdk.server.filedownload.FileDownloadServiceImpl$getDownloadFileApi$1"
    f = "FileDownloadServiceImpl.kt"
    i = {}
    l = {
        0x1c
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $deferred:Lkotlinx/coroutines/CompletableDeferred;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/CompletableDeferred<",
            "Lcom/rokid/security/sdk/base/common/filedownload/AppDownloadInfo;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $url:Ljava/lang/String;

.field label:I


# direct methods
.method constructor <init>(Ljava/lang/String;Lkotlinx/coroutines/CompletableDeferred;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlinx/coroutines/CompletableDeferred<",
            "Lcom/rokid/security/sdk/base/common/filedownload/AppDownloadInfo;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->$url:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->$deferred:Lkotlinx/coroutines/CompletableDeferred;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p3}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 3
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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->$url:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->$deferred:Lkotlinx/coroutines/CompletableDeferred;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;-><init>(Ljava/lang/String;Lkotlinx/coroutines/CompletableDeferred;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 7

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 26
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;
    .local p1, "$result":Ljava/lang/Object;
    :try_start_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v0

    move-object v0, p1

    goto :goto_0

    .line 34
    :catch_0
    move-exception v1

    goto/16 :goto_2

    .line 26
    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 27
    .local v1, "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    nop

    .line 28
    :try_start_1
    sget-object v2, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->getApi()Lcom/rokid/security/phone/sdk/server/net/ApiService;

    move-result-object v2

    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->$url:Ljava/lang/String;

    invoke-interface {v2, v3}, Lcom/rokid/security/phone/sdk/server/net/ApiService;->getAppDownloadInfo(Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v2

    move-object v3, v1

    check-cast v3, Lkotlin/coroutines/Continuation;

    const/4 v4, 0x1

    iput v4, v1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->label:I

    invoke-static {v2, v3}, Lkotlinx/coroutines/flow/FlowKt;->first(Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    if-ne v2, v0, :cond_0

    .line 26
    return-object v0

    .line 28
    :cond_0
    move-object v0, p1

    move-object p1, v2

    .line 26
    .end local p1    # "$result":Ljava/lang/Object;
    .local v0, "$result":Ljava/lang/Object;
    :goto_0
    :try_start_2
    check-cast p1, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;

    .line 29
    .local p1, "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v2

    if-nez v2, :cond_2

    :cond_1
    goto :goto_1

    :cond_2
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 30
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->$deferred:Lkotlinx/coroutines/CompletableDeferred;

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-interface {v2, v3}, Lkotlinx/coroutines/CompletableDeferred;->complete(Ljava/lang/Object;)Z

    goto :goto_3

    .line 32
    :goto_1
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->$deferred:Lkotlinx/coroutines/CompletableDeferred;

    new-instance v3, Ljava/lang/RuntimeException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Server error: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    check-cast v3, Ljava/lang/Throwable;

    invoke-interface {v2, v3}, Lkotlinx/coroutines/CompletableDeferred;->completeExceptionally(Ljava/lang/Throwable;)Z
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_3

    .line 34
    .end local p1    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    :catch_1
    move-exception p1

    move-object v6, v1

    move-object v1, p1

    move-object p1, v0

    move-object v0, v6

    goto :goto_2

    .end local v0    # "$result":Ljava/lang/Object;
    .local p1, "$result":Ljava/lang/Object;
    :catch_2
    move-exception v0

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    .line 35
    .local v0, "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;
    .local v1, "e":Ljava/lang/Exception;
    :goto_2
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;->$deferred:Lkotlinx/coroutines/CompletableDeferred;

    move-object v3, v1

    check-cast v3, Ljava/lang/Throwable;

    invoke-interface {v2, v3}, Lkotlinx/coroutines/CompletableDeferred;->completeExceptionally(Ljava/lang/Throwable;)Z

    move-object v1, v0

    move-object v0, p1

    .line 37
    .end local p1    # "$result":Ljava/lang/Object;
    .local v0, "$result":Ljava/lang/Object;
    .local v1, "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$getDownloadFileApi$1;
    :goto_3
    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
