.class public Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$RecognizationResult;
.super Ljava/lang/Object;
.source "FaceRecognizerWrapper.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "RecognizationResult"
.end annotation


# instance fields
.field public frameId:I

.field public libraryName:Ljava/lang/String;

.field public recogLabel:Ljava/lang/String;

.field public recogScore:F

.field public trackId:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
