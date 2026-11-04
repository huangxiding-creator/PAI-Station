.class public Lcom/rokid/aicore/core/AIFaceRecogCore;
.super Ljava/lang/Object;


# static fields
.field private static final LOCK_LIST:Ljava/lang/String; = "LOCK_LIST"


# instance fields
.field private faceRecogConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

.field private faceRecognizerWrapper:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;

.field private isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

.field public mIsDestroyed:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->mIsDestroyed:Z

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method private convertFaceRecogResult(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;II)Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;
    .locals 12

    move-object/from16 v0, p6

    new-instance v11, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;

    new-instance v9, Landroid/graphics/Rect;

    iget v1, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    float-to-int v1, v1

    iget v2, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    float-to-int v2, v2

    iget v3, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    float-to-int v3, v3

    iget v0, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    float-to-int v0, v0

    invoke-direct {v9, v1, v2, v3, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    const/4 v10, 0x0

    move-object v0, v11

    move v1, p1

    move v2, p2

    move-object/from16 v3, p4

    move/from16 v4, p5

    move-object v5, p3

    move-object/from16 v6, p7

    move/from16 v7, p8

    move/from16 v8, p9

    invoke-direct/range {v0 .. v10}, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;-><init>(IILjava/lang/String;FLjava/lang/String;Ljava/nio/ByteBuffer;IILandroid/graphics/Rect;I)V

    return-object v11
.end method


# virtual methods
.method public destroy()V
    .locals 2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->mIsDestroyed:Z

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v1, "start destroy aicore"

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    :goto_0
    iget-object v0, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    const-wide/16 v0, 0xa

    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->faceRecognizerWrapper:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->faceRecognizerWrapper:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;

    :cond_1
    return-void
.end method

.method public getRecThreshold()F
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->faceRecogConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getRecThreshold()F

    move-result v0

    return v0
.end method

.method public init(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I
    .locals 8

    if-nez p1, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    iput-object p1, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->faceRecogConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    new-instance v7, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;

    invoke-virtual {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getRecModelName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getDetectModelName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isUseGpu()Z

    move-result v3

    invoke-virtual {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getRecThreshold()F

    move-result v4

    invoke-virtual {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getIqaThreshold()F

    move-result v5

    invoke-virtual {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAssetsMgr()Landroid/content/res/AssetManager;

    move-result-object v6

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;-><init>(Ljava/lang/String;Ljava/lang/String;ZFFLandroid/content/res/AssetManager;)V

    iput-object v7, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->faceRecognizerWrapper:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->mIsDestroyed:Z

    return p1
.end method

.method public process(Lcom/rokid/aicore/api/bean/RecognizeDataInput;)Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;
    .locals 13

    iget-boolean v0, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->mIsDestroyed:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "processFaceRecognize error.because has destroyed"

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->d(Ljava/lang/String;)V

    return-object v1

    :cond_0
    iget-object v0, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->data:[B

    if-eqz v0, :cond_5

    array-length v0, v0

    if-gtz v0, :cond_1

    goto/16 :goto_0

    :cond_1
    iget-object v0, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->type:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->ordinal()I

    move-result v0

    sget-object v2, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->BRG:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    invoke-virtual {v2}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->ordinal()I

    move-result v2

    if-le v0, v2, :cond_2

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "processFaceRecognize error.ImageInput type is error "

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->d(Ljava/lang/String;)V

    return-object v1

    :cond_2
    iget-object v0, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    iget-object v3, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->faceRecognizerWrapper:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;

    iget-wide v4, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->frameId:J

    long-to-int v4, v4

    iget v5, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->trackId:I

    iget-object v6, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->data:[B

    iget v7, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->width:I

    iget v8, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->height:I

    iget-object v9, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->type:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    invoke-virtual/range {v3 .. v9}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->recognizeImage(II[BIILcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;)Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;

    move-result-object v0

    if-eqz v0, :cond_4

    sget-object v2, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "faceRecogResult recognized frame: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;->frameId:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", track_Id: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;->trackId:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", rec_score: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;->recogScore:F

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", label: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;->recogLabel:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget v3, v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;->recogScore:F

    invoke-virtual {p0}, Lcom/rokid/aicore/core/AIFaceRecogCore;->getRecThreshold()F

    move-result v4

    cmpg-float v3, v3, v4

    if-gez v3, :cond_3

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "faceRecogResult recognized but recognize score is lower than threshold, recognizeScore:"

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget v0, v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;->recogScore:F

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "; recThreshold: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p0}, Lcom/rokid/aicore/core/AIFaceRecogCore;->getRecThreshold()F

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    return-object v1

    :cond_3
    iget v4, v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;->frameId:I

    iget v5, v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;->trackId:I

    iget-object v6, v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;->libraryName:Ljava/lang/String;

    iget-object v7, v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;->recogLabel:Ljava/lang/String;

    iget v8, v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;->recogScore:F

    new-instance v9, Lcom/rokid/aicore/ncnn/bean/MotBBox;

    const/4 v0, 0x0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-direct {v9, v0, v0, v1, v1}, Lcom/rokid/aicore/ncnn/bean/MotBBox;-><init>(FFFF)V

    iget-object v0, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->data:[B

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v10

    iget v11, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->width:I

    iget v12, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->height:I

    move-object v3, p0

    invoke-direct/range {v3 .. v12}, Lcom/rokid/aicore/core/AIFaceRecogCore;->convertFaceRecogResult(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;II)Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;

    move-result-object v1

    :cond_4
    iget-object p1, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    return-object v1

    :cond_5
    :goto_0
    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "processFaceRecognize error.imageInput is null"

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->d(Ljava/lang/String;)V

    return-object v1
.end method

.method public removeFeatureLibrary(Ljava/lang/String;)I
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->faceRecognizerWrapper:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->delFeatureLibrary(Ljava/lang/String;)I

    move-result p1

    return p1

    :cond_0
    const/4 p1, -0x1

    return p1
.end method

.method public setFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/core/AIFaceRecogCore;->faceRecognizerWrapper:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->addFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    return p1

    :cond_0
    const/4 p1, -0x1

    return p1
.end method
