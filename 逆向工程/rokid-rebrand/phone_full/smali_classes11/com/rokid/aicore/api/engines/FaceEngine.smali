.class public Lcom/rokid/aicore/api/engines/FaceEngine;
.super Lcom/rokid/aicore/api/engines/BaseEngine;


# instance fields
.field private faceCallback:Lcom/rokid/aicore/api/callback/face/FaceCallback;

.field private mMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;


# direct methods
.method public constructor <init>()V
    .locals 1

    sget-object v0, Lcom/rokid/aicore/type/AIType;->FACE:Lcom/rokid/aicore/type/AIType;

    invoke-direct {p0, v0}, Lcom/rokid/aicore/api/engines/BaseEngine;-><init>(Lcom/rokid/aicore/type/AIType;)V

    return-void
.end method

.method private convertFaceRecogResult(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;
    .locals 20

    move-object/from16 v0, p6

    move-object/from16 v7, p0

    iget-object v1, v7, Lcom/rokid/aicore/api/engines/FaceEngine;->mMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isSaveTestData()Z

    move-result v1

    new-instance v19, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;

    new-instance v2, Landroid/graphics/Rect;

    iget v3, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    float-to-int v3, v3

    iget v4, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    float-to-int v4, v4

    iget v5, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    float-to-int v5, v5

    iget v0, v0, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    float-to-int v0, v0

    invoke-direct {v2, v3, v4, v5, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    move-object/from16 v8, v19

    move/from16 v9, p1

    move/from16 v10, p2

    move-object/from16 v11, p4

    move/from16 v12, p5

    move-object/from16 v13, p3

    move-object/from16 v14, p7

    move/from16 v15, p8

    move/from16 v16, p9

    move-object/from16 v17, v2

    move/from16 v18, p10

    invoke-direct/range {v8 .. v18}, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;-><init>(IILjava/lang/String;FLjava/lang/String;Ljava/nio/ByteBuffer;IILandroid/graphics/Rect;I)V

    move-object/from16 v0, p0

    move-object/from16 v2, v19

    move-object/from16 v3, p7

    move/from16 v4, p8

    move/from16 v5, p9

    move/from16 v6, p1

    invoke-direct/range {v0 .. v6}, Lcom/rokid/aicore/api/engines/FaceEngine;->saveRecogTestBigPic(ZLcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;Ljava/nio/ByteBuffer;III)V

    return-object v19
.end method

.method private convertMotDetectResults(ILjava/util/List;Ljava/nio/ByteBuffer;II)Ljava/util/ArrayList;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/List<",
            "Lcom/rokid/aicore/ncnn/bean/MotDetection;",
            ">;",
            "Ljava/nio/ByteBuffer;",
            "II)",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;"
        }
    .end annotation

    if-eqz p2, :cond_3

    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto/16 :goto_1

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceEngine;->mMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isSaveTestData()Z

    move-result v2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "faceDetectResult Detect frame"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;

    iget v3, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->prob:F

    invoke-virtual {p0}, Lcom/rokid/aicore/api/engines/BaseEngine;->getDetectScore()F

    move-result v4

    cmpl-float v3, v3, v4

    if-ltz v3, :cond_1

    new-instance v3, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;

    int-to-long v4, p1

    iget-wide v6, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->trackId:J

    invoke-direct {v3, v4, v5, v6, v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;-><init>(JJ)V

    invoke-virtual {v3, p3}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setDataBuffer(Ljava/nio/ByteBuffer;)V

    invoke-virtual {v3, v4, v5}, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->setFrameId(J)V

    iget v4, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->prob:F

    invoke-virtual {v3, v4}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setFaceScore(F)V

    iget v4, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->iqaScore:F

    invoke-virtual {v3, v4}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setIqaScore(F)V

    iget-object v4, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v4, v4, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    invoke-virtual {v3, v4}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setX1(F)V

    iget-object v4, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v4, v4, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    invoke-virtual {v3, v4}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setY1(F)V

    iget-object v4, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v4, v4, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    invoke-virtual {v3, v4}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setX2(F)V

    iget-object v4, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v4, v4, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    invoke-virtual {v3, v4}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setY2(F)V

    invoke-virtual {v8, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, ",(track_id"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-wide v5, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->trackId:J

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getX1()F

    move-result v5

    int-to-float v6, p4

    mul-float/2addr v5, v6

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ","

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getY1()F

    move-result v7

    int-to-float v9, p5

    mul-float/2addr v7, v9

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getX2()F

    move-result v7

    mul-float/2addr v7, v6

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getY2()F

    move-result v3

    mul-float/2addr v3, v9

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "], iqa_score: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v1, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->iqaScore:F

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ")"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ",count: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_2
    move-object v1, p0

    move-object v3, v8

    move-object v4, p3

    move v5, p4

    move v6, p5

    move v7, p1

    invoke-direct/range {v1 .. v7}, Lcom/rokid/aicore/api/engines/FaceEngine;->saveDetectTestBigPic(ZLjava/util/ArrayList;Ljava/nio/ByteBuffer;III)V

    return-object v8

    :cond_3
    :goto_1
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    return-object p1
.end method

.method private convertMotDetectResults([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)Ljava/util/ArrayList;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Lcom/rokid/aicore/ncnn/bean/MotDetection;",
            "Lcom/rokid/aicore/api/bean/ImageInput;",
            ")",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;"
        }
    .end annotation

    if-eqz p1, :cond_3

    array-length v0, p1

    if-gtz v0, :cond_0

    goto/16 :goto_1

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceEngine;->mMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isSaveTestData()Z

    move-result v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "faceDetectResult Detect frame"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    array-length v3, p1

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_2

    aget-object v5, p1, v4

    iget v6, v5, Lcom/rokid/aicore/ncnn/bean/MotDetection;->prob:F

    invoke-virtual {p0}, Lcom/rokid/aicore/api/engines/BaseEngine;->getDetectScore()F

    move-result v7

    cmpl-float v6, v6, v7

    if-ltz v6, :cond_1

    new-instance v6, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;

    iget-wide v7, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    iget-wide v9, v5, Lcom/rokid/aicore/ncnn/bean/MotDetection;->trackId:J

    invoke-direct {v6, v7, v8, v9, v10}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;-><init>(JJ)V

    iget-object v7, p2, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setData([B)V

    iget-wide v7, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v6, v7, v8}, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->setFrameId(J)V

    iget v7, v5, Lcom/rokid/aicore/ncnn/bean/MotDetection;->prob:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setFaceScore(F)V

    iget v7, v5, Lcom/rokid/aicore/ncnn/bean/MotDetection;->iqaScore:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setIqaScore(F)V

    iget-object v7, v5, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v7, v7, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setX1(F)V

    iget-object v7, v5, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v7, v7, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setY1(F)V

    iget-object v7, v5, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v7, v7, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setX2(F)V

    iget-object v7, v5, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v7, v7, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setY2(F)V

    invoke-virtual {v2, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, ",(track_id"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-wide v8, v5, Lcom/rokid/aicore/ncnn/bean/MotDetection;->trackId:J

    invoke-virtual {v7, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "["

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v6}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getX1()F

    move-result v8

    iget v9, p2, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    int-to-float v9, v9

    mul-float/2addr v8, v9

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ","

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v6}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getY1()F

    move-result v9

    iget v10, p2, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    int-to-float v10, v10

    mul-float/2addr v9, v10

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v6}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getX2()F

    move-result v9

    iget v10, p2, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    int-to-float v10, v10

    mul-float/2addr v9, v10

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v6}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getY2()F

    move-result v6

    iget v8, p2, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    int-to-float v8, v8

    mul-float/2addr v6, v8

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "], iqa_score: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v5, v5, Lcom/rokid/aicore/ncnn/bean/MotDetection;->iqaScore:F

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ")"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_1
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, ",count: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v5, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_0

    :cond_2
    invoke-direct {p0, v0, v2, p2}, Lcom/rokid/aicore/api/engines/FaceEngine;->saveDetectTestBigPic(ZLjava/util/ArrayList;Lcom/rokid/aicore/api/bean/ImageInput;)V

    return-object v2

    :cond_3
    :goto_1
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    return-object p1
.end method

.method private saveDetectTestBigPic(ZLjava/util/ArrayList;Lcom/rokid/aicore/api/bean/ImageInput;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;",
            "Lcom/rokid/aicore/api/bean/ImageInput;",
            ")V"
        }
    .end annotation

    const-string v0, "_"

    if-eqz p1, :cond_5

    :try_start_0
    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object p1

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v2, ".jpg"

    const-string v3, "/"

    if-nez p2, :cond_0

    :try_start_1
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "/testDetectFailed"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {p2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    goto :goto_1

    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v4, "/testDetect"

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-wide v6, p3, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v5, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v5}, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->getTrackId()J

    move-result-wide v7

    invoke-virtual {v6, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v5}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getIqaScore()F

    move-result v5

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_1
    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    :goto_1
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    :cond_2
    new-instance p1, Ljava/io/File;

    invoke-direct {p1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {p1}, Ljava/io/File;->createNewFile()Z

    :cond_3
    if-eqz p3, :cond_4

    iget-object v1, p3, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    :cond_4
    iget p1, p3, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget v0, p3, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    new-instance v2, Landroid/graphics/Rect;

    iget v3, p3, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget p3, p3, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    const/4 v4, 0x0

    invoke-direct {v2, v4, v4, v3, p3}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-static {v1, p2, p1, v0, v2}, Lcom/rokid/aicore/utils/BitmapUtils;->nv21ToFile([BLjava/lang/String;IILandroid/graphics/Rect;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_5
    :goto_2
    return-void
.end method

.method private saveDetectTestBigPic(ZLjava/util/ArrayList;Ljava/nio/ByteBuffer;III)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;",
            "Ljava/nio/ByteBuffer;",
            "III)V"
        }
    .end annotation

    const-string v0, "_"

    if-eqz p1, :cond_4

    :try_start_0
    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v1, ".jpg"

    const-string v2, "/"

    const/4 v3, 0x0

    if-nez p2, :cond_0

    :try_start_1
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v3}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "/testDetectFailed"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {p2, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    goto :goto_1

    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v3}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v3, "/testDetect"

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result p6

    if-eqz p6, :cond_1

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p6

    check-cast p6, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p6}, Lcom/rokid/aicore/api/callback/result/base/BaseFaceResult;->getTrackId()J

    move-result-wide v5

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p6}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getIqaScore()F

    move-result p6

    invoke-virtual {v4, p6}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_1
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p6

    invoke-virtual {p2, p6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    :goto_1
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    new-instance p6, Ljava/io/File;

    invoke-direct {p6, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p6}, Ljava/io/File;->exists()Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {p6}, Ljava/io/File;->mkdirs()Z

    :cond_2
    new-instance p1, Ljava/io/File;

    invoke-direct {p1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p2

    if-nez p2, :cond_3

    invoke-virtual {p1}, Ljava/io/File;->createNewFile()Z

    :cond_3
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    new-instance v4, Landroid/graphics/Rect;

    const/4 p1, 0x0

    invoke-direct {v4, p1, p1, p4, p5}, Landroid/graphics/Rect;-><init>(IIII)V

    const/16 v5, 0x55

    move-object v0, p3

    move v2, p4

    move v3, p5

    invoke-static/range {v0 .. v5}, Lcom/rokid/aicore/utils/BitmapUtils;->RGBToJPEG(Ljava/nio/ByteBuffer;Ljava/lang/String;IILandroid/graphics/Rect;I)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_4
    :goto_2
    return-void
.end method

.method private saveRecogTestBigPic(ZLcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;Ljava/nio/ByteBuffer;III)V
    .locals 6

    const-string v0, "_"

    if-eqz p1, :cond_3

    :try_start_0
    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v1, ".jpg"

    const-string v2, "/"

    const/4 v3, 0x0

    if-nez p2, :cond_0

    :try_start_1
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v3}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "/testRecogFailed"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {p2, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    goto :goto_0

    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v3}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v3, "/testRecog"

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p6

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->getTrackId()I

    move-result v4

    invoke-virtual {p6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p6

    invoke-virtual {p6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p6

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->getLabel()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p6

    invoke-virtual {p6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p6

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->getRegScore()F

    move-result v4

    invoke-virtual {p6, v4}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p6

    invoke-virtual {p6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p6

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->getLibraryName()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p6, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p6

    invoke-virtual {p2, p6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    :goto_0
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    new-instance p6, Ljava/io/File;

    invoke-direct {p6, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p6}, Ljava/io/File;->exists()Z

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p6}, Ljava/io/File;->mkdirs()Z

    :cond_1
    new-instance p1, Ljava/io/File;

    invoke-direct {p1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p2

    if-nez p2, :cond_2

    invoke-virtual {p1}, Ljava/io/File;->createNewFile()Z

    :cond_2
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    new-instance v4, Landroid/graphics/Rect;

    const/4 p1, 0x0

    invoke-direct {v4, p1, p1, p4, p5}, Landroid/graphics/Rect;-><init>(IIII)V

    const/16 v5, 0x55

    move-object v0, p3

    move v2, p4

    move v3, p5

    invoke-static/range {v0 .. v5}, Lcom/rokid/aicore/utils/BitmapUtils;->RGBToJPEG(Ljava/nio/ByteBuffer;Ljava/lang/String;IILandroid/graphics/Rect;I)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_3
    :goto_1
    return-void
.end method


# virtual methods
.method public AIEvent([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)V
    .locals 3

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceEngine;->faceCallback:Lcom/rokid/aicore/api/callback/face/FaceCallback;

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, p2}, Lcom/rokid/aicore/api/engines/FaceEngine;->convertMotDetectResults([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)Ljava/util/ArrayList;

    move-result-object p1

    iget-wide v1, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-interface {v0, p1, v1, v2}, Lcom/rokid/aicore/api/callback/face/FaceCallback;->onFaceTrackCallback(Ljava/util/ArrayList;J)V

    :cond_0
    return-void
.end method

.method public AIEventBuffer([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/BufferImageInput;)V
    .locals 3

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceEngine;->faceCallback:Lcom/rokid/aicore/api/callback/face/FaceCallback;

    if-eqz v0, :cond_1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/bean/BufferImageInput;->toMetadataImageInput()Lcom/rokid/aicore/api/bean/ImageInput;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lcom/rokid/aicore/api/engines/FaceEngine;->convertMotDetectResults([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;

    invoke-virtual {p2}, Lcom/rokid/aicore/api/bean/BufferImageInput;->borrowedView()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->setDataBuffer(Ljava/nio/ByteBuffer;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceEngine;->faceCallback:Lcom/rokid/aicore/api/callback/face/FaceCallback;

    iget-wide v1, p2, Lcom/rokid/aicore/api/bean/BufferImageInput;->frame_id:J

    invoke-interface {v0, p1, v1, v2}, Lcom/rokid/aicore/api/callback/face/FaceCallback;->onFaceTrackCallback(Ljava/util/ArrayList;J)V

    :cond_1
    return-void
.end method

.method public AIFaceDetectEvent(ILjava/util/List;Ljava/nio/ByteBuffer;II)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/List<",
            "Lcom/rokid/aicore/ncnn/bean/MotDetection;",
            ">;",
            "Ljava/nio/ByteBuffer;",
            "II)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceEngine;->faceCallback:Lcom/rokid/aicore/api/callback/face/FaceCallback;

    if-eqz v0, :cond_0

    invoke-direct/range {p0 .. p5}, Lcom/rokid/aicore/api/engines/FaceEngine;->convertMotDetectResults(ILjava/util/List;Ljava/nio/ByteBuffer;II)Ljava/util/ArrayList;

    move-result-object p2

    int-to-long p3, p1

    invoke-interface {v0, p2, p3, p4}, Lcom/rokid/aicore/api/callback/face/FaceCallback;->onFaceTrackCallback(Ljava/util/ArrayList;J)V

    :cond_0
    return-void
.end method

.method public AIRecogEvent(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)V
    .locals 3

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "faceRecogResult recognized frame: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", track_Id: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", rec_score: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", label: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceEngine;->faceCallback:Lcom/rokid/aicore/api/callback/face/FaceCallback;

    if-eqz v0, :cond_0

    invoke-direct/range {p0 .. p10}, Lcom/rokid/aicore/api/engines/FaceEngine;->convertFaceRecogResult(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/rokid/aicore/api/callback/face/FaceCallback;->onFaceRecognizeCallback(Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;)V

    :cond_0
    return-void
.end method

.method public AIUnRecogEvent(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)V
    .locals 3

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AIUnRecogEvent recognized frame: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", track_Id: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", rec_score: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", label: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/FaceEngine;->faceCallback:Lcom/rokid/aicore/api/callback/face/FaceCallback;

    if-eqz v0, :cond_0

    invoke-direct/range {p0 .. p10}, Lcom/rokid/aicore/api/engines/FaceEngine;->convertFaceRecogResult(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/rokid/aicore/api/callback/face/FaceCallback;->onFaceRecognizeNotInLibCallback(Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;)V

    :cond_0
    return-void
.end method

.method public initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/engines/FaceEngine;->mMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-super {p0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I

    move-result p1

    return p1
.end method

.method public release()V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/aicore/api/engines/FaceEngine;->mMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-super {p0}, Lcom/rokid/aicore/api/engines/BaseEngine;->release()V

    return-void
.end method

.method public removeFeatureLibrary(Ljava/lang/String;)I
    .locals 0

    invoke-super {p0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->removeFeatureLibrary(Ljava/lang/String;)I

    move-result p1

    return p1
.end method

.method public setFaceTrackCallback(Lcom/rokid/aicore/api/callback/face/FaceCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/engines/FaceEngine;->faceCallback:Lcom/rokid/aicore/api/callback/face/FaceCallback;

    return-void
.end method

.method public setFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I
    .locals 0

    invoke-super {p0, p1, p2}, Lcom/rokid/aicore/api/engines/BaseEngine;->setFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    return p1
.end method
