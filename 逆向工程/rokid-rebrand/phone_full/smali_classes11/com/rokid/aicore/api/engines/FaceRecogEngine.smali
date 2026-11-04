.class public Lcom/rokid/aicore/api/engines/FaceRecogEngine;
.super Ljava/lang/Object;


# instance fields
.field private aiCore:Lcom/rokid/aicore/core/AIFaceRecogCore;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v1, "############FaceRecogEngine create "

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/aicore/core/AIFaceRecogCore;

    invoke-direct {v0}, Lcom/rokid/aicore/core/AIFaceRecogCore;-><init>()V

    iput-object v0, p0, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->aiCore:Lcom/rokid/aicore/core/AIFaceRecogCore;

    return-void
.end method


# virtual methods
.method public getRecThreshold()F
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->aiCore:Lcom/rokid/aicore/core/AIFaceRecogCore;

    invoke-virtual {v0}, Lcom/rokid/aicore/core/AIFaceRecogCore;->getRecThreshold()F

    move-result v0

    return v0
.end method

.method public initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->aiCore:Lcom/rokid/aicore/core/AIFaceRecogCore;

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/core/AIFaceRecogCore;->init(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I

    move-result p1

    return p1
.end method

.method public process(Lcom/rokid/aicore/api/bean/RecognizeDataInput;)Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->aiCore:Lcom/rokid/aicore/core/AIFaceRecogCore;

    if-nez v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "############FaceRecogEngine#process but aiCore instance is null "

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, 0x0

    return-object p1

    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/core/AIFaceRecogCore;->process(Lcom/rokid/aicore/api/bean/RecognizeDataInput;)Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;

    move-result-object p1

    return-object p1
.end method

.method public release()V
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->aiCore:Lcom/rokid/aicore/core/AIFaceRecogCore;

    invoke-virtual {v0}, Lcom/rokid/aicore/core/AIFaceRecogCore;->destroy()V

    return-void
.end method

.method public removeFeatureLibrary(Ljava/lang/String;)I
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->aiCore:Lcom/rokid/aicore/core/AIFaceRecogCore;

    if-nez v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "############FaceRecogEngine#removeFeatureLibrary but aiCore instance is null "

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/core/AIFaceRecogCore;->removeFeatureLibrary(Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public setFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->aiCore:Lcom/rokid/aicore/core/AIFaceRecogCore;

    if-nez v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string p2, "############FaceRecogEngine#setFeatureLibrary but aiCore instance is null "

    invoke-virtual {p1, p2}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/core/AIFaceRecogCore;->setFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    return p1
.end method
