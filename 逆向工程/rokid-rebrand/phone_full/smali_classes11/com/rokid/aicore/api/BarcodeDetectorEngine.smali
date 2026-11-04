.class public Lcom/rokid/aicore/api/BarcodeDetectorEngine;
.super Ljava/lang/Object;


# static fields
.field private static final LOCK_LIST:Ljava/lang/String; = "LOCK_LIST"

.field private static instance:Lcom/rokid/aicore/api/BarcodeDetectorEngine;


# instance fields
.field private barcodeDetector:Lcom/rokid/aicore/ncnn/BarcodeDetector;

.field private isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

.field public mIsDestroyed:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->mIsDestroyed:Z

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method private convertBarcodeDetectResult(Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;Lcom/rokid/aicore/api/bean/ImageInput;)Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;
    .locals 3

    new-instance v0, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;

    invoke-direct {v0}, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;-><init>()V

    iget v1, p1, Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;->x1:F

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX1(F)V

    iget v1, p1, Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;->x2:F

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX2(F)V

    iget v1, p1, Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;->y1:F

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY1(F)V

    iget v1, p1, Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;->y2:F

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY2(F)V

    iget v1, p2, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->setWidth(I)V

    iget v1, p2, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->setHeight(I)V

    iget-wide v1, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v0, v1, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->setFrameId(J)V

    iget p1, p1, Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;->prob:F

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->setDetectScore(F)V

    iget-object p1, p2, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->setData([B)V

    return-object v0
.end method

.method public static getInstance()Lcom/rokid/aicore/api/BarcodeDetectorEngine;
    .locals 2

    const-class v0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->instance:Lcom/rokid/aicore/api/BarcodeDetectorEngine;

    if-nez v1, :cond_0

    new-instance v1, Lcom/rokid/aicore/api/BarcodeDetectorEngine;

    invoke-direct {v1}, Lcom/rokid/aicore/api/BarcodeDetectorEngine;-><init>()V

    sput-object v1, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->instance:Lcom/rokid/aicore/api/BarcodeDetectorEngine;

    :cond_0
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    sget-object v0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->instance:Lcom/rokid/aicore/api/BarcodeDetectorEngine;

    return-object v0

    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method


# virtual methods
.method public destroy()V
    .locals 2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->mIsDestroyed:Z

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v1, "start destroy aicore"

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    :goto_0
    iget-object v0, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

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
    iget-object v0, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->barcodeDetector:Lcom/rokid/aicore/ncnn/BarcodeDetector;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/BarcodeDetector;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->barcodeDetector:Lcom/rokid/aicore/ncnn/BarcodeDetector;

    :cond_1
    return-void
.end method

.method public init(Landroid/content/res/AssetManager;Ljava/lang/String;Ljava/lang/String;)I
    .locals 2

    if-eqz p1, :cond_1

    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/aicore/ncnn/BarcodeDetector;

    invoke-direct {v0}, Lcom/rokid/aicore/ncnn/BarcodeDetector;-><init>()V

    iput-object v0, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->barcodeDetector:Lcom/rokid/aicore/ncnn/BarcodeDetector;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, p2, p3, v1}, Lcom/rokid/aicore/ncnn/BarcodeDetector;->load(Landroid/content/res/AssetManager;Ljava/lang/String;Ljava/lang/String;Z)I

    move-result p1

    sget-object p2, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "BarcodeDetector# load result : "

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Lcom/rokid/aicore/utils/LogUtil$Companion;->d(Ljava/lang/String;)V

    iput-boolean v1, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->mIsDestroyed:Z

    return p1

    :cond_1
    :goto_0
    const/4 p1, -0x1

    return p1
.end method

.method public process(Lcom/rokid/aicore/api/bean/ImageInput;)Ljava/util/ArrayList;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/aicore/api/bean/ImageInput;",
            ")",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;",
            ">;"
        }
    .end annotation

    iget-boolean v0, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->mIsDestroyed:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "BarcodeDetector#process error.because has destroyed"

    :goto_0
    invoke-virtual {p1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->d(Ljava/lang/String;)V

    return-object v1

    :cond_0
    iget-object v0, p1, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    if-eqz v0, :cond_4

    array-length v0, v0

    if-gtz v0, :cond_1

    goto :goto_2

    :cond_1
    iget-object v0, p1, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->ordinal()I

    move-result v0

    sget-object v2, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->BRG:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    invoke-virtual {v2}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->ordinal()I

    move-result v2

    if-le v0, v2, :cond_2

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "BarcodeDetector#process error.ImageInput type is error "

    goto :goto_0

    :cond_2
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    iget-object v3, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->barcodeDetector:Lcom/rokid/aicore/ncnn/BarcodeDetector;

    iget-object v4, p1, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    iget v5, p1, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget v6, p1, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    iget-object v1, p1, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->ordinal()I

    move-result v7

    iget-wide v8, p1, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual/range {v3 .. v9}, Lcom/rokid/aicore/ncnn/BarcodeDetector;->detect([BIIIJ)[Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz v1, :cond_3

    array-length v3, v1

    if-lez v3, :cond_3

    array-length v3, v1

    move v4, v2

    :goto_1
    if-ge v4, v3, :cond_3

    aget-object v5, v1, v4

    invoke-direct {p0, v5, p1}, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->convertBarcodeDetectResult(Lcom/rokid/aicore/ncnn/BarcodeDetector$Detection;Lcom/rokid/aicore/api/bean/ImageInput;)Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    sget-object v6, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "BarcodeDetector detectResult : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v5}, Lcom/rokid/aicore/api/callback/result/BarcodeDetectResult;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v6, v5}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_3
    iget-object p1, p0, Lcom/rokid/aicore/api/BarcodeDetectorEngine;->isProcessing:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {p1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    return-object v0

    :cond_4
    :goto_2
    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "BarcodeDetector#process error.imageInput.data is empty"

    goto :goto_0
.end method
