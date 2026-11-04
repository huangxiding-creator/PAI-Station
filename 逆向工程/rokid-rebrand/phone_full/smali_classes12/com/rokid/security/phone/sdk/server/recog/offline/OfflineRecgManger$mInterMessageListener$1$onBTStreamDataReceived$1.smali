.class final Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "OfflineRecgManger.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1;->onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V
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
    c = "com.rokid.security.phone.sdk.server.recog.offline.OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1"
    f = "OfflineRecgManger.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $data:[B

.field final synthetic $tag:Ljava/lang/String;

.field label:I


# direct methods
.method constructor <init>([BLjava/lang/String;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;->$data:[B

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;->$tag:Ljava/lang/String;

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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;->$data:[B

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;->$tag:Ljava/lang/String;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;-><init>([BLjava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 14

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 58
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 59
    .local v0, "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->access$getMRecProvider$p()Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;

    move-result-object v1

    if-eqz v1, :cond_4

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;->$data:[B

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1;->$tag:Ljava/lang/String;

    .local v1, "it":Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;
    const/4 v4, 0x0

    .line 60
    .local v4, "$i$a$-let-OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1$1":I
    sget-object v5, Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;

    invoke-virtual {v5, v2}, Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;->dataToBase64([B)Ljava/lang/String;

    move-result-object v2

    .line 61
    .local v2, "base64Str":Ljava/lang/String;
    move-object v5, v3

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v11, 0x1

    new-array v6, v11, [Ljava/lang/String;

    const-string v7, ","

    const/4 v12, 0x0

    aput-object v7, v6, v12

    const/4 v9, 0x6

    const/4 v10, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static/range {v5 .. v10}, Lkotlin/text/StringsKt;->split$default(Ljava/lang/CharSequence;[Ljava/lang/String;ZIILjava/lang/Object;)Ljava/util/List;

    move-result-object v5

    .line 62
    .local v5, "items":Ljava/util/List;
    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v6

    const/4 v7, 0x7

    if-ge v6, v7, :cond_0

    .line 64
    .end local v1    # "it":Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;
    .end local v2    # "base64Str":Ljava/lang/String;
    .end local v5    # "items":Ljava/util/List;
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    .line 66
    .restart local v1    # "it":Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;
    .restart local v2    # "base64Str":Ljava/lang/String;
    .restart local v5    # "items":Ljava/util/List;
    :cond_0
    move-object v6, v2

    check-cast v6, Ljava/lang/CharSequence;

    if-eqz v6, :cond_1

    invoke-interface {v6}, Ljava/lang/CharSequence;->length()I

    move-result v6

    if-nez v6, :cond_2

    :cond_1
    move v12, v11

    :cond_2
    if-eqz v12, :cond_3

    .line 67
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "data to base64Str failed "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v6, "OfflineRecgManger"

    invoke-static {v6, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 68
    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v3

    .line 70
    :cond_3
    new-instance v3, Lcom/rokid/security/sdk/base/common/outside/RecognizeFaceSubmitInfo;

    .line 71
    invoke-interface {v5, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    move-object v7, v6

    check-cast v7, Ljava/lang/String;

    .line 72
    const/4 v6, 0x2

    invoke-interface {v5, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    move-object v8, v6

    check-cast v8, Ljava/lang/String;

    .line 73
    const/4 v6, 0x3

    invoke-interface {v5, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    move-object v9, v6

    check-cast v9, Ljava/lang/String;

    .line 74
    const/4 v6, 0x4

    invoke-interface {v5, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    move-object v10, v6

    check-cast v10, Ljava/lang/String;

    .line 75
    const/4 v6, 0x5

    invoke-interface {v5, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    move-object v11, v6

    check-cast v11, Ljava/lang/String;

    .line 76
    const/4 v6, 0x6

    invoke-interface {v5, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    move-object v12, v6

    check-cast v12, Ljava/lang/String;

    .line 77
    nop

    .line 70
    move-object v6, v3

    move-object v13, v2

    invoke-direct/range {v6 .. v13}, Lcom/rokid/security/sdk/base/common/outside/RecognizeFaceSubmitInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 79
    .local v3, "info":Lcom/rokid/security/sdk/base/common/outside/RecognizeFaceSubmitInfo;
    invoke-interface {v1, v3}, Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;->onRecognizedInfo(Lcom/rokid/security/sdk/base/common/outside/RecognizeFaceSubmitInfo;)V

    .line 80
    nop

    .line 59
    .end local v1    # "it":Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;
    .end local v2    # "base64Str":Ljava/lang/String;
    .end local v3    # "info":Lcom/rokid/security/sdk/base/common/outside/RecognizeFaceSubmitInfo;
    .end local v4    # "$i$a$-let-OfflineRecgManger$mInterMessageListener$1$onBTStreamDataReceived$1$1":I
    .end local v5    # "items":Ljava/util/List;
    nop

    .line 81
    :cond_4
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
