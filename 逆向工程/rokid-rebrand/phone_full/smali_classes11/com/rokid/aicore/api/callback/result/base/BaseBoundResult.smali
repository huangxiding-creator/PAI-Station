.class public Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;
.super Ljava/lang/Object;


# instance fields
.field private x1:F

.field private x2:F

.field private y1:F

.field private y2:F


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(FFFF)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->x1:F

    iput p2, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->y1:F

    iput p3, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->x2:F

    iput p4, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->y2:F

    return-void
.end method


# virtual methods
.method public getX1()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->x1:F

    return v0
.end method

.method public getX2()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->x2:F

    return v0
.end method

.method public getY1()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->y1:F

    return v0
.end method

.method public getY2()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->y2:F

    return v0
.end method

.method public setX1(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->x1:F

    return-void
.end method

.method public setX2(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->x2:F

    return-void
.end method

.method public setY1(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->y1:F

    return-void
.end method

.method public setY2(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->y2:F

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "{x1="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->x1:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", y1="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->y1:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", x2="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->x2:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", y2="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->y2:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
