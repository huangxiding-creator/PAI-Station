.class public Lcom/rokid/aicore/api/engines/LPREngine;
.super Lcom/rokid/aicore/api/engines/BaseEngine;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/aicore/api/engines/LPREngine$PlateType;
    }
.end annotation


# static fields
.field private static final BLACK:Ljava/lang/String; = "^(?:[\u4f7f\u9886][A-Z0-9]{5}|\u6e2f[A-Z0-9]{4}\u6e2f?|\u6fb3[A-Z0-9]{4}\u6fb3?)$"

.field private static final BLACK_PATTERN:Ljava/util/regex/Pattern;

.field private static final BLUE:Ljava/lang/String; = "^[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c][A-Z][A-Z0-9]{5}$"

.field private static final BLUE_PATTERN:Ljava/util/regex/Pattern;

.field private static final GREEN:Ljava/lang/String; = "^[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c][A-Z](?:[0-9A-Z]{5}[DF]|[A-K][0-9A-Z]{5})$"

.field private static final GREEN_PATTERN:Ljava/util/regex/Pattern;

.field private static final TEMP:Ljava/lang/String; = "^[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c][A-Z][A-Z0-9]{4}\u4e34$"

.field private static final TEMP_PATTERN:Ljava/util/regex/Pattern;

.field private static final WHITE:Ljava/lang/String; = "^(?:WJ[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c]?[0-9]{4}[A-Z0-9]|[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c][A-Z][0-9A-Z]{4}\u8b66|\u519b[A-Z][0-9]{5}|\u8bd5[A-Z0-9]{5}|\u4f7f[0-9]{5}|\u9886[0-9]{5})$"

.field private static final WHITE_PATTERN:Ljava/util/regex/Pattern;

.field private static final YELLOW:Ljava/lang/String; = "^[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c][A-Z][0-9A-Z]{4}(?:[\u6302\u5b66]|[0-9A-Z]{0,2})$"

.field private static final YELLOW_GREEN_PATTERN:Ljava/util/regex/Pattern;

.field private static final YELLOW_PATTERN:Ljava/util/regex/Pattern;


# instance fields
.field private areaThreshold:I

.field private mLprCallback:Lcom/rokid/aicore/api/callback/LPRCallback;

.field private mLprMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

.field private platCharGoodEnough:F

.field private widthThreshold:I


# direct methods
.method public static constructor <clinit>()V
    .locals 2

    const-string v0, "^[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c][A-Z][A-Z0-9]{5}$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->BLUE_PATTERN:Ljava/util/regex/Pattern;

    const-string v0, "^[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c][A-Z](?:[0-9A-Z]{5}[DF]|[A-K][0-9A-Z]{5})$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v1

    sput-object v1, Lcom/rokid/aicore/api/engines/LPREngine;->GREEN_PATTERN:Ljava/util/regex/Pattern;

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->YELLOW_GREEN_PATTERN:Ljava/util/regex/Pattern;

    const-string v0, "^[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c][A-Z][0-9A-Z]{4}(?:[\u6302\u5b66]|[0-9A-Z]{0,2})$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->YELLOW_PATTERN:Ljava/util/regex/Pattern;

    const-string v0, "^(?:WJ[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c]?[0-9]{4}[A-Z0-9]|[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c][A-Z][0-9A-Z]{4}\u8b66|\u519b[A-Z][0-9]{5}|\u8bd5[A-Z0-9]{5}|\u4f7f[0-9]{5}|\u9886[0-9]{5})$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->WHITE_PATTERN:Ljava/util/regex/Pattern;

    const-string v0, "^(?:[\u4f7f\u9886][A-Z0-9]{5}|\u6e2f[A-Z0-9]{4}\u6e2f?|\u6fb3[A-Z0-9]{4}\u6fb3?)$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->BLACK_PATTERN:Ljava/util/regex/Pattern;

    const-string v0, "^[\u4eac\u6d25\u6caa\u6e1d\u5180\u8c6b\u4e91\u8fbd\u9ed1\u6e58\u7696\u9c81\u65b0\u82cf\u6d59\u8d63\u9102\u6842\u7518\u664b\u8499\u9655\u5409\u95fd\u8d35\u7ca4\u9752\u85cf\u5ddd\u5b81\u743c][A-Z][A-Z0-9]{4}\u4e34$"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->TEMP_PATTERN:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    sget-object v0, Lcom/rokid/aicore/type/AIType;->LPR:Lcom/rokid/aicore/type/AIType;

    invoke-direct {p0, v0}, Lcom/rokid/aicore/api/engines/BaseEngine;-><init>(Lcom/rokid/aicore/type/AIType;)V

    const/4 v0, 0x0

    iput v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->widthThreshold:I

    iput v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->areaThreshold:I

    const v0, 0x3f59999a    # 0.85f

    iput v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->platCharGoodEnough:F

    return-void
.end method

.method public static checkPlate(Ljava/lang/String;Ljava/lang/String;)Lcom/rokid/aicore/api/engines/LPREngine$PlateType;
    .locals 7

    if-nez p0, :cond_0

    sget-object p0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->UNKNOWN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    return-object p0

    :cond_0
    sget-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->BLUE_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    const-string v1, "\u9ed1\u8272"

    const/4 v2, 0x7

    const-string v3, "\u767d\u8272"

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v2, :cond_2

    const-string v0, "\u84dd\u8272"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    sget-object p0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->BLUE:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    return-object p0

    :cond_2
    sget-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->GREEN_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    const-string v4, "\u7eff\u8272"

    const/16 v5, 0x8

    const-string v6, "\u9ec4\u8272"

    if-eqz v0, :cond_4

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v5, :cond_4

    invoke-virtual {p1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_3
    sget-object p0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->GREEN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    return-object p0

    :cond_4
    sget-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->YELLOW_GREEN_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v5, :cond_6

    invoke-virtual {p1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    const-string v0, "\u9ec4\u7eff\u8272"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    :cond_5
    sget-object p0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->YELLOW_GREEN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    return-object p0

    :cond_6
    sget-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->YELLOW_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-ne v0, v2, :cond_7

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    sget-object p0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->YELLOW:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    return-object p0

    :cond_7
    sget-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->WHITE_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-eqz v0, :cond_8

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    sget-object p0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->WHITE:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    return-object p0

    :cond_8
    sget-object v0, Lcom/rokid/aicore/api/engines/LPREngine;->BLACK_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-eqz v0, :cond_9

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_9

    sget-object p0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->BLACK:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    return-object p0

    :cond_9
    sget-object p1, Lcom/rokid/aicore/api/engines/LPREngine;->TEMP_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {p1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/regex/Matcher;->matches()Z

    move-result p1

    if-eqz p1, :cond_a

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p0

    if-ne p0, v2, :cond_a

    sget-object p0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->TEMP:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    return-object p0

    :cond_a
    sget-object p0, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->UNKNOWN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    return-object p0
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
            "Lcom/rokid/aicore/api/callback/result/LPRResult;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->mLprMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->isSaveTestData()Z

    move-result v0

    if-eqz p1, :cond_6

    array-length v1, p1

    if-gtz v1, :cond_0

    goto/16 :goto_4

    :cond_0
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    array-length v8, p1

    const/4 v1, 0x0

    move v9, v1

    :goto_0
    if-ge v9, v8, :cond_5

    aget-object v1, p1, v9

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->plateChars:Ljava/lang/String;

    invoke-direct {p0, v2}, Lcom/rokid/aicore/api/engines/LPREngine;->resolvedPlate(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->plateColor:Ljava/lang/String;

    invoke-static {v2, v3}, Lcom/rokid/aicore/api/engines/LPREngine;->checkPlate(Ljava/lang/String;Ljava/lang/String;)Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    move-result-object v4

    invoke-direct {p0, v1, p2}, Lcom/rokid/aicore/api/engines/LPREngine;->isRectMatch(Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)Z

    move-result v5

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_2

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_2

    sget-object v6, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->UNKNOWN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    if-eq v4, v6, :cond_2

    if-nez v5, :cond_1

    iget v5, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->recProb:F

    iget v6, p0, Lcom/rokid/aicore/api/engines/LPREngine;->platCharGoodEnough:F

    cmpl-float v5, v5, v6

    if-ltz v5, :cond_2

    :cond_1
    iget v5, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->prob:F

    invoke-virtual {p0}, Lcom/rokid/aicore/api/engines/BaseEngine;->getDetectScore()F

    move-result v6

    cmpl-float v5, v5, v6

    if-ltz v5, :cond_2

    new-instance v10, Lcom/rokid/aicore/api/callback/result/LPRResult;

    invoke-direct {v10}, Lcom/rokid/aicore/api/callback/result/LPRResult;-><init>()V

    iget-object v3, p2, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    invoke-virtual {v10, v3}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setData([B)V

    invoke-virtual {v10, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setLabel(Ljava/lang/String;)V

    invoke-direct {p0, v4}, Lcom/rokid/aicore/api/engines/LPREngine;->getPlateColor(Lcom/rokid/aicore/api/engines/LPREngine$PlateType;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v10, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setColor(Ljava/lang/String;)V

    iget-wide v2, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v10, v2, v3}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->setFrameId(J)V

    iget-wide v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->trackId:J

    invoke-virtual {v10, v2, v3}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->setTrackId(J)V

    iget v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->prob:F

    invoke-virtual {v10, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setScore(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    invoke-virtual {v10, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX1(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    invoke-virtual {v10, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY1(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    invoke-virtual {v10, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX2(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    invoke-virtual {v10, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY2(F)V

    iget v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->recProb:F

    invoke-virtual {v10, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateCharScore(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->recProbs:[F

    invoke-virtual {v10, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateCharScores([F)V

    iget v1, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->colorProb:F

    invoke-virtual {v10, v1}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateColorScore(F)V

    sget-object v1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "LPRResult: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v10}, Lcom/rokid/aicore/api/callback/result/LPRResult;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    const/4 v5, 0x1

    const/4 v6, 0x1

    move-object v1, p0

    move v2, v0

    move-object v3, v10

    move-object v4, p2

    invoke-direct/range {v1 .. v6}, Lcom/rokid/aicore/api/engines/LPREngine;->saveTestPlateBigPic(ZLcom/rokid/aicore/api/callback/result/LPRResult;Lcom/rokid/aicore/api/bean/ImageInput;ZZ)V

    invoke-virtual {v7, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_3

    :cond_2
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_3

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_3

    sget-object v5, Lcom/rokid/aicore/api/engines/LPREngine$PlateType;->UNKNOWN:Lcom/rokid/aicore/api/engines/LPREngine$PlateType;

    if-eq v4, v5, :cond_3

    new-instance v4, Lcom/rokid/aicore/api/callback/result/LPRResult;

    invoke-direct {v4}, Lcom/rokid/aicore/api/callback/result/LPRResult;-><init>()V

    iget-object v5, p2, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    invoke-virtual {v4, v5}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setData([B)V

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setLabel(Ljava/lang/String;)V

    invoke-virtual {v4, v3}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setColor(Ljava/lang/String;)V

    iget-wide v2, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v4, v2, v3}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->setFrameId(J)V

    iget-wide v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->trackId:J

    invoke-virtual {v4, v2, v3}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->setTrackId(J)V

    iget v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->prob:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setScore(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX1(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY1(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX2(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY2(F)V

    iget v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->recProb:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateCharScore(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->recProbs:[F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateCharScores([F)V

    iget v1, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->colorProb:F

    invoke-virtual {v4, v1}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateColorScore(F)V

    sget-object v1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "LPRResult Not Match Rect Threshold : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v4}, Lcom/rokid/aicore/api/callback/result/LPRResult;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    const/4 v5, 0x1

    goto :goto_1

    :cond_3
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_4

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_4

    new-instance v4, Lcom/rokid/aicore/api/callback/result/LPRResult;

    invoke-direct {v4}, Lcom/rokid/aicore/api/callback/result/LPRResult;-><init>()V

    iget-object v5, p2, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    invoke-virtual {v4, v5}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setData([B)V

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setLabel(Ljava/lang/String;)V

    invoke-virtual {v4, v3}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setColor(Ljava/lang/String;)V

    iget-wide v2, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v4, v2, v3}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->setFrameId(J)V

    iget-wide v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->trackId:J

    invoke-virtual {v4, v2, v3}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->setTrackId(J)V

    iget v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->prob:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setScore(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x1:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX1(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y1:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY1(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->x2:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setX2(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->rect:Lcom/rokid/aicore/ncnn/bean/MotBBox;

    iget v2, v2, Lcom/rokid/aicore/ncnn/bean/MotBBox;->y2:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->setY2(F)V

    iget v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->recProb:F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateCharScore(F)V

    iget-object v2, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->recProbs:[F

    invoke-virtual {v4, v2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateCharScores([F)V

    iget v1, v1, Lcom/rokid/aicore/ncnn/bean/MotDetection;->colorProb:F

    invoke-virtual {v4, v1}, Lcom/rokid/aicore/api/callback/result/LPRResult;->setPlateColorScore(F)V

    sget-object v1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "LPRResult Not Match Plate Rule : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v4}, Lcom/rokid/aicore/api/callback/result/LPRResult;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    const/4 v5, 0x0

    :goto_1
    const/4 v6, 0x0

    move-object v1, p0

    move v2, v0

    move-object v3, v4

    goto :goto_2

    :cond_4
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v3, 0x0

    move-object v1, p0

    move v2, v0

    :goto_2
    move-object v4, p2

    invoke-direct/range {v1 .. v6}, Lcom/rokid/aicore/api/engines/LPREngine;->saveTestPlateBigPic(ZLcom/rokid/aicore/api/callback/result/LPRResult;Lcom/rokid/aicore/api/bean/ImageInput;ZZ)V

    :goto_3
    add-int/lit8 v9, v9, 0x1

    goto/16 :goto_0

    :cond_5
    return-object v7

    :cond_6
    :goto_4
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v3, 0x0

    move-object v1, p0

    move v2, v0

    move-object v4, p2

    invoke-direct/range {v1 .. v6}, Lcom/rokid/aicore/api/engines/LPREngine;->saveTestPlateBigPic(ZLcom/rokid/aicore/api/callback/result/LPRResult;Lcom/rokid/aicore/api/bean/ImageInput;ZZ)V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    return-object p1
.end method

.method private getPlateColor(Lcom/rokid/aicore/api/engines/LPREngine$PlateType;)Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/rokid/aicore/api/engines/LPREngine$1;->$SwitchMap$com$rokid$aicore$api$engines$LPREngine$PlateType:[I

    invoke-virtual {p1}, Ljava/lang/Enum;->ordinal()I

    move-result p1

    aget p1, v0, p1

    packed-switch p1, :pswitch_data_0

    const-string p1, "\u672a\u77e5"

    return-object p1

    :pswitch_0
    const-string p1, "\u4e34\u724c"

    return-object p1

    :pswitch_1
    const-string p1, "\u9ed1\u8272"

    return-object p1

    :pswitch_2
    const-string p1, "\u767d\u8272"

    return-object p1

    :pswitch_3
    const-string p1, "\u9ec4\u8272"

    return-object p1

    :pswitch_4
    const-string p1, "\u9ec4\u7eff\u8272"

    return-object p1

    :pswitch_5
    const-string p1, "\u7eff\u8272"

    return-object p1

    :pswitch_6
    const-string p1, "\u84dd\u8272"

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
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

    iget v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->widthThreshold:I

    if-gt p2, v0, :cond_1

    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    move-result p2

    invoke-virtual {p1}, Landroid/graphics/Rect;->height()I

    move-result p1

    mul-int/2addr p2, p1

    iget p1, p0, Lcom/rokid/aicore/api/engines/LPREngine;->areaThreshold:I

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

.method private resolvedPlate(Ljava/lang/String;)Ljava/lang/String;
    .locals 8

    if-eqz p1, :cond_9

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_5

    :cond_0
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

.method private saveTestPlateBigPic(ZLcom/rokid/aicore/api/callback/result/LPRResult;Lcom/rokid/aicore/api/bean/ImageInput;ZZ)V
    .locals 7

    if-eqz p1, :cond_5

    :try_start_0
    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "/testLPR"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v2, ".jpg"

    const-string v3, "/"

    const-string v4, "_"

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

    const-string p2, "/testLPRFailed"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p4

    invoke-virtual {p1, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-wide p4, p3, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {p1, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    :goto_0
    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    goto/16 :goto_1

    :cond_0
    if-eqz p4, :cond_1

    if-eqz p5, :cond_1

    new-instance p1, Landroid/graphics/RectF;

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getX1()F

    move-result p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getY1()F

    move-result p5

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getX2()F

    move-result v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getY2()F

    move-result v5

    invoke-direct {p1, p4, p5, v1, v5}, Landroid/graphics/RectF;-><init>(FFFF)V

    iget p4, p3, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget p5, p3, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    invoke-static {p1, p4, p5}, Lcom/rokid/aicore/api/engines/LPREngine;->toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;

    move-result-object p1

    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-virtual {p4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->getFrameId()J

    move-result-wide v5

    invoke-virtual {p4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->getTrackId()J

    move-result-wide v5

    invoke-virtual {p4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getLabel()Ljava/lang/String;

    move-result-object p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getScore()F

    move-result p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateCharScore()F

    move-result p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateColorScore()F

    move-result p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p5, p1, Landroid/graphics/Rect;->left:I

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p5, p1, Landroid/graphics/Rect;->top:I

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p5, p1, Landroid/graphics/Rect;->right:I

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p1, p1, Landroid/graphics/Rect;->bottom:I

    invoke-virtual {p4, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getColor()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    goto/16 :goto_0

    :cond_1
    if-eqz p4, :cond_2

    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p4, "/testLPRRectNotMatch"

    invoke-virtual {p1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance p1, Landroid/graphics/RectF;

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getX1()F

    move-result p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getY1()F

    move-result p5

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getX2()F

    move-result v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getY2()F

    move-result v5

    invoke-direct {p1, p4, p5, v1, v5}, Landroid/graphics/RectF;-><init>(FFFF)V

    iget p4, p3, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget p5, p3, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    invoke-static {p1, p4, p5}, Lcom/rokid/aicore/api/engines/LPREngine;->toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;

    move-result-object p1

    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-virtual {p4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->getFrameId()J

    move-result-wide v5

    invoke-virtual {p4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->getTrackId()J

    move-result-wide v5

    invoke-virtual {p4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getLabel()Ljava/lang/String;

    move-result-object p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getScore()F

    move-result p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateCharScore()F

    move-result p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateColorScore()F

    move-result p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p5, p1, Landroid/graphics/Rect;->left:I

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p5, p1, Landroid/graphics/Rect;->top:I

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p5, p1, Landroid/graphics/Rect;->right:I

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p1, p1, Landroid/graphics/Rect;->bottom:I

    invoke-virtual {p4, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getColor()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    goto/16 :goto_0

    :cond_2
    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v1}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p4, "/testLPRNotMatch"

    invoke-virtual {p1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance p1, Landroid/graphics/RectF;

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getX1()F

    move-result p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getY1()F

    move-result p5

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getX2()F

    move-result v1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseBoundResult;->getY2()F

    move-result v5

    invoke-direct {p1, p4, p5, v1, v5}, Landroid/graphics/RectF;-><init>(FFFF)V

    iget p4, p3, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget p5, p3, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    invoke-static {p1, p4, p5}, Lcom/rokid/aicore/api/engines/LPREngine;->toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;

    move-result-object p1

    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-virtual {p4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->getFrameId()J

    move-result-wide v5

    invoke-virtual {p4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/base/BaseResult;->getTrackId()J

    move-result-wide v5

    invoke-virtual {p4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getLabel()Ljava/lang/String;

    move-result-object p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getScore()F

    move-result p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateCharScore()F

    move-result p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getPlateColorScore()F

    move-result p5

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p5, p1, Landroid/graphics/Rect;->left:I

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p5, p1, Landroid/graphics/Rect;->top:I

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p5, p1, Landroid/graphics/Rect;->right:I

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p4

    invoke-virtual {p4, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p4

    iget p1, p1, Landroid/graphics/Rect;->bottom:I

    invoke-virtual {p4, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getColor()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    goto/16 :goto_0

    :goto_1
    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/io/File;

    invoke-direct {p2, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Ljava/io/File;->exists()Z

    move-result p4

    if-nez p4, :cond_3

    invoke-virtual {p2}, Ljava/io/File;->mkdirs()Z

    :cond_3
    new-instance p2, Ljava/io/File;

    invoke-direct {p2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Ljava/io/File;->exists()Z

    move-result p4

    if-nez p4, :cond_4

    invoke-virtual {p2}, Ljava/io/File;->createNewFile()Z

    :cond_4
    iget-object p2, p3, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    if-eqz p2, :cond_5

    iget p4, p3, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget p5, p3, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    new-instance v0, Landroid/graphics/Rect;

    iget v1, p3, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget p3, p3, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    const/4 v2, 0x0

    invoke-direct {v0, v2, v2, v1, p3}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-static {p2, p1, p4, p5, v0}, Lcom/rokid/aicore/utils/BitmapUtils;->nv21ToFile([BLjava/lang/String;IILandroid/graphics/Rect;)Ljava/lang/String;
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

.method public static toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;
    .locals 4

    new-instance v0, Landroid/graphics/Rect;

    int-to-float p1, p1

    iget v1, p0, Landroid/graphics/RectF;->left:F

    mul-float/2addr v1, p1

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    int-to-float p2, p2

    iget v2, p0, Landroid/graphics/RectF;->top:F

    mul-float/2addr v2, p2

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    iget v3, p0, Landroid/graphics/RectF;->right:F

    mul-float/2addr p1, v3

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    iget p0, p0, Landroid/graphics/RectF;->bottom:F

    mul-float/2addr p2, p0

    invoke-static {p2}, Ljava/lang/Math;->round(F)I

    move-result p0

    invoke-direct {v0, v1, v2, p1, p0}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v0
.end method


# virtual methods
.method public AIEvent([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)V
    .locals 3

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->mLprCallback:Lcom/rokid/aicore/api/callback/LPRCallback;

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, p2}, Lcom/rokid/aicore/api/engines/LPREngine;->convertMotDetectResults([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)Ljava/util/ArrayList;

    move-result-object p1

    iget-wide v1, p2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-interface {v0, p1, v1, v2}, Lcom/rokid/aicore/api/callback/LPRCallback;->onLPREvent(Ljava/util/ArrayList;J)V

    :cond_0
    return-void
.end method

.method public AIEventBuffer([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/BufferImageInput;)V
    .locals 3

    iget-object v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->mLprCallback:Lcom/rokid/aicore/api/callback/LPRCallback;

    if-eqz v0, :cond_1

    invoke-virtual {p2}, Lcom/rokid/aicore/api/bean/BufferImageInput;->toMetadataImageInput()Lcom/rokid/aicore/api/bean/ImageInput;

    move-result-object v0

    invoke-direct {p0, p1, v0}, Lcom/rokid/aicore/api/engines/LPREngine;->convertMotDetectResults([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)Ljava/util/ArrayList;

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
    iget-object v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->mLprCallback:Lcom/rokid/aicore/api/callback/LPRCallback;

    iget-wide v1, p2, Lcom/rokid/aicore/api/bean/BufferImageInput;->frame_id:J

    invoke-interface {v0, p1, v1, v2}, Lcom/rokid/aicore/api/callback/LPRCallback;->onLPREvent(Ljava/util/ArrayList;J)V

    :cond_1
    return-void
.end method

.method public initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/engines/LPREngine;->mLprMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    invoke-super {p0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I

    move-result p1

    return p1
.end method

.method public release()V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->mLprMotConfig:Lcom/rokid/aicore/ncnn/bean/MotConfig;

    const v0, 0x3f59999a    # 0.85f

    iput v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->platCharGoodEnough:F

    const/4 v0, 0x0

    iput v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->widthThreshold:I

    iput v0, p0, Lcom/rokid/aicore/api/engines/LPREngine;->areaThreshold:I

    invoke-super {p0}, Lcom/rokid/aicore/api/engines/BaseEngine;->release()V

    return-void
.end method

.method public setLPRCallback(Lcom/rokid/aicore/api/callback/LPRCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/engines/LPREngine;->mLprCallback:Lcom/rokid/aicore/api/callback/LPRCallback;

    return-void
.end method

.method public setLPRRectThreshold(II)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/engines/LPREngine;->widthThreshold:I

    iput p2, p0, Lcom/rokid/aicore/api/engines/LPREngine;->areaThreshold:I

    return-void
.end method

.method public setPlatCharGoodEnough(F)V
    .locals 0

    iput p1, p0, Lcom/rokid/aicore/api/engines/LPREngine;->platCharGoodEnough:F

    return-void
.end method
