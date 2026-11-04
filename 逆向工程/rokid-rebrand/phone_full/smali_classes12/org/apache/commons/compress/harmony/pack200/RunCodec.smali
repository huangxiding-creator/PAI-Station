.class public Lorg/apache/commons/compress/harmony/pack200/RunCodec;
.super Lorg/apache/commons/compress/harmony/pack200/Codec;
.source "RunCodec.java"


# instance fields
.field private final aCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

.field private final bCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

.field private k:I

.field private last:I


# direct methods
.method public constructor <init>(ILorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)V
    .locals 2
    .param p1, "k"    # I
    .param p2, "aCodec"    # Lorg/apache/commons/compress/harmony/pack200/Codec;
    .param p3, "bCodec"    # Lorg/apache/commons/compress/harmony/pack200/Codec;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 34
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/Codec;-><init>()V

    .line 35
    if-lez p1, :cond_1

    .line 38
    if-eqz p2, :cond_0

    if-eqz p3, :cond_0

    .line 41
    iput p1, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->k:I

    .line 42
    iput-object p2, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->aCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    .line 43
    iput-object p3, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->bCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    .line 44
    return-void

    .line 39
    :cond_0
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    const-string v1, "Must supply both codecs for a RunCodec"

    invoke-direct {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 36
    :cond_1
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    const-string v1, "Cannot have a RunCodec for a negative number of numbers"

    invoke-direct {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private normalise(ILorg/apache/commons/compress/harmony/pack200/Codec;)I
    .locals 7
    .param p1, "value"    # I
    .param p2, "codecUsed"    # Lorg/apache/commons/compress/harmony/pack200/Codec;

    .line 63
    instance-of v0, p2, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    if-eqz v0, :cond_1

    .line 64
    move-object v0, p2

    check-cast v0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    .line 65
    .local v0, "bhsd":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isDelta()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 66
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality()J

    move-result-wide v1

    .line 67
    .local v1, "cardinality":J
    :goto_0
    int-to-long v3, p1

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest()J

    move-result-wide v5

    cmp-long v3, v3, v5

    if-lez v3, :cond_0

    .line 68
    int-to-long v3, p1

    sub-long/2addr v3, v1

    long-to-int p1, v3

    goto :goto_0

    .line 70
    :cond_0
    :goto_1
    int-to-long v3, p1

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest()J

    move-result-wide v5

    cmp-long v3, v3, v5

    if-gez v3, :cond_1

    .line 71
    int-to-long v3, p1

    add-long/2addr v3, v1

    long-to-int p1, v3

    goto :goto_1

    .line 75
    .end local v0    # "bhsd":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .end local v1    # "cardinality":J
    :cond_1
    return p1
.end method

.method private normalise([ILorg/apache/commons/compress/harmony/pack200/Codec;)V
    .locals 12
    .param p1, "band"    # [I
    .param p2, "codecUsed"    # Lorg/apache/commons/compress/harmony/pack200/Codec;

    .line 92
    instance-of v0, p2, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    if-eqz v0, :cond_2

    .line 93
    move-object v0, p2

    check-cast v0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    .line 94
    .local v0, "bhsd":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isDelta()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 95
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality()J

    move-result-wide v1

    .line 96
    .local v1, "cardinality":J
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    array-length v4, p1

    if-ge v3, v4, :cond_7

    .line 97
    :goto_1
    aget v4, p1, v3

    int-to-long v4, v4

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest()J

    move-result-wide v6

    cmp-long v4, v4, v6

    if-lez v4, :cond_0

    .line 98
    aget v4, p1, v3

    int-to-long v4, v4

    sub-long/2addr v4, v1

    long-to-int v4, v4

    aput v4, p1, v3

    goto :goto_1

    .line 100
    :cond_0
    :goto_2
    aget v4, p1, v3

    int-to-long v4, v4

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest()J

    move-result-wide v6

    cmp-long v4, v4, v6

    if-gez v4, :cond_1

    .line 101
    aget v4, p1, v3

    int-to-long v4, v4

    add-long/2addr v4, v1

    long-to-int v4, v4

    aput v4, p1, v3

    goto :goto_2

    .line 96
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 105
    .end local v0    # "bhsd":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .end local v1    # "cardinality":J
    .end local v3    # "i":I
    :cond_2
    instance-of v0, p2, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;

    if-eqz v0, :cond_7

    .line 106
    move-object v0, p2

    check-cast v0, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;

    .line 107
    .local v0, "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;->getFavoured()[I

    move-result-object v1

    invoke-virtual {v1}, [I->clone()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [I

    check-cast v1, [I

    .line 108
    .local v1, "favoured":[I
    invoke-static {v1}, Ljava/util/Arrays;->sort([I)V

    .line 109
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_3
    array-length v3, p1

    if-ge v2, v3, :cond_8

    .line 110
    aget v3, p1, v2

    invoke-static {v1, v3}, Ljava/util/Arrays;->binarySearch([II)I

    move-result v3

    const/4 v4, -0x1

    if-le v3, v4, :cond_3

    const/4 v3, 0x1

    goto :goto_4

    :cond_3
    const/4 v3, 0x0

    .line 111
    .local v3, "favouredValue":Z
    :goto_4
    if-eqz v3, :cond_4

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;->getFavouredCodec()Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v4

    goto :goto_5

    :cond_4
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;->getUnfavouredCodec()Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v4

    .line 112
    .local v4, "theCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :goto_5
    instance-of v5, v4, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    if-eqz v5, :cond_6

    .line 113
    move-object v5, v4

    check-cast v5, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    .line 114
    .local v5, "bhsd":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isDelta()Z

    move-result v6

    if-eqz v6, :cond_6

    .line 115
    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality()J

    move-result-wide v6

    .line 116
    .local v6, "cardinality":J
    :goto_6
    aget v8, p1, v2

    int-to-long v8, v8

    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest()J

    move-result-wide v10

    cmp-long v8, v8, v10

    if-lez v8, :cond_5

    .line 117
    aget v8, p1, v2

    int-to-long v8, v8

    sub-long/2addr v8, v6

    long-to-int v8, v8

    aput v8, p1, v2

    goto :goto_6

    .line 119
    :cond_5
    :goto_7
    aget v8, p1, v2

    int-to-long v8, v8

    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest()J

    move-result-wide v10

    cmp-long v8, v8, v10

    if-gez v8, :cond_6

    .line 120
    aget v8, p1, v2

    int-to-long v8, v8

    add-long/2addr v8, v6

    long-to-int v8, v8

    aput v8, p1, v2

    goto :goto_7

    .line 109
    .end local v3    # "favouredValue":Z
    .end local v4    # "theCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .end local v5    # "bhsd":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .end local v6    # "cardinality":J
    :cond_6
    add-int/lit8 v2, v2, 0x1

    goto :goto_3

    .line 105
    .end local v0    # "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    .end local v1    # "favoured":[I
    .end local v2    # "i":I
    :cond_7
    nop

    .line 126
    :cond_8
    return-void
.end method


# virtual methods
.method public decode(Ljava/io/InputStream;)I
    .locals 2
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 48
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->last:I

    int-to-long v0, v0

    invoke-virtual {p0, p1, v0, v1}, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->decode(Ljava/io/InputStream;J)I

    move-result v0

    return v0
.end method

.method public decode(Ljava/io/InputStream;J)I
    .locals 3
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "last"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 53
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->k:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->k:I

    if-ltz v0, :cond_1

    .line 54
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->aCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->last:I

    int-to-long v1, v1

    invoke-virtual {v0, p1, v1, v2}, Lorg/apache/commons/compress/harmony/pack200/Codec;->decode(Ljava/io/InputStream;J)I

    move-result v0

    .line 55
    .local v0, "value":I
    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->k:I

    if-nez v1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    iput v1, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->last:I

    .line 56
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->aCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    invoke-direct {p0, v0, v1}, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->normalise(ILorg/apache/commons/compress/harmony/pack200/Codec;)I

    move-result v1

    return v1

    .line 58
    .end local v0    # "value":I
    :cond_1
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->bCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->last:I

    int-to-long v1, v1

    invoke-virtual {v0, p1, v1, v2}, Lorg/apache/commons/compress/harmony/pack200/Codec;->decode(Ljava/io/InputStream;J)I

    move-result v0

    iput v0, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->last:I

    .line 59
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->last:I

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->bCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    invoke-direct {p0, v0, v1}, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->normalise(ILorg/apache/commons/compress/harmony/pack200/Codec;)I

    move-result v0

    return v0
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

    .line 80
    new-array v0, p1, [I

    .line 81
    .local v0, "band":[I
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->aCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->k:I

    invoke-virtual {v1, v2, p2}, Lorg/apache/commons/compress/harmony/pack200/Codec;->decodeInts(ILjava/io/InputStream;)[I

    move-result-object v1

    .line 82
    .local v1, "aValues":[I
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->aCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    invoke-direct {p0, v1, v2}, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->normalise([ILorg/apache/commons/compress/harmony/pack200/Codec;)V

    .line 83
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->bCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    iget v3, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->k:I

    sub-int v3, p1, v3

    invoke-virtual {v2, v3, p2}, Lorg/apache/commons/compress/harmony/pack200/Codec;->decodeInts(ILjava/io/InputStream;)[I

    move-result-object v2

    .line 84
    .local v2, "bValues":[I
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->bCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    invoke-direct {p0, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->normalise([ILorg/apache/commons/compress/harmony/pack200/Codec;)V

    .line 85
    iget v3, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->k:I

    const/4 v4, 0x0

    invoke-static {v1, v4, v0, v4, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 86
    iget v3, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->k:I

    iget v5, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->k:I

    sub-int v5, p1, v5

    invoke-static {v2, v4, v0, v3, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 87
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->aCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    iget v3, v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->lastBandLength:I

    iget-object v4, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->bCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    iget v4, v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->lastBandLength:I

    add-int/2addr v3, v4

    iput v3, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->lastBandLength:I

    .line 88
    return-object v0
.end method

.method public encode(I)[B
    .locals 2
    .param p1, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 140
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    const-string v1, "Must encode entire band at once with a RunCodec"

    invoke-direct {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public encode(II)[B
    .locals 2
    .param p1, "value"    # I
    .param p2, "last"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 135
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    const-string v1, "Must encode entire band at once with a RunCodec"

    invoke-direct {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getACodec()Lorg/apache/commons/compress/harmony/pack200/Codec;
    .locals 1

    .line 148
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->aCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    return-object v0
.end method

.method public getBCodec()Lorg/apache/commons/compress/harmony/pack200/Codec;
    .locals 1

    .line 152
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->bCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    return-object v0
.end method

.method public getK()I
    .locals 1

    .line 144
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->k:I

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 130
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "RunCodec[k="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->k:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ";aCodec="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->aCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "bCodec="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->bCodec:Lorg/apache/commons/compress/harmony/pack200/Codec;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
