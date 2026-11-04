.class public Lcom/rokid/aicore/ncnn/bean/MotConfig;
.super Ljava/lang/Object;
.source "MotConfig.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;,
        Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;,
        Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;,
        Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;
    }
.end annotation


# static fields
.field private static final FACE_DETECT_SCORE:F = 0.6f

.field private static final LPR_DETECT_SCORE:F = 0.6f


# instance fields
.field private activeFaceCount:I

.field private activeFeatureCount:I

.field private final algorithmName:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

.field private final assetsMgr:Landroid/content/res/AssetManager;

.field private final detectInterval:I

.field private final detectModelName:Ljava/lang/String;

.field private final detectScore:F

.field private faceFeatureBin:Ljava/lang/String;

.field private faceFeatureIqaThreshold:F

.field private faceFeatureSimilarityThreshold:F

.field private frameDetectLastestThreshold:I

.field private hasPts:Z

.field private iqaModelName:Ljava/lang/String;

.field private iqaThreshold:F

.field private isTestSaveData:Z

.field private final maxNumDetections:I

.field private nativeImagePoolSize:I

.field private final nonTrack:Z

.field private plateCharThreshold:F

.field private plateChineseThreshold:F

.field private plateColorThreshold:F

.field private final recModelName:Ljava/lang/String;

.field private final recThreshold:F

.field private skipTrack:Z

.field private final trackModelName:Ljava/lang/String;

.field private final trackerType:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

.field private useActiveFaceFeature:Z

.field private final useGpu:Z

.field private useNpu:Z


# direct methods
.method private constructor <init>(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)V
    .locals 1
    .param p1, "builder"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    const v0, -0x42333333    # -0.1f

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->plateChineseThreshold:F

    .line 38
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->useActiveFaceFeature:Z

    .line 39
    const/16 v0, 0x20

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->activeFaceCount:I

    .line 40
    const/16 v0, 0x14

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->activeFeatureCount:I

    .line 41
    const/high16 v0, 0x429c0000    # 78.0f

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->faceFeatureSimilarityThreshold:F

    .line 42
    const/16 v0, 0x96

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->frameDetectLastestThreshold:I

    .line 43
    const/4 v0, -0x1

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->nativeImagePoolSize:I

    .line 45
    const/high16 v0, 0x42340000    # 45.0f

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->faceFeatureIqaThreshold:F

    .line 48
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$000(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->algorithmName:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    .line 49
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$100(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->detectModelName:Ljava/lang/String;

    .line 50
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$200(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Landroid/content/res/AssetManager;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->assetsMgr:Landroid/content/res/AssetManager;

    .line 51
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$300(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->useGpu:Z

    .line 52
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$400(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->detectInterval:I

    .line 53
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$500(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->maxNumDetections:I

    .line 54
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$600(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->nonTrack:Z

    .line 55
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$700(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->trackerType:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    .line 56
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$800(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->trackModelName:Ljava/lang/String;

    .line 57
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$900(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->recModelName:Ljava/lang/String;

    .line 58
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$1000(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->recThreshold:F

    .line 59
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$1100(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->detectScore:F

    .line 60
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$1200(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->iqaModelName:Ljava/lang/String;

    .line 61
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$1300(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->iqaThreshold:F

    .line 62
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$1400(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->faceFeatureBin:Ljava/lang/String;

    .line 63
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$1500(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->hasPts:Z

    .line 64
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$1600(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isTestSaveData:Z

    .line 65
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$1700(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->plateCharThreshold:F

    .line 66
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$1800(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->plateColorThreshold:F

    .line 67
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$1900(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->skipTrack:Z

    .line 68
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$2000(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->useNpu:Z

    .line 69
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$2100(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->plateChineseThreshold:F

    .line 70
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$2200(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->useActiveFaceFeature:Z

    .line 71
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$2300(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->activeFaceCount:I

    .line 72
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$2400(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->activeFeatureCount:I

    .line 73
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$2500(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->faceFeatureSimilarityThreshold:F

    .line 74
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$2600(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->frameDetectLastestThreshold:I

    .line 75
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$2700(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)I

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->nativeImagePoolSize:I

    .line 76
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->access$2800(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)F

    move-result v0

    iput v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->faceFeatureIqaThreshold:F

    .line 77
    return-void
.end method

.method synthetic constructor <init>(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;Lcom/rokid/aicore/ncnn/bean/MotConfig$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;
    .param p2, "x1"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$1;

    .line 7
    invoke-direct {p0, p1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;-><init>(Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;)V

    return-void
.end method


# virtual methods
.method public getActiveFaceCount()I
    .locals 1

    .line 138
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->activeFaceCount:I

    return v0
.end method

.method public getActiveFeatureCount()I
    .locals 1

    .line 142
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->activeFeatureCount:I

    return v0
.end method

.method public getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;
    .locals 1

    .line 81
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->algorithmName:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    return-object v0
.end method

.method public getAssetsMgr()Landroid/content/res/AssetManager;
    .locals 1

    .line 83
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->assetsMgr:Landroid/content/res/AssetManager;

    return-object v0
.end method

.method public getDetectInterval()I
    .locals 1

    .line 85
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->detectInterval:I

    return v0
.end method

.method public getDetectModelName()Ljava/lang/String;
    .locals 1

    .line 82
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->detectModelName:Ljava/lang/String;

    return-object v0
.end method

.method public getDetectScore()F
    .locals 1

    .line 94
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->detectScore:F

    return v0
.end method

.method public getFaceFeatureBin()Ljava/lang/String;
    .locals 1

    .line 114
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->faceFeatureBin:Ljava/lang/String;

    return-object v0
.end method

.method public getFaceFeatureIqaThreshold()F
    .locals 1

    .line 162
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->faceFeatureIqaThreshold:F

    return v0
.end method

.method public getFaceFeatureSimilarityThreshold()F
    .locals 1

    .line 150
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->faceFeatureSimilarityThreshold:F

    return v0
.end method

.method public getFrameDetectLastestThreshold()I
    .locals 1

    .line 154
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->frameDetectLastestThreshold:I

    return v0
.end method

.method public getIqaModelName()Ljava/lang/String;
    .locals 1

    .line 98
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->iqaModelName:Ljava/lang/String;

    return-object v0
.end method

.method public getIqaThreshold()F
    .locals 1

    .line 110
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->iqaThreshold:F

    return v0
.end method

.method public getMaxNumDetections()I
    .locals 1

    .line 86
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->maxNumDetections:I

    return v0
.end method

.method public getNativeImagePoolSize()I
    .locals 1

    .line 158
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->nativeImagePoolSize:I

    return v0
.end method

.method public getPlateCharThreshold()F
    .locals 1

    .line 122
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->plateCharThreshold:F

    return v0
.end method

.method public getPlateChineseThreshold()F
    .locals 1

    .line 134
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->plateChineseThreshold:F

    return v0
.end method

.method public getPlateColorThreshold()F
    .locals 1

    .line 126
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->plateColorThreshold:F

    return v0
.end method

.method public getRecModelName()Ljava/lang/String;
    .locals 1

    .line 90
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->recModelName:Ljava/lang/String;

    return-object v0
.end method

.method public getRecThreshold()F
    .locals 1

    .line 91
    iget v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->recThreshold:F

    return v0
.end method

.method public getTrackModelName()Ljava/lang/String;
    .locals 1

    .line 89
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->trackModelName:Ljava/lang/String;

    return-object v0
.end method

.method public getTrackerType()Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;
    .locals 1

    .line 88
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->trackerType:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    return-object v0
.end method

.method public isHasPts()Z
    .locals 1

    .line 102
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->hasPts:Z

    return v0
.end method

.method public isNonTrack()Z
    .locals 1

    .line 87
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->nonTrack:Z

    return v0
.end method

.method public isSaveTestData()Z
    .locals 1

    .line 106
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isTestSaveData:Z

    return v0
.end method

.method public isSkipTrack()Z
    .locals 1

    .line 118
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->skipTrack:Z

    return v0
.end method

.method public isUseActiveFaceFeature()Z
    .locals 1

    .line 146
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->useActiveFaceFeature:Z

    return v0
.end method

.method public isUseGpu()Z
    .locals 1

    .line 84
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->useGpu:Z

    return v0
.end method

.method public isUseNpu()Z
    .locals 1

    .line 130
    iget-boolean v0, p0, Lcom/rokid/aicore/ncnn/bean/MotConfig;->useNpu:Z

    return v0
.end method
