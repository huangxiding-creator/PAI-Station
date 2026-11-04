.class final Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "GHgIdentificationServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->toIdentification(Lcom/rokid/security/sdk/base/common/IdentificationExtra;)V
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
    c = "com.rokid.security.sdk.ability.identification.GHgIdentificationServiceImpl$toIdentification$1"
    f = "GHgIdentificationServiceImpl.kt"
    i = {}
    l = {
        0x98
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/sdk/ability/param/AiChatParam;",
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

.field final synthetic $question:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $questionId:Ljava/lang/String;

.field label:I


# direct methods
.method constructor <init>(Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/IdentificationExtra;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Lcom/rokid/security/sdk/ability/param/AiChatParam;",
            ">;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lcom/rokid/security/sdk/base/common/IdentificationExtra;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$questionId:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p3, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$identificationId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p4, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p5, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$extra:Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    iput-object p6, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p7}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method

.method public static final synthetic access$invokeSuspend$failIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->invokeSuspend$failIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$invokeSuspend$finishIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->invokeSuspend$finishIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;)V

    return-void
.end method

.method private static final invokeSuspend$failIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p0, "terminalHandled"    # Ljava/util/concurrent/atomic/AtomicBoolean;
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "source"    # Ljava/lang/String;

    .line 172
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    .line 173
    invoke-static {}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

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

    .line 174
    return-void

    .line 176
    :cond_0
    sget-object v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    invoke-static {v0, p1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$sendError(Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;Ljava/lang/String;)V

    .line 177
    return-void
.end method

.method private static final invokeSuspend$finishIdentificationOnce(Ljava/util/concurrent/atomic/AtomicBoolean;Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;)V
    .locals 8
    .param p0, "terminalHandled"    # Ljava/util/concurrent/atomic/AtomicBoolean;
    .param p1, "questionId"    # Ljava/lang/String;
    .param p2, "imageUrl"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p3, "source"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/concurrent/atomic/AtomicBoolean;",
            "Ljava/lang/String;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 159
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    .line 160
    invoke-static {}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ignore duplicate terminal callback source="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

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

    .line 161
    return-void

    .line 163
    :cond_0
    sget-object v2, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    .line 164
    nop

    .line 165
    iget-object v0, p2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v4, v0

    check-cast v4, Ljava/lang/String;

    .line 166
    nop

    .line 167
    nop

    .line 168
    nop

    .line 163
    const/4 v5, 0x0

    const/4 v6, 0x1

    const-string v7, "InputOver"

    move-object v3, p1

    invoke-static/range {v2 .. v7}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$sendChatContent(Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/aichat/AiContent;ZLjava/lang/String;)V

    .line 170
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

    new-instance v8, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$questionId:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$identificationId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v4, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v5, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$extra:Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    iget-object v6, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    move-object v0, v8

    move-object v7, p2

    invoke-direct/range {v0 .. v7}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;-><init>(Ljava/lang/String;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/sdk/base/common/IdentificationExtra;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V

    check-cast v8, Lkotlin/coroutines/Continuation;

    return-object v8
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 11

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 151
    iget v1, p0, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, v0

    move-object v0, p1

    goto :goto_0

    .end local v0    # "this":Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 152
    .local v1, "this":Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    move-object v3, v1

    check-cast v3, Lkotlin/coroutines/Continuation;

    const/4 v4, 0x1

    iput v4, v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->label:I

    const-wide/16 v4, 0x3a98

    invoke-virtual {v2, v4, v5, v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->awaitAuthReady(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2

    if-ne v2, v0, :cond_0

    .line 151
    return-object v0

    .line 152
    :cond_0
    move-object v0, p1

    move-object p1, v2

    .end local p1    # "$result":Ljava/lang/Object;
    .local v0, "$result":Ljava/lang/Object;
    :goto_0
    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-nez p1, :cond_1

    .line 153
    invoke-static {}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "identification blocked: auth not ready state="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/auth/SdkTokenManager;->getAuthState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v3

    invoke-interface {v3}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {p1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 154
    sget-object p1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    iget-object v2, v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$questionId:Ljava/lang/String;

    invoke-static {p1, v2}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$sendError(Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;Ljava/lang/String;)V

    .line 155
    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1

    .line 157
    :cond_1
    new-instance p1, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x0

    invoke-direct {p1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    .line 178
    .local p1, "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    new-instance v2, Lcom/google/gson/Gson;

    invoke-direct {v2}, Lcom/google/gson/Gson;-><init>()V

    iget-object v3, v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$aiChatParam:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    invoke-virtual {v2, v3}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 179
    .local v2, "param":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getIdentification()Ljava/lang/String;

    move-result-object v3

    .line 180
    .local v3, "url":Ljava/lang/String;
    sget-object v4, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    iget-object v5, v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$identificationId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v5, v5, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v6, v5

    check-cast v6, Ljava/lang/String;

    iget-object v5, v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$question:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v5, v5, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    move-object v7, v5

    check-cast v7, Ljava/lang/String;

    iget-object v5, v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$extra:Lcom/rokid/security/sdk/base/common/IdentificationExtra;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/IdentificationExtra;->getImageBase64()Ljava/lang/String;

    move-result-object v8

    const-string v10, "param"

    invoke-static {v2, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v5, v3

    move-object v9, v2

    invoke-static/range {v4 .. v9}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->access$logIdentificationRequest(Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 181
    sget-object v4, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl;->getMOkHttpSSEClient()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    move-result-object v4

    if-eqz v4, :cond_2

    .end local v2    # "param":Ljava/lang/String;
    .end local v3    # "url":Ljava/lang/String;
    invoke-static {v2, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v5, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;

    iget-object v6, v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$questionId:Ljava/lang/String;

    iget-object v7, v1, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1;->$imageUrl:Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v5, v6, p1, v7}, Lcom/rokid/security/sdk/ability/identification/GHgIdentificationServiceImpl$toIdentification$1$1;-><init>(Ljava/lang/String;Ljava/util/concurrent/atomic/AtomicBoolean;Lkotlin/jvm/internal/Ref$ObjectRef;)V

    check-cast v5, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    .line 208
    .end local p1    # "terminalHandled":Ljava/util/concurrent/atomic/AtomicBoolean;
    nop

    .line 181
    const/4 p1, 0x2

    invoke-virtual {v4, v3, v2, v5, p1}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->getAiChat(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;I)V

    nop

    .line 210
    :cond_2
    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
