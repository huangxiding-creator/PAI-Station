.class public Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;
.super Landroid/graphics/drawable/Drawable;
.source "SplitBackgroundDrawable.java"


# static fields
.field private static final DEFAULT_BACKGROUND_COLOR:I = -0x1


# instance fields
.field private distanceFromTopToSplitPoint:I

.field private paint:Landroid/graphics/Paint;

.field private topBackgroundColor:I


# direct methods
.method public constructor <init>(I)V
    .locals 2
    .param p1, "distanceFromTop"    # I

    .line 37
    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    .line 33
    const/4 v0, -0x1

    iput v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->distanceFromTopToSplitPoint:I

    .line 38
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    iput-object v1, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->paint:Landroid/graphics/Paint;

    .line 39
    iput v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->topBackgroundColor:I

    .line 40
    invoke-virtual {p0, p1}, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->setSplitPointDistanceFromTop(I)V

    .line 41
    return-void
.end method

.method public constructor <init>(II)V
    .locals 1
    .param p1, "distanceFromTop"    # I
    .param p2, "topBackgroundColor"    # I

    .line 43
    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    .line 33
    const/4 v0, -0x1

    iput v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->distanceFromTopToSplitPoint:I

    .line 44
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->paint:Landroid/graphics/Paint;

    .line 45
    iput p2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->topBackgroundColor:I

    .line 46
    invoke-virtual {p0, p1}, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->setSplitPointDistanceFromTop(I)V

    .line 47
    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 13
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 56
    invoke-virtual {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    .line 57
    .local v0, "b":Landroid/graphics/Rect;
    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->paint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->topBackgroundColor:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 58
    iget v1, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->distanceFromTopToSplitPoint:I

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v2

    if-ge v1, v2, :cond_0

    iget v1, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->distanceFromTopToSplitPoint:I

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v1

    :goto_0
    int-to-float v1, v1

    move v6, v1

    .line 60
    .local v6, "y":F
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-float v5, v1

    iget-object v7, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->paint:Landroid/graphics/Paint;

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v2, p1

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 61
    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->paint:Landroid/graphics/Paint;

    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 62
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-float v10, v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v1

    int-to-float v11, v1

    iget-object v12, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->paint:Landroid/graphics/Paint;

    const/4 v8, 0x0

    move-object v7, p1

    move v9, v6

    invoke-virtual/range {v7 .. v12}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 63
    return-void
.end method

.method public getOpacity()I
    .locals 1

    .line 75
    const/4 v0, -0x3

    return v0
.end method

.method public setAlpha(I)V
    .locals 0
    .param p1, "alpha"    # I

    .line 67
    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .locals 0
    .param p1, "colorFilter"    # Landroid/graphics/ColorFilter;

    .line 71
    return-void
.end method

.method public setSplitPointDistanceFromTop(I)V
    .locals 0
    .param p1, "distanceFromTop"    # I

    .line 50
    iput p1, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->distanceFromTopToSplitPoint:I

    .line 51
    invoke-virtual {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/SplitBackgroundDrawable;->invalidateSelf()V

    .line 52
    return-void
.end method
