.class public Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Comparable;


# instance fields
.field private frameId:J

.field private labelId:I

.field private timeStamp:J

.field private trackId:J


# direct methods
.method public constructor <init>(JJ)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p3, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->trackId:J

    iput-wide p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->frameId:J

    return-void
.end method


# virtual methods
.method public compareTo(Ljava/lang/Object;)I
    .locals 4

    check-cast p1, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;

    iget-wide v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->trackId:J

    iget-wide v2, p1, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->trackId:J

    cmp-long p1, v0, v2

    if-lez p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    if-gez p1, :cond_1

    const/4 p1, -0x1

    return p1

    :cond_1
    const/4 p1, 0x0

    return p1
.end method

.method public getFrameId()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->frameId:J

    return-wide v0
.end method

.method public getKey()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->getTrackId()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->getTrackId()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getLabelId()I
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->labelId:I

    return v0
.end method

.method public getTimeStamp()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->timeStamp:J

    return-wide v0
.end method

.method public getTrackId()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->trackId:J

    return-wide v0
.end method

.method public setFrameId(J)V
    .locals 0

    iput-wide p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->frameId:J

    return-void
.end method

.method public setLabelId(I)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->labelId:I

    return-void
.end method

.method public setTimeStamp(J)V
    .locals 0

    iput-wide p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->timeStamp:J

    return-void
.end method

.method public setTrackId(I)V
    .locals 2

    int-to-long v0, p1

    iput-wide v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->trackId:J

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "BaseFaceResult{trackId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->trackId:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", frameId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->frameId:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", timeStamp="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->timeStamp:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
