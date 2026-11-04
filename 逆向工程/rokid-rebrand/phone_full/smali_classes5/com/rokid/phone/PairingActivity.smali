.class public final Lcom/rokid/phone/PairingActivity;
.super Lcom/rokid/phone/base/BaseActivity;
.source "PairingActivity.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/phone/PairingActivity$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/rokid/phone/base/BaseActivity<",
        "Lcom/rokid/phone/databinding/ActivityPairingBinding;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0007\u0018\u0000 \u00152\u0008\u0012\u0004\u0012\u00020\u00020\u0001:\u0001\u0015B\u0007\u00a2\u0006\u0004\u0008\u0003\u0010\u0004J\u0008\u0010\u000b\u001a\u00020\u0002H\u0016J\u0012\u0010\u000c\u001a\u00020\r2\u0008\u0010\u000e\u001a\u0004\u0018\u00010\u000fH\u0016J\u0008\u0010\u0010\u001a\u00020\rH\u0002J\u0008\u0010\u0011\u001a\u00020\rH\u0002J\u0008\u0010\u0012\u001a\u00020\rH\u0002J\u0008\u0010\u0013\u001a\u00020\rH\u0002J\u0008\u0010\u0014\u001a\u00020\rH\u0014R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0016"
    }
    d2 = {
        "Lcom/rokid/phone/PairingActivity;",
        "Lcom/rokid/phone/base/BaseActivity;",
        "Lcom/rokid/phone/databinding/ActivityPairingBinding;",
        "<init>",
        "()V",
        "device",
        "Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;",
        "pairJob",
        "Lkotlinx/coroutines/Job;",
        "completed",
        "",
        "initViewBinding",
        "onInit",
        "",
        "savedInstanceState",
        "Landroid/os/Bundle;",
        "observeConnection",
        "startPairing",
        "completePairing",
        "showPairFailure",
        "onDestroy",
        "Companion",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final Companion:Lcom/rokid/phone/PairingActivity$Companion;

.field private static final EXTRA_ADDRESS:Ljava/lang/String; = "device_address"

.field private static final EXTRA_NAME:Ljava/lang/String; = "device_name"

.field private static final EXTRA_TYPE:Ljava/lang/String; = "device_type"


# instance fields
.field private completed:Z

.field private device:Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

.field private pairJob:Lkotlinx/coroutines/Job;


# direct methods
.method public static synthetic $r8$lambda$HT6jZG8_UR2j4ngPelPstqieRO0(Lcom/rokid/phone/PairingActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/PairingActivity;->onInit$lambda$1(Lcom/rokid/phone/PairingActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$bjvkssOBISdeQsbC5AjPB7moYl0(Lcom/rokid/phone/PairingActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/PairingActivity;->onInit$lambda$0(Lcom/rokid/phone/PairingActivity;Landroid/view/View;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/phone/PairingActivity$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/phone/PairingActivity$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/phone/PairingActivity;->Companion:Lcom/rokid/phone/PairingActivity$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .line 19
    invoke-direct {p0}, Lcom/rokid/phone/base/BaseActivity;-><init>()V

    .line 20
    new-instance v0, Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    const-string v1, ""

    const/4 v2, 0x0

    invoke-direct {v0, v1, v1, v2}, Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    iput-object v0, p0, Lcom/rokid/phone/PairingActivity;->device:Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    .line 19
    return-void
.end method

.method public static final synthetic access$completePairing(Lcom/rokid/phone/PairingActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/PairingActivity;

    .line 19
    invoke-direct {p0}, Lcom/rokid/phone/PairingActivity;->completePairing()V

    return-void
.end method

.method public static final synthetic access$getBinding(Lcom/rokid/phone/PairingActivity;)Lcom/rokid/phone/databinding/ActivityPairingBinding;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/PairingActivity;

    .line 19
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    return-object v0
.end method

.method public static final synthetic access$getCompleted$p(Lcom/rokid/phone/PairingActivity;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/PairingActivity;

    .line 19
    iget-boolean v0, p0, Lcom/rokid/phone/PairingActivity;->completed:Z

    return v0
.end method

.method public static final synthetic access$getDevice$p(Lcom/rokid/phone/PairingActivity;)Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/PairingActivity;

    .line 19
    iget-object v0, p0, Lcom/rokid/phone/PairingActivity;->device:Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    return-object v0
.end method

.method public static final synthetic access$showPairFailure(Lcom/rokid/phone/PairingActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/PairingActivity;

    .line 19
    invoke-direct {p0}, Lcom/rokid/phone/PairingActivity;->showPairFailure()V

    return-void
.end method

.method private final completePairing()V
    .locals 9

    .line 87
    iget-boolean v0, p0, Lcom/rokid/phone/PairingActivity;->completed:Z

    if-eqz v0, :cond_0

    return-void

    .line 88
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/phone/PairingActivity;->completed:Z

    .line 89
    iget-object v1, p0, Lcom/rokid/phone/PairingActivity;->pairJob:Lkotlinx/coroutines/Job;

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    invoke-static {v1, v2, v0, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 90
    :cond_1
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->progress:Landroid/widget/ProgressBar;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    .line 91
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvPairHint:Landroid/widget/TextView;

    sget v3, Lcom/rokid/phone/R$string;->demo_pair_complete:I

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v3, v4}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 92
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->btnRetry:Landroidx/appcompat/widget/AppCompatButton;

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/AppCompatButton;->setVisibility(I)V

    .line 93
    move-object v0, p0

    check-cast v0, Landroidx/lifecycle/LifecycleOwner;

    invoke-static {v0}, Landroidx/lifecycle/LifecycleOwnerKt;->getLifecycleScope(Landroidx/lifecycle/LifecycleOwner;)Landroidx/lifecycle/LifecycleCoroutineScope;

    move-result-object v0

    move-object v3, v0

    check-cast v3, Lkotlinx/coroutines/CoroutineScope;

    new-instance v0, Lcom/rokid/phone/PairingActivity$completePairing$1;

    invoke-direct {v0, p0, v2}, Lcom/rokid/phone/PairingActivity$completePairing$1;-><init>(Lcom/rokid/phone/PairingActivity;Lkotlin/coroutines/Continuation;)V

    move-object v6, v0

    check-cast v6, Lkotlin/jvm/functions/Function2;

    const/4 v7, 0x3

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v3 .. v8}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 97
    return-void
.end method

.method private final observeConnection()V
    .locals 7

    .line 42
    move-object v0, p0

    check-cast v0, Landroidx/lifecycle/LifecycleOwner;

    invoke-static {v0}, Landroidx/lifecycle/LifecycleOwnerKt;->getLifecycleScope(Landroidx/lifecycle/LifecycleOwner;)Landroidx/lifecycle/LifecycleCoroutineScope;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Lkotlinx/coroutines/CoroutineScope;

    new-instance v0, Lcom/rokid/phone/PairingActivity$observeConnection$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v2}, Lcom/rokid/phone/PairingActivity$observeConnection$1;-><init>(Lcom/rokid/phone/PairingActivity;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 62
    return-void
.end method

.method private static final onInit$lambda$0(Lcom/rokid/phone/PairingActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "this$0"    # Lcom/rokid/phone/PairingActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 34
    invoke-direct {p0}, Lcom/rokid/phone/PairingActivity;->startPairing()V

    return-void
.end method

.method private static final onInit$lambda$1(Lcom/rokid/phone/PairingActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "this$0"    # Lcom/rokid/phone/PairingActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 35
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->finish()V

    return-void
.end method

.method private final showPairFailure()V
    .locals 4

    .line 100
    iget-boolean v0, p0, Lcom/rokid/phone/PairingActivity;->completed:Z

    if-eqz v0, :cond_0

    return-void

    .line 101
    :cond_0
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->progress:Landroid/widget/ProgressBar;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    .line 102
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvPairHint:Landroid/widget/TextView;

    sget v1, Lcom/rokid/phone/R$string;->demo_pair_failed:I

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v1, v3}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 103
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->btnRetry:Landroidx/appcompat/widget/AppCompatButton;

    invoke-virtual {v0, v2}, Landroidx/appcompat/widget/AppCompatButton;->setVisibility(I)V

    .line 104
    return-void
.end method

.method private final startPairing()V
    .locals 8

    .line 65
    iget-boolean v0, p0, Lcom/rokid/phone/PairingActivity;->completed:Z

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/rokid/phone/PairingActivity;->device:Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    invoke-virtual {v0}, Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;->getAddress()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_0

    .line 66
    :cond_0
    iget-object v0, p0, Lcom/rokid/phone/PairingActivity;->pairJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 67
    :cond_1
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v0}, Lcom/rokid/phone/DeviceLinkerManager;->disconnectBt()V

    .line 68
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->progress:Landroid/widget/ProgressBar;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/widget/ProgressBar;->setVisibility(I)V

    .line 69
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->btnRetry:Landroidx/appcompat/widget/AppCompatButton;

    const/16 v3, 0x8

    invoke-virtual {v0, v3}, Landroidx/appcompat/widget/AppCompatButton;->setVisibility(I)V

    .line 70
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvPairHint:Landroid/widget/TextView;

    sget v3, Lcom/rokid/phone/R$string;->demo_pair_preparing:I

    new-array v4, v2, [Ljava/lang/Object;

    invoke-static {v3, v4}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 71
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvBluetoothState:Landroid/widget/TextView;

    sget v3, Lcom/rokid/phone/R$string;->demo_pair_bluetooth_waiting:I

    new-array v4, v2, [Ljava/lang/Object;

    invoke-static {v3, v4}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 72
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvP2PState:Landroid/widget/TextView;

    sget v3, Lcom/rokid/phone/R$string;->demo_pair_p2p_waiting:I

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v3, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 73
    move-object v0, p0

    check-cast v0, Landroidx/lifecycle/LifecycleOwner;

    invoke-static {v0}, Landroidx/lifecycle/LifecycleOwnerKt;->getLifecycleScope(Landroidx/lifecycle/LifecycleOwner;)Landroidx/lifecycle/LifecycleCoroutineScope;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Lkotlinx/coroutines/CoroutineScope;

    new-instance v0, Lcom/rokid/phone/PairingActivity$startPairing$1;

    invoke-direct {v0, p0, v1}, Lcom/rokid/phone/PairingActivity$startPairing$1;-><init>(Lcom/rokid/phone/PairingActivity;Lkotlin/coroutines/Continuation;)V

    move-object v5, v0

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/phone/PairingActivity;->pairJob:Lkotlinx/coroutines/Job;

    .line 84
    return-void

    .line 65
    :cond_2
    :goto_0
    return-void
.end method


# virtual methods
.method public bridge synthetic initViewBinding()Landroidx/viewbinding/ViewBinding;
    .locals 1

    .line 19
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->initViewBinding()Lcom/rokid/phone/databinding/ActivityPairingBinding;

    move-result-object v0

    check-cast v0, Landroidx/viewbinding/ViewBinding;

    return-object v0
.end method

.method public initViewBinding()Lcom/rokid/phone/databinding/ActivityPairingBinding;
    .locals 2

    .line 25
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/phone/databinding/ActivityPairingBinding;->inflate(Landroid/view/LayoutInflater;)Lcom/rokid/phone/databinding/ActivityPairingBinding;

    move-result-object v0

    const-string v1, "inflate(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method protected onDestroy()V
    .locals 3

    .line 107
    iget-object v0, p0, Lcom/rokid/phone/PairingActivity;->pairJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 108
    :cond_0
    invoke-super {p0}, Lcom/rokid/phone/base/BaseActivity;->onDestroy()V

    .line 109
    return-void
.end method

.method public onInit(Landroid/os/Bundle;)V
    .locals 6
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 28
    new-instance v0, Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    .line 29
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    const-string v2, "device_name"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, ""

    if-nez v1, :cond_0

    move-object v1, v2

    .line 30
    :cond_0
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getIntent()Landroid/content/Intent;

    move-result-object v3

    const-string v4, "device_address"

    invoke-virtual {v3, v4}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_0

    :cond_1
    move-object v2, v3

    .line 31
    :goto_0
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getIntent()Landroid/content/Intent;

    move-result-object v3

    const-string v4, "device_type"

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    .line 28
    invoke-direct {v0, v1, v2, v3}, Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    iput-object v0, p0, Lcom/rokid/phone/PairingActivity;->device:Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    .line 33
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvDeviceName:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/rokid/phone/PairingActivity;->device:Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    invoke-virtual {v1}, Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;->getName()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 34
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->btnRetry:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v1, Lcom/rokid/phone/PairingActivity$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/rokid/phone/PairingActivity$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/phone/PairingActivity;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 35
    invoke-virtual {p0}, Lcom/rokid/phone/PairingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->btnCancel:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v1, Lcom/rokid/phone/PairingActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/rokid/phone/PairingActivity$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/phone/PairingActivity;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 36
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v0}, Lcom/rokid/phone/DeviceLinkerManager;->disconnectBt()V

    .line 37
    invoke-direct {p0}, Lcom/rokid/phone/PairingActivity;->observeConnection()V

    .line 38
    invoke-direct {p0}, Lcom/rokid/phone/PairingActivity;->startPairing()V

    .line 39
    return-void
.end method
