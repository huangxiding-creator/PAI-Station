.class public final Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;
.super Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;
.source "StringBase64Decoder.java"


# instance fields
.field _currSegment:Ljava/lang/String;

.field _currSegmentEnd:I

.field _currSegmentPtr:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 38
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;-><init>()V

    return-void
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

    .line 63
    move-object v0, p0

    move/from16 v1, p2

    .line 64
    .local v1, "origResultOffset":I
    add-int v2, p2, p3

    move/from16 v3, p2

    .line 68
    .end local p2    # "resultOffset":I
    .local v2, "resultBufferEnd":I
    .local v3, "resultOffset":I
    :goto_0
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    const/4 v5, -0x2

    const/4 v6, 0x0

    const/4 v7, 0x5

    const/4 v8, 0x4

    const/4 v9, 0x3

    const/4 v10, 0x2

    const/4 v11, 0x6

    packed-switch v4, :pswitch_data_0

    .line 195
    new-instance v4, Ljava/lang/IllegalStateException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Illegal internal state "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 179
    :pswitch_0
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    iget v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentEnd:I

    if-lt v4, v5, :cond_0

    .line 181
    goto/16 :goto_1

    .line 183
    :cond_0
    iget-object v4, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegment:Ljava/lang/String;

    iget v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    invoke-virtual {v4, v5}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 184
    .local v4, "ch":C
    iget-object v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v5, v4}, Lorg/codehaus/stax2/typed/Base64Variant;->usesPaddingChar(C)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 188
    iput v11, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    .line 189
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    shr-int/2addr v5, v8

    iput v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    .line 191
    .end local v4    # "ch":C
    goto :goto_0

    .line 185
    .restart local v4    # "ch":C
    :cond_1
    const-string v5, "expected padding character \'=\'"

    invoke-virtual {p0, v4, v9, v5}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->reportInvalidChar(CILjava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    .line 74
    .end local v4    # "ch":C
    :cond_2
    :pswitch_1
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentEnd:I

    if-lt v4, v12, :cond_3

    .line 75
    goto/16 :goto_1

    .line 77
    :cond_3
    iget-object v4, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegment:Ljava/lang/String;

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    add-int/lit8 v13, v12, 0x1

    iput v13, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    invoke-virtual {v4, v12}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 78
    .restart local v4    # "ch":C
    const/16 v12, 0x20

    if-le v4, v12, :cond_2

    .line 79
    iget-object v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v12, v4}, Lorg/codehaus/stax2/typed/Base64Variant;->decodeBase64Char(C)I

    move-result v12

    .line 80
    .local v12, "bits":I
    if-ltz v12, :cond_f

    .line 83
    iput v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    .line 90
    .end local v4    # "ch":C
    .end local v12    # "bits":I
    :pswitch_2
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentEnd:I

    const/4 v13, 0x1

    if-lt v4, v12, :cond_4

    .line 91
    iput v13, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    .line 92
    goto/16 :goto_1

    .line 94
    :cond_4
    iget-object v4, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegment:Ljava/lang/String;

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    add-int/lit8 v14, v12, 0x1

    iput v14, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    invoke-virtual {v4, v12}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 95
    .restart local v4    # "ch":C
    iget-object v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v12, v4}, Lorg/codehaus/stax2/typed/Base64Variant;->decodeBase64Char(C)I

    move-result v12

    .line 96
    .restart local v12    # "bits":I
    if-ltz v12, :cond_e

    .line 99
    iget v13, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    shl-int/2addr v13, v11

    or-int/2addr v13, v12

    iput v13, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    .line 106
    .end local v4    # "ch":C
    .end local v12    # "bits":I
    :pswitch_3
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentEnd:I

    if-lt v4, v12, :cond_5

    .line 107
    iput v10, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    .line 108
    goto/16 :goto_1

    .line 110
    :cond_5
    iget-object v4, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegment:Ljava/lang/String;

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    add-int/lit8 v13, v12, 0x1

    iput v13, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    invoke-virtual {v4, v12}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 111
    .restart local v4    # "ch":C
    iget-object v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v12, v4}, Lorg/codehaus/stax2/typed/Base64Variant;->decodeBase64Char(C)I

    move-result v12

    .line 112
    .restart local v12    # "bits":I
    if-gez v12, :cond_7

    .line 113
    if-ne v12, v5, :cond_6

    .line 117
    const/4 v5, 0x7

    iput v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    .line 118
    goto/16 :goto_0

    .line 114
    :cond_6
    invoke-virtual {p0, v4, v10}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->reportInvalidChar(CI)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    .line 120
    :cond_7
    iget v13, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    shl-int/2addr v13, v11

    or-int/2addr v13, v12

    iput v13, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    .line 127
    .end local v4    # "ch":C
    .end local v12    # "bits":I
    :pswitch_4
    iget v4, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentEnd:I

    if-lt v4, v12, :cond_8

    .line 128
    iput v9, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    .line 129
    goto :goto_1

    .line 131
    :cond_8
    iget-object v4, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegment:Ljava/lang/String;

    iget v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    add-int/lit8 v13, v12, 0x1

    iput v13, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    invoke-virtual {v4, v12}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 132
    .restart local v4    # "ch":C
    iget-object v12, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v12, v4}, Lorg/codehaus/stax2/typed/Base64Variant;->decodeBase64Char(C)I

    move-result v12

    .line 133
    .restart local v12    # "bits":I
    if-gez v12, :cond_a

    .line 134
    if-ne v12, v5, :cond_9

    .line 143
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    shr-int/2addr v5, v10

    iput v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    .line 144
    iput v7, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    .line 145
    goto/16 :goto_0

    .line 135
    :cond_9
    invoke-virtual {p0, v4, v9}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->reportInvalidChar(CI)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    .line 148
    :cond_a
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    shl-int/2addr v5, v11

    or-int/2addr v5, v12

    iput v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    .line 153
    .end local v4    # "ch":C
    .end local v12    # "bits":I
    :pswitch_5
    if-lt v3, v2, :cond_b

    .line 154
    iput v8, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    .line 155
    goto :goto_1

    .line 157
    :cond_b
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "resultOffset":I
    .local v4, "resultOffset":I
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    shr-int/lit8 v5, v5, 0x10

    int-to-byte v5, v5

    aput-byte v5, p1, v3

    move v3, v4

    .line 161
    .end local v4    # "resultOffset":I
    .restart local v3    # "resultOffset":I
    :pswitch_6
    if-lt v3, v2, :cond_c

    .line 162
    iput v7, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    .line 163
    goto :goto_1

    .line 165
    :cond_c
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "resultOffset":I
    .restart local v4    # "resultOffset":I
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    shr-int/lit8 v5, v5, 0x8

    int-to-byte v5, v5

    aput-byte v5, p1, v3

    move v3, v4

    .line 169
    .end local v4    # "resultOffset":I
    .restart local v3    # "resultOffset":I
    :pswitch_7
    if-lt v3, v2, :cond_d

    .line 170
    iput v11, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    .line 171
    nop

    .line 198
    :goto_1
    sub-int v4, v3, v1

    return v4

    .line 173
    :cond_d
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "resultOffset":I
    .restart local v4    # "resultOffset":I
    iget v5, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_decodedData:I

    int-to-byte v5, v5

    aput-byte v5, p1, v3

    .line 174
    iput v6, v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    .line 175
    move v3, v4

    goto/16 :goto_0

    .line 97
    .restart local v3    # "resultOffset":I
    .local v4, "ch":C
    .restart local v12    # "bits":I
    :cond_e
    invoke-virtual {p0, v4, v13}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->reportInvalidChar(CI)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    .line 81
    :cond_f
    invoke-virtual {p0, v4, v6}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->reportInvalidChar(CI)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    nop

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

    .line 24
    invoke-super {p0}, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->decodeCompletely()[B

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getByteAggregator()Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;
    .locals 1

    .line 24
    invoke-super {p0}, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->getByteAggregator()Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

    move-result-object v0

    return-object v0
.end method

.method public init(Lorg/codehaus/stax2/typed/Base64Variant;ZLjava/lang/String;)V
    .locals 1
    .param p1, "variant"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "firstChunk"    # Z
    .param p3, "segment"    # Ljava/lang/String;

    .line 42
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    .line 43
    const/4 v0, 0x0

    if-eqz p2, :cond_0

    .line 44
    iput v0, p0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_state:I

    .line 46
    :cond_0
    iput-object p3, p0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegment:Ljava/lang/String;

    .line 47
    iput v0, p0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentPtr:I

    .line 48
    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v0

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->_currSegmentEnd:I

    .line 49
    return-void
.end method
