.class final Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "AiVisionActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/ai/AiVisionActivity;->generateReport(Z)V
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
    value = "SMAP\nAiVisionActivity.kt\nKotlin\n*S Kotlin\n*F\n+ 1 AiVisionActivity.kt\ncom/rokid/phone/ai/AiVisionActivity$generateReport$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,321:1\n1#2:322\n*E\n"
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
    c = "com.rokid.phone.ai.AiVisionActivity$generateReport$1"
    f = "AiVisionActivity.kt"
    i = {
        0x0,
        0x0,
        0x0
    }
    l = {
        0x108
    }
    m = "invokeSuspend"
    n = {
        "$this$launch",
        "$this$invokeSuspend_u24lambda_u240",
        "$i$a$-runCatching-AiVisionActivity$generateReport$1$result$1"
    }
    s = {
        "L$0",
        "L$1",
        "I$0"
    }
.end annotation


# instance fields
.field final synthetic $records:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $saveAndOpen:Z

.field I$0:I

.field private synthetic L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/phone/ai/AiVisionActivity;


# direct methods
.method constructor <init>(Lcom/rokid/phone/ai/AiVisionActivity;Ljava/util/List;ZLkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/phone/ai/AiVisionActivity;",
            "Ljava/util/List<",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ">;Z",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    iput-object p2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->$records:Ljava/util/List;

    iput-boolean p3, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->$saveAndOpen:Z

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

    new-instance v0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;

    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->$records:Ljava/util/List;

    iget-boolean v3, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->$saveAndOpen:Z

    invoke-direct {v0, v1, v2, v3, p2}, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;Ljava/util/List;ZLkotlin/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 11
    .param p1, "$result"    # Ljava/lang/Object;

    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlinx/coroutines/CoroutineScope;

    .local v0, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 255
    iget v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->label:I

    const/4 v3, 0x1

    const/4 v4, 0x0

    packed-switch v2, :pswitch_data_0

    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    :pswitch_0
    iget v1, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->I$0:I

    .local v1, "$i$a$-runCatching-AiVisionActivity$generateReport$1$result$1":I
    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->L$1:Ljava/lang/Object;

    check-cast v2, Lkotlinx/coroutines/CoroutineScope;

    .local v2, "$this$invokeSuspend_u24lambda_u240":Lkotlinx/coroutines/CoroutineScope;
    :try_start_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v6, v2

    move-object v2, p1

    goto :goto_0

    .end local v1    # "$i$a$-runCatching-AiVisionActivity$generateReport$1$result$1":I
    .end local v2    # "$this$invokeSuspend_u24lambda_u240":Lkotlinx/coroutines/CoroutineScope;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 256
    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    invoke-static {v2}, Lcom/rokid/phone/ai/AiVisionActivity;->access$getBinding(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    move-result-object v2

    iget-object v2, v2, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnGenerateReport:Landroidx/appcompat/widget/AppCompatButton;

    invoke-virtual {v2, v4}, Landroidx/appcompat/widget/AppCompatButton;->setEnabled(Z)V

    .line 257
    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    invoke-static {v2}, Lcom/rokid/phone/ai/AiVisionActivity;->access$getBinding(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    move-result-object v2

    iget-object v2, v2, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnDownloadReport:Landroidx/appcompat/widget/AppCompatButton;

    invoke-virtual {v2, v4}, Landroidx/appcompat/widget/AppCompatButton;->setEnabled(Z)V

    .line 259
    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    check-cast v2, Landroid/content/Context;

    .line 260
    sget v5, Lcom/rokid/phone/R$string;->demo_ai_vision_generating:I

    new-array v6, v4, [Ljava/lang/Object;

    invoke-static {v5, v6}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    check-cast v5, Ljava/lang/CharSequence;

    .line 261
    nop

    .line 258
    invoke-static {v2, v5, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v2

    .line 262
    invoke-virtual {v2}, Landroid/widget/Toast;->show()V

    .line 263
    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    iget-object v5, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->$records:Ljava/util/List;

    :try_start_1
    sget-object v6, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v6, v0

    .local v6, "$this$invokeSuspend_u24lambda_u240":Lkotlinx/coroutines/CoroutineScope;
    const/4 v7, 0x0

    .line 264
    .local v7, "$i$a$-runCatching-AiVisionActivity$generateReport$1$result$1":I
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v8

    check-cast v8, Lkotlin/coroutines/CoroutineContext;

    new-instance v9, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;

    const/4 v10, 0x0

    invoke-direct {v9, v2, v5, v10}, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;Ljava/util/List;Lkotlin/coroutines/Continuation;)V

    check-cast v9, Lkotlin/jvm/functions/Function2;

    invoke-static {v0}, Lkotlin/coroutines/jvm/internal/SpillingKt;->nullOutSpilledVariable(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    iput-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->L$0:Ljava/lang/Object;

    invoke-static {v6}, Lkotlin/coroutines/jvm/internal/SpillingKt;->nullOutSpilledVariable(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    iput-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->L$1:Ljava/lang/Object;

    iput v7, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->I$0:I

    iput v3, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->label:I

    invoke-static {v8, v9, p0}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2

    if-ne v2, v1, :cond_0

    .line 255
    return-object v1

    .line 264
    :cond_0
    move v1, v7

    .line 255
    .end local v7    # "$i$a$-runCatching-AiVisionActivity$generateReport$1$result$1":I
    .restart local v1    # "$i$a$-runCatching-AiVisionActivity$generateReport$1$result$1":I
    :goto_0
    check-cast v2, Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    .line 266
    nop

    .line 263
    .end local v1    # "$i$a$-runCatching-AiVisionActivity$generateReport$1$result$1":I
    .end local v6    # "$this$invokeSuspend_u24lambda_u240":Lkotlinx/coroutines/CoroutineScope;
    invoke-static {v2}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v1

    sget-object v2, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v1}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 268
    .local v1, "result":Ljava/lang/Object;
    :goto_1
    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    iget-boolean v5, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->$saveAndOpen:Z

    invoke-static {v1}, Lkotlin/Result;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    move-object v6, v1

    check-cast v6, Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    .local v6, "report":Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;
    const/4 v7, 0x0

    .line 269
    .local v7, "$i$a$-onSuccess-AiVisionActivity$generateReport$1$1":I
    invoke-static {v2, v6}, Lcom/rokid/phone/ai/AiVisionActivity;->access$setCurrentReport$p(Lcom/rokid/phone/ai/AiVisionActivity;Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;)V

    .line 271
    move-object v8, v2

    check-cast v8, Landroid/content/Context;

    .line 272
    sget v9, Lcom/rokid/phone/R$string;->demo_ai_vision_report_ready:I

    invoke-virtual {v6}, Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;->getDisplayName()Ljava/lang/String;

    move-result-object v10

    filled-new-array {v10}, [Ljava/lang/Object;

    move-result-object v10

    invoke-static {v9, v10}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    check-cast v9, Ljava/lang/CharSequence;

    .line 273
    nop

    .line 270
    invoke-static {v8, v9, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v8

    .line 274
    invoke-virtual {v8}, Landroid/widget/Toast;->show()V

    .line 275
    invoke-static {v2}, Lcom/rokid/phone/ai/AiVisionActivity;->access$getBinding(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    move-result-object v8

    iget-object v8, v8, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnDownloadReport:Landroidx/appcompat/widget/AppCompatButton;

    invoke-virtual {v8, v3}, Landroidx/appcompat/widget/AppCompatButton;->setEnabled(Z)V

    .line 276
    if-eqz v5, :cond_1

    .line 277
    invoke-static {v2}, Lcom/rokid/phone/ai/AiVisionActivity;->access$getCreateReportDocument$p(Lcom/rokid/phone/ai/AiVisionActivity;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object v2

    invoke-virtual {v6}, Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;->getDisplayName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Landroidx/activity/result/ActivityResultLauncher;->launch(Ljava/lang/Object;)V

    .line 279
    :cond_1
    nop

    .line 268
    .end local v6    # "report":Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;
    .end local v7    # "$i$a$-onSuccess-AiVisionActivity$generateReport$1$1":I
    :cond_2
    nop

    .line 279
    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    invoke-static {v1}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v5

    if-eqz v5, :cond_4

    .local v5, "error":Ljava/lang/Throwable;
    const/4 v6, 0x0

    .line 281
    .local v6, "$i$a$-onFailure-AiVisionActivity$generateReport$1$2":I
    check-cast v2, Landroid/content/Context;

    .line 283
    sget v7, Lcom/rokid/phone/R$string;->demo_ai_vision_report_failed:I

    .line 284
    invoke-virtual {v5}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v8

    if-nez v8, :cond_3

    const-string v8, ""

    :cond_3
    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    .line 282
    invoke-static {v7, v8}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    check-cast v7, Ljava/lang/CharSequence;

    .line 286
    nop

    .line 280
    invoke-static {v2, v7, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v2

    .line 287
    invoke-virtual {v2}, Landroid/widget/Toast;->show()V

    .line 288
    nop

    .line 279
    .end local v5    # "error":Ljava/lang/Throwable;
    .end local v6    # "$i$a$-onFailure-AiVisionActivity$generateReport$1$2":I
    nop

    .line 289
    :cond_4
    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    invoke-static {v2}, Lcom/rokid/phone/ai/AiVisionActivity;->access$getBinding(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    move-result-object v2

    iget-object v2, v2, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnGenerateReport:Landroidx/appcompat/widget/AppCompatButton;

    .line 290
    iget-object v5, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    invoke-static {v5}, Lcom/rokid/phone/ai/AiVisionActivity;->access$selectedRecord(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/ai/AiVisionRecord;

    move-result-object v5

    if-eqz v5, :cond_5

    sget-object v6, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    .line 322
    nop

    .local v5, "p0":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v7, 0x0

    .line 290
    .local v7, "$i$a$-let-AiVisionActivity$generateReport$1$3":I
    invoke-virtual {v6, v5}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->isReportReady(Lcom/rokid/phone/ai/AiVisionRecord;)Z

    move-result v5

    .end local v5    # "p0":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v7    # "$i$a$-let-AiVisionActivity$generateReport$1$3":I
    if-ne v5, v3, :cond_5

    move v5, v3

    goto :goto_2

    :cond_5
    move v5, v4

    .line 289
    :goto_2
    invoke-virtual {v2, v5}, Landroidx/appcompat/widget/AppCompatButton;->setEnabled(Z)V

    .line 291
    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    invoke-static {v2}, Lcom/rokid/phone/ai/AiVisionActivity;->access$getBinding(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    move-result-object v2

    iget-object v2, v2, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnDownloadReport:Landroidx/appcompat/widget/AppCompatButton;

    iget-object v5, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    invoke-static {v5}, Lcom/rokid/phone/ai/AiVisionActivity;->access$getCurrentReport$p(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    move-result-object v5

    if-eqz v5, :cond_6

    goto :goto_3

    :cond_6
    move v3, v4

    :goto_3
    invoke-virtual {v2, v3}, Landroidx/appcompat/widget/AppCompatButton;->setEnabled(Z)V

    .line 292
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v2

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
