.class public Lcom/rokid/aicore/ncnn/MotWrapper;
.super Ljava/lang/Object;
.source "MotWrapper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;
    }
.end annotation


# instance fields
.field private callback:Lcom/rokid/aicore/ncnn/RecognizeCallback;

.field private detectCallback:Lcom/rokid/aicore/ncnn/DetectCallback;

.field holder:Lcom/rokid/aicore/ncnn/CropBitmapHolder;

.field private nativeDetectCallback:Lcom/rokid/aicore/ncnn/DetectCallback;

.field private nativeHandle:J

.field private nativeRecognizeCallback:Lcom/rokid/aicore/ncnn/RecognizeCallback;

.field private nativeUnRecognizeCallback:Lcom/rokid/aicore/ncnn/UnrecognizeCallback;

.field private unRecogCallback:Lcom/rokid/aicore/ncnn/UnrecognizeCallback;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 18
    const-string v0, "mot_jni"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 19
    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    new-instance v0, Lcom/rokid/aicore/ncnn/CropBitmapHolder;

    invoke-direct {v0}, Lcom/rokid/aicore/ncnn/CropBitmapHolder;-><init>()V

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->holder:Lcom/rokid/aicore/ncnn/CropBitmapHolder;

    .line 27
    new-instance v0, Lcom/rokid/aicore/ncnn/MotWrapper$1;

    invoke-direct {v0, p0}, Lcom/rokid/aicore/ncnn/MotWrapper$1;-><init>(Lcom/rokid/aicore/ncnn/MotWrapper;)V

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeDetectCallback:Lcom/rokid/aicore/ncnn/DetectCallback;

    .line 37
    new-instance v0, Lcom/rokid/aicore/ncnn/MotWrapper$2;

    invoke-direct {v0, p0}, Lcom/rokid/aicore/ncnn/MotWrapper$2;-><init>(Lcom/rokid/aicore/ncnn/MotWrapper;)V

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeRecognizeCallback:Lcom/rokid/aicore/ncnn/RecognizeCallback;

    .line 49
    new-instance v0, Lcom/rokid/aicore/ncnn/MotWrapper$3;

    invoke-direct {v0, p0}, Lcom/rokid/aicore/ncnn/MotWrapper$3;-><init>(Lcom/rokid/aicore/ncnn/MotWrapper;)V

    iput-object v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeUnRecognizeCallback:Lcom/rokid/aicore/ncnn/UnrecognizeCallback;

    .line 61
    invoke-direct {p0}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeCreate()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    .line 62
    return-void
.end method

.method static synthetic access$000(Lcom/rokid/aicore/ncnn/MotWrapper;)Lcom/rokid/aicore/ncnn/DetectCallback;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/MotWrapper;

    .line 15
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->detectCallback:Lcom/rokid/aicore/ncnn/DetectCallback;

    return-object v0
.end method

.method static synthetic access$100(Lcom/rokid/aicore/ncnn/MotWrapper;)Lcom/rokid/aicore/ncnn/RecognizeCallback;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/MotWrapper;

    .line 15
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->callback:Lcom/rokid/aicore/ncnn/RecognizeCallback;

    return-object v0
.end method

.method static synthetic access$200(Lcom/rokid/aicore/ncnn/MotWrapper;)Lcom/rokid/aicore/ncnn/UnrecognizeCallback;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/aicore/ncnn/MotWrapper;

    .line 15
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->unRecogCallback:Lcom/rokid/aicore/ncnn/UnrecognizeCallback;

    return-object v0
.end method

.method public static getQnnRuntimeState()I
    .locals 1

    .line 82
    invoke-static {}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeGetQnnRuntimeState()I

    move-result v0

    return v0
.end method

.method private native nativeAddActiveFace(JII)I
.end method

.method private native nativeAddActiveFeature(JII[F)I
.end method

.method private native nativeAddFeatureLibrary(JLjava/lang/String;Ljava/lang/String;)I
.end method

.method private native nativeCleanupCallback(J)V
.end method

.method private native nativeCleanupUnrecognizedCallback(J)V
.end method

.method private native nativeClearActiveFace(JII)I
.end method

.method private native nativeCreate()J
.end method

.method private native nativeDelFeatureLibrary(JLjava/lang/String;)I
.end method

.method private static native nativeGetQnnRuntimeState()I
.end method

.method private native nativeInit(JLandroid/content/res/AssetManager;ILjava/lang/String;ZIIZILjava/lang/String;Ljava/lang/String;FLjava/lang/String;FZFFZZF)I
.end method

.method private native nativeInitActiveFaceCompare(JIIIFF)I
.end method

.method private native nativeMatchActiveFace(JIILcom/rokid/aicore/ncnn/MotWrapper$MatchResult;)F
.end method

.method private static native nativePrepareQnnRuntime()I
.end method

.method private native nativeProcess(J[BIIII)[Lcom/rokid/aicore/ncnn/bean/MotDetection;
.end method

.method private native nativeProcessAsync(JI[BIII)I
.end method

.method private native nativeProcessDirectBuffer(JLjava/nio/ByteBuffer;IIIIII)[Lcom/rokid/aicore/ncnn/bean/MotDetection;
.end method

.method private native nativeRelease(J)V
.end method

.method private static native nativeSetAdspPath(Ljava/lang/String;)I
.end method

.method private native nativeSetImagePoolSize(JI)V
.end method

.method private native nativeSetRecognizeCallback(JLcom/rokid/aicore/ncnn/RecognizeCallback;)V
.end method

.method private native nativeSetUnrecognizedCallback(JLcom/rokid/aicore/ncnn/UnrecognizeCallback;)V
.end method

.method private static native nativeStaticDestroyEngine()V
.end method

.method private static native nativeStaticInitEngine(Landroid/content/res/AssetManager;Ljava/lang/String;Ljava/lang/String;)I
.end method

.method public static prepareQnnRuntime()I
    .locals 1

    .line 78
    invoke-static {}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativePrepareQnnRuntime()I

    move-result v0

    return v0
.end method

.method public static staticDestroyFaceEngine()V
    .locals 0

    .line 74
    invoke-static {}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeStaticDestroyEngine()V

    .line 75
    return-void
.end method

.method public static staticInitFaceEngine(Landroid/content/res/AssetManager;Ljava/lang/String;Ljava/lang/String;)I
    .locals 2
    .param p0, "assets"    # Landroid/content/res/AssetManager;
    .param p1, "assetName"    # Ljava/lang/String;
    .param p2, "outputPath"    # Ljava/lang/String;

    .line 69
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "staticInitFaceEngine------>outputPath: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "MotWrapper"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 70
    invoke-static {p0, p1, p2}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeStaticInitEngine(Landroid/content/res/AssetManager;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method


# virtual methods
.method public addActiveFace(II)I
    .locals 2
    .param p1, "frameId"    # I
    .param p2, "trackId"    # I

    .line 181
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "addActiveFace: frameId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", trackId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "MotWrapper"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 182
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-direct {p0, v0, v1, p1, p2}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeAddActiveFace(JII)I

    move-result v0

    return v0
.end method

.method public addActiveFeature(II[F)I
    .locals 8
    .param p1, "frameId"    # I
    .param p2, "trackId"    # I
    .param p3, "feature"    # [F

    .line 187
    const-string v0, "MotWrapper"

    if-eqz p3, :cond_1

    array-length v1, p3

    if-nez v1, :cond_0

    goto :goto_0

    .line 191
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "addActiveFeature: frameId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", trackId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", featureLen="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v2, p3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 193
    iget-wide v3, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    move-object v2, p0

    move v5, p1

    move v6, p2

    move-object v7, p3

    invoke-direct/range {v2 .. v7}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeAddActiveFeature(JII[F)I

    move-result v0

    return v0

    .line 188
    :cond_1
    :goto_0
    const-string v1, "addActiveFeature: invalid feature array"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 189
    const/4 v0, -0x1

    return v0
.end method

.method public addFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I
    .locals 2
    .param p1, "libraryName"    # Ljava/lang/String;
    .param p2, "libraryFile"    # Ljava/lang/String;

    .line 86
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-direct {p0, v0, v1, p1, p2}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeAddFeatureLibrary(JLjava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public clearActiveFace(II)I
    .locals 2
    .param p1, "frameId"    # I
    .param p2, "trackId"    # I

    .line 198
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "clearActiveFace: frameId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", trackId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "MotWrapper"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 199
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-direct {p0, v0, v1, p1, p2}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeClearActiveFace(JII)I

    move-result v0

    return v0
.end method

.method public cropBitmap(ILandroid/graphics/Rect;)Landroid/graphics/Bitmap;
    .locals 9
    .param p1, "frameId"    # I
    .param p2, "rect"    # Landroid/graphics/Rect;

    .line 203
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->holder:Lcom/rokid/aicore/ncnn/CropBitmapHolder;

    invoke-virtual {p2}, Landroid/graphics/Rect;->width()I

    move-result v1

    invoke-virtual {p2}, Landroid/graphics/Rect;->height()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/rokid/aicore/ncnn/CropBitmapHolder;->obtain(II)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 205
    .local v0, "backing":Landroid/graphics/Bitmap;
    iget-wide v4, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    move-object v3, p0

    move v6, p1

    move-object v7, p2

    move-object v8, v0

    invoke-virtual/range {v3 .. v8}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeCropBitmap(JILandroid/graphics/Rect;Landroid/graphics/Bitmap;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 206
    const/4 v1, 0x0

    return-object v1

    .line 210
    :cond_0
    nop

    .line 214
    invoke-virtual {p2}, Landroid/graphics/Rect;->width()I

    move-result v1

    .line 215
    invoke-virtual {p2}, Landroid/graphics/Rect;->height()I

    move-result v2

    .line 210
    const/4 v3, 0x0

    invoke-static {v0, v3, v3, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIII)Landroid/graphics/Bitmap;

    move-result-object v1

    return-object v1
.end method

.method public delFeatureLibrary(Ljava/lang/String;)I
    .locals 2
    .param p1, "libraryName"    # Ljava/lang/String;

    .line 90
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-direct {p0, v0, v1, p1}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeDelFeatureLibrary(JLjava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getNativeHandle()J
    .locals 2

    .line 226
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    return-wide v0
.end method

.method public init(Landroid/content/res/AssetManager;Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;Ljava/lang/String;ZIIZLcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;Ljava/lang/String;Ljava/lang/String;FLjava/lang/String;FZFFZZF)I
    .locals 23
    .param p1, "assetManager"    # Landroid/content/res/AssetManager;
    .param p2, "algorithmName"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;
    .param p3, "detectModelName"    # Ljava/lang/String;
    .param p4, "useGpu"    # Z
    .param p5, "detectInterval"    # I
    .param p6, "maxNumDetections"    # I
    .param p7, "nonTrack"    # Z
    .param p8, "trackerType"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;
    .param p9, "trackModelName"    # Ljava/lang/String;
    .param p10, "recModelName"    # Ljava/lang/String;
    .param p11, "recThreshold"    # F
    .param p12, "iqaModelName"    # Ljava/lang/String;
    .param p13, "iqaThreshold"    # F
    .param p14, "hasPts"    # Z
    .param p15, "plateCharThreshold"    # F
    .param p16, "plateColorThreshold"    # F
    .param p17, "skipTrack"    # Z
    .param p18, "useNpu"    # Z
    .param p19, "plateChineseThreshold"    # F

    move-object/from16 v10, p0

    move-object/from16 v0, p0

    move-object/from16 v3, p1

    move-object/from16 v5, p3

    move/from16 v6, p4

    move/from16 v7, p5

    move/from16 v8, p6

    move/from16 v9, p7

    move-object/from16 v11, p9

    move-object/from16 v12, p10

    move/from16 v13, p11

    move-object/from16 v14, p12

    move/from16 v15, p13

    move/from16 v16, p14

    move/from16 v17, p15

    move/from16 v18, p16

    move/from16 v19, p17

    move/from16 v20, p18

    move/from16 v21, p19

    .line 118
    iget-wide v1, v10, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-virtual/range {p2 .. p2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v4

    .line 120
    invoke-virtual/range {p8 .. p8}, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->ordinal()I

    move-result v22

    move/from16 v10, v22

    .line 118
    invoke-direct/range {v0 .. v21}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeInit(JLandroid/content/res/AssetManager;ILjava/lang/String;ZIIZILjava/lang/String;Ljava/lang/String;FLjava/lang/String;FZFFZZF)I

    move-result v0

    .line 124
    .local v0, "ret":I
    invoke-virtual/range {p2 .. p2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v1

    sget-object v2, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmFaceDet:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    invoke-virtual {v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->ordinal()I

    move-result v2

    if-ne v1, v2, :cond_0

    .line 125
    move-object/from16 v1, p0

    iget-wide v2, v1, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    iget-object v4, v1, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeDetectCallback:Lcom/rokid/aicore/ncnn/DetectCallback;

    invoke-virtual {v1, v2, v3, v4}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeSetDetectCallback(JLcom/rokid/aicore/ncnn/DetectCallback;)V

    .line 126
    iget-wide v2, v1, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    iget-object v4, v1, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeRecognizeCallback:Lcom/rokid/aicore/ncnn/RecognizeCallback;

    invoke-direct {v1, v2, v3, v4}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeSetRecognizeCallback(JLcom/rokid/aicore/ncnn/RecognizeCallback;)V

    .line 127
    iget-wide v2, v1, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    iget-object v4, v1, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeUnRecognizeCallback:Lcom/rokid/aicore/ncnn/UnrecognizeCallback;

    invoke-direct {v1, v2, v3, v4}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeSetUnrecognizedCallback(JLcom/rokid/aicore/ncnn/UnrecognizeCallback;)V

    goto :goto_0

    .line 124
    :cond_0
    move-object/from16 v1, p0

    .line 129
    :goto_0
    return v0
.end method

.method public initActiveFaceCompare(IIIFF)I
    .locals 10
    .param p1, "faceListLen"    # I
    .param p2, "featureListLen"    # I
    .param p3, "frameDetlaLimit"    # I
    .param p4, "similarityThreshold"    # F
    .param p5, "iqaThreshold"    # F

    .line 154
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "initActiveFaceCompare: faceCacheLen="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", featureListLen="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", frameDetlaLimit="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", similarityThreshold="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", iqaThreshold="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "MotWrapper"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 159
    iget-wide v3, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    move-object v2, p0

    move v5, p1

    move v6, p2

    move v7, p3

    move v8, p4

    move v9, p5

    invoke-direct/range {v2 .. v9}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeInitActiveFaceCompare(JIIIFF)I

    move-result v0

    return v0
.end method

.method public isValid()Z
    .locals 4

    .line 304
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public matchActiveFace(IILcom/rokid/aicore/ncnn/MotWrapper$MatchResult;)F
    .locals 6
    .param p1, "frameId"    # I
    .param p2, "trackId"    # I
    .param p3, "result"    # Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;

    .line 165
    if-nez p3, :cond_0

    .line 166
    new-instance v0, Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;

    invoke-direct {v0}, Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;-><init>()V

    move-object p3, v0

    .line 168
    :cond_0
    iget-wide v1, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    move-object v0, p0

    move v3, p1

    move v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeMatchActiveFace(JIILcom/rokid/aicore/ncnn/MotWrapper$MatchResult;)F

    move-result v0

    .line 169
    .local v0, "similarity":F
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "matchActiveFace: frameId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", trackId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", similarity="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", mostMatchFrameId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p3, Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;->mostMatchFrameId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", mostMatchTrackId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p3, Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;->mostMatchTrackId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", matchFeature="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 173
    iget-object v2, p3, Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;->matchFeature:[F

    if-eqz v2, :cond_1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "length="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p3, Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;->matchFeature:[F

    array-length v3, v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_1
    const-string v2, "null"

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 169
    const-string v2, "MotWrapper"

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 174
    iput v0, p3, Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;->similarity:F

    .line 175
    return v0
.end method

.method public native nativeCleanupDetectCallback(J)V
.end method

.method public native nativeCropBitmap(JILandroid/graphics/Rect;Landroid/graphics/Bitmap;)Z
.end method

.method public native nativeDebugOption(JLjava/lang/String;Ljava/lang/String;)V
.end method

.method public native nativeSetDetectCallback(JLcom/rokid/aicore/ncnn/DetectCallback;)V
.end method

.method public process(Ljava/nio/ByteBuffer;IIIILcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;I)[Lcom/rokid/aicore/ncnn/bean/MotDetection;
    .locals 11
    .param p1, "imageData"    # Ljava/nio/ByteBuffer;
    .param p2, "offset"    # I
    .param p3, "size"    # I
    .param p4, "width"    # I
    .param p5, "height"    # I
    .param p6, "type"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;
    .param p7, "frameId"    # I

    .line 139
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 142
    move-object v10, p0

    iget-wide v1, v10, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    .line 143
    invoke-virtual/range {p6 .. p6}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->ordinal()I

    move-result v8

    .line 142
    move-object v0, p0

    move-object v3, p1

    move v4, p2

    move v5, p3

    move v6, p4

    move/from16 v7, p5

    move/from16 v9, p7

    invoke-direct/range {v0 .. v9}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeProcessDirectBuffer(JLjava/nio/ByteBuffer;IIIIII)[Lcom/rokid/aicore/ncnn/bean/MotDetection;

    move-result-object v0

    return-object v0

    .line 139
    :cond_0
    move-object v10, p0

    .line 140
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "imageData must be a direct ByteBuffer"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public process([BIILcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;I)[Lcom/rokid/aicore/ncnn/bean/MotDetection;
    .locals 8
    .param p1, "imageData"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I
    .param p4, "type"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;
    .param p5, "frameId"    # I

    .line 133
    iget-wide v1, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-virtual {p4}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->ordinal()I

    move-result v6

    move-object v0, p0

    move-object v3, p1

    move v4, p2

    move v5, p3

    move v7, p5

    invoke-direct/range {v0 .. v7}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeProcess(J[BIIII)[Lcom/rokid/aicore/ncnn/bean/MotDetection;

    move-result-object v0

    return-object v0
.end method

.method public processAsync(I[BIILcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;)I
    .locals 8
    .param p1, "frameId"    # I
    .param p2, "imageData"    # [B
    .param p3, "width"    # I
    .param p4, "height"    # I
    .param p5, "type"    # Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    .line 147
    iget-wide v1, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-virtual {p5}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->ordinal()I

    move-result v7

    move-object v0, p0

    move v3, p1

    move-object v4, p2

    move v5, p3

    move v6, p4

    invoke-direct/range {v0 .. v7}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeProcessAsync(JI[BIII)I

    move-result v0

    return v0
.end method

.method public release()V
    .locals 2

    .line 104
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-virtual {p0, v0, v1}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeCleanupDetectCallback(J)V

    .line 105
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-direct {p0, v0, v1}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeCleanupCallback(J)V

    .line 106
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-direct {p0, v0, v1}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeCleanupUnrecognizedCallback(J)V

    .line 107
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-direct {p0, v0, v1}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeRelease(J)V

    .line 108
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    .line 109
    return-void
.end method

.method public setDetectCallback(Lcom/rokid/aicore/ncnn/DetectCallback;)V
    .locals 0
    .param p1, "callback"    # Lcom/rokid/aicore/ncnn/DetectCallback;

    .line 101
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->detectCallback:Lcom/rokid/aicore/ncnn/DetectCallback;

    .line 102
    return-void
.end method

.method public setImagePoolSize(I)V
    .locals 2
    .param p1, "poolSize"    # I

    .line 220
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "setImagePoolSize: poolSize="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "MotWrapper"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 221
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeHandle:J

    invoke-direct {p0, v0, v1, p1}, Lcom/rokid/aicore/ncnn/MotWrapper;->nativeSetImagePoolSize(JI)V

    .line 222
    return-void
.end method

.method public setRecognizeCallback(Lcom/rokid/aicore/ncnn/RecognizeCallback;)V
    .locals 0
    .param p1, "callback"    # Lcom/rokid/aicore/ncnn/RecognizeCallback;

    .line 93
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->callback:Lcom/rokid/aicore/ncnn/RecognizeCallback;

    .line 94
    return-void
.end method

.method public setWhitelistUnRecognizeCallback(Lcom/rokid/aicore/ncnn/UnrecognizeCallback;)V
    .locals 0
    .param p1, "callback"    # Lcom/rokid/aicore/ncnn/UnrecognizeCallback;

    .line 97
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/MotWrapper;->unRecogCallback:Lcom/rokid/aicore/ncnn/UnrecognizeCallback;

    .line 98
    return-void
.end method
