.class public final Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;
.super Landroid/widget/TextView;
.source "FloatingBallView.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00008\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u000b\n\u0002\u0010\u0007\n\u0002\u0008\u0004\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u0010\u0010\u0016\u001a\u00020\u00062\u0006\u0010\u0017\u001a\u00020\u0006H\u0002J\u0008\u0010\u0018\u001a\u00020\u0019H\u0014J\u000e\u0010\u001a\u001a\u00020\u00192\u0006\u0010\u001b\u001a\u00020\u001cJ\u0008\u0010\u001d\u001a\u00020\u0019H\u0003R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082D\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0007\u001a\u00020\u00088BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000b\u0010\u000c\u001a\u0004\u0008\t\u0010\nR\u001b\u0010\r\u001a\u00020\u00088BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000f\u0010\u000c\u001a\u0004\u0008\u000e\u0010\nR\u001b\u0010\u0010\u001a\u00020\u00088BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0012\u0010\u000c\u001a\u0004\u0008\u0011\u0010\nR\u000e\u0010\u0013\u001a\u00020\u0014X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0015\u001a\u00020\u0014X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001e"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;",
        "Landroid/widget/TextView;",
        "context",
        "Landroid/content/Context;",
        "(Landroid/content/Context;)V",
        "ballSizeDp",
        "",
        "bgBlue",
        "Landroid/graphics/drawable/GradientDrawable;",
        "getBgBlue",
        "()Landroid/graphics/drawable/GradientDrawable;",
        "bgBlue$delegate",
        "Lkotlin/Lazy;",
        "bgGreen",
        "getBgGreen",
        "bgGreen$delegate",
        "bgOrange",
        "getBgOrange",
        "bgOrange$delegate",
        "lastX",
        "",
        "lastY",
        "dpToPx",
        "dp",
        "onDetachedFromWindow",
        "",
        "setStatus",
        "status",
        "",
        "setupDragLogic",
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


# instance fields
.field private final ballSizeDp:I

.field private final bgBlue$delegate:Lkotlin/Lazy;

.field private final bgGreen$delegate:Lkotlin/Lazy;

.field private final bgOrange$delegate:Lkotlin/Lazy;

.field private lastX:F

.field private lastY:F


# direct methods
.method public static synthetic $r8$lambda$ZFj6lrAY46gbs9WcPrYywGL5VZ8(Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setupDragLogic$lambda$1(Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;Landroid/view/View;Landroid/view/MotionEvent;)Z

    move-result p0

    return p0
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    invoke-direct {p0, p1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 16
    const/16 v0, 0x3c

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->ballSizeDp:I

    .line 18
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgBlue$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgBlue$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->bgBlue$delegate:Lkotlin/Lazy;

    .line 28
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgGreen$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgGreen$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->bgGreen$delegate:Lkotlin/Lazy;

    .line 38
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgOrange$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$bgOrange$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->bgOrange$delegate:Lkotlin/Lazy;

    .line 48
    nop

    .line 49
    const/4 v0, -0x1

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setTextColor(I)V

    .line 50
    const/high16 v0, 0x41600000    # 14.0f

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setTextSize(F)V

    .line 51
    const/16 v0, 0x11

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setGravity(I)V

    .line 52
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setMaxLines(I)V

    .line 54
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->ballSizeDp:I

    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->dpToPx(I)I

    move-result v0

    .line 55
    .local v0, "sizePx":I
    new-instance v1, Landroid/view/ViewGroup$MarginLayoutParams;

    invoke-direct {v1, v0, v0}, Landroid/view/ViewGroup$MarginLayoutParams;-><init>(II)V

    move-object v2, v1

    .local v2, "$this$_init__u24lambda_u240":Landroid/view/ViewGroup$MarginLayoutParams;
    const/4 v3, 0x0

    .line 56
    .local v3, "$i$a$-apply-FloatingBallView$1":I
    const/16 v4, 0xc8

    iput v4, v2, Landroid/view/ViewGroup$MarginLayoutParams;->topMargin:I

    .line 57
    const/16 v4, 0x28

    iput v4, v2, Landroid/view/ViewGroup$MarginLayoutParams;->leftMargin:I

    .line 58
    nop

    .line 55
    .end local v2    # "$this$_init__u24lambda_u240":Landroid/view/ViewGroup$MarginLayoutParams;
    .end local v3    # "$i$a$-apply-FloatingBallView$1":I
    check-cast v1, Landroid/view/ViewGroup$LayoutParams;

    invoke-virtual {p0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 60
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->getBgOrange()Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    check-cast v1, Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 62
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setupDragLogic()V

    .line 63
    .end local v0    # "sizePx":I
    nop

    .line 12
    return-void
.end method

.method private final dpToPx(I)I
    .locals 2
    .param p1, "dp"    # I

    .line 123
    int-to-float v0, p1

    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v0, v1

    float-to-int v0, v0

    return v0
.end method

.method private final getBgBlue()Landroid/graphics/drawable/GradientDrawable;
    .locals 1

    .line 18
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->bgBlue$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/GradientDrawable;

    return-object v0
.end method

.method private final getBgGreen()Landroid/graphics/drawable/GradientDrawable;
    .locals 1

    .line 28
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->bgGreen$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/GradientDrawable;

    return-object v0
.end method

.method private final getBgOrange()Landroid/graphics/drawable/GradientDrawable;
    .locals 1

    .line 38
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->bgOrange$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/GradientDrawable;

    return-object v0
.end method

.method private final setupDragLogic()V
    .locals 1

    .line 67
    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;)V

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 103
    return-void
.end method

.method private static final setupDragLogic$lambda$1(Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 9
    .param p0, "this$0"    # Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    const-string/jumbo v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 68
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    instance-of v1, v0, Landroid/view/ViewGroup;

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    check-cast v0, Landroid/view/ViewGroup;

    goto :goto_0

    :cond_0
    move-object v0, v2

    :goto_0
    const/4 v1, 0x1

    if-nez v0, :cond_1

    return v1

    .line 70
    .local v0, "parent":Landroid/view/ViewGroup;
    :cond_1
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v3

    const/4 v4, 0x0

    packed-switch v3, :pswitch_data_0

    goto/16 :goto_2

    .line 77
    :pswitch_0
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v2

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->lastX:F

    sub-float/2addr v2, v3

    .line 78
    .local v2, "newX":F
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v3

    iget v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->lastY:F

    sub-float/2addr v3, v5

    .line 80
    .local v3, "newY":F
    invoke-virtual {v0}, Landroid/view/ViewGroup;->getWidth()I

    move-result v5

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v6

    sub-int/2addr v5, v6

    int-to-float v5, v5

    .line 81
    .local v5, "maxX":F
    invoke-virtual {v0}, Landroid/view/ViewGroup;->getHeight()I

    move-result v6

    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v7

    sub-int/2addr v6, v7

    int-to-float v6, v6

    .line 83
    .local v6, "maxY":F
    invoke-static {v2, v4, v5}, Lkotlin/ranges/RangesKt;->coerceIn(FFF)F

    move-result v2

    .line 84
    invoke-static {v3, v4, v6}, Lkotlin/ranges/RangesKt;->coerceIn(FFF)F

    move-result v3

    .line 86
    invoke-virtual {p1, v2}, Landroid/view/View;->setX(F)V

    .line 87
    invoke-virtual {p1, v3}, Landroid/view/View;->setY(F)V

    .end local v2    # "newX":F
    .end local v3    # "newY":F
    .end local v5    # "maxX":F
    .end local v6    # "maxY":F
    goto :goto_2

    .line 91
    :pswitch_1
    invoke-virtual {v0}, Landroid/view/ViewGroup;->getWidth()I

    move-result v3

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v5

    sub-int/2addr v3, v5

    int-to-float v3, v3

    .line 92
    .local v3, "maxX":F
    invoke-virtual {v0}, Landroid/view/ViewGroup;->getHeight()I

    move-result v5

    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v6

    sub-int/2addr v5, v6

    int-to-float v5, v5

    .line 94
    .local v5, "maxY":F
    invoke-virtual {p1}, Landroid/view/View;->getX()F

    move-result v6

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v7

    div-int/lit8 v7, v7, 0x2

    int-to-float v7, v7

    add-float/2addr v6, v7

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getWidth()I

    move-result v7

    div-int/lit8 v7, v7, 0x2

    int-to-float v7, v7

    cmpg-float v6, v6, v7

    if-gez v6, :cond_2

    move v6, v4

    goto :goto_1

    :cond_2
    move v6, v3

    .line 95
    .local v6, "targetX":F
    :goto_1
    invoke-virtual {p1}, Landroid/view/View;->getY()F

    move-result v7

    invoke-static {v7, v4, v5}, Lkotlin/ranges/RangesKt;->coerceIn(FFF)F

    move-result v4

    .line 97
    .local v4, "targetY":F
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v7

    invoke-virtual {v7, v2}, Landroid/view/ViewPropertyAnimator;->setListener(Landroid/animation/Animator$AnimatorListener;)Landroid/view/ViewPropertyAnimator;

    .line 98
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v6}, Landroid/view/ViewPropertyAnimator;->x(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2, v4}, Landroid/view/ViewPropertyAnimator;->y(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    const-wide/16 v7, 0xc8

    invoke-virtual {v2, v7, v8}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/ViewPropertyAnimator;->start()V

    goto :goto_2

    .line 72
    .end local v3    # "maxX":F
    .end local v4    # "targetY":F
    .end local v5    # "maxY":F
    .end local v6    # "targetX":F
    :pswitch_2
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v2

    invoke-virtual {p1}, Landroid/view/View;->getX()F

    move-result v3

    sub-float/2addr v2, v3

    iput v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->lastX:F

    .line 73
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v2

    invoke-virtual {p1}, Landroid/view/View;->getY()F

    move-result v3

    sub-float/2addr v2, v3

    iput v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->lastY:F

    .line 101
    :goto_2
    return v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method


# virtual methods
.method protected onDetachedFromWindow()V
    .locals 2

    .line 117
    invoke-super {p0}, Landroid/widget/TextView;->onDetachedFromWindow()V

    .line 118
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->setListener(Landroid/animation/Animator$AnimatorListener;)Landroid/view/ViewPropertyAnimator;

    .line 119
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->cancel()V

    .line 120
    return-void
.end method

.method public final setStatus(Ljava/lang/String;)V
    .locals 1
    .param p1, "status"    # Ljava/lang/String;

    const-string/jumbo v0, "status"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 107
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setText(Ljava/lang/CharSequence;)V

    .line 108
    nop

    .line 109
    const-string/jumbo v0, "\u5de1\u68c0\u4e2d"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->getBgBlue()Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Drawable;

    goto :goto_0

    .line 110
    :cond_0
    const-string/jumbo v0, "\u5de1\u68c0\u4e0a\u4f20\u4e2d"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->getBgGreen()Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Drawable;

    goto :goto_0

    .line 111
    :cond_1
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->getBgOrange()Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Drawable;

    .line 108
    :goto_0
    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 113
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallView;->setAlpha(F)V

    .line 114
    return-void
.end method
