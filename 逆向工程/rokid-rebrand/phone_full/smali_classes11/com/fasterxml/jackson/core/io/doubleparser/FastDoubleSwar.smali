.class Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleSwar;
.super Ljava/lang/Object;
.source "FastDoubleSwar.java"


# direct methods
.method constructor <init>()V
    .locals 0

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static readLongFromByteArrayBigEndian([BI)J
    .locals 7
    .param p0, "a"    # [B
    .param p1, "offset"    # I

    .line 320
    aget-byte v0, p0, p1

    int-to-long v0, v0

    const-wide/16 v2, 0xff

    and-long/2addr v0, v2

    const/16 v4, 0x38

    shl-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x1

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x30

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x2

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x28

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x3

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x20

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x4

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x18

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x5

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x10

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x6

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x8

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x7

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v2, v4

    or-long/2addr v0, v2

    return-wide v0
.end method

.method public static readLongFromByteArrayLittleEndian([BI)J
    .locals 7
    .param p0, "a"    # [B
    .param p1, "offset"    # I

    .line 309
    add-int/lit8 v0, p1, 0x7

    aget-byte v0, p0, v0

    int-to-long v0, v0

    const-wide/16 v2, 0xff

    and-long/2addr v0, v2

    const/16 v4, 0x38

    shl-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x6

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x30

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x5

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x28

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x4

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x20

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x3

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x18

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x2

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x10

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    add-int/lit8 v4, p1, 0x1

    aget-byte v4, p0, v4

    int-to-long v4, v4

    and-long/2addr v4, v2

    const/16 v6, 0x8

    shl-long/2addr v4, v6

    or-long/2addr v0, v4

    aget-byte v4, p0, p1

    int-to-long v4, v4

    and-long/2addr v2, v4

    or-long/2addr v0, v2

    return-wide v0
.end method

.method public static tryToParseEightDigitsUtf16(JJ)I
    .locals 13
    .param p0, "first"    # J
    .param p2, "second"    # J

    .line 75
    const-wide v0, 0x30003000300030L

    sub-long v2, p0, v0

    .line 76
    .local v2, "fval":J
    sub-long v0, p2, v0

    .line 82
    .local v0, "sval":J
    const-wide v4, 0x46004600460046L    # 2.447700077935472E-307

    add-long v6, p0, v4

    or-long/2addr v6, v2

    .line 83
    .local v6, "fpre":J
    add-long/2addr v4, p2

    or-long/2addr v4, v0

    .line 84
    .local v4, "spre":J
    or-long v8, v6, v4

    const-wide v10, -0x7f007f007f0080L

    and-long/2addr v8, v10

    const-wide/16 v10, 0x0

    cmp-long v8, v8, v10

    if-eqz v8, :cond_0

    .line 85
    const/4 v8, -0x1

    return v8

    .line 88
    :cond_0
    const-wide v8, 0x3e80064000a0001L

    mul-long v10, v0, v8

    const/16 v12, 0x30

    ushr-long/2addr v10, v12

    long-to-int v10, v10

    mul-long/2addr v8, v2

    ushr-long/2addr v8, v12

    long-to-int v8, v8

    mul-int/lit16 v8, v8, 0x2710

    add-int/2addr v10, v8

    return v10
.end method

.method public static tryToParseEightDigitsUtf16([CI)I
    .locals 9
    .param p0, "a"    # [C
    .param p1, "offset"    # I

    .line 48
    aget-char v0, p0, p1

    int-to-long v0, v0

    add-int/lit8 v2, p1, 0x1

    aget-char v2, p0, v2

    int-to-long v2, v2

    const/16 v4, 0x10

    shl-long/2addr v2, v4

    or-long/2addr v0, v2

    add-int/lit8 v2, p1, 0x2

    aget-char v2, p0, v2

    int-to-long v2, v2

    const/16 v5, 0x20

    shl-long/2addr v2, v5

    or-long/2addr v0, v2

    add-int/lit8 v2, p1, 0x3

    aget-char v2, p0, v2

    int-to-long v2, v2

    const/16 v6, 0x30

    shl-long/2addr v2, v6

    or-long/2addr v0, v2

    .line 52
    .local v0, "first":J
    add-int/lit8 v2, p1, 0x4

    aget-char v2, p0, v2

    int-to-long v2, v2

    add-int/lit8 v7, p1, 0x5

    aget-char v7, p0, v7

    int-to-long v7, v7

    shl-long/2addr v7, v4

    or-long/2addr v2, v7

    add-int/lit8 v4, p1, 0x6

    aget-char v4, p0, v4

    int-to-long v7, v4

    shl-long v4, v7, v5

    or-long/2addr v2, v4

    add-int/lit8 v4, p1, 0x7

    aget-char v4, p0, v4

    int-to-long v4, v4

    shl-long/2addr v4, v6

    or-long/2addr v2, v4

    .line 57
    .local v2, "second":J
    invoke-static {v0, v1, v2, v3}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleSwar;->tryToParseEightDigitsUtf16(JJ)I

    move-result v4

    return v4
.end method

.method public static tryToParseEightDigitsUtf8(J)I
    .locals 10
    .param p0, "chunk"    # J

    .line 128
    const-wide v0, 0x3030303030303030L    # 1.398043286095289E-76

    sub-long v0, p0, v0

    .line 129
    .local v0, "val":J
    const-wide v2, 0x4646464646464646L    # 3.5295369653413445E30

    add-long/2addr v2, p0

    or-long/2addr v2, v0

    const-wide v4, -0x7f7f7f7f7f7f7f80L    # -2.937446524422997E-306

    and-long/2addr v2, v4

    .line 130
    .local v2, "predicate":J
    const-wide/16 v4, 0x0

    cmp-long v4, v2, v4

    if-eqz v4, :cond_0

    .line 131
    const/4 v4, -0x1

    return v4

    .line 135
    :cond_0
    const-wide/16 v4, 0xa01

    mul-long/2addr v4, v0

    const/16 v6, 0x8

    ushr-long v0, v4, v6

    .line 136
    const-wide v4, 0xff000000ffL

    and-long v6, v0, v4

    const-wide v8, 0xf424000000064L

    mul-long/2addr v6, v8

    const/16 v8, 0x10

    ushr-long v8, v0, v8

    and-long/2addr v4, v8

    const-wide v8, 0x271000000001L

    mul-long/2addr v4, v8

    add-long/2addr v6, v4

    const/16 v4, 0x20

    ushr-long v0, v6, v4

    .line 138
    long-to-int v4, v0

    return v4
.end method

.method public static tryToParseEightDigitsUtf8([BI)I
    .locals 2
    .param p0, "a"    # [B
    .param p1, "offset"    # I

    .line 102
    invoke-static {p0, p1}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleSwar;->readLongFromByteArrayLittleEndian([BI)J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleSwar;->tryToParseEightDigitsUtf8(J)I

    move-result v0

    return v0
.end method

.method public static tryToParseEightHexDigitsUtf16(JJ)J
    .locals 6
    .param p0, "first"    # J
    .param p2, "second"    # J

    .line 189
    invoke-static {p0, p1}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleSwar;->tryToParseFourHexDigitsUtf16(J)J

    move-result-wide v0

    .line 190
    .local v0, "lfirst":J
    invoke-static {p2, p3}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleSwar;->tryToParseFourHexDigitsUtf16(J)J

    move-result-wide v2

    .line 191
    .local v2, "lsecond":J
    const/16 v4, 0x10

    shl-long v4, v0, v4

    or-long/2addr v4, v2

    return-wide v4
.end method

.method public static tryToParseEightHexDigitsUtf16([CI)J
    .locals 9
    .param p0, "a"    # [C
    .param p1, "offset"    # I

    .line 153
    aget-char v0, p0, p1

    int-to-long v0, v0

    const/16 v2, 0x30

    shl-long/2addr v0, v2

    add-int/lit8 v3, p1, 0x1

    aget-char v3, p0, v3

    int-to-long v3, v3

    const/16 v5, 0x20

    shl-long/2addr v3, v5

    or-long/2addr v0, v3

    add-int/lit8 v3, p1, 0x2

    aget-char v3, p0, v3

    int-to-long v3, v3

    const/16 v6, 0x10

    shl-long/2addr v3, v6

    or-long/2addr v0, v3

    add-int/lit8 v3, p1, 0x3

    aget-char v3, p0, v3

    int-to-long v3, v3

    or-long/2addr v0, v3

    .line 158
    .local v0, "first":J
    add-int/lit8 v3, p1, 0x4

    aget-char v3, p0, v3

    int-to-long v3, v3

    shl-long v2, v3, v2

    add-int/lit8 v4, p1, 0x5

    aget-char v4, p0, v4

    int-to-long v7, v4

    shl-long v4, v7, v5

    or-long/2addr v2, v4

    add-int/lit8 v4, p1, 0x6

    aget-char v4, p0, v4

    int-to-long v4, v4

    shl-long/2addr v4, v6

    or-long/2addr v2, v4

    add-int/lit8 v4, p1, 0x7

    aget-char v4, p0, v4

    int-to-long v4, v4

    or-long/2addr v2, v4

    .line 163
    .local v2, "second":J
    invoke-static {v0, v1, v2, v3}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleSwar;->tryToParseEightHexDigitsUtf16(JJ)J

    move-result-wide v4

    return-wide v4
.end method

.method public static tryToParseEightHexDigitsUtf8(J)J
    .locals 22
    .param p0, "chunk"    # J

    .line 220
    const-wide v0, 0x3030303030303030L    # 1.398043286095289E-76

    sub-long v0, p0, v0

    .line 224
    .local v0, "vec":J
    const-wide v2, 0x7676767676767676L    # 4.420781653221171E262

    add-long/2addr v2, v0

    .line 225
    .local v2, "gt_09":J
    const-wide v4, -0x7f7f7f7f7f7f7f80L    # -2.937446524422997E-306

    and-long/2addr v2, v4

    .line 228
    const-wide v6, 0x4f4f4f4f4f4f4f4fL    # 1.1063927031522055E74

    add-long/2addr v6, v0

    .line 229
    .local v6, "ge_30":J
    and-long/2addr v4, v6

    .line 232
    .end local v6    # "ge_30":J
    .local v4, "ge_30":J
    const-wide v6, 0x7f7f7f7f7f7f7f7fL    # 1.3824172084878715E306

    xor-long/2addr v6, v0

    const-wide v8, 0x3737373737373737L    # 1.0410273767909543E-42

    add-long/2addr v6, v8

    .line 239
    .local v6, "le_37":J
    and-long v8, v4, v6

    cmp-long v8, v2, v8

    if-eqz v8, :cond_0

    .line 240
    const-wide/16 v8, -0x1

    return-wide v8

    .line 244
    :cond_0
    const/4 v8, 0x7

    ushr-long v8, v2, v8

    const-wide/16 v10, 0xff

    mul-long/2addr v8, v10

    .line 247
    .local v8, "gt_09mask":J
    not-long v10, v8

    and-long/2addr v10, v0

    const-wide v12, 0x2727272727272727L    # 4.483094640249093E-120

    and-long/2addr v12, v8

    sub-long v12, v0, v12

    or-long/2addr v10, v12

    .line 250
    .local v10, "v":J
    const/4 v12, 0x4

    ushr-long v12, v10, v12

    or-long/2addr v12, v10

    .line 251
    .local v12, "v2":J
    const-wide v14, 0xff00ff00ff00ffL

    and-long/2addr v14, v12

    .line 252
    .local v14, "v3":J
    const/16 v16, 0x8

    ushr-long v16, v14, v16

    or-long v16, v14, v16

    .line 253
    .local v16, "v4":J
    const/16 v18, 0x10

    ushr-long v18, v16, v18

    const-wide v20, 0xffff0000L

    and-long v18, v18, v20

    const-wide/32 v20, 0xffff

    and-long v20, v16, v20

    or-long v18, v18, v20

    .line 255
    .local v18, "v5":J
    return-wide v18
.end method

.method public static tryToParseEightHexDigitsUtf8([BI)J
    .locals 2
    .param p0, "a"    # [B
    .param p1, "offset"    # I

    .line 203
    invoke-static {p0, p1}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleSwar;->readLongFromByteArrayBigEndian([BI)J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleSwar;->tryToParseEightHexDigitsUtf8(J)J

    move-result-wide v0

    return-wide v0
.end method

.method public static tryToParseFourHexDigitsUtf16(J)J
    .locals 18
    .param p0, "chunk"    # J

    .line 272
    const-wide v0, 0x30003000300030L

    sub-long v0, p0, v0

    .line 276
    .local v0, "vec":J
    const-wide v2, 0x7ff67ff67ff67ff6L

    add-long/2addr v2, v0

    .line 277
    .local v2, "gt_09":J
    const-wide v4, -0x7fff7fff7fff8000L    # -6.9534619092435E-310

    and-long/2addr v2, v4

    .line 280
    const-wide v6, 0x7fcf7fcf7fcf7fcfL    # 4.4239065111543664E307

    add-long/2addr v6, v0

    .line 281
    .local v6, "ge_30":J
    and-long/2addr v4, v6

    .line 284
    .end local v6    # "ge_30":J
    .local v4, "ge_30":J
    const-wide v6, 0x7fff7fff7fff7fffL

    xor-long/2addr v6, v0

    const-wide v8, 0x37003700370037L

    add-long/2addr v6, v8

    .line 291
    .local v6, "le_37":J
    and-long v8, v4, v6

    cmp-long v8, v2, v8

    if-eqz v8, :cond_0

    .line 292
    const-wide/16 v8, -0x1

    return-wide v8

    .line 296
    :cond_0
    const/16 v8, 0xf

    ushr-long v8, v2, v8

    const-wide/32 v10, 0xffff

    mul-long/2addr v8, v10

    .line 299
    .local v8, "gt_09mask":J
    not-long v12, v8

    and-long/2addr v12, v0

    const-wide v14, 0x27002700270027L

    and-long/2addr v14, v8

    sub-long v14, v0, v14

    or-long/2addr v12, v14

    .line 302
    .local v12, "v":J
    const/16 v14, 0xc

    ushr-long v14, v12, v14

    or-long/2addr v14, v12

    .line 303
    .local v14, "v2":J
    const/16 v16, 0x18

    ushr-long v16, v14, v16

    or-long v16, v14, v16

    and-long v10, v16, v10

    .line 305
    .local v10, "v5":J
    return-wide v10
.end method
