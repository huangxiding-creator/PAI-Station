.class public Lcom/rokid/aicore/utils/FaceRectUtils;
.super Ljava/lang/Object;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static center2Rect(Landroid/graphics/Point;IIII)Landroid/graphics/Rect;
    .locals 3

    iget v0, p0, Landroid/graphics/Point;->x:I

    div-int/lit8 p1, p1, 0x2

    sub-int v1, v0, p1

    add-int/2addr v0, p1

    iget p0, p0, Landroid/graphics/Point;->y:I

    div-int/lit8 p2, p2, 0x2

    sub-int p1, p0, p2

    add-int/2addr p0, p2

    new-instance p2, Landroid/graphics/Rect;

    invoke-direct {p2}, Landroid/graphics/Rect;-><init>()V

    const/4 v2, 0x0

    if-lez v1, :cond_0

    goto :goto_0

    :cond_0
    move v1, v2

    :goto_0
    iput v1, p2, Landroid/graphics/Rect;->left:I

    if-ge v0, p3, :cond_1

    move p3, v0

    :cond_1
    iput p3, p2, Landroid/graphics/Rect;->right:I

    if-lez p1, :cond_2

    goto :goto_1

    :cond_2
    move p1, v2

    :goto_1
    iput p1, p2, Landroid/graphics/Rect;->top:I

    if-ge p0, p4, :cond_3

    move p4, p0

    :cond_3
    iput p4, p2, Landroid/graphics/Rect;->bottom:I

    return-object p2
.end method

.method public static pointDis(IIII)J
    .locals 4

    sub-int/2addr p0, p2

    int-to-double v0, p0

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    sub-int/2addr p1, p3

    int-to-double p0, p1

    invoke-static {p0, p1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide p0

    add-double/2addr v0, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide p0

    invoke-static {p0, p1}, Ljava/lang/Math;->round(D)J

    move-result-wide p0

    return-wide p0
.end method

.method public static pointDisPow2(IIII)J
    .locals 4

    sub-int/2addr p0, p2

    int-to-double v0, p0

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    sub-int/2addr p1, p3

    int-to-double p0, p1

    invoke-static {p0, p1, v2, v3}, Ljava/lang/Math;->pow(DD)D

    move-result-wide p0

    add-double/2addr v0, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide p0

    return-wide p0
.end method

.method public static pointDisPow2(Landroid/graphics/Point;Landroid/graphics/Point;)J
    .locals 2

    iget v0, p0, Landroid/graphics/Point;->x:I

    iget p0, p0, Landroid/graphics/Point;->y:I

    iget v1, p1, Landroid/graphics/Point;->x:I

    iget p1, p1, Landroid/graphics/Point;->y:I

    invoke-static {v0, p0, v1, p1}, Lcom/rokid/aicore/utils/FaceRectUtils;->pointDisPow2(IIII)J

    move-result-wide p0

    return-wide p0
.end method

.method public static rect2Center(Landroid/graphics/Rect;)Landroid/graphics/Point;
    .locals 3

    new-instance v0, Landroid/graphics/Point;

    iget v1, p0, Landroid/graphics/Rect;->left:I

    iget v2, p0, Landroid/graphics/Rect;->right:I

    add-int/2addr v1, v2

    div-int/lit8 v1, v1, 0x2

    iget v2, p0, Landroid/graphics/Rect;->top:I

    iget p0, p0, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v2, p0

    div-int/lit8 v2, v2, 0x2

    invoke-direct {v0, v1, v2}, Landroid/graphics/Point;-><init>(II)V

    return-object v0
.end method

.method public static scaleRect(Landroid/graphics/Rect;IIF)Landroid/graphics/Rect;
    .locals 2

    invoke-static {p0}, Lcom/rokid/aicore/utils/FaceRectUtils;->rect2Center(Landroid/graphics/Rect;)Landroid/graphics/Point;

    move-result-object v0

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-float v1, v1

    mul-float/2addr v1, p3

    float-to-int v1, v1

    invoke-virtual {p0}, Landroid/graphics/Rect;->height()I

    move-result p0

    int-to-float p0, p0

    mul-float/2addr p0, p3

    float-to-int p0, p0

    invoke-static {v0, v1, p0, p1, p2}, Lcom/rokid/aicore/utils/FaceRectUtils;->center2Rect(Landroid/graphics/Point;IIII)Landroid/graphics/Rect;

    move-result-object p0

    return-object p0
.end method

.method public static toMirror(Landroid/graphics/Rect;I)Landroid/graphics/Rect;
    .locals 1

    iget v0, p0, Landroid/graphics/Rect;->right:I

    sub-int v0, p1, v0

    iput v0, p0, Landroid/graphics/Rect;->left:I

    sub-int/2addr p1, v0

    iput p1, p0, Landroid/graphics/Rect;->right:I

    return-object p0
.end method

.method public static toMirror(Landroid/graphics/RectF;)Landroid/graphics/RectF;
    .locals 2

    iget v0, p0, Landroid/graphics/RectF;->left:F

    const/high16 v1, 0x3f800000    # 1.0f

    sub-float v0, v1, v0

    iput v0, p0, Landroid/graphics/RectF;->left:F

    iget v0, p0, Landroid/graphics/RectF;->right:F

    sub-float/2addr v1, v0

    iput v1, p0, Landroid/graphics/RectF;->right:F

    return-object p0
.end method

.method public static toRect(Landroid/graphics/Rect;FII)Landroid/graphics/Rect;
    .locals 2

    invoke-static {p0}, Lcom/rokid/aicore/utils/FaceRectUtils;->rect2Center(Landroid/graphics/Rect;)Landroid/graphics/Point;

    move-result-object v0

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-float v1, v1

    mul-float/2addr v1, p1

    float-to-int v1, v1

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result p0

    int-to-float p0, p0

    mul-float/2addr p0, p1

    float-to-int p0, p0

    invoke-static {v0, v1, p0, p2, p3}, Lcom/rokid/aicore/utils/FaceRectUtils;->center2Rect(Landroid/graphics/Point;IIII)Landroid/graphics/Rect;

    move-result-object p0

    return-object p0
.end method

.method public static toRect(Landroid/graphics/Rect;IIII)Landroid/graphics/Rect;
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/aicore/utils/FaceRectUtils;->toRectF(Landroid/graphics/Rect;II)Landroid/graphics/RectF;

    move-result-object p0

    invoke-static {p0, p3, p4}, Lcom/rokid/aicore/utils/FaceRectUtils;->toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;

    move-result-object p0

    return-object p0
.end method

.method public static toRect(Landroid/graphics/Rect;Lcom/rokid/aicore/bean/FaceSize;Lcom/rokid/aicore/bean/FaceSize;)Landroid/graphics/Rect;
    .locals 1

    iget v0, p1, Lcom/rokid/aicore/bean/FaceSize;->width:I

    iget p1, p1, Lcom/rokid/aicore/bean/FaceSize;->height:I

    invoke-static {p0, v0, p1}, Lcom/rokid/aicore/utils/FaceRectUtils;->toRectF(Landroid/graphics/Rect;II)Landroid/graphics/RectF;

    move-result-object p0

    iget p1, p2, Lcom/rokid/aicore/bean/FaceSize;->width:I

    iget p2, p2, Lcom/rokid/aicore/bean/FaceSize;->height:I

    invoke-static {p0, p1, p2}, Lcom/rokid/aicore/utils/FaceRectUtils;->toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;

    move-result-object p0

    return-object p0
.end method

.method public static toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;
    .locals 3

    iget v0, p0, Landroid/graphics/RectF;->left:F

    int-to-float p1, p1

    mul-float/2addr v0, p1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    iget v1, p0, Landroid/graphics/RectF;->top:F

    int-to-float p2, p2

    mul-float/2addr v1, p2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    iget v2, p0, Landroid/graphics/RectF;->right:F

    mul-float/2addr v2, p1

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result p1

    iget p0, p0, Landroid/graphics/RectF;->bottom:F

    mul-float/2addr p0, p2

    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result p0

    new-instance p2, Landroid/graphics/Rect;

    invoke-direct {p2, v0, v1, p1, p0}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object p2
.end method

.method public static toRectF(Landroid/graphics/Rect;II)Landroid/graphics/RectF;
    .locals 5

    new-instance v0, Landroid/graphics/RectF;

    iget v1, p0, Landroid/graphics/Rect;->left:I

    int-to-float v1, v1

    const/high16 v2, 0x3f800000    # 1.0f

    mul-float/2addr v1, v2

    int-to-float p1, p1

    div-float/2addr v1, p1

    iget v3, p0, Landroid/graphics/Rect;->top:I

    int-to-float v3, v3

    mul-float/2addr v3, v2

    int-to-float p2, p2

    div-float/2addr v3, p2

    iget v4, p0, Landroid/graphics/Rect;->right:I

    int-to-float v4, v4

    mul-float/2addr v4, v2

    div-float/2addr v4, p1

    iget p0, p0, Landroid/graphics/Rect;->bottom:I

    int-to-float p0, p0

    mul-float/2addr p0, v2

    div-float/2addr p0, p2

    invoke-direct {v0, v1, v3, v4, p0}, Landroid/graphics/RectF;-><init>(FFFF)V

    return-object v0
.end method
