.class public final Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
.super Lorg/apache/commons/compress/harmony/pack200/Codec;
.source "BHSDCodec.java"


# instance fields
.field private final b:I

.field private cardinality:J

.field private final d:I

.field private final h:I

.field private final l:I

.field private final largest:J

.field private final powers:[J

.field private final s:I

.field private final smallest:J


# direct methods
.method public constructor <init>(II)V
    .locals 1
    .param p1, "b"    # I
    .param p2, "h"    # I

    .line 111
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0, v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    .line 112
    return-void
.end method

.method public constructor <init>(III)V
    .locals 1
    .param p1, "b"    # I
    .param p2, "h"    # I
    .param p3, "s"    # I

    .line 123
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3, v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    .line 124
    return-void
.end method

.method public constructor <init>(IIII)V
    .locals 6
    .param p1, "b"    # I
    .param p2, "h"    # I
    .param p3, "s"    # I
    .param p4, "d"    # I

    .line 135
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/Codec;-><init>()V

    .line 136
    const/4 v0, 0x1

    if-lt p1, v0, :cond_9

    const/4 v1, 0x5

    if-gt p1, v1, :cond_9

    .line 139
    if-lt p2, v0, :cond_8

    const/16 v2, 0x100

    if-gt p2, v2, :cond_8

    .line 142
    if-ltz p3, :cond_7

    const/4 v3, 0x2

    if-gt p3, v3, :cond_7

    .line 145
    if-ltz p4, :cond_6

    if-gt p4, v0, :cond_6

    .line 148
    if-ne p1, v0, :cond_1

    if-ne p2, v2, :cond_0

    goto :goto_0

    .line 149
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "b=1 -> h=256"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 151
    :cond_1
    :goto_0
    if-ne p2, v2, :cond_3

    if-eq p1, v1, :cond_2

    goto :goto_1

    .line 152
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "h=256 -> b!=5"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 154
    :cond_3
    :goto_1
    iput p1, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->b:I

    .line 155
    iput p2, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->h:I

    .line 156
    iput p3, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    .line 157
    iput p4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->d:I

    .line 158
    rsub-int v1, p2, 0x100

    iput v1, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->l:I

    .line 159
    if-ne p2, v0, :cond_4

    .line 160
    mul-int/lit16 v1, p1, 0xff

    add-int/2addr v1, v0

    int-to-long v0, v1

    iput-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality:J

    goto :goto_2

    .line 162
    :cond_4
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->l:I

    int-to-double v0, v0

    int-to-double v2, p2

    int-to-double v4, p1

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    const-wide/high16 v4, 0x3ff0000000000000L    # 1.0

    sub-double/2addr v4, v2

    mul-double/2addr v0, v4

    rsub-int/lit8 v2, p2, 0x1

    int-to-double v2, v2

    div-double/2addr v0, v2

    double-to-long v0, v0

    long-to-double v0, v0

    int-to-double v2, p2

    int-to-double v4, p1

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    add-double/2addr v0, v2

    double-to-long v0, v0

    iput-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality:J

    .line 164
    :goto_2
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->calculateSmallest()J

    move-result-wide v0

    iput-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest:J

    .line 165
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->calculateLargest()J

    move-result-wide v0

    iput-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest:J

    .line 167
    new-array v0, p1, [J

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->powers:[J

    .line 168
    const/4 v0, 0x0

    .local v0, "c":I
    :goto_3
    if-ge v0, p1, :cond_5

    .line 169
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->powers:[J

    int-to-double v2, p2

    int-to-double v4, v0

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    double-to-long v2, v2

    aput-wide v2, v1, v0

    .line 168
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 171
    .end local v0    # "c":I
    :cond_5
    return-void

    .line 146
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "0<=d<=1"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 143
    :cond_7
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "0<=s<=2"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 140
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "1<=h<=256"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 137
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "1<=b<=5"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private calculateLargest()J
    .locals 6

    .line 382
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->d:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 383
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->b:I

    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->h:I

    invoke-direct {v0, v1, v2}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    .line 384
    .local v0, "bh0":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest()J

    move-result-wide v1

    return-wide v1

    .line 386
    .end local v0    # "bh0":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    :cond_0
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    const-wide/16 v2, 0x1

    if-nez v0, :cond_1

    .line 387
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality()J

    move-result-wide v0

    sub-long/2addr v0, v2

    .local v0, "result":J
    goto :goto_0

    .line 388
    .end local v0    # "result":J
    :cond_1
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    if-ne v0, v1, :cond_2

    .line 389
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality()J

    move-result-wide v0

    const-wide/16 v4, 0x2

    div-long/2addr v0, v4

    sub-long/2addr v0, v2

    .restart local v0    # "result":J
    goto :goto_0

    .line 390
    .end local v0    # "result":J
    :cond_2
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_4

    .line 391
    const-wide/16 v0, 0x3

    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality()J

    move-result-wide v4

    mul-long/2addr v4, v0

    const-wide/16 v0, 0x4

    div-long/2addr v4, v0

    sub-long v0, v4, v2

    .line 395
    .restart local v0    # "result":J
    :goto_0
    iget v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    if-nez v4, :cond_3

    const-wide v4, 0xfffffffeL

    goto :goto_1

    :cond_3
    const-wide/32 v4, 0x7fffffff

    :goto_1
    sub-long/2addr v4, v2

    invoke-static {v4, v5, v0, v1}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v2

    return-wide v2

    .line 393
    .end local v0    # "result":J
    :cond_4
    new-instance v0, Ljava/lang/Error;

    const-string v1, "Unknown s value"

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private calculateSmallest()J
    .locals 4

    .line 409
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->d:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isSigned()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 416
    :cond_0
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality()J

    move-result-wide v2

    neg-long v2, v2

    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    shl-int v0, v1, v0

    int-to-long v0, v0

    div-long/2addr v2, v0

    const-wide/32 v0, -0x80000000

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v0

    .local v0, "result":J
    goto :goto_1

    .line 410
    .end local v0    # "result":J
    :cond_1
    :goto_0
    iget-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality:J

    const-wide v2, 0x100000000L

    cmp-long v0, v0, v2

    if-ltz v0, :cond_2

    .line 411
    const-wide/32 v0, -0x80000000

    .restart local v0    # "result":J
    goto :goto_1

    .line 413
    .end local v0    # "result":J
    :cond_2
    const-wide/16 v0, 0x0

    .line 418
    .restart local v0    # "result":J
    :goto_1
    return-wide v0
.end method


# virtual methods
.method public cardinality()J
    .locals 2

    .line 179
    iget-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality:J

    return-wide v0
.end method

.method public decode(Ljava/io/InputStream;)I
    .locals 2
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 184
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->d:I

    if-nez v0, :cond_0

    .line 187
    const-wide/16 v0, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->decode(Ljava/io/InputStream;J)I

    move-result v0

    return v0

    .line 185
    :cond_0
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    const-string v1, "Delta encoding used without passing in last value; this is a coding error"

    invoke-direct {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public decode(Ljava/io/InputStream;J)I
    .locals 10
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "last"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 192
    const/4 v0, 0x0

    .line 193
    .local v0, "n":I
    const-wide/16 v1, 0x0

    .line 194
    .local v1, "z":J
    const-wide/16 v3, 0x0

    .line 197
    .local v3, "x":J
    :cond_0
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v5

    int-to-long v3, v5

    .line 198
    iget v5, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->lastBandLength:I

    const/4 v6, 0x1

    add-int/2addr v5, v6

    iput v5, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->lastBandLength:I

    .line 199
    iget-object v5, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->powers:[J

    aget-wide v7, v5, v0

    mul-long/2addr v7, v3

    add-long/2addr v1, v7

    .line 200
    add-int/2addr v0, v6

    .line 201
    iget v5, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->l:I

    int-to-long v7, v5

    cmp-long v5, v3, v7

    if-ltz v5, :cond_1

    iget v5, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->b:I

    if-lt v0, v5, :cond_0

    .line 203
    :cond_1
    const-wide/16 v7, -0x1

    cmp-long v5, v3, v7

    if-eqz v5, :cond_5

    .line 207
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isSigned()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 208
    iget v5, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    shl-int v5, v6, v5

    sub-int/2addr v5, v6

    .line 209
    .local v5, "u":I
    int-to-long v6, v5

    and-long/2addr v6, v1

    int-to-long v8, v5

    cmp-long v6, v6, v8

    if-nez v6, :cond_2

    .line 210
    iget v6, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    ushr-long v6, v1, v6

    not-long v1, v6

    goto :goto_0

    .line 212
    :cond_2
    iget v6, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    ushr-long v6, v1, v6

    sub-long/2addr v1, v6

    .line 231
    .end local v5    # "u":I
    :cond_3
    :goto_0
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isDelta()Z

    move-result v5

    if-eqz v5, :cond_4

    .line 232
    add-long/2addr v1, p2

    .line 234
    :cond_4
    long-to-int v5, v1

    return v5

    .line 204
    :cond_5
    new-instance v5, Ljava/io/EOFException;

    const-string v6, "End of stream reached whilst decoding"

    invoke-direct {v5, v6}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    throw v5
.end method

.method public decodeInts(ILjava/io/InputStream;)[I
    .locals 6
    .param p1, "n"    # I
    .param p2, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 239
    invoke-super {p0, p1, p2}, Lorg/apache/commons/compress/harmony/pack200/Codec;->decodeInts(ILjava/io/InputStream;)[I

    move-result-object v0

    .line 240
    .local v0, "band":[I
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isDelta()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 241
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_2

    .line 242
    :goto_1
    aget v2, v0, v1

    int-to-long v2, v2

    iget-wide v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest:J

    cmp-long v2, v2, v4

    if-lez v2, :cond_0

    .line 243
    aget v2, v0, v1

    int-to-long v2, v2

    iget-wide v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality:J

    sub-long/2addr v2, v4

    long-to-int v2, v2

    aput v2, v0, v1

    goto :goto_1

    .line 245
    :cond_0
    :goto_2
    aget v2, v0, v1

    int-to-long v2, v2

    iget-wide v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest:J

    cmp-long v2, v2, v4

    if-gez v2, :cond_1

    .line 246
    aget v2, v0, v1

    int-to-long v2, v2

    iget-wide v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality:J

    add-long/2addr v2, v4

    long-to-int v2, v2

    aput v2, v0, v1

    goto :goto_2

    .line 241
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 250
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public decodeInts(ILjava/io/InputStream;I)[I
    .locals 6
    .param p1, "n"    # I
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "firstValue"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 256
    invoke-super {p0, p1, p2, p3}, Lorg/apache/commons/compress/harmony/pack200/Codec;->decodeInts(ILjava/io/InputStream;I)[I

    move-result-object v0

    .line 257
    .local v0, "band":[I
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isDelta()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 258
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_2

    .line 259
    :goto_1
    aget v2, v0, v1

    int-to-long v2, v2

    iget-wide v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest:J

    cmp-long v2, v2, v4

    if-lez v2, :cond_0

    .line 260
    aget v2, v0, v1

    int-to-long v2, v2

    iget-wide v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality:J

    sub-long/2addr v2, v4

    long-to-int v2, v2

    aput v2, v0, v1

    goto :goto_1

    .line 262
    :cond_0
    :goto_2
    aget v2, v0, v1

    int-to-long v2, v2

    iget-wide v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest:J

    cmp-long v2, v2, v4

    if-gez v2, :cond_1

    .line 263
    aget v2, v0, v1

    int-to-long v2, v2

    iget-wide v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality:J

    add-long/2addr v2, v4

    long-to-int v2, v2

    aput v2, v0, v1

    goto :goto_2

    .line 258
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 267
    .end local v1    # "i":I
    :cond_2
    return-object v0
.end method

.method public encode(I)[B
    .locals 1
    .param p1, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 348
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encode(II)[B

    move-result-object v0

    return-object v0
.end method

.method public encode(II)[B
    .locals 9
    .param p1, "value"    # I
    .param p2, "last"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 288
    int-to-long v0, p1

    invoke-virtual {p0, v0, v1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->encodes(J)Z

    move-result v0

    if-eqz v0, :cond_e

    .line 292
    int-to-long v0, p1

    .line 293
    .local v0, "z":J
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isDelta()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 294
    int-to-long v2, p2

    sub-long/2addr v0, v2

    .line 296
    :cond_0
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isSigned()Z

    move-result v2

    const-wide/16 v3, 0x0

    const-wide v5, 0x100000000L

    if-eqz v2, :cond_5

    .line 297
    const-wide/32 v7, -0x80000000

    cmp-long v2, v0, v7

    if-gez v2, :cond_1

    .line 298
    add-long/2addr v0, v5

    goto :goto_0

    .line 299
    :cond_1
    const-wide/32 v7, 0x7fffffff

    cmp-long v2, v0, v7

    if-lez v2, :cond_2

    .line 300
    sub-long/2addr v0, v5

    .line 302
    :cond_2
    :goto_0
    cmp-long v2, v0, v3

    if-gez v2, :cond_3

    .line 303
    neg-long v5, v0

    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    shl-long/2addr v5, v2

    const-wide/16 v7, 0x1

    sub-long v0, v5, v7

    goto :goto_1

    .line 304
    :cond_3
    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    const/4 v5, 0x1

    if-ne v2, v5, :cond_4

    .line 305
    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    shl-long/2addr v0, v2

    goto :goto_1

    .line 307
    :cond_4
    const-wide/16 v5, 0x3

    rem-long v7, v0, v5

    sub-long v7, v0, v7

    div-long/2addr v7, v5

    add-long/2addr v0, v7

    goto :goto_1

    .line 309
    :cond_5
    cmp-long v2, v0, v3

    if-gez v2, :cond_7

    .line 311
    iget-wide v7, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality:J

    cmp-long v2, v7, v5

    if-gez v2, :cond_6

    .line 312
    iget-wide v5, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality:J

    add-long/2addr v0, v5

    goto :goto_1

    .line 314
    :cond_6
    add-long/2addr v0, v5

    .line 317
    :cond_7
    :goto_1
    cmp-long v2, v0, v3

    if-ltz v2, :cond_d

    .line 321
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 322
    .local v2, "byteList":Ljava/util/List;
    const/4 v3, 0x0

    .local v3, "n":I
    :goto_2
    iget v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->b:I

    if-ge v3, v4, :cond_b

    .line 324
    iget v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->l:I

    int-to-long v4, v4

    cmp-long v4, v0, v4

    if-gez v4, :cond_8

    .line 325
    move-wide v4, v0

    .local v4, "byteN":J
    goto :goto_4

    .line 327
    .end local v4    # "byteN":J
    :cond_8
    iget v4, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->h:I

    int-to-long v4, v4

    rem-long v4, v0, v4

    .line 328
    .restart local v4    # "byteN":J
    :goto_3
    iget v6, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->l:I

    int-to-long v6, v6

    cmp-long v6, v4, v6

    if-gez v6, :cond_9

    .line 329
    iget v6, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->h:I

    int-to-long v6, v6

    add-long/2addr v4, v6

    goto :goto_3

    .line 332
    :cond_9
    :goto_4
    long-to-int v6, v4

    int-to-byte v6, v6

    invoke-static {v6}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v6

    invoke-interface {v2, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 333
    iget v6, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->l:I

    int-to-long v6, v6

    cmp-long v6, v4, v6

    if-gez v6, :cond_a

    .line 334
    goto :goto_5

    .line 336
    :cond_a
    sub-long/2addr v0, v4

    .line 337
    iget v6, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->h:I

    int-to-long v6, v6

    div-long/2addr v0, v6

    .line 322
    .end local v4    # "byteN":J
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 339
    .end local v3    # "n":I
    :cond_b
    :goto_5
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v3

    new-array v3, v3, [B

    .line 340
    .local v3, "bytes":[B
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_6
    array-length v5, v3

    if-ge v4, v5, :cond_c

    .line 341
    invoke-interface {v2, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Byte;

    invoke-virtual {v5}, Ljava/lang/Byte;->byteValue()B

    move-result v5

    aput-byte v5, v3, v4

    .line 340
    add-int/lit8 v4, v4, 0x1

    goto :goto_6

    .line 343
    .end local v4    # "i":I
    :cond_c
    return-object v3

    .line 318
    .end local v2    # "byteList":Ljava/util/List;
    .end local v3    # "bytes":[B
    :cond_d
    new-instance v2, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    const-string/jumbo v3, "unable to encode"

    invoke-direct {v2, v3}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v2

    .line 289
    .end local v0    # "z":J
    :cond_e
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "The codec "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " does not encode the value "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public encodes(J)Z
    .locals 2
    .param p1, "value"    # J

    .line 283
    iget-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest:J

    cmp-long v0, p1, v0

    if-ltz v0, :cond_0

    iget-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest:J

    cmp-long v0, p1, v0

    if-gtz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4
    .param p1, "o"    # Ljava/lang/Object;

    .line 473
    instance-of v0, p1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 474
    move-object v0, p1

    check-cast v0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    .line 475
    .local v0, "codec":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    iget v2, v0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->b:I

    iget v3, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->b:I

    if-ne v2, v3, :cond_0

    iget v2, v0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->h:I

    iget v3, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->h:I

    if-ne v2, v3, :cond_0

    iget v2, v0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    iget v3, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    if-ne v2, v3, :cond_0

    iget v2, v0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->d:I

    iget v3, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->d:I

    if-ne v2, v3, :cond_0

    const/4 v1, 0x1

    :cond_0
    return v1

    .line 477
    .end local v0    # "codec":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    :cond_1
    return v1
.end method

.method public getB()I
    .locals 1

    .line 447
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->b:I

    return v0
.end method

.method public getH()I
    .locals 1

    .line 454
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->h:I

    return v0
.end method

.method public getL()I
    .locals 1

    .line 468
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->l:I

    return v0
.end method

.method public getS()I
    .locals 1

    .line 461
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    return v0
.end method

.method public hashCode()I
    .locals 2

    .line 482
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->b:I

    mul-int/lit8 v0, v0, 0x25

    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->h:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x25

    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x25

    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->d:I

    add-int/2addr v0, v1

    return v0
.end method

.method public isDelta()Z
    .locals 1

    .line 357
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->d:I

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isSigned()Z
    .locals 1

    .line 366
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public largest()J
    .locals 2

    .line 375
    iget-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest:J

    return-wide v0
.end method

.method public smallest()J
    .locals 2

    .line 404
    iget-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest:J

    return-wide v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 426
    new-instance v0, Ljava/lang/StringBuffer;

    const/16 v1, 0xb

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 427
    .local v0, "buffer":Ljava/lang/StringBuffer;
    const/16 v1, 0x28

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 428
    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->b:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 429
    const/16 v1, 0x2c

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 430
    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->h:I

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 431
    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    if-nez v2, :cond_0

    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->d:I

    if-eqz v2, :cond_1

    .line 432
    :cond_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 433
    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->s:I

    invoke-virtual {v0, v2}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 435
    :cond_1
    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->d:I

    if-eqz v2, :cond_2

    .line 436
    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 437
    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->d:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 439
    :cond_2
    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 440
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
