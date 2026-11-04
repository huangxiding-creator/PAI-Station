.class final Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "HgIdentificationServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->toIdentification(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V
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
    c = "com.rokid.security.phone.sdk.server.hgIdentification.HgIdentificationServiceImpl$toIdentification$1"
    f = "HgIdentificationServiceImpl.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $extra:Lcom/rokid/security/sdk/base/common/IdentificationExtra;

.field final synthetic $identificationId:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $isModify:Lkotlin/jvm/internal/Ref$BooleanRef;

.field final synthetic $question:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $requestQuestionId:Ljava/lang/String;

.field final synthetic $terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

.field label:I


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/IdentificationExtra;Ljava/lang/String;Lkotlin/jvm/internal/Ref$BooleanRef;Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/phone/sdk/server/aichat/data/AiChatParam;",
            ">;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lcom/rokid/security/sdk/base/common/IdentificationExtra;",
            "Ljava/lang/String;",
            "Lkotlin/jvm/internal/Ref$BooleanRef;",
            "Ljava/util/concurrent/atomic/AtomicBoolean;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$identificationId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$extra:Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$requestQuestionId:Ljava/lang/String;

    iput-object p6, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$isModify:Lkotlin/jvm/internal/Ref$BooleanRef;

    iput-object p7, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iput-object p8, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p9}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method

.method public static final synthetic access$invokeSuspend$failIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->invokeSuspend$failIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$invokeSuspend$finishIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$BooleanRef;Ljava/lang/String;)V
    .locals 0

    invoke-static {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->invokeSuspend$finishIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$BooleanRef;Ljava/lang/String;)V

    return-void
.end method

.method private static final invokeSuspend$failIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p0, "terminalHandled"    # Ljava/util/concurrent/atomic/AtomicBoolean;
    .param p1, "requestQuestionId"    # Ljava/lang/String;
    .param p2, "source"    # Ljava/lang/String;

    .line 439
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    .line 440
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ignore duplicate terminal callback source="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " questionId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 441
    return-void

    .line 443
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->access$sendError(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;)V

    .line 444
    return-void
.end method

.method private static final invokeSuspend$finishIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$BooleanRef;Ljava/lang/String;)V
    .locals 9
    .param p0, "terminalHandled"    # Ljava/util/concurrent/atomic/AtomicBoolean;
    .param p1, "requestQuestionId"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p3, "isModify"    # Lkotlin/jvm/internal/Ref$BooleanRef;
    .param p4, "source"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/concurrent/atomic/AtomicBoolean;",
            "Ljava/lang/String;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/jvm/internal/Ref$BooleanRef;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 424
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    .line 425
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ignore duplicate terminal callback source="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " questionId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 426
    return-void

    .line 428
    :cond_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    .line 429
    nop

    .line 430
    iget-object v0, p2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v4, v0

    check-cast v4, Ljava/lang/String;

    .line 431
    nop

    .line 432
    nop

    .line 433
    nop

    .line 434
    iget-boolean v8, p3, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    .line 428
    const/4 v5, 0x0

    const/4 v6, 0x1

    const-string v7, "InputOver"

    move-object v3, p1

    invoke-static/range {v2 .. v8}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->access$sendChatContent(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;Z)V

    .line 436
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

    new-instance v10, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$identificationId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$extra:Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$requestQuestionId:Ljava/lang/String;

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$isModify:Lkotlin/jvm/internal/Ref$BooleanRef;

    iget-object v7, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v8, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    move-object v0, v10

    move-object v9, p2

    invoke-direct/range {v0 .. v9}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/IdentificationExtra;Ljava/lang/String;Lkotlin/jvm/internal/Ref$BooleanRef;Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V

    check-cast v10, Lkotlin/coroutines/Continuation;

    return-object v10
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 10

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 422
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 446
    .local v0, "this":Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;
    .local p1, "$result":Ljava/lang/Object;
    new-instance v1, Lcom/google/gson/Gson;

    invoke-direct {v1}, Lcom/google/gson/Gson;-><init>()V

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 447
    .local v1, "param":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getIdentification()Ljava/lang/String;

    move-result-object v2

    .line 448
    .local v2, "url":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$identificationId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v4, v4, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v5, v4

    check-cast v5, Ljava/lang/String;

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v4, v4, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v6, v4

    check-cast v6, Ljava/lang/String;

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$extra:Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v7

    const-string v9, "param"

    invoke-static {v1, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v2

    move-object v8, v1

    invoke-static/range {v3 .. v8}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->access$logIdentificationRequest(Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 449
    sget-object v3, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl;->getMOkHttpSSEClient()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    move-result-object v3

    .end local v1    # "param":Ljava/lang/String;
    .end local v2    # "url":Ljava/lang/String;
    if-eqz v3, :cond_0

    invoke-static {v1, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;

    iget-object v5, v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$requestQuestionId:Ljava/lang/String;

    iget-object v6, v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$isModify:Lkotlin/jvm/internal/Ref$BooleanRef;

    iget-object v7, v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$terminalHandled:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object v8, v0, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v4, v5, v6, v7, v8}, Lcom/rokid/security/phone/sdk/server/hgIdentification/HgIdentificationServiceImpl$toIdentification$1$1;-><init>(Ljava/lang/String;Lkotlin/jvm/internal/Ref$BooleanRef;Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;)V

    move-object v6, v4

    check-cast v6, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    const/16 v8, 0x8

    const/4 v9, 0x0

    const/4 v7, 0x0

    move-object v4, v2

    move-object v5, v1

    invoke-static/range {v3 .. v9}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->getAiChat$default(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;IILjava/lang/Object;)V

    .line 478
    :cond_0
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
