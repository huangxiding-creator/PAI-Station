.class abstract Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;
.super Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;
.source "AbstractFloatingPointBitsFromCharSequence.java"


# direct methods
.method constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;-><init>()V

    return-void
.end method

.method private isDigit(C)Z
    .locals 1
    .param p1, "c"    # C

    .line 26
    const/16 v0, 0x30

    if-gt v0, p1, :cond_0

    const/16 v0, 0x39

    if-gt p1, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private parseDecFloatLiteral(Ljava/lang/CharSequence;IIIZZ)J
    .locals 28
    .param p1, "str"    # Ljava/lang/CharSequence;
    .param p2, "index"    # I
    .param p3, "startIndex"    # I
    .param p4, "endIndex"    # I
    .param p5, "isNegative"    # Z
    .param p6, "hasLeadingZero"    # Z

    .line 56
    move-object/from16 v10, p0

    move-object/from16 v11, p1

    move/from16 v12, p4

    const-wide/16 v0, 0x0

    .line 57
    .local v0, "significand":J
    move/from16 v13, p2

    .line 58
    .local v13, "significandStartIndex":I
    const/4 v2, -0x1

    .line 59
    .local v2, "virtualIndexOfPoint":I
    const/4 v3, 0x0

    .line 60
    .local v3, "illegal":Z
    const/4 v4, 0x0

    move v5, v4

    move v4, v3

    move v3, v2

    move-wide v1, v0

    move/from16 v0, p2

    .line 61
    .end local v2    # "virtualIndexOfPoint":I
    .end local p2    # "index":I
    .local v0, "index":I
    .local v1, "significand":J
    .local v3, "virtualIndexOfPoint":I
    .local v4, "illegal":Z
    .local v5, "ch":C
    :goto_0
    const-wide/16 v6, 0x30

    const-wide/16 v8, 0xa

    const/16 v14, 0x2e

    const/16 v16, 0x1

    if-ge v0, v12, :cond_4

    .line 62
    invoke-interface {v11, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    .line 63
    invoke-direct {v10, v5}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->isDigit(C)Z

    move-result v17

    if-eqz v17, :cond_0

    .line 65
    mul-long/2addr v8, v1

    int-to-long v14, v5

    add-long/2addr v8, v14

    sub-long/2addr v8, v6

    move-wide v1, v8

    .end local v1    # "significand":J
    .local v8, "significand":J
    goto :goto_3

    .line 66
    .end local v8    # "significand":J
    .restart local v1    # "significand":J
    :cond_0
    if-ne v5, v14, :cond_4

    .line 67
    if-ltz v3, :cond_1

    move/from16 v15, v16

    goto :goto_1

    :cond_1
    const/4 v15, 0x0

    :goto_1
    or-int/2addr v4, v15

    .line 68
    move v3, v0

    .line 69
    :goto_2
    add-int/lit8 v6, v12, -0x8

    if-ge v0, v6, :cond_3

    .line 70
    add-int/lit8 v6, v0, 0x1

    invoke-direct {v10, v11, v6}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->tryToParseEightDigits(Ljava/lang/CharSequence;I)I

    move-result v6

    .line 71
    .local v6, "eightDigits":I
    if-gez v6, :cond_2

    .line 72
    goto :goto_3

    .line 75
    :cond_2
    const-wide/32 v7, 0x5f5e100

    mul-long/2addr v7, v1

    int-to-long v14, v6

    add-long v1, v7, v14

    .line 69
    .end local v6    # "eightDigits":I
    add-int/lit8 v0, v0, 0x8

    goto :goto_2

    .line 61
    :cond_3
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 82
    :cond_4
    move/from16 p2, v0

    .line 84
    .local p2, "significandEndIndex":I
    if-gez v3, :cond_5

    .line 85
    move/from16 v15, p2

    .end local p2    # "significandEndIndex":I
    .local v15, "significandEndIndex":I
    sub-int v18, v15, v13

    .line 86
    .local v18, "digitCount":I
    move v3, v15

    .line 87
    const/16 v19, 0x0

    move/from16 v27, v18

    move/from16 v18, v3

    move/from16 v3, v27

    .local v19, "exponent":I
    goto :goto_4

    .line 89
    .end local v15    # "significandEndIndex":I
    .end local v18    # "digitCount":I
    .end local v19    # "exponent":I
    .restart local p2    # "significandEndIndex":I
    :cond_5
    move/from16 v15, p2

    .end local p2    # "significandEndIndex":I
    .restart local v15    # "significandEndIndex":I
    sub-int v18, v15, v13

    add-int/lit8 v18, v18, -0x1

    .line 90
    .restart local v18    # "digitCount":I
    sub-int v19, v3, v15

    add-int/lit8 v19, v19, 0x1

    move/from16 v27, v18

    move/from16 v18, v3

    move/from16 v3, v27

    .line 95
    .local v3, "digitCount":I
    .local v18, "virtualIndexOfPoint":I
    .restart local v19    # "exponent":I
    :goto_4
    const/16 v20, 0x0

    .line 96
    .local v20, "expNumber":I
    const/16 v6, 0x65

    if-eq v5, v6, :cond_7

    const/16 v6, 0x45

    if-ne v5, v6, :cond_6

    goto :goto_5

    :cond_6
    move/from16 v25, v20

    move/from16 v20, v19

    move/from16 v19, v4

    goto :goto_c

    .line 97
    :cond_7
    :goto_5
    add-int/lit8 v0, v0, 0x1

    if-ge v0, v12, :cond_8

    invoke-interface {v11, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v6

    goto :goto_6

    :cond_8
    const/4 v6, 0x0

    :goto_6
    move v5, v6

    .line 98
    const/16 v6, 0x2d

    if-ne v5, v6, :cond_9

    move/from16 v6, v16

    goto :goto_7

    :cond_9
    const/4 v6, 0x0

    .line 99
    .local v6, "neg_exp":Z
    :goto_7
    if-nez v6, :cond_a

    const/16 v7, 0x2b

    if-ne v5, v7, :cond_c

    .line 100
    :cond_a
    add-int/lit8 v0, v0, 0x1

    if-ge v0, v12, :cond_b

    invoke-interface {v11, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v7

    goto :goto_8

    :cond_b
    const/4 v7, 0x0

    :goto_8
    move v5, v7

    .line 102
    :cond_c
    invoke-direct {v10, v5}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->isDigit(C)Z

    move-result v7

    xor-int/lit8 v7, v7, 0x1

    or-int/2addr v4, v7

    move/from16 v7, v20

    .line 105
    .end local v20    # "expNumber":I
    .local v7, "expNumber":I
    :goto_9
    const/16 v8, 0x400

    if-ge v7, v8, :cond_d

    .line 106
    mul-int/lit8 v8, v7, 0xa

    add-int/2addr v8, v5

    add-int/lit8 v8, v8, -0x30

    move v7, v8

    .line 108
    :cond_d
    add-int/lit8 v0, v0, 0x1

    if-ge v0, v12, :cond_e

    invoke-interface {v11, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v8

    goto :goto_a

    :cond_e
    const/4 v8, 0x0

    :goto_a
    move v5, v8

    .line 109
    invoke-direct {v10, v5}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->isDigit(C)Z

    move-result v8

    if-nez v8, :cond_18

    .line 110
    if-eqz v6, :cond_f

    .line 111
    neg-int v7, v7

    move/from16 v20, v7

    goto :goto_b

    .line 110
    :cond_f
    move/from16 v20, v7

    .line 113
    .end local v7    # "expNumber":I
    .restart local v20    # "expNumber":I
    :goto_b
    add-int v19, v19, v20

    move/from16 v25, v20

    move/from16 v20, v19

    move/from16 v19, v4

    .line 118
    .end local v4    # "illegal":Z
    .end local v6    # "neg_exp":Z
    .local v19, "illegal":Z
    .local v20, "exponent":I
    .local v25, "expNumber":I
    :goto_c
    if-ge v0, v12, :cond_11

    const/16 v4, 0x64

    if-eq v5, v4, :cond_10

    const/16 v4, 0x44

    if-eq v5, v4, :cond_10

    const/16 v4, 0x66

    if-eq v5, v4, :cond_10

    const/16 v4, 0x46

    if-ne v5, v4, :cond_11

    .line 119
    :cond_10
    add-int/lit8 v0, v0, 0x1

    .line 124
    :cond_11
    invoke-direct {v10, v11, v0, v12}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->skipWhitespace(Ljava/lang/CharSequence;II)I

    move-result v0

    .line 125
    if-nez v19, :cond_17

    if-lt v0, v12, :cond_17

    if-nez p6, :cond_12

    if-nez v3, :cond_12

    move/from16 v26, v3

    goto/16 :goto_11

    .line 133
    :cond_12
    const/4 v4, 0x0

    .line 135
    .local v4, "skipCountInTruncatedDigits":I
    const/16 v6, 0x13

    if-le v3, v6, :cond_16

    .line 136
    const-wide/16 v1, 0x0

    .line 137
    move v0, v13

    :goto_d
    if-ge v0, v15, :cond_14

    .line 138
    invoke-interface {v11, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    .line 139
    if-ne v5, v14, :cond_13

    .line 140
    add-int/lit8 v4, v4, 0x1

    const-wide/16 v8, 0x30

    goto :goto_e

    .line 142
    :cond_13
    const-wide v6, 0xde0b6b3a7640000L

    invoke-static {v1, v2, v6, v7}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray$$ExternalSyntheticBackport0;->m(JJ)I

    move-result v6

    if-gez v6, :cond_14

    .line 143
    const-wide/16 v8, 0xa

    mul-long v6, v1, v8

    int-to-long v8, v5

    add-long/2addr v6, v8

    const-wide/16 v8, 0x30

    sub-long v1, v6, v8

    .line 137
    :goto_e
    add-int/lit8 v0, v0, 0x1

    goto :goto_d

    .line 149
    :cond_14
    if-ge v0, v15, :cond_15

    goto :goto_f

    :cond_15
    const/16 v16, 0x0

    :goto_f
    move/from16 v6, v16

    .line 150
    .local v6, "isSignificandTruncated":Z
    sub-int v7, v18, v0

    add-int/2addr v7, v4

    add-int v7, v7, v25

    move v14, v0

    move-wide/from16 v16, v1

    move/from16 v21, v4

    move/from16 v22, v5

    move/from16 v23, v6

    move/from16 v24, v7

    .local v7, "exponentOfTruncatedSignificand":I
    goto :goto_10

    .line 152
    .end local v6    # "isSignificandTruncated":Z
    .end local v7    # "exponentOfTruncatedSignificand":I
    :cond_16
    const/4 v6, 0x0

    .line 153
    .restart local v6    # "isSignificandTruncated":Z
    const/4 v7, 0x0

    move v14, v0

    move-wide/from16 v16, v1

    move/from16 v21, v4

    move/from16 v22, v5

    move/from16 v23, v6

    move/from16 v24, v7

    .line 155
    .end local v0    # "index":I
    .end local v1    # "significand":J
    .end local v4    # "skipCountInTruncatedDigits":I
    .end local v5    # "ch":C
    .end local v6    # "isSignificandTruncated":Z
    .local v14, "index":I
    .local v16, "significand":J
    .local v21, "skipCountInTruncatedDigits":I
    .local v22, "ch":C
    .local v23, "isSignificandTruncated":Z
    .local v24, "exponentOfTruncatedSignificand":I
    :goto_10
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p3

    move/from16 v26, v3

    .end local v3    # "digitCount":I
    .local v26, "digitCount":I
    move/from16 v3, p4

    move/from16 v4, p5

    move-wide/from16 v5, v16

    move/from16 v7, v20

    move/from16 v8, v23

    move/from16 v9, v24

    invoke-virtual/range {v0 .. v9}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->valueOfFloatLiteral(Ljava/lang/CharSequence;IIZJIZI)J

    move-result-wide v0

    return-wide v0

    .line 125
    .end local v14    # "index":I
    .end local v16    # "significand":J
    .end local v21    # "skipCountInTruncatedDigits":I
    .end local v22    # "ch":C
    .end local v23    # "isSignificandTruncated":Z
    .end local v24    # "exponentOfTruncatedSignificand":I
    .end local v26    # "digitCount":I
    .restart local v0    # "index":I
    .restart local v1    # "significand":J
    .restart local v3    # "digitCount":I
    .restart local v5    # "ch":C
    :cond_17
    move/from16 v26, v3

    .line 127
    .end local v3    # "digitCount":I
    .restart local v26    # "digitCount":I
    :goto_11
    const-wide/16 v3, -0x1

    return-wide v3

    .line 109
    .end local v20    # "exponent":I
    .end local v25    # "expNumber":I
    .end local v26    # "digitCount":I
    .restart local v3    # "digitCount":I
    .local v4, "illegal":Z
    .local v6, "neg_exp":Z
    .local v7, "expNumber":I
    .local v19, "exponent":I
    :cond_18
    move/from16 v26, v3

    const-wide/16 v8, 0x30

    .end local v3    # "digitCount":I
    .restart local v26    # "digitCount":I
    const-wide/16 v8, 0xa

    goto/16 :goto_9
.end method

.method private parseHexFloatLiteral(Ljava/lang/CharSequence;IIIZ)J
    .locals 29
    .param p1, "str"    # Ljava/lang/CharSequence;
    .param p2, "index"    # I
    .param p3, "startIndex"    # I
    .param p4, "endIndex"    # I
    .param p5, "isNegative"    # Z

    .line 257
    move-object/from16 v10, p0

    move-object/from16 v11, p1

    move/from16 v12, p4

    const-wide/16 v0, 0x0

    .line 258
    .local v0, "significand":J
    const/4 v2, 0x0

    .line 259
    .local v2, "exponent":I
    move/from16 v13, p2

    .line 260
    .local v13, "significandStartIndex":I
    const/4 v3, -0x1

    .line 262
    .local v3, "virtualIndexOfPoint":I
    const/4 v4, 0x0

    .line 263
    .local v4, "illegal":Z
    const/4 v5, 0x0

    move v6, v5

    move v5, v4

    move-wide/from16 v27, v0

    move/from16 v0, p2

    move v1, v3

    move-wide/from16 v3, v27

    .line 264
    .end local v4    # "illegal":Z
    .end local p2    # "index":I
    .local v0, "index":I
    .local v1, "virtualIndexOfPoint":I
    .local v3, "significand":J
    .local v5, "illegal":Z
    .local v6, "ch":C
    :goto_0
    const/16 v8, 0x7f

    const/4 v9, 0x4

    const/4 v15, 0x1

    if-ge v0, v12, :cond_3

    .line 265
    invoke-interface {v11, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v6

    .line 267
    if-le v6, v8, :cond_0

    const/16 v16, -0x1

    goto :goto_1

    :cond_0
    sget-object v16, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;->CHAR_TO_HEX_MAP:[B

    aget-byte v16, v16, v6

    :goto_1
    move/from16 p2, v16

    .line 268
    .local p2, "hexValue":I
    move/from16 v7, p2

    .end local p2    # "hexValue":I
    .local v7, "hexValue":I
    if-ltz v7, :cond_1

    .line 269
    shl-long v8, v3, v9

    int-to-long v14, v7

    or-long v3, v8, v14

    goto :goto_3

    .line 270
    :cond_1
    const/4 v14, -0x4

    if-ne v7, v14, :cond_3

    .line 271
    if-ltz v1, :cond_2

    move v14, v15

    goto :goto_2

    :cond_2
    const/4 v14, 0x0

    :goto_2
    or-int/2addr v5, v14

    .line 272
    move v1, v0

    .line 264
    .end local v7    # "hexValue":I
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 288
    :cond_3
    move v14, v0

    .line 289
    .local v14, "significandEndIndex":I
    const/16 v7, 0x400

    if-gez v1, :cond_4

    .line 290
    sub-int v17, v14, v13

    .line 291
    .local v17, "digitCount":I
    move v1, v14

    move/from16 v8, v17

    move/from16 v17, v1

    goto :goto_4

    .line 293
    .end local v17    # "digitCount":I
    :cond_4
    sub-int v17, v14, v13

    add-int/lit8 v17, v17, -0x1

    .line 294
    .restart local v17    # "digitCount":I
    sub-int v18, v1, v0

    add-int/lit8 v8, v18, 0x1

    invoke-static {v8, v7}, Ljava/lang/Math;->min(II)I

    move-result v8

    mul-int/lit8 v2, v8, 0x4

    move/from16 v8, v17

    move/from16 v17, v1

    .line 299
    .end local v1    # "virtualIndexOfPoint":I
    .local v8, "digitCount":I
    .local v17, "virtualIndexOfPoint":I
    :goto_4
    const/4 v1, 0x0

    .line 300
    .local v1, "expNumber":I
    const/16 v9, 0x70

    if-eq v6, v9, :cond_6

    const/16 v9, 0x50

    if-ne v6, v9, :cond_5

    goto :goto_5

    :cond_5
    const/4 v9, 0x0

    goto :goto_6

    :cond_6
    :goto_5
    move v9, v15

    :goto_6
    move/from16 v20, v9

    .line 301
    .local v20, "hasExponent":Z
    if-eqz v20, :cond_10

    .line 302
    add-int/lit8 v0, v0, 0x1

    if-ge v0, v12, :cond_7

    invoke-interface {v11, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v9

    goto :goto_7

    :cond_7
    const/4 v9, 0x0

    :goto_7
    move v6, v9

    .line 303
    const/16 v9, 0x2d

    if-ne v6, v9, :cond_8

    move v9, v15

    goto :goto_8

    :cond_8
    const/4 v9, 0x0

    .line 304
    .local v9, "neg_exp":Z
    :goto_8
    if-nez v9, :cond_9

    const/16 v7, 0x2b

    if-ne v6, v7, :cond_b

    .line 305
    :cond_9
    add-int/lit8 v0, v0, 0x1

    if-ge v0, v12, :cond_a

    invoke-interface {v11, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v7

    goto :goto_9

    :cond_a
    const/4 v7, 0x0

    :goto_9
    move v6, v7

    .line 307
    :cond_b
    invoke-direct {v10, v6}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->isDigit(C)Z

    move-result v7

    xor-int/2addr v7, v15

    or-int/2addr v7, v5

    .line 310
    .end local v5    # "illegal":Z
    .local v7, "illegal":Z
    :cond_c
    const/16 v5, 0x400

    if-ge v1, v5, :cond_d

    .line 311
    mul-int/lit8 v21, v1, 0xa

    add-int v21, v21, v6

    add-int/lit8 v21, v21, -0x30

    move/from16 v1, v21

    .line 313
    :cond_d
    add-int/2addr v0, v15

    if-ge v0, v12, :cond_e

    invoke-interface {v11, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v21

    goto :goto_a

    :cond_e
    const/16 v21, 0x0

    :goto_a
    move/from16 v6, v21

    .line 314
    invoke-direct {v10, v6}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->isDigit(C)Z

    move-result v21

    if-nez v21, :cond_c

    .line 315
    if-eqz v9, :cond_f

    .line 316
    neg-int v1, v1

    .line 318
    :cond_f
    add-int/2addr v2, v1

    move/from16 v21, v1

    move/from16 v22, v2

    move/from16 v23, v7

    goto :goto_b

    .line 301
    .end local v7    # "illegal":Z
    .end local v9    # "neg_exp":Z
    .restart local v5    # "illegal":Z
    :cond_10
    move/from16 v21, v1

    move/from16 v22, v2

    move/from16 v23, v5

    .line 323
    .end local v1    # "expNumber":I
    .end local v2    # "exponent":I
    .end local v5    # "illegal":Z
    .local v21, "expNumber":I
    .local v22, "exponent":I
    .local v23, "illegal":Z
    :goto_b
    if-ge v0, v12, :cond_12

    const/16 v1, 0x64

    if-eq v6, v1, :cond_11

    const/16 v1, 0x44

    if-eq v6, v1, :cond_11

    const/16 v1, 0x66

    if-eq v6, v1, :cond_11

    const/16 v1, 0x46

    if-ne v6, v1, :cond_12

    .line 324
    :cond_11
    add-int/lit8 v0, v0, 0x1

    .line 329
    :cond_12
    invoke-direct {v10, v11, v0, v12}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->skipWhitespace(Ljava/lang/CharSequence;II)I

    move-result v0

    .line 330
    if-nez v23, :cond_1a

    if-lt v0, v12, :cond_1a

    if-eqz v8, :cond_1a

    if-nez v20, :cond_13

    move/from16 v26, v8

    goto/16 :goto_12

    .line 339
    :cond_13
    const/4 v1, 0x0

    .line 340
    .local v1, "skipCountInTruncatedDigits":I
    const/16 v2, 0x10

    if-le v8, v2, :cond_19

    .line 341
    const-wide/16 v2, 0x0

    .line 342
    .end local v3    # "significand":J
    .local v2, "significand":J
    move v0, v13

    move-wide v3, v2

    .end local v2    # "significand":J
    .restart local v3    # "significand":J
    :goto_c
    if-ge v0, v14, :cond_17

    .line 343
    invoke-interface {v11, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v6

    .line 345
    const/16 v2, 0x7f

    if-le v6, v2, :cond_14

    const/4 v5, -0x1

    goto :goto_d

    :cond_14
    sget-object v5, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;->CHAR_TO_HEX_MAP:[B

    aget-byte v5, v5, v6

    .line 346
    .local v5, "hexValue":I
    :goto_d
    if-ltz v5, :cond_16

    .line 347
    move v9, v6

    .end local v6    # "ch":C
    .local v9, "ch":C
    const-wide v6, 0xde0b6b3a7640000L

    invoke-static {v3, v4, v6, v7}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray$$ExternalSyntheticBackport0;->m(JJ)I

    move-result v6

    if-gez v6, :cond_15

    .line 348
    const/4 v7, 0x4

    shl-long v18, v3, v7

    move-wide/from16 v24, v3

    .end local v3    # "significand":J
    .local v24, "significand":J
    int-to-long v2, v5

    or-long v2, v18, v2

    .end local v24    # "significand":J
    .restart local v2    # "significand":J
    goto :goto_e

    .line 347
    .end local v2    # "significand":J
    .restart local v3    # "significand":J
    :cond_15
    move-wide/from16 v24, v3

    .end local v3    # "significand":J
    .restart local v24    # "significand":J
    move v6, v9

    goto :goto_f

    .line 353
    .end local v9    # "ch":C
    .end local v24    # "significand":J
    .restart local v3    # "significand":J
    .restart local v6    # "ch":C
    :cond_16
    move-wide/from16 v24, v3

    move v9, v6

    const/4 v7, 0x4

    .end local v3    # "significand":J
    .end local v6    # "ch":C
    .restart local v9    # "ch":C
    .restart local v24    # "significand":J
    add-int/lit8 v1, v1, 0x1

    move-wide/from16 v2, v24

    .line 342
    .end local v5    # "hexValue":I
    .end local v24    # "significand":J
    .restart local v2    # "significand":J
    :goto_e
    add-int/lit8 v0, v0, 0x1

    move-wide v3, v2

    move v6, v9

    goto :goto_c

    .end local v2    # "significand":J
    .end local v9    # "ch":C
    .restart local v3    # "significand":J
    .restart local v6    # "ch":C
    :cond_17
    move-wide/from16 v24, v3

    .line 356
    .end local v3    # "significand":J
    .restart local v24    # "significand":J
    :goto_f
    if-ge v0, v14, :cond_18

    goto :goto_10

    :cond_18
    const/4 v15, 0x0

    :goto_10
    move v2, v15

    move v15, v0

    move/from16 v16, v1

    move/from16 v18, v2

    move/from16 v19, v6

    .local v2, "isSignificandTruncated":Z
    goto :goto_11

    .line 358
    .end local v2    # "isSignificandTruncated":Z
    .end local v24    # "significand":J
    .restart local v3    # "significand":J
    :cond_19
    const/4 v2, 0x0

    move v15, v0

    move/from16 v16, v1

    move/from16 v18, v2

    move-wide/from16 v24, v3

    move/from16 v19, v6

    .line 361
    .end local v0    # "index":I
    .end local v1    # "skipCountInTruncatedDigits":I
    .end local v3    # "significand":J
    .end local v6    # "ch":C
    .local v15, "index":I
    .local v16, "skipCountInTruncatedDigits":I
    .local v18, "isSignificandTruncated":Z
    .local v19, "ch":C
    .restart local v24    # "significand":J
    :goto_11
    sub-int v0, v17, v15

    add-int v0, v0, v16

    add-int v9, v0, v21

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p3

    move/from16 v3, p4

    move/from16 v4, p5

    move-wide/from16 v5, v24

    move/from16 v7, v22

    move/from16 v26, v8

    .end local v8    # "digitCount":I
    .local v26, "digitCount":I
    move/from16 v8, v18

    invoke-virtual/range {v0 .. v9}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->valueOfHexLiteral(Ljava/lang/CharSequence;IIZJIZI)J

    move-result-wide v0

    return-wide v0

    .line 330
    .end local v15    # "index":I
    .end local v16    # "skipCountInTruncatedDigits":I
    .end local v18    # "isSignificandTruncated":Z
    .end local v19    # "ch":C
    .end local v24    # "significand":J
    .end local v26    # "digitCount":I
    .restart local v0    # "index":I
    .restart local v3    # "significand":J
    .restart local v6    # "ch":C
    .restart local v8    # "digitCount":I
    :cond_1a
    move/from16 v26, v8

    .line 333
    .end local v8    # "digitCount":I
    .restart local v26    # "digitCount":I
    :goto_12
    const-wide/16 v1, -0x1

    return-wide v1
.end method

.method private parseInfinity(Ljava/lang/CharSequence;IIZ)J
    .locals 3
    .param p1, "str"    # Ljava/lang/CharSequence;
    .param p2, "index"    # I
    .param p3, "endIndex"    # I
    .param p4, "negative"    # Z

    .line 382
    add-int/lit8 v0, p2, 0x7

    if-ge v0, p3, :cond_1

    .line 383
    invoke-interface {p1, p2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    const/16 v1, 0x49

    if-ne v0, v1, :cond_1

    add-int/lit8 v0, p2, 0x1

    .line 384
    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    const/16 v1, 0x6e

    if-ne v0, v1, :cond_1

    add-int/lit8 v0, p2, 0x2

    .line 385
    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    const/16 v2, 0x66

    if-ne v0, v2, :cond_1

    add-int/lit8 v0, p2, 0x3

    .line 386
    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    const/16 v2, 0x69

    if-ne v0, v2, :cond_1

    add-int/lit8 v0, p2, 0x4

    .line 387
    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    if-ne v0, v1, :cond_1

    add-int/lit8 v0, p2, 0x5

    .line 388
    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    if-ne v0, v2, :cond_1

    add-int/lit8 v0, p2, 0x6

    .line 389
    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    const/16 v1, 0x74

    if-ne v0, v1, :cond_1

    add-int/lit8 v0, p2, 0x7

    .line 390
    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    const/16 v1, 0x79

    if-ne v0, v1, :cond_1

    .line 392
    add-int/lit8 v0, p2, 0x8

    invoke-direct {p0, p1, v0, p3}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->skipWhitespace(Ljava/lang/CharSequence;II)I

    move-result p2

    .line 393
    if-ne p2, p3, :cond_1

    .line 394
    if-eqz p4, :cond_0

    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->negativeInfinity()J

    move-result-wide v0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->positiveInfinity()J

    move-result-wide v0

    :goto_0
    return-wide v0

    .line 397
    :cond_1
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method private parseNaN(Ljava/lang/CharSequence;II)J
    .locals 2
    .param p1, "str"    # Ljava/lang/CharSequence;
    .param p2, "index"    # I
    .param p3, "endIndex"    # I

    .line 419
    add-int/lit8 v0, p2, 0x2

    if-ge v0, p3, :cond_0

    add-int/lit8 v0, p2, 0x1

    .line 421
    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    const/16 v1, 0x61

    if-ne v0, v1, :cond_0

    add-int/lit8 v0, p2, 0x2

    .line 422
    invoke-interface {p1, v0}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    const/16 v1, 0x4e

    if-ne v0, v1, :cond_0

    .line 424
    add-int/lit8 v0, p2, 0x3

    invoke-direct {p0, p1, v0, p3}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->skipWhitespace(Ljava/lang/CharSequence;II)I

    move-result p2

    .line 425
    if-ne p2, p3, :cond_0

    .line 426
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->nan()J

    move-result-wide v0

    return-wide v0

    .line 429
    :cond_0
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method private skipWhitespace(Ljava/lang/CharSequence;II)I
    .locals 2
    .param p1, "str"    # Ljava/lang/CharSequence;
    .param p2, "index"    # I
    .param p3, "endIndex"    # I

    .line 441
    nop

    :goto_0
    if-ge p2, p3, :cond_1

    .line 442
    invoke-interface {p1, p2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    const/16 v1, 0x20

    if-le v0, v1, :cond_0

    .line 443
    goto :goto_1

    .line 441
    :cond_0
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 446
    :cond_1
    :goto_1
    return p2
.end method

.method private tryToParseEightDigits(Ljava/lang/CharSequence;I)I
    .locals 9
    .param p1, "str"    # Ljava/lang/CharSequence;
    .param p2, "offset"    # I

    .line 452
    invoke-interface {p1, p2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v0

    int-to-long v0, v0

    add-int/lit8 v2, p2, 0x1

    .line 453
    invoke-interface {p1, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    int-to-long v2, v2

    const/16 v4, 0x10

    shl-long/2addr v2, v4

    or-long/2addr v0, v2

    add-int/lit8 v2, p2, 0x2

    .line 454
    invoke-interface {p1, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    int-to-long v2, v2

    const/16 v5, 0x20

    shl-long/2addr v2, v5

    or-long/2addr v0, v2

    add-int/lit8 v2, p2, 0x3

    .line 455
    invoke-interface {p1, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    int-to-long v2, v2

    const/16 v6, 0x30

    shl-long/2addr v2, v6

    or-long/2addr v0, v2

    .line 457
    .local v0, "first":J
    add-int/lit8 v2, p2, 0x4

    invoke-interface {p1, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v2

    int-to-long v2, v2

    add-int/lit8 v7, p2, 0x5

    .line 458
    invoke-interface {p1, v7}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v7

    int-to-long v7, v7

    shl-long/2addr v7, v4

    or-long/2addr v2, v7

    add-int/lit8 v4, p2, 0x6

    .line 459
    invoke-interface {p1, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v4

    int-to-long v7, v4

    shl-long v4, v7, v5

    or-long/2addr v2, v4

    add-int/lit8 v4, p2, 0x7

    .line 460
    invoke-interface {p1, v4}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v4

    int-to-long v4, v4

    shl-long/2addr v4, v6

    or-long/2addr v2, v4

    .line 462
    .local v2, "second":J
    invoke-static {v0, v1, v2, v3}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleSwar;->tryToParseEightDigitsUtf16(JJ)I

    move-result v4

    return v4
.end method


# virtual methods
.method abstract nan()J
.end method

.method abstract negativeInfinity()J
.end method

.method public parseFloatingPointLiteral(Ljava/lang/CharSequence;II)J
    .locals 12
    .param p1, "str"    # Ljava/lang/CharSequence;
    .param p2, "offset"    # I
    .param p3, "length"    # I

    .line 178
    add-int v7, p2, p3

    .line 179
    .local v7, "endIndex":I
    const-wide/16 v0, -0x1

    if-ltz p2, :cond_d

    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-le v7, v2, :cond_0

    goto/16 :goto_6

    .line 185
    :cond_0
    invoke-direct {p0, p1, p2, v7}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->skipWhitespace(Ljava/lang/CharSequence;II)I

    move-result v2

    .line 186
    .local v2, "index":I
    if-ne v2, v7, :cond_1

    .line 187
    return-wide v0

    .line 189
    :cond_1
    invoke-interface {p1, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    .line 193
    .local v3, "ch":C
    const/16 v4, 0x2d

    const/4 v5, 0x0

    const/4 v6, 0x1

    if-ne v3, v4, :cond_2

    move v4, v6

    goto :goto_0

    :cond_2
    move v4, v5

    :goto_0
    move v8, v4

    .line 194
    .local v8, "isNegative":Z
    if-nez v8, :cond_3

    const/16 v4, 0x2b

    if-ne v3, v4, :cond_5

    .line 195
    :cond_3
    add-int/lit8 v2, v2, 0x1

    if-ge v2, v7, :cond_4

    invoke-interface {p1, v2}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v4

    goto :goto_1

    :cond_4
    move v4, v5

    :goto_1
    move v3, v4

    .line 196
    if-nez v3, :cond_5

    .line 197
    return-wide v0

    .line 203
    :cond_5
    const/16 v0, 0x49

    if-lt v3, v0, :cond_7

    .line 204
    const/16 v0, 0x4e

    if-ne v3, v0, :cond_6

    .line 205
    invoke-direct {p0, p1, v2, v7}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->parseNaN(Ljava/lang/CharSequence;II)J

    move-result-wide v0

    goto :goto_2

    .line 206
    :cond_6
    invoke-direct {p0, p1, v2, v7, v8}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->parseInfinity(Ljava/lang/CharSequence;IIZ)J

    move-result-wide v0

    .line 204
    :goto_2
    return-wide v0

    .line 211
    :cond_7
    const/16 v0, 0x30

    if-ne v3, v0, :cond_8

    goto :goto_3

    :cond_8
    move v6, v5

    :goto_3
    move v9, v6

    .line 212
    .local v9, "hasLeadingZero":Z
    if-eqz v9, :cond_c

    .line 213
    add-int/lit8 v6, v2, 0x1

    .end local v2    # "index":I
    .local v6, "index":I
    if-ge v6, v7, :cond_9

    invoke-interface {p1, v6}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    :cond_9
    move v10, v5

    .line 214
    .end local v3    # "ch":C
    .local v10, "ch":C
    const/16 v0, 0x78

    if-eq v10, v0, :cond_b

    const/16 v0, 0x58

    if-ne v10, v0, :cond_a

    goto :goto_4

    :cond_a
    move v11, v10

    move v10, v6

    goto :goto_5

    .line 215
    :cond_b
    :goto_4
    add-int/lit8 v2, v6, 0x1

    move-object v0, p0

    move-object v1, p1

    move v3, p2

    move v4, v7

    move v5, v8

    invoke-direct/range {v0 .. v5}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->parseHexFloatLiteral(Ljava/lang/CharSequence;IIIZ)J

    move-result-wide v0

    return-wide v0

    .line 212
    .end local v6    # "index":I
    .end local v10    # "ch":C
    .restart local v2    # "index":I
    .restart local v3    # "ch":C
    :cond_c
    move v10, v2

    move v11, v3

    .line 219
    .end local v2    # "index":I
    .end local v3    # "ch":C
    .local v10, "index":I
    .local v11, "ch":C
    :goto_5
    move-object v0, p0

    move-object v1, p1

    move v2, v10

    move v3, p2

    move v4, v7

    move v5, v8

    move v6, v9

    invoke-direct/range {v0 .. v6}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharSequence;->parseDecFloatLiteral(Ljava/lang/CharSequence;IIIZZ)J

    move-result-wide v0

    return-wide v0

    .line 180
    .end local v8    # "isNegative":Z
    .end local v9    # "hasLeadingZero":Z
    .end local v10    # "index":I
    .end local v11    # "ch":C
    :cond_d
    :goto_6
    return-wide v0
.end method

.method abstract positiveInfinity()J
.end method

.method abstract valueOfFloatLiteral(Ljava/lang/CharSequence;IIZJIZI)J
.end method

.method abstract valueOfHexLiteral(Ljava/lang/CharSequence;IIZJIZI)J
.end method
