.class public Lcom/rokid/aicore/api/callback/result/base/HandPoint;
.super Lcom/rokid/aicore/api/callback/result/base/Point;


# instance fields
.field private z:F


# direct methods
.method public constructor <init>(FFF)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/rokid/aicore/api/callback/result/base/Point;-><init>(FF)V

    iput p3, p0, Lcom/rokid/aicore/api/callback/result/base/HandPoint;->z:F

    return-void
.end method


# virtual methods
.method public getZ()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/base/HandPoint;->z:F

    return v0
.end method

.method public setZ(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/base/HandPoint;->z:F

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "HandPoint{z="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/base/HandPoint;->z:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-super {p0}, Lcom/rokid/aicore/api/callback/result/base/Point;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
