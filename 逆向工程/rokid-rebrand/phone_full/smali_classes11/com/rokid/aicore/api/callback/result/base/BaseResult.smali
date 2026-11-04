.class public abstract Lcom/rokid/aicore/api/callback/result/base/BaseResult;
.super Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;


# instance fields
.field private conf:F

.field private frameId:J

.field private labelId:I

.field private label_id:J

.field private timeStamp:J

.field private trackId:J


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;-><init>()V

    return-void
.end method

.method public constructor <init>(FFFF)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;-><init>(FFFF)V

    return-void
.end method


# virtual methods
.method public getConf()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->conf:F

    return v0
.end method

.method public getFrameId()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->frameId:J

    return-wide v0
.end method

.method public getLabelId()I
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->labelId:I

    return v0
.end method

.method public getLabel_id()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->label_id:J

    return-wide v0
.end method

.method public getTimeStamp()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->timeStamp:J

    return-wide v0
.end method

.method public getTrackId()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->trackId:J

    return-wide v0
.end method

.method public setConf(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->conf:F

    return-void
.end method

.method public setFrameId(J)V
    .locals 0

    iput-wide p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->frameId:J

    return-void
.end method

.method public setLabelId(I)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->labelId:I

    return-void
.end method

.method public setLabel_id(J)V
    .locals 0

    iput-wide p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->label_id:J

    return-void
.end method

.method public setTimeStamp(J)V
    .locals 0

    iput-wide p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->timeStamp:J

    return-void
.end method

.method public setTrackId(J)V
    .locals 0

    iput-wide p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->trackId:J

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "BaseResult{frameId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->frameId:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", timeStamp="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->timeStamp:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-super {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
