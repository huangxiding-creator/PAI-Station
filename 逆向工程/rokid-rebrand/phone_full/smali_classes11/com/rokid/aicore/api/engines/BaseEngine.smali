.class public abstract Lcom/rokid/aicore/api/engines/BaseEngine;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/rokid/aicore/api/IAIEngine;
.implements Lcom/rokid/aicore/api/callback/AICallback;
.implements Lcom/rokid/aicore/api/callback/BufferAICallback;


# static fields
.field private static final TAG:Ljava/lang/String; = "BaseEngine"


# instance fields
.field public aiCore:Lcom/rokid/aicore/core/AICore;

.field public mType:Lcom/rokid/aicore/type/AIType;


# direct methods
.method public constructor <init>(Lcom/rokid/aicore/type/AIType;)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "############BaseEngine type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/rokid/aicore/type/AIType;->getValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iput-object p1, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->mType:Lcom/rokid/aicore/type/AIType;

    new-instance p1, Lcom/rokid/aicore/core/AICore;

    invoke-direct {p1}, Lcom/rokid/aicore/core/AICore;-><init>()V

    iput-object p1, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    invoke-virtual {p1, p0}, Lcom/rokid/aicore/core/AICore;->setAICallback(Lcom/rokid/aicore/api/callback/AICallback;)V

    return-void
.end method


# virtual methods
.method public AIFaceDetectEvent(ILjava/util/List;Ljava/nio/ByteBuffer;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/List<",
            "Lcom/rokid/aicore/ncnn/bean/MotDetection;",
            ">;",
            "Ljava/nio/ByteBuffer;",
            "II)V"
        }
    .end annotation

    return-void
.end method

.method public AIRecogEvent(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)V
    .locals 0

    return-void
.end method

.method public AIUnRecogEvent(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)V
    .locals 0

    return-void
.end method

.method public addActiveFace(II)I
    .locals 3

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "############addActiveFace but aiCore instance is null; frameId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, ", trackId: "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/core/AICore;->addActiveFace(II)I

    move-result p1

    return p1
.end method

.method public addActiveFeature(II[F)I
    .locals 2

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    sget-object p3, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "############addActiveFeature but aiCore instance is null; frameId: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ", trackId: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/aicore/core/AICore;->addActiveFeature(II[F)I

    move-result p1

    return p1
.end method

.method public authorize(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/core/AICore;->authorize(Ljava/lang/String;Ljava/lang/String;)V

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string p2, "#########authorize "

    invoke-virtual {p1, p2}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    return-void
.end method

.method public clearActiveFace(II)I
    .locals 3

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "############clearActiveFace but aiCore instance is null; frameId:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, ", trackId: "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/core/AICore;->clearActiveFace(II)I

    move-result p1

    return p1
.end method

.method public cropSmallFaceBitmap(Landroid/graphics/Rect;J)Landroid/graphics/Bitmap;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/aicore/core/AICore;->cropSmallFaceBitmap(Landroid/graphics/Rect;J)Landroid/graphics/Bitmap;

    move-result-object p1

    return-object p1
.end method

.method public disable()V
    .locals 3

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "############disable algor "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->mType:Lcom/rokid/aicore/type/AIType;

    invoke-virtual {v2}, Lcom/rokid/aicore/type/AIType;->getValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/aicore/core/AICore;->disable()V

    :cond_0
    return-void
.end method

.method public enable()V
    .locals 3

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "############enable algor "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->mType:Lcom/rokid/aicore/type/AIType;

    invoke-virtual {v2}, Lcom/rokid/aicore/type/AIType;->getValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/aicore/core/AICore;->enable()V

    :cond_0
    return-void
.end method

.method public getDetectScore()F
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    invoke-virtual {v0}, Lcom/rokid/aicore/core/AICore;->getDetectScore()F

    move-result v0

    return v0
.end method

.method public initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/core/AICore;->init(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I

    move-result p1

    return p1
.end method

.method public isEnable()Z
    .locals 3

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "############isEnable but aiCore instance is null "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->mType:Lcom/rokid/aicore/type/AIType;

    invoke-virtual {v2}, Lcom/rokid/aicore/type/AIType;->getValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 v0, 0x0

    return v0

    :cond_0
    invoke-virtual {v0}, Lcom/rokid/aicore/core/AICore;->isEnable()Z

    move-result v0

    return v0
.end method

.method public matchActiveFace(IILcom/rokid/aicore/ncnn/MotWrapper$MatchResult;)Z
    .locals 2

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    sget-object p3, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "############matchActiveFace but aiCore instance is null , frameId: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ", trackId: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p3, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1

    :cond_0
    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/aicore/core/AICore;->matchActiveFace(IILcom/rokid/aicore/ncnn/MotWrapper$MatchResult;)Z

    move-result p1

    return p1
.end method

.method public process(Lcom/rokid/aicore/api/bean/ImageInput;)Z
    .locals 2

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "############process but aiCore instance is null "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->mType:Lcom/rokid/aicore/type/AIType;

    invoke-virtual {v1}, Lcom/rokid/aicore/type/AIType;->getValue()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1

    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/core/AICore;->process(Lcom/rokid/aicore/api/bean/ImageInput;)[Lcom/rokid/aicore/ncnn/bean/MotDetection;

    const/4 p1, 0x1

    return p1
.end method

.method public processAsync(Lcom/rokid/aicore/api/bean/ImageInput;)Z
    .locals 2

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "############processAsync but aiCore instance is null "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->mType:Lcom/rokid/aicore/type/AIType;

    invoke-virtual {v1}, Lcom/rokid/aicore/type/AIType;->getValue()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1

    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/core/AICore;->processAsync(Lcom/rokid/aicore/api/bean/ImageInput;)V

    const/4 p1, 0x1

    return p1
.end method

.method public processAsyncV2(Lcom/rokid/aicore/api/bean/ImageInput;)Z
    .locals 2

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "############processAsync but aiCore instance is null "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->mType:Lcom/rokid/aicore/type/AIType;

    invoke-virtual {v1}, Lcom/rokid/aicore/type/AIType;->getValue()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1

    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/core/AICore;->processAsyncV2(Lcom/rokid/aicore/api/bean/ImageInput;)V

    const/4 p1, 0x1

    return p1
.end method

.method public processBuffer(Lcom/rokid/aicore/api/bean/BufferImageInput;)Z
    .locals 2

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "############processBuffer but aiCore instance is null "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->mType:Lcom/rokid/aicore/type/AIType;

    invoke-virtual {v1}, Lcom/rokid/aicore/type/AIType;->getValue()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1

    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/core/AICore;->processBuffer(Lcom/rokid/aicore/api/bean/BufferImageInput;)[Lcom/rokid/aicore/ncnn/bean/MotDetection;

    const/4 p1, 0x1

    return p1
.end method

.method public release()V
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    invoke-virtual {v0}, Lcom/rokid/aicore/core/AICore;->removeCallback()V

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    invoke-virtual {v0}, Lcom/rokid/aicore/core/AICore;->destroy()V

    return-void
.end method

.method public removeFeatureLibrary(Ljava/lang/String;)I
    .locals 3

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "############removeFeatureLibrary but aiCore instance is null\uff1b libraryName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/core/AICore;->removeFeatureLibrary(Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public setFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I
    .locals 3

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->aiCore:Lcom/rokid/aicore/core/AICore;

    if-nez v0, :cond_0

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "############setFeatureLibrary but aiCore instance is null ;libraryName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, ", libraryFile: "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/core/AICore;->setFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "BaseEngine{mType="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/engines/BaseEngine;->mType:Lcom/rokid/aicore/type/AIType;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
