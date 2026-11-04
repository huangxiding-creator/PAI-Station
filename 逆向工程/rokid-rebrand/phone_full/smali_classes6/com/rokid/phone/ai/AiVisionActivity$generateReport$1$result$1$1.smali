.class final Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "AiVisionActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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
        "Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\n"
    }
    d2 = {
        "<anonymous>",
        "Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;",
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
    c = "com.rokid.phone.ai.AiVisionActivity$generateReport$1$result$1$1"
    f = "AiVisionActivity.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
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

.field label:I

.field final synthetic this$0:Lcom/rokid/phone/ai/AiVisionActivity;


# direct methods
.method constructor <init>(Lcom/rokid/phone/ai/AiVisionActivity;Ljava/util/List;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/phone/ai/AiVisionActivity;",
            "Ljava/util/List<",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    iput-object p2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;->$records:Ljava/util/List;

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

    new-instance v0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;

    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;->$records:Ljava/util/List;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;Ljava/util/List;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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
            "Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 8
    .param p1, "$result"    # Ljava/lang/Object;

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 264
    iget v0, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 265
    sget-object v1, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->INSTANCE:Lcom/rokid/phone/ai/AiVisionPdfGenerator;

    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;->this$0:Lcom/rokid/phone/ai/AiVisionActivity;

    move-object v2, v0

    check-cast v2, Landroid/content/Context;

    iget-object v3, p0, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1$result$1$1;->$records:Ljava/util/List;

    const/4 v6, 0x4

    const/4 v7, 0x0

    const-wide/16 v4, 0x0

    invoke-static/range {v1 .. v7}, Lcom/rokid/phone/ai/AiVisionPdfGenerator;->generate$default(Lcom/rokid/phone/ai/AiVisionPdfGenerator;Landroid/content/Context;Ljava/util/List;JILjava/lang/Object;)Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    move-result-object v0

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
