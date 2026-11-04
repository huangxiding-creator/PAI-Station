.class public Lcom/rokid/aicore/ncnn/BarcodeDetector;
.super Ljava/lang/Object;
.source "BarcodeDetector.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;
    }
.end annotation


# instance fields
.field private nativeHandle:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 8
    const-string v0, "barcode_detector"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 9
    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    invoke-static {}, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeCreate()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeHandle:J

    .line 20
    return-void
.end method

.method private static native nativeCreate()J
.end method

.method private static native nativeDestroy(J)V
.end method

.method private static native nativeDetect(JJ[BIII)[Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;
.end method

.method private static native nativeLoadAsset(JLandroid/content/res/AssetManager;Ljava/lang/String;Ljava/lang/String;Z)I
.end method

.method private static native nativeSetTargetSize(JI)V
.end method


# virtual methods
.method public detect([BIIIJ)[Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;
    .locals 8
    .param p1, "image"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I
    .param p4, "imageType"    # I
    .param p5, "frameId"    # J

    .line 34
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeHandle:J

    move-wide v2, p5

    move-object v4, p1

    move v5, p2

    move v6, p3

    move v7, p4

    invoke-static/range {v0 .. v7}, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeDetect(JJ[BIII)[Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;

    move-result-object v0

    return-object v0
.end method

.method public load(Landroid/content/res/AssetManager;Ljava/lang/String;Ljava/lang/String;Z)I
    .locals 6
    .param p1, "mgr"    # Landroid/content/res/AssetManager;
    .param p2, "paramPath"    # Ljava/lang/String;
    .param p3, "modelPath"    # Ljava/lang/String;
    .param p4, "useGpu"    # Z

    .line 30
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeHandle:J

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-static/range {v0 .. v5}, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeLoadAsset(JLandroid/content/res/AssetManager;Ljava/lang/String;Ljava/lang/String;Z)I

    move-result v0

    return v0
.end method

.method public release()V
    .locals 4

    .line 23
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeHandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 24
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeHandle:J

    invoke-static {v0, v1}, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeDestroy(J)V

    .line 25
    iput-wide v2, p0, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeHandle:J

    .line 27
    :cond_0
    return-void
.end method

.method public setTargetSize(I)V
    .locals 2
    .param p1, "size"    # I

    .line 38
    iget-wide v0, p0, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeHandle:J

    invoke-static {v0, v1, p1}, Lcom/rokid/aicore/ncnn/BarcodeDetector;->nativeSetTargetSize(JI)V

    .line 39
    return-void
.end method
