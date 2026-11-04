.class abstract Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;
.super Ljava/lang/Object;
.source "Base64DecoderBase.java"


# static fields
.field static final INT_SPACE:I = 0x20

.field static final STATE_INITIAL:I = 0x0

.field static final STATE_OUTPUT_1:I = 0x6

.field static final STATE_OUTPUT_2:I = 0x5

.field static final STATE_OUTPUT_3:I = 0x4

.field static final STATE_VALID_1:I = 0x1

.field static final STATE_VALID_2:I = 0x2

.field static final STATE_VALID_2_AND_PADDING:I = 0x7

.field static final STATE_VALID_3:I = 0x3


# instance fields
.field _byteAggr:Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

.field _decodedData:I

.field _state:I

.field _variant:Lorg/codehaus/stax2/typed/Base64Variant;


# direct methods
.method protected constructor <init>()V
    .locals 1

    .line 121
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 101
    const/4 v0, 0x0

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_state:I

    .line 113
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_byteAggr:Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

    .line 121
    return-void
.end method


# virtual methods
.method public abstract decode([BII)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public decodeCompletely()[B
    .locals 8

    .line 202
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->getByteAggregator()Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

    move-result-object v0

    .line 203
    .local v0, "aggr":Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->startAggregation()[B

    move-result-object v1

    .line 206
    .local v1, "buffer":[B
    :goto_0
    const/4 v2, 0x0

    .line 207
    .local v2, "offset":I
    array-length v3, v1

    .line 210
    .local v3, "len":I
    :cond_0
    invoke-virtual {p0, v1, v2, v3}, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->decode([BII)I

    move-result v4

    .line 212
    .local v4, "readCount":I
    const/4 v5, 0x1

    if-ge v4, v5, :cond_3

    .line 220
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->endOfContent()I

    move-result v5

    .line 221
    .local v5, "left":I
    if-ltz v5, :cond_2

    .line 223
    if-lez v5, :cond_1

    .line 224
    goto :goto_1

    .line 226
    :cond_1
    invoke-virtual {v0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->aggregateAll([BI)[B

    move-result-object v6

    return-object v6

    .line 222
    :cond_2
    new-instance v6, Ljava/lang/IllegalArgumentException;

    const-string v7, "Incomplete base64 triplet at the end of decoded content"

    invoke-direct {v6, v7}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 228
    .end local v5    # "left":I
    :cond_3
    add-int/2addr v2, v4

    .line 229
    sub-int/2addr v3, v4

    .line 230
    .end local v4    # "readCount":I
    :goto_1
    if-gtz v3, :cond_0

    .line 233
    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->addFullBlock([B)[B

    move-result-object v1

    .line 234
    .end local v2    # "offset":I
    .end local v3    # "len":I
    goto :goto_0
.end method

.method public final endOfContent()I
    .locals 6

    .line 165
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_state:I

    if-eqz v0, :cond_4

    iget v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_state:I

    const/4 v1, 0x4

    if-eq v0, v1, :cond_4

    iget v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_state:I

    const/4 v2, 0x5

    if-eq v0, v2, :cond_4

    iget v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_state:I

    const/4 v3, 0x6

    if-ne v0, v3, :cond_0

    goto :goto_0

    .line 170
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v0}, Lorg/codehaus/stax2/typed/Base64Variant;->usesPadding()Z

    move-result v0

    const/4 v4, -0x1

    if-eqz v0, :cond_1

    .line 171
    return v4

    .line 175
    :cond_1
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_state:I

    const/4 v5, 0x2

    if-ne v0, v5, :cond_2

    .line 177
    iput v3, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_state:I

    .line 178
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_decodedData:I

    shr-int/2addr v0, v1

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_decodedData:I

    .line 179
    const/4 v0, 0x1

    return v0

    .line 180
    :cond_2
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_state:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_3

    .line 182
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_decodedData:I

    shr-int/2addr v0, v5

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_decodedData:I

    .line 183
    iput v2, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_state:I

    .line 184
    return v5

    .line 186
    :cond_3
    return v4

    .line 167
    :cond_4
    :goto_0
    const/4 v0, 0x0

    return v0
.end method

.method public getByteAggregator()Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;
    .locals 1

    .line 239
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_byteAggr:Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

    if-nez v0, :cond_0

    .line 240
    new-instance v0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_byteAggr:Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

    .line 242
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_byteAggr:Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

    return-object v0
.end method

.method public final hasData()Z
    .locals 2

    .line 141
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_state:I

    const/4 v1, 0x4

    if-lt v0, v1, :cond_0

    iget v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_state:I

    const/4 v1, 0x6

    if-gt v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method protected reportInvalidChar(CI)Ljava/lang/IllegalArgumentException;
    .locals 1
    .param p1, "ch"    # C
    .param p2, "bindex"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 254
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->reportInvalidChar(CILjava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v0

    return-object v0
.end method

.method protected reportInvalidChar(CILjava/lang/String;)Ljava/lang/IllegalArgumentException;
    .locals 3
    .param p1, "ch"    # C
    .param p2, "bindex"    # I
    .param p3, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 265
    const/16 v0, 0x20

    if-gt p1, v0, :cond_0

    .line 266
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Illegal white space character (code 0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ") as character #"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    add-int/lit8 v1, p2, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " of 4-char base64 unit: can only used between units"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "base":Ljava/lang/String;
    goto/16 :goto_1

    .line 267
    .end local v0    # "base":Ljava/lang/String;
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/typed/Base64Variant;->usesPaddingChar(C)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 268
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected padding character (\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lorg/codehaus/stax2/ri/typed/Base64DecoderBase;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v1}, Lorg/codehaus/stax2/typed/Base64Variant;->getPaddingChar()C

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\') as character #"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    add-int/lit8 v1, p2, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " of 4-char base64 unit: padding only legal as 3rd or 4th character"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .restart local v0    # "base":Ljava/lang/String;
    goto :goto_1

    .line 269
    .end local v0    # "base":Ljava/lang/String;
    :cond_1
    invoke-static {p1}, Ljava/lang/Character;->isDefined(C)Z

    move-result v0

    const-string v1, ") in base64 content"

    if-eqz v0, :cond_3

    invoke-static {p1}, Ljava/lang/Character;->isISOControl(C)Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_0

    .line 273
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Illegal character \'"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\' (code 0x"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .restart local v0    # "base":Ljava/lang/String;
    goto :goto_1

    .line 271
    .end local v0    # "base":Ljava/lang/String;
    :cond_3
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Illegal character (code 0x"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 275
    .restart local v0    # "base":Ljava/lang/String;
    :goto_1
    if-eqz p3, :cond_4

    .line 276
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 278
    :cond_4
    new-instance v1, Ljava/lang/IllegalArgumentException;

    invoke-direct {v1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    return-object v1
.end method
