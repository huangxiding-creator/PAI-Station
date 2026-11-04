.class final Lcom/rokid/phone/PairingActivity$startPairing$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "PairingActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/PairingActivity;->startPairing()V
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
    c = "com.rokid.phone.PairingActivity$startPairing$1"
    f = "PairingActivity.kt"
    i = {}
    l = {
        0x4a,
        0x51
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field label:I

.field final synthetic this$0:Lcom/rokid/phone/PairingActivity;


# direct methods
.method public static synthetic $r8$lambda$3PNWhwm7JzJfydfsmTEUA1eqyRU(Lcom/rokid/phone/PairingActivity;Z)Lkotlin/Unit;
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/PairingActivity$startPairing$1;->invokeSuspend$lambda$1(Lcom/rokid/phone/PairingActivity;Z)Lkotlin/Unit;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$g-zuz0NVSXD6C8ukVzKgTkEw5ws(ZLcom/rokid/phone/PairingActivity;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/PairingActivity$startPairing$1;->invokeSuspend$lambda$1$lambda$0(ZLcom/rokid/phone/PairingActivity;)V

    return-void
.end method

.method constructor <init>(Lcom/rokid/phone/PairingActivity;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/phone/PairingActivity;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/phone/PairingActivity$startPairing$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/phone/PairingActivity$startPairing$1;->this$0:Lcom/rokid/phone/PairingActivity;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p2}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method

.method private static final invokeSuspend$lambda$1(Lcom/rokid/phone/PairingActivity;Z)Lkotlin/Unit;
    .locals 1
    .param p0, "this$0"    # Lcom/rokid/phone/PairingActivity;
    .param p1, "success"    # Z

    .line 77
    new-instance v0, Lcom/rokid/phone/PairingActivity$startPairing$1$$ExternalSyntheticLambda1;

    invoke-direct {v0, p1, p0}, Lcom/rokid/phone/PairingActivity$startPairing$1$$ExternalSyntheticLambda1;-><init>(ZLcom/rokid/phone/PairingActivity;)V

    invoke-virtual {p0, v0}, Lcom/rokid/phone/PairingActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 80
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method private static final invokeSuspend$lambda$1$lambda$0(ZLcom/rokid/phone/PairingActivity;)V
    .locals 0
    .param p0, "$success"    # Z
    .param p1, "this$0"    # Lcom/rokid/phone/PairingActivity;

    .line 78
    if-nez p0, :cond_0

    invoke-static {p1}, Lcom/rokid/phone/PairingActivity;->access$showPairFailure(Lcom/rokid/phone/PairingActivity;)V

    .line 79
    :cond_0
    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 2
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

    new-instance v0, Lcom/rokid/phone/PairingActivity$startPairing$1;

    iget-object v1, p0, Lcom/rokid/phone/PairingActivity$startPairing$1;->this$0:Lcom/rokid/phone/PairingActivity;

    invoke-direct {v0, v1, p2}, Lcom/rokid/phone/PairingActivity$startPairing$1;-><init>(Lcom/rokid/phone/PairingActivity;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/PairingActivity$startPairing$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/PairingActivity$startPairing$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/PairingActivity$startPairing$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/phone/PairingActivity$startPairing$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 5
    .param p1, "$result"    # Ljava/lang/Object;

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 73
    iget v1, p0, Lcom/rokid/phone/PairingActivity$startPairing$1;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_1

    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_0

    :pswitch_2
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 74
    move-object v1, p0

    check-cast v1, Lkotlin/coroutines/Continuation;

    const/4 v2, 0x1

    iput v2, p0, Lcom/rokid/phone/PairingActivity$startPairing$1;->label:I

    const-wide/16 v2, 0x15e

    invoke-static {v2, v3, v1}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_0

    .line 73
    return-object v0

    .line 75
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/rokid/phone/PairingActivity$startPairing$1;->this$0:Lcom/rokid/phone/PairingActivity;

    invoke-static {v1}, Lcom/rokid/phone/PairingActivity;->access$getBinding(Lcom/rokid/phone/PairingActivity;)Lcom/rokid/phone/databinding/ActivityPairingBinding;

    move-result-object v1

    iget-object v1, v1, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvPairHint:Landroid/widget/TextView;

    sget v2, Lcom/rokid/phone/R$string;->demo_pair_bluetooth_connecting:I

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 76
    sget-object v1, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    iget-object v2, p0, Lcom/rokid/phone/PairingActivity$startPairing$1;->this$0:Lcom/rokid/phone/PairingActivity;

    invoke-static {v2}, Lcom/rokid/phone/PairingActivity;->access$getDevice$p(Lcom/rokid/phone/PairingActivity;)Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    move-result-object v2

    iget-object v3, p0, Lcom/rokid/phone/PairingActivity$startPairing$1;->this$0:Lcom/rokid/phone/PairingActivity;

    new-instance v4, Lcom/rokid/phone/PairingActivity$startPairing$1$$ExternalSyntheticLambda0;

    invoke-direct {v4, v3}, Lcom/rokid/phone/PairingActivity$startPairing$1$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/phone/PairingActivity;)V

    invoke-virtual {v1, v2, v4}, Lcom/rokid/phone/DeviceLinkerManager;->connectBt(Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;Lkotlin/jvm/functions/Function1;)V

    .line 81
    move-object v1, p0

    check-cast v1, Lkotlin/coroutines/Continuation;

    const/4 v2, 0x2

    iput v2, p0, Lcom/rokid/phone/PairingActivity$startPairing$1;->label:I

    const-wide/16 v2, 0x4e20

    invoke-static {v2, v3, v1}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_1

    .line 73
    return-object v0

    .line 82
    :cond_1
    :goto_1
    iget-object v0, p0, Lcom/rokid/phone/PairingActivity$startPairing$1;->this$0:Lcom/rokid/phone/PairingActivity;

    invoke-static {v0}, Lcom/rokid/phone/PairingActivity;->access$getCompleted$p(Lcom/rokid/phone/PairingActivity;)Z

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    invoke-virtual {v0}, Lcom/rokid/phone/data/GlobalData;->getP2pConnectState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/rokid/phone/PairingActivity$startPairing$1;->this$0:Lcom/rokid/phone/PairingActivity;

    invoke-static {v0}, Lcom/rokid/phone/PairingActivity;->access$showPairFailure(Lcom/rokid/phone/PairingActivity;)V

    .line 83
    :cond_2
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
