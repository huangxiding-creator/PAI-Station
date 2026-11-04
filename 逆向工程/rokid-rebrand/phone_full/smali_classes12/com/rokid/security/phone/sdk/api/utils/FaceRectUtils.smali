.class public Lcom/rokid/security/phone/sdk/api/utils/FaceRectUtils;
.super Ljava/lang/Object;
.source "FaceRectUtils.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    return-void
.end method

.method public static center2Rect(Landroid/graphics/Point;IIII)Landroid/graphics/Rect;
    .locals 7
    .param p0, "center"    # Landroid/graphics/Point;
    .param p1, "rectW"    # I
    .param p2, "rectH"    # I
    .param p3, "width"    # I
    .param p4, "height"    # I

    .line 48
    iget v0, p0, Landroid/graphics/Point;->x:I

    div-int/lit8 v1, p1, 0x2

    sub-int/2addr v0, v1

    .line 49
    .local v0, "left":I
    iget v1, p0, Landroid/graphics/Point;->x:I

    div-int/lit8 v2, p1, 0x2

    add-int/2addr v1, v2

    .line 50
    .local v1, "right":I
    iget v2, p0, Landroid/graphics/Point;->y:I

    div-int/lit8 v3, p2, 0x2

    sub-int/2addr v2, v3

    .line 51
    .local v2, "top":I
    iget v3, p0, Landroid/graphics/Point;->y:I

    div-int/lit8 v4, p2, 0x2

    add-int/2addr v3, v4

    .line 52
    .local v3, "bottom":I
    new-instance v4, Landroid/graphics/Rect;

    invoke-direct {v4}, Landroid/graphics/Rect;-><init>()V

    .line 53
    .local v4, "rect":Landroid/graphics/Rect;
    const/4 v5, 0x0

    if-lez v0, :cond_0

    move v6, v0

    goto :goto_0

    :cond_0
    move v6, v5

    :goto_0
    iput v6, v4, Landroid/graphics/Rect;->left:I

    .line 54
    if-ge v1, p3, :cond_1

    move v6, v1

    goto :goto_1

    :cond_1
    move v6, p3

    :goto_1
    iput v6, v4, Landroid/graphics/Rect;->right:I

    .line 55
    if-lez v2, :cond_2

    move v5, v2

    :cond_2
    iput v5, v4, Landroid/graphics/Rect;->top:I

    .line 56
    if-ge v3, p4, :cond_3

    move v5, v3

    goto :goto_2

    :cond_3
    move v5, p4

    :goto_2
    iput v5, v4, Landroid/graphics/Rect;->bottom:I

    .line 57
    return-object v4
.end method

.method public static pointDis(IIII)J
    .locals 6
    .param p0, "x1"    # I
    .param p1, "y1"    # I
    .param p2, "x2"    # I
    .param p3, "y2"    # I

    .line 44
    sub-int v0, p0, p2

    int-to-double v0, v0

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    sub-int v4, p1, p3

    int-to-double v4, v4

    invoke-static {v4, v5, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    add-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    return-wide v0
.end method

.method public static pointDisPow2(IIII)J
    .locals 6
    .param p0, "x1"    # I
    .param p1, "y1"    # I
    .param p2, "x2"    # I
    .param p3, "y2"    # I

    .line 40
    sub-int v0, p0, p2

    int-to-double v0, v0

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    sub-int v4, p1, p3

    int-to-double v4, v4

    invoke-static {v4, v5, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    add-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    return-wide v0
.end method

.method public static pointDisPow2(Landroid/graphics/Point;Landroid/graphics/Point;)J
    .locals 4
    .param p0, "left"    # Landroid/graphics/Point;
    .param p1, "right"    # Landroid/graphics/Point;

    .line 36
    iget v0, p0, Landroid/graphics/Point;->x:I

    iget v1, p0, Landroid/graphics/Point;->y:I

    iget v2, p1, Landroid/graphics/Point;->x:I

    iget v3, p1, Landroid/graphics/Point;->y:I

    invoke-static {v0, v1, v2, v3}, Lcom/rokid/security/phone/sdk/api/utils/FaceRectUtils;->pointDisPow2(IIII)J

    move-result-wide v0

    return-wide v0
.end method

.method public static rect2Center(Landroid/graphics/Rect;)Landroid/graphics/Point;
    .locals 4
    .param p0, "rect"    # Landroid/graphics/Rect;

    .line 32
    new-instance v0, Landroid/graphics/Point;

    iget v1, p0, Landroid/graphics/Rect;->left:I

    iget v2, p0, Landroid/graphics/Rect;->right:I

    add-int/2addr v1, v2

    div-int/lit8 v1, v1, 0x2

    iget v2, p0, Landroid/graphics/Rect;->top:I

    iget v3, p0, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v2, v3

    div-int/lit8 v2, v2, 0x2

    invoke-direct {v0, v1, v2}, Landroid/graphics/Point;-><init>(II)V

    return-object v0
.end method

.method public static scaleRect(Landroid/graphics/Rect;IIF)Landroid/graphics/Rect;
    .locals 3
    .param p0, "rect"    # Landroid/graphics/Rect;
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "scale"    # F

    .line 61
    invoke-static {p0}, Lcom/rokid/security/phone/sdk/api/utils/FaceRectUtils;->rect2Center(Landroid/graphics/Rect;)Landroid/graphics/Point;

    move-result-object v0

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-float v1, v1

    mul-float/2addr v1, p3

    float-to-int v1, v1

    invoke-virtual {p0}, Landroid/graphics/Rect;->height()I

    move-result v2

    int-to-float v2, v2

    mul-float/2addr v2, p3

    float-to-int v2, v2

    invoke-static {v0, v1, v2, p1, p2}, Lcom/rokid/security/phone/sdk/api/utils/FaceRectUtils;->center2Rect(Landroid/graphics/Point;IIII)Landroid/graphics/Rect;

    move-result-object v0

    return-object v0
.end method

.method public static toMirror(Landroid/graphics/Rect;I)Landroid/graphics/Rect;
    .locals 1
    .param p0, "rect"    # Landroid/graphics/Rect;
    .param p1, "width"    # I

    .line 69
    iget v0, p0, Landroid/graphics/Rect;->right:I

    sub-int v0, p1, v0

    iput v0, p0, Landroid/graphics/Rect;->left:I

    .line 70
    iget v0, p0, Landroid/graphics/Rect;->left:I

    sub-int v0, p1, v0

    iput v0, p0, Landroid/graphics/Rect;->right:I

    .line 71
    return-object p0
.end method

.method public static toMirror(Landroid/graphics/RectF;)Landroid/graphics/RectF;
    .locals 2
    .param p0, "rectF"    # Landroid/graphics/RectF;

    .line 75
    iget v0, p0, Landroid/graphics/RectF;->left:F

    const/high16 v1, 0x3f800000    # 1.0f

    sub-float v0, v1, v0

    iput v0, p0, Landroid/graphics/RectF;->left:F

    .line 76
    iget v0, p0, Landroid/graphics/RectF;->right:F

    sub-float/2addr v1, v0

    iput v1, p0, Landroid/graphics/RectF;->right:F

    .line 77
    return-object p0
.end method

.method public static toRect(Landroid/graphics/Rect;FII)Landroid/graphics/Rect;
    .locals 3
    .param p0, "srcRect"    # Landroid/graphics/Rect;
    .param p1, "scale"    # F
    .param p2, "width"    # I
    .param p3, "height"    # I

    .line 65
    invoke-static {p0}, Lcom/rokid/security/phone/sdk/api/utils/FaceRectUtils;->rect2Center(Landroid/graphics/Rect;)Landroid/graphics/Point;

    move-result-object v0

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-float v1, v1

    mul-float/2addr v1, p1

    float-to-int v1, v1

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result v2

    int-to-float v2, v2

    mul-float/2addr v2, p1

    float-to-int v2, v2

    invoke-static {v0, v1, v2, p2, p3}, Lcom/rokid/security/phone/sdk/api/utils/FaceRectUtils;->center2Rect(Landroid/graphics/Point;IIII)Landroid/graphics/Rect;

    move-result-object v0

    return-object v0
.end method

.method public static toRect(Landroid/graphics/Rect;IIII)Landroid/graphics/Rect;
    .locals 1
    .param p0, "srcRect"    # Landroid/graphics/Rect;
    .param p1, "srcW"    # I
    .param p2, "srcH"    # I
    .param p3, "dstW"    # I
    .param p4, "dstH"    # I

    .line 24
    invoke-static {p0, p1, p2}, Lcom/rokid/security/phone/sdk/api/utils/FaceRectUtils;->toRectF(Landroid/graphics/Rect;II)Landroid/graphics/RectF;

    move-result-object v0

    invoke-static {v0, p3, p4}, Lcom/rokid/security/phone/sdk/api/utils/FaceRectUtils;->toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;

    move-result-object v0

    return-object v0
.end method

.method public static toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;
    .locals 5
    .param p0, "rectF"    # Landroid/graphics/RectF;
    .param p1, "width"    # I
    .param p2, "height"    # I

    .line 16
    iget v0, p0, Landroid/graphics/RectF;->left:F

    int-to-float v1, p1

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 17
    .local v0, "left":I
    iget v1, p0, Landroid/graphics/RectF;->top:F

    int-to-float v2, p2

    mul-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 18
    .local v1, "top":I
    iget v2, p0, Landroid/graphics/RectF;->right:F

    int-to-float v3, p1

    mul-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 19
    .local v2, "right":I
    iget v3, p0, Landroid/graphics/RectF;->bottom:F

    int-to-float v4, p2

    mul-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    .line 20
    .local v3, "bottom":I
    new-instance v4, Landroid/graphics/Rect;

    invoke-direct {v4, v0, v1, v2, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v4
.end method

.method public static toRectF(Landroid/graphics/Rect;II)Landroid/graphics/RectF;
    .locals 6
    .param p0, "rect"    # Landroid/graphics/Rect;
    .param p1, "width"    # I
    .param p2, "height"    # I

    .line 12
    new-instance v0, Landroid/graphics/RectF;

    iget v1, p0, Landroid/graphics/Rect;->left:I

    int-to-float v1, v1

    const/high16 v2, 0x3f800000    # 1.0f

    mul-float/2addr v1, v2

    int-to-float v3, p1

    div-float/2addr v1, v3

    iget v3, p0, Landroid/graphics/Rect;->top:I

    int-to-float v3, v3

    mul-float/2addr v3, v2

    int-to-float v4, p2

    div-float/2addr v3, v4

    iget v4, p0, Landroid/graphics/Rect;->right:I

    int-to-float v4, v4

    mul-float/2addr v4, v2

    int-to-float v5, p1

    div-float/2addr v4, v5

    iget v5, p0, Landroid/graphics/Rect;->bottom:I

    int-to-float v5, v5

    mul-float/2addr v5, v2

    int-to-float v2, p2

    div-float/2addr v5, v2

    invoke-direct {v0, v1, v3, v4, v5}, Landroid/graphics/RectF;-><init>(FFFF)V

    return-object v0
.end method
