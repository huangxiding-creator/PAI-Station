.class public final Lcom/rokid/phone/ui/MainPhoneActivity;
.super Lcom/rokid/phone/base/BaseActivity;
.source "MainPhoneActivity.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/phone/ui/MainPhoneActivity$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/rokid/phone/base/BaseActivity<",
        "Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nMainPhoneActivity.kt\nKotlin\n*S Kotlin\n*F\n+ 1 MainPhoneActivity.kt\ncom/rokid/phone/ui/MainPhoneActivity\n+ 2 _Arrays.kt\nkotlin/collections/ArraysKt___ArraysKt\n+ 3 ArraysJVM.kt\nkotlin/collections/ArraysKt__ArraysJVMKt\n+ 4 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,255:1\n3829#2:256\n4344#2,2:257\n37#3:259\n36#3,3:260\n1740#4,3:263\n*S KotlinDebug\n*F\n+ 1 MainPhoneActivity.kt\ncom/rokid/phone/ui/MainPhoneActivity\n*L\n128#1:256\n128#1:257,2\n132#1:259\n132#1:260,3\n61#1:263,3\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000L\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0011\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u000c\u0018\u0000 &2\u0008\u0012\u0004\u0012\u00020\u00020\u0001:\u0001&B\u0007\u00a2\u0006\u0004\u0008\u0003\u0010\u0004J\u0008\u0010\u0017\u001a\u00020\u0002H\u0016J\u0012\u0010\u0018\u001a\u00020\u00192\u0008\u0010\u001a\u001a\u0004\u0018\u00010\u001bH\u0016J\u0008\u0010\u001c\u001a\u00020\u0019H\u0002J\u0008\u0010\u001d\u001a\u00020\u0019H\u0002J\u0008\u0010\u001e\u001a\u00020\u0019H\u0002J\u0008\u0010\u001f\u001a\u00020\u0019H\u0002J\u0010\u0010 \u001a\u00020\u00192\u0006\u0010!\u001a\u00020\u000eH\u0002J\u0010\u0010\"\u001a\u00020\u00192\u0006\u0010!\u001a\u00020\u000eH\u0002J\u0008\u0010#\u001a\u00020\u0019H\u0002J\u0008\u0010$\u001a\u00020\u0019H\u0002J\u0008\u0010%\u001a\u00020\u0019H\u0014R\u001b\u0010\u0005\u001a\u00020\u00068BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\t\u0010\n\u001a\u0004\u0008\u0007\u0010\u0008R\u0010\u0010\u000b\u001a\u0004\u0018\u00010\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u000eX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u000f\u001a\u0008\u0012\u0004\u0012\u00020\u00110\u0010X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0012R\u001a\u0010\u0013\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00110\u00100\u0014X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0015\u001a\u0008\u0012\u0004\u0012\u00020\u00160\u0014X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\'"
    }
    d2 = {
        "Lcom/rokid/phone/ui/MainPhoneActivity;",
        "Lcom/rokid/phone/base/BaseActivity;",
        "Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;",
        "<init>",
        "()V",
        "phoneEngineService",
        "Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;",
        "getPhoneEngineService",
        "()Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;",
        "phoneEngineService$delegate",
        "Lkotlin/Lazy;",
        "autoConnectJob",
        "Lkotlinx/coroutines/Job;",
        "sdkReady",
        "",
        "requiredPermissions",
        "",
        "",
        "[Ljava/lang/String;",
        "permissionLauncher",
        "Landroidx/activity/result/ActivityResultLauncher;",
        "enableBluetoothLauncher",
        "Landroid/content/Intent;",
        "initViewBinding",
        "onInit",
        "",
        "savedInstanceState",
        "Landroid/os/Bundle;",
        "continueStartup",
        "initializeSdk",
        "onSdkReady",
        "scheduleAutoConnect",
        "updateConnectionState",
        "connected",
        "updateP2pState",
        "updateBattery",
        "openAiVision",
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
.field private static final Companion:Lcom/rokid/phone/ui/MainPhoneActivity$Companion;

.field public static final TAG:Ljava/lang/String; = "MainPhoneActivity"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field


# instance fields
.field private autoConnectJob:Lkotlinx/coroutines/Job;

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
            "[",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final phoneEngineService$delegate:Lkotlin/Lazy;

.field private final requiredPermissions:[Ljava/lang/String;

.field private sdkReady:Z


# direct methods
.method public static synthetic $r8$lambda$KXo4EyjMYLfeT9e6tEuC-iJ-rMc()Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;
    .locals 1

    invoke-static {}, Lcom/rokid/phone/ui/MainPhoneActivity;->phoneEngineService_delegate$lambda$0()Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;

    move-result-object v0

    return-object v0
.end method

.method public static synthetic $r8$lambda$VJ-foPGEgjlhWY6GGHVH1lsrVSQ(Lcom/rokid/phone/ui/MainPhoneActivity;Landroidx/activity/result/ActivityResult;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/MainPhoneActivity;->enableBluetoothLauncher$lambda$3(Lcom/rokid/phone/ui/MainPhoneActivity;Landroidx/activity/result/ActivityResult;)V

    return-void
.end method

.method public static synthetic $r8$lambda$dX-yBrc-ge-rU5G3TNSRwOuXKNI(Lcom/rokid/phone/ui/MainPhoneActivity;Ljava/util/Map;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/MainPhoneActivity;->permissionLauncher$lambda$2(Lcom/rokid/phone/ui/MainPhoneActivity;Ljava/util/Map;)V

    return-void
.end method

.method public static synthetic $r8$lambda$ekm4n5H7WIbyOyG9ND-lI9VAlB8(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/MainPhoneActivity;->onInit$lambda$5(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$elaKtJeTMXmRu_NLa4KRfWzEI90(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/MainPhoneActivity;->onInit$lambda$8(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$hN_QIG7gPfQwg1-HrRa1pktzPRc(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/MainPhoneActivity;->onInit$lambda$4(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$pQU4ppAdWXQU4Lva5ghbOH5cF-4(Landroid/view/View;)V
    .locals 0

    invoke-static {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->onInit$lambda$6(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$yBZeFhtdG5FlLAChGpQT_hWQCsI(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/MainPhoneActivity;->onInit$lambda$7(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/phone/ui/MainPhoneActivity$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/phone/ui/MainPhoneActivity$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/phone/ui/MainPhoneActivity;->Companion:Lcom/rokid/phone/ui/MainPhoneActivity$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 6

    .line 39
    invoke-direct {p0}, Lcom/rokid/phone/base/BaseActivity;-><init>()V

    .line 40
    new-instance v0, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->phoneEngineService$delegate:Lkotlin/Lazy;

    .line 44
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    const/4 v2, 0x2

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x3

    if-lt v0, v1, :cond_0

    .line 46
    new-array v0, v5, [Ljava/lang/String;

    const-string v1, "android.permission.BLUETOOTH_SCAN"

    aput-object v1, v0, v4

    .line 47
    const-string v1, "android.permission.BLUETOOTH_CONNECT"

    aput-object v1, v0, v3

    .line 46
    nop

    .line 48
    const-string v1, "android.permission.NEARBY_WIFI_DEVICES"

    aput-object v1, v0, v2

    .line 46
    goto :goto_0

    .line 52
    :cond_0
    new-array v0, v5, [Ljava/lang/String;

    const-string v1, "android.permission.BLUETOOTH"

    aput-object v1, v0, v4

    .line 53
    const-string v1, "android.permission.BLUETOOTH_ADMIN"

    aput-object v1, v0, v3

    .line 52
    nop

    .line 54
    const-string v1, "android.permission.ACCESS_FINE_LOCATION"

    aput-object v1, v0, v2

    .line 52
    nop

    .line 44
    :goto_0
    iput-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->requiredPermissions:[Ljava/lang/String;

    .line 58
    nop

    .line 59
    new-instance v0, Landroidx/activity/result/contract/ActivityResultContracts$RequestMultiplePermissions;

    invoke-direct {v0}, Landroidx/activity/result/contract/ActivityResultContracts$RequestMultiplePermissions;-><init>()V

    check-cast v0, Landroidx/activity/result/contract/ActivityResultContract;

    .line 60
    nop

    .line 58
    new-instance v1, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/phone/ui/MainPhoneActivity;)V

    invoke-virtual {p0, v0, v1}, Lcom/rokid/phone/ui/MainPhoneActivity;->registerForActivityResult(Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->permissionLauncher:Landroidx/activity/result/ActivityResultLauncher;

    .line 68
    nop

    .line 69
    new-instance v0, Landroidx/activity/result/contract/ActivityResultContracts$StartActivityForResult;

    invoke-direct {v0}, Landroidx/activity/result/contract/ActivityResultContracts$StartActivityForResult;-><init>()V

    check-cast v0, Landroidx/activity/result/contract/ActivityResultContract;

    .line 70
    nop

    .line 68
    new-instance v1, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda2;-><init>(Lcom/rokid/phone/ui/MainPhoneActivity;)V

    invoke-virtual {p0, v0, v1}, Lcom/rokid/phone/ui/MainPhoneActivity;->registerForActivityResult(Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->enableBluetoothLauncher:Landroidx/activity/result/ActivityResultLauncher;

    .line 39
    return-void
.end method

.method public static final synthetic access$getBinding(Lcom/rokid/phone/ui/MainPhoneActivity;)Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ui/MainPhoneActivity;

    .line 39
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    return-object v0
.end method

.method public static final synthetic access$getPhoneEngineService(Lcom/rokid/phone/ui/MainPhoneActivity;)Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ui/MainPhoneActivity;

    .line 39
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getPhoneEngineService()Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$onSdkReady(Lcom/rokid/phone/ui/MainPhoneActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/ui/MainPhoneActivity;

    .line 39
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->onSdkReady()V

    return-void
.end method

.method public static final synthetic access$scheduleAutoConnect(Lcom/rokid/phone/ui/MainPhoneActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/ui/MainPhoneActivity;

    .line 39
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->scheduleAutoConnect()V

    return-void
.end method

.method public static final synthetic access$setSdkReady$p(Lcom/rokid/phone/ui/MainPhoneActivity;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/ui/MainPhoneActivity;
    .param p1, "<set-?>"    # Z

    .line 39
    iput-boolean p1, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->sdkReady:Z

    return-void
.end method

.method public static final synthetic access$updateBattery(Lcom/rokid/phone/ui/MainPhoneActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/ui/MainPhoneActivity;

    .line 39
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->updateBattery()V

    return-void
.end method

.method public static final synthetic access$updateConnectionState(Lcom/rokid/phone/ui/MainPhoneActivity;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/ui/MainPhoneActivity;
    .param p1, "connected"    # Z

    .line 39
    invoke-direct {p0, p1}, Lcom/rokid/phone/ui/MainPhoneActivity;->updateConnectionState(Z)V

    return-void
.end method

.method public static final synthetic access$updateP2pState(Lcom/rokid/phone/ui/MainPhoneActivity;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/ui/MainPhoneActivity;
    .param p1, "connected"    # Z

    .line 39
    invoke-direct {p0, p1}, Lcom/rokid/phone/ui/MainPhoneActivity;->updateP2pState(Z)V

    return-void
.end method

.method private final continueStartup()V
    .locals 13

    .line 128
    iget-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->requiredPermissions:[Ljava/lang/String;

    .local v0, "$this$filter$iv":[Ljava/lang/Object;
    const/4 v1, 0x0

    .line 256
    .local v1, "$i$f$filter":I
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    check-cast v2, Ljava/util/Collection;

    .local v2, "destination$iv$iv":Ljava/util/Collection;
    move-object v3, v0

    .local v3, "$this$filterTo$iv$iv":[Ljava/lang/Object;
    const/4 v4, 0x0

    .line 257
    .local v4, "$i$f$filterTo":I
    array-length v5, v3

    const/4 v6, 0x0

    move v7, v6

    :goto_0
    const/4 v8, 0x1

    if-ge v7, v5, :cond_2

    aget-object v9, v3, v7

    .local v9, "element$iv$iv":Ljava/lang/Object;
    move-object v10, v9

    .local v10, "it":Ljava/lang/String;
    const/4 v11, 0x0

    .line 129
    .local v11, "$i$a$-filter-MainPhoneActivity$continueStartup$missing$1":I
    move-object v12, p0

    check-cast v12, Landroid/content/Context;

    invoke-static {v12, v10}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v12

    if-eqz v12, :cond_0

    goto :goto_1

    :cond_0
    move v8, v6

    .line 257
    .end local v10    # "it":Ljava/lang/String;
    .end local v11    # "$i$a$-filter-MainPhoneActivity$continueStartup$missing$1":I
    :goto_1
    if-eqz v8, :cond_1

    invoke-interface {v2, v9}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    .end local v9    # "element$iv$iv":Ljava/lang/Object;
    :cond_1
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 258
    :cond_2
    nop

    .end local v2    # "destination$iv$iv":Ljava/util/Collection;
    .end local v3    # "$this$filterTo$iv$iv":[Ljava/lang/Object;
    .end local v4    # "$i$f$filterTo":I
    check-cast v2, Ljava/util/List;

    .line 256
    nop

    .line 128
    .end local v0    # "$this$filter$iv":[Ljava/lang/Object;
    .end local v1    # "$i$f$filter":I
    move-object v0, v2

    .line 131
    .local v0, "missing":Ljava/util/List;
    move-object v1, v0

    check-cast v1, Ljava/util/Collection;

    invoke-interface {v1}, Ljava/util/Collection;->isEmpty()Z

    move-result v1

    xor-int/2addr v1, v8

    if-eqz v1, :cond_3

    .line 132
    iget-object v1, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->permissionLauncher:Landroidx/activity/result/ActivityResultLauncher;

    move-object v2, v0

    check-cast v2, Ljava/util/Collection;

    .local v2, "$this$toTypedArray$iv":Ljava/util/Collection;
    const/4 v3, 0x0

    .line 259
    .local v3, "$i$f$toTypedArray":I
    nop

    .line 260
    move-object v4, v2

    .line 262
    .local v4, "thisCollection$iv":Ljava/util/Collection;
    new-array v5, v6, [Ljava/lang/String;

    invoke-interface {v4, v5}, Ljava/util/Collection;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v2

    .line 132
    .end local v2    # "$this$toTypedArray$iv":Ljava/util/Collection;
    .end local v3    # "$i$f$toTypedArray":I
    .end local v4    # "thisCollection$iv":Ljava/util/Collection;
    invoke-virtual {v1, v2}, Landroidx/activity/result/ActivityResultLauncher;->launch(Ljava/lang/Object;)V

    .line 133
    return-void

    .line 136
    :cond_3
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v1

    .line 137
    .local v1, "adapter":Landroid/bluetooth/BluetoothAdapter;
    if-nez v1, :cond_4

    .line 138
    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    sget v3, Lcom/rokid/phone/R$string;->demo_this_device_does_not_support_bluetooth:I

    new-array v4, v6, [Ljava/lang/Object;

    invoke-static {v3, v4}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v2, v3, v8}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v2

    invoke-virtual {v2}, Landroid/widget/Toast;->show()V

    .line 139
    return-void

    .line 141
    :cond_4
    invoke-virtual {v1}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v2

    if-nez v2, :cond_5

    .line 142
    iget-object v2, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->enableBluetoothLauncher:Landroidx/activity/result/ActivityResultLauncher;

    new-instance v3, Landroid/content/Intent;

    const-string v4, "android.bluetooth.adapter.action.REQUEST_ENABLE"

    invoke-direct {v3, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Landroidx/activity/result/ActivityResultLauncher;->launch(Ljava/lang/Object;)V

    .line 143
    return-void

    .line 145
    :cond_5
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->initializeSdk()V

    .line 146
    return-void
.end method

.method private static final enableBluetoothLauncher$lambda$3(Lcom/rokid/phone/ui/MainPhoneActivity;Landroidx/activity/result/ActivityResult;)V
    .locals 4
    .param p0, "this$0"    # Lcom/rokid/phone/ui/MainPhoneActivity;
    .param p1, "it"    # Landroidx/activity/result/ActivityResult;

    const-string v0, "it"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 71
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v0

    if-ne v0, v1, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    move v0, v2

    :goto_0
    if-eqz v0, :cond_1

    .line 72
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->continueStartup()V

    goto :goto_1

    .line 74
    :cond_1
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    sget v3, Lcom/rokid/phone/R$string;->demo_bluetooth_is_off:I

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v3, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v0, v2, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 76
    :goto_1
    return-void
.end method

.method private final getPhoneEngineService()Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;
    .locals 1

    .line 40
    iget-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->phoneEngineService$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;

    return-object v0
.end method

.method private final initializeSdk()V
    .locals 7

    .line 149
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getPhoneEngineService()Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;->isInit()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 150
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->onSdkReady()V

    .line 151
    return-void

    .line 153
    :cond_0
    move-object v0, p0

    check-cast v0, Landroidx/lifecycle/LifecycleOwner;

    invoke-static {v0}, Landroidx/lifecycle/LifecycleOwnerKt;->getLifecycleScope(Landroidx/lifecycle/LifecycleOwner;)Landroidx/lifecycle/LifecycleCoroutineScope;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Lkotlinx/coroutines/CoroutineScope;

    new-instance v0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v2}, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;-><init>(Lcom/rokid/phone/ui/MainPhoneActivity;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 171
    return-void
.end method

.method private static final onInit$lambda$4(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V
    .locals 3
    .param p0, "this$0"    # Lcom/rokid/phone/ui/MainPhoneActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 83
    iget-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->autoConnectJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 84
    :cond_0
    new-instance v0, Landroid/content/Intent;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    const-class v2, Lcom/rokid/phone/ui/classicbt/ui/ClassicBtActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/rokid/phone/ui/MainPhoneActivity;->startActivity(Landroid/content/Intent;)V

    .line 85
    return-void
.end method

.method private static final onInit$lambda$5(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "this$0"    # Lcom/rokid/phone/ui/MainPhoneActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 86
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->openAiVision()V

    return-void
.end method

.method private static final onInit$lambda$6(Landroid/view/View;)V
    .locals 1
    .param p0, "it"    # Landroid/view/View;

    .line 88
    sget-object v0, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    invoke-virtual {v0}, Lcom/rokid/phone/data/GlobalData;->getP2pConnectState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 89
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v0}, Lcom/rokid/phone/DeviceLinkerManager;->disconnectP2p()V

    goto :goto_0

    .line 91
    :cond_0
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v0}, Lcom/rokid/phone/DeviceLinkerManager;->connectP2p()V

    .line 93
    :goto_0
    return-void
.end method

.method private static final onInit$lambda$7(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V
    .locals 3
    .param p0, "this$0"    # Lcom/rokid/phone/ui/MainPhoneActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 95
    new-instance v0, Landroid/content/Intent;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    const-class v2, Lcom/rokid/phone/GalleryActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/rokid/phone/ui/MainPhoneActivity;->startActivity(Landroid/content/Intent;)V

    .line 96
    return-void
.end method

.method private static final onInit$lambda$8(Lcom/rokid/phone/ui/MainPhoneActivity;Landroid/view/View;)V
    .locals 3
    .param p0, "this$0"    # Lcom/rokid/phone/ui/MainPhoneActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 98
    new-instance v0, Landroid/content/Intent;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    const-class v2, Lcom/rokid/phone/SettingActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/rokid/phone/ui/MainPhoneActivity;->startActivity(Landroid/content/Intent;)V

    .line 99
    return-void
.end method

.method private final onSdkReady()V
    .locals 2

    .line 174
    sget-object v0, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    invoke-virtual {v0}, Lcom/rokid/phone/data/GlobalData;->getSdkInitState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 175
    :cond_0
    sget-object v0, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/phone/data/GlobalData;->setSdkInitState(Z)V

    .line 176
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v0}, Lcom/rokid/phone/DeviceLinkerManager;->loadSavedDevice()V

    .line 177
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v0}, Lcom/rokid/phone/DeviceLinkerManager;->initialize()V

    .line 178
    return-void
.end method

.method private final openAiVision()V
    .locals 3

    .line 234
    sget-object v0, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    invoke-virtual {v0}, Lcom/rokid/phone/data/GlobalData;->getBtConnectState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_0

    .line 235
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    sget v1, Lcom/rokid/phone/R$string;->demo_connect_glasses_first:I

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 236
    return-void

    .line 238
    :cond_0
    new-instance v0, Landroid/content/Intent;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    const-class v2, Lcom/rokid/phone/ai/AiVisionActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/rokid/phone/ui/MainPhoneActivity;->startActivity(Landroid/content/Intent;)V

    .line 239
    return-void
.end method

.method private static final permissionLauncher$lambda$2(Lcom/rokid/phone/ui/MainPhoneActivity;Ljava/util/Map;)V
    .locals 8
    .param p0, "this$0"    # Lcom/rokid/phone/ui/MainPhoneActivity;
    .param p1, "grants"    # Ljava/util/Map;

    const-string v0, "grants"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 61
    invoke-interface {p1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$all$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 263
    .local v1, "$i$f$all":I
    instance-of v2, v0, Ljava/util/Collection;

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-eqz v2, :cond_0

    move-object v2, v0

    check-cast v2, Ljava/util/Collection;

    invoke-interface {v2}, Ljava/util/Collection;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    move v0, v4

    goto :goto_0

    .line 264
    :cond_0
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .local v5, "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Ljava/lang/Boolean;

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6

    .local v6, "it":Z
    const/4 v7, 0x0

    .line 61
    .local v7, "$i$a$-all-MainPhoneActivity$permissionLauncher$1$1":I
    nop

    .line 264
    .end local v6    # "it":Z
    .end local v7    # "$i$a$-all-MainPhoneActivity$permissionLauncher$1$1":I
    if-nez v6, :cond_1

    move v0, v3

    goto :goto_0

    .line 265
    .end local v5    # "element$iv":Ljava/lang/Object;
    :cond_2
    move v0, v4

    .line 61
    .end local v0    # "$this$all$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$all":I
    :goto_0
    if-eqz v0, :cond_3

    .line 62
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->continueStartup()V

    goto :goto_1

    .line 64
    :cond_3
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    sget v1, Lcom/rokid/phone/R$string;->demo_permissions_denied:I

    new-array v2, v3, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v0, v1, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 66
    :goto_1
    return-void
.end method

.method private static final phoneEngineService_delegate$lambda$0()Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;
    .locals 1

    .line 40
    invoke-static {}, Lcom/rokid/security/phone/sdk/api/PSecuritySDK;->getMobileEngineService()Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;

    move-result-object v0

    return-object v0
.end method

.method private final scheduleAutoConnect()V
    .locals 8

    .line 181
    sget-object v0, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    invoke-virtual {v0}, Lcom/rokid/phone/data/GlobalData;->getBtConnectState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 182
    :cond_0
    iget-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->autoConnectJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 183
    :cond_1
    move-object v0, p0

    check-cast v0, Landroidx/lifecycle/LifecycleOwner;

    invoke-static {v0}, Landroidx/lifecycle/LifecycleOwnerKt;->getLifecycleScope(Landroidx/lifecycle/LifecycleOwner;)Landroidx/lifecycle/LifecycleCoroutineScope;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Lkotlinx/coroutines/CoroutineScope;

    new-instance v0, Lcom/rokid/phone/ui/MainPhoneActivity$scheduleAutoConnect$1;

    invoke-direct {v0, v1}, Lcom/rokid/phone/ui/MainPhoneActivity$scheduleAutoConnect$1;-><init>(Lkotlin/coroutines/Continuation;)V

    move-object v5, v0

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->autoConnectJob:Lkotlinx/coroutines/Job;

    .line 188
    return-void
.end method

.method private final updateBattery()V
    .locals 4

    .line 218
    sget-object v0, Lcom/rokid/phone/data/DeviceStatus;->INSTANCE:Lcom/rokid/phone/data/DeviceStatus;

    invoke-virtual {v0}, Lcom/rokid/phone/data/DeviceStatus;->getPowerValue()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    .line 219
    .local v0, "power":I
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v1

    check-cast v1, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v1, v1, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->tvBattery:Landroid/widget/TextView;

    if-gtz v0, :cond_0

    .line 220
    sget v2, Lcom/rokid/phone/R$string;->demo_battery_unknown:I

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    goto :goto_1

    .line 223
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

    .line 224
    sget v2, Lcom/rokid/phone/R$string;->demo_battery_charging:I

    goto :goto_0

    .line 226
    :cond_1
    sget v2, Lcom/rokid/phone/R$string;->demo_battery_level:I

    .line 228
    :goto_0
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    .line 222
    invoke-static {v2, v3}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    .line 219
    :goto_1
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 231
    return-void
.end method

.method private final updateConnectionState(Z)V
    .locals 4
    .param p1, "connected"    # Z

    .line 191
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->tvDeviceName:Landroid/widget/TextView;

    sget-object v1, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v1}, Lcom/rokid/phone/DeviceLinkerManager;->getDeviceName()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 192
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->tvConnectionState:Landroid/widget/TextView;

    .line 193
    if-eqz p1, :cond_0

    sget v1, Lcom/rokid/phone/R$string;->demo_bluetooth_connected:I

    goto :goto_0

    :cond_0
    sget v1, Lcom/rokid/phone/R$string;->demo_bluetooth_disconnected:I

    :goto_0
    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    .line 192
    invoke-static {v1, v3}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 195
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->ivConnectStatus:Landroid/widget/ImageView;

    .line 196
    if-eqz p1, :cond_1

    sget v1, Lcom/rokid/phone/R$mipmap;->icon_pair_complete:I

    goto :goto_1

    :cond_1
    sget v1, Lcom/rokid/phone/R$mipmap;->icon_to_connect2:I

    .line 195
    :goto_1
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 198
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnConnect:Landroidx/appcompat/widget/AppCompatButton;

    .line 199
    if-eqz p1, :cond_2

    sget v1, Lcom/rokid/phone/R$string;->demo_reconnect_glasses:I

    goto :goto_2

    :cond_2
    sget v1, Lcom/rokid/phone/R$string;->demo_connect_glasses:I

    .line 198
    :goto_2
    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/AppCompatButton;->setText(I)V

    .line 201
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnAiVision:Landroid/widget/LinearLayout;

    if-eqz p1, :cond_3

    iget-boolean v1, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->sdkReady:Z

    if-eqz v1, :cond_3

    const/4 v2, 0x1

    :cond_3
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setEnabled(Z)V

    .line 202
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnAiVision:Landroid/widget/LinearLayout;

    if-eqz p1, :cond_4

    iget-boolean v1, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->sdkReady:Z

    if-eqz v1, :cond_4

    const/high16 v1, 0x3f800000    # 1.0f

    goto :goto_3

    :cond_4
    const v1, 0x3ee66666    # 0.45f

    :goto_3
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setAlpha(F)V

    .line 203
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnP2P:Landroidx/appcompat/widget/AppCompatButton;

    invoke-virtual {v0, p1}, Landroidx/appcompat/widget/AppCompatButton;->setEnabled(Z)V

    .line 204
    sget-object v0, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    invoke-virtual {v0}, Lcom/rokid/phone/data/GlobalData;->getP2pConnectState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-direct {p0, v0}, Lcom/rokid/phone/ui/MainPhoneActivity;->updateP2pState(Z)V

    .line 205
    return-void
.end method

.method private final updateP2pState(Z)V
    .locals 3
    .param p1, "connected"    # Z

    .line 208
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->tvP2PState:Landroid/widget/TextView;

    .line 209
    if-eqz p1, :cond_0

    sget v1, Lcom/rokid/phone/R$string;->demo_p2p_connected_short:I

    goto :goto_0

    :cond_0
    sget v1, Lcom/rokid/phone/R$string;->demo_p2p_disconnected_short:I

    :goto_0
    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    .line 208
    invoke-static {v1, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 211
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnP2P:Landroidx/appcompat/widget/AppCompatButton;

    .line 212
    if-eqz p1, :cond_1

    sget v1, Lcom/rokid/phone/R$string;->demo_disconnect_p2p:I

    goto :goto_1

    :cond_1
    sget v1, Lcom/rokid/phone/R$string;->demo_connect_p2p:I

    .line 211
    :goto_1
    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/AppCompatButton;->setText(I)V

    .line 214
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnP2P:Landroidx/appcompat/widget/AppCompatButton;

    sget-object v1, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    invoke-virtual {v1}, Lcom/rokid/phone/data/GlobalData;->getBtConnectState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v1

    invoke-interface {v1}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/AppCompatButton;->setEnabled(Z)V

    .line 215
    return-void
.end method


# virtual methods
.method public bridge synthetic initViewBinding()Landroidx/viewbinding/ViewBinding;
    .locals 1

    .line 39
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->initViewBinding()Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    move-result-object v0

    check-cast v0, Landroidx/viewbinding/ViewBinding;

    return-object v0
.end method

.method public initViewBinding()Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;
    .locals 2

    .line 79
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->inflate(Landroid/view/LayoutInflater;)Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    move-result-object v0

    const-string v1, "inflate(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

# ===== 水利安全AI眼镜: 返回键Tab回退 =====
.method public onBackPressed()V
    .locals 2

    # V3 WebView回退
    const v0, 0x7f080238
    invoke-virtual {p0, v0}, Lcom/rokid/phone/ui/MainPhoneActivity;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/webkit/WebView;
    if-eqz v0, :call_super

    invoke-virtual {v0}, Landroid/webkit/WebView;->canGoBack()Z
    move-result v1
    if-eqz v1, :call_super

    invoke-virtual {v0}, Landroid/webkit/WebView;->goBack()V
    return-void

    :call_super
    invoke-super {p0}, Lcom/rokid/phone/base/BaseActivity;->onBackPressed()V
    return-void
.end method

.method protected onDestroy()V
    .locals 3

    .line 242
    iget-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity;->autoConnectJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 243
    :cond_0
    sget-object v0, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    invoke-virtual {v0}, Lcom/rokid/phone/data/GlobalData;->getSdkInitState()Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 244
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v0}, Lcom/rokid/phone/DeviceLinkerManager;->release()V

    .line 245
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getPhoneEngineService()Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;->destroy()V

    .line 247
    :cond_1
    sget-object v0, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    invoke-virtual {v0}, Lcom/rokid/phone/data/GlobalData;->reset()V

    .line 248
    invoke-super {p0}, Lcom/rokid/phone/base/BaseActivity;->onDestroy()V

    .line 249
    return-void
.end method

.method public onInit(Landroid/os/Bundle;)V
    .locals 7
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 82
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnConnect:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v1, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda3;-><init>(Lcom/rokid/phone/ui/MainPhoneActivity;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 86
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnAiVision:Landroid/widget/LinearLayout;

    new-instance v1, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda4;-><init>(Lcom/rokid/phone/ui/MainPhoneActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 87
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnP2P:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v1, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda5;

    invoke-direct {v1}, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda5;-><init>()V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 94
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnGallery:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v1, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda6;-><init>(Lcom/rokid/phone/ui/MainPhoneActivity;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 97
    invoke-virtual {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnSettings:Landroid/widget/ImageButton;

    new-instance v1, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda7;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ui/MainPhoneActivity$$ExternalSyntheticLambda7;-><init>(Lcom/rokid/phone/ui/MainPhoneActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 101
    move-object v0, p0

    check-cast v0, Landroidx/lifecycle/LifecycleOwner;

    invoke-static {v0}, Landroidx/lifecycle/LifecycleOwnerKt;->getLifecycleScope(Landroidx/lifecycle/LifecycleOwner;)Landroidx/lifecycle/LifecycleCoroutineScope;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Lkotlinx/coroutines/CoroutineScope;

    new-instance v0, Lcom/rokid/phone/ui/MainPhoneActivity$onInit$6;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v2}, Lcom/rokid/phone/ui/MainPhoneActivity$onInit$6;-><init>(Lcom/rokid/phone/ui/MainPhoneActivity;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 124
    invoke-direct {p0}, Lcom/rokid/phone/ui/MainPhoneActivity;->continueStartup()V

    # 水安全AI眼镜: V3官网WebView(0x7f080238=v3_webview)
    const v0, 0x7f080238
    invoke-virtual {p0, v0}, Lcom/rokid/phone/ui/MainPhoneActivity;->findViewById(I)Landroid/view/View;
    move-result-object v0
    check-cast v0, Landroid/webkit/WebView;
    if-eqz v0, :skip_nav
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V
    new-instance v1, Landroid/webkit/WebViewClient;
    invoke-direct {v1}, Landroid/webkit/WebViewClient;-><init>()V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    const-string v1, "http://47.120.43.20:8090/"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    :skip_nav

    .line 125
    return-void
.end method
