.class public Lcom/rokid/aicore/ncnn/bean/MotDetection;
.super Ljava/lang/Object;
.source "MotDetection.java"


# instance fields
.field public colorProb:F

.field public featId:I

.field public frameId:J

.field public iqaScore:F

.field public isDetected:Z

.field public label:Ljava/lang/String;

.field public landmark:[Lcom/rokid/aicore/ncnn/bean/MotPoint;

.field public plateChars:Ljava/lang/String;

.field public plateColor:Ljava/lang/String;

.field public plateTwiceLayers:Z

.field public prob:F

.field public recProb:F

.field public recProbs:[F

.field public rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

.field public trackId:J

.field public type:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 5
    const/4 v0, 0x5

    new-array v0, v0, [Lcom/rokid/aicore/ncnn/bean/MotPoint;

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotDetection;->landmark:[Lcom/rokid/aicore/ncnn/bean/MotPoint;

    return-void
.end method


# virtual methods
.method public normalize(FF)V
    .locals 2
    .param p1, "imageWidth"    # F
    .param p2, "imageHeight"    # F

    .line 27
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    if-eqz v0, :cond_2

    const/4 v0, 0x0

    cmpg-float v1, p1, v0

    if-lez v1, :cond_2

    cmpg-float v0, p2, v0

    if-gtz v0, :cond_0

    goto :goto_0

    .line 30
    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    if-eqz v0, :cond_1

    .line 31
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v1, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    div-float/2addr v1, p1

    iput v1, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    .line 32
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v1, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    div-float/2addr v1, p1

    iput v1, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    .line 33
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v1, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    div-float/2addr v1, p2

    iput v1, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    .line 34
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v1, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    div-float/2addr v1, p2

    iput v1, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    .line 36
    :cond_1
    return-void

    .line 28
    :cond_2
    :goto_0
    return-void
.end method
