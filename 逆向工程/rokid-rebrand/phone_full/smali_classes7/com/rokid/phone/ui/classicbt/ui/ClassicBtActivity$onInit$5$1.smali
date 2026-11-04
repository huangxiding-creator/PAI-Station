.class final Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$onInit$5$1;
.super Ljava/lang/Object;
.source "ClassicBtActivity.kt"

# interfaces
.implements Lkotlinx/coroutines/flow/FlowCollector;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$onInit$5;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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
    k = 0x3
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic this$0:Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;


# direct methods
.method constructor <init>(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$onInit$5$1;->this$0:Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic emit(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p1, "value"    # Ljava/lang/Object;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 63
    move-object v0, p1

    check-cast v0, Lkotlin/Unit;

    invoke-virtual {p0, v0, p2}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$onInit$5$1;->emit(Lkotlin/Unit;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final emit(Lkotlin/Unit;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .param p1, "it"    # Lkotlin/Unit;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/Unit;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 64
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$onInit$5$1;->this$0:Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;

    invoke-static {v0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->access$stopLoading(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)V

    .line 65
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$onInit$5$1;->this$0:Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;

    invoke-static {v0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->access$getBinding(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    move-result-object v0

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->tvListTip2:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    const/16 v1, 0x8

    if-ne v0, v1, :cond_0

    .line 66
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$onInit$5$1;->this$0:Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;

    invoke-static {v0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->access$getBinding(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    move-result-object v0

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->tvListTip2:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 68
    :cond_0
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method
