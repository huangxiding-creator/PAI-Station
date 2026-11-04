.class abstract Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;
.super Landroid/text/style/ReplacementSpan;
.source "SpanUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blankj/utilcode/util/SpanUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x408
    name = "CustomDynamicDrawableSpan"
.end annotation


# static fields
.field static final ALIGN_BASELINE:I = 0x1

.field static final ALIGN_BOTTOM:I = 0x0

.field static final ALIGN_CENTER:I = 0x2

.field static final ALIGN_TOP:I = 0x3


# instance fields
.field private mDrawableRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/graphics/drawable/Drawable;",
            ">;"
        }
    .end annotation
.end field

.field final mVerticalAlignment:I


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 1341
    invoke-direct {p0}, Landroid/text/style/ReplacementSpan;-><init>()V

    .line 1342
    const/4 v0, 0x0

    iput v0, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->mVerticalAlignment:I

    .line 1343
    return-void
.end method

.method private constructor <init>(I)V
    .locals 0
    .param p1, "verticalAlignment"    # I

    .line 1345
    invoke-direct {p0}, Landroid/text/style/ReplacementSpan;-><init>()V

    .line 1346
    iput p1, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->mVerticalAlignment:I

    .line 1347
    return-void
.end method

.method synthetic constructor <init>(ILcom/blankj/utilcode/util/SpanUtils$1;)V
    .locals 0
    .param p1, "x0"    # I
    .param p2, "x1"    # Lcom/blankj/utilcode/util/SpanUtils$1;

    .line 1329
    invoke-direct {p0, p1}, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;-><init>(I)V

    return-void
.end method

.method private getCachedDrawable()Landroid/graphics/drawable/Drawable;
    .locals 3

    .line 1411
    iget-object v0, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->mDrawableRef:Ljava/lang/ref/WeakReference;

    .line 1412
    .local v0, "wr":Ljava/lang/ref/WeakReference;, "Ljava/lang/ref/WeakReference<Landroid/graphics/drawable/Drawable;>;"
    const/4 v1, 0x0

    .line 1413
    .local v1, "d":Landroid/graphics/drawable/Drawable;
    if-eqz v0, :cond_0

    .line 1414
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v2

    move-object v1, v2

    check-cast v1, Landroid/graphics/drawable/Drawable;

    .line 1416
    :cond_0
    if-nez v1, :cond_1

    .line 1417
    invoke-virtual {p0}, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    .line 1418
    new-instance v2, Ljava/lang/ref/WeakReference;

    invoke-direct {v2, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v2, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->mDrawableRef:Ljava/lang/ref/WeakReference;

    .line 1420
    :cond_1
    return-object v1
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;Ljava/lang/CharSequence;IIFIIILandroid/graphics/Paint;)V
    .locals 6
    .param p1, "canvas"    # Landroid/graphics/Canvas;
    .param p2, "text"    # Ljava/lang/CharSequence;
    .param p3, "start"    # I
    .param p4, "end"    # I
    .param p5, "x"    # F
    .param p6, "top"    # I
    .param p7, "y"    # I
    .param p8, "bottom"    # I
    .param p9, "paint"    # Landroid/graphics/Paint;

    .line 1385
    invoke-direct {p0}, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->getCachedDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 1386
    .local v0, "d":Landroid/graphics/drawable/Drawable;
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v1

    .line 1387
    .local v1, "rect":Landroid/graphics/Rect;
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 1389
    sub-int v2, p8, p6

    .line 1392
    .local v2, "lineHeight":I
    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v3

    if-ge v3, v2, :cond_3

    .line 1393
    iget v3, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->mVerticalAlignment:I

    const/4 v4, 0x3

    if-ne v3, v4, :cond_0

    .line 1394
    int-to-float v3, p6

    .local v3, "transY":F
    goto :goto_0

    .line 1395
    .end local v3    # "transY":F
    :cond_0
    iget v3, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->mVerticalAlignment:I

    const/4 v4, 0x2

    if-ne v3, v4, :cond_1

    .line 1396
    add-int v3, p8, p6

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v5

    sub-int/2addr v3, v5

    div-int/2addr v3, v4

    int-to-float v3, v3

    .restart local v3    # "transY":F
    goto :goto_0

    .line 1397
    .end local v3    # "transY":F
    :cond_1
    iget v3, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->mVerticalAlignment:I

    const/4 v4, 0x1

    if-ne v3, v4, :cond_2

    .line 1398
    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v3

    sub-int v3, p7, v3

    int-to-float v3, v3

    .restart local v3    # "transY":F
    goto :goto_0

    .line 1400
    .end local v3    # "transY":F
    :cond_2
    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v3

    sub-int v3, p8, v3

    int-to-float v3, v3

    .line 1402
    .restart local v3    # "transY":F
    :goto_0
    invoke-virtual {p1, p5, v3}, Landroid/graphics/Canvas;->translate(FF)V

    goto :goto_1

    .line 1404
    .end local v3    # "transY":F
    :cond_3
    int-to-float v3, p6

    invoke-virtual {p1, p5, v3}, Landroid/graphics/Canvas;->translate(FF)V

    .line 1406
    :goto_1
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    .line 1407
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 1408
    return-void
.end method

.method public abstract getDrawable()Landroid/graphics/drawable/Drawable;
.end method

.method public getSize(Landroid/graphics/Paint;Ljava/lang/CharSequence;IILandroid/graphics/Paint$FontMetricsInt;)I
    .locals 6
    .param p1, "paint"    # Landroid/graphics/Paint;
    .param p2, "text"    # Ljava/lang/CharSequence;
    .param p3, "start"    # I
    .param p4, "end"    # I
    .param p5, "fm"    # Landroid/graphics/Paint$FontMetricsInt;

    .line 1354
    invoke-direct {p0}, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->getCachedDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 1355
    .local v0, "d":Landroid/graphics/drawable/Drawable;
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v1

    .line 1356
    .local v1, "rect":Landroid/graphics/Rect;
    if-eqz p5, :cond_2

    .line 1362
    iget v2, p5, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    iget v3, p5, Landroid/graphics/Paint$FontMetricsInt;->top:I

    sub-int/2addr v2, v3

    .line 1363
    .local v2, "lineHeight":I
    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v3

    if-ge v2, v3, :cond_2

    .line 1364
    iget v3, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->mVerticalAlignment:I

    const/4 v4, 0x3

    if-ne v3, v4, :cond_0

    .line 1365
    iget v3, p5, Landroid/graphics/Paint$FontMetricsInt;->top:I

    iput v3, p5, Landroid/graphics/Paint$FontMetricsInt;->top:I

    .line 1366
    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v3

    iget v4, p5, Landroid/graphics/Paint$FontMetricsInt;->top:I

    add-int/2addr v3, v4

    iput v3, p5, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    goto :goto_0

    .line 1367
    :cond_0
    iget v3, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomDynamicDrawableSpan;->mVerticalAlignment:I

    const/4 v4, 0x2

    if-ne v3, v4, :cond_1

    .line 1368
    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v3

    neg-int v3, v3

    div-int/2addr v3, v4

    div-int/lit8 v5, v2, 0x4

    sub-int/2addr v3, v5

    iput v3, p5, Landroid/graphics/Paint$FontMetricsInt;->top:I

    .line 1369
    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v3

    div-int/2addr v3, v4

    div-int/lit8 v4, v2, 0x4

    sub-int/2addr v3, v4

    iput v3, p5, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    goto :goto_0

    .line 1371
    :cond_1
    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v3

    neg-int v3, v3

    iget v4, p5, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    add-int/2addr v3, v4

    iput v3, p5, Landroid/graphics/Paint$FontMetricsInt;->top:I

    .line 1372
    iget v3, p5, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    iput v3, p5, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    .line 1374
    :goto_0
    iget v3, p5, Landroid/graphics/Paint$FontMetricsInt;->top:I

    iput v3, p5, Landroid/graphics/Paint$FontMetricsInt;->ascent:I

    .line 1375
    iget v3, p5, Landroid/graphics/Paint$FontMetricsInt;->bottom:I

    iput v3, p5, Landroid/graphics/Paint$FontMetricsInt;->descent:I

    .line 1378
    .end local v2    # "lineHeight":I
    :cond_2
    iget v2, v1, Landroid/graphics/Rect;->right:I

    return v2
.end method
