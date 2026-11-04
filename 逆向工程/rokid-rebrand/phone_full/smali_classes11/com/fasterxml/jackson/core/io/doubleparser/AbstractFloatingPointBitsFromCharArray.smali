.class abstract Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;
.super Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;
.source "AbstractFloatingPointBitsFromCharArray.java"


# direct methods
.method constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;-><init>()V

    return-void
.end method

.method private static isDigit(C)Z
    .locals 1
    .param p0, "c"    # C

    .line 26
    const/16 v0, 0x30

    if-gt v0, p0, :cond_0

    const/16 v0, 0x39

    if-gt p0, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private parseDecFloatLiteral([CIIIZZ)J
    .locals 28
    .param p1, "str"    # [C
    .param p2, "index"    # I
    .param p3, "startIndex"    # I
    .param p4, "endIndex"    # I
    .param p5, "isNegative"    # Z
    .param p6, "hasLeadingZero"    # Z

    .line 73
    move-object/from16 v10, p0

    move-object/from16 v11, p1

    move/from16 v12, p4

    const-wide/16 v0, 0x0

    .line 74
    .local v0, "significand":J
    move/from16 v13, p2

    .line 75
    .local v13, "significandStartIndex":I
    const/4 v2, -0x1

    .line 76
    .local v2, "virtualIndexOfPoint":I
    const/4 v3, 0x0

    .line 77
    .local v3, "illegal":Z
    const/4 v4, 0x0

    move v5, v4

    move v4, v3

    move v3, v2

    move-wide v1, v0

    move/from16 v0, p2

    .line 78
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

    .line 79
    aget-char v5, v11, v0

    .line 80
    invoke-static {v5}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->isDigit(C)Z

    move-result v17

    if-eqz v17, :cond_0

    .line 82
    mul-long/2addr v8, v1

    int-to-long v14, v5

    add-long/2addr v8, v14

    sub-long/2addr v8, v6

    move-wide v1, v8

    .end local v1    # "significand":J
    .local v8, "significand":J
    goto :goto_3

    .line 83
    .end local v8    # "significand":J
    .restart local v1    # "significand":J
    :cond_0
    if-ne v5, v14, :cond_4

    .line 84
    if-ltz v3, :cond_1

    move/from16 v15, v16

    goto :goto_1

    :cond_1
    const/4 v15, 0x0

    :goto_1
    or-int/2addr v4, v15

    .line 85
    move v3, v0

    .line 86
    :goto_2
    add-int/lit8 v6, v12, -0x8

    if-ge v0, v6, :cond_3

    .line 87
    add-int/lit8 v6, v0, 0x1

    invoke-direct {v10, v11, v6}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->tryToParseEightDigits([CI)I

    move-result v6

    .line 88
    .local v6, "eightDigits":I
    if-gez v6, :cond_2

    .line 89
    goto :goto_3

    .line 92
    :cond_2
    const-wide/32 v7, 0x5f5e100

    mul-long/2addr v7, v1

    int-to-long v14, v6

    add-long v1, v7, v14

    .line 86
    .end local v6    # "eightDigits":I
    add-int/lit8 v0, v0, 0x8

    goto :goto_2

    .line 78
    :cond_3
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 99
    :cond_4
    move/from16 p2, v0

    .line 101
    .local p2, "significandEndIndex":I
    if-gez v3, :cond_5

    .line 102
    sub-int v17, v0, v13

    .line 103
    .local v17, "digitCount":I
    move v3, v0

    .line 104
    const/16 v18, 0x0

    move/from16 v27, v17

    move/from16 v17, v3

    move/from16 v3, v27

    .local v18, "exponent":I
    goto :goto_4

    .line 106
    .end local v17    # "digitCount":I
    .end local v18    # "exponent":I
    :cond_5
    sub-int v17, v0, v13

    add-int/lit8 v17, v17, -0x1

    .line 107
    .restart local v17    # "digitCount":I
    sub-int v18, v3, v0

    add-int/lit8 v18, v18, 0x1

    move/from16 v27, v17

    move/from16 v17, v3

    move/from16 v3, v27

    .line 112
    .local v3, "digitCount":I
    .local v17, "virtualIndexOfPoint":I
    .restart local v18    # "exponent":I
    :goto_4
    const/16 v19, 0x0

    .line 113
    .local v19, "expNumber":I
    const/16 v15, 0x65

    if-eq v5, v15, :cond_7

    const/16 v15, 0x45

    if-ne v5, v15, :cond_6

    goto :goto_5

    :cond_6
    move v15, v4

    goto :goto_c

    .line 114
    :cond_7
    :goto_5
    add-int/lit8 v0, v0, 0x1

    if-ge v0, v12, :cond_8

    aget-char v15, v11, v0

    goto :goto_6

    :cond_8
    const/4 v15, 0x0

    :goto_6
    move v5, v15

    .line 115
    const/16 v15, 0x2d

    if-ne v5, v15, :cond_9

    move/from16 v15, v16

    goto :goto_7

    :cond_9
    const/4 v15, 0x0

    .line 116
    .local v15, "neg_exp":Z
    :goto_7
    if-nez v15, :cond_a

    const/16 v6, 0x2b

    if-ne v5, v6, :cond_c

    .line 117
    :cond_a
    add-int/lit8 v0, v0, 0x1

    if-ge v0, v12, :cond_b

    aget-char v6, v11, v0

    goto :goto_8

    :cond_b
    const/4 v6, 0x0

    :goto_8
    move v5, v6

    .line 119
    :cond_c
    invoke-static {v5}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->isDigit(C)Z

    move-result v6

    xor-int/lit8 v6, v6, 0x1

    or-int/2addr v4, v6

    move/from16 v6, v19

    .line 122
    .end local v19    # "expNumber":I
    .local v6, "expNumber":I
    :goto_9
    const/16 v7, 0x400

    if-ge v6, v7, :cond_d

    .line 123
    mul-int/lit8 v7, v6, 0xa

    add-int/2addr v7, v5

    add-int/lit8 v7, v7, -0x30

    move v6, v7

    .line 125
    :cond_d
    add-int/lit8 v0, v0, 0x1

    if-ge v0, v12, :cond_e

    aget-char v7, v11, v0

    goto :goto_a

    :cond_e
    const/4 v7, 0x0

    :goto_a
    move v5, v7

    .line 126
    invoke-static {v5}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->isDigit(C)Z

    move-result v7

    if-nez v7, :cond_19

    .line 127
    if-eqz v15, :cond_f

    .line 128
    neg-int v6, v6

    move/from16 v19, v6

    goto :goto_b

    .line 127
    :cond_f
    move/from16 v19, v6

    .line 130
    .end local v6    # "expNumber":I
    .restart local v19    # "expNumber":I
    :goto_b
    add-int v18, v18, v19

    move v15, v4

    .line 135
    .end local v4    # "illegal":Z
    .local v15, "illegal":Z
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

    .line 136
    :cond_10
    add-int/lit8 v0, v0, 0x1

    .line 141
    :cond_11
    invoke-direct {v10, v11, v0, v12}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->skipWhitespace([CII)I

    move-result v0

    .line 142
    if-nez v15, :cond_18

    if-lt v0, v12, :cond_18

    if-nez p6, :cond_12

    if-nez v3, :cond_12

    move/from16 v26, p2

    move/from16 v25, v3

    move/from16 v23, v15

    goto/16 :goto_11

    .line 150
    :cond_12
    const/4 v4, 0x0

    .line 152
    .local v4, "skipCountInTruncatedDigits":I
    const/16 v6, 0x13

    if-le v3, v6, :cond_17

    .line 153
    const-wide/16 v1, 0x0

    .line 154
    move v0, v13

    :goto_d
    move/from16 v7, p2

    .end local p2    # "significandEndIndex":I
    .local v7, "significandEndIndex":I
    if-ge v0, v7, :cond_14

    .line 155
    aget-char v5, v11, v0

    .line 156
    if-ne v5, v14, :cond_13

    .line 157
    add-int/lit8 v4, v4, 0x1

    move/from16 v23, v15

    const-wide/16 v8, 0x30

    goto :goto_e

    .line 159
    :cond_13
    move/from16 v23, v15

    .end local v15    # "illegal":Z
    .local v23, "illegal":Z
    const-wide v14, 0xde0b6b3a7640000L

    invoke-static {v1, v2, v14, v15}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray$$ExternalSyntheticBackport0;->m(JJ)I

    move-result v6

    if-gez v6, :cond_15

    .line 160
    mul-long v14, v1, v8

    int-to-long v8, v5

    add-long/2addr v14, v8

    const-wide/16 v8, 0x30

    sub-long v1, v14, v8

    .line 154
    :goto_e
    add-int/lit8 v0, v0, 0x1

    move/from16 p2, v7

    move/from16 v15, v23

    const-wide/16 v8, 0xa

    const/16 v14, 0x2e

    goto :goto_d

    .end local v23    # "illegal":Z
    .restart local v15    # "illegal":Z
    :cond_14
    move/from16 v23, v15

    .line 166
    .end local v15    # "illegal":Z
    .restart local v23    # "illegal":Z
    :cond_15
    if-ge v0, v7, :cond_16

    move/from16 v15, v16

    goto :goto_f

    :cond_16
    const/4 v15, 0x0

    :goto_f
    move v6, v15

    .line 167
    .local v6, "isSignificandTruncated":Z
    sub-int v8, v17, v0

    add-int/2addr v8, v4

    add-int v8, v8, v19

    move v14, v0

    move-wide v15, v1

    move/from16 v20, v4

    move/from16 v21, v5

    move/from16 v22, v6

    move/from16 v24, v8

    .local v8, "exponentOfTruncatedSignificand":I
    goto :goto_10

    .line 169
    .end local v6    # "isSignificandTruncated":Z
    .end local v7    # "significandEndIndex":I
    .end local v8    # "exponentOfTruncatedSignificand":I
    .end local v23    # "illegal":Z
    .restart local v15    # "illegal":Z
    .restart local p2    # "significandEndIndex":I
    :cond_17
    move/from16 v7, p2

    move/from16 v23, v15

    .end local v15    # "illegal":Z
    .end local p2    # "significandEndIndex":I
    .restart local v7    # "significandEndIndex":I
    .restart local v23    # "illegal":Z
    const/4 v6, 0x0

    .line 170
    .restart local v6    # "isSignificandTruncated":Z
    const/4 v8, 0x0

    move v14, v0

    move-wide v15, v1

    move/from16 v20, v4

    move/from16 v21, v5

    move/from16 v22, v6

    move/from16 v24, v8

    .line 172
    .end local v0    # "index":I
    .end local v1    # "significand":J
    .end local v4    # "skipCountInTruncatedDigits":I
    .end local v5    # "ch":C
    .end local v6    # "isSignificandTruncated":Z
    .local v14, "index":I
    .local v15, "significand":J
    .local v20, "skipCountInTruncatedDigits":I
    .local v21, "ch":C
    .local v22, "isSignificandTruncated":Z
    .local v24, "exponentOfTruncatedSignificand":I
    :goto_10
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p3

    move/from16 v25, v3

    .end local v3    # "digitCount":I
    .local v25, "digitCount":I
    move/from16 v3, p4

    move/from16 v4, p5

    move-wide v5, v15

    move/from16 v26, v7

    .end local v7    # "significandEndIndex":I
    .local v26, "significandEndIndex":I
    move/from16 v7, v18

    move/from16 v8, v22

    move/from16 v9, v24

    invoke-virtual/range {v0 .. v9}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->valueOfFloatLiteral([CIIZJIZI)J

    move-result-wide v0

    return-wide v0

    .line 142
    .end local v14    # "index":I
    .end local v20    # "skipCountInTruncatedDigits":I
    .end local v21    # "ch":C
    .end local v22    # "isSignificandTruncated":Z
    .end local v23    # "illegal":Z
    .end local v24    # "exponentOfTruncatedSignificand":I
    .end local v25    # "digitCount":I
    .end local v26    # "significandEndIndex":I
    .restart local v0    # "index":I
    .restart local v1    # "significand":J
    .restart local v3    # "digitCount":I
    .restart local v5    # "ch":C
    .local v15, "illegal":Z
    .restart local p2    # "significandEndIndex":I
    :cond_18
    move/from16 v26, p2

    move/from16 v25, v3

    move/from16 v23, v15

    .line 144
    .end local v3    # "digitCount":I
    .end local v15    # "illegal":Z
    .end local p2    # "significandEndIndex":I
    .restart local v23    # "illegal":Z
    .restart local v25    # "digitCount":I
    .restart local v26    # "significandEndIndex":I
    :goto_11
    const-wide/16 v3, -0x1

    return-wide v3

    .line 126
    .end local v19    # "expNumber":I
    .end local v23    # "illegal":Z
    .end local v25    # "digitCount":I
    .end local v26    # "significandEndIndex":I
    .restart local v3    # "digitCount":I
    .local v4, "illegal":Z
    .local v6, "expNumber":I
    .local v15, "neg_exp":Z
    .restart local p2    # "significandEndIndex":I
    :cond_19
    move/from16 v26, p2

    move/from16 v25, v3

    const-wide/16 v8, 0x30

    .end local v3    # "digitCount":I
    .end local p2    # "significandEndIndex":I
    .restart local v25    # "digitCount":I
    .restart local v26    # "significandEndIndex":I
    const-wide/16 v8, 0xa

    const/16 v14, 0x2e

    goto/16 :goto_9
.end method

.method private parseHexFloatLiteral([CIIIZ)J
    .locals 29
    .param p1, "str"    # [C
    .param p2, "index"    # I
    .param p3, "startIndex"    # I
    .param p4, "endIndex"    # I
    .param p5, "isNegative"    # Z

    .line 267
    move-object/from16 v10, p1

    move/from16 v11, p4

    const-wide/16 v0, 0x0

    .line 268
    .local v0, "significand":J
    const/4 v2, 0x0

    .line 269
    .local v2, "exponent":I
    move/from16 v12, p2

    .line 270
    .local v12, "significandStartIndex":I
    const/4 v3, -0x1

    .line 272
    .local v3, "virtualIndexOfPoint":I
    const/4 v4, 0x0

    .line 273
    .local v4, "illegal":Z
    const/4 v5, 0x0

    move v6, v5

    move v5, v4

    move-wide/from16 v27, v0

    move/from16 v0, p2

    move v1, v3

    move-wide/from16 v3, v27

    .line 274
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

    const/4 v14, 0x1

    if-ge v0, v11, :cond_3

    .line 275
    aget-char v6, v10, v0

    .line 277
    if-le v6, v8, :cond_0

    const/4 v15, -0x1

    goto :goto_1

    :cond_0
    sget-object v15, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;->CHAR_TO_HEX_MAP:[B

    aget-byte v15, v15, v6

    .line 278
    .local v15, "hexValue":I
    :goto_1
    if-ltz v15, :cond_1

    .line 279
    shl-long v7, v3, v9

    int-to-long v13, v15

    or-long v3, v7, v13

    goto :goto_3

    .line 280
    :cond_1
    const/4 v7, -0x4

    if-ne v15, v7, :cond_3

    .line 281
    if-ltz v1, :cond_2

    move v13, v14

    goto :goto_2

    :cond_2
    const/4 v13, 0x0

    :goto_2
    or-int/2addr v5, v13

    .line 282
    move v1, v0

    .line 274
    .end local v15    # "hexValue":I
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 298
    :cond_3
    move v15, v0

    .line 299
    .local v15, "significandEndIndex":I
    const/16 v7, 0x400

    if-gez v1, :cond_4

    .line 300
    sub-int v16, v15, v12

    .line 301
    .local v16, "digitCount":I
    move v1, v15

    move v13, v1

    move/from16 v1, v16

    goto :goto_4

    .line 303
    .end local v16    # "digitCount":I
    :cond_4
    sub-int v16, v15, v12

    add-int/lit8 v16, v16, -0x1

    .line 304
    .restart local v16    # "digitCount":I
    sub-int v17, v1, v0

    add-int/lit8 v13, v17, 0x1

    invoke-static {v13, v7}, Ljava/lang/Math;->min(II)I

    move-result v13

    mul-int/lit8 v2, v13, 0x4

    move v13, v1

    move/from16 v1, v16

    .line 309
    .end local v16    # "digitCount":I
    .local v1, "digitCount":I
    .local v13, "virtualIndexOfPoint":I
    :goto_4
    const/16 v16, 0x0

    .line 310
    .local v16, "expNumber":I
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
    move v9, v14

    :goto_6
    move/from16 v19, v9

    .line 311
    .local v19, "hasExponent":Z
    if-eqz v19, :cond_10

    .line 312
    add-int/lit8 v0, v0, 0x1

    if-ge v0, v11, :cond_7

    aget-char v9, v10, v0

    goto :goto_7

    :cond_7
    const/4 v9, 0x0

    :goto_7
    move v6, v9

    .line 313
    const/16 v9, 0x2d

    if-ne v6, v9, :cond_8

    move v9, v14

    goto :goto_8

    :cond_8
    const/4 v9, 0x0

    .line 314
    .local v9, "neg_exp":Z
    :goto_8
    if-nez v9, :cond_9

    const/16 v8, 0x2b

    if-ne v6, v8, :cond_b

    .line 315
    :cond_9
    add-int/lit8 v0, v0, 0x1

    if-ge v0, v11, :cond_a

    aget-char v8, v10, v0

    goto :goto_9

    :cond_a
    const/4 v8, 0x0

    :goto_9
    move v6, v8

    .line 317
    :cond_b
    invoke-static {v6}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->isDigit(C)Z

    move-result v8

    xor-int/2addr v8, v14

    or-int/2addr v8, v5

    move/from16 v5, v16

    .line 320
    .end local v16    # "expNumber":I
    .local v5, "expNumber":I
    .local v8, "illegal":Z
    :cond_c
    if-ge v5, v7, :cond_d

    .line 321
    mul-int/lit8 v16, v5, 0xa

    add-int v16, v16, v6

    add-int/lit8 v16, v16, -0x30

    move/from16 v5, v16

    .line 323
    :cond_d
    add-int/2addr v0, v14

    if-ge v0, v11, :cond_e

    aget-char v16, v10, v0

    goto :goto_a

    :cond_e
    const/16 v16, 0x0

    :goto_a
    move/from16 v6, v16

    .line 324
    invoke-static {v6}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->isDigit(C)Z

    move-result v16

    if-nez v16, :cond_c

    .line 325
    if-eqz v9, :cond_f

    .line 326
    neg-int v5, v5

    move/from16 v16, v5

    goto :goto_b

    .line 325
    :cond_f
    move/from16 v16, v5

    .line 328
    .end local v5    # "expNumber":I
    .restart local v16    # "expNumber":I
    :goto_b
    add-int v2, v2, v16

    move/from16 v21, v8

    move/from16 v22, v16

    move/from16 v16, v2

    goto :goto_c

    .line 311
    .end local v8    # "illegal":Z
    .end local v9    # "neg_exp":Z
    .local v5, "illegal":Z
    :cond_10
    move/from16 v21, v5

    move/from16 v22, v16

    move/from16 v16, v2

    .line 333
    .end local v2    # "exponent":I
    .end local v5    # "illegal":Z
    .local v16, "exponent":I
    .local v21, "illegal":Z
    .local v22, "expNumber":I
    :goto_c
    if-ge v0, v11, :cond_12

    const/16 v2, 0x64

    if-eq v6, v2, :cond_11

    const/16 v2, 0x44

    if-eq v6, v2, :cond_11

    const/16 v2, 0x66

    if-eq v6, v2, :cond_11

    const/16 v2, 0x46

    if-ne v6, v2, :cond_12

    .line 334
    :cond_11
    add-int/lit8 v0, v0, 0x1

    .line 339
    :cond_12
    move-object/from16 v9, p0

    invoke-direct {v9, v10, v0, v11}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->skipWhitespace([CII)I

    move-result v0

    .line 340
    if-nez v21, :cond_1a

    if-lt v0, v11, :cond_1a

    if-eqz v1, :cond_1a

    if-nez v19, :cond_13

    move/from16 v26, v1

    goto/16 :goto_13

    .line 349
    :cond_13
    const/4 v2, 0x0

    .line 350
    .local v2, "skipCountInTruncatedDigits":I
    const/16 v5, 0x10

    if-le v1, v5, :cond_19

    .line 351
    const-wide/16 v3, 0x0

    .line 352
    move v0, v12

    :goto_d
    if-ge v0, v15, :cond_17

    .line 353
    aget-char v6, v10, v0

    .line 355
    const/16 v5, 0x7f

    if-le v6, v5, :cond_14

    const/4 v7, -0x1

    goto :goto_e

    :cond_14
    sget-object v7, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;->CHAR_TO_HEX_MAP:[B

    aget-byte v7, v7, v6

    .line 356
    .local v7, "hexValue":I
    :goto_e
    if-ltz v7, :cond_16

    .line 357
    move v8, v6

    .end local v6    # "ch":C
    .local v8, "ch":C
    const-wide v5, 0xde0b6b3a7640000L

    invoke-static {v3, v4, v5, v6}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray$$ExternalSyntheticBackport0;->m(JJ)I

    move-result v5

    if-gez v5, :cond_15

    .line 358
    const/4 v5, 0x4

    shl-long v23, v3, v5

    int-to-long v5, v7

    or-long v3, v23, v5

    goto :goto_f

    .line 357
    :cond_15
    move v6, v8

    goto :goto_10

    .line 363
    .end local v8    # "ch":C
    .restart local v6    # "ch":C
    :cond_16
    move v8, v6

    .end local v6    # "ch":C
    .restart local v8    # "ch":C
    add-int/lit8 v2, v2, 0x1

    .line 352
    .end local v7    # "hexValue":I
    :goto_f
    add-int/lit8 v0, v0, 0x1

    move v6, v8

    goto :goto_d

    .line 366
    .end local v8    # "ch":C
    .restart local v6    # "ch":C
    :cond_17
    :goto_10
    if-ge v0, v15, :cond_18

    goto :goto_11

    :cond_18
    const/4 v14, 0x0

    :goto_11
    move v5, v14

    move v14, v0

    move/from16 v17, v2

    move-wide/from16 v23, v3

    move/from16 v18, v5

    move/from16 v20, v6

    .local v5, "isSignificandTruncated":Z
    goto :goto_12

    .line 368
    .end local v5    # "isSignificandTruncated":Z
    :cond_19
    const/4 v5, 0x0

    move v14, v0

    move/from16 v17, v2

    move-wide/from16 v23, v3

    move/from16 v18, v5

    move/from16 v20, v6

    .line 371
    .end local v0    # "index":I
    .end local v2    # "skipCountInTruncatedDigits":I
    .end local v3    # "significand":J
    .end local v6    # "ch":C
    .local v14, "index":I
    .local v17, "skipCountInTruncatedDigits":I
    .local v18, "isSignificandTruncated":Z
    .local v20, "ch":C
    .local v23, "significand":J
    :goto_12
    sub-int v0, v13, v14

    add-int v0, v0, v17

    add-int v25, v0, v22

    move-object/from16 v0, p0

    move/from16 v26, v1

    .end local v1    # "digitCount":I
    .local v26, "digitCount":I
    move-object/from16 v1, p1

    move/from16 v2, p3

    move/from16 v3, p4

    move/from16 v4, p5

    move-wide/from16 v5, v23

    move/from16 v7, v16

    move/from16 v8, v18

    move/from16 v9, v25

    invoke-virtual/range {v0 .. v9}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->valueOfHexLiteral([CIIZJIZI)J

    move-result-wide v0

    return-wide v0

    .line 340
    .end local v14    # "index":I
    .end local v17    # "skipCountInTruncatedDigits":I
    .end local v18    # "isSignificandTruncated":Z
    .end local v20    # "ch":C
    .end local v23    # "significand":J
    .end local v26    # "digitCount":I
    .restart local v0    # "index":I
    .restart local v1    # "digitCount":I
    .restart local v3    # "significand":J
    .restart local v6    # "ch":C
    :cond_1a
    move/from16 v26, v1

    .line 343
    .end local v1    # "digitCount":I
    .restart local v26    # "digitCount":I
    :goto_13
    const-wide/16 v1, -0x1

    return-wide v1
.end method

.method private parseInfinity([CIIZ)J
    .locals 3
    .param p1, "str"    # [C
    .param p2, "index"    # I
    .param p3, "endIndex"    # I
    .param p4, "negative"    # Z

    .line 392
    add-int/lit8 v0, p2, 0x7

    if-ge v0, p3, :cond_1

    aget-char v0, p1, p2

    const/16 v1, 0x49

    if-ne v0, v1, :cond_1

    add-int/lit8 v0, p2, 0x1

    aget-char v0, p1, v0

    const/16 v1, 0x6e

    if-ne v0, v1, :cond_1

    add-int/lit8 v0, p2, 0x2

    aget-char v0, p1, v0

    const/16 v2, 0x66

    if-ne v0, v2, :cond_1

    add-int/lit8 v0, p2, 0x3

    aget-char v0, p1, v0

    const/16 v2, 0x69

    if-ne v0, v2, :cond_1

    add-int/lit8 v0, p2, 0x4

    aget-char v0, p1, v0

    if-ne v0, v1, :cond_1

    add-int/lit8 v0, p2, 0x5

    aget-char v0, p1, v0

    if-ne v0, v2, :cond_1

    add-int/lit8 v0, p2, 0x6

    aget-char v0, p1, v0

    const/16 v1, 0x74

    if-ne v0, v1, :cond_1

    add-int/lit8 v0, p2, 0x7

    aget-char v0, p1, v0

    const/16 v1, 0x79

    if-ne v0, v1, :cond_1

    .line 402
    add-int/lit8 v0, p2, 0x8

    invoke-direct {p0, p1, v0, p3}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->skipWhitespace([CII)I

    move-result p2

    .line 403
    if-ne p2, p3, :cond_1

    .line 404
    if-eqz p4, :cond_0

    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->negativeInfinity()J

    move-result-wide v0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->positiveInfinity()J

    move-result-wide v0

    :goto_0
    return-wide v0

    .line 407
    :cond_1
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method private parseNaN([CII)J
    .locals 2
    .param p1, "str"    # [C
    .param p2, "index"    # I
    .param p3, "endIndex"    # I

    .line 429
    add-int/lit8 v0, p2, 0x2

    if-ge v0, p3, :cond_0

    add-int/lit8 v0, p2, 0x1

    aget-char v0, p1, v0

    const/16 v1, 0x61

    if-ne v0, v1, :cond_0

    add-int/lit8 v0, p2, 0x2

    aget-char v0, p1, v0

    const/16 v1, 0x4e

    if-ne v0, v1, :cond_0

    .line 434
    add-int/lit8 v0, p2, 0x3

    invoke-direct {p0, p1, v0, p3}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->skipWhitespace([CII)I

    move-result p2

    .line 435
    if-ne p2, p3, :cond_0

    .line 436
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->nan()J

    move-result-wide v0

    return-wide v0

    .line 439
    :cond_0
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method private skipWhitespace([CII)I
    .locals 2
    .param p1, "str"    # [C
    .param p2, "index"    # I
    .param p3, "endIndex"    # I

    .line 38
    nop

    :goto_0
    if-ge p2, p3, :cond_1

    .line 39
    aget-char v0, p1, p2

    and-int/lit16 v0, v0, 0xff

    const/16 v1, 0x20

    if-le v0, v1, :cond_0

    .line 40
    goto :goto_1

    .line 38
    :cond_0
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 43
    :cond_1
    :goto_1
    return p2
.end method

.method private tryToParseEightDigits([CI)I
    .locals 1
    .param p1, "str"    # [C
    .param p2, "offset"    # I

    .line 443
    invoke-static {p1, p2}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleSwar;->tryToParseEightDigitsUtf16([CI)I

    move-result v0

    return v0
.end method


# virtual methods
.method abstract nan()J
.end method

.method abstract negativeInfinity()J
.end method

.method public parseFloatingPointLiteral([CII)J
    .locals 12
    .param p1, "str"    # [C
    .param p2, "offset"    # I
    .param p3, "length"    # I

    .line 195
    add-int v7, p2, p3

    .line 196
    .local v7, "endIndex":I
    const-wide/16 v0, -0x1

    if-ltz p2, :cond_d

    array-length v2, p1

    if-le v7, v2, :cond_0

    goto/16 :goto_6

    .line 202
    :cond_0
    invoke-direct {p0, p1, p2, v7}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->skipWhitespace([CII)I

    move-result v2

    .line 203
    .local v2, "index":I
    if-ne v2, v7, :cond_1

    .line 204
    return-wide v0

    .line 206
    :cond_1
    aget-char v3, p1, v2

    .line 210
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

    .line 211
    .local v8, "isNegative":Z
    if-nez v8, :cond_3

    const/16 v4, 0x2b

    if-ne v3, v4, :cond_5

    .line 212
    :cond_3
    add-int/lit8 v2, v2, 0x1

    if-ge v2, v7, :cond_4

    aget-char v4, p1, v2

    goto :goto_1

    :cond_4
    move v4, v5

    :goto_1
    move v3, v4

    .line 213
    if-nez v3, :cond_5

    .line 214
    return-wide v0

    .line 220
    :cond_5
    const/16 v0, 0x49

    if-lt v3, v0, :cond_7

    .line 221
    const/16 v0, 0x4e

    if-ne v3, v0, :cond_6

    .line 222
    invoke-direct {p0, p1, v2, v7}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->parseNaN([CII)J

    move-result-wide v0

    goto :goto_2

    .line 223
    :cond_6
    invoke-direct {p0, p1, v2, v7, v8}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->parseInfinity([CIIZ)J

    move-result-wide v0

    .line 221
    :goto_2
    return-wide v0

    .line 228
    :cond_7
    const/16 v0, 0x30

    if-ne v3, v0, :cond_8

    goto :goto_3

    :cond_8
    move v6, v5

    :goto_3
    move v9, v6

    .line 229
    .local v9, "hasLeadingZero":Z
    if-eqz v9, :cond_c

    .line 230
    add-int/lit8 v6, v2, 0x1

    .end local v2    # "index":I
    .local v6, "index":I
    if-ge v6, v7, :cond_9

    aget-char v5, p1, v6

    :cond_9
    move v10, v5

    .line 231
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

    .line 232
    :cond_b
    :goto_4
    add-int/lit8 v2, v6, 0x1

    move-object v0, p0

    move-object v1, p1

    move v3, p2

    move v4, v7

    move v5, v8

    invoke-direct/range {v0 .. v5}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->parseHexFloatLiteral([CIIIZ)J

    move-result-wide v0

    return-wide v0

    .line 229
    .end local v6    # "index":I
    .end local v10    # "ch":C
    .restart local v2    # "index":I
    .restart local v3    # "ch":C
    :cond_c
    move v10, v2

    move v11, v3

    .line 236
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

    invoke-direct/range {v0 .. v6}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;->parseDecFloatLiteral([CIIIZZ)J

    move-result-wide v0

    return-wide v0

    .line 197
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

.method abstract valueOfFloatLiteral([CIIZJIZI)J
.end method

.method abstract valueOfHexLiteral([CIIZJIZI)J
.end method
