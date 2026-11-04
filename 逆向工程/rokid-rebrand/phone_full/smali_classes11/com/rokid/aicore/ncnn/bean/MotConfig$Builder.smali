.class public Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
.super Ljava/lang/Object;
.source "MotConfig.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/ncnn/bean/MotConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private activeFaceCount:I

.field private activeFeatureCount:I

.field private algorithmName:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

.field private assetsMgr:Landroid/content/res/AssetManager;

.field private detectInterval:I

.field private final detectModelName:Ljava/lang/String;

.field private detectScore:F

.field private faceFeatureBin:Ljava/lang/String;

.field private faceFeatureIqaThreshold:F

.field private faceFeatureSimilarityThreshold:F

.field private frameDetectLastestThreshold:I

.field private hasPts:Z

.field private iqaModelName:Ljava/lang/String;

.field private iqaThreshold:F

.field private isTestSaveData:Z

.field private maxNumDetections:I

.field private nativeImagePoolSize:I

.field private nonTrack:Z

.field private plateCharThreshold:F

.field private plateChineseThreshold:F

.field private plateColorThreshold:F

.field private recModelName:Ljava/lang/String;

.field private recThreshold:F

.field private skipTrack:Z

.field private trackModelName:Ljava/lang/String;

.field private trackerType:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

.field private useActiveFaceFeature:Z

.field private useGpu:Z

.field private useNpu:Z

.field private whiteListRecThreshold:F


# direct methods
.method public constructor <init>(Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;Ljava/lang/String;)V
    .locals 3
    .param p1, "algorithmName"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;
    .param p2, "detectModelName"    # Ljava/lang/String;

    .line 207
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 168
    sget-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmFaceDet:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->algorithmName:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    .line 172
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->assetsMgr:Landroid/content/res/AssetManager;

    .line 173
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->useGpu:Z

    .line 174
    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->detectInterval:I

    .line 175
    const/4 v1, 0x5

    iput v1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->maxNumDetections:I

    .line 176
    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->nonTrack:Z

    .line 177
    sget-object v1, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->kTrackerTypeByteTracker:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    iput-object v1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->trackerType:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    .line 178
    const-string v1, ""

    iput-object v1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->trackModelName:Ljava/lang/String;

    .line 179
    iput-object v1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->recModelName:Ljava/lang/String;

    .line 180
    const/high16 v2, 0x42a20000    # 81.0f

    iput v2, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->recThreshold:F

    .line 181
    const/high16 v2, 0x42920000    # 73.0f

    iput v2, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->whiteListRecThreshold:F

    .line 183
    iput-object v1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->iqaModelName:Ljava/lang/String;

    .line 184
    const/high16 v2, 0x420c0000    # 35.0f

    iput v2, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->iqaThreshold:F

    .line 185
    iput-object v1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->faceFeatureBin:Ljava/lang/String;

    .line 186
    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->hasPts:Z

    .line 187
    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->isTestSaveData:Z

    .line 189
    const v1, 0x3f4ccccd    # 0.8f

    iput v1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->plateCharThreshold:F

    .line 190
    const v1, 0x3f19999a    # 0.6f

    iput v1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->plateColorThreshold:F

    .line 191
    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->skipTrack:Z

    .line 192
    sget-object v2, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmFaceDet:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    iput v1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->detectScore:F

    .line 196
    const v2, -0x42333333    # -0.1f

    iput v2, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->plateChineseThreshold:F

    .line 198
    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->useActiveFaceFeature:Z

    .line 199
    const/16 v0, 0x20

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->activeFaceCount:I

    .line 200
    const/16 v0, 0x14

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->activeFeatureCount:I

    .line 201
    const/high16 v0, 0x429c0000    # 78.0f

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->faceFeatureSimilarityThreshold:F

    .line 202
    const/16 v0, 0x96

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->frameDetectLastestThreshold:I

    .line 204
    const/4 v0, -0x1

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->nativeImagePoolSize:I

    .line 205
    const/high16 v0, 0x42340000    # 45.0f

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->faceFeatureIqaThreshold:F

    .line 208
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->algorithmName:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    .line 209
    iput-object p2, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->detectModelName:Ljava/lang/String;

    .line 210
    sget-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmFaceDet:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    if-ne p1, v0, :cond_0

    .line 211
    iput v1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->detectScore:F

    goto :goto_0

    .line 213
    :cond_0
    iput v1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->detectScore:F

    .line 215
    :goto_0
    return-void
.end method

.method static synthetic access$000(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->algorithmName:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    return-object v0
.end method

.method static synthetic access$100(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->detectModelName:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1000(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->recThreshold:F

    return v0
.end method

.method static synthetic access$1100(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->detectScore:F

    return v0
.end method

.method static synthetic access$1200(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->iqaModelName:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1300(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->iqaThreshold:F

    return v0
.end method

.method static synthetic access$1400(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->faceFeatureBin:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1500(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->hasPts:Z

    return v0
.end method

.method static synthetic access$1600(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->isTestSaveData:Z

    return v0
.end method

.method static synthetic access$1700(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->plateCharThreshold:F

    return v0
.end method

.method static synthetic access$1800(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->plateColorThreshold:F

    return v0
.end method

.method static synthetic access$1900(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->skipTrack:Z

    return v0
.end method

.method static synthetic access$200(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Landroid/content/res/AssetManager;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->assetsMgr:Landroid/content/res/AssetManager;

    return-object v0
.end method

.method static synthetic access$2000(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->useNpu:Z

    return v0
.end method

.method static synthetic access$2100(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->plateChineseThreshold:F

    return v0
.end method

.method static synthetic access$2200(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->useActiveFaceFeature:Z

    return v0
.end method

.method static synthetic access$2300(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->activeFaceCount:I

    return v0
.end method

.method static synthetic access$2400(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->activeFeatureCount:I

    return v0
.end method

.method static synthetic access$2500(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->faceFeatureSimilarityThreshold:F

    return v0
.end method

.method static synthetic access$2600(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->frameDetectLastestThreshold:I

    return v0
.end method

.method static synthetic access$2700(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->nativeImagePoolSize:I

    return v0
.end method

.method static synthetic access$2800(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->faceFeatureIqaThreshold:F

    return v0
.end method

.method static synthetic access$300(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->useGpu:Z

    return v0
.end method

.method static synthetic access$400(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->detectInterval:I

    return v0
.end method

.method static synthetic access$500(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->maxNumDetections:I

    return v0
.end method

.method static synthetic access$600(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->nonTrack:Z

    return v0
.end method

.method static synthetic access$700(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->trackerType:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    return-object v0
.end method

.method static synthetic access$800(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->trackModelName:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$900(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 165
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->recModelName:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public build()Lcom/rokid/aicore/ncnn/bean/MotConfig;
    .locals 2

    .line 274
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;-><init>(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;Lcom/rokid/aicore/ncnn/bean/MotConfig$1;)V

    return-object v0
.end method

.method public setActiveFaceCount(I)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "activeFaceCount"    # I

    .line 332
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->activeFaceCount:I

    .line 333
    return-object p0
.end method

.method public setActiveFeatureCount(I)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "activeFeatureCount"    # I

    .line 337
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->activeFeatureCount:I

    .line 338
    return-object p0
.end method

.method public setAssetsMgr(Landroid/content/res/AssetManager;)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "assetsMgr"    # Landroid/content/res/AssetManager;

    .line 218
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->assetsMgr:Landroid/content/res/AssetManager;

    .line 219
    return-object p0
.end method

.method public setDetectInterval(I)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "detectInterval"    # I

    .line 228
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->detectInterval:I

    .line 229
    return-object p0
.end method

.method public setDetectScore(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "score"    # F

    .line 269
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->detectScore:F

    .line 270
    return-object p0
.end method

.method public setFaceFeatureBin(Ljava/lang/String;)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "faceFeatureBin"    # Ljava/lang/String;

    .line 313
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->faceFeatureBin:Ljava/lang/String;

    .line 314
    return-object p0
.end method

.method public setFaceFeatureIqaThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "faceFeatureIqaThreshold"    # F

    .line 356
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->faceFeatureIqaThreshold:F

    .line 357
    return-object p0
.end method

.method public setFaceFeatureSimilarityThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "faceFeatureSimilarity"    # F

    .line 341
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->faceFeatureSimilarityThreshold:F

    .line 342
    return-object p0
.end method

.method public setFrameDetectLastestThreshold(I)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "frameDetectLastestThreshold"    # I

    .line 346
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->frameDetectLastestThreshold:I

    .line 347
    return-object p0
.end method

.method public setHasPts(Z)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "hasPts"    # Z

    .line 283
    iput-boolean p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->hasPts:Z

    .line 284
    return-object p0
.end method

.method public setIqaModelName(Ljava/lang/String;)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "iqaModelName"    # Ljava/lang/String;

    .line 278
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->iqaModelName:Ljava/lang/String;

    .line 279
    return-object p0
.end method

.method public setIqaThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "iqaThreshold"    # F

    .line 293
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->iqaThreshold:F

    .line 294
    return-object p0
.end method

.method public setMaxNumDetections(I)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "maxNumDetections"    # I

    .line 233
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->maxNumDetections:I

    .line 234
    return-object p0
.end method

.method public setNativeImagePoolSize(I)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "nativeImagePoolSize"    # I

    .line 351
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->nativeImagePoolSize:I

    .line 352
    return-object p0
.end method

.method public setNonTrack(Z)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "nonTrack"    # Z

    .line 238
    iput-boolean p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->nonTrack:Z

    .line 239
    return-object p0
.end method

.method public setPlateCharThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "plateCharThreshold"    # F

    .line 303
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->plateCharThreshold:F

    .line 304
    return-object p0
.end method

.method public setPlateChineseThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "plateChineseThreshold"    # F

    .line 322
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->plateChineseThreshold:F

    .line 323
    return-object p0
.end method

.method public setPlateColorThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "plateColorThreshold"    # F

    .line 308
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->plateColorThreshold:F

    .line 309
    return-object p0
.end method

.method public setRecModelName(Ljava/lang/String;)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "recModelName"    # Ljava/lang/String;

    .line 253
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->recModelName:Ljava/lang/String;

    .line 254
    return-object p0
.end method

.method public setRecThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "recThreshold"    # F

    .line 258
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->recThreshold:F

    .line 259
    return-object p0
.end method

.method public setSaveTestData(Z)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "saveTestData"    # Z

    .line 288
    iput-boolean p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->isTestSaveData:Z

    .line 289
    return-object p0
.end method

.method public setSkipTrack(Z)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "skip"    # Z

    .line 298
    iput-boolean p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->skipTrack:Z

    .line 299
    return-object p0
.end method

.method public setTrackModelName(Ljava/lang/String;)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "trackModelName"    # Ljava/lang/String;

    .line 248
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->trackModelName:Ljava/lang/String;

    .line 249
    return-object p0
.end method

.method public setTrackerType(Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "trackerType"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    .line 243
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->trackerType:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    .line 244
    return-object p0
.end method

.method public setUseActiveFaceFeature(Z)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "useActiveFaceFeature"    # Z

    .line 327
    iput-boolean p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->useActiveFaceFeature:Z

    .line 328
    return-object p0
.end method

.method public setUseGpu(Z)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "useGpu"    # Z

    .line 223
    iput-boolean p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->useGpu:Z

    .line 224
    return-object p0
.end method

.method public setUseNpu(Z)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "useNpu"    # Z

    .line 317
    iput-boolean p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->useNpu:Z

    .line 318
    return-object p0
.end method

.method public setWhiteListRecThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .locals 0
    .param p1, "recThreshold"    # F

    .line 264
    iput p1, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->whiteListRecThreshold:F

    .line 265
    return-object p0
.end method
