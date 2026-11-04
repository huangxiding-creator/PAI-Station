.class public final Lcom/fasterxml/aalto/io/UTF8Writer;
.super Ljava/io/Writer;
.source "UTF8Writer.java"


# static fields
.field static final SURR1_FIRST:I = 0xd800

.field static final SURR1_LAST:I = 0xdbff

.field static final SURR2_FIRST:I = 0xdc00

.field static final SURR2_LAST:I = 0xdfff


# instance fields
.field final mAutoCloseOutput:Z

.field final mConfig:Lcom/fasterxml/aalto/out/WriterConfig;

.field mOut:Ljava/io/OutputStream;

.field mOutBuffer:[B

.field final mOutBufferLast:I

.field mOutPtr:I

.field mSurrogate:I


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/OutputStream;Z)V
    .locals 2
    .param p1, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;
    .param p2, "out"    # Ljava/io/OutputStream;
    .param p3, "autoclose"    # Z

    .line 35
    invoke-direct {p0}, Ljava/io/Writer;-><init>()V

    .line 32
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mSurrogate:I

    .line 36
    iput-object p1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mConfig:Lcom/fasterxml/aalto/out/WriterConfig;

    .line 37
    iput-boolean p3, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mAutoCloseOutput:Z

    .line 38
    iput-object p2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOut:Ljava/io/OutputStream;

    .line 39
    const/16 v1, 0xfa0

    invoke-virtual {p1, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->allocFullBBuffer(I)[B

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    .line 44
    iget-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    array-length v1, v1

    add-int/lit8 v1, v1, -0x4

    iput v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBufferLast:I

    .line 45
    iput v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 46
    return-void
.end method

.method private convertSurrogate(I)I
    .locals 4
    .param p1, "secondPart"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 364
    iget v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mSurrogate:I

    .line 365
    .local v0, "firstPart":I
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mSurrogate:I

    .line 368
    const v1, 0xdc00

    if-lt p1, v1, :cond_0

    const v2, 0xdfff

    if-gt p1, v2, :cond_0

    .line 371
    const v2, 0xd800

    sub-int v2, v0, v2

    shl-int/lit8 v2, v2, 0xa

    const/high16 v3, 0x10000

    add-int/2addr v2, v3

    sub-int v1, p1, v1

    add-int/2addr v2, v1

    return v2

    .line 369
    :cond_0
    new-instance v1, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Broken surrogate pair: first char 0x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", second 0x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "; illegal combination"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private throwIllegal(I)V
    .locals 4
    .param p1, "code"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 377
    const v0, 0x10ffff

    const-string v1, "Illegal character point (0x"

    if-gt p1, v0, :cond_2

    .line 380
    const v0, 0xd800

    if-lt p1, v0, :cond_1

    .line 381
    const v0, 0xdbff

    const-string v1, ")"

    if-gt p1, v0, :cond_0

    .line 382
    new-instance v0, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unmatched first part of surrogate pair (0x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 384
    :cond_0
    new-instance v0, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unmatched second part of surrogate pair (0x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 388
    :cond_1
    new-instance v0, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") to output"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 378
    :cond_2
    new-instance v0, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") to output; max is 0x10FFFF as per RFC 3629"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public close()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 66
    iget-object v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOut:Ljava/io/OutputStream;

    if-eqz v0, :cond_2

    .line 67
    iget v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    const/4 v1, 0x0

    if-lez v0, :cond_0

    .line 68
    iget-object v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOut:Ljava/io/OutputStream;

    iget-object v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    invoke-virtual {v0, v2, v1, v3}, Ljava/io/OutputStream;->write([BII)V

    .line 69
    iput v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 71
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOut:Ljava/io/OutputStream;

    .line 72
    .local v0, "out":Ljava/io/OutputStream;
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOut:Ljava/io/OutputStream;

    .line 73
    iget-object v3, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    .line 74
    .local v3, "buf":[B
    iput-object v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    .line 76
    iget-boolean v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mAutoCloseOutput:Z

    if-eqz v2, :cond_1

    .line 77
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    .line 79
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mConfig:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v2, v3}, Lcom/fasterxml/aalto/out/WriterConfig;->freeFullBBuffer([B)V

    .line 84
    iget v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mSurrogate:I

    .line 85
    .local v2, "code":I
    iput v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mSurrogate:I

    .line 86
    if-lez v2, :cond_2

    .line 87
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/io/UTF8Writer;->throwIllegal(I)V

    .line 90
    .end local v0    # "out":Ljava/io/OutputStream;
    .end local v2    # "code":I
    .end local v3    # "buf":[B
    :cond_2
    return-void
.end method

.method public flush()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 95
    iget v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    if-lez v0, :cond_0

    .line 96
    iget-object v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOut:Ljava/io/OutputStream;

    iget-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/OutputStream;->write([BII)V

    .line 97
    iput v3, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 99
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOut:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V

    .line 100
    return-void
.end method

.method public write(I)V
    .locals 5
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 208
    iget v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mSurrogate:I

    if-lez v0, :cond_0

    .line 209
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/io/UTF8Writer;->convertSurrogate(I)I

    move-result p1

    goto :goto_0

    .line 211
    :cond_0
    const v0, 0xd800

    if-lt p1, v0, :cond_2

    const v0, 0xdfff

    if-gt p1, v0, :cond_2

    .line 213
    const v0, 0xdbff

    if-le p1, v0, :cond_1

    .line 214
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/io/UTF8Writer;->throwIllegal(I)V

    .line 217
    :cond_1
    iput p1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mSurrogate:I

    .line 218
    return-void

    .line 221
    :cond_2
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBufferLast:I

    if-lt v0, v1, :cond_3

    .line 222
    iget-object v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOut:Ljava/io/OutputStream;

    iget-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/OutputStream;->write([BII)V

    .line 223
    iput v3, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 226
    :cond_3
    const/16 v0, 0x80

    if-ge p1, v0, :cond_4

    .line 227
    iget-object v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    int-to-byte v2, p1

    aput-byte v2, v0, v1

    goto/16 :goto_2

    .line 229
    :cond_4
    iget v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 230
    .local v1, "ptr":I
    const/16 v2, 0x800

    if-ge p1, v2, :cond_5

    .line 231
    iget-object v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .local v3, "ptr":I
    shr-int/lit8 v4, p1, 0x6

    or-int/lit16 v4, v4, 0xc0

    int-to-byte v4, v4

    aput-byte v4, v2, v1

    .line 232
    iget-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    add-int/lit8 v2, v3, 0x1

    .end local v3    # "ptr":I
    .local v2, "ptr":I
    and-int/lit8 v4, p1, 0x3f

    or-int/2addr v0, v4

    int-to-byte v0, v0

    aput-byte v0, v1, v3

    goto :goto_1

    .line 233
    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    :cond_5
    const v2, 0xffff

    if-gt p1, v2, :cond_6

    .line 234
    iget-object v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v3    # "ptr":I
    shr-int/lit8 v4, p1, 0xc

    or-int/lit16 v4, v4, 0xe0

    int-to-byte v4, v4

    aput-byte v4, v2, v1

    .line 235
    iget-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    add-int/lit8 v2, v3, 0x1

    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    shr-int/lit8 v4, p1, 0x6

    and-int/lit8 v4, v4, 0x3f

    or-int/2addr v4, v0

    int-to-byte v4, v4

    aput-byte v4, v1, v3

    .line 236
    iget-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    add-int/lit8 v3, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v3    # "ptr":I
    and-int/lit8 v4, p1, 0x3f

    or-int/2addr v0, v4

    int-to-byte v0, v0

    aput-byte v0, v1, v2

    move v2, v3

    goto :goto_1

    .line 238
    .end local v3    # "ptr":I
    .restart local v1    # "ptr":I
    :cond_6
    const v2, 0x10ffff

    if-le p1, v2, :cond_7

    .line 239
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/io/UTF8Writer;->throwIllegal(I)V

    .line 241
    :cond_7
    iget-object v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v3    # "ptr":I
    shr-int/lit8 v4, p1, 0x12

    or-int/lit16 v4, v4, 0xf0

    int-to-byte v4, v4

    aput-byte v4, v2, v1

    .line 242
    iget-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    add-int/lit8 v2, v3, 0x1

    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    shr-int/lit8 v4, p1, 0xc

    and-int/lit8 v4, v4, 0x3f

    or-int/2addr v4, v0

    int-to-byte v4, v4

    aput-byte v4, v1, v3

    .line 243
    iget-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    add-int/lit8 v3, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v3    # "ptr":I
    shr-int/lit8 v4, p1, 0x6

    and-int/lit8 v4, v4, 0x3f

    or-int/2addr v4, v0

    int-to-byte v4, v4

    aput-byte v4, v1, v2

    .line 244
    iget-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    add-int/lit8 v2, v3, 0x1

    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    and-int/lit8 v4, p1, 0x3f

    or-int/2addr v0, v4

    int-to-byte v0, v0

    aput-byte v0, v1, v3

    .line 246
    :goto_1
    iput v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 248
    .end local v2    # "ptr":I
    :goto_2
    return-void
.end method

.method public write(Ljava/lang/String;)V
    .locals 2
    .param p1, "str"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 253
    const/4 v0, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/io/UTF8Writer;->write(Ljava/lang/String;II)V

    .line 254
    return-void
.end method

.method public write(Ljava/lang/String;II)V
    .locals 9
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 259
    const/4 v0, 0x2

    if-ge p3, v0, :cond_1

    .line 260
    const/4 v0, 0x1

    if-ne p3, v0, :cond_0

    .line 261
    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/io/UTF8Writer;->write(I)V

    .line 263
    :cond_0
    return-void

    .line 267
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mSurrogate:I

    if-lez v0, :cond_2

    .line 268
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "off":I
    .local v0, "off":I
    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result p2

    .line 269
    .local p2, "second":C
    add-int/lit8 p3, p3, -0x1

    .line 270
    invoke-direct {p0, p2}, Lcom/fasterxml/aalto/io/UTF8Writer;->convertSurrogate(I)I

    move-result v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/io/UTF8Writer;->write(I)V

    move p2, v0

    .line 274
    .end local v0    # "off":I
    .local p2, "off":I
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 275
    .local v0, "outPtr":I
    iget-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    .line 276
    .local v1, "outBuf":[B
    iget v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBufferLast:I

    .line 279
    .local v2, "outBufLast":I
    add-int/2addr p3, p2

    .line 282
    :goto_0
    if-ge p2, p3, :cond_e

    .line 286
    if-lt v0, v2, :cond_3

    .line 287
    iget-object v3, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOut:Ljava/io/OutputStream;

    const/4 v4, 0x0

    invoke-virtual {v3, v1, v4, v0}, Ljava/io/OutputStream;->write([BII)V

    .line 288
    const/4 v0, 0x0

    .line 291
    :cond_3
    add-int/lit8 v3, p2, 0x1

    .end local p2    # "off":I
    .local v3, "off":I
    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result p2

    .line 293
    .local p2, "c":I
    const/16 v4, 0x80

    if-ge p2, v4, :cond_7

    .line 294
    add-int/lit8 v5, v0, 0x1

    .end local v0    # "outPtr":I
    .local v5, "outPtr":I
    int-to-byte v6, p2

    aput-byte v6, v1, v0

    .line 296
    sub-int v0, p3, v3

    .line 297
    .local v0, "maxInCount":I
    sub-int v6, v2, v5

    .line 299
    .local v6, "maxOutCount":I
    if-le v0, v6, :cond_4

    .line 300
    move v0, v6

    .line 302
    :cond_4
    add-int v7, v0, v3

    move v0, p2

    move p2, v3

    .line 305
    .end local v3    # "off":I
    .local v0, "c":I
    .local v7, "maxInCount":I
    .local p2, "off":I
    :goto_1
    if-lt p2, v7, :cond_5

    .line 306
    move v0, v5

    goto :goto_0

    .line 308
    :cond_5
    add-int/lit8 v3, p2, 0x1

    .end local p2    # "off":I
    .restart local v3    # "off":I
    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 309
    if-lt v0, v4, :cond_6

    .line 310
    move p2, v0

    move v0, v5

    goto :goto_2

    .line 312
    :cond_6
    add-int/lit8 p2, v5, 0x1

    .end local v5    # "outPtr":I
    .local p2, "outPtr":I
    int-to-byte v8, v0

    aput-byte v8, v1, v5

    move v5, p2

    move p2, v3

    goto :goto_1

    .line 317
    .end local v6    # "maxOutCount":I
    .end local v7    # "maxInCount":I
    .local v0, "outPtr":I
    .local p2, "c":I
    :cond_7
    :goto_2
    const/16 v5, 0x800

    if-ge p2, v5, :cond_8

    .line 318
    add-int/lit8 v5, v0, 0x1

    .end local v0    # "outPtr":I
    .restart local v5    # "outPtr":I
    shr-int/lit8 v6, p2, 0x6

    or-int/lit16 v6, v6, 0xc0

    int-to-byte v6, v6

    aput-byte v6, v1, v0

    .line 319
    add-int/lit8 v0, v5, 0x1

    .end local v5    # "outPtr":I
    .restart local v0    # "outPtr":I
    and-int/lit8 v6, p2, 0x3f

    or-int/2addr v4, v6

    int-to-byte v4, v4

    aput-byte v4, v1, v5

    move p2, v3

    goto :goto_3

    .line 322
    :cond_8
    const v5, 0xd800

    if-lt p2, v5, :cond_d

    const v5, 0xdfff

    if-le p2, v5, :cond_9

    goto :goto_4

    .line 329
    :cond_9
    const v5, 0xdbff

    if-le p2, v5, :cond_a

    .line 330
    iput v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 331
    invoke-direct {p0, p2}, Lcom/fasterxml/aalto/io/UTF8Writer;->throwIllegal(I)V

    .line 333
    :cond_a
    iput p2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mSurrogate:I

    .line 335
    if-lt v3, p3, :cond_b

    .line 336
    move p2, v3

    goto :goto_5

    .line 338
    :cond_b
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "off":I
    .local v5, "off":I
    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/io/UTF8Writer;->convertSurrogate(I)I

    move-result p2

    .line 339
    const v3, 0x10ffff

    if-le p2, v3, :cond_c

    .line 340
    iput v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 341
    invoke-direct {p0, p2}, Lcom/fasterxml/aalto/io/UTF8Writer;->throwIllegal(I)V

    .line 343
    :cond_c
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "outPtr":I
    .local v3, "outPtr":I
    shr-int/lit8 v6, p2, 0x12

    or-int/lit16 v6, v6, 0xf0

    int-to-byte v6, v6

    aput-byte v6, v1, v0

    .line 344
    add-int/lit8 v0, v3, 0x1

    .end local v3    # "outPtr":I
    .restart local v0    # "outPtr":I
    shr-int/lit8 v6, p2, 0xc

    and-int/lit8 v6, v6, 0x3f

    or-int/2addr v6, v4

    int-to-byte v6, v6

    aput-byte v6, v1, v3

    .line 345
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "outPtr":I
    .restart local v3    # "outPtr":I
    shr-int/lit8 v6, p2, 0x6

    and-int/lit8 v6, v6, 0x3f

    or-int/2addr v6, v4

    int-to-byte v6, v6

    aput-byte v6, v1, v0

    .line 346
    add-int/lit8 v0, v3, 0x1

    .end local v3    # "outPtr":I
    .restart local v0    # "outPtr":I
    and-int/lit8 v6, p2, 0x3f

    or-int/2addr v4, v6

    int-to-byte v4, v4

    aput-byte v4, v1, v3

    move p2, v5

    .line 348
    .end local v5    # "off":I
    .local p2, "off":I
    :goto_3
    goto/16 :goto_0

    .line 323
    .local v3, "off":I
    .local p2, "c":I
    :cond_d
    :goto_4
    add-int/lit8 v5, v0, 0x1

    .end local v0    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v6, p2, 0xc

    or-int/lit16 v6, v6, 0xe0

    int-to-byte v6, v6

    aput-byte v6, v1, v0

    .line 324
    add-int/lit8 v0, v5, 0x1

    .end local v5    # "outPtr":I
    .restart local v0    # "outPtr":I
    shr-int/lit8 v6, p2, 0x6

    and-int/lit8 v6, v6, 0x3f

    or-int/2addr v6, v4

    int-to-byte v6, v6

    aput-byte v6, v1, v5

    .line 325
    add-int/lit8 v5, v0, 0x1

    .end local v0    # "outPtr":I
    .restart local v5    # "outPtr":I
    and-int/lit8 v6, p2, 0x3f

    or-int/2addr v4, v6

    int-to-byte v4, v4

    aput-byte v4, v1, v0

    .line 326
    move p2, v3

    move v0, v5

    goto/16 :goto_0

    .line 349
    .end local v3    # "off":I
    .end local v5    # "outPtr":I
    .restart local v0    # "outPtr":I
    .local p2, "off":I
    :cond_e
    :goto_5
    iput v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 350
    return-void
.end method

.method public write([C)V
    .locals 2
    .param p1, "cbuf"    # [C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 105
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/io/UTF8Writer;->write([CII)V

    .line 106
    return-void
.end method

.method public write([CII)V
    .locals 9
    .param p1, "cbuf"    # [C
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 111
    const/4 v0, 0x2

    if-ge p3, v0, :cond_1

    .line 112
    const/4 v0, 0x1

    if-ne p3, v0, :cond_0

    .line 113
    aget-char v0, p1, p2

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/io/UTF8Writer;->write(I)V

    .line 115
    :cond_0
    return-void

    .line 119
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mSurrogate:I

    if-lez v0, :cond_2

    .line 120
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "off":I
    .local v0, "off":I
    aget-char p2, p1, p2

    .line 121
    .local p2, "second":C
    add-int/lit8 p3, p3, -0x1

    .line 122
    invoke-direct {p0, p2}, Lcom/fasterxml/aalto/io/UTF8Writer;->convertSurrogate(I)I

    move-result v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/io/UTF8Writer;->write(I)V

    move p2, v0

    .line 126
    .end local v0    # "off":I
    .local p2, "off":I
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 127
    .local v0, "outPtr":I
    iget-object v1, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBuffer:[B

    .line 128
    .local v1, "outBuf":[B
    iget v2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutBufferLast:I

    .line 131
    .local v2, "outBufLast":I
    add-int/2addr p3, p2

    .line 134
    :goto_0
    if-ge p2, p3, :cond_e

    .line 138
    if-lt v0, v2, :cond_3

    .line 139
    iget-object v3, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOut:Ljava/io/OutputStream;

    const/4 v4, 0x0

    invoke-virtual {v3, v1, v4, v0}, Ljava/io/OutputStream;->write([BII)V

    .line 140
    const/4 v0, 0x0

    .line 143
    :cond_3
    add-int/lit8 v3, p2, 0x1

    .end local p2    # "off":I
    .local v3, "off":I
    aget-char p2, p1, p2

    .line 145
    .local p2, "c":I
    const/16 v4, 0x80

    if-ge p2, v4, :cond_7

    .line 146
    add-int/lit8 v5, v0, 0x1

    .end local v0    # "outPtr":I
    .local v5, "outPtr":I
    int-to-byte v6, p2

    aput-byte v6, v1, v0

    .line 148
    sub-int v0, p3, v3

    .line 149
    .local v0, "maxInCount":I
    sub-int v6, v2, v5

    .line 151
    .local v6, "maxOutCount":I
    if-le v0, v6, :cond_4

    .line 152
    move v0, v6

    .line 154
    :cond_4
    add-int v7, v0, v3

    move v0, p2

    move p2, v3

    .line 157
    .end local v3    # "off":I
    .local v0, "c":I
    .local v7, "maxInCount":I
    .local p2, "off":I
    :goto_1
    if-lt p2, v7, :cond_5

    .line 158
    move v0, v5

    goto :goto_0

    .line 160
    :cond_5
    add-int/lit8 v3, p2, 0x1

    .end local p2    # "off":I
    .restart local v3    # "off":I
    aget-char v0, p1, p2

    .line 161
    if-lt v0, v4, :cond_6

    .line 162
    move p2, v0

    move v0, v5

    goto :goto_2

    .line 164
    :cond_6
    add-int/lit8 p2, v5, 0x1

    .end local v5    # "outPtr":I
    .local p2, "outPtr":I
    int-to-byte v8, v0

    aput-byte v8, v1, v5

    move v5, p2

    move p2, v3

    goto :goto_1

    .line 169
    .end local v6    # "maxOutCount":I
    .end local v7    # "maxInCount":I
    .local v0, "outPtr":I
    .local p2, "c":I
    :cond_7
    :goto_2
    const/16 v5, 0x800

    if-ge p2, v5, :cond_8

    .line 170
    add-int/lit8 v5, v0, 0x1

    .end local v0    # "outPtr":I
    .restart local v5    # "outPtr":I
    shr-int/lit8 v6, p2, 0x6

    or-int/lit16 v6, v6, 0xc0

    int-to-byte v6, v6

    aput-byte v6, v1, v0

    .line 171
    add-int/lit8 v0, v5, 0x1

    .end local v5    # "outPtr":I
    .restart local v0    # "outPtr":I
    and-int/lit8 v6, p2, 0x3f

    or-int/2addr v4, v6

    int-to-byte v4, v4

    aput-byte v4, v1, v5

    move p2, v3

    goto :goto_3

    .line 174
    :cond_8
    const v5, 0xd800

    if-lt p2, v5, :cond_d

    const v5, 0xdfff

    if-le p2, v5, :cond_9

    goto :goto_4

    .line 181
    :cond_9
    const v5, 0xdbff

    if-le p2, v5, :cond_a

    .line 182
    iput v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 183
    invoke-direct {p0, p2}, Lcom/fasterxml/aalto/io/UTF8Writer;->throwIllegal(I)V

    .line 185
    :cond_a
    iput p2, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mSurrogate:I

    .line 187
    if-lt v3, p3, :cond_b

    .line 188
    move p2, v3

    goto :goto_5

    .line 190
    :cond_b
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "off":I
    .local v5, "off":I
    aget-char v3, p1, v3

    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/io/UTF8Writer;->convertSurrogate(I)I

    move-result p2

    .line 191
    const v3, 0x10ffff

    if-le p2, v3, :cond_c

    .line 192
    iput v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 193
    invoke-direct {p0, p2}, Lcom/fasterxml/aalto/io/UTF8Writer;->throwIllegal(I)V

    .line 195
    :cond_c
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "outPtr":I
    .local v3, "outPtr":I
    shr-int/lit8 v6, p2, 0x12

    or-int/lit16 v6, v6, 0xf0

    int-to-byte v6, v6

    aput-byte v6, v1, v0

    .line 196
    add-int/lit8 v0, v3, 0x1

    .end local v3    # "outPtr":I
    .restart local v0    # "outPtr":I
    shr-int/lit8 v6, p2, 0xc

    and-int/lit8 v6, v6, 0x3f

    or-int/2addr v6, v4

    int-to-byte v6, v6

    aput-byte v6, v1, v3

    .line 197
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "outPtr":I
    .restart local v3    # "outPtr":I
    shr-int/lit8 v6, p2, 0x6

    and-int/lit8 v6, v6, 0x3f

    or-int/2addr v6, v4

    int-to-byte v6, v6

    aput-byte v6, v1, v0

    .line 198
    add-int/lit8 v0, v3, 0x1

    .end local v3    # "outPtr":I
    .restart local v0    # "outPtr":I
    and-int/lit8 v6, p2, 0x3f

    or-int/2addr v4, v6

    int-to-byte v4, v4

    aput-byte v4, v1, v3

    move p2, v5

    .line 200
    .end local v5    # "off":I
    .local p2, "off":I
    :goto_3
    goto/16 :goto_0

    .line 175
    .local v3, "off":I
    .local p2, "c":I
    :cond_d
    :goto_4
    add-int/lit8 v5, v0, 0x1

    .end local v0    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v6, p2, 0xc

    or-int/lit16 v6, v6, 0xe0

    int-to-byte v6, v6

    aput-byte v6, v1, v0

    .line 176
    add-int/lit8 v0, v5, 0x1

    .end local v5    # "outPtr":I
    .restart local v0    # "outPtr":I
    shr-int/lit8 v6, p2, 0x6

    and-int/lit8 v6, v6, 0x3f

    or-int/2addr v6, v4

    int-to-byte v6, v6

    aput-byte v6, v1, v5

    .line 177
    add-int/lit8 v5, v0, 0x1

    .end local v0    # "outPtr":I
    .restart local v5    # "outPtr":I
    and-int/lit8 v6, p2, 0x3f

    or-int/2addr v4, v6

    int-to-byte v4, v4

    aput-byte v4, v1, v0

    .line 178
    move p2, v3

    move v0, v5

    goto/16 :goto_0

    .line 201
    .end local v3    # "off":I
    .end local v5    # "outPtr":I
    .restart local v0    # "outPtr":I
    .local p2, "off":I
    :cond_e
    :goto_5
    iput v0, p0, Lcom/fasterxml/aalto/io/UTF8Writer;->mOutPtr:I

    .line 202
    return-void
.end method
