.class public Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;
.super Lcom/rokid/aicore/api/callback/result/base/BaseResult;


# instance fields
.field private data:[B

.field private detectScore:F

.field private height:I

.field private width:I


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;-><init>()V

    return-void
.end method


# virtual methods
.method public getBitmap()Landroid/graphics/Bitmap;
    .locals 8

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->data:[B

    if-eqz v0, :cond_1

    array-length v1, v0

    if-gtz v1, :cond_0

    goto :goto_0

    :cond_0
    iget v1, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->width:I

    iget v2, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->height:I

    new-instance v3, Landroid/graphics/Rect;

    invoke-virtual {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getX1()F

    move-result v4

    float-to-int v4, v4

    invoke-virtual {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getY1()F

    move-result v5

    float-to-int v5, v5

    invoke-virtual {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getX2()F

    move-result v6

    float-to-int v6, v6

    invoke-virtual {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getY2()F

    move-result v7

    float-to-int v7, v7

    invoke-direct {v3, v4, v5, v6, v7}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-static {v0, v1, v2, v3}, Lcom/rokid/aicore/utils/BitmapUtils;->nv21ToBitmap([BIILandroid/graphics/Rect;)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0

    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getData()[B
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->data:[B

    return-object v0
.end method

.method public getDetectScore()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->detectScore:F

    return v0
.end method

.method public getHeight()I
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->height:I

    return v0
.end method

.method public getWidth()I
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->width:I

    return v0
.end method

.method public setData([B)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->data:[B

    return-void
.end method

.method public setDetectScore(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->detectScore:F

    return-void
.end method

.method public setHeight(I)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->height:I

    return-void
.end method

.method public setWidth(I)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->width:I

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "BarcodeDetectResult{, frameId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->getFrameId()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "rect=\'("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getX1()F

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getY1()F

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getX2()F

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getY2()F

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "), score="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->detectScore:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
