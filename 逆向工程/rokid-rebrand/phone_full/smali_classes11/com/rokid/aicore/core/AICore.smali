.class public Lcom/rokid/aicore/core/AICore;
.super Ljava/lang/Object;


# static fields
.field private static final LOCK_LIST:Ljava/lang/String; = "LOCK_LIST"

.field public static mSendDataThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;


# instance fields
.field private aiCallback:Lcom/rokid/aicore/api/callback/AICallback;

.field private isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private isInited:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private mDetectCallback:Lcom/rokid/aicore/ncnn/DetectCallback;

.field public volatile mIsDestroyed:Z

.field private mRecognizeCallback:Lcom/rokid/aicore/ncnn/RecognizeCallback;

.field private mWhitelistUnrecognizeCallback:Lcom/rokid/aicore/ncnn/UnrecognizeCallback;

.field private motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

.field private motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;


# direct methods
.method public constructor <init>()V
    .locals 10

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/aicore/core/AICore;->isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/aicore/core/AICore;->isInited:Ljava/util/concurrent/atomic/AtomicBoolean;

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    new-instance v0, Lcom/rokid/aicore/core/AICore$1;

    invoke-direct {v0, p0}, Lcom/rokid/aicore/core/AICore$1;-><init>(Lcom/rokid/aicore/core/AICore;)V

    iput-object v0, p0, Lcom/rokid/aicore/core/AICore;->mRecognizeCallback:Lcom/rokid/aicore/ncnn/RecognizeCallback;

    new-instance v0, Lcom/rokid/aicore/core/AICore$2;

    invoke-direct {v0, p0}, Lcom/rokid/aicore/core/AICore$2;-><init>(Lcom/rokid/aicore/core/AICore;)V

    iput-object v0, p0, Lcom/rokid/aicore/core/AICore;->mDetectCallback:Lcom/rokid/aicore/ncnn/DetectCallback;

    new-instance v0, Lcom/rokid/aicore/core/AICore$3;

    invoke-direct {v0, p0}, Lcom/rokid/aicore/core/AICore$3;-><init>(Lcom/rokid/aicore/core/AICore;)V

    iput-object v0, p0, Lcom/rokid/aicore/core/AICore;->mWhitelistUnrecognizeCallback:Lcom/rokid/aicore/ncnn/UnrecognizeCallback;

    new-instance v0, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v7, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v8, Ljava/util/concurrent/LinkedBlockingQueue;

    const/16 v2, 0xa

    invoke-direct {v8, v2}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    new-instance v9, Ljava/util/concurrent/ThreadPoolExecutor$DiscardPolicy;

    invoke-direct {v9}, Ljava/util/concurrent/ThreadPoolExecutor$DiscardPolicy;-><init>()V

    const/4 v4, 0x1

    const-wide/16 v5, 0x0

    const/4 v3, 0x1

    move-object v2, v0

    invoke-direct/range {v2 .. v9}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/RejectedExecutionHandler;)V

    sput-object v0, Lcom/rokid/aicore/core/AICore;->mSendDataThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    iput-boolean v1, p0, Lcom/rokid/aicore/core/AICore;->mIsDestroyed:Z

    return-void
.end method

.method public static synthetic access$000(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/api/callback/AICallback;
    .locals 0

    iget-object p0, p0, Lcom/rokid/aicore/core/AICore;->aiCallback:Lcom/rokid/aicore/api/callback/AICallback;

    return-object p0
.end method

.method public static synthetic access$100(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/ncnn/MotWrapper;
    .locals 0

    iget-object p0, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    return-object p0
.end method

.method public static synthetic access$200(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/ncnn/bean/MotConfig;
    .locals 0

    iget-object p0, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    return-object p0
.end method

.method public static synthetic access$300(Lcom/rokid/aicore/core/AICore;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 0

    iget-object p0, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object p0
.end method


# virtual methods
.method public addActiveFace(II)I
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/ncnn/MotWrapper;->addActiveFace(II)I

    move-result p1

    return p1

    :cond_0
    const/4 p1, -0x1

    return p1
.end method

.method public addActiveFeature(II[F)I
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/aicore/ncnn/MotWrapper;->addActiveFeature(II[F)I

    move-result p1

    return p1

    :cond_0
    const/4 p1, -0x1

    return p1
.end method

.method public authorize(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public clearActiveFace(II)I
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/ncnn/MotWrapper;->clearActiveFace(II)I

    move-result p1

    return p1

    :cond_0
    const/4 p1, -0x1

    return p1
.end method

.method public cropSmallFaceBitmap(Landroid/graphics/Rect;J)Landroid/graphics/Bitmap;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    if-eqz v0, :cond_0

    long-to-int p2, p2

    invoke-virtual {v0, p2, p1}, Lcom/rokid/aicore/ncnn/MotWrapper;->cropBitmap(ILandroid/graphics/Rect;)Landroid/graphics/Bitmap;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public destroy()V
    .locals 6

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/aicore/core/AICore;->mIsDestroyed:Z

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v1, "start destroy aicore"

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    sget-object v0, Lcom/rokid/aicore/core/AICore;->mSendDataThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->shutdownNow()Ljava/util/List;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    :goto_0
    iget-object v2, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sub-long/2addr v2, v0

    const-wide/16 v4, 0x7d0

    cmp-long v2, v2, v4

    if-lez v2, :cond_0

    goto :goto_1

    :cond_0
    const-wide/16 v2, 0xa

    :try_start_0
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    :cond_1
    :goto_1
    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/MotWrapper;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    :cond_2
    return-void
.end method

.method public disable()V
    .locals 2

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    return-void
.end method

.method public enable()V
    .locals 2

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    return-void
.end method

.method public getDetectScore()F
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getDetectScore()F

    move-result v0

    return v0
.end method

.method public init(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I
    .locals 22

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    if-nez v1, :cond_0

    const/4 v1, -0x1

    return v1

    :cond_0
    iput-object v1, v0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    new-instance v3, Lcom/rokid/aicore/ncnn/MotWrapper;

    move-object v2, v3

    invoke-direct {v3}, Lcom/rokid/aicore/ncnn/MotWrapper;-><init>()V

    iput-object v3, v0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAssetsMgr()Landroid/content/res/AssetManager;

    move-result-object v3

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v4

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getDetectModelName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isUseGpu()Z

    move-result v6

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getDetectInterval()I

    move-result v7

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getMaxNumDetections()I

    move-result v8

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isNonTrack()Z

    move-result v9

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getTrackerType()Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    move-result-object v10

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getTrackModelName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getRecModelName()Ljava/lang/String;

    move-result-object v12

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getRecThreshold()F

    move-result v13

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getIqaModelName()Ljava/lang/String;

    move-result-object v14

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getIqaThreshold()F

    move-result v15

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isHasPts()Z

    move-result v16

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getPlateCharThreshold()F

    move-result v17

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getPlateColorThreshold()F

    move-result v18

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isSkipTrack()Z

    move-result v19

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isUseNpu()Z

    move-result v20

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getPlateChineseThreshold()F

    move-result v21

    invoke-virtual/range {v2 .. v21}, Lcom/rokid/aicore/ncnn/MotWrapper;->init(Landroid/content/res/AssetManager;Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;Ljava/lang/String;ZIIZLcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;Ljava/lang/String;Ljava/lang/String;FLjava/lang/String;FZFFZZF)I

    move-result v2

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getNativeImagePoolSize()I

    move-result v3

    const/4 v4, 0x1

    if-lez v3, :cond_1

    goto :goto_0

    :cond_1
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v3

    invoke-virtual {v3}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v3

    sget-object v5, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmFaceDet:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    invoke-virtual {v5}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v5

    if-ne v3, v5, :cond_2

    const/16 v3, 0xf

    goto :goto_0

    :cond_2
    move v3, v4

    :goto_0
    iget-object v5, v0, Lcom/rokid/aicore/core/AICore;->isInited:Ljava/util/concurrent/atomic/AtomicBoolean;

    if-nez v2, :cond_3

    goto :goto_1

    :cond_3
    const/4 v4, 0x0

    :goto_1
    invoke-virtual {v5, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v4

    invoke-virtual {v4}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v4

    sget-object v5, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmFaceDet:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    invoke-virtual {v5}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v5

    if-ne v4, v5, :cond_4

    iget-object v4, v0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    iget-object v5, v0, Lcom/rokid/aicore/core/AICore;->mDetectCallback:Lcom/rokid/aicore/ncnn/DetectCallback;

    invoke-virtual {v4, v5}, Lcom/rokid/aicore/ncnn/MotWrapper;->setDetectCallback(Lcom/rokid/aicore/ncnn/DetectCallback;)V

    iget-object v4, v0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    iget-object v5, v0, Lcom/rokid/aicore/core/AICore;->mRecognizeCallback:Lcom/rokid/aicore/ncnn/RecognizeCallback;

    invoke-virtual {v4, v5}, Lcom/rokid/aicore/ncnn/MotWrapper;->setRecognizeCallback(Lcom/rokid/aicore/ncnn/RecognizeCallback;)V

    iget-object v4, v0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    iget-object v5, v0, Lcom/rokid/aicore/core/AICore;->mWhitelistUnrecognizeCallback:Lcom/rokid/aicore/ncnn/UnrecognizeCallback;

    invoke-virtual {v4, v5}, Lcom/rokid/aicore/ncnn/MotWrapper;->setWhitelistUnRecognizeCallback(Lcom/rokid/aicore/ncnn/UnrecognizeCallback;)V

    :cond_4
    iget-object v4, v0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual {v4, v3}, Lcom/rokid/aicore/ncnn/MotWrapper;->setImagePoolSize(I)V

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isUseActiveFaceFeature()Z

    move-result v3

    if-eqz v3, :cond_5

    iget-object v4, v0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getActiveFaceCount()I

    move-result v5

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getActiveFeatureCount()I

    move-result v6

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getFrameDetectLastestThreshold()I

    move-result v7

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getFaceFeatureSimilarityThreshold()F

    move-result v8

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getFaceFeatureIqaThreshold()F

    move-result v9

    invoke-virtual/range {v4 .. v9}, Lcom/rokid/aicore/ncnn/MotWrapper;->initActiveFaceCompare(IIIFF)I

    :cond_5
    sget-object v1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "###########init aicore result: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " && MotWrapper instanceId: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual {v4}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ";  Type = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v4}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v4

    invoke-virtual {v4}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->name()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    return v2
.end method

.method public initActiveFaceCompare(IIIFF)I
    .locals 6

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    if-eqz v0, :cond_0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-virtual/range {v0 .. v5}, Lcom/rokid/aicore/ncnn/MotWrapper;->initActiveFaceCompare(IIIFF)I

    move-result p1

    return p1

    :cond_0
    const/4 p1, -0x1

    return p1
.end method

.method public isEnable()Z
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    return v0
.end method

.method public matchActiveFace(IILcom/rokid/aicore/ncnn/MotWrapper$MatchResult;)Z
    .locals 8

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/aicore/ncnn/MotWrapper;->matchActiveFace(IILcom/rokid/aicore/ncnn/MotWrapper$MatchResult;)F

    move-result p2

    new-instance v0, Ljava/math/BigDecimal;

    invoke-static {p2}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/math/BigDecimal;-><init>(Ljava/lang/String;)V

    new-instance v2, Ljava/math/BigDecimal;

    iget-object v3, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v3}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getFaceFeatureSimilarityThreshold()F

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/math/BigDecimal;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Ljava/math/BigDecimal;->compareTo(Ljava/math/BigDecimal;)I

    move-result v0

    const/4 v3, 0x1

    if-ltz v0, :cond_0

    move v0, v3

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    iget v4, p3, Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;->mostMatchFrameId:I

    sub-int/2addr v4, p1

    invoke-static {v4}, Ljava/lang/Math;->abs(I)I

    move-result v4

    iget-object v5, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v5}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getFrameDetectLastestThreshold()I

    move-result v5

    if-gt v4, v5, :cond_1

    move v4, v3

    goto :goto_1

    :cond_1
    move v4, v1

    :goto_1
    sget-object v5, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "matchActiveFace frameIdValid = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " similarityValid = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " similarity = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v6, " threshold = "

    invoke-virtual {p2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v2, " mostMatchFrameId = "

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    iget p3, p3, Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;->mostMatchFrameId:I

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, " frameId = "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v5, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    if-eqz v0, :cond_2

    if-eqz v4, :cond_2

    move v1, v3

    :cond_2
    return v1
.end method

.method public process(Lcom/rokid/aicore/api/bean/ImageInput;)[Lcom/rokid/aicore/ncnn/bean/MotDetection;
    .locals 10

    iget-boolean v0, p0, Lcom/rokid/aicore/core/AICore;->mIsDestroyed:Z

    if-nez v0, :cond_4

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isInited:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_4

    if-nez p1, :cond_0

    goto/16 :goto_1

    :cond_0
    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "start process for MotWrapper instanceId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual {v2}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ";  Type = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v2

    invoke-virtual {v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->name()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; frameId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p1, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->d(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-object v3, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    iget-object v4, p1, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    iget v5, p1, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget v6, p1, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    iget-object v7, p1, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    iget-wide v8, p1, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    long-to-int v8, v8

    invoke-virtual/range {v3 .. v8}, Lcom/rokid/aicore/ncnn/MotWrapper;->process([BIILcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;I)[Lcom/rokid/aicore/ncnn/bean/MotDetection;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_2

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->aiCallback:Lcom/rokid/aicore/api/callback/AICallback;

    if-eqz v1, :cond_1

    invoke-interface {v1, v3, p1}, Lcom/rokid/aicore/api/callback/AICallback;->AIEvent([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)V

    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "start process for MotWrapper instanceId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual {v2}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v5

    invoke-virtual {v1, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ";  Type = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v2

    invoke-virtual {v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->name()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " but result is null!!!;  frameId = "

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v5, p1, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v1, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {p1, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    return-object v3

    :cond_2
    const-string v5, "LOCK_LIST"

    monitor-enter v5

    :try_start_0
    iget-object v6, p0, Lcom/rokid/aicore/core/AICore;->aiCallback:Lcom/rokid/aicore/api/callback/AICallback;

    if-eqz v6, :cond_3

    invoke-interface {v6, v3, p1}, Lcom/rokid/aicore/api/callback/AICallback;->AIEvent([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)V

    :cond_3
    monitor-exit v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "start process for MotWrapper instanceId: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual {v8}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v8

    invoke-virtual {v7, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " kAlgorithmName"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v8}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v8

    invoke-virtual {v8}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->name()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " && processing cost time: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    sub-long/2addr v5, v1

    invoke-virtual {v7, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; frameId = "

    goto :goto_0

    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit v5
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1

    :cond_4
    :goto_1
    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "start process for MotWrapper instanceId: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " but mIsDestroyed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/rokid/aicore/core/AICore;->mIsDestroyed:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "; isInited: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->isInited:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "; isEnable: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, 0x0

    return-object p1
.end method

.method public processAsync(Lcom/rokid/aicore/api/bean/ImageInput;)V
    .locals 4

    iget-boolean v0, p0, Lcom/rokid/aicore/core/AICore;->mIsDestroyed:Z

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isInited:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_3

    if-nez p1, :cond_0

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v0

    sget-object v1, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmPlateRec:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v1

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v0

    sget-object v1, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmMotorRec:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v1

    if-ne v0, v1, :cond_2

    :cond_1
    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "start processAsync for MotWrapper instanceId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual {v2}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " kAlgorithmPlateRec && isProcessing,so Skip frameId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p1, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    :try_start_0
    sget-object v2, Lcom/rokid/aicore/core/AICore;->mSendDataThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    new-instance v3, Lcom/rokid/aicore/core/AICore$4;

    invoke-direct {v3, p0, p1, v0, v1}, Lcom/rokid/aicore/core/AICore$4;-><init>(Lcom/rokid/aicore/core/AICore;Lcom/rokid/aicore/api/bean/ImageInput;J)V

    invoke-virtual {v2, v3}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object p1, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    :goto_0
    return-void

    :cond_3
    :goto_1
    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "start processAsync for MotWrapper instanceId = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ";  Type = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v1

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->name()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " but mIsDestroyed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/rokid/aicore/core/AICore;->mIsDestroyed:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "; isInited: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->isInited:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "; isEnable: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    return-void
.end method

.method public processAsyncV2(Lcom/rokid/aicore/api/bean/ImageInput;)V
    .locals 4

    iget-boolean v0, p0, Lcom/rokid/aicore/core/AICore;->mIsDestroyed:Z

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isInited:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_3

    if-nez p1, :cond_0

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v0

    sget-object v1, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmPlateRec:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v1

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v0

    sget-object v1, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmMotorRec:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v1

    if-ne v0, v1, :cond_2

    :cond_1
    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "start processAsyncV2 for MotWrapper instanceId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual {v2}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " kAlgorithmPlateRec && isProcessing,so Skip frameId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p1, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    :try_start_0
    sget-object v0, Lcom/rokid/aicore/core/AICore;->mSendDataThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    new-instance v1, Lcom/rokid/aicore/core/AICore$5;

    invoke-direct {v1, p0, p1}, Lcom/rokid/aicore/core/AICore$5;-><init>(Lcom/rokid/aicore/core/AICore;Lcom/rokid/aicore/api/bean/ImageInput;)V

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object p1, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    :goto_0
    return-void

    :cond_3
    :goto_1
    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "start processAsyncV2 for MotWrapper instanceId = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ";  Type = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v1

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->name()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " but mIsDestroyed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/rokid/aicore/core/AICore;->mIsDestroyed:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "; isInited: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->isInited:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "; isEnable: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore;->isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    return-void
.end method

.method public processBuffer(Lcom/rokid/aicore/api/bean/BufferImageInput;)[Lcom/rokid/aicore/ncnn/bean/MotDetection;
    .locals 12

    iget-boolean v0, p0, Lcom/rokid/aicore/core/AICore;->mIsDestroyed:Z

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isEnable:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isInited:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_2

    if-eqz p1, :cond_2

    invoke-virtual {p1}, Lcom/rokid/aicore/api/bean/BufferImageInput;->isValid()Z

    move-result v0

    if-nez v0, :cond_0

    goto/16 :goto_0

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const/4 v2, 0x0

    :try_start_0
    iget-object v3, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    iget-object v4, p1, Lcom/rokid/aicore/api/bean/BufferImageInput;->data:Ljava/nio/ByteBuffer;

    iget v5, p1, Lcom/rokid/aicore/api/bean/BufferImageInput;->offset:I

    iget v6, p1, Lcom/rokid/aicore/api/bean/BufferImageInput;->size:I

    iget v7, p1, Lcom/rokid/aicore/api/bean/BufferImageInput;->width:I

    iget v8, p1, Lcom/rokid/aicore/api/bean/BufferImageInput;->height:I

    iget-object v9, p1, Lcom/rokid/aicore/api/bean/BufferImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    iget-wide v10, p1, Lcom/rokid/aicore/api/bean/BufferImageInput;->frame_id:J

    long-to-int v10, v10

    invoke-virtual/range {v3 .. v10}, Lcom/rokid/aicore/ncnn/MotWrapper;->process(Ljava/nio/ByteBuffer;IIIILcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;I)[Lcom/rokid/aicore/ncnn/bean/MotDetection;

    move-result-object v3

    const-string v4, "LOCK_LIST"

    monitor-enter v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :try_start_1
    iget-object v5, p0, Lcom/rokid/aicore/core/AICore;->aiCallback:Lcom/rokid/aicore/api/callback/AICallback;

    instance-of v6, v5, Lcom/rokid/aicore/api/callback/BufferAICallback;

    if-eqz v6, :cond_1

    check-cast v5, Lcom/rokid/aicore/api/callback/BufferAICallback;

    invoke-interface {v5, v3, p1}, Lcom/rokid/aicore/api/callback/BufferAICallback;->AIEventBuffer([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/BufferImageInput;)V

    :cond_1
    monitor-exit v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    sget-object v4, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "processBuffer for MotWrapper instanceId: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-virtual {v6}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v6

    invoke-virtual {v5, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " kAlgorithmName"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/rokid/aicore/core/AICore;->motConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v6}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v6

    invoke-virtual {v6}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->name()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " && processing cost time: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    sub-long/2addr v6, v0

    invoke-virtual {v5, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "; frameId = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v5, p1, Lcom/rokid/aicore/api/bean/BufferImageInput;->frame_id:J

    invoke-virtual {v0, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v4, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    iget-object p1, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {p1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    return-object v3

    :catchall_0
    move-exception p1

    :try_start_3
    monitor-exit v4
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw p1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    :catchall_1
    move-exception p1

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    throw p1

    :cond_2
    :goto_0
    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "processBuffer rejected invalid state or input"

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    const/4 p1, 0x0

    return-object p1
.end method

.method public removeCallback()V
    .locals 2

    const-string v0, "LOCK_LIST"

    monitor-enter v0

    const/4 v1, 0x0

    :try_start_0
    iput-object v1, p0, Lcom/rokid/aicore/core/AICore;->aiCallback:Lcom/rokid/aicore/api/callback/AICallback;

    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public removeFeatureLibrary(Ljava/lang/String;)I
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/ncnn/MotWrapper;->delFeatureLibrary(Ljava/lang/String;)I

    move-result p1

    return p1

    :cond_0
    const/4 p1, -0x1

    return p1
.end method

.method public setAICallback(Lcom/rokid/aicore/api/callback/AICallback;)V
    .locals 1

    iget-boolean v0, p0, Lcom/rokid/aicore/core/AICore;->mIsDestroyed:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const-string v0, "LOCK_LIST"

    monitor-enter v0

    :try_start_0
    iput-object p1, p0, Lcom/rokid/aicore/core/AICore;->aiCallback:Lcom/rokid/aicore/api/callback/AICallback;

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "setAICallback"

    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->d(Ljava/lang/String;)V

    return-void

    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public setFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore;->motWrapper:Lcom/rokid/aicore/ncnn/MotWrapper;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/ncnn/MotWrapper;->addFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    return p1

    :cond_0
    const/4 p1, -0x1

    return p1
.end method
