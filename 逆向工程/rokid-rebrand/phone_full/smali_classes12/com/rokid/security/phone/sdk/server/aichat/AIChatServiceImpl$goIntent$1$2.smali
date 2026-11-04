.class final Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$goIntent$1$2;
.super Ljava/lang/Object;
.source "AIChatServiceImpl.kt"

# interfaces
.implements Lkotlinx/coroutines/flow/FlowCollector;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$goIntent$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Lkotlinx/coroutines/flow/FlowCollector;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u00012\u000c\u0010\u0002\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0003H\u008a@\u00a2\u0006\u0004\u0008\u0005\u0010\u0006"
    }
    d2 = {
        "<anonymous>",
        "",
        "response",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;",
        "Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;",
        "emit",
        "(Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $question:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$goIntent$1$2;->$question:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final emit(Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 7
    .param p1, "response"    # Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3<",
            "Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 638
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getCode()Ljava/lang/Integer;

    move-result-object v0

    if-nez v0, :cond_0

    goto/16 :goto_4

    :cond_0
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-nez v0, :cond_6

    .line 639
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u54cd\u5e94\u6570\u636e: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;

    const/4 v3, 0x0

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;->getIntent()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_1
    move-object v2, v3

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 640
    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;

    .line 641
    .local v0, "aiResponse":Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u54cd\u5e94\u6570\u636e intent: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;

    if-eqz v4, :cond_2

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;->getIntent()Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    :cond_2
    move-object v4, v3

    :goto_1
    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 643
    const/4 v1, 0x0

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;->getIntent()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_4

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    const/4 v4, 0x1

    if-lez v2, :cond_3

    move v2, v4

    goto :goto_2

    :cond_3
    move v2, v1

    :goto_2
    if-ne v2, v4, :cond_4

    goto :goto_3

    :cond_4
    move v4, v1

    :goto_3
    if-eqz v4, :cond_5

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;->getIntent()Ljava/lang/String;

    move-result-object v2

    sget-object v4, Lcom/rokid/security/sdk/base/common/AiIntent;->INSTANCE:Lcom/rokid/security/sdk/base/common/AiIntent;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/AiIntent;->getIMAGE()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 644
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;->getIntent()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$goIntent$1$2;->$question:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->access$sendChatImgIntent(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_4

    .line 646
    :cond_5
    new-instance v2, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$goIntent$1$2;->$question:Ljava/lang/String;

    move-object v5, v2

    .local v5, "$this$emit_u24lambda_u240":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v6, 0x0

    .line 647
    .local v6, "$i$a$-apply-AIChatServiceImpl$goIntent$1$2$mAiChatExtra$1":I
    invoke-virtual {v5, v4}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setQuestion(Ljava/lang/String;)V

    .line 648
    nop

    .line 646
    .end local v5    # "$this$emit_u24lambda_u240":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v6    # "$i$a$-apply-AIChatServiceImpl$goIntent$1$2$mAiChatExtra$1":I
    nop

    .line 649
    .local v2, "mAiChatExtra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    const/4 v5, 0x2

    invoke-static {v4, v2, v1, v5, v3}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->toAiChat$default(Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;Lcom/rokid/security/sdk/base/common/AiChatExtra;ZILjava/lang/Object;)V

    .line 652
    .end local v0    # "aiResponse":Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;
    .end local v2    # "mAiChatExtra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    :cond_6
    :goto_4
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public bridge synthetic emit(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p1, "value"    # Ljava/lang/Object;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 636
    move-object v0, p1

    check-cast v0, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;

    invoke-virtual {p0, v0, p2}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl$goIntent$1$2;->emit(Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
