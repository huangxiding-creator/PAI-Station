.class public final Lorg/codehaus/stax2/ri/typed/NumberUtil;
.super Ljava/lang/Object;
.source "NumberUtil.java"


# static fields
.field private static final BILLION:I = 0x3b9aca00

.field private static final BYTE_1:B = 0x31t

.field private static final BYTE_2:B = 0x32t

.field private static final BYTE_HYPHEN:B = 0x2dt

.field static final FULL_TRIPLETS:[C

.field static final LEADING_TRIPLETS:[C

.field public static final MAX_DOUBLE_CLEN:I = 0x20

.field public static final MAX_FLOAT_CLEN:I = 0x20

.field private static MAX_INT_AS_LONG:J = 0x0L

.field public static final MAX_INT_CLEN:I = 0xb

.field public static final MAX_LONG_CLEN:I = 0x15

.field private static final MILLION:I = 0xf4240

.field private static MIN_INT_AS_LONG:J = 0x0L

.field private static final NULL_CHAR:C = '\u0000'

.field private static final TEN_BILLION_L:J = 0x2540be400L

.field private static final THOUSAND_L:J = 0x3e8L


# direct methods
.method static constructor <clinit>()V
    .locals 13

    .line 67
    const-wide/32 v0, -0x7fffffff

    sput-wide v0, Lorg/codehaus/stax2/ri/typed/NumberUtil;->MIN_INT_AS_LONG:J

    .line 69
    const-wide/32 v0, 0x7fffffff

    sput-wide v0, Lorg/codehaus/stax2/ri/typed/NumberUtil;->MAX_INT_AS_LONG:J

    .line 71
    const/16 v0, 0xfa0

    new-array v1, v0, [C

    sput-object v1, Lorg/codehaus/stax2/ri/typed/NumberUtil;->LEADING_TRIPLETS:[C

    .line 72
    new-array v0, v0, [C

    sput-object v0, Lorg/codehaus/stax2/ri/typed/NumberUtil;->FULL_TRIPLETS:[C

    .line 77
    const/4 v0, 0x0

    .line 78
    .local v0, "ix":I
    const/4 v1, 0x0

    .local v1, "i1":I
    :goto_0
    const/16 v2, 0xa

    if-ge v1, v2, :cond_4

    .line 79
    add-int/lit8 v3, v1, 0x30

    int-to-char v3, v3

    .line 80
    .local v3, "f1":C
    const/4 v4, 0x0

    if-nez v1, :cond_0

    move v5, v4

    goto :goto_1

    :cond_0
    move v5, v3

    .line 81
    .local v5, "l1":C
    :goto_1
    const/4 v6, 0x0

    .local v6, "i2":I
    :goto_2
    if-ge v6, v2, :cond_3

    .line 82
    add-int/lit8 v7, v6, 0x30

    int-to-char v7, v7

    .line 83
    .local v7, "f2":C
    if-nez v1, :cond_1

    if-nez v6, :cond_1

    move v8, v4

    goto :goto_3

    :cond_1
    move v8, v7

    .line 84
    .local v8, "l2":C
    :goto_3
    const/4 v9, 0x0

    .local v9, "i3":I
    :goto_4
    if-ge v9, v2, :cond_2

    .line 86
    add-int/lit8 v10, v9, 0x30

    int-to-char v10, v10

    .line 87
    .local v10, "f3":C
    sget-object v11, Lorg/codehaus/stax2/ri/typed/NumberUtil;->LEADING_TRIPLETS:[C

    aput-char v5, v11, v0

    .line 88
    sget-object v11, Lorg/codehaus/stax2/ri/typed/NumberUtil;->LEADING_TRIPLETS:[C

    add-int/lit8 v12, v0, 0x1

    aput-char v8, v11, v12

    .line 89
    sget-object v11, Lorg/codehaus/stax2/ri/typed/NumberUtil;->LEADING_TRIPLETS:[C

    add-int/lit8 v12, v0, 0x2

    aput-char v10, v11, v12

    .line 90
    sget-object v11, Lorg/codehaus/stax2/ri/typed/NumberUtil;->FULL_TRIPLETS:[C

    aput-char v3, v11, v0

    .line 91
    sget-object v11, Lorg/codehaus/stax2/ri/typed/NumberUtil;->FULL_TRIPLETS:[C

    add-int/lit8 v12, v0, 0x1

    aput-char v7, v11, v12

    .line 92
    sget-object v11, Lorg/codehaus/stax2/ri/typed/NumberUtil;->FULL_TRIPLETS:[C

    add-int/lit8 v12, v0, 0x2

    aput-char v10, v11, v12

    .line 93
    nop

    .end local v10    # "f3":C
    add-int/lit8 v0, v0, 0x4

    .line 84
    add-int/lit8 v9, v9, 0x1

    goto :goto_4

    .line 81
    .end local v7    # "f2":C
    .end local v8    # "l2":C
    .end local v9    # "i3":I
    :cond_2
    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    .line 78
    .end local v3    # "f1":C
    .end local v5    # "l1":C
    .end local v6    # "i2":I
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 97
    .end local v0    # "ix":I
    .end local v1    # "i1":I
    :cond_4
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static calcLongStrLength(J)I
    .locals 7
    .param p0, "posValue"    # J

    .line 408
    const/16 v0, 0xa

    .line 409
    .local v0, "len":I
    const-wide v1, 0x2540be400L

    .line 412
    .local v1, "comp":J
    :goto_0
    cmp-long v3, p0, v1

    if-ltz v3, :cond_1

    .line 413
    const/16 v3, 0x13

    if-ne v0, v3, :cond_0

    .line 414
    goto :goto_1

    .line 416
    :cond_0
    add-int/lit8 v0, v0, 0x1

    .line 417
    const/4 v3, 0x3

    shl-long v3, v1, v3

    const/4 v5, 0x1

    shl-long v5, v1, v5

    add-long v1, v3, v5

    goto :goto_0

    .line 419
    :cond_1
    :goto_1
    return v0
.end method

.method private static getAsciiBytes(Ljava/lang/String;[BI)I
    .locals 4
    .param p0, "str"    # Ljava/lang/String;
    .param p1, "buffer"    # [B
    .param p2, "ptr"    # I

    .line 431
    const/4 v0, 0x0

    .local v0, "i":I
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_0

    .line 432
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "ptr":I
    .local v2, "ptr":I
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    int-to-byte v3, v3

    aput-byte v3, p1, p2

    .line 431
    add-int/lit8 v0, v0, 0x1

    move p2, v2

    goto :goto_0

    .line 434
    .end local v0    # "i":I
    .end local v1    # "len":I
    .end local v2    # "ptr":I
    .restart local p2    # "ptr":I
    :cond_0
    return p2
.end method

.method private static getChars(Ljava/lang/String;[CI)I
    .locals 2
    .param p0, "str"    # Ljava/lang/String;
    .param p1, "buffer"    # [C
    .param p2, "ptr"    # I

    .line 424
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 425
    .local v0, "len":I
    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0, p1, p2}, Ljava/lang/String;->getChars(II[CI)V

    .line 426
    add-int v1, p2, v0

    return v1
.end method

.method public static writeDouble(D[BI)I
    .locals 1
    .param p0, "value"    # D
    .param p2, "buffer"    # [B
    .param p3, "offset"    # I

    .line 342
    invoke-static {p0, p1}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p2, p3}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->getAsciiBytes(Ljava/lang/String;[BI)I

    move-result v0

    return v0
.end method

.method public static writeDouble(D[CI)I
    .locals 1
    .param p0, "value"    # D
    .param p2, "buffer"    # [C
    .param p3, "offset"    # I

    .line 337
    invoke-static {p0, p1}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p2, p3}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->getChars(Ljava/lang/String;[CI)I

    move-result v0

    return v0
.end method

.method public static writeFloat(F[BI)I
    .locals 1
    .param p0, "value"    # F
    .param p1, "buffer"    # [B
    .param p2, "offset"    # I

    .line 331
    invoke-static {p0}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->getAsciiBytes(Ljava/lang/String;[BI)I

    move-result v0

    return v0
.end method

.method public static writeFloat(F[CI)I
    .locals 1
    .param p0, "value"    # F
    .param p1, "buffer"    # [C
    .param p2, "offset"    # I

    .line 325
    invoke-static {p0}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->getChars(Ljava/lang/String;[CI)I

    move-result v0

    return v0
.end method

.method private static writeFullTriplet(I[BI)I
    .locals 4
    .param p0, "triplet"    # I
    .param p1, "buffer"    # [B
    .param p2, "offset"    # I

    .line 394
    shl-int/lit8 v0, p0, 0x2

    .line 395
    .local v0, "digitOffset":I
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .local v1, "offset":I
    sget-object v2, Lorg/codehaus/stax2/ri/typed/NumberUtil;->FULL_TRIPLETS:[C

    add-int/lit8 v3, v0, 0x1

    .end local v0    # "digitOffset":I
    .local v3, "digitOffset":I
    aget-char v0, v2, v0

    int-to-byte v0, v0

    aput-byte v0, p1, p2

    .line 396
    add-int/lit8 p2, v1, 0x1

    .end local v1    # "offset":I
    .restart local p2    # "offset":I
    sget-object v0, Lorg/codehaus/stax2/ri/typed/NumberUtil;->FULL_TRIPLETS:[C

    add-int/lit8 v2, v3, 0x1

    .end local v3    # "digitOffset":I
    .local v2, "digitOffset":I
    aget-char v0, v0, v3

    int-to-byte v0, v0

    aput-byte v0, p1, v1

    .line 397
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .local v0, "offset":I
    sget-object v1, Lorg/codehaus/stax2/ri/typed/NumberUtil;->FULL_TRIPLETS:[C

    aget-char v1, v1, v2

    int-to-byte v1, v1

    aput-byte v1, p1, p2

    .line 398
    return v0
.end method

.method private static writeFullTriplet(I[CI)I
    .locals 4
    .param p0, "triplet"    # I
    .param p1, "buffer"    # [C
    .param p2, "offset"    # I

    .line 385
    shl-int/lit8 v0, p0, 0x2

    .line 386
    .local v0, "digitOffset":I
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .local v1, "offset":I
    sget-object v2, Lorg/codehaus/stax2/ri/typed/NumberUtil;->FULL_TRIPLETS:[C

    add-int/lit8 v3, v0, 0x1

    .end local v0    # "digitOffset":I
    .local v3, "digitOffset":I
    aget-char v0, v2, v0

    aput-char v0, p1, p2

    .line 387
    add-int/lit8 p2, v1, 0x1

    .end local v1    # "offset":I
    .restart local p2    # "offset":I
    sget-object v0, Lorg/codehaus/stax2/ri/typed/NumberUtil;->FULL_TRIPLETS:[C

    add-int/lit8 v2, v3, 0x1

    .end local v3    # "digitOffset":I
    .local v2, "digitOffset":I
    aget-char v0, v0, v3

    aput-char v0, p1, v1

    .line 388
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .local v0, "offset":I
    sget-object v1, Lorg/codehaus/stax2/ri/typed/NumberUtil;->FULL_TRIPLETS:[C

    aget-char v1, v1, v2

    aput-char v1, p1, p2

    .line 389
    return v0
.end method

.method public static writeInt(I[BI)I
    .locals 4
    .param p0, "value"    # I
    .param p1, "buffer"    # [B
    .param p2, "offset"    # I

    .line 177
    if-gez p0, :cond_1

    .line 178
    const/high16 v0, -0x80000000

    if-ne p0, v0, :cond_0

    .line 179
    int-to-long v0, p0

    invoke-static {v0, v1, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeLong(J[BI)I

    move-result v0

    return v0

    .line 181
    :cond_0
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .local v0, "offset":I
    const/16 v1, 0x2d

    aput-byte v1, p1, p2

    .line 182
    neg-int p0, p0

    move p2, v0

    .line 184
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_1
    const v0, 0xf4240

    const/16 v1, 0x3e8

    if-ge p0, v0, :cond_4

    .line 185
    if-ge p0, v1, :cond_3

    .line 186
    const/16 v0, 0xa

    if-ge p0, v0, :cond_2

    .line 187
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .restart local v0    # "offset":I
    add-int/lit8 v1, p0, 0x30

    int-to-byte v1, v1

    aput-byte v1, p1, p2

    goto :goto_0

    .line 189
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_2
    invoke-static {p0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeLeadingTriplet(I[BI)I

    move-result v0

    .end local p2    # "offset":I
    .restart local v0    # "offset":I
    goto :goto_0

    .line 192
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_3
    div-int/lit16 v0, p0, 0x3e8

    .line 193
    .local v0, "thousands":I
    mul-int/lit16 v1, v0, 0x3e8

    sub-int/2addr p0, v1

    .line 194
    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeLeadingTriplet(I[BI)I

    move-result p2

    .line 195
    invoke-static {p0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[BI)I

    move-result p2

    move v0, p2

    .line 197
    .end local p2    # "offset":I
    .local v0, "offset":I
    :goto_0
    return v0

    .line 199
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_4
    const v0, 0x3b9aca00

    if-lt p0, v0, :cond_5

    const/4 v2, 0x1

    goto :goto_1

    :cond_5
    const/4 v2, 0x0

    .line 200
    .local v2, "hasBillions":Z
    :goto_1
    if-eqz v2, :cond_7

    .line 201
    sub-int/2addr p0, v0

    .line 202
    if-lt p0, v0, :cond_6

    .line 203
    sub-int/2addr p0, v0

    .line 204
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .restart local v0    # "offset":I
    const/16 v3, 0x32

    aput-byte v3, p1, p2

    move p2, v0

    goto :goto_2

    .line 206
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_6
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .restart local v0    # "offset":I
    const/16 v3, 0x31

    aput-byte v3, p1, p2

    move p2, v0

    .line 209
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_7
    :goto_2
    div-int/lit16 v0, p0, 0x3e8

    .line 210
    .local v0, "newValue":I
    mul-int/lit16 v3, v0, 0x3e8

    sub-int v3, p0, v3

    .line 211
    .local v3, "ones":I
    move p0, v0

    .line 212
    div-int/2addr v0, v1

    .line 213
    mul-int/lit16 v1, v0, 0x3e8

    sub-int v1, p0, v1

    .line 216
    .local v1, "thousands":I
    if-eqz v2, :cond_8

    .line 217
    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[BI)I

    move-result p2

    goto :goto_3

    .line 219
    :cond_8
    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeLeadingTriplet(I[BI)I

    move-result p2

    .line 221
    :goto_3
    invoke-static {v1, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[BI)I

    move-result p2

    .line 222
    invoke-static {v3, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[BI)I

    move-result p2

    .line 223
    return p2
.end method

.method public static writeInt(I[CI)I
    .locals 4
    .param p0, "value"    # I
    .param p1, "buffer"    # [C
    .param p2, "offset"    # I

    .line 114
    if-gez p0, :cond_1

    .line 116
    const/high16 v0, -0x80000000

    if-ne p0, v0, :cond_0

    .line 120
    int-to-long v0, p0

    invoke-static {v0, v1, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeLong(J[CI)I

    move-result v0

    return v0

    .line 122
    :cond_0
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .local v0, "offset":I
    const/16 v1, 0x2d

    aput-char v1, p1, p2

    .line 123
    neg-int p0, p0

    move p2, v0

    .line 126
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_1
    const v0, 0xf4240

    const/16 v1, 0x3e8

    if-ge p0, v0, :cond_4

    .line 127
    if-ge p0, v1, :cond_3

    .line 128
    const/16 v0, 0xa

    if-ge p0, v0, :cond_2

    .line 129
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .restart local v0    # "offset":I
    add-int/lit8 v1, p0, 0x30

    int-to-char v1, v1

    aput-char v1, p1, p2

    goto :goto_0

    .line 131
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_2
    invoke-static {p0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeLeadingTriplet(I[CI)I

    move-result v0

    .end local p2    # "offset":I
    .restart local v0    # "offset":I
    goto :goto_0

    .line 134
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_3
    div-int/lit16 v0, p0, 0x3e8

    .line 135
    .local v0, "thousands":I
    mul-int/lit16 v1, v0, 0x3e8

    sub-int/2addr p0, v1

    .line 136
    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeLeadingTriplet(I[CI)I

    move-result p2

    .line 137
    invoke-static {p0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[CI)I

    move-result p2

    move v0, p2

    .line 139
    .end local p2    # "offset":I
    .local v0, "offset":I
    :goto_0
    return v0

    .line 147
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_4
    const v0, 0x3b9aca00

    if-lt p0, v0, :cond_5

    const/4 v2, 0x1

    goto :goto_1

    :cond_5
    const/4 v2, 0x0

    .line 148
    .local v2, "hasBillions":Z
    :goto_1
    if-eqz v2, :cond_7

    .line 149
    sub-int/2addr p0, v0

    .line 150
    if-lt p0, v0, :cond_6

    .line 151
    sub-int/2addr p0, v0

    .line 152
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .restart local v0    # "offset":I
    const/16 v3, 0x32

    aput-char v3, p1, p2

    move p2, v0

    goto :goto_2

    .line 154
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_6
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .restart local v0    # "offset":I
    const/16 v3, 0x31

    aput-char v3, p1, p2

    move p2, v0

    .line 157
    .end local v0    # "offset":I
    .restart local p2    # "offset":I
    :cond_7
    :goto_2
    div-int/lit16 v0, p0, 0x3e8

    .line 158
    .local v0, "newValue":I
    mul-int/lit16 v3, v0, 0x3e8

    sub-int v3, p0, v3

    .line 159
    .local v3, "ones":I
    move p0, v0

    .line 160
    div-int/2addr v0, v1

    .line 161
    mul-int/lit16 v1, v0, 0x3e8

    sub-int v1, p0, v1

    .line 164
    .local v1, "thousands":I
    if-eqz v2, :cond_8

    .line 165
    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[CI)I

    move-result p2

    goto :goto_3

    .line 167
    :cond_8
    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeLeadingTriplet(I[CI)I

    move-result p2

    .line 169
    :goto_3
    invoke-static {v1, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[CI)I

    move-result p2

    .line 170
    invoke-static {v3, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[CI)I

    move-result p2

    .line 171
    return p2
.end method

.method private static writeLeadingTriplet(I[BI)I
    .locals 4
    .param p0, "triplet"    # I
    .param p1, "buffer"    # [B
    .param p2, "offset"    # I

    .line 369
    shl-int/lit8 v0, p0, 0x2

    .line 370
    .local v0, "digitOffset":I
    sget-object v1, Lorg/codehaus/stax2/ri/typed/NumberUtil;->LEADING_TRIPLETS:[C

    add-int/lit8 v2, v0, 0x1

    .end local v0    # "digitOffset":I
    .local v2, "digitOffset":I
    aget-char v0, v1, v0

    .line 371
    .local v0, "c":C
    if-eqz v0, :cond_0

    .line 372
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .local v1, "offset":I
    int-to-byte v3, v0

    aput-byte v3, p1, p2

    move p2, v1

    .line 374
    .end local v1    # "offset":I
    .restart local p2    # "offset":I
    :cond_0
    sget-object v1, Lorg/codehaus/stax2/ri/typed/NumberUtil;->LEADING_TRIPLETS:[C

    add-int/lit8 v3, v2, 0x1

    .end local v2    # "digitOffset":I
    .local v3, "digitOffset":I
    aget-char v0, v1, v2

    .line 375
    if-eqz v0, :cond_1

    .line 376
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .restart local v1    # "offset":I
    int-to-byte v2, v0

    aput-byte v2, p1, p2

    move p2, v1

    .line 379
    .end local v1    # "offset":I
    .restart local p2    # "offset":I
    :cond_1
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .restart local v1    # "offset":I
    sget-object v2, Lorg/codehaus/stax2/ri/typed/NumberUtil;->LEADING_TRIPLETS:[C

    aget-char v2, v2, v3

    int-to-byte v2, v2

    aput-byte v2, p1, p2

    .line 380
    return v1
.end method

.method private static writeLeadingTriplet(I[CI)I
    .locals 4
    .param p0, "triplet"    # I
    .param p1, "buffer"    # [C
    .param p2, "offset"    # I

    .line 353
    shl-int/lit8 v0, p0, 0x2

    .line 354
    .local v0, "digitOffset":I
    sget-object v1, Lorg/codehaus/stax2/ri/typed/NumberUtil;->LEADING_TRIPLETS:[C

    add-int/lit8 v2, v0, 0x1

    .end local v0    # "digitOffset":I
    .local v2, "digitOffset":I
    aget-char v0, v1, v0

    .line 355
    .local v0, "c":C
    if-eqz v0, :cond_0

    .line 356
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .local v1, "offset":I
    aput-char v0, p1, p2

    move p2, v1

    .line 358
    .end local v1    # "offset":I
    .restart local p2    # "offset":I
    :cond_0
    sget-object v1, Lorg/codehaus/stax2/ri/typed/NumberUtil;->LEADING_TRIPLETS:[C

    add-int/lit8 v3, v2, 0x1

    .end local v2    # "digitOffset":I
    .local v3, "digitOffset":I
    aget-char v0, v1, v2

    .line 359
    if-eqz v0, :cond_1

    .line 360
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .restart local v1    # "offset":I
    aput-char v0, p1, p2

    move p2, v1

    .line 363
    .end local v1    # "offset":I
    .restart local p2    # "offset":I
    :cond_1
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .restart local v1    # "offset":I
    sget-object v2, Lorg/codehaus/stax2/ri/typed/NumberUtil;->LEADING_TRIPLETS:[C

    aget-char v2, v2, v3

    aput-char v2, p1, p2

    .line 364
    return v1
.end method

.method public static writeLong(J[BI)I
    .locals 6
    .param p0, "value"    # J
    .param p2, "buffer"    # [B
    .param p3, "offset"    # I

    .line 285
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-gez v0, :cond_2

    .line 286
    sget-wide v0, Lorg/codehaus/stax2/ri/typed/NumberUtil;->MIN_INT_AS_LONG:J

    cmp-long v0, p0, v0

    if-ltz v0, :cond_0

    .line 287
    long-to-int v0, p0

    invoke-static {v0, p2, p3}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeInt(I[BI)I

    move-result v0

    return v0

    .line 289
    :cond_0
    const-wide/high16 v0, -0x8000000000000000L

    cmp-long v0, p0, v0

    if-nez v0, :cond_1

    .line 290
    invoke-static {p0, p1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p2, p3}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->getAsciiBytes(Ljava/lang/String;[BI)I

    move-result v0

    return v0

    .line 292
    :cond_1
    add-int/lit8 v0, p3, 0x1

    .end local p3    # "offset":I
    .local v0, "offset":I
    const/16 v1, 0x2d

    aput-byte v1, p2, p3

    .line 293
    neg-long p0, p0

    move p3, v0

    goto :goto_0

    .line 295
    .end local v0    # "offset":I
    .restart local p3    # "offset":I
    :cond_2
    sget-wide v0, Lorg/codehaus/stax2/ri/typed/NumberUtil;->MAX_INT_AS_LONG:J

    cmp-long v0, p0, v0

    if-gtz v0, :cond_3

    .line 296
    long-to-int v0, p0

    invoke-static {v0, p2, p3}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeInt(I[BI)I

    move-result v0

    return v0

    .line 299
    :cond_3
    :goto_0
    move v0, p3

    .line 300
    .local v0, "origOffset":I
    invoke-static {p0, p1}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->calcLongStrLength(J)I

    move-result v1

    add-int/2addr p3, v1

    .line 301
    move v1, p3

    .line 303
    .local v1, "ptr":I
    :goto_1
    sget-wide v2, Lorg/codehaus/stax2/ri/typed/NumberUtil;->MAX_INT_AS_LONG:J

    cmp-long v2, p0, v2

    if-lez v2, :cond_4

    .line 304
    add-int/lit8 v1, v1, -0x3

    .line 305
    const-wide/16 v2, 0x3e8

    div-long v4, p0, v2

    .line 306
    .local v4, "newValue":J
    mul-long/2addr v2, v4

    sub-long v2, p0, v2

    long-to-int v2, v2

    .line 307
    .local v2, "triplet":I
    invoke-static {v2, p2, v1}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[BI)I

    .line 308
    move-wide p0, v4

    .line 309
    .end local v2    # "triplet":I
    .end local v4    # "newValue":J
    goto :goto_1

    .line 310
    :cond_4
    long-to-int v2, p0

    .line 311
    .local v2, "ivalue":I
    :goto_2
    const/16 v3, 0x3e8

    if-lt v2, v3, :cond_5

    .line 312
    add-int/lit8 v1, v1, -0x3

    .line 313
    div-int/lit16 v3, v2, 0x3e8

    .line 314
    .local v3, "newValue":I
    mul-int/lit16 v4, v3, 0x3e8

    sub-int v4, v2, v4

    .line 315
    .local v4, "triplet":I
    invoke-static {v4, p2, v1}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[BI)I

    .line 316
    move v2, v3

    .line 317
    .end local v3    # "newValue":I
    .end local v4    # "triplet":I
    goto :goto_2

    .line 318
    :cond_5
    invoke-static {v2, p2, v0}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeLeadingTriplet(I[BI)I

    .line 319
    return p3
.end method

.method public static writeLong(J[CI)I
    .locals 6
    .param p0, "value"    # J
    .param p2, "buffer"    # [C
    .param p3, "offset"    # I

    .line 236
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-gez v0, :cond_2

    .line 237
    sget-wide v0, Lorg/codehaus/stax2/ri/typed/NumberUtil;->MIN_INT_AS_LONG:J

    cmp-long v0, p0, v0

    if-ltz v0, :cond_0

    .line 238
    long-to-int v0, p0

    invoke-static {v0, p2, p3}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeInt(I[CI)I

    move-result v0

    return v0

    .line 240
    :cond_0
    const-wide/high16 v0, -0x8000000000000000L

    cmp-long v0, p0, v0

    if-nez v0, :cond_1

    .line 242
    invoke-static {p0, p1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p2, p3}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->getChars(Ljava/lang/String;[CI)I

    move-result v0

    return v0

    .line 244
    :cond_1
    add-int/lit8 v0, p3, 0x1

    .end local p3    # "offset":I
    .local v0, "offset":I
    const/16 v1, 0x2d

    aput-char v1, p2, p3

    .line 245
    neg-long p0, p0

    move p3, v0

    goto :goto_0

    .line 247
    .end local v0    # "offset":I
    .restart local p3    # "offset":I
    :cond_2
    sget-wide v0, Lorg/codehaus/stax2/ri/typed/NumberUtil;->MAX_INT_AS_LONG:J

    cmp-long v0, p0, v0

    if-gtz v0, :cond_3

    .line 248
    long-to-int v0, p0

    invoke-static {v0, p2, p3}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeInt(I[CI)I

    move-result v0

    return v0

    .line 255
    :cond_3
    :goto_0
    move v0, p3

    .line 256
    .local v0, "origOffset":I
    invoke-static {p0, p1}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->calcLongStrLength(J)I

    move-result v1

    add-int/2addr p3, v1

    .line 257
    move v1, p3

    .line 260
    .local v1, "ptr":I
    :goto_1
    sget-wide v2, Lorg/codehaus/stax2/ri/typed/NumberUtil;->MAX_INT_AS_LONG:J

    cmp-long v2, p0, v2

    if-lez v2, :cond_4

    .line 261
    add-int/lit8 v1, v1, -0x3

    .line 262
    const-wide/16 v2, 0x3e8

    div-long v4, p0, v2

    .line 263
    .local v4, "newValue":J
    mul-long/2addr v2, v4

    sub-long v2, p0, v2

    long-to-int v2, v2

    .line 264
    .local v2, "triplet":I
    invoke-static {v2, p2, v1}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[CI)I

    .line 265
    move-wide p0, v4

    .line 266
    .end local v2    # "triplet":I
    .end local v4    # "newValue":J
    goto :goto_1

    .line 268
    :cond_4
    long-to-int v2, p0

    .line 269
    .local v2, "ivalue":I
    :goto_2
    const/16 v3, 0x3e8

    if-lt v2, v3, :cond_5

    .line 270
    add-int/lit8 v1, v1, -0x3

    .line 271
    div-int/lit16 v3, v2, 0x3e8

    .line 272
    .local v3, "newValue":I
    mul-int/lit16 v4, v3, 0x3e8

    sub-int v4, v2, v4

    .line 273
    .local v4, "triplet":I
    invoke-static {v4, p2, v1}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFullTriplet(I[CI)I

    .line 274
    move v2, v3

    .line 275
    .end local v3    # "newValue":I
    .end local v4    # "triplet":I
    goto :goto_2

    .line 277
    :cond_5
    invoke-static {v2, p2, v0}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeLeadingTriplet(I[CI)I

    .line 279
    return p3
.end method
