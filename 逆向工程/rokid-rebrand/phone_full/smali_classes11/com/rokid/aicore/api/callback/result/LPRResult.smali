.class public Lcom/rokid/aicore/api/callback/result/LPRResult;
.super Lcom/rokid/aicore/api/callback/result/base/BaseResult;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;
    }
.end annotation


# instance fields
.field private color:Ljava/lang/String;

.field private data:[B

.field private dataBuffer:Ljava/nio/ByteBuffer;

.field private label:Ljava/lang/String;

.field private plateCharScore:F

.field private plateCharScores:[F

.field private plateColorScore:F

.field private plateStatus:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

.field private score:F


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;-><init>()V

    sget-object v0, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->VALID:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    iput-object v0, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateStatus:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    return-void
.end method


# virtual methods
.method public getColor()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->color:Ljava/lang/String;

    return-object v0
.end method

.method public getData()[B
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->data:[B

    return-object v0
.end method

.method public getDataBuffer()Ljava/nio/ByteBuffer;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->dataBuffer:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getLabel()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->label:Ljava/lang/String;

    return-object v0
.end method

.method public getPlateCharScore()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateCharScore:F

    return v0
.end method

.method public getPlateCharScores()[F
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateCharScores:[F

    return-object v0
.end method

.method public getPlateColorScore()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateColorScore:F

    return v0
.end method

.method public getPlateStatus()Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateStatus:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    return-object v0
.end method

.method public getScore()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->score:F

    return v0
.end method

.method public setColor(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->color:Ljava/lang/String;

    return-void
.end method

.method public setData([B)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->data:[B

    return-void
.end method

.method public setDataBuffer(Ljava/nio/ByteBuffer;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->dataBuffer:Ljava/nio/ByteBuffer;

    return-void
.end method

.method public setLabel(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->label:Ljava/lang/String;

    return-void
.end method

.method public setPlateCharScore(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateCharScore:F

    return-void
.end method

.method public setPlateCharScores([F)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateCharScores:[F

    return-void
.end method

.method public setPlateColorScore(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateColorScore:F

    return-void
.end method

.method public setPlateStatus(Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateStatus:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    return-void
.end method

.method public setScore(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->score:F

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "LPRResult{label=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->label:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", score="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->score:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", color="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->color:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", plateCharScore="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateCharScore:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", plateColorScore="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateColorScore:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", plateStatus="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/callback/result/LPRResult;->plateStatus:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-super {p0}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
