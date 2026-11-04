.class Lcom/blankj/utilcode/util/SpanUtils$ShadowSpan;
.super Landroid/text/style/CharacterStyle;
.source "SpanUtils.java"

# interfaces
.implements Landroid/text/style/UpdateAppearance;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blankj/utilcode/util/SpanUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "ShadowSpan"
.end annotation


# instance fields
.field private dx:F

.field private dy:F

.field private radius:F

.field private shadowColor:I


# direct methods
.method private constructor <init>(FFFI)V
    .locals 0
    .param p1, "radius"    # F
    .param p2, "dx"    # F
    .param p3, "dy"    # F
    .param p4, "shadowColor"    # I

    .line 1447
    invoke-direct {p0}, Landroid/text/style/CharacterStyle;-><init>()V

    .line 1448
    iput p1, p0, Lcom/blankj/utilcode/util/SpanUtils$ShadowSpan;->radius:F

    .line 1449
    iput p2, p0, Lcom/blankj/utilcode/util/SpanUtils$ShadowSpan;->dx:F

    .line 1450
    iput p3, p0, Lcom/blankj/utilcode/util/SpanUtils$ShadowSpan;->dy:F

    .line 1451
    iput p4, p0, Lcom/blankj/utilcode/util/SpanUtils$ShadowSpan;->shadowColor:I

    .line 1452
    return-void
.end method

.method synthetic constructor <init>(FFFILcom/blankj/utilcode/util/SpanUtils$1;)V
    .locals 0
    .param p1, "x0"    # F
    .param p2, "x1"    # F
    .param p3, "x2"    # F
    .param p4, "x3"    # I
    .param p5, "x4"    # Lcom/blankj/utilcode/util/SpanUtils$1;

    .line 1439
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/blankj/utilcode/util/SpanUtils$ShadowSpan;-><init>(FFFI)V

    return-void
.end method


# virtual methods
.method public updateDrawState(Landroid/text/TextPaint;)V
    .locals 4
    .param p1, "tp"    # Landroid/text/TextPaint;

    .line 1456
    iget v0, p0, Lcom/blankj/utilcode/util/SpanUtils$ShadowSpan;->radius:F

    iget v1, p0, Lcom/blankj/utilcode/util/SpanUtils$ShadowSpan;->dx:F

    iget v2, p0, Lcom/blankj/utilcode/util/SpanUtils$ShadowSpan;->dy:F

    iget v3, p0, Lcom/blankj/utilcode/util/SpanUtils$ShadowSpan;->shadowColor:I

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/text/TextPaint;->setShadowLayer(FFFI)V

    .line 1457
    return-void
.end method
