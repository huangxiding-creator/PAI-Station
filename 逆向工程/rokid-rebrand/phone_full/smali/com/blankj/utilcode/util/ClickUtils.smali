.class public Lcom/blankj/utilcode/util/ClickUtils;
.super Ljava/lang/Object;
.source "ClickUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/blankj/utilcode/util/ClickUtils$ClickDrawableWrapper;,
        Lcom/blankj/utilcode/util/ClickUtils$OnUtilsTouchListener;,
        Lcom/blankj/utilcode/util/ClickUtils$OnMultiClickListener;,
        Lcom/blankj/utilcode/util/ClickUtils$OnDebouncingClickListener;,
        Lcom/blankj/utilcode/util/ClickUtils$Back2HomeFriendlyListener;
    }
.end annotation


# static fields
.field private static final DEBOUNCING_DEFAULT_VALUE:J = 0x3e8L

.field private static final PRESSED_BG_ALPHA_DEFAULT_VALUE:F = 0.9f

.field private static final PRESSED_BG_ALPHA_STYLE:I = 0x4

.field private static final PRESSED_BG_DARK_DEFAULT_VALUE:F = 0.9f

.field private static final PRESSED_BG_DARK_STYLE:I = 0x5

.field private static final PRESSED_VIEW_ALPHA_DEFAULT_VALUE:F = 0.8f

.field private static final PRESSED_VIEW_ALPHA_SRC_TAG:I = -0x3

.field private static final PRESSED_VIEW_ALPHA_TAG:I = -0x2

.field private static final PRESSED_VIEW_SCALE_DEFAULT_VALUE:F = -0.06f

.field private static final PRESSED_VIEW_SCALE_TAG:I = -0x1

.field private static final TIP_DURATION:J = 0x7d0L

.field private static sClickCount:I

.field private static sLastClickMillis:J


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 53
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static applyDebouncing([Landroid/view/View;ZJLandroid/view/View$OnClickListener;)V
    .locals 4
    .param p0, "views"    # [Landroid/view/View;
    .param p1, "isGlobal"    # Z
    .param p2, "duration"    # J
    .param p4, "listener"    # Landroid/view/View$OnClickListener;

    .line 332
    if-eqz p0, :cond_3

    array-length v0, p0

    if-eqz v0, :cond_3

    if-nez p4, :cond_0

    goto :goto_2

    .line 333
    :cond_0
    array-length v0, p0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_2

    aget-object v2, p0, v1

    .line 334
    .local v2, "view":Landroid/view/View;
    if-nez v2, :cond_1

    goto :goto_1

    .line 335
    :cond_1
    new-instance v3, Lcom/blankj/utilcode/util/ClickUtils$1;

    invoke-direct {v3, p1, p2, p3, p4}, Lcom/blankj/utilcode/util/ClickUtils$1;-><init>(ZJLandroid/view/View$OnClickListener;)V

    invoke-virtual {v2, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 333
    .end local v2    # "view":Landroid/view/View;
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 342
    :cond_2
    return-void

    .line 332
    :cond_3
    :goto_2
    return-void
.end method

.method public static applyGlobalDebouncing(Landroid/view/View;JLandroid/view/View$OnClickListener;)V
    .locals 2
    .param p0, "view"    # Landroid/view/View;
    .param p1, "duration"    # J
    .param p3, "listener"    # Landroid/view/View$OnClickListener;

    .line 301
    const/4 v0, 0x1

    new-array v0, v0, [Landroid/view/View;

    const/4 v1, 0x0

    aput-object p0, v0, v1

    invoke-static {v0, p1, p2, p3}, Lcom/blankj/utilcode/util/ClickUtils;->applyGlobalDebouncing([Landroid/view/View;JLandroid/view/View$OnClickListener;)V

    .line 302
    return-void
.end method

.method public static applyGlobalDebouncing(Landroid/view/View;Landroid/view/View$OnClickListener;)V
    .locals 2
    .param p0, "view"    # Landroid/view/View;
    .param p1, "listener"    # Landroid/view/View$OnClickListener;

    .line 289
    const/4 v0, 0x1

    new-array v0, v0, [Landroid/view/View;

    const/4 v1, 0x0

    aput-object p0, v0, v1

    invoke-static {v0, p1}, Lcom/blankj/utilcode/util/ClickUtils;->applyGlobalDebouncing([Landroid/view/View;Landroid/view/View$OnClickListener;)V

    .line 290
    return-void
.end method

.method public static applyGlobalDebouncing([Landroid/view/View;JLandroid/view/View$OnClickListener;)V
    .locals 1
    .param p0, "views"    # [Landroid/view/View;
    .param p1, "duration"    # J
    .param p3, "listener"    # Landroid/view/View$OnClickListener;

    .line 325
    const/4 v0, 0x1

    invoke-static {p0, v0, p1, p2, p3}, Lcom/blankj/utilcode/util/ClickUtils;->applyDebouncing([Landroid/view/View;ZJLandroid/view/View$OnClickListener;)V

    .line 326
    return-void
.end method

.method public static applyGlobalDebouncing([Landroid/view/View;Landroid/view/View$OnClickListener;)V
    .locals 2
    .param p0, "views"    # [Landroid/view/View;
    .param p1, "listener"    # Landroid/view/View$OnClickListener;

    .line 312
    const-wide/16 v0, 0x3e8

    invoke-static {p0, v0, v1, p1}, Lcom/blankj/utilcode/util/ClickUtils;->applyGlobalDebouncing([Landroid/view/View;JLandroid/view/View$OnClickListener;)V

    .line 313
    return-void
.end method

.method public static applyPressedBgAlpha(Landroid/view/View;)V
    .locals 1
    .param p0, "view"    # Landroid/view/View;

    .line 148
    const v0, 0x3f666666    # 0.9f

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ClickUtils;->applyPressedBgAlpha(Landroid/view/View;F)V

    .line 149
    return-void
.end method

.method public static applyPressedBgAlpha(Landroid/view/View;F)V
    .locals 1
    .param p0, "view"    # Landroid/view/View;
    .param p1, "alpha"    # F

    .line 158
    const/4 v0, 0x4

    invoke-static {p0, v0, p1}, Lcom/blankj/utilcode/util/ClickUtils;->applyPressedBgStyle(Landroid/view/View;IF)V

    .line 159
    return-void
.end method

.method public static applyPressedBgDark(Landroid/view/View;)V
    .locals 1
    .param p0, "view"    # Landroid/view/View;

    .line 167
    const v0, 0x3f666666    # 0.9f

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ClickUtils;->applyPressedBgDark(Landroid/view/View;F)V

    .line 168
    return-void
.end method

.method public static applyPressedBgDark(Landroid/view/View;F)V
    .locals 1
    .param p0, "view"    # Landroid/view/View;
    .param p1, "darkAlpha"    # F

    .line 177
    const/4 v0, 0x5

    invoke-static {p0, v0, p1}, Lcom/blankj/utilcode/util/ClickUtils;->applyPressedBgStyle(Landroid/view/View;IF)V

    .line 178
    return-void
.end method

.method private static applyPressedBgStyle(Landroid/view/View;IF)V
    .locals 3
    .param p0, "view"    # Landroid/view/View;
    .param p1, "style"    # I
    .param p2, "value"    # F

    .line 181
    if-nez p0, :cond_0

    return-void

    .line 182
    :cond_0
    invoke-virtual {p0}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 183
    .local v0, "background":Landroid/graphics/drawable/Drawable;
    neg-int v1, p1

    invoke-virtual {p0, v1}, Landroid/view/View;->getTag(I)Ljava/lang/Object;

    move-result-object v1

    .line 184
    .local v1, "tag":Ljava/lang/Object;
    instance-of v2, v1, Landroid/graphics/drawable/Drawable;

    if-eqz v2, :cond_1

    .line 185
    move-object v2, v1

    check-cast v2, Landroid/graphics/drawable/Drawable;

    invoke-static {p0, v2}, Landroidx/core/view/ViewCompat;->setBackground(Landroid/view/View;Landroid/graphics/drawable/Drawable;)V

    goto :goto_0

    .line 187
    :cond_1
    invoke-static {v0, p1, p2}, Lcom/blankj/utilcode/util/ClickUtils;->createStyleDrawable(Landroid/graphics/drawable/Drawable;IF)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 188
    invoke-static {p0, v0}, Landroidx/core/view/ViewCompat;->setBackground(Landroid/view/View;Landroid/graphics/drawable/Drawable;)V

    .line 189
    neg-int v2, p1

    invoke-virtual {p0, v2, v0}, Landroid/view/View;->setTag(ILjava/lang/Object;)V

    .line 191
    :goto_0
    return-void
.end method

.method public static applyPressedViewAlpha(Landroid/view/View;F)V
    .locals 2
    .param p0, "view"    # Landroid/view/View;
    .param p1, "alpha"    # F

    .line 133
    if-nez p0, :cond_0

    .line 134
    return-void

    .line 136
    :cond_0
    const/4 v0, -0x2

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Landroid/view/View;->setTag(ILjava/lang/Object;)V

    .line 137
    invoke-virtual {p0}, Landroid/view/View;->getAlpha()F

    move-result v0

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    const/4 v1, -0x3

    invoke-virtual {p0, v1, v0}, Landroid/view/View;->setTag(ILjava/lang/Object;)V

    .line 138
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Landroid/view/View;->setClickable(Z)V

    .line 139
    invoke-static {}, Lcom/blankj/utilcode/util/ClickUtils$OnUtilsTouchListener;->getInstance()Lcom/blankj/utilcode/util/ClickUtils$OnUtilsTouchListener;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 140
    return-void
.end method

.method public static varargs applyPressedViewAlpha([Landroid/view/View;)V
    .locals 1
    .param p0, "views"    # [Landroid/view/View;

    .line 105
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ClickUtils;->applyPressedViewAlpha([Landroid/view/View;[F)V

    .line 106
    return-void
.end method

.method public static applyPressedViewAlpha([Landroid/view/View;[F)V
    .locals 3
    .param p0, "views"    # [Landroid/view/View;
    .param p1, "alphas"    # [F

    .line 115
    if-eqz p0, :cond_4

    array-length v0, p0

    if-nez v0, :cond_0

    goto :goto_3

    .line 116
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v1, p0

    if-ge v0, v1, :cond_3

    .line 117
    if-eqz p1, :cond_2

    array-length v1, p1

    if-lt v0, v1, :cond_1

    goto :goto_1

    .line 120
    :cond_1
    aget-object v1, p0, v0

    aget v2, p1, v0

    invoke-static {v1, v2}, Lcom/blankj/utilcode/util/ClickUtils;->applyPressedViewAlpha(Landroid/view/View;F)V

    goto :goto_2

    .line 118
    :cond_2
    :goto_1
    aget-object v1, p0, v0

    const v2, 0x3f4ccccd    # 0.8f

    invoke-static {v1, v2}, Lcom/blankj/utilcode/util/ClickUtils;->applyPressedViewAlpha(Landroid/view/View;F)V

    .line 116
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 123
    .end local v0    # "i":I
    :cond_3
    return-void

    .line 115
    :cond_4
    :goto_3
    return-void
.end method

.method public static applyPressedViewScale(Landroid/view/View;F)V
    .locals 2
    .param p0, "view"    # Landroid/view/View;
    .param p1, "scaleFactor"    # F

    .line 91
    if-nez p0, :cond_0

    .line 92
    return-void

    .line 94
    :cond_0
    const/4 v0, -0x1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Landroid/view/View;->setTag(ILjava/lang/Object;)V

    .line 95
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Landroid/view/View;->setClickable(Z)V

    .line 96
    invoke-static {}, Lcom/blankj/utilcode/util/ClickUtils$OnUtilsTouchListener;->getInstance()Lcom/blankj/utilcode/util/ClickUtils$OnUtilsTouchListener;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 97
    return-void
.end method

.method public static varargs applyPressedViewScale([Landroid/view/View;)V
    .locals 1
    .param p0, "views"    # [Landroid/view/View;

    .line 62
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ClickUtils;->applyPressedViewScale([Landroid/view/View;[F)V

    .line 63
    return-void
.end method

.method public static applyPressedViewScale([Landroid/view/View;[F)V
    .locals 3
    .param p0, "views"    # [Landroid/view/View;
    .param p1, "scaleFactors"    # [F

    .line 72
    if-eqz p0, :cond_4

    array-length v0, p0

    if-nez v0, :cond_0

    goto :goto_3

    .line 75
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v1, p0

    if-ge v0, v1, :cond_3

    .line 76
    if-eqz p1, :cond_2

    array-length v1, p1

    if-lt v0, v1, :cond_1

    goto :goto_1

    .line 79
    :cond_1
    aget-object v1, p0, v0

    aget v2, p1, v0

    invoke-static {v1, v2}, Lcom/blankj/utilcode/util/ClickUtils;->applyPressedViewScale(Landroid/view/View;F)V

    goto :goto_2

    .line 77
    :cond_2
    :goto_1
    aget-object v1, p0, v0

    const v2, -0x428a3d71    # -0.06f

    invoke-static {v1, v2}, Lcom/blankj/utilcode/util/ClickUtils;->applyPressedViewScale(Landroid/view/View;F)V

    .line 75
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 82
    .end local v0    # "i":I
    :cond_3
    return-void

    .line 73
    :cond_4
    :goto_3
    return-void
.end method

.method public static applySingleDebouncing(Landroid/view/View;JLandroid/view/View$OnClickListener;)V
    .locals 2
    .param p0, "view"    # Landroid/view/View;
    .param p1, "duration"    # J
    .param p3, "listener"    # Landroid/view/View$OnClickListener;

    .line 256
    const/4 v0, 0x1

    new-array v0, v0, [Landroid/view/View;

    const/4 v1, 0x0

    aput-object p0, v0, v1

    invoke-static {v0, p1, p2, p3}, Lcom/blankj/utilcode/util/ClickUtils;->applySingleDebouncing([Landroid/view/View;JLandroid/view/View$OnClickListener;)V

    .line 257
    return-void
.end method

.method public static applySingleDebouncing(Landroid/view/View;Landroid/view/View$OnClickListener;)V
    .locals 2
    .param p0, "view"    # Landroid/view/View;
    .param p1, "listener"    # Landroid/view/View$OnClickListener;

    .line 244
    const/4 v0, 0x1

    new-array v0, v0, [Landroid/view/View;

    const/4 v1, 0x0

    aput-object p0, v0, v1

    invoke-static {v0, p1}, Lcom/blankj/utilcode/util/ClickUtils;->applySingleDebouncing([Landroid/view/View;Landroid/view/View$OnClickListener;)V

    .line 245
    return-void
.end method

.method public static applySingleDebouncing([Landroid/view/View;JLandroid/view/View$OnClickListener;)V
    .locals 1
    .param p0, "views"    # [Landroid/view/View;
    .param p1, "duration"    # J
    .param p3, "listener"    # Landroid/view/View$OnClickListener;

    .line 279
    const/4 v0, 0x0

    invoke-static {p0, v0, p1, p2, p3}, Lcom/blankj/utilcode/util/ClickUtils;->applyDebouncing([Landroid/view/View;ZJLandroid/view/View$OnClickListener;)V

    .line 280
    return-void
.end method

.method public static applySingleDebouncing([Landroid/view/View;Landroid/view/View$OnClickListener;)V
    .locals 2
    .param p0, "views"    # [Landroid/view/View;
    .param p1, "listener"    # Landroid/view/View$OnClickListener;

    .line 266
    const-wide/16 v0, 0x3e8

    invoke-static {p0, v0, v1, p1}, Lcom/blankj/utilcode/util/ClickUtils;->applySingleDebouncing([Landroid/view/View;JLandroid/view/View$OnClickListener;)V

    .line 267
    return-void
.end method

.method public static back2HomeFriendly(Ljava/lang/CharSequence;)V
    .locals 3
    .param p0, "tip"    # Ljava/lang/CharSequence;

    .line 383
    const-wide/16 v0, 0x7d0

    sget-object v2, Lcom/blankj/utilcode/util/ClickUtils$Back2HomeFriendlyListener;->DEFAULT:Lcom/blankj/utilcode/util/ClickUtils$Back2HomeFriendlyListener;

    invoke-static {p0, v0, v1, v2}, Lcom/blankj/utilcode/util/ClickUtils;->back2HomeFriendly(Ljava/lang/CharSequence;JLcom/blankj/utilcode/util/ClickUtils$Back2HomeFriendlyListener;)V

    .line 384
    return-void
.end method

.method public static back2HomeFriendly(Ljava/lang/CharSequence;JLcom/blankj/utilcode/util/ClickUtils$Back2HomeFriendlyListener;)V
    .locals 4
    .param p0, "tip"    # Ljava/lang/CharSequence;
    .param p1, "duration"    # J
    .param p3, "listener"    # Lcom/blankj/utilcode/util/ClickUtils$Back2HomeFriendlyListener;

    .line 389
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 390
    .local v0, "nowMillis":J
    sget-wide v2, Lcom/blankj/utilcode/util/ClickUtils;->sLastClickMillis:J

    sub-long v2, v0, v2

    invoke-static {v2, v3}, Ljava/lang/Math;->abs(J)J

    move-result-wide v2

    cmp-long v2, v2, p1

    const/4 v3, 0x1

    if-gez v2, :cond_0

    .line 391
    sget v2, Lcom/blankj/utilcode/util/ClickUtils;->sClickCount:I

    add-int/2addr v2, v3

    sput v2, Lcom/blankj/utilcode/util/ClickUtils;->sClickCount:I

    .line 392
    sget v2, Lcom/blankj/utilcode/util/ClickUtils;->sClickCount:I

    const/4 v3, 0x2

    if-ne v2, v3, :cond_1

    .line 393
    invoke-static {}, Lcom/blankj/utilcode/util/UtilsBridge;->startHomeActivity()V

    .line 394
    invoke-interface {p3}, Lcom/blankj/utilcode/util/ClickUtils$Back2HomeFriendlyListener;->dismiss()V

    .line 395
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/blankj/utilcode/util/ClickUtils;->sLastClickMillis:J

    goto :goto_0

    .line 398
    :cond_0
    sput v3, Lcom/blankj/utilcode/util/ClickUtils;->sClickCount:I

    .line 399
    invoke-interface {p3, p0, p1, p2}, Lcom/blankj/utilcode/util/ClickUtils$Back2HomeFriendlyListener;->show(Ljava/lang/CharSequence;J)V

    .line 400
    sput-wide v0, Lcom/blankj/utilcode/util/ClickUtils;->sLastClickMillis:J

    .line 402
    :cond_1
    :goto_0
    return-void
.end method

.method private static createAlphaDrawable(Landroid/graphics/drawable/Drawable;F)Landroid/graphics/drawable/Drawable;
    .locals 2
    .param p0, "drawable"    # Landroid/graphics/drawable/Drawable;
    .param p1, "alpha"    # F

    .line 217
    new-instance v0, Lcom/blankj/utilcode/util/ClickUtils$ClickDrawableWrapper;

    invoke-direct {v0, p0}, Lcom/blankj/utilcode/util/ClickUtils$ClickDrawableWrapper;-><init>(Landroid/graphics/drawable/Drawable;)V

    .line 218
    .local v0, "drawableWrapper":Lcom/blankj/utilcode/util/ClickUtils$ClickDrawableWrapper;
    const/high16 v1, 0x437f0000    # 255.0f

    mul-float/2addr v1, p1

    float-to-int v1, v1

    invoke-virtual {v0, v1}, Lcom/blankj/utilcode/util/ClickUtils$ClickDrawableWrapper;->setAlpha(I)V

    .line 219
    return-object v0
.end method

.method private static createDarkDrawable(Landroid/graphics/drawable/Drawable;F)Landroid/graphics/drawable/Drawable;
    .locals 2
    .param p0, "drawable"    # Landroid/graphics/drawable/Drawable;
    .param p1, "alpha"    # F

    .line 223
    new-instance v0, Lcom/blankj/utilcode/util/ClickUtils$ClickDrawableWrapper;

    invoke-direct {v0, p0}, Lcom/blankj/utilcode/util/ClickUtils$ClickDrawableWrapper;-><init>(Landroid/graphics/drawable/Drawable;)V

    .line 224
    .local v0, "drawableWrapper":Lcom/blankj/utilcode/util/ClickUtils$ClickDrawableWrapper;
    invoke-static {p1}, Lcom/blankj/utilcode/util/ClickUtils;->getDarkColorFilter(F)Landroid/graphics/ColorMatrixColorFilter;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/blankj/utilcode/util/ClickUtils$ClickDrawableWrapper;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 225
    return-object v0
.end method

.method private static createStyleDrawable(Landroid/graphics/drawable/Drawable;IF)Landroid/graphics/drawable/Drawable;
    .locals 4
    .param p0, "src"    # Landroid/graphics/drawable/Drawable;
    .param p1, "style"    # I
    .param p2, "value"    # F

    .line 194
    if-nez p0, :cond_0

    .line 195
    new-instance v0, Landroid/graphics/drawable/ColorDrawable;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    move-object p0, v0

    .line 197
    :cond_0
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v0

    if-nez v0, :cond_1

    return-object p0

    .line 199
    :cond_1
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 200
    .local v0, "pressed":Landroid/graphics/drawable/Drawable;
    const/4 v1, 0x4

    if-ne p1, v1, :cond_2

    .line 201
    invoke-static {v0, p2}, Lcom/blankj/utilcode/util/ClickUtils;->createAlphaDrawable(Landroid/graphics/drawable/Drawable;F)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    goto :goto_0

    .line 202
    :cond_2
    const/4 v1, 0x5

    if-ne p1, v1, :cond_3

    .line 203
    invoke-static {v0, p2}, Lcom/blankj/utilcode/util/ClickUtils;->createDarkDrawable(Landroid/graphics/drawable/Drawable;F)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 206
    :cond_3
    :goto_0
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v1

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    .line 207
    .local v1, "disable":Landroid/graphics/drawable/Drawable;
    const/high16 v2, 0x3f000000    # 0.5f

    invoke-static {v1, v2}, Lcom/blankj/utilcode/util/ClickUtils;->createAlphaDrawable(Landroid/graphics/drawable/Drawable;F)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    .line 209
    new-instance v2, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v2}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    .line 210
    .local v2, "drawable":Landroid/graphics/drawable/StateListDrawable;
    const v3, 0x10100a7

    filled-new-array {v3}, [I

    move-result-object v3

    invoke-virtual {v2, v3, v0}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    .line 211
    const v3, -0x101009e

    filled-new-array {v3}, [I

    move-result-object v3

    invoke-virtual {v2, v3, v1}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    .line 212
    sget-object v3, Landroid/util/StateSet;->WILD_CARD:[I

    invoke-virtual {v2, v3, p0}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    .line 213
    return-object v2
.end method

.method public static expandClickArea(Landroid/view/View;I)V
    .locals 0
    .param p0, "view"    # Landroid/view/View;
    .param p1, "expandSize"    # I

    .line 351
    invoke-static {p0, p1, p1, p1, p1}, Lcom/blankj/utilcode/util/ClickUtils;->expandClickArea(Landroid/view/View;IIII)V

    .line 352
    return-void
.end method

.method public static expandClickArea(Landroid/view/View;IIII)V
    .locals 9
    .param p0, "view"    # Landroid/view/View;
    .param p1, "expandSizeTop"    # I
    .param p2, "expandSizeLeft"    # I
    .param p3, "expandSizeRight"    # I
    .param p4, "expandSizeBottom"    # I

    .line 359
    invoke-virtual {p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    .line 360
    .local v0, "parentView":Landroid/view/View;
    if-nez v0, :cond_0

    .line 361
    const-string v1, "ClickUtils"

    const-string v2, "expandClickArea must have parent view."

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 362
    return-void

    .line 364
    :cond_0
    new-instance v8, Lcom/blankj/utilcode/util/ClickUtils$2;

    move-object v1, v8

    move-object v2, p0

    move v3, p1

    move v4, p4

    move v5, p2

    move v6, p3

    move-object v7, v0

    invoke-direct/range {v1 .. v7}, Lcom/blankj/utilcode/util/ClickUtils$2;-><init>(Landroid/view/View;IIIILandroid/view/View;)V

    invoke-virtual {v0, v8}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    .line 376
    return-void
.end method

.method private static getDarkColorFilter(F)Landroid/graphics/ColorMatrixColorFilter;
    .locals 6
    .param p0, "darkAlpha"    # F

    .line 229
    new-instance v0, Landroid/graphics/ColorMatrixColorFilter;

    new-instance v1, Landroid/graphics/ColorMatrix;

    const/16 v2, 0x14

    new-array v2, v2, [F

    const/4 v3, 0x0

    aput p0, v2, v3

    const/4 v3, 0x1

    const/4 v4, 0x0

    aput v4, v2, v3

    const/4 v3, 0x2

    aput v4, v2, v3

    const/4 v3, 0x3

    aput v4, v2, v3

    const/4 v3, 0x4

    aput v4, v2, v3

    const/4 v3, 0x5

    aput v4, v2, v3

    const/4 v3, 0x6

    aput p0, v2, v3

    const/4 v3, 0x7

    aput v4, v2, v3

    const/16 v3, 0x8

    aput v4, v2, v3

    const/16 v3, 0x9

    aput v4, v2, v3

    const/16 v3, 0xa

    aput v4, v2, v3

    const/16 v3, 0xb

    aput v4, v2, v3

    const/16 v3, 0xc

    aput p0, v2, v3

    const/16 v3, 0xd

    aput v4, v2, v3

    const/16 v3, 0xe

    aput v4, v2, v3

    const/16 v3, 0xf

    aput v4, v2, v3

    const/16 v3, 0x10

    aput v4, v2, v3

    const/16 v3, 0x11

    aput v4, v2, v3

    const/high16 v3, 0x40000000    # 2.0f

    const/16 v5, 0x12

    aput v3, v2, v5

    const/16 v3, 0x13

    aput v4, v2, v3

    invoke-direct {v1, v2}, Landroid/graphics/ColorMatrix;-><init>([F)V

    invoke-direct {v0, v1}, Landroid/graphics/ColorMatrixColorFilter;-><init>(Landroid/graphics/ColorMatrix;)V

    return-object v0
.end method
