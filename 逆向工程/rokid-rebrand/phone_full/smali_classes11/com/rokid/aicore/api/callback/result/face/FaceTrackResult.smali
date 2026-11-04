.class public Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;
.super Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;


# instance fields
.field private data:[B

.field private dataBuffer:Ljava/nio/ByteBuffer;

.field private faceScore:F

.field private iqaScore:F

.field private x1:F

.field private x2:F

.field private y1:F

.field private y2:F


# direct methods
.method public constructor <init>(JJ)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;-><init>(JJ)V

    return-void
.end method


# virtual methods
.method public getData()[B
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->data:[B

    return-object v0
.end method

.method public getDataBuffer()Ljava/nio/ByteBuffer;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->dataBuffer:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getFaceScore()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->faceScore:F

    return v0
.end method

.method public getIqaScore()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->iqaScore:F

    return v0
.end method

.method public getX1()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->x1:F

    return v0
.end method

.method public getX2()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->x2:F

    return v0
.end method

.method public getY1()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->y1:F

    return v0
.end method

.method public getY2()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->y2:F

    return v0
.end method

.method public setBounds(Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;)V
    .locals 1

    invoke-virtual {p1}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getX1()F

    move-result v0

    invoke-virtual {p0, v0}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setX1(F)V

    invoke-virtual {p1}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getY1()F

    move-result v0

    invoke-virtual {p0, v0}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setY1(F)V

    invoke-virtual {p1}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getX2()F

    move-result v0

    invoke-virtual {p0, v0}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setX2(F)V

    invoke-virtual {p1}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getY2()F

    move-result p1

    invoke-virtual {p0, p1}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setY2(F)V

    return-void
.end method

.method public setData([B)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->data:[B

    return-void
.end method

.method public setDataBuffer(Ljava/nio/ByteBuffer;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->dataBuffer:Ljava/nio/ByteBuffer;

    return-void
.end method

.method public setFaceScore(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->faceScore:F

    return-void
.end method

.method public setIqaScore(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->iqaScore:F

    return-void
.end method

.method public setX1(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->x1:F

    return-void
.end method

.method public setX2(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->x2:F

    return-void
.end method

.method public setY1(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->y1:F

    return-void
.end method

.method public setY2(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->y2:F

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "FaceTrackResult{x1="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->x1:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", y1="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->y1:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", x2="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->x2:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", y2="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->y2:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", faceScore="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->faceScore:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", iqaScore="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->iqaScore:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-super {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
