.class public Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;
.super Ljava/lang/Object;
.source "FaceRecognizerWrapper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;,
        Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;
    }
.end annotation


# instance fields
.field private nativeHandle:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 9
    const-string v0, "face_recognizer_jni"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 10
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;ZFFLandroid/content/res/AssetManager;)V
    .locals 2
    .param p1, "recogModelName"    # Ljava/lang/String;
    .param p2, "detectModelName"    # Ljava/lang/String;
    .param p3, "useGpu"    # Z
    .param p4, "recogThreshold"    # F
    .param p5, "iqaThreshold"    # F
    .param p6, "assetManager"    # Landroid/content/res/AssetManager;

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeHandle:J

    .line 37
    invoke-direct/range {p0 .. p6}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeCreate(Ljava/lang/String;Ljava/lang/String;ZFFLjava/lang/Object;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeHandle:J

    .line 39
    return-void
.end method

.method private native nativeAddFeatureLibrary(JLjava/lang/String;Ljava/lang/String;)I
.end method

.method private native nativeCreate(Ljava/lang/String;Ljava/lang/String;ZFFLjava/lang/Object;)J
.end method

.method private native nativeDelFeatureLibrary(JLjava/lang/String;)I
.end method

.method private native nativeRecognizeImage(JII[BIII)Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;
.end method

.method private native nativeRelease(J)V
.end method


# virtual methods
.method public addFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I
    .locals 2
    .param p1, "libraryName"    # Ljava/lang/String;
    .param p2, "featureFile"    # Ljava/lang/String;

    .line 50
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeHandle:J

    invoke-direct {p0, v0, v1, p1, p2}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeAddFeatureLibrary(JLjava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public delFeatureLibrary(Ljava/lang/String;)I
    .locals 2
    .param p1, "libraryName"    # Ljava/lang/String;

    .line 54
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeHandle:J

    invoke-direct {p0, v0, v1, p1}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeDelFeatureLibrary(JLjava/lang/String;)I

    move-result v0

    return v0
.end method

.method public recognizeImage(II[BIILcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;)Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;
    .locals 9
    .param p1, "frameId"    # I
    .param p2, "trackId"    # I
    .param p3, "imageData"    # [B
    .param p4, "width"    # I
    .param p5, "height"    # I
    .param p6, "imageType"    # Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    .line 61
    iget-wide v1, p0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeHandle:J

    .line 62
    invoke-virtual {p6}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->ordinal()I

    move-result v8

    .line 61
    move-object v0, p0

    move v3, p1

    move v4, p2

    move-object v5, p3

    move v6, p4

    move v7, p5

    invoke-direct/range {v0 .. v8}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeRecognizeImage(JII[BIII)Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;

    move-result-object v0

    return-object v0
.end method

.method public release()V
    .locals 4

    .line 42
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeHandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 43
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeHandle:J

    invoke-direct {p0, v0, v1}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeRelease(J)V

    .line 44
    iput-wide v2, p0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;->nativeHandle:J

    .line 46
    :cond_0
    return-void
.end method
