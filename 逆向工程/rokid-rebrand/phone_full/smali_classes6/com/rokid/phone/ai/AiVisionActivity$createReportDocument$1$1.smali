.class final Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "AiVisionActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/ai/AiVisionActivity;-><init>()V
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
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\n"
    }
    d2 = {
        "<anonymous>",
        "",
        "Lkotlinx/coroutines/CoroutineScope;"
    }
    k = 0x3
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.phone.ai.AiVisionActivity$createReportDocument$1$1"
    f = "AiVisionActivity.kt"
    i = {}
    l = {
        0x3a
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $report:Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

.field final synthetic $uri:Landroid/net/Uri;

.field label:I

.field final synthetic this$0:Lcom/rokid/phone/ai/AiVisionActivity;


# direct methods
.method constructor <init>(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/net/Uri;Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/phone/ai/AiVisionActivity;",
            "Landroid/net/Uri;",
            "Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    iput-object p2, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->$uri:Landroid/net/Uri;

    iput-object p3, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->$report:Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

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

    new-instance v0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;

    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->$uri:Landroid/net/Uri;

    iget-object v3, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->$report:Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    invoke-direct {v0, v1, v2, v3, p2}, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/net/Uri;Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 8
    .param p1, "$result"    # Ljava/lang/Object;

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 57
    iget v1, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->label:I

    const/4 v2, 0x1

    packed-switch v1, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p1

    goto :goto_0

    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 58
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v1

    check-cast v1, Lkotlin/coroutines/CoroutineContext;

    new-instance v3, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1$copied$1;

    iget-object v4, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    iget-object v5, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->$report:Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    iget-object v6, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->$uri:Landroid/net/Uri;

    const/4 v7, 0x0

    invoke-direct {v3, v4, v5, v6, v7}, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1$copied$1;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;Landroid/net/Uri;Lkotlin/coroutines/Continuation;)V

    check-cast v3, Lkotlin/jvm/functions/Function2;

    move-object v4, p0

    check-cast v4, Lkotlin/coroutines/Continuation;

    iput v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->label:I

    invoke-static {v1, v3, v4}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_0

    .line 57
    return-object v0

    .line 58
    :cond_0
    :goto_0
    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 61
    .local v0, "copied":Z
    const/4 v1, 0x0

    if-nez v0, :cond_1

    .line 63
    iget-object v3, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    check-cast v3, Landroid/content/Context;

    .line 64
    sget v4, Lcom/rokid/phone/R$string;->demo_ai_vision_download_failed:I

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v4, v1}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    .line 65
    nop

    .line 62
    invoke-static {v3, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    .line 66
    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 67
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    .line 70
    :cond_1
    iget-object v3, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    check-cast v3, Landroid/content/Context;

    .line 71
    sget v4, Lcom/rokid/phone/R$string;->demo_ai_vision_download_started:I

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v4, v1}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    .line 72
    nop

    .line 69
    invoke-static {v3, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    .line 73
    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 74
    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    invoke-static {v1}, Lcom/rokid/phone/ai/AiVisionActivity;->access$getPendingAction$p(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/ai/AiVisionActivity$PendingAction;

    move-result-object v1

    sget-object v2, Lcom/rokid/phone/ai/AiVisionActivity$PendingAction$SaveAndOpen;->INSTANCE:Lcom/rokid/phone/ai/AiVisionActivity$PendingAction$SaveAndOpen;

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 75
    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;->$uri:Landroid/net/Uri;

    invoke-static {v1, v2}, Lcom/rokid/phone/ai/AiVisionActivity;->access$openReport(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/net/Uri;)V

    .line 77
    :cond_2
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
