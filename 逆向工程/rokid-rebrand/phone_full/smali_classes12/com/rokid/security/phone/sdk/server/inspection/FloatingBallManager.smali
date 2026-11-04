.class public final Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;
.super Ljava/lang/Object;
.source "FloatingBallManager.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00004\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\n\u0008\u00c7\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0010\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\nJ\u0006\u0010\u0013\u001a\u00020\u0011J\u0008\u0010\u0014\u001a\u00020\u0011H\u0002J\u0008\u0010\u0015\u001a\u00020\u0011H\u0002J\u0008\u0010\u0016\u001a\u00020\u0011H\u0002J\u0008\u0010\u0017\u001a\u00020\u0011H\u0002J\u0006\u0010\u0018\u001a\u00020\u0011J\u000e\u0010\u0019\u001a\u00020\u00112\u0006\u0010\u001a\u001a\u00020\u0004R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u0008\u001a\n\u0012\u0004\u0012\u00020\n\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u000b\u001a\n\u0012\u0004\u0012\u00020\u000c\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u000e\u001a\n\u0012\u0004\u0012\u00020\u000f\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001b"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;",
        "",
        "()V",
        "STATUS_IDLE",
        "",
        "STATUS_INSPECTING",
        "STATUS_UPLOADING",
        "TAG",
        "activityRef",
        "Ljava/lang/ref/WeakReference;",
        "Landroid/app/Activity;",
        "containerRef",
        "Landroid/widget/FrameLayout;",
        "currentStatus",
        "floatingViewRef",
        "Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;",
        "attach",
        "",
        "activity",
        "detach",
        "ensureContainer",
        "hide",
        "removeContainer",
        "show",
        "start",
        "updateStatus",
        "status",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;

.field public static final STATUS_IDLE:Ljava/lang/String; = "idle"

.field public static final STATUS_INSPECTING:Ljava/lang/String; = "\u5de1\u68c0\u4e2d"

.field public static final STATUS_UPLOADING:Ljava/lang/String; = "\u5de1\u68c0\u4e0a\u4f20\u4e2d"

.field private static final TAG:Ljava/lang/String; = "FloatingBallManager"

.field private static activityRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/app/Activity;",
            ">;"
        }
    .end annotation
.end field

.field private static containerRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/widget/FrameLayout;",
            ">;"
        }
    .end annotation
.end field

.field private static currentStatus:Ljava/lang/String;

.field private static floatingViewRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$D_ngGu1KMeX-vLGu7PHt6TEag5Q(Landroid/app/Activity;)V
    .locals 0

    invoke-static {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->ensureContainer$lambda$2(Landroid/app/Activity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$KToexcXOereFFOUfetXudhjQYU0(Landroid/app/Activity;)V
    .locals 0

    invoke-static {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->removeContainer$lambda$3(Landroid/app/Activity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$KhmD6Le_ys7mvSagjVVNK9oyPrY(Landroid/app/Activity;)V
    .locals 0

    invoke-static {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->show$lambda$4(Landroid/app/Activity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$ZRfBVHXRVnNtebBSLZpq35k_bU4()V
    .locals 0

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->hide$lambda$5()V

    return-void
.end method

.method public static synthetic $r8$lambda$Zn-IVOVsuINYiHNJb8rBVLixV4Q(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->updateStatus$lambda$0(Ljava/lang/String;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;

    .line 23
    const-string v0, "idle"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->currentStatus:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final ensureContainer()V
    .locals 2

    .line 68
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->activityRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    if-nez v0, :cond_0

    goto :goto_0

    .line 70
    .local v0, "act":Landroid/app/Activity;
    :cond_0
    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager$$ExternalSyntheticLambda1;

    invoke-direct {v1, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager$$ExternalSyntheticLambda1;-><init>(Landroid/app/Activity;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 86
    return-void

    .line 68
    .end local v0    # "act":Landroid/app/Activity;
    :cond_1
    :goto_0
    return-void
.end method

.method private static final ensureContainer$lambda$2(Landroid/app/Activity;)V
    .locals 7
    .param p0, "$act"    # Landroid/app/Activity;

    const-string v0, "$act"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 71
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->containerRef:Ljava/lang/ref/WeakReference;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    goto :goto_0

    :cond_0
    move-object v0, v1

    .line 72
    .local v0, "existing":Landroid/widget/FrameLayout;
    :goto_0
    if-eqz v0, :cond_1

    return-void

    .line 74
    :cond_1
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {v2}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v2

    goto :goto_1

    :cond_2
    move-object v2, v1

    :goto_1
    instance-of v3, v2, Landroid/view/ViewGroup;

    if-eqz v3, :cond_3

    move-object v1, v2

    check-cast v1, Landroid/view/ViewGroup;

    :cond_3
    if-nez v1, :cond_4

    return-void

    .line 75
    .local v1, "root":Landroid/view/ViewGroup;
    :cond_4
    new-instance v2, Landroid/widget/FrameLayout;

    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    move-object v3, v2

    .local v3, "$this$ensureContainer_u24lambda_u242_u24lambda_u241":Landroid/widget/FrameLayout;
    const/4 v4, 0x0

    .line 76
    .local v4, "$i$a$-apply-FloatingBallManager$ensureContainer$1$container$1":I
    new-instance v5, Landroid/view/ViewGroup$LayoutParams;

    .line 77
    nop

    .line 78
    nop

    .line 76
    const/4 v6, -0x1

    invoke-direct {v5, v6, v6}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v5}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 80
    const/4 v5, 0x0

    invoke-virtual {v3, v5}, Landroid/widget/FrameLayout;->setClickable(Z)V

    .line 81
    nop

    .line 75
    .end local v3    # "$this$ensureContainer_u24lambda_u242_u24lambda_u241":Landroid/widget/FrameLayout;
    .end local v4    # "$i$a$-apply-FloatingBallManager$ensureContainer$1$container$1":I
    nop

    .line 82
    .local v2, "container":Landroid/widget/FrameLayout;
    move-object v3, v2

    check-cast v3, Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 84
    new-instance v3, Ljava/lang/ref/WeakReference;

    invoke-direct {v3, v2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v3, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->containerRef:Ljava/lang/ref/WeakReference;

    .line 85
    return-void
.end method

.method private final hide()V
    .locals 2

    .line 125
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->activityRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    if-nez v0, :cond_0

    goto :goto_0

    .line 127
    .local v0, "act":Landroid/app/Activity;
    :cond_0
    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager$$ExternalSyntheticLambda3;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager$$ExternalSyntheticLambda3;-><init>()V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 135
    return-void

    .line 125
    .end local v0    # "act":Landroid/app/Activity;
    :cond_1
    :goto_0
    return-void
.end method

.method private static final hide$lambda$5()V
    .locals 3

    .line 128
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->floatingViewRef:Ljava/lang/ref/WeakReference;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;

    goto :goto_0

    :cond_0
    move-object v0, v1

    .line 129
    .local v0, "floating":Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;
    :goto_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->containerRef:Ljava/lang/ref/WeakReference;

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/widget/FrameLayout;

    .line 131
    .local v1, "container":Landroid/widget/FrameLayout;
    :cond_1
    if-eqz v0, :cond_2

    if-eqz v1, :cond_2

    .line 132
    move-object v2, v0

    check-cast v2, Landroid/view/View;

    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->removeView(Landroid/view/View;)V

    .line 134
    :cond_2
    return-void
.end method

.method private final removeContainer()V
    .locals 2

    .line 89
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->activityRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    if-nez v0, :cond_0

    goto :goto_0

    .line 91
    .local v0, "act":Landroid/app/Activity;
    :cond_0
    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager$$ExternalSyntheticLambda2;

    invoke-direct {v1, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager$$ExternalSyntheticLambda2;-><init>(Landroid/app/Activity;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 99
    return-void

    .line 89
    .end local v0    # "act":Landroid/app/Activity;
    :cond_1
    :goto_0
    return-void
.end method

.method private static final removeContainer$lambda$3(Landroid/app/Activity;)V
    .locals 4
    .param p0, "$act"    # Landroid/app/Activity;

    const-string v0, "$act"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 92
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    :goto_0
    instance-of v2, v0, Landroid/view/ViewGroup;

    if-eqz v2, :cond_1

    check-cast v0, Landroid/view/ViewGroup;

    goto :goto_1

    :cond_1
    move-object v0, v1

    :goto_1
    if-nez v0, :cond_2

    return-void

    .line 93
    .local v0, "root":Landroid/view/ViewGroup;
    :cond_2
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->containerRef:Ljava/lang/ref/WeakReference;

    if-eqz v2, :cond_5

    invoke-virtual {v2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/widget/FrameLayout;

    if-nez v2, :cond_3

    goto :goto_2

    .line 95
    .local v2, "container":Landroid/widget/FrameLayout;
    :cond_3
    move-object v3, v2

    check-cast v3, Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 96
    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->containerRef:Ljava/lang/ref/WeakReference;

    if-eqz v3, :cond_4

    invoke-virtual {v3}, Ljava/lang/ref/WeakReference;->clear()V

    .line 97
    :cond_4
    sput-object v1, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->containerRef:Ljava/lang/ref/WeakReference;

    .line 98
    return-void

    .line 93
    .end local v2    # "container":Landroid/widget/FrameLayout;
    :cond_5
    :goto_2
    return-void
.end method

.method private final show()V
    .locals 2

    .line 102
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->activityRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    if-nez v0, :cond_0

    goto :goto_0

    .line 104
    .local v0, "act":Landroid/app/Activity;
    :cond_0
    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager$$ExternalSyntheticLambda0;

    invoke-direct {v1, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager$$ExternalSyntheticLambda0;-><init>(Landroid/app/Activity;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 122
    return-void

    .line 102
    .end local v0    # "act":Landroid/app/Activity;
    :cond_1
    :goto_0
    return-void
.end method

.method private static final show$lambda$4(Landroid/app/Activity;)V
    .locals 5
    .param p0, "$act"    # Landroid/app/Activity;

    const-string v0, "$act"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 105
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->ensureContainer()V

    .line 107
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->containerRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    if-nez v0, :cond_0

    goto :goto_1

    .line 109
    .local v0, "container":Landroid/widget/FrameLayout;
    :cond_0
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->floatingViewRef:Ljava/lang/ref/WeakReference;

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    .line 111
    .local v1, "floating":Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;
    :goto_0
    if-nez v1, :cond_2

    .line 113
    new-instance v2, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;

    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    const-string v4, "act.applicationContext"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v2, v3}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;-><init>(Landroid/content/Context;)V

    move-object v1, v2

    .line 114
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->currentStatus:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setStatus(Ljava/lang/String;)V

    .line 115
    new-instance v2, Ljava/lang/ref/WeakReference;

    invoke-direct {v2, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v2, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->floatingViewRef:Ljava/lang/ref/WeakReference;

    .line 118
    :cond_2
    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    if-nez v2, :cond_3

    .line 119
    move-object v2, v1

    check-cast v2, Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 121
    :cond_3
    return-void

    .line 107
    .end local v0    # "container":Landroid/widget/FrameLayout;
    .end local v1    # "floating":Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;
    :cond_4
    :goto_1
    return-void
.end method

.method private static final updateStatus$lambda$0(Ljava/lang/String;)V
    .locals 1
    .param p0, "$status"    # Ljava/lang/String;

    const-string v0, "$status"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    const-string v0, "idle"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 43
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->hide()V

    .line 44
    return-void

    .line 46
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->show()V

    .line 47
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->floatingViewRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;

    if-eqz v0, :cond_1

    invoke-virtual {v0, p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setStatus(Ljava/lang/String;)V

    .line 48
    :cond_1
    return-void
.end method


# virtual methods
.method public final attach(Landroid/app/Activity;)V
    .locals 2
    .param p1, "activity"    # Landroid/app/Activity;

    const-string v0, "activity"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->activityRef:Ljava/lang/ref/WeakReference;

    .line 29
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->ensureContainer()V

    .line 30
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "attach: bound to "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "FloatingBallManager"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 31
    return-void
.end method

.method public final detach()V
    .locals 2

    .line 52
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->hide()V

    .line 53
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->removeContainer()V

    .line 55
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->activityRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->clear()V

    .line 56
    :cond_0
    const/4 v0, 0x0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->activityRef:Ljava/lang/ref/WeakReference;

    .line 58
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->floatingViewRef:Ljava/lang/ref/WeakReference;

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->clear()V

    .line 59
    :cond_1
    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->floatingViewRef:Ljava/lang/ref/WeakReference;

    .line 61
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->containerRef:Ljava/lang/ref/WeakReference;

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->clear()V

    .line 62
    :cond_2
    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->containerRef:Ljava/lang/ref/WeakReference;

    .line 63
    return-void
.end method

.method public final start()V
    .locals 0

    .line 34
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->show()V

    .line 35
    return-void
.end method

.method public final updateStatus(Ljava/lang/String;)V
    .locals 2
    .param p1, "status"    # Ljava/lang/String;

    const-string/jumbo v0, "status"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 38
    sput-object p1, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->currentStatus:Ljava/lang/String;

    .line 39
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->activityRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    if-nez v0, :cond_0

    goto :goto_0

    .line 41
    .local v0, "act":Landroid/app/Activity;
    :cond_0
    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager$$ExternalSyntheticLambda4;

    invoke-direct {v1, p1}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager$$ExternalSyntheticLambda4;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 49
    return-void

    .line 39
    .end local v0    # "act":Landroid/app/Activity;
    :cond_1
    :goto_0
    return-void
.end method
