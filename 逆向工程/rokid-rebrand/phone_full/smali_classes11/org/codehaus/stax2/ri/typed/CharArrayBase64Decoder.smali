.class public Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;
.super Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;
.source "CharArrayBase64Decoder.java"


# instance fields
.field protected _currSegment:[C

.field protected _currSegmentEnd:I

.field protected _currSegmentPtr:I

.field protected _lastSegmentEnd:I

.field protected _lastSegmentOffset:I

.field protected _nextSegmentIndex:I

.field protected final _nextSegments:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "[C>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 50
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;-><init>()V

    .line 39
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegments:Ljava/util/ArrayList;

    .line 50
    return-void
.end method

.method private nextSegment()Z
    .locals 4

    .line 258
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegmentIndex:I

    iget-object v1, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x0

    if-ge v0, v1, :cond_1

    .line 259
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegments:Ljava/util/ArrayList;

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegmentIndex:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegmentIndex:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [C

    check-cast v0, [C

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegment:[C

    .line 261
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegmentIndex:I

    iget-object v1, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ne v0, v1, :cond_0

    .line 262
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_lastSegmentOffset:I

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    .line 263
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_lastSegmentEnd:I

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentEnd:I

    goto :goto_0

    .line 265
    :cond_0
    iput v2, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    .line 266
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegment:[C

    array-length v0, v0

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentEnd:I

    .line 268
    :goto_0
    const/4 v0, 0x1

    return v0

    .line 270
    :cond_1
    return v2
.end method


# virtual methods
.method public decode([BII)I
    .locals 15
    .param p1, "resultBuffer"    # [B
    .param p2, "resultOffset"    # I
    .param p3, "maxLength"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 102
    move-object v0, p0

    move/from16 v1, p2

    .line 103
    .local v1, "origResultOffset":I
    add-int v2, p2, p3

    move/from16 v3, p2

    .line 107
    .end local p2    # "resultOffset":I
    .local v2, "resultBufferEnd":I
    .local v3, "resultOffset":I
    :goto_0
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    const/4 v5, -0x2

    const/4 v6, 0x0

    const/4 v7, 0x5

    const/4 v8, 0x4

    const/4 v9, 0x3

    const/4 v10, 0x2

    const/4 v11, 0x6

    packed-switch v4, :pswitch_data_0

    .line 244
    new-instance v4, Ljava/lang/IllegalStateException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Illegal internal state "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 226
    :pswitch_0
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    iget v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentEnd:I

    if-lt v4, v5, :cond_0

    .line 227
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->nextSegment()Z

    move-result v4

    if-nez v4, :cond_0

    .line 229
    goto/16 :goto_1

    .line 232
    :cond_0
    iget-object v4, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegment:[C

    iget v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    aget-char v4, v4, v5

    .line 233
    .local v4, "ch":C
    iget-object v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v5, v4}, Lorg/codehaus/stax2/typed/Base64Variant;->usesPaddingChar(C)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 237
    iput v11, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    .line 238
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    shr-int/2addr v5, v8

    iput v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    .line 240
    .end local v4    # "ch":C
    goto :goto_0

    .line 234
    .restart local v4    # "ch":C
    :cond_1
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "expected padding character \'"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v6}, Lorg/codehaus/stax2/typed/Base64Variant;->getPaddingChar()C

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\'"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v4, v9, v5}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->reportInvalidChar(CILjava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    .line 113
    .end local v4    # "ch":C
    :cond_2
    :pswitch_1
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentEnd:I

    if-lt v4, v12, :cond_3

    .line 114
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->nextSegment()Z

    move-result v4

    if-nez v4, :cond_3

    .line 115
    goto/16 :goto_1

    .line 118
    :cond_3
    iget-object v4, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegment:[C

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    add-int/lit8 v13, v12, 0x1

    iput v13, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    aget-char v4, v4, v12

    .line 119
    .restart local v4    # "ch":C
    const/16 v12, 0x20

    if-le v4, v12, :cond_2

    .line 120
    iget-object v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v12, v4}, Lorg/codehaus/stax2/typed/Base64Variant;->decodeBase64Char(C)I

    move-result v12

    .line 121
    .local v12, "bits":I
    if-ltz v12, :cond_f

    .line 124
    iput v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    .line 131
    .end local v4    # "ch":C
    .end local v12    # "bits":I
    :pswitch_2
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentEnd:I

    const/4 v13, 0x1

    if-lt v4, v12, :cond_4

    .line 132
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->nextSegment()Z

    move-result v4

    if-nez v4, :cond_4

    .line 133
    iput v13, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    .line 134
    goto/16 :goto_1

    .line 137
    :cond_4
    iget-object v4, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegment:[C

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    add-int/lit8 v14, v12, 0x1

    iput v14, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    aget-char v4, v4, v12

    .line 138
    .restart local v4    # "ch":C
    iget-object v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v12, v4}, Lorg/codehaus/stax2/typed/Base64Variant;->decodeBase64Char(C)I

    move-result v12

    .line 139
    .restart local v12    # "bits":I
    if-ltz v12, :cond_e

    .line 142
    iget v13, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    shl-int/2addr v13, v11

    or-int/2addr v13, v12

    iput v13, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    .line 149
    .end local v4    # "ch":C
    .end local v12    # "bits":I
    :pswitch_3
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentEnd:I

    if-lt v4, v12, :cond_5

    .line 150
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->nextSegment()Z

    move-result v4

    if-nez v4, :cond_5

    .line 151
    iput v10, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    .line 152
    goto/16 :goto_1

    .line 155
    :cond_5
    iget-object v4, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegment:[C

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    add-int/lit8 v13, v12, 0x1

    iput v13, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    aget-char v4, v4, v12

    .line 156
    .restart local v4    # "ch":C
    iget-object v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v12, v4}, Lorg/codehaus/stax2/typed/Base64Variant;->decodeBase64Char(C)I

    move-result v12

    .line 157
    .restart local v12    # "bits":I
    if-gez v12, :cond_7

    .line 158
    if-ne v12, v5, :cond_6

    .line 162
    const/4 v5, 0x7

    iput v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    .line 163
    goto/16 :goto_0

    .line 159
    :cond_6
    invoke-virtual {p0, v4, v10}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->reportInvalidChar(CI)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    .line 165
    :cond_7
    iget v13, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    shl-int/2addr v13, v11

    or-int/2addr v13, v12

    iput v13, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    .line 172
    .end local v4    # "ch":C
    .end local v12    # "bits":I
    :pswitch_4
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentEnd:I

    if-lt v4, v12, :cond_8

    .line 173
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->nextSegment()Z

    move-result v4

    if-nez v4, :cond_8

    .line 174
    iput v9, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    .line 175
    goto :goto_1

    .line 178
    :cond_8
    iget-object v4, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegment:[C

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    add-int/lit8 v13, v12, 0x1

    iput v13, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    aget-char v4, v4, v12

    .line 179
    .restart local v4    # "ch":C
    iget-object v12, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v12, v4}, Lorg/codehaus/stax2/typed/Base64Variant;->decodeBase64Char(C)I

    move-result v12

    .line 180
    .restart local v12    # "bits":I
    if-gez v12, :cond_a

    .line 181
    if-ne v12, v5, :cond_9

    .line 190
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    shr-int/2addr v5, v10

    iput v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    .line 191
    iput v7, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    .line 192
    goto/16 :goto_0

    .line 182
    :cond_9
    invoke-virtual {p0, v4, v9}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->reportInvalidChar(CI)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    .line 195
    :cond_a
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    shl-int/2addr v5, v11

    or-int/2addr v5, v12

    iput v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    .line 200
    .end local v4    # "ch":C
    .end local v12    # "bits":I
    :pswitch_5
    if-lt v3, v2, :cond_b

    .line 201
    iput v8, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    .line 202
    goto :goto_1

    .line 204
    :cond_b
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "resultOffset":I
    .local v4, "resultOffset":I
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    shr-int/lit8 v5, v5, 0x10

    int-to-byte v5, v5

    aput-byte v5, p1, v3

    move v3, v4

    .line 208
    .end local v4    # "resultOffset":I
    .restart local v3    # "resultOffset":I
    :pswitch_6
    if-lt v3, v2, :cond_c

    .line 209
    iput v7, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    .line 210
    goto :goto_1

    .line 212
    :cond_c
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "resultOffset":I
    .restart local v4    # "resultOffset":I
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    shr-int/lit8 v5, v5, 0x8

    int-to-byte v5, v5

    aput-byte v5, p1, v3

    move v3, v4

    .line 216
    .end local v4    # "resultOffset":I
    .restart local v3    # "resultOffset":I
    :pswitch_7
    if-lt v3, v2, :cond_d

    .line 217
    iput v11, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    .line 218
    nop

    .line 247
    :goto_1
    sub-int v4, v3, v1

    return v4

    .line 220
    :cond_d
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "resultOffset":I
    .restart local v4    # "resultOffset":I
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_decodedData:I

    int-to-byte v5, v5

    aput-byte v5, p1, v3

    .line 221
    iput v6, v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    .line 222
    move v3, v4

    goto/16 :goto_0

    .line 140
    .restart local v3    # "resultOffset":I
    .local v4, "ch":C
    .restart local v12    # "bits":I
    :cond_e
    invoke-virtual {p0, v4, v13}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->reportInvalidChar(CI)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    .line 122
    :cond_f
    invoke-virtual {p0, v4, v6}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->reportInvalidChar(CI)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_0
    .end packed-switch
.end method

.method public bridge synthetic decodeCompletely()[B
    .locals 1

    .line 26
    invoke-super {p0}, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->decodeCompletely()[B

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getByteAggregator()Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;
    .locals 1

    .line 26
    invoke-super {p0}, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->getByteAggregator()Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

    move-result-object v0

    return-object v0
.end method

.method public init(Lorg/codehaus/stax2/typed/Base64Variant;Z[CIILjava/util/List;)V
    .locals 4
    .param p1, "variant"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "firstChunk"    # Z
    .param p3, "lastSegment"    # [C
    .param p4, "lastOffset"    # I
    .param p5, "lastLen"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/codehaus/stax2/typed/Base64Variant;",
            "Z[CII",
            "Ljava/util/List<",
            "[C>;)V"
        }
    .end annotation

    .line 56
    .local p6, "segments":Ljava/util/List;, "Ljava/util/List<[C>;"
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    .line 60
    const/4 v0, 0x0

    if-eqz p2, :cond_0

    .line 61
    iput v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_state:I

    .line 63
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 64
    if-eqz p6, :cond_4

    invoke-interface {p6}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    goto :goto_1

    .line 69
    :cond_1
    if-eqz p3, :cond_3

    .line 73
    invoke-interface {p6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .line 74
    .local v1, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<[C>;"
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [C

    iput-object v2, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegment:[C

    .line 75
    iput v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    .line 76
    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegment:[C

    array-length v2, v2

    iput v2, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentEnd:I

    .line 78
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 79
    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegments:Ljava/util/ArrayList;

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 81
    :cond_2
    iput v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegmentIndex:I

    .line 84
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_nextSegments:Ljava/util/ArrayList;

    invoke-virtual {v0, p3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 85
    iput p4, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_lastSegmentOffset:I

    .line 86
    add-int v0, p4, p5

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_lastSegmentEnd:I

    goto :goto_2

    .line 70
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<[C>;"
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw v0

    .line 65
    :cond_4
    :goto_1
    iput-object p3, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegment:[C

    .line 66
    iput p4, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentPtr:I

    .line 67
    add-int v0, p4, p5

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->_currSegmentEnd:I

    .line 88
    :goto_2
    return-void
.end method
