.class public final Lcom/fasterxml/jackson/core/io/BigDecimalParser;
.super Ljava/lang/Object;
.source "BigDecimalParser.java"


# static fields
.field private static final MAX_CHARS_TO_REPORT:I = 0x3e8


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static adjustScale(IJ)I
    .locals 5
    .param p0, "scale"    # I
    .param p1, "exp"    # J

    .line 162
    int-to-long v0, p0

    sub-long/2addr v0, p1

    .line 163
    .local v0, "adjScale":J
    const-wide/32 v2, 0x7fffffff

    cmp-long v2, v0, v2

    if-gtz v2, :cond_0

    const-wide/32 v2, -0x80000000

    cmp-long v2, v0, v2

    if-ltz v2, :cond_0

    .line 168
    long-to-int v2, v0

    return v2

    .line 164
    :cond_0
    new-instance v2, Ljava/lang/NumberFormatException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Scale out of range: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " while adjusting scale "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " to exponent "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public static parse(Ljava/lang/String;)Ljava/math/BigDecimal;
    .locals 1
    .param p0, "valueStr"    # Ljava/lang/String;

    .line 29
    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    invoke-static {v0}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->parse([C)Ljava/math/BigDecimal;

    move-result-object v0

    return-object v0
.end method

.method public static parse([C)Ljava/math/BigDecimal;
    .locals 2
    .param p0, "chars"    # [C

    .line 60
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->parse([CII)Ljava/math/BigDecimal;

    move-result-object v0

    return-object v0
.end method

.method public static parse([CII)Ljava/math/BigDecimal;
    .locals 6
    .param p0, "chars"    # [C
    .param p1, "off"    # I
    .param p2, "len"    # I

    .line 34
    const/16 v0, 0x1f4

    if-ge p2, v0, :cond_0

    .line 35
    :try_start_0
    new-instance v0, Ljava/math/BigDecimal;

    invoke-direct {v0, p0, p1, p2}, Ljava/math/BigDecimal;-><init>([CII)V

    return-object v0

    .line 37
    :cond_0
    div-int/lit8 v0, p2, 0xa

    invoke-static {p0, p1, p2, v0}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->parseBigDecimal([CIII)Ljava/math/BigDecimal;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/ArithmeticException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 41
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 42
    .local v0, "e":Ljava/lang/RuntimeException;
    :goto_0
    invoke-virtual {v0}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object v1

    .line 44
    .local v1, "desc":Ljava/lang/String;
    if-nez v1, :cond_1

    .line 45
    const-string v1, "Not a valid number representation"

    .line 48
    :cond_1
    const/16 v2, 0x3e8

    if-gt p2, v2, :cond_2

    .line 49
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, p0, p1, p2}, Ljava/lang/String;-><init>([CII)V

    .local v2, "stringToReport":Ljava/lang/String;
    goto :goto_1

    .line 51
    .end local v2    # "stringToReport":Ljava/lang/String;
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v4, Ljava/lang/String;

    invoke-static {p0, p1, v2}, Ljava/util/Arrays;->copyOfRange([CII)[C

    move-result-object v2

    invoke-direct {v4, v2}, Ljava/lang/String;-><init>([C)V

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "(truncated, full length is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    array-length v3, p0

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " chars)"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 54
    .restart local v2    # "stringToReport":Ljava/lang/String;
    :goto_1
    new-instance v3, Ljava/lang/NumberFormatException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Value \""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\" can not be represented as `java.math.BigDecimal`, reason: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method private static parseBigDecimal([CIII)Ljava/math/BigDecimal;
    .locals 17
    .param p0, "chars"    # [C
    .param p1, "off"    # I
    .param p2, "len"    # I
    .param p3, "splitLen"    # I

    .line 64
    move-object/from16 v0, p0

    move/from16 v1, p3

    const/4 v2, 0x0

    .line 65
    .local v2, "numHasSign":Z
    const/4 v3, 0x0

    .line 66
    .local v3, "expHasSign":Z
    const/4 v4, 0x0

    .line 67
    .local v4, "neg":Z
    move/from16 v5, p1

    .line 68
    .local v5, "numIdx":I
    const/4 v6, -0x1

    .line 69
    .local v6, "expIdx":I
    const/4 v7, -0x1

    .line 70
    .local v7, "dotIdx":I
    const/4 v8, 0x0

    .line 71
    .local v8, "scale":I
    add-int v9, p1, p2

    .line 73
    .local v9, "endIdx":I
    move/from16 v10, p1

    .local v10, "i":I
    :goto_0
    if-ge v10, v9, :cond_9

    .line 74
    aget-char v11, v0, v10

    .line 75
    .local v11, "c":C
    const-string v12, "Multiple signs in exponent"

    const-string v13, "Multiple signs in number"

    sparse-switch v11, :sswitch_data_0

    .line 119
    if-ltz v7, :cond_8

    const/4 v12, -0x1

    if-ne v6, v12, :cond_8

    .line 120
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 107
    :sswitch_0
    if-gez v6, :cond_0

    .line 110
    move v6, v10

    .line 111
    goto :goto_1

    .line 108
    :cond_0
    new-instance v12, Ljava/lang/NumberFormatException;

    const-string v13, "Multiple exponent markers"

    invoke-direct {v12, v13}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v12

    .line 113
    :sswitch_1
    if-gez v7, :cond_1

    .line 116
    move v7, v10

    .line 117
    goto :goto_1

    .line 114
    :cond_1
    new-instance v12, Ljava/lang/NumberFormatException;

    const-string v13, "Multiple decimal points"

    invoke-direct {v12, v13}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v12

    .line 91
    :sswitch_2
    if-ltz v6, :cond_3

    .line 92
    if-nez v3, :cond_2

    .line 95
    const/4 v3, 0x1

    goto :goto_1

    .line 93
    :cond_2
    new-instance v13, Ljava/lang/NumberFormatException;

    invoke-direct {v13, v12}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v13

    .line 97
    :cond_3
    if-nez v2, :cond_4

    .line 100
    const/4 v2, 0x1

    .line 101
    const/4 v4, 0x1

    .line 102
    add-int/lit8 v5, v10, 0x1

    .line 104
    goto :goto_1

    .line 98
    :cond_4
    new-instance v12, Ljava/lang/NumberFormatException;

    invoke-direct {v12, v13}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v12

    .line 77
    :sswitch_3
    if-ltz v6, :cond_6

    .line 78
    if-nez v3, :cond_5

    .line 81
    const/4 v3, 0x1

    goto :goto_1

    .line 79
    :cond_5
    new-instance v13, Ljava/lang/NumberFormatException;

    invoke-direct {v13, v12}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v13

    .line 83
    :cond_6
    if-nez v2, :cond_7

    .line 86
    const/4 v2, 0x1

    .line 87
    add-int/lit8 v5, v10, 0x1

    .line 89
    goto :goto_1

    .line 84
    :cond_7
    new-instance v12, Ljava/lang/NumberFormatException;

    invoke-direct {v12, v13}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v12

    .line 73
    .end local v11    # "c":C
    :cond_8
    :goto_1
    add-int/lit8 v10, v10, 0x1

    goto :goto_0

    .line 126
    .end local v10    # "i":I
    :cond_9
    const/4 v10, 0x0

    .line 127
    .local v10, "exp":I
    if-ltz v6, :cond_a

    .line 128
    move v11, v6

    .line 129
    .local v11, "numEndIdx":I
    new-instance v12, Ljava/lang/String;

    add-int/lit8 v13, v6, 0x1

    sub-int v14, v9, v6

    add-int/lit8 v14, v14, -0x1

    invoke-direct {v12, v0, v13, v14}, Ljava/lang/String;-><init>([CII)V

    .line 130
    .local v12, "expStr":Ljava/lang/String;
    invoke-static {v12}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v10

    .line 131
    int-to-long v13, v10

    invoke-static {v8, v13, v14}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->adjustScale(IJ)I

    move-result v8

    .line 132
    .end local v12    # "expStr":Ljava/lang/String;
    goto :goto_2

    .line 133
    .end local v11    # "numEndIdx":I
    :cond_a
    move v11, v9

    .line 138
    .restart local v11    # "numEndIdx":I
    :goto_2
    if-ltz v7, :cond_b

    .line 139
    sub-int v12, v7, v5

    .line 140
    .local v12, "leftLen":I
    invoke-static {v0, v5, v12, v10, v1}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->toBigDecimalRec([CIIII)Ljava/math/BigDecimal;

    move-result-object v13

    .line 142
    .local v13, "left":Ljava/math/BigDecimal;
    sub-int v14, v11, v7

    add-int/lit8 v14, v14, -0x1

    .line 143
    .local v14, "rightLen":I
    add-int/lit8 v15, v7, 0x1

    move/from16 v16, v2

    .end local v2    # "numHasSign":Z
    .local v16, "numHasSign":Z
    sub-int v2, v10, v14

    invoke-static {v0, v15, v14, v2, v1}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->toBigDecimalRec([CIIII)Ljava/math/BigDecimal;

    move-result-object v2

    .line 145
    .local v2, "right":Ljava/math/BigDecimal;
    invoke-virtual {v13, v2}, Ljava/math/BigDecimal;->add(Ljava/math/BigDecimal;)Ljava/math/BigDecimal;

    move-result-object v2

    .line 146
    .end local v12    # "leftLen":I
    .end local v13    # "left":Ljava/math/BigDecimal;
    .end local v14    # "rightLen":I
    .local v2, "res":Ljava/math/BigDecimal;
    goto :goto_3

    .line 147
    .end local v16    # "numHasSign":Z
    .local v2, "numHasSign":Z
    :cond_b
    move/from16 v16, v2

    .end local v2    # "numHasSign":Z
    .restart local v16    # "numHasSign":Z
    sub-int v2, v11, v5

    invoke-static {v0, v5, v2, v10, v1}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->toBigDecimalRec([CIIII)Ljava/math/BigDecimal;

    move-result-object v2

    .line 150
    .local v2, "res":Ljava/math/BigDecimal;
    :goto_3
    if-eqz v8, :cond_c

    .line 151
    invoke-virtual {v2, v8}, Ljava/math/BigDecimal;->setScale(I)Ljava/math/BigDecimal;

    move-result-object v2

    .line 154
    :cond_c
    if-eqz v4, :cond_d

    .line 155
    invoke-virtual {v2}, Ljava/math/BigDecimal;->negate()Ljava/math/BigDecimal;

    move-result-object v2

    .line 158
    :cond_d
    return-object v2

    nop

    :sswitch_data_0
    .sparse-switch
        0x2b -> :sswitch_3
        0x2d -> :sswitch_2
        0x2e -> :sswitch_1
        0x45 -> :sswitch_0
        0x65 -> :sswitch_0
    .end sparse-switch
.end method

.method private static toBigDecimalRec([CIIII)Ljava/math/BigDecimal;
    .locals 4
    .param p0, "chars"    # [C
    .param p1, "off"    # I
    .param p2, "len"    # I
    .param p3, "scale"    # I
    .param p4, "splitLen"    # I

    .line 173
    if-le p2, p4, :cond_0

    .line 174
    div-int/lit8 v0, p2, 0x2

    .line 175
    .local v0, "mid":I
    add-int v1, p3, p2

    sub-int/2addr v1, v0

    invoke-static {p0, p1, v0, v1, p4}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->toBigDecimalRec([CIIII)Ljava/math/BigDecimal;

    move-result-object v1

    .line 176
    .local v1, "left":Ljava/math/BigDecimal;
    add-int v2, p1, v0

    sub-int v3, p2, v0

    invoke-static {p0, v2, v3, p3, p4}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->toBigDecimalRec([CIIII)Ljava/math/BigDecimal;

    move-result-object v2

    .line 178
    .local v2, "right":Ljava/math/BigDecimal;
    invoke-virtual {v1, v2}, Ljava/math/BigDecimal;->add(Ljava/math/BigDecimal;)Ljava/math/BigDecimal;

    move-result-object v3

    return-object v3

    .line 181
    .end local v0    # "mid":I
    .end local v1    # "left":Ljava/math/BigDecimal;
    .end local v2    # "right":Ljava/math/BigDecimal;
    :cond_0
    if-nez p2, :cond_1

    sget-object v0, Ljava/math/BigDecimal;->ZERO:Ljava/math/BigDecimal;

    goto :goto_0

    :cond_1
    new-instance v0, Ljava/math/BigDecimal;

    invoke-direct {v0, p0, p1, p2}, Ljava/math/BigDecimal;-><init>([CII)V

    invoke-virtual {v0, p3}, Ljava/math/BigDecimal;->movePointRight(I)Ljava/math/BigDecimal;

    move-result-object v0

    :goto_0
    return-object v0
.end method
