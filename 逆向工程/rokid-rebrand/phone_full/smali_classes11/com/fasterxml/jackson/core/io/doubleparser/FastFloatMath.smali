.class Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;
.super Ljava/lang/Object;
.source "FastFloatMath.java"


# static fields
.field private static final FLOAT_EXPONENT_BIAS:I = 0x7f

.field private static final FLOAT_MAX_EXPONENT_POWER_OF_TEN:I = 0x26

.field private static final FLOAT_MAX_EXPONENT_POWER_OF_TWO:I = 0x7f

.field private static final FLOAT_MIN_EXPONENT_POWER_OF_TEN:I = -0x2d

.field private static final FLOAT_MIN_EXPONENT_POWER_OF_TWO:I = -0x7e

.field private static final FLOAT_POWER_OF_TEN:[F

.field private static final FLOAT_SIGNIFICAND_WIDTH:I = 0x18


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 41
    const/16 v0, 0xb

    new-array v0, v0, [F

    fill-array-data v0, :array_0

    sput-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;->FLOAT_POWER_OF_TEN:[F

    return-void

    :array_0
    .array-data 4
        0x3f800000    # 1.0f
        0x41200000    # 10.0f
        0x42c80000    # 100.0f
        0x447a0000    # 1000.0f
        0x461c4000    # 10000.0f
        0x47c35000    # 100000.0f
        0x49742400    # 1000000.0f
        0x4b189680    # 1.0E7f
        0x4cbebc20    # 1.0E8f
        0x4e6e6b28    # 1.0E9f
        0x501502f9    # 1.0E10f
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    return-void
.end method

.method static decFloatLiteralToFloat(ZJIZI)F
    .locals 3
    .param p0, "isNegative"    # Z
    .param p1, "significand"    # J
    .param p3, "exponent"    # I
    .param p4, "isSignificandTruncated"    # Z
    .param p5, "exponentOfTruncatedSignificand"    # I

    .line 54
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-nez v0, :cond_1

    .line 55
    if-eqz p0, :cond_0

    const/high16 v0, -0x80000000

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 59
    :cond_1
    const/16 v0, 0x26

    const/16 v1, -0x2d

    if-eqz p4, :cond_3

    .line 65
    if-gt v1, p5, :cond_2

    if-gt p5, v0, :cond_2

    .line 67
    invoke-static {p0, p1, p2, p5}, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;->tryDecToFloatWithFastAlgorithm(ZJI)F

    move-result v0

    .line 68
    .local v0, "withoutRounding":F
    const-wide/16 v1, 0x1

    add-long/2addr v1, p1

    invoke-static {p0, v1, v2, p5}, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;->tryDecToFloatWithFastAlgorithm(ZJI)F

    move-result v1

    .line 69
    .local v1, "roundedUp":F
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    move-result v2

    if-nez v2, :cond_2

    cmpl-float v2, v1, v0

    if-nez v2, :cond_2

    .line 70
    return v0

    .line 76
    .end local v0    # "withoutRounding":F
    .end local v1    # "roundedUp":F
    :cond_2
    const/high16 v0, 0x7fc00000    # Float.NaN

    .local v0, "result":F
    goto :goto_1

    .line 79
    .end local v0    # "result":F
    :cond_3
    if-gt v1, p3, :cond_4

    if-gt p3, v0, :cond_4

    .line 80
    invoke-static {p0, p1, p2, p3}, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;->tryDecToFloatWithFastAlgorithm(ZJI)F

    move-result v0

    .restart local v0    # "result":F
    goto :goto_1

    .line 82
    .end local v0    # "result":F
    :cond_4
    const/high16 v0, 0x7fc00000    # Float.NaN

    .line 84
    .restart local v0    # "result":F
    :goto_1
    return v0
.end method

.method static hexFloatLiteralToFloat(ZJIZI)F
    .locals 4
    .param p0, "isNegative"    # Z
    .param p1, "significand"    # J
    .param p3, "exponent"    # I
    .param p4, "isSignificandTruncated"    # Z
    .param p5, "exponentOfTruncatedSignificand"    # I

    .line 90
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-nez v0, :cond_1

    .line 91
    if-eqz p0, :cond_0

    const/high16 v0, -0x80000000

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 94
    :cond_1
    const/16 v0, 0x7f

    const/16 v1, -0x7e

    if-eqz p4, :cond_3

    .line 100
    if-gt v1, p5, :cond_2

    if-gt p5, v0, :cond_2

    .line 101
    invoke-static {p0, p1, p2, p5}, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;->tryHexToFloatWithFastAlgorithm(ZJI)F

    move-result v0

    .line 102
    .local v0, "withoutRounding":F
    const-wide/16 v1, 0x1

    add-long/2addr v1, p1

    invoke-static {p0, v1, v2, p5}, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;->tryHexToFloatWithFastAlgorithm(ZJI)F

    move-result v1

    .line 103
    .local v1, "roundedUp":F
    float-to-double v2, v0

    invoke-static {v2, v3}, Ljava/lang/Double;->isNaN(D)Z

    move-result v2

    if-nez v2, :cond_2

    cmpl-float v2, v1, v0

    if-nez v2, :cond_2

    .line 104
    return v0

    .line 109
    .end local v0    # "withoutRounding":F
    .end local v1    # "roundedUp":F
    :cond_2
    const/high16 v0, 0x7fc00000    # Float.NaN

    .local v0, "result":F
    goto :goto_1

    .line 111
    .end local v0    # "result":F
    :cond_3
    if-gt v1, p3, :cond_4

    if-gt p3, v0, :cond_4

    .line 112
    invoke-static {p0, p1, p2, p3}, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;->tryHexToFloatWithFastAlgorithm(ZJI)F

    move-result v0

    .restart local v0    # "result":F
    goto :goto_1

    .line 114
    .end local v0    # "result":F
    :cond_4
    const/high16 v0, 0x7fc00000    # Float.NaN

    .line 116
    .restart local v0    # "result":F
    :goto_1
    return v0
.end method

.method static tryDecToFloatWithFastAlgorithm(ZJI)F
    .locals 37
    .param p0, "isNegative"    # Z
    .param p1, "digits"    # J
    .param p3, "power"    # I

    .line 138
    move-wide/from16 v0, p1

    move/from16 v2, p3

    const/16 v3, -0xa

    if-gt v3, v2, :cond_2

    const/16 v3, 0xa

    if-gt v2, v3, :cond_2

    const-wide/32 v3, 0xffffff

    invoke-static {v0, v1, v3, v4}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray$$ExternalSyntheticBackport0;->m(JJ)I

    move-result v3

    if-gtz v3, :cond_2

    .line 141
    long-to-float v3, v0

    .line 149
    .local v3, "d":F
    if-gez v2, :cond_0

    .line 150
    sget-object v4, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;->FLOAT_POWER_OF_TEN:[F

    neg-int v5, v2

    aget v4, v4, v5

    div-float/2addr v3, v4

    goto :goto_0

    .line 152
    :cond_0
    sget-object v4, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;->FLOAT_POWER_OF_TEN:[F

    aget v4, v4, v2

    mul-float/2addr v3, v4

    .line 154
    :goto_0
    if-eqz p0, :cond_1

    neg-float v4, v3

    goto :goto_1

    :cond_1
    move v4, v3

    :goto_1
    return v4

    .line 167
    .end local v3    # "d":F
    :cond_2
    sget-object v3, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath;->MANTISSA_64:[J

    add-int/lit16 v4, v2, 0x145

    aget-wide v4, v3, v4

    .line 197
    .local v4, "factorMantissa":J
    const-wide/32 v6, 0x3526a

    int-to-long v8, v2

    mul-long/2addr v8, v6

    const/16 v3, 0x10

    shr-long v6, v8, v3

    const-wide/16 v8, 0x7f

    add-long/2addr v6, v8

    const-wide/16 v8, 0x40

    add-long/2addr v6, v8

    .line 199
    .local v6, "exponent":J
    invoke-static/range {p1 .. p2}, Ljava/lang/Long;->numberOfLeadingZeros(J)I

    move-result v3

    .line 200
    .local v3, "lz":I
    shl-long/2addr v0, v3

    .line 204
    .end local p1    # "digits":J
    .local v0, "digits":J
    invoke-static {v0, v1, v4, v5}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath;->fullMultiplication(JJ)Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;

    move-result-object v8

    .line 205
    .local v8, "product":Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;
    iget-wide v9, v8, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;->low:J

    .line 206
    .local v9, "lower":J
    iget-wide v11, v8, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;->high:J

    .line 221
    .local v11, "upper":J
    const-wide v13, 0x3fffffffffL

    and-long v15, v11, v13

    cmp-long v15, v15, v13

    const/high16 v16, 0x7fc00000    # Float.NaN

    const-wide/16 v17, 0x0

    const-wide/16 v19, 0x1

    if-nez v15, :cond_6

    add-long v13, v9, v0

    invoke-static {v13, v14, v9, v10}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray$$ExternalSyntheticBackport0;->m(JJ)I

    move-result v13

    if-gez v13, :cond_6

    .line 222
    sget-object v13, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath;->MANTISSA_128:[J

    add-int/lit16 v14, v2, 0x145

    aget-wide v14, v13, v14

    .line 226
    .local v14, "factor_mantissa_low":J
    invoke-static {v0, v1, v14, v15}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath;->fullMultiplication(JJ)Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;

    move-result-object v8

    .line 227
    move-wide/from16 v21, v4

    .end local v4    # "factorMantissa":J
    .local v21, "factorMantissa":J
    iget-wide v4, v8, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;->low:J

    .line 228
    .local v4, "product_low":J
    move-wide/from16 v23, v14

    .end local v14    # "factor_mantissa_low":J
    .local v23, "factor_mantissa_low":J
    iget-wide v13, v8, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;->high:J

    .line 229
    .local v13, "product_middle2":J
    move-wide/from16 v25, v9

    .line 230
    .local v25, "product_middle1":J
    move-wide/from16 v27, v11

    .line 231
    .local v27, "product_high":J
    move-wide/from16 v29, v9

    move-wide/from16 v35, v11

    move-object v12, v8

    move-wide/from16 v8, v25

    move-wide/from16 v25, v35

    .end local v9    # "lower":J
    .end local v11    # "upper":J
    .local v8, "product_middle1":J
    .local v12, "product":Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;
    .local v25, "upper":J
    .local v29, "lower":J
    add-long v10, v8, v13

    .line 232
    .local v10, "product_middle":J
    invoke-static {v10, v11, v8, v9}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray$$ExternalSyntheticBackport0;->m(JJ)I

    move-result v15

    if-gez v15, :cond_3

    .line 233
    add-long v27, v27, v19

    .line 239
    :cond_3
    add-long v31, v10, v19

    cmp-long v15, v31, v17

    if-nez v15, :cond_4

    const-wide v31, 0x7fffffffffL

    and-long v33, v27, v31

    cmp-long v15, v33, v31

    if-nez v15, :cond_4

    .line 240
    invoke-static {v0, v1, v4, v5}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray$$ExternalSyntheticBackport0;->m(JJ)I

    move-result v15

    move-wide/from16 v31, v0

    .end local v0    # "digits":J
    .local v31, "digits":J
    int-to-long v0, v15

    add-long/2addr v0, v4

    cmp-long v0, v0, v17

    if-gez v0, :cond_5

    .line 241
    return v16

    .line 239
    .end local v31    # "digits":J
    .restart local v0    # "digits":J
    :cond_4
    move-wide/from16 v31, v0

    .line 243
    .end local v0    # "digits":J
    .restart local v31    # "digits":J
    :cond_5
    move-wide/from16 v0, v27

    move-object v8, v12

    move-wide v11, v0

    .end local v25    # "upper":J
    .local v0, "upper":J
    goto :goto_2

    .line 221
    .end local v10    # "product_middle":J
    .end local v12    # "product":Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;
    .end local v13    # "product_middle2":J
    .end local v21    # "factorMantissa":J
    .end local v23    # "factor_mantissa_low":J
    .end local v27    # "product_high":J
    .end local v29    # "lower":J
    .end local v31    # "digits":J
    .local v0, "digits":J
    .local v4, "factorMantissa":J
    .local v8, "product":Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;
    .restart local v9    # "lower":J
    .restart local v11    # "upper":J
    :cond_6
    move-wide/from16 v31, v0

    move-wide/from16 v21, v4

    move-wide/from16 v29, v9

    move-wide/from16 v25, v11

    .line 249
    .end local v0    # "digits":J
    .end local v4    # "factorMantissa":J
    .end local v9    # "lower":J
    .end local v11    # "upper":J
    .restart local v21    # "factorMantissa":J
    .restart local v25    # "upper":J
    .restart local v29    # "lower":J
    .restart local v31    # "digits":J
    move-wide/from16 v11, v25

    .end local v25    # "upper":J
    .restart local v11    # "upper":J
    :goto_2
    const/16 v0, 0x3f

    ushr-long v0, v11, v0

    .line 250
    .local v0, "upperbit":J
    const-wide/16 v4, 0x26

    add-long/2addr v4, v0

    long-to-int v4, v4

    ushr-long v4, v11, v4

    .line 251
    .local v4, "mantissa":J
    xor-long v9, v0, v19

    long-to-int v9, v9

    add-int/2addr v3, v9

    .line 260
    const-wide v9, 0x3fffffffffL

    and-long v13, v11, v9

    cmp-long v13, v13, v9

    if-eqz v13, :cond_c

    and-long/2addr v9, v11

    cmp-long v9, v9, v17

    if-nez v9, :cond_7

    const-wide/16 v9, 0x3

    and-long/2addr v9, v4

    cmp-long v9, v9, v19

    if-nez v9, :cond_7

    goto :goto_4

    .line 282
    :cond_7
    add-long v4, v4, v19

    .line 283
    const/4 v9, 0x1

    ushr-long/2addr v4, v9

    .line 286
    const-wide/32 v9, 0x1000000

    cmp-long v9, v4, v9

    if-ltz v9, :cond_8

    .line 288
    const-wide/32 v4, 0x800000

    .line 289
    add-int/lit8 v3, v3, -0x1

    .line 292
    :cond_8
    const-wide/32 v9, -0x800001

    and-long/2addr v4, v9

    .line 295
    int-to-long v9, v3

    sub-long v9, v6, v9

    .line 297
    .local v9, "real_exponent":J
    cmp-long v13, v9, v19

    if-ltz v13, :cond_b

    const-wide/16 v13, 0xfe

    cmp-long v13, v9, v13

    if-lez v13, :cond_9

    goto :goto_3

    .line 301
    :cond_9
    const/16 v13, 0x17

    shl-long v13, v9, v13

    or-long/2addr v13, v4

    if-eqz p0, :cond_a

    const-wide v17, 0x80000000L

    :cond_a
    or-long v13, v13, v17

    long-to-int v13, v13

    .line 303
    .local v13, "bits":I
    invoke-static {v13}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v14

    return v14

    .line 298
    .end local v13    # "bits":I
    :cond_b
    :goto_3
    return v16

    .line 279
    .end local v9    # "real_exponent":J
    :cond_c
    :goto_4
    return v16
.end method

.method static tryHexToFloatWithFastAlgorithm(ZJI)F
    .locals 2
    .param p0, "isNegative"    # Z
    .param p1, "digits"    # J
    .param p3, "power"    # I

    .line 307
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-eqz v0, :cond_5

    const/16 v0, -0xb4

    if-ge p3, v0, :cond_0

    goto :goto_1

    .line 310
    :cond_0
    const/16 v0, 0x7f

    if-le p3, v0, :cond_2

    .line 311
    if-eqz p0, :cond_1

    const/high16 v0, -0x800000    # Float.NEGATIVE_INFINITY

    goto :goto_0

    :cond_1
    const/high16 v0, 0x7f800000    # Float.POSITIVE_INFINITY

    :goto_0
    return v0

    .line 318
    :cond_2
    const-wide v0, 0x1fffffffffffffL

    invoke-static {p1, p2, v0, v1}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray$$ExternalSyntheticBackport0;->m(JJ)I

    move-result v0

    if-gtz v0, :cond_4

    .line 321
    long-to-float v0, p1

    .line 330
    .local v0, "d":F
    const/high16 v1, 0x3f800000    # 1.0f

    invoke-static {v1, p3}, Ljava/lang/Math;->scalb(FI)F

    move-result v1

    mul-float/2addr v0, v1

    .line 331
    if-eqz p0, :cond_3

    .line 332
    neg-float v0, v0

    .line 334
    :cond_3
    return v0

    .line 338
    .end local v0    # "d":F
    :cond_4
    const/high16 v0, 0x7fc00000    # Float.NaN

    return v0

    .line 308
    :cond_5
    :goto_1
    if-eqz p0, :cond_6

    const/high16 v0, -0x80000000

    goto :goto_2

    :cond_6
    const/4 v0, 0x0

    :goto_2
    return v0
.end method
