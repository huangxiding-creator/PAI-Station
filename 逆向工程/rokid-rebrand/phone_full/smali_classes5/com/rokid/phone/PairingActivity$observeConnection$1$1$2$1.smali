.class final Lcom/rokid/phone/PairingActivity$observeConnection$1$1$2$1;
.super Ljava/lang/Object;
.source "PairingActivity.kt"

# interfaces
.implements Lkotlinx/coroutines/flow/FlowCollector;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/PairingActivity$observeConnection$1$1$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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
.field final synthetic this$0:Lcom/rokid/phone/PairingActivity;


# direct methods
.method constructor <init>(Lcom/rokid/phone/PairingActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/phone/PairingActivity$observeConnection$1$1$2$1;->this$0:Lcom/rokid/phone/PairingActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic emit(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p1, "value"    # Ljava/lang/Object;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 53
    move-object v0, p1

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-virtual {p0, v0, p2}, Lcom/rokid/phone/PairingActivity$observeConnection$1$1$2$1;->emit(ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final emit(ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 3
    .param p1, "connected"    # Z
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 54
    iget-object v0, p0, Lcom/rokid/phone/PairingActivity$observeConnection$1$1$2$1;->this$0:Lcom/rokid/phone/PairingActivity;

    invoke-static {v0}, Lcom/rokid/phone/PairingActivity;->access$getBinding(Lcom/rokid/phone/PairingActivity;)Lcom/rokid/phone/databinding/ActivityPairingBinding;

    move-result-object v0

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvP2PState:Landroid/widget/TextView;

    .line 55
    if-eqz p1, :cond_0

    sget v1, Lcom/rokid/phone/R$string;->demo_pair_p2p_done:I

    goto :goto_0

    :cond_0
    sget v1, Lcom/rokid/phone/R$string;->demo_pair_p2p_waiting:I

    :goto_0
    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    .line 54
    invoke-static {v1, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 57
    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/rokid/phone/PairingActivity$observeConnection$1$1$2$1;->this$0:Lcom/rokid/phone/PairingActivity;

    invoke-static {v0}, Lcom/rokid/phone/PairingActivity;->access$completePairing(Lcom/rokid/phone/PairingActivity;)V

    .line 58
    :cond_1
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method
