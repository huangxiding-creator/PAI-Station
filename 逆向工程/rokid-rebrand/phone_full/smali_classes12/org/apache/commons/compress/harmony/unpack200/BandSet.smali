.class public abstract Lorg/apache/commons/compress/harmony/unpack200/BandSet;
.super Ljava/lang/Object;
.source "BandSet.java"


# instance fields
.field protected header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

.field protected segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;


# direct methods
.method public constructor <init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V
    .locals 1
    .param p1, "segment"    # Lorg/apache/commons/compress/harmony/unpack200/Segment;

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    .line 60
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getSegmentHeader()Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    .line 61
    return-void
.end method


# virtual methods
.method public decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I
    .locals 21
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 81
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    move/from16 v3, p4

    move-object/from16 v4, p3

    .line 82
    .local v4, "codecUsed":Lorg/apache/commons/compress/harmony/pack200/Codec;
    invoke-virtual/range {p3 .. p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getB()I

    move-result v5

    const/4 v6, 0x1

    if-eq v5, v6, :cond_b

    if-nez v3, :cond_0

    goto/16 :goto_6

    .line 85
    :cond_0
    invoke-virtual {v2, v6, v1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->decodeInts(ILjava/io/InputStream;)[I

    move-result-object v5

    .line 86
    .local v5, "getFirst":[I
    array-length v7, v5

    if-nez v7, :cond_1

    .line 87
    return-object v5

    .line 89
    :cond_1
    const/4 v7, 0x0

    aget v8, v5, v7

    .line 90
    .local v8, "first":I
    invoke-virtual/range {p3 .. p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isSigned()Z

    move-result v9

    const/4 v10, -0x1

    if-eqz v9, :cond_2

    const/16 v9, -0x100

    if-lt v8, v9, :cond_2

    if-gt v8, v10, :cond_2

    .line 92
    rsub-int/lit8 v9, v8, -0x1

    iget-object v11, v0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v11}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getBandHeadersInputStream()Ljava/io/InputStream;

    move-result-object v11

    invoke-static {v9, v11, v2}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getCodec(ILjava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v4

    .line 93
    invoke-virtual {v4, v3, v1}, Lorg/apache/commons/compress/harmony/pack200/Codec;->decodeInts(ILjava/io/InputStream;)[I

    move-result-object v9

    .local v9, "band":[I
    goto :goto_0

    .line 94
    .end local v9    # "band":[I
    :cond_2
    invoke-virtual/range {p3 .. p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isSigned()Z

    move-result v9

    if-nez v9, :cond_3

    invoke-virtual/range {p3 .. p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getL()I

    move-result v9

    if-lt v8, v9, :cond_3

    invoke-virtual/range {p3 .. p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getL()I

    move-result v9

    add-int/lit16 v9, v9, 0xff

    if-gt v8, v9, :cond_3

    .line 96
    invoke-virtual/range {p3 .. p3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getL()I

    move-result v9

    sub-int v9, v8, v9

    iget-object v11, v0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v11}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getBandHeadersInputStream()Ljava/io/InputStream;

    move-result-object v11

    invoke-static {v9, v11, v2}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getCodec(ILjava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v4

    .line 97
    invoke-virtual {v4, v3, v1}, Lorg/apache/commons/compress/harmony/pack200/Codec;->decodeInts(ILjava/io/InputStream;)[I

    move-result-object v9

    .restart local v9    # "band":[I
    goto :goto_0

    .line 100
    .end local v9    # "band":[I
    :cond_3
    add-int/lit8 v9, v3, -0x1

    invoke-virtual {v2, v9, v1, v8}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->decodeInts(ILjava/io/InputStream;I)[I

    move-result-object v9

    .line 107
    .restart local v9    # "band":[I
    :goto_0
    instance-of v11, v4, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;

    if-eqz v11, :cond_a

    .line 108
    move-object v11, v4

    check-cast v11, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;

    .line 109
    .local v11, "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    invoke-virtual {v11}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;->getFavoured()[I

    move-result-object v12

    invoke-virtual {v12}, [I->clone()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, [I

    check-cast v12, [I

    .line 110
    .local v12, "favoured":[I
    invoke-static {v12}, Ljava/util/Arrays;->sort([I)V

    .line 111
    const/4 v13, 0x0

    .local v13, "i":I
    :goto_1
    array-length v14, v9

    if-ge v13, v14, :cond_9

    .line 112
    aget v14, v9, v13

    invoke-static {v12, v14}, Ljava/util/Arrays;->binarySearch([II)I

    move-result v14

    if-le v14, v10, :cond_4

    move v14, v6

    goto :goto_2

    :cond_4
    move v14, v7

    .line 113
    .local v14, "favouredValue":Z
    :goto_2
    if-eqz v14, :cond_5

    invoke-virtual {v11}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;->getFavouredCodec()Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v15

    goto :goto_3

    :cond_5
    invoke-virtual {v11}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;->getUnfavouredCodec()Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v15

    .line 114
    .local v15, "theCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :goto_3
    instance-of v6, v15, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    if-eqz v6, :cond_7

    move-object v6, v15

    check-cast v6, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isDelta()Z

    move-result v6

    if-eqz v6, :cond_7

    .line 115
    move-object v6, v15

    check-cast v6, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    .line 116
    .local v6, "bhsd":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->cardinality()J

    move-result-wide v16

    .line 117
    .local v16, "cardinality":J
    :goto_4
    aget v7, v9, v13

    move-object/from16 v18, v11

    .end local v11    # "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    .local v18, "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    int-to-long v10, v7

    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->largest()J

    move-result-wide v19

    cmp-long v7, v10, v19

    if-lez v7, :cond_6

    .line 118
    aget v7, v9, v13

    int-to-long v10, v7

    sub-long v10, v10, v16

    long-to-int v7, v10

    aput v7, v9, v13

    move-object/from16 v11, v18

    const/4 v7, 0x0

    const/4 v10, -0x1

    goto :goto_4

    .line 120
    :cond_6
    :goto_5
    aget v7, v9, v13

    int-to-long v10, v7

    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->smallest()J

    move-result-wide v19

    cmp-long v7, v10, v19

    if-gez v7, :cond_8

    .line 121
    aget v7, v9, v13

    int-to-long v10, v7

    add-long v10, v10, v16

    long-to-int v7, v10

    aput v7, v9, v13

    goto :goto_5

    .line 114
    .end local v6    # "bhsd":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .end local v16    # "cardinality":J
    .end local v18    # "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    .restart local v11    # "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    :cond_7
    move-object/from16 v18, v11

    .line 111
    .end local v11    # "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    .end local v14    # "favouredValue":Z
    .end local v15    # "theCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .restart local v18    # "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    :cond_8
    add-int/lit8 v13, v13, 0x1

    move-object/from16 v11, v18

    const/4 v6, 0x1

    const/4 v7, 0x0

    const/4 v10, -0x1

    goto :goto_1

    .end local v18    # "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    .restart local v11    # "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    :cond_9
    move-object/from16 v18, v11

    .line 126
    .end local v11    # "popCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    .end local v12    # "favoured":[I
    .end local v13    # "i":I
    :cond_a
    return-object v9

    .line 83
    .end local v5    # "getFirst":[I
    .end local v8    # "first":I
    .end local v9    # "band":[I
    :cond_b
    :goto_6
    invoke-virtual {v2, v3, v1}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->decodeInts(ILjava/io/InputStream;)[I

    move-result-object v5

    return-object v5
.end method

.method public decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I
    .locals 8
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "defaultCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "counts"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 142
    array-length v0, p4

    new-array v0, v0, [[I

    .line 143
    .local v0, "result":[[I
    const/4 v1, 0x0

    .line 144
    .local v1, "totalCount":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    array-length v3, p4

    if-ge v2, v3, :cond_0

    .line 145
    aget v3, p4, v2

    add-int/2addr v1, v3

    .line 144
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 147
    .end local v2    # "i":I
    :cond_0
    invoke-virtual {p0, p1, p2, p3, v1}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v2

    .line 148
    .local v2, "twoDResult":[I
    const/4 v3, 0x0

    .line 149
    .local v3, "index":I
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_1
    array-length v5, v0

    if-ge v4, v5, :cond_2

    .line 150
    aget v5, p4, v4

    new-array v5, v5, [I

    aput-object v5, v0, v4

    .line 151
    const/4 v5, 0x0

    .local v5, "j":I
    :goto_2
    aget-object v6, v0, v4

    array-length v6, v6

    if-ge v5, v6, :cond_1

    .line 152
    aget-object v6, v0, v4

    aget v7, v2, v3

    aput v7, v6, v5

    .line 153
    add-int/lit8 v3, v3, 0x1

    .line 151
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 149
    .end local v5    # "j":I
    :cond_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 156
    .end local v4    # "i":I
    :cond_2
    return-object v0
.end method

.method protected getReferences([I[Ljava/lang/String;)[Ljava/lang/String;
    .locals 3
    .param p1, "ints"    # [I
    .param p2, "reference"    # [Ljava/lang/String;

    .line 477
    array-length v0, p1

    new-array v0, v0, [Ljava/lang/String;

    .line 478
    .local v0, "result":[Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_0

    .line 479
    aget v2, p1, v1

    aget-object v2, p2, v2

    aput-object v2, v0, v1

    .line 478
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 481
    .end local v1    # "i":I
    :cond_0
    return-object v0
.end method

.method protected getReferences([[I[Ljava/lang/String;)[[Ljava/lang/String;
    .locals 5
    .param p1, "ints"    # [[I
    .param p2, "reference"    # [Ljava/lang/String;

    .line 485
    array-length v0, p1

    new-array v0, v0, [[Ljava/lang/String;

    .line 486
    .local v0, "result":[[Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_1

    .line 487
    aget-object v2, p1, v1

    array-length v2, v2

    new-array v2, v2, [Ljava/lang/String;

    aput-object v2, v0, v1

    .line 488
    const/4 v2, 0x0

    .local v2, "j":I
    :goto_1
    aget-object v3, v0, v1

    array-length v3, v3

    if-ge v2, v3, :cond_0

    .line 489
    aget-object v3, v0, v1

    aget-object v4, p1, v1

    aget v4, v4, v2

    aget-object v4, p2, v4

    aput-object v4, v3, v2

    .line 488
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 486
    .end local v2    # "j":I
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 493
    .end local v1    # "i":I
    :cond_1
    return-object v0
.end method

.method public parseCPClassReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    .locals 5
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 467
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v0

    .line 468
    .local v0, "indices":[I
    array-length v1, v0

    new-array v1, v1, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    .line 469
    .local v1, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    const/4 v2, 0x0

    .local v2, "i1":I
    :goto_0
    if-ge v2, p4, :cond_0

    .line 470
    aget v3, v0, v2

    .line 471
    .local v3, "index":I
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v4

    invoke-virtual {v4, v3}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpClassValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    move-result-object v4

    aput-object v4, v1, v2

    .line 469
    .end local v3    # "index":I
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 473
    .end local v2    # "i1":I
    :cond_0
    return-object v1
.end method

.method public parseCPDescriptorReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 419
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    .line 420
    .local v0, "cpBands":Lorg/apache/commons/compress/harmony/unpack200/CpBands;
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 421
    .local v1, "indices":[I
    array-length v2, v1

    new-array v2, v2, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;

    .line 422
    .local v2, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;
    const/4 v3, 0x0

    .local v3, "i1":I
    :goto_0
    if-ge v3, p4, :cond_0

    .line 423
    aget v4, v1, v3

    .line 424
    .local v4, "index":I
    invoke-virtual {v0, v4}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpNameAndTypeValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;

    move-result-object v5

    aput-object v5, v2, v3

    .line 422
    .end local v4    # "index":I
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 426
    .end local v3    # "i1":I
    :cond_0
    return-object v2
.end method

.method public parseCPDoubleReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPDouble;
    .locals 5
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 298
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v0

    .line 299
    .local v0, "indices":[I
    array-length v1, v0

    new-array v1, v1, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPDouble;

    .line 300
    .local v1, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPDouble;
    const/4 v2, 0x0

    .local v2, "i1":I
    :goto_0
    if-ge v2, p4, :cond_0

    .line 301
    aget v3, v0, v2

    .line 302
    .local v3, "index":I
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v4

    invoke-virtual {v4, v3}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpDoubleValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPDouble;

    move-result-object v4

    aput-object v4, v1, v2

    .line 300
    .end local v3    # "index":I
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 304
    .end local v2    # "i1":I
    :cond_0
    return-object v1
.end method

.method public parseCPFieldRefReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPFieldRef;
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 407
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    .line 408
    .local v0, "cpBands":Lorg/apache/commons/compress/harmony/unpack200/CpBands;
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 409
    .local v1, "indices":[I
    array-length v2, v1

    new-array v2, v2, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPFieldRef;

    .line 410
    .local v2, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPFieldRef;
    const/4 v3, 0x0

    .local v3, "i1":I
    :goto_0
    if-ge v3, p4, :cond_0

    .line 411
    aget v4, v1, v3

    .line 412
    .local v4, "index":I
    invoke-virtual {v0, v4}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpFieldValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPFieldRef;

    move-result-object v5

    aput-object v5, v2, v3

    .line 410
    .end local v4    # "index":I
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 414
    .end local v3    # "i1":I
    :cond_0
    return-object v2
.end method

.method public parseCPFloatReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPFloat;
    .locals 5
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 309
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v0

    .line 310
    .local v0, "indices":[I
    array-length v1, v0

    new-array v1, v1, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPFloat;

    .line 311
    .local v1, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPFloat;
    const/4 v2, 0x0

    .local v2, "i1":I
    :goto_0
    if-ge v2, p4, :cond_0

    .line 312
    aget v3, v0, v2

    .line 313
    .local v3, "index":I
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v4

    invoke-virtual {v4, v3}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpFloatValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPFloat;

    move-result-object v4

    aput-object v4, v1, v2

    .line 311
    .end local v3    # "index":I
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 315
    .end local v2    # "i1":I
    :cond_0
    return-object v1
.end method

.method public parseCPIntReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInteger;
    .locals 8
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 282
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpInt()[I

    move-result-object v0

    .line 283
    .local v0, "reference":[I
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 284
    .local v1, "indices":[I
    array-length v2, v1

    new-array v2, v2, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInteger;

    .line 285
    .local v2, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInteger;
    const/4 v3, 0x0

    .local v3, "i1":I
    :goto_0
    if-ge v3, p4, :cond_1

    .line 286
    aget v4, v1, v3

    .line 287
    .local v4, "index":I
    if-ltz v4, :cond_0

    array-length v5, v0

    if-ge v4, v5, :cond_0

    .line 291
    iget-object v5, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v5

    invoke-virtual {v5, v4}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpIntegerValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInteger;

    move-result-object v5

    aput-object v5, v2, v3

    .line 285
    .end local v4    # "index":I
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 288
    .restart local v4    # "index":I
    :cond_0
    new-instance v5, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Something has gone wrong during parsing references, index = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ", array size = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    array-length v7, v0

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v5

    .line 293
    .end local v3    # "i1":I
    .end local v4    # "index":I
    :cond_1
    return-object v2
.end method

.method public parseCPInterfaceMethodRefReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 383
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    .line 384
    .local v0, "cpBands":Lorg/apache/commons/compress/harmony/unpack200/CpBands;
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 385
    .local v1, "indices":[I
    array-length v2, v1

    new-array v2, v2, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;

    .line 386
    .local v2, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;
    const/4 v3, 0x0

    .local v3, "i1":I
    :goto_0
    if-ge v3, p4, :cond_0

    .line 387
    aget v4, v1, v3

    .line 388
    .local v4, "index":I
    invoke-virtual {v0, v4}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpIMethodValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;

    move-result-object v5

    aput-object v5, v2, v3

    .line 386
    .end local v4    # "index":I
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 390
    .end local v3    # "i1":I
    :cond_0
    return-object v2
.end method

.method public parseCPLongReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPLong;
    .locals 8
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 320
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpLong()[J

    move-result-object v0

    .line 321
    .local v0, "reference":[J
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 322
    .local v1, "indices":[I
    array-length v2, v1

    new-array v2, v2, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPLong;

    .line 323
    .local v2, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPLong;
    const/4 v3, 0x0

    .local v3, "i1":I
    :goto_0
    if-ge v3, p4, :cond_1

    .line 324
    aget v4, v1, v3

    .line 325
    .local v4, "index":I
    if-ltz v4, :cond_0

    array-length v5, v0

    if-ge v4, v5, :cond_0

    .line 329
    iget-object v5, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v5

    invoke-virtual {v5, v4}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpLongValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPLong;

    move-result-object v5

    aput-object v5, v2, v3

    .line 323
    .end local v4    # "index":I
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 326
    .restart local v4    # "index":I
    :cond_0
    new-instance v5, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Something has gone wrong during parsing references, index = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ", array size = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    array-length v7, v0

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v5

    .line 331
    .end local v3    # "i1":I
    .end local v4    # "index":I
    :cond_1
    return-object v2
.end method

.method public parseCPMethodRefReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPMethodRef;
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 395
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    .line 396
    .local v0, "cpBands":Lorg/apache/commons/compress/harmony/unpack200/CpBands;
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 397
    .local v1, "indices":[I
    array-length v2, v1

    new-array v2, v2, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPMethodRef;

    .line 398
    .local v2, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPMethodRef;
    const/4 v3, 0x0

    .local v3, "i1":I
    :goto_0
    if-ge v3, p4, :cond_0

    .line 399
    aget v4, v1, v3

    .line 400
    .local v4, "index":I
    invoke-virtual {v0, v4}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpMethodValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPMethodRef;

    move-result-object v5

    aput-object v5, v2, v3

    .line 398
    .end local v4    # "index":I
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 402
    .end local v3    # "i1":I
    :cond_0
    return-object v2
.end method

.method public parseCPSignatureReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .locals 5
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 431
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v0

    .line 432
    .local v0, "indices":[I
    array-length v1, v0

    new-array v1, v1, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 433
    .local v1, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    const/4 v2, 0x0

    .local v2, "i1":I
    :goto_0
    if-ge v2, p4, :cond_0

    .line 434
    aget v3, v0, v2

    .line 435
    .local v3, "index":I
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v4

    invoke-virtual {v4, v3}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpSignatureValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v4

    aput-object v4, v1, v2

    .line 433
    .end local v3    # "index":I
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 437
    .end local v2    # "i1":I
    :cond_0
    return-object v1
.end method

.method protected parseCPSignatureReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .locals 10
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "counts"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 442
    array-length v0, p4

    new-array v0, v0, [[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 443
    .local v0, "result":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    const/4 v1, 0x0

    .line 444
    .local v1, "sum":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    array-length v3, p4

    if-ge v2, v3, :cond_0

    .line 445
    aget v3, p4, v2

    new-array v3, v3, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    aput-object v3, v0, v2

    .line 446
    aget v3, p4, v2

    add-int/2addr v1, v3

    .line 444
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 448
    .end local v2    # "i":I
    :cond_0
    new-array v2, v1, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 449
    .local v2, "result1":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    invoke-virtual {p0, p1, p2, p3, v1}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v3

    .line 450
    .local v3, "indices":[I
    const/4 v4, 0x0

    .local v4, "i1":I
    :goto_1
    if-ge v4, v1, :cond_1

    .line 451
    aget v5, v3, v4

    .line 452
    .local v5, "index":I
    iget-object v6, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v6

    invoke-virtual {v6, v5}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpSignatureValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v6

    aput-object v6, v2, v4

    .line 450
    .end local v5    # "index":I
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 454
    .end local v4    # "i1":I
    :cond_1
    move-object v4, v2

    .line 455
    .local v4, "refs":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    const/4 v5, 0x0

    .line 456
    .local v5, "pos":I
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_2
    array-length v7, p4

    if-ge v6, v7, :cond_2

    .line 457
    aget v7, p4, v6

    .line 458
    .local v7, "num":I
    new-array v8, v7, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    aput-object v8, v0, v6

    .line 459
    aget-object v8, v0, v6

    const/4 v9, 0x0

    invoke-static {v4, v5, v8, v9, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 460
    add-int/2addr v5, v7

    .line 456
    .end local v7    # "num":I
    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    .line 462
    .end local v6    # "i":I
    :cond_2
    return-object v0
.end method

.method public parseCPStringReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPString;
    .locals 5
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 372
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v0

    .line 373
    .local v0, "indices":[I
    array-length v1, v0

    new-array v1, v1, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPString;

    .line 374
    .local v1, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPString;
    const/4 v2, 0x0

    .local v2, "i1":I
    :goto_0
    if-ge v2, p4, :cond_0

    .line 375
    aget v3, v0, v2

    .line 376
    .local v3, "index":I
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v4

    invoke-virtual {v4, v3}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpStringValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPString;

    move-result-object v4

    aput-object v4, v1, v2

    .line 374
    .end local v3    # "index":I
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 378
    .end local v2    # "i1":I
    :cond_0
    return-object v1
.end method

.method public parseCPUTF8References(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .locals 5
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 336
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v0

    .line 337
    .local v0, "indices":[I
    array-length v1, v0

    new-array v1, v1, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 338
    .local v1, "result":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    const/4 v2, 0x0

    .local v2, "i1":I
    :goto_0
    if-ge v2, p4, :cond_0

    .line 339
    aget v3, v0, v2

    .line 340
    .local v3, "index":I
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v4

    invoke-virtual {v4, v3}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v4

    aput-object v4, v1, v2

    .line 338
    .end local v3    # "index":I
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 342
    .end local v2    # "i1":I
    :cond_0
    return-object v1
.end method

.method public parseCPUTF8References(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .locals 10
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "counts"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 347
    array-length v0, p4

    new-array v0, v0, [[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 348
    .local v0, "result":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    const/4 v1, 0x0

    .line 349
    .local v1, "sum":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    array-length v3, p4

    if-ge v2, v3, :cond_0

    .line 350
    aget v3, p4, v2

    new-array v3, v3, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    aput-object v3, v0, v2

    .line 351
    aget v3, p4, v2

    add-int/2addr v1, v3

    .line 349
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 353
    .end local v2    # "i":I
    :cond_0
    new-array v2, v1, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 354
    .local v2, "result1":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    invoke-virtual {p0, p1, p2, p3, v1}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v3

    .line 355
    .local v3, "indices":[I
    const/4 v4, 0x0

    .local v4, "i1":I
    :goto_1
    if-ge v4, v1, :cond_1

    .line 356
    aget v5, v3, v4

    .line 357
    .local v5, "index":I
    iget-object v6, p0, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v6

    invoke-virtual {v6, v5}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v6

    aput-object v6, v2, v4

    .line 355
    .end local v5    # "index":I
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 359
    .end local v4    # "i1":I
    :cond_1
    move-object v4, v2

    .line 360
    .local v4, "refs":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    const/4 v5, 0x0

    .line 361
    .local v5, "pos":I
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_2
    array-length v7, p4

    if-ge v6, v7, :cond_2

    .line 362
    aget v7, p4, v6

    .line 363
    .local v7, "num":I
    new-array v8, v7, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    aput-object v8, v0, v6

    .line 364
    aget-object v8, v0, v6

    const/4 v9, 0x0

    invoke-static {v4, v5, v8, v9, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 365
    add-int/2addr v5, v7

    .line 361
    .end local v7    # "num":I
    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    .line 367
    .end local v6    # "i":I
    :cond_2
    return-object v0
.end method

.method public parseFlags(Ljava/lang/String;Ljava/io/InputStream;ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[J
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "count"    # I
    .param p4, "hiCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p5, "loCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 171
    filled-new-array {p3}, [I

    move-result-object v3

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, p4

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->parseFlags(Ljava/lang/String;Ljava/io/InputStream;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[[J

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    return-object v0
.end method

.method public parseFlags(Ljava/lang/String;Ljava/io/InputStream;ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Z)[J
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "count"    # I
    .param p4, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p5, "hasHi"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 161
    filled-new-array {p3}, [I

    move-result-object v3

    if-eqz p5, :cond_0

    move-object v4, p4

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    move-object v4, v0

    :goto_0
    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v5, p4

    invoke-virtual/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->parseFlags(Ljava/lang/String;Ljava/io/InputStream;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[[J

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    return-object v0
.end method

.method public parseFlags(Ljava/lang/String;Ljava/io/InputStream;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[[J
    .locals 17
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "counts"    # [I
    .param p4, "hiCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p5, "loCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 176
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p5

    array-length v6, v3

    .line 177
    .local v6, "count":I
    if-nez v6, :cond_0

    .line 178
    const/4 v7, 0x0

    new-array v7, v7, [J

    filled-new-array {v7}, [[J

    move-result-object v7

    return-object v7

    .line 180
    :cond_0
    const/4 v7, 0x0

    .line 181
    .local v7, "sum":I
    new-array v8, v6, [[J

    .line 182
    .local v8, "result":[[J
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_0
    if-ge v9, v6, :cond_1

    .line 183
    aget v10, v3, v9

    new-array v10, v10, [J

    aput-object v10, v8, v9

    .line 184
    aget v10, v3, v9

    add-int/2addr v7, v10

    .line 182
    add-int/lit8 v9, v9, 0x1

    goto :goto_0

    .line 186
    .end local v9    # "i":I
    :cond_1
    const/4 v9, 0x0

    .line 188
    .local v9, "hi":[I
    if-eqz v4, :cond_2

    .line 189
    invoke-virtual {v0, v1, v2, v4, v7}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v9

    .line 190
    invoke-virtual {v0, v1, v2, v5, v7}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v10

    .local v10, "lo":[I
    goto :goto_1

    .line 192
    .end local v10    # "lo":[I
    :cond_2
    invoke-virtual {v0, v1, v2, v5, v7}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v10

    .line 195
    .restart local v10    # "lo":[I
    :goto_1
    const/4 v11, 0x0

    .line 196
    .local v11, "index":I
    const/4 v12, 0x0

    .local v12, "i":I
    :goto_2
    array-length v13, v8

    if-ge v12, v13, :cond_5

    .line 197
    const/4 v13, 0x0

    .local v13, "j":I
    :goto_3
    aget-object v14, v8, v12

    array-length v14, v14

    if-ge v13, v14, :cond_4

    .line 198
    if-eqz v9, :cond_3

    .line 199
    aget-object v14, v8, v12

    aget v15, v9, v11

    int-to-long v0, v15

    const/16 v15, 0x20

    shl-long/2addr v0, v15

    aget v15, v10, v11

    int-to-long v2, v15

    const-wide v15, 0xffffffffL

    and-long/2addr v2, v15

    or-long/2addr v0, v2

    aput-wide v0, v14, v13

    goto :goto_4

    .line 201
    :cond_3
    aget-object v0, v8, v12

    aget v1, v10, v11

    int-to-long v1, v1

    aput-wide v1, v0, v13

    .line 203
    :goto_4
    add-int/lit8 v11, v11, 0x1

    .line 197
    add-int/lit8 v13, v13, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    goto :goto_3

    .line 196
    .end local v13    # "j":I
    :cond_4
    add-int/lit8 v12, v12, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    goto :goto_2

    .line 206
    .end local v12    # "i":I
    :cond_5
    return-object v8
.end method

.method public parseFlags(Ljava/lang/String;Ljava/io/InputStream;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Z)[[J
    .locals 7
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "counts"    # [I
    .param p4, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p5, "hasHi"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 166
    if-eqz p5, :cond_0

    move-object v5, p4

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    move-object v5, v0

    :goto_0
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v6, p4

    invoke-virtual/range {v1 .. v6}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->parseFlags(Ljava/lang/String;Ljava/io/InputStream;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[[J

    move-result-object v0

    return-object v0
.end method

.method public parseReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I[Ljava/lang/String;)[Ljava/lang/String;
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "count"    # I
    .param p5, "reference"    # [Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 226
    filled-new-array {p4}, [I

    move-result-object v4

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->parseReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I[Ljava/lang/String;)[[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    return-object v0
.end method

.method public parseReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I[Ljava/lang/String;)[[Ljava/lang/String;
    .locals 16
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "codec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .param p4, "counts"    # [I
    .param p5, "reference"    # [Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 247
    move-object/from16 v0, p4

    move-object/from16 v1, p5

    array-length v2, v0

    .line 248
    .local v2, "count":I
    const/4 v3, 0x0

    if-nez v2, :cond_0

    .line 249
    const/4 v4, 0x1

    new-array v4, v4, [[Ljava/lang/String;

    new-array v5, v3, [Ljava/lang/String;

    aput-object v5, v4, v3

    return-object v4

    .line 251
    :cond_0
    new-array v4, v2, [[Ljava/lang/String;

    .line 252
    .local v4, "result":[[Ljava/lang/String;
    const/4 v5, 0x0

    .line 253
    .local v5, "sum":I
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_0
    if-ge v6, v2, :cond_1

    .line 254
    aget v7, v0, v6

    new-array v7, v7, [Ljava/lang/String;

    aput-object v7, v4, v6

    .line 255
    aget v7, v0, v6

    add-int/2addr v5, v7

    .line 253
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 258
    .end local v6    # "i":I
    :cond_1
    new-array v6, v5, [Ljava/lang/String;

    .line 259
    .local v6, "result1":[Ljava/lang/String;
    move-object/from16 v7, p0

    move-object/from16 v8, p1

    move-object/from16 v9, p2

    move-object/from16 v10, p3

    invoke-virtual {v7, v8, v9, v10, v5}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v11

    .line 260
    .local v11, "indices":[I
    const/4 v12, 0x0

    .local v12, "i1":I
    :goto_1
    if-ge v12, v5, :cond_3

    .line 261
    aget v13, v11, v12

    .line 262
    .local v13, "index":I
    if-ltz v13, :cond_2

    array-length v14, v1

    if-ge v13, v14, :cond_2

    .line 266
    aget-object v14, v1, v13

    aput-object v14, v6, v12

    .line 260
    .end local v13    # "index":I
    add-int/lit8 v12, v12, 0x1

    goto :goto_1

    .line 263
    .restart local v13    # "index":I
    :cond_2
    new-instance v3, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "Something has gone wrong during parsing references, index = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, ", array size = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    array-length v15, v1

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-direct {v3, v14}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v3

    .line 268
    .end local v12    # "i1":I
    .end local v13    # "index":I
    :cond_3
    move-object v12, v6

    .line 270
    .local v12, "refs":[Ljava/lang/String;
    const/4 v13, 0x0

    .line 271
    .local v13, "pos":I
    const/4 v14, 0x0

    .local v14, "i":I
    :goto_2
    if-ge v14, v2, :cond_4

    .line 272
    aget v15, v0, v14

    .line 273
    .local v15, "num":I
    new-array v3, v15, [Ljava/lang/String;

    aput-object v3, v4, v14

    .line 274
    aget-object v3, v4, v14

    const/4 v0, 0x0

    invoke-static {v12, v13, v3, v0, v15}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 275
    add-int/2addr v13, v15

    .line 271
    .end local v15    # "num":I
    add-int/lit8 v14, v14, 0x1

    move v3, v0

    move-object/from16 v0, p4

    goto :goto_2

    .line 277
    .end local v14    # "i":I
    :cond_4
    return-object v4
.end method

.method public abstract read(Ljava/io/InputStream;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation
.end method

.method public abstract unpack()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation
.end method

.method public unpack(Ljava/io/InputStream;)V
    .locals 0
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 50
    invoke-virtual {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->read(Ljava/io/InputStream;)V

    .line 51
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;->unpack()V

    .line 52
    return-void
.end method
