.class public Lcom/rokid/aicore/api/engines/MotorLPREngine;
.super Lcom/rokid/aicore/api/engines/BaseEngine;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;
    }
.end annotation


# static fields
.field private static final YUHANG_PATTERN:Ljava/util/regex/Pattern;


# instance fields
.field private areaThreshold:I

.field private mExternalProcessCallback:Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;

.field private mLprCallback:Lcom/rokid/aicore/api/callback/LPRCallback;

.field private mLprMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

.field private widthThreshold:I


# direct methods
.method public static constructor <clinit>()V
    .locals 1

    const-string v0, "([\\u4e00-\\u9fa5]+)(\\d+)"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->YUHANG_PATTERN:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    sget-object v0, Lcom/rokid/aicore/type/AIType;->MOTOR_LPR:Lcom/rokid/aicore/type/AIType;

    invoke-direct {p0, v0}, Lcom/rokid/aicore/api/engines/BaseEngine;-><init>(Lcom/rokid/aicore/type/AIType;)V

    const/4 v0, 0x0

    iput v0, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->widthThreshold:I

    iput v0, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->areaThreshold:I

    return-void
.end method

.method private convertMotDetectResults([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)Ljava/util/ArrayList;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Lcom/rokid/aicore/ncnn/bean/MotDetection;",
            "Lcom/rokid/aicore/api/bean/ImageInput;",
            ")",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/LPRResult;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->mLprMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isSaveTestData()Z

    move-result v0

    if-eqz p1, :cond_3

    array-length v1, p1

    if-nez v1, :cond_0

    goto/16 :goto_2

    :cond_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    array-length v2, p1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, p1, v3

    new-instance v5, Lcom/rokid/aicore/api/callback/result/LPRResult;

    invoke-direct {v5}, Lcom/rokid/aicore/api/callback/result/LPRResult;-><init>()V

    iget v6, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->prob:F

    invoke-virtual {v5, v6}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setScore(F)V

    iget-object v6, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v6, v6, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    invoke-virtual {v5, v6}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX1(F)V

    iget-object v6, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v6, v6, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    invoke-virtual {v5, v6}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY1(F)V

    iget-object v6, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v6, v6, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    invoke-virtual {v5, v6}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX2(F)V

    iget-object v6, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v6, v6, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    invoke-virtual {v5, v6}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY2(F)V

    iget v6, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->recProb:F

    invoke-virtual {v5, v6}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateCharScore(F)V

    iget-wide v6, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v5, v6, v7}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->setFrameId(J)V

    iget-object v6, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->plateChars:Ljava/lang/String;

    invoke-direct {p0, v6, v5}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->processPlate(Ljava/lang/String;Lcom/rokid/aicore/api/callback/result/LPRResult;)Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;

    move-result-object v5

    new-instance v6, Lcom/rokid/aicore/api/callback/result/LPRResult;

    invoke-direct {v6}, Lcom/rokid/aicore/api/callback/result/LPRResult;-><init>()V

    iget-object v7, p2, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setData([B)V

    iget-object v7, v5, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;->processedPlate:Ljava/lang/String;

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setLabel(Ljava/lang/String;)V

    iget-wide v7, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v6, v7, v8}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->setFrameId(J)V

    iget v7, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->prob:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setScore(F)V

    iget-object v7, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v7, v7, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX1(F)V

    iget-object v7, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v7, v7, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY1(F)V

    iget-object v7, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v7, v7, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX2(F)V

    iget-object v7, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v7, v7, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY2(F)V

    iget v7, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->recProb:F

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateCharScore(F)V

    iget-object v7, v5, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;->status:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    invoke-virtual {v6, v7}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateStatus(Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;)V

    sget-object v7, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "MotorLPRResult: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v6}, Lcom/rokid/aicore/api/callback/result/LPRResult;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    invoke-direct {p0, v4, p2}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->isRectMatch(Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)Z

    move-result v7

    iget-object v5, v5, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;->status:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    sget-object v8, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->VALID:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    if-ne v5, v8, :cond_1

    if-eqz v7, :cond_1

    iget v4, v4, Lcom/rokid/aicore/ncnn/bean/MotDetection;->prob:F

    invoke-virtual {p0}, Lcom/rokid/aicore/api/engines/BaseEngine;->getDetectScore()F

    move-result v5

    cmpl-float v4, v4, v5

    if-ltz v4, :cond_1

    invoke-direct {p0, v0, v6, p2}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->saveTestPlateBigPic(ZLcom/rokid/aicore/api/callback/result/LPRResult;Lcom/rokid/aicore/api/bean/ImageInput;)V

    invoke-virtual {v1, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    invoke-direct {p0, v0, v6, p2}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->saveTestPlateBigPic(ZLcom/rokid/aicore/api/callback/result/LPRResult;Lcom/rokid/aicore/api/bean/ImageInput;)V

    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_0

    :cond_2
    return-object v1

    :cond_3
    :goto_2
    const/4 p1, 0x0

    invoke-direct {p0, v0, p1, p2}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->saveTestPlateBigPic(ZLcom/rokid/aicore/api/callback/result/LPRResult;Lcom/rokid/aicore/api/bean/ImageInput;)V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    return-object p1
.end method

.method private isRectMatch(Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)Z
    .locals 4

    new-instance v0, Landroid/graphics/RectF;

    iget-object p1, p1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v1, p1, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    iget v2, p1, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    iget v3, p1, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    iget p1, p1, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    invoke-direct {v0, v1, v2, v3, p1}, Landroid/graphics/RectF;-><init>(FFFF)V

    iget p1, p2, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget p2, p2, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    invoke-static {v0, p1, p2}, Lcom/rokid/aicore/api/engines/LPREngine;->toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;

    move-result-object p1

    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    move-result p2

    iget v0, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->widthThreshold:I

    if-gt p2, v0, :cond_1

    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    move-result p2

    invoke-virtual {p1}, Landroid/graphics/Rect;->height()I

    move-result p1

    mul-int/2addr p2, p1

    iget p1, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->areaThreshold:I

    if-le p2, p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    :goto_1
    return p1
.end method

.method private processPlate(Ljava/lang/String;Lcom/rokid/aicore/api/callback/result/LPRResult;)Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;
    .locals 6

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->mExternalProcessCallback:Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    :try_start_0
    invoke-interface {v0, p1, p2}, Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;->processPlate(Ljava/lang/String;Lcom/rokid/aicore/api/callback/result/LPRResult;)Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback$PlateProcessResult;

    move-result-object p2

    new-instance v0, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;

    invoke-direct {v0, v1}, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;-><init>(Lcom/rokid/aicore/api/engines/MotorLPREngine$1;)V

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback$PlateProcessResult;->getProcessedPlate()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;->processedPlate:Ljava/lang/String;

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback$PlateProcessResult;->getStatus()Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    move-result-object p2

    iput-object p2, v0, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;->status:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception p2

    sget-object p2, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "External plate processing failed, fallback to internal logic"

    invoke-virtual {p2, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->w(Ljava/lang/String;)V

    :cond_0
    new-instance p2, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;

    invoke-direct {p2, v1}, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;-><init>(Lcom/rokid/aicore/api/engines/MotorLPREngine$1;)V

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    iput-object p1, p2, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;->processedPlate:Ljava/lang/String;

    sget-object p1, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->EMPTY:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    iput-object p1, p2, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;->status:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    return-object p2

    :cond_1
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x5357

    const v3, 0x8d63

    const/16 v4, 0x676d

    const/16 v5, 0x4f59

    if-eq v1, v5, :cond_4

    if-ne v1, v4, :cond_2

    goto :goto_0

    :cond_2
    if-eq v1, v3, :cond_3

    if-ne v1, v2, :cond_5

    :cond_3
    invoke-direct {p0, p1}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->resolvedNanChangPlate(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_1

    :cond_4
    :goto_0
    invoke-direct {p0, p1}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->resolvedYuhangPlate(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    :cond_5
    :goto_1
    iput-object p1, p2, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;->processedPlate:Ljava/lang/String;

    if-eq v1, v5, :cond_9

    if-ne v1, v4, :cond_6

    goto :goto_3

    :cond_6
    if-eq v1, v3, :cond_8

    if-ne v1, v2, :cond_7

    goto :goto_2

    :cond_7
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x7

    if-lt v1, v2, :cond_a

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x4e00

    if-lt v1, v2, :cond_a

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result p1

    const v0, 0x9fa5

    if-gt p1, v0, :cond_a

    goto :goto_4

    :cond_8
    :goto_2
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    const/16 v0, 0x8

    if-ne p1, v0, :cond_a

    goto :goto_4

    :cond_9
    :goto_3
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    const/16 v0, 0x9

    if-ne p1, v0, :cond_a

    :goto_4
    sget-object p1, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->VALID:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    :goto_5
    iput-object p1, p2, Lcom/rokid/aicore/api/engines/MotorLPREngine$ProcessedPlateResult;->status:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    goto :goto_6

    :cond_a
    sget-object p1, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->INVALID_RULE:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    goto :goto_5

    :goto_6
    return-object p2
.end method

.method private resolvedNanChangPlate(Ljava/lang/String;)Ljava/lang/String;
    .locals 8

    if-eqz p1, :cond_9

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_5

    :cond_0
    const-string v0, "\u8d63\u660c"

    const-string v1, "\u5357\u660c"

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_8

    aget-char v2, p1, v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    const/16 v3, 0x49

    const/16 v4, 0x31

    const/16 v5, 0x30

    const/16 v6, 0x4f

    const/4 v7, 0x1

    if-ne v1, v7, :cond_3

    if-ne v2, v5, :cond_2

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_4

    :cond_2
    if-ne v2, v4, :cond_5

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_4

    :cond_3
    if-eq v2, v6, :cond_7

    const/16 v6, 0x6f

    if-ne v2, v6, :cond_4

    goto :goto_3

    :cond_4
    if-eq v2, v3, :cond_6

    const/16 v3, 0x69

    if-ne v2, v3, :cond_5

    goto :goto_2

    :cond_5
    :goto_1
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_4

    :cond_6
    :goto_2
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_4

    :cond_7
    :goto_3
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    :goto_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_8
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :cond_9
    :goto_5
    return-object p1
.end method

.method private resolvedYuhangPlate(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    if-eqz p1, :cond_4

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    :cond_0
    sget-object v0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->YUHANG_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v1

    if-nez v1, :cond_1

    return-object p1

    :cond_1
    const/4 p1, 0x1

    invoke-virtual {v0, p1}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x4f59

    if-ne v1, v2, :cond_2

    const-string p1, "\u4f59\u676d"

    goto :goto_0

    :cond_2
    const/16 v2, 0x676d

    if-ne v1, v2, :cond_3

    const-string p1, "\u676d\u5dde"

    :cond_3
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :cond_4
    :goto_1
    return-object p1
.end method

.method private saveTestPlateBigPic(ZLcom/rokid/aicore/api/callback/result/LPRResult;Lcom/rokid/aicore/api/bean/ImageInput;)V
    .locals 6

    if-eqz p1, :cond_5

    :try_start_0
    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v0, ".jpg"

    const-string v1, "/"

    const/4 v2, 0x0

    if-eqz p2, :cond_2

    :try_start_1
    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateStatus()Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    move-result-object v3

    sget-object v4, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->EMPTY:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    if-ne v3, v4, :cond_0

    goto/16 :goto_1

    :cond_0
    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateStatus()Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;

    move-result-object v3

    sget-object v4, Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;->VALID:Lcom/rokid/aicore/api/callback/result/LPRResult$PlateStatus;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    const-string v5, "_"

    if-ne v3, v4, :cond_1

    :try_start_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v2}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, "/testMotorLPR"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getLabel()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getScore()F

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateCharScore()F

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateColorScore()F

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getColor()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    :goto_0
    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    goto/16 :goto_2

    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v2}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, "/testMotorLPRNotMatch"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getLabel()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getScore()F

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateCharScore()F

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateColorScore()F

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getColor()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    goto :goto_0

    :cond_2
    :goto_1
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v2}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "/testMotorLPRFailed"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {p2, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p2

    goto/16 :goto_0

    :goto_2
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p1

    if-nez p1, :cond_3

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    :cond_3
    new-instance p1, Ljava/io/File;

    invoke-direct {p1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_4

    invoke-virtual {p1}, Ljava/io/File;->createNewFile()Z

    :cond_4
    iget-object p1, p3, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    if-eqz p1, :cond_5

    iget v0, p3, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget v1, p3, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    new-instance v2, Landroid/graphics/Rect;

    iget v3, p3, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget p3, p3, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    const/4 v4, 0x0

    invoke-direct {v2, v4, v4, v3, p3}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-static {p1, p2, v0, v1, v2}, Lcom/rokid/aicore/utils/BitmapUtils;->nv21ToFile([BLjava/lang/String;IILandroid/graphics/Rect;)Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_3

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_5
    :goto_3
    return-void
.end method


# virtual methods
.method public AIEvent([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)V
    .locals 3

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->mLprCallback:Lcom/rokid/aicore/api/callback/LPRCallback;

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, p2}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->convertMotDetectResults([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)Ljava/util/ArrayList;

    move-result-object p1

    iget-wide v1, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-interface {v0, p1, v1, v2}, Lcom/rokid/aicore/api/callback/LPRCallback;->onLPREvent(Ljava/util/ArrayList;J)V

    :cond_0
    return-void
.end method

.method public AIEventBuffer([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/BufferImageInput;)V
    .locals 3

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->mLprCallback:Lcom/rokid/aicore/api/callback/LPRCallback;

    if-eqz v0, :cond_1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/bean/BufferImageInput;->toMetadataImageInput()Lcom/rokid/aicore/api/bean/ImageInput;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->convertMotDetectResults([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/aicore/api/callback/result/LPRResult;

    invoke-virtual {p2}, Lcom/rokid/aicore/api/bean/BufferImageInput;->borrowedView()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setDataBuffer(Ljava/nio/ByteBuffer;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->mLprCallback:Lcom/rokid/aicore/api/callback/LPRCallback;

    iget-wide v1, p2, Lcom/rokid/aicore/api/bean/BufferImageInput;->frame_id:J

    invoke-interface {v0, p1, v1, v2}, Lcom/rokid/aicore/api/callback/LPRCallback;->onLPREvent(Ljava/util/ArrayList;J)V

    :cond_1
    return-void
.end method

.method public initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->mLprMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-super {p0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I

    move-result p1

    return p1
.end method

.method public release()V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->mLprMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    const/4 v0, 0x0

    iput v0, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->widthThreshold:I

    iput v0, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->areaThreshold:I

    invoke-super {p0}, Lcom/rokid/aicore/api/engines/BaseEngine;->release()V

    return-void
.end method

.method public setExternalProcessCallback(Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->mExternalProcessCallback:Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;

    return-void
.end method

.method public setLPRCallback(Lcom/rokid/aicore/api/callback/LPRCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->mLprCallback:Lcom/rokid/aicore/api/callback/LPRCallback;

    return-void
.end method

.method public setMotorLPRRectThreshold(II)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->widthThreshold:I

    iput p2, p0, Lcom/rokid/aicore/api/engines/MotorLPREngine;->areaThreshold:I

    return-void
.end method
