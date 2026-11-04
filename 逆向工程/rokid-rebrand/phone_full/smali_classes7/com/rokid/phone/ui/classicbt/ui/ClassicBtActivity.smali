.class public final Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;
.super Lcom/rokid/phone/base/BaseActivity;
.source "ClassicBtActivity.kt"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/rokid/phone/base/BaseActivity<",
        "Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000J\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001B\u0007\u00a2\u0006\u0004\u0008\u0003\u0010\u0004J\u0008\u0010\u0010\u001a\u00020\u0002H\u0016J\u0012\u0010\u0011\u001a\u00020\u00122\u0008\u0010\u0013\u001a\u0004\u0018\u00010\u0014H\u0016J\u0008\u0010\u0015\u001a\u00020\u0012H\u0002J\u0008\u0010\u0016\u001a\u00020\u0012H\u0002J\u0010\u0010\u0017\u001a\u00020\u00122\u0006\u0010\u0018\u001a\u00020\u0019H\u0002J\u0008\u0010\u001a\u001a\u00020\u0012H\u0002J\u0008\u0010\u001b\u001a\u00020\u0012H\u0002J\u0008\u0010\u001c\u001a\u00020\u0012H\u0014R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u000b\u001a\u0008\u0012\u0004\u0012\u00020\r0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u000e\u001a\u0008\u0012\u0004\u0012\u00020\u000f0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001d"
    }
    d2 = {
        "Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;",
        "Lcom/rokid/phone/base/BaseActivity;",
        "Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;",
        "<init>",
        "()V",
        "repository",
        "Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;",
        "adapter",
        "Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;",
        "rotation",
        "Landroid/view/animation/RotateAnimation;",
        "permissionLauncher",
        "Landroidx/activity/result/ActivityResultLauncher;",
        "",
        "enableBluetoothLauncher",
        "Landroid/content/Intent;",
        "initViewBinding",
        "onInit",
        "",
        "savedInstanceState",
        "Landroid/os/Bundle;",
        "ensureBluetoothEnabled",
        "startScan",
        "connect",
        "device",
        "Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;",
        "startLoading",
        "stopLoading",
        "onDestroy",
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


# instance fields
.field private final adapter:Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;

.field private final enableBluetoothLauncher:Landroidx/activity/result/ActivityResultLauncher;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/activity/result/ActivityResultLauncher<",
            "Landroid/content/Intent;",
            ">;"
        }
    .end annotation
.end field

.field private final permissionLauncher:Landroidx/activity/result/ActivityResultLauncher;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/activity/result/ActivityResultLauncher<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final repository:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

.field private rotation:Landroid/view/animation/RotateAnimation;


# direct methods
.method public static synthetic $r8$lambda$2rggnHevResFM1LZILj7vediXOY(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->onInit$lambda$3(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$DsmOnhXgPmiZ1biaUf1uvc-vapo(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Z)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->permissionLauncher$lambda$0(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Z)V

    return-void
.end method

.method public static synthetic $r8$lambda$TDIVJ3jdR5hbhZOkc0Lw7U0KeVs(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroidx/activity/result/ActivityResult;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->enableBluetoothLauncher$lambda$1(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroidx/activity/result/ActivityResult;)V

    return-void
.end method

.method public static synthetic $r8$lambda$TTXEldGbUAroawP39hPNYxVZfMg(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->onInit$lambda$4(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$YFEuwMNcopym69QuZHs4qKFMQFA(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->onInit$lambda$2(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroid/view/View;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 25
    invoke-direct {p0}, Lcom/rokid/phone/base/BaseActivity;-><init>()V

    .line 26
    new-instance v0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    invoke-direct {v0}, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;-><init>()V

    iput-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->repository:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    .line 27
    new-instance v0, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;

    new-instance v1, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$adapter$1;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$adapter$1;-><init>(Ljava/lang/Object;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-direct {v0, v1}, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;-><init>(Lkotlin/jvm/functions/Function1;)V

    iput-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->adapter:Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;

    .line 30
    nop

    .line 31
    new-instance v0, Landroidx/activity/result/contract/ActivityResultContracts$RequestPermission;

    invoke-direct {v0}, Landroidx/activity/result/contract/ActivityResultContracts$RequestPermission;-><init>()V

    check-cast v0, Landroidx/activity/result/contract/ActivityResultContract;

    .line 32
    nop

    .line 30
    new-instance v1, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$$ExternalSyntheticLambda3;-><init>(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)V

    invoke-virtual {p0, v0, v1}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->registerForActivityResult(Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->permissionLauncher:Landroidx/activity/result/ActivityResultLauncher;

    .line 36
    nop

    .line 37
    new-instance v0, Landroidx/activity/result/contract/ActivityResultContracts$StartActivityForResult;

    invoke-direct {v0}, Landroidx/activity/result/contract/ActivityResultContracts$StartActivityForResult;-><init>()V

    check-cast v0, Landroidx/activity/result/contract/ActivityResultContract;

    .line 38
    nop

    .line 36
    new-instance v1, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$$ExternalSyntheticLambda4;-><init>(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)V

    invoke-virtual {p0, v0, v1}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->registerForActivityResult(Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->enableBluetoothLauncher:Landroidx/activity/result/ActivityResultLauncher;

    .line 25
    return-void
.end method

.method public static final synthetic access$connect(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;
    .param p1, "device"    # Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    .line 25
    invoke-direct {p0, p1}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->connect(Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;)V

    return-void
.end method

.method public static final synthetic access$getAdapter$p(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;

    .line 25
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->adapter:Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;

    return-object v0
.end method

.method public static final synthetic access$getBinding(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;

    .line 25
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    return-object v0
.end method

.method public static final synthetic access$getRepository$p(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;

    .line 25
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->repository:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    return-object v0
.end method

.method public static final synthetic access$stopLoading(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;

    .line 25
    invoke-direct {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->stopLoading()V

    return-void
.end method

.method private final connect(Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;)V
    .locals 2
    .param p1, "device"    # Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    .line 95
    sget-object v0, Lcom/rokid/phone/PairingActivity;->Companion:Lcom/rokid/phone/PairingActivity$Companion;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-virtual {v0, v1, p1}, Lcom/rokid/phone/PairingActivity$Companion;->start(Landroid/content/Context;Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;)V

    .line 96
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->finish()V

    .line 97
    return-void
.end method

.method private static final enableBluetoothLauncher$lambda$1(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroidx/activity/result/ActivityResult;)V
    .locals 2
    .param p0, "this$0"    # Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;
    .param p1, "result"    # Landroidx/activity/result/ActivityResult;

    const-string v0, "result"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 39
    invoke-virtual {p1}, Landroidx/activity/result/ActivityResult;->getResultCode()I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    invoke-direct {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->startScan()V

    .line 40
    :cond_0
    return-void
.end method

.method private final ensureBluetoothEnabled()V
    .locals 3

    .line 74
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    if-lt v0, v1, :cond_0

    .line 75
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    const-string v1, "android.permission.BLUETOOTH_SCAN"

    invoke-static {v0, v1}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    .line 78
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->permissionLauncher:Landroidx/activity/result/ActivityResultLauncher;

    invoke-virtual {v0, v1}, Landroidx/activity/result/ActivityResultLauncher;->launch(Ljava/lang/Object;)V

    .line 79
    return-void

    .line 81
    :cond_0
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_1

    move v1, v2

    :cond_1
    if-nez v1, :cond_2

    .line 82
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->enableBluetoothLauncher:Landroidx/activity/result/ActivityResultLauncher;

    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.bluetooth.adapter.action.REQUEST_ENABLE"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroidx/activity/result/ActivityResultLauncher;->launch(Ljava/lang/Object;)V

    .line 83
    return-void

    .line 85
    :cond_2
    invoke-direct {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->startScan()V

    .line 86
    return-void
.end method

.method private static final onInit$lambda$2(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "this$0"    # Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 46
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->finish()V

    return-void
.end method

.method private static final onInit$lambda$3(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "this$0"    # Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 47
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->finish()V

    return-void
.end method

.method private static final onInit$lambda$4(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "this$0"    # Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 48
    invoke-direct {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->startScan()V

    return-void
.end method

.method private static final permissionLauncher$lambda$0(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Z)V
    .locals 0
    .param p0, "this$0"    # Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;
    .param p1, "granted"    # Z

    .line 33
    if-eqz p1, :cond_0

    invoke-direct {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->ensureBluetoothEnabled()V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->finish()V

    .line 34
    :goto_0
    return-void
.end method

.method private final startLoading()V
    .locals 9

    .line 100
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->ivLoadSmall:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 101
    new-instance v0, Landroid/view/animation/RotateAnimation;

    .line 102
    nop

    .line 103
    nop

    .line 104
    nop

    .line 105
    nop

    .line 106
    nop

    .line 107
    nop

    .line 101
    const/4 v3, 0x0

    const/high16 v4, 0x43b40000    # 360.0f

    const/4 v5, 0x1

    const/high16 v6, 0x3f000000    # 0.5f

    const/4 v7, 0x1

    const/high16 v8, 0x3f000000    # 0.5f

    move-object v2, v0

    invoke-direct/range {v2 .. v8}, Landroid/view/animation/RotateAnimation;-><init>(FFIFIF)V

    .line 108
    move-object v1, v0

    .local v1, "$this$startLoading_u24lambda_u245":Landroid/view/animation/RotateAnimation;
    const/4 v2, 0x0

    .line 109
    .local v2, "$i$a$-apply-ClassicBtActivity$startLoading$1":I
    const-wide/16 v3, 0x384

    invoke-virtual {v1, v3, v4}, Landroid/view/animation/RotateAnimation;->setDuration(J)V

    .line 110
    const/4 v3, -0x1

    invoke-virtual {v1, v3}, Landroid/view/animation/RotateAnimation;->setRepeatCount(I)V

    .line 111
    new-instance v3, Landroid/view/animation/LinearInterpolator;

    invoke-direct {v3}, Landroid/view/animation/LinearInterpolator;-><init>()V

    check-cast v3, Landroid/view/animation/Interpolator;

    invoke-virtual {v1, v3}, Landroid/view/animation/RotateAnimation;->setInterpolator(Landroid/view/animation/Interpolator;)V

    .line 112
    nop

    .line 108
    .end local v1    # "$this$startLoading_u24lambda_u245":Landroid/view/animation/RotateAnimation;
    .end local v2    # "$i$a$-apply-ClassicBtActivity$startLoading$1":I
    nop

    .line 101
    iput-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->rotation:Landroid/view/animation/RotateAnimation;

    .line 113
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->ivLoadSmall:Landroid/widget/ImageView;

    iget-object v1, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->rotation:Landroid/view/animation/RotateAnimation;

    check-cast v1, Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V

    .line 114
    return-void
.end method

.method private final startScan()V
    .locals 2

    .line 89
    invoke-direct {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->startLoading()V

    .line 90
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->tvListTip2:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 91
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->repository:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    invoke-virtual {v0}, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->startScan()V

    .line 92
    return-void
.end method

.method private final stopLoading()V
    .locals 2

    .line 117
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->ivLoadSmall:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->clearAnimation()V

    .line 118
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->ivLoadSmall:Landroid/widget/ImageView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 119
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->rotation:Landroid/view/animation/RotateAnimation;

    .line 120
    return-void
.end method


# virtual methods
.method public bridge synthetic initViewBinding()Landroidx/viewbinding/ViewBinding;
    .locals 1

    .line 25
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->initViewBinding()Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    move-result-object v0

    check-cast v0, Landroidx/viewbinding/ViewBinding;

    return-object v0
.end method

.method public initViewBinding()Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;
    .locals 2

    .line 43
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->inflate(Landroid/view/LayoutInflater;)Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    move-result-object v0

    const-string v1, "inflate(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method protected onDestroy()V
    .locals 1

    .line 123
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->repository:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    invoke-virtual {v0}, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->stopScan()V

    .line 124
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->repository:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    invoke-virtual {v0}, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->removeListener()V

    .line 125
    invoke-super {p0}, Lcom/rokid/phone/base/BaseActivity;->onDestroy()V

    .line 126
    return-void
.end method

.method public onInit(Landroid/os/Bundle;)V
    .locals 8
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 46
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->ivBack:Landroid/widget/ImageView;

    new-instance v1, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 47
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->tvSkip:Landroid/widget/TextView;

    new-instance v1, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 48
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->ivLoadReflesh:Landroid/widget/ImageView;

    new-instance v1, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$$ExternalSyntheticLambda2;-><init>(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 49
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->rvDiscoveredDevices:Landroidx/recyclerview/widget/RecyclerView;

    new-instance v1, Landroidx/recyclerview/widget/LinearLayoutManager;

    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    invoke-direct {v1, v2}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;)V

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView$LayoutManager;

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$LayoutManager;)V

    .line 50
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->rvDiscoveredDevices:Landroidx/recyclerview/widget/RecyclerView;

    .line 51
    new-instance v1, Landroidx/recyclerview/widget/DividerItemDecoration;

    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Landroidx/recyclerview/widget/DividerItemDecoration;-><init>(Landroid/content/Context;I)V

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView$ItemDecoration;

    .line 50
    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->addItemDecoration(Landroidx/recyclerview/widget/RecyclerView$ItemDecoration;)V

    .line 53
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->rvDiscoveredDevices:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v1, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->adapter:Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView$Adapter;

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$Adapter;)V

    .line 54
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->repository:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    invoke-virtual {v0}, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->addListener()V

    .line 56
    move-object v0, p0

    check-cast v0, Landroidx/lifecycle/LifecycleOwner;

    invoke-static {v0}, Landroidx/lifecycle/LifecycleOwnerKt;->getLifecycleScope(Landroidx/lifecycle/LifecycleOwner;)Landroidx/lifecycle/LifecycleCoroutineScope;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Lkotlinx/coroutines/CoroutineScope;

    new-instance v0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$onInit$4;

    const/4 v7, 0x0

    invoke-direct {v0, p0, v7}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$onInit$4;-><init>(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 62
    move-object v0, p0

    check-cast v0, Landroidx/lifecycle/LifecycleOwner;

    invoke-static {v0}, Landroidx/lifecycle/LifecycleOwnerKt;->getLifecycleScope(Landroidx/lifecycle/LifecycleOwner;)Landroidx/lifecycle/LifecycleCoroutineScope;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Lkotlinx/coroutines/CoroutineScope;

    new-instance v0, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$onInit$5;

    invoke-direct {v0, p0, v7}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity$onInit$5;-><init>(Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 70
    invoke-direct {p0}, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;->ensureBluetoothEnabled()V

    .line 71
    return-void
.end method
