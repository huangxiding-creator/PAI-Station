.class Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;
.super Ljava/lang/Object;
.source "SpanUtils.java"

# interfaces
.implements Landroid/text/style/LeadingMarginSpan;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blankj/utilcode/util/SpanUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "CustomBulletSpan"
.end annotation


# instance fields
.field private final color:I

.field private final gapWidth:I

.field private final radius:I

.field private sBulletPath:Landroid/graphics/Path;


# direct methods
.method private constructor <init>(III)V
    .locals 1
    .param p1, "color"    # I
    .param p2, "radius"    # I
    .param p3, "gapWidth"    # I

    .line 1180
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1178
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->sBulletPath:Landroid/graphics/Path;

    .line 1181
    iput p1, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->color:I

    .line 1182
    iput p2, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->radius:I

    .line 1183
    iput p3, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->gapWidth:I

    .line 1184
    return-void
.end method

.method synthetic constructor <init>(IIILcom/blankj/utilcode/util/SpanUtils$1;)V
    .locals 0
    .param p1, "x0"    # I
    .param p2, "x1"    # I
    .param p3, "x2"    # I
    .param p4, "x3"    # Lcom/blankj/utilcode/util/SpanUtils$1;

    .line 1172
    invoke-direct {p0, p1, p2, p3}, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;-><init>(III)V

    return-void
.end method


# virtual methods
.method public drawLeadingMargin(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIIIILjava/lang/CharSequence;IIZLandroid/text/Layout;)V
    .locals 11
    .param p1, "c"    # Landroid/graphics/Canvas;
    .param p2, "p"    # Landroid/graphics/Paint;
    .param p3, "x"    # I
    .param p4, "dir"    # I
    .param p5, "top"    # I
    .param p6, "baseline"    # I
    .param p7, "bottom"    # I
    .param p8, "text"    # Ljava/lang/CharSequence;
    .param p9, "start"    # I
    .param p10, "end"    # I
    .param p11, "first"    # Z
    .param p12, "l"    # Landroid/text/Layout;

    .line 1194
    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object/from16 v3, p8

    check-cast v3, Landroid/text/Spanned;

    invoke-interface {v3, p0}, Landroid/text/Spanned;->getSpanStart(Ljava/lang/Object;)I

    move-result v3

    move/from16 v4, p9

    if-ne v3, v4, :cond_2

    .line 1195
    invoke-virtual {p2}, Landroid/graphics/Paint;->getStyle()Landroid/graphics/Paint$Style;

    move-result-object v3

    .line 1196
    .local v3, "style":Landroid/graphics/Paint$Style;
    const/4 v5, 0x0

    .line 1197
    .local v5, "oldColor":I
    invoke-virtual {p2}, Landroid/graphics/Paint;->getColor()I

    move-result v5

    .line 1198
    iget v6, v0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->color:I

    invoke-virtual {p2, v6}, Landroid/graphics/Paint;->setColor(I)V

    .line 1199
    sget-object v6, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p2, v6}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 1200
    invoke-virtual {p1}, Landroid/graphics/Canvas;->isHardwareAccelerated()Z

    move-result v6

    const/high16 v7, 0x40000000    # 2.0f

    if-eqz v6, :cond_1

    .line 1201
    iget-object v6, v0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->sBulletPath:Landroid/graphics/Path;

    if-nez v6, :cond_0

    .line 1202
    new-instance v6, Landroid/graphics/Path;

    invoke-direct {v6}, Landroid/graphics/Path;-><init>()V

    iput-object v6, v0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->sBulletPath:Landroid/graphics/Path;

    .line 1204
    iget-object v6, v0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->sBulletPath:Landroid/graphics/Path;

    iget v8, v0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->radius:I

    int-to-float v8, v8

    sget-object v9, Landroid/graphics/Path$Direction;->CW:Landroid/graphics/Path$Direction;

    const/4 v10, 0x0

    invoke-virtual {v6, v10, v10, v8, v9}, Landroid/graphics/Path;->addCircle(FFFLandroid/graphics/Path$Direction;)V

    .line 1206
    :cond_0
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 1207
    iget v6, v0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->radius:I

    mul-int/2addr v6, p4

    add-int/2addr v6, p3

    int-to-float v6, v6

    add-int v8, p5, p7

    int-to-float v8, v8

    div-float/2addr v8, v7

    invoke-virtual {p1, v6, v8}, Landroid/graphics/Canvas;->translate(FF)V

    .line 1208
    iget-object v6, v0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->sBulletPath:Landroid/graphics/Path;

    invoke-virtual {p1, v6, p2}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 1209
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    goto :goto_0

    .line 1211
    :cond_1
    iget v6, v0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->radius:I

    mul-int/2addr v6, p4

    add-int/2addr v6, p3

    int-to-float v6, v6

    add-int v8, p5, p7

    int-to-float v8, v8

    div-float/2addr v8, v7

    iget v7, v0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->radius:I

    int-to-float v7, v7

    invoke-virtual {p1, v6, v8, v7, p2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 1213
    :goto_0
    invoke-virtual {p2, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 1214
    invoke-virtual {p2, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 1216
    .end local v3    # "style":Landroid/graphics/Paint$Style;
    .end local v5    # "oldColor":I
    :cond_2
    return-void
.end method

.method public getLeadingMargin(Z)I
    .locals 2
    .param p1, "first"    # Z

    .line 1187
    iget v0, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->radius:I

    mul-int/lit8 v0, v0, 0x2

    iget v1, p0, Lcom/blankj/utilcode/util/SpanUtils$CustomBulletSpan;->gapWidth:I

    add-int/2addr v0, v1

    return v0
.end method
