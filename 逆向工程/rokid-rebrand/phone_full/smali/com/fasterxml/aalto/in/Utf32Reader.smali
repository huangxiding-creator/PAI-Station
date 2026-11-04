.class public Lcom/fasterxml/aalto/in/Utf32Reader;
.super Ljava/io/Reader;
.source "Utf32Reader.java"


# static fields
.field private static final NULL_CHAR:C


# instance fields
.field protected final mBigEndian:Z

.field protected mBuffer:[B

.field protected mByteCount:I

.field protected mCharCount:I

.field protected final mConfig:Lcom/fasterxml/aalto/in/ReaderConfig;

.field protected mIn:Ljava/io/InputStream;

.field protected mLength:I

.field protected mPtr:I

.field protected mSurrogate:C

.field mTmpBuf:[C


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;[BIIZ)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "buf"    # [B
    .param p4, "ptr"    # I
    .param p5, "len"    # I
    .param p6, "isBigEndian"    # Z

    .line 68
    invoke-direct {p0}, Ljava/io/Reader;-><init>()V

    .line 47
    const/4 v0, 0x0

    iput-char v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mSurrogate:C

    .line 52
    iput v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mCharCount:I

    .line 57
    iput v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mByteCount:I

    .line 91
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mTmpBuf:[C

    .line 69
    iput-object p1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mConfig:Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 70
    iput-boolean p6, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mBigEndian:Z

    .line 71
    return-void
.end method

.method private loadMore(I)Z
    .locals 7
    .param p1, "available"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 219
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mByteCount:I

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    sub-int/2addr v1, p1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mByteCount:I

    .line 222
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-lez p1, :cond_2

    .line 223
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mPtr:I

    if-lez v2, :cond_1

    .line 224
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, p1, :cond_0

    .line 225
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mBuffer:[B

    iget-object v4, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mPtr:I

    add-int/2addr v5, v2

    aget-byte v4, v4, v5

    aput-byte v4, v3, v2

    .line 224
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 227
    .end local v2    # "i":I
    :cond_0
    iput v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mPtr:I

    .line 229
    :cond_1
    iput p1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    goto :goto_1

    .line 233
    :cond_2
    iput v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mPtr:I

    .line 234
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mIn:Ljava/io/InputStream;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mBuffer:[B

    invoke-virtual {v2, v3}, Ljava/io/InputStream;->read([B)I

    move-result v2

    .line 235
    .local v2, "count":I
    if-ge v2, v0, :cond_4

    .line 236
    iput v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    .line 237
    if-gez v2, :cond_3

    .line 238
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf32Reader;->freeBuffers()V

    .line 239
    return v1

    .line 242
    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf32Reader;->reportStrangeStream()V

    .line 244
    :cond_4
    iput v2, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    .line 249
    .end local v2    # "count":I
    :goto_1
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    const/4 v2, 0x4

    if-ge v1, v2, :cond_7

    .line 250
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mIn:Ljava/io/InputStream;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mBuffer:[B

    array-length v5, v5

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    sub-int/2addr v5, v6

    invoke-virtual {v1, v3, v4, v5}, Ljava/io/InputStream;->read([BII)I

    move-result v1

    .line 251
    .local v1, "count":I
    if-ge v1, v0, :cond_6

    .line 252
    if-gez v1, :cond_5

    .line 253
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf32Reader;->freeBuffers()V

    .line 254
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    invoke-direct {p0, v3, v2}, Lcom/fasterxml/aalto/in/Utf32Reader;->reportUnexpectedEOF(II)V

    .line 257
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf32Reader;->reportStrangeStream()V

    .line 259
    :cond_6
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    add-int/2addr v2, v1

    iput v2, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    .line 260
    .end local v1    # "count":I
    goto :goto_1

    .line 261
    :cond_7
    return v0
.end method

.method private reportInvalid(IILjava/lang/String;)V
    .locals 5
    .param p1, "value"    # I
    .param p2, "offset"    # I
    .param p3, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 295
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mByteCount:I

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mPtr:I

    add-int/2addr v0, v1

    add-int/lit8 v0, v0, -0x1

    .line 296
    .local v0, "bytePos":I
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mCharCount:I

    add-int/2addr v1, p2

    .line 298
    .local v1, "charPos":I
    new-instance v2, Ljava/io/CharConversionException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Invalid UTF-32 character 0x"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 299
    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " at char #"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", byte #"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ")"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/CharConversionException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method private reportUnexpectedEOF(II)V
    .locals 5
    .param p1, "gotBytes"    # I
    .param p2, "needed"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 284
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mByteCount:I

    add-int/2addr v0, p1

    .line 285
    .local v0, "bytePos":I
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mCharCount:I

    .line 287
    .local v1, "charPos":I
    new-instance v2, Ljava/io/CharConversionException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Unexpected EOF in the middle of a 4-byte UTF-32 char: got "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", needed "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", at char #"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", byte #"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ")"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/CharConversionException;-><init>(Ljava/lang/String;)V

    throw v2
.end method


# virtual methods
.method public close()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 82
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mIn:Ljava/io/InputStream;

    .line 84
    .local v0, "in":Ljava/io/InputStream;
    if-eqz v0, :cond_0

    .line 85
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mIn:Ljava/io/InputStream;

    .line 86
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf32Reader;->freeBuffers()V

    .line 87
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 89
    :cond_0
    return-void
.end method

.method public final freeBuffers()V
    .locals 2

    .line 266
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mBuffer:[B

    .line 267
    .local v0, "buf":[B
    if-eqz v0, :cond_0

    .line 268
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mBuffer:[B

    .line 269
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mConfig:Lcom/fasterxml/aalto/in/ReaderConfig;

    if-eqz v1, :cond_0

    .line 270
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mConfig:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->freeFullBBuffer([B)V

    .line 273
    :cond_0
    return-void
.end method

.method public read()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 101
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mTmpBuf:[C

    const/4 v1, 0x1

    if-nez v0, :cond_0

    .line 102
    new-array v0, v1, [C

    iput-object v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mTmpBuf:[C

    .line 104
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mTmpBuf:[C

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v2, v1}, Lcom/fasterxml/aalto/in/Utf32Reader;->read([CII)I

    move-result v0

    if-ge v0, v1, :cond_1

    .line 105
    const/4 v0, -0x1

    return v0

    .line 107
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mTmpBuf:[C

    aget-char v0, v0, v2

    return v0
.end method

.method public read([CII)I
    .locals 10
    .param p1, "cbuf"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 120
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mBuffer:[B

    const/4 v1, -0x1

    if-nez v0, :cond_0

    .line 121
    return v1

    .line 123
    :cond_0
    const/4 v0, 0x1

    if-ge p3, v0, :cond_1

    .line 124
    return p3

    .line 127
    :cond_1
    if-ltz p2, :cond_2

    add-int v0, p2, p3

    array-length v2, p1

    if-le v0, v2, :cond_3

    .line 128
    :cond_2
    invoke-virtual {p0, p1, p2, p3}, Lcom/fasterxml/aalto/in/Utf32Reader;->reportBounds([CII)V

    .line 131
    :cond_3
    add-int/2addr p3, p2

    .line 132
    move v0, p2

    .line 135
    .local v0, "outPtr":I
    iget-char v2, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mSurrogate:C

    const/4 v3, 0x4

    if-eqz v2, :cond_4

    .line 136
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "outPtr":I
    .local v1, "outPtr":I
    iget-char v2, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mSurrogate:C

    aput-char v2, p1, v0

    .line 137
    const/4 v0, 0x0

    iput-char v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mSurrogate:C

    move v0, v1

    goto :goto_0

    .line 143
    .end local v1    # "outPtr":I
    .restart local v0    # "outPtr":I
    :cond_4
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mPtr:I

    sub-int/2addr v2, v4

    .line 144
    .local v2, "left":I
    if-ge v2, v3, :cond_5

    .line 145
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf32Reader;->loadMore(I)Z

    move-result v4

    if-nez v4, :cond_5

    .line 146
    return v1

    .line 151
    .end local v2    # "left":I
    :cond_5
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mBuffer:[B

    .line 154
    .local v1, "buf":[B
    :goto_1
    if-ge v0, p3, :cond_d

    .line 155
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mPtr:I

    .line 158
    .local v2, "ptr":I
    iget-boolean v4, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mBigEndian:Z

    if-eqz v4, :cond_6

    .line 159
    aget-byte v4, v1, v2

    shl-int/lit8 v4, v4, 0x18

    add-int/lit8 v5, v2, 0x1

    aget-byte v5, v1, v5

    and-int/lit16 v5, v5, 0xff

    shl-int/lit8 v5, v5, 0x10

    or-int/2addr v4, v5

    add-int/lit8 v5, v2, 0x2

    aget-byte v5, v1, v5

    and-int/lit16 v5, v5, 0xff

    shl-int/lit8 v5, v5, 0x8

    or-int/2addr v4, v5

    add-int/lit8 v5, v2, 0x3

    aget-byte v5, v1, v5

    and-int/lit16 v5, v5, 0xff

    or-int/2addr v4, v5

    .local v4, "ch":I
    goto :goto_2

    .line 162
    .end local v4    # "ch":I
    :cond_6
    aget-byte v4, v1, v2

    and-int/lit16 v4, v4, 0xff

    add-int/lit8 v5, v2, 0x1

    aget-byte v5, v1, v5

    and-int/lit16 v5, v5, 0xff

    shl-int/lit8 v5, v5, 0x8

    or-int/2addr v4, v5

    add-int/lit8 v5, v2, 0x2

    aget-byte v5, v1, v5

    and-int/lit16 v5, v5, 0xff

    shl-int/lit8 v5, v5, 0x10

    or-int/2addr v4, v5

    add-int/lit8 v5, v2, 0x3

    aget-byte v5, v1, v5

    shl-int/lit8 v5, v5, 0x18

    or-int/2addr v4, v5

    .line 165
    .restart local v4    # "ch":I
    :goto_2
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mPtr:I

    add-int/2addr v5, v3

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mPtr:I

    .line 168
    const v5, 0xd800

    if-lt v4, v5, :cond_b

    .line 170
    const v6, 0x10ffff

    if-le v4, v6, :cond_7

    .line 171
    sub-int v7, v0, p2

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "(above "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    .line 172
    invoke-static {v6}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v8, ") "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 171
    invoke-direct {p0, v4, v7, v6}, Lcom/fasterxml/aalto/in/Utf32Reader;->reportInvalid(IILjava/lang/String;)V

    .line 174
    :cond_7
    const v6, 0xffff

    if-le v4, v6, :cond_9

    .line 175
    const/high16 v6, 0x10000

    sub-int/2addr v4, v6

    .line 176
    add-int/lit8 v6, v0, 0x1

    .end local v0    # "outPtr":I
    .local v6, "outPtr":I
    shr-int/lit8 v7, v4, 0xa

    add-int/2addr v7, v5

    int-to-char v5, v7

    aput-char v5, p1, v0

    .line 178
    and-int/lit16 v0, v4, 0x3ff

    const v5, 0xdc00

    or-int v4, v0, v5

    .line 180
    if-lt v6, p3, :cond_8

    .line 181
    int-to-char v0, v4

    iput-char v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mSurrogate:C

    .line 182
    move v0, v6

    goto :goto_4

    .line 180
    :cond_8
    move v0, v6

    goto :goto_3

    .line 185
    .end local v6    # "outPtr":I
    .restart local v0    # "outPtr":I
    :cond_9
    const v5, 0xe000

    if-ge v4, v5, :cond_a

    .line 186
    sub-int v5, v0, p2

    const-string v6, "(a surrogate char) "

    invoke-direct {p0, v4, v5, v6}, Lcom/fasterxml/aalto/in/Utf32Reader;->reportInvalid(IILjava/lang/String;)V

    goto :goto_3

    .line 187
    :cond_a
    const v5, 0xfffe

    if-lt v4, v5, :cond_b

    .line 188
    sub-int v5, v0, p2

    const-string v6, ""

    invoke-direct {p0, v4, v5, v6}, Lcom/fasterxml/aalto/in/Utf32Reader;->reportInvalid(IILjava/lang/String;)V

    .line 192
    :cond_b
    :goto_3
    add-int/lit8 v5, v0, 0x1

    .end local v0    # "outPtr":I
    .local v5, "outPtr":I
    int-to-char v6, v4

    aput-char v6, p1, v0

    .line 193
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mLength:I

    if-lt v0, v6, :cond_c

    .line 194
    move v0, v5

    goto :goto_4

    .line 196
    .end local v2    # "ptr":I
    .end local v4    # "ch":I
    :cond_c
    move v0, v5

    goto/16 :goto_1

    .line 198
    .end local v5    # "outPtr":I
    .restart local v0    # "outPtr":I
    :cond_d
    :goto_4
    sub-int p3, v0, p2

    .line 199
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mCharCount:I

    add-int/2addr v2, p3

    iput v2, p0, Lcom/fasterxml/aalto/in/Utf32Reader;->mCharCount:I

    .line 200
    return p3
.end method

.method protected reportBounds([CII)V
    .locals 3
    .param p1, "cbuf"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 306
    new-instance v0, Ljava/lang/ArrayIndexOutOfBoundsException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "read(buf,"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "), cbuf["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v2, p1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "]"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/ArrayIndexOutOfBoundsException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected reportStrangeStream()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 312
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Strange I/O stream, returned 0 bytes on read"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
