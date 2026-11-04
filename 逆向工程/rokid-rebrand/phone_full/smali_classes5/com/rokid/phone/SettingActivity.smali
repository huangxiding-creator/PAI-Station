.class public final Lcom/rokid/phone/SettingActivity;
.super Lcom/rokid/phone/base/BaseActivity;
.source "SettingActivity.kt"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/rokid/phone/base/BaseActivity<",
        "Lcom/rokid/phone/databinding/ActivitySettingBinding;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000b\n\u0002\u0008\u0002\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001B\u0007\u00a2\u0006\u0004\u0008\u0003\u0010\u0004J\u0008\u0010\u0005\u001a\u00020\u0002H\u0016J\u0012\u0010\u0006\u001a\u00020\u00072\u0008\u0010\u0008\u001a\u0004\u0018\u00010\tH\u0016J\u0008\u0010\n\u001a\u00020\u0007H\u0002J\u0008\u0010\u000b\u001a\u00020\u0007H\u0002J\u0010\u0010\u000c\u001a\u00020\u00072\u0006\u0010\r\u001a\u00020\u000eH\u0002J\u0010\u0010\u000f\u001a\u00020\u00072\u0006\u0010\r\u001a\u00020\u000eH\u0002\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/phone/SettingActivity;",
        "Lcom/rokid/phone/base/BaseActivity;",
        "Lcom/rokid/phone/databinding/ActivitySettingBinding;",
        "<init>",
        "()V",
        "initViewBinding",
        "onInit",
        "",
        "savedInstanceState",
        "Landroid/os/Bundle;",
        "observeStatus",
        "updateBattery",
        "updateP2p",
        "connected",
        "",
        "updateBluetooth",
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


# direct methods
.method public static synthetic $r8$lambda$4T8U0XxVYOcoO8aRxYi71Asty5Q(Lcom/rokid/phone/SettingActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/SettingActivity;->onInit$lambda$0(Lcom/rokid/phone/SettingActivity;Landroid/view/View;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Lcom/rokid/phone/base/BaseActivity;-><init>()V

    return-void
.end method

.method public static final synthetic access$getBinding(Lcom/rokid/phone/SettingActivity;)Lcom/rokid/phone/databinding/ActivitySettingBinding;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/SettingActivity;

    .line 14
    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivitySettingBinding;

    return-object v0
.end method

.method public static final synthetic access$updateBattery(Lcom/rokid/phone/SettingActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/SettingActivity;

    .line 14
    invoke-direct {p0}, Lcom/rokid/phone/SettingActivity;->updateBattery()V

    return-void
.end method

.method public static final synthetic access$updateBluetooth(Lcom/rokid/phone/SettingActivity;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/SettingActivity;
    .param p1, "connected"    # Z

    .line 14
    invoke-direct {p0, p1}, Lcom/rokid/phone/SettingActivity;->updateBluetooth(Z)V

    return-void
.end method

.method public static final synthetic access$updateP2p(Lcom/rokid/phone/SettingActivity;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/SettingActivity;
    .param p1, "connected"    # Z

    .line 14
    invoke-direct {p0, p1}, Lcom/rokid/phone/SettingActivity;->updateP2p(Z)V

    return-void
.end method

.method private final observeStatus()V
    .locals 7

    .line 28
    move-object v0, p0

    check-cast v0, Landroidx/lifecycle/LifecycleOwner;

    invoke-static {v0}, Landroidx/lifecycle/LifecycleOwnerKt;->getLifecycleScope(Landroidx/lifecycle/LifecycleOwner;)Landroidx/lifecycle/LifecycleCoroutineScope;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Lkotlinx/coroutines/CoroutineScope;

    new-instance v0, Lcom/rokid/phone/SettingActivity$observeStatus$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v2}, Lcom/rokid/phone/SettingActivity$observeStatus$1;-><init>(Lcom/rokid/phone/SettingActivity;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 38
    return-void
.end method

.method private static final onInit$lambda$0(Lcom/rokid/phone/SettingActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "this$0"    # Lcom/rokid/phone/SettingActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 19
    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->finish()V

    return-void
.end method

.method private final updateBattery()V
    .locals 4

    .line 41
    sget-object v0, Lcom/rokid/phone/data/DeviceStatus;->INSTANCE:Lcom/rokid/phone/data/DeviceStatus;

    invoke-virtual {v0}, Lcom/rokid/phone/data/DeviceStatus;->getPowerValue()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    .line 42
    .local v0, "power":I
    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v1

    check-cast v1, Lcom/rokid/phone/databinding/ActivitySettingBinding;

    iget-object v1, v1, Lcom/rokid/phone/databinding/ActivitySettingBinding;->tvBatteryStatus:Landroid/widget/TextView;

    if-gtz v0, :cond_0

    .line 43
    sget v2, Lcom/rokid/phone/R$string;->demo_battery_unknown:I

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    goto :goto_1

    .line 46
    :cond_0
    sget-object v2, Lcom/rokid/phone/data/DeviceStatus;->INSTANCE:Lcom/rokid/phone/data/DeviceStatus;

    invoke-virtual {v2}, Lcom/rokid/phone/data/DeviceStatus;->getCharging()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v2

    invoke-interface {v2}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 47
    sget v2, Lcom/rokid/phone/R$string;->demo_battery_charging_short:I

    goto :goto_0

    .line 49
    :cond_1
    sget v2, Lcom/rokid/phone/R$string;->demo_battery_level_short:I

    .line 51
    :goto_0
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    .line 45
    invoke-static {v2, v3}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    .line 42
    :goto_1
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 54
    return-void
.end method

.method private final updateBluetooth(Z)V
    .locals 3
    .param p1, "connected"    # Z

    .line 63
    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivitySettingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivitySettingBinding;->tvBluetoothStatus:Landroid/widget/TextView;

    .line 64
    if-eqz p1, :cond_0

    sget v1, Lcom/rokid/phone/R$string;->demo_bluetooth_connected:I

    goto :goto_0

    :cond_0
    sget v1, Lcom/rokid/phone/R$string;->demo_bluetooth_disconnected:I

    :goto_0
    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    .line 63
    invoke-static {v1, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 66
    return-void
.end method

.method private final updateP2p(Z)V
    .locals 3
    .param p1, "connected"    # Z

    .line 57
    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivitySettingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivitySettingBinding;->tvP2PStatus:Landroid/widget/TextView;

    .line 58
    if-eqz p1, :cond_0

    sget v1, Lcom/rokid/phone/R$string;->demo_p2p_connected_short:I

    goto :goto_0

    :cond_0
    sget v1, Lcom/rokid/phone/R$string;->demo_p2p_disconnected_short:I

    :goto_0
    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    .line 57
    invoke-static {v1, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 60
    return-void
.end method


# virtual methods
.method public bridge synthetic initViewBinding()Landroidx/viewbinding/ViewBinding;
    .locals 1

    .line 14
    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->initViewBinding()Lcom/rokid/phone/databinding/ActivitySettingBinding;

    move-result-object v0

    check-cast v0, Landroidx/viewbinding/ViewBinding;

    return-object v0
.end method

.method public initViewBinding()Lcom/rokid/phone/databinding/ActivitySettingBinding;
    .locals 2

    .line 16
    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/phone/databinding/ActivitySettingBinding;->inflate(Landroid/view/LayoutInflater;)Lcom/rokid/phone/databinding/ActivitySettingBinding;

    move-result-object v0

    const-string v1, "inflate(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method public onInit(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 19
    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivitySettingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivitySettingBinding;->btnBack:Landroid/widget/ImageButton;

    new-instance v1, Lcom/rokid/phone/SettingActivity$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/rokid/phone/SettingActivity$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/phone/SettingActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 20
    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivitySettingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivitySettingBinding;->tvDeviceName:Landroid/widget/TextView;

    sget-object v1, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v1}, Lcom/rokid/phone/DeviceLinkerManager;->getDeviceName()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 21
    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivitySettingBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivitySettingBinding;->tvAppVersion:Landroid/widget/TextView;

    .line 22
    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {p0}, Lcom/rokid/phone/SettingActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v1

    iget-object v1, v1, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    const-string v1, "1.0"

    :goto_0
    check-cast v1, Ljava/lang/CharSequence;

    .line 21
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 23
    invoke-direct {p0}, Lcom/rokid/phone/SettingActivity;->observeStatus()V

    .line 24
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v0}, Lcom/rokid/phone/DeviceLinkerManager;->refreshDeviceStatus()V

    .line 25
    return-void
.end method
