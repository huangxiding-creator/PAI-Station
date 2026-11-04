.class public Lcom/rokid/aicore/ncnn/SCRFDNcnn;
.super Ljava/lang/Object;
.source "SCRFDNcnn.java"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 28
    const-string v0, "scrfdncnn"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 29
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public native closeCamera()Z
.end method

.method public native loadModel(Landroid/content/res/AssetManager;II)Z
.end method

.method public native openCamera(I)Z
.end method

.method public native setOutputWindow(Landroid/view/Surface;)Z
.end method
