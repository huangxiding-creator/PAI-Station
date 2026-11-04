.class public Lorg/xerial/snappy/SnappyInputStream;
.super Ljava/io/InputStream;
.source "SnappyInputStream.java"


# instance fields
.field private compressed:[B

.field private finishedReading:Z

.field private header:[B

.field protected final in:Ljava/io/InputStream;

.field private uncompressed:[B

.field private uncompressedCursor:I

.field private uncompressedLimit:I


# direct methods
.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 57
    invoke-direct {p0}, Ljava/io/InputStream;-><init>()V

    .line 39
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/xerial/snappy/SnappyInputStream;->finishedReading:Z

    .line 44
    iput v0, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    .line 45
    iput v0, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    .line 47
    invoke-static {}, Lorg/xerial/snappy/SnappyCodec;->headerSize()I

    move-result v0

    new-array v0, v0, [B

    iput-object v0, p0, Lorg/xerial/snappy/SnappyInputStream;->header:[B

    .line 58
    iput-object p1, p0, Lorg/xerial/snappy/SnappyInputStream;->in:Ljava/io/InputStream;

    .line 59
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyInputStream;->readHeader()V

    .line 60
    return-void
.end method

.method private static isValidHeader([B)Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 107
    new-instance v0, Ljava/io/ByteArrayInputStream;

    invoke-direct {v0, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-static {v0}, Lorg/xerial/snappy/SnappyCodec;->readHeader(Ljava/io/InputStream;)Lorg/xerial/snappy/SnappyCodec;

    move-result-object p0

    .line 108
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyCodec;->isValidMagicHeader()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 110
    iget v0, p0, Lorg/xerial/snappy/SnappyCodec;->version:I

    const/4 v1, 0x1

    if-lt v0, v1, :cond_0

    .line 115
    return v1

    .line 111
    :cond_0
    new-instance v0, Lorg/xerial/snappy/SnappyIOException;

    sget-object v2, Lorg/xerial/snappy/SnappyErrorCode;->INCOMPATIBLE_VERSION:Lorg/xerial/snappy/SnappyErrorCode;

    iget p0, p0, Lorg/xerial/snappy/SnappyCodec;->version:I

    .line 113
    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {p0, v1}, [Ljava/lang/Object;

    move-result-object p0

    .line 111
    const-string v1, "Compressed with an incompatible codec version %d. At least version %d is required"

    invoke-static {v1, p0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, v2, p0}, Lorg/xerial/snappy/SnappyIOException;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw v0

    .line 118
    :cond_1
    const/4 p0, 0x0

    return p0
.end method

.method private readNext([BII)I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 376
    const/4 v0, 0x0

    .line 377
    :goto_0
    if-ge v0, p3, :cond_1

    .line 378
    iget-object v1, p0, Lorg/xerial/snappy/SnappyInputStream;->in:Ljava/io/InputStream;

    add-int v2, v0, p2

    sub-int v3, p3, v0

    invoke-virtual {v1, p1, v2, v3}, Ljava/io/InputStream;->read([BII)I

    move-result v1

    .line 379
    const/4 v2, -0x1

    if-ne v1, v2, :cond_0

    .line 380
    const/4 p1, 0x1

    iput-boolean p1, p0, Lorg/xerial/snappy/SnappyInputStream;->finishedReading:Z

    .line 381
    return v0

    .line 383
    :cond_0
    add-int/2addr v0, v1

    .line 384
    goto :goto_0

    .line 385
    :cond_1
    return v0
.end method


# virtual methods
.method public available()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 482
    iget v0, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    iget v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    if-ge v0, v1, :cond_0

    .line 483
    iget v0, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    iget v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    sub-int/2addr v0, v1

    return v0

    .line 486
    :cond_0
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyInputStream;->hasNextChunk()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 487
    iget v0, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    iget v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    sub-int/2addr v0, v1

    return v0

    .line 490
    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 72
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    .line 73
    iput-object v0, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressed:[B

    .line 74
    iget-object v0, p0, Lorg/xerial/snappy/SnappyInputStream;->in:Ljava/io/InputStream;

    if-eqz v0, :cond_0

    .line 75
    iget-object v0, p0, Lorg/xerial/snappy/SnappyInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 77
    :cond_0
    return-void
.end method

.method protected hasNextChunk()Z
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 391
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyInputStream;->finishedReading:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 392
    return v1

    .line 395
    :cond_0
    iput v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    .line 396
    iput v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    .line 398
    iget-object v0, p0, Lorg/xerial/snappy/SnappyInputStream;->header:[B

    const/4 v2, 0x4

    invoke-direct {p0, v0, v1, v2}, Lorg/xerial/snappy/SnappyInputStream;->readNext([BII)I

    move-result v0

    .line 399
    if-ge v0, v2, :cond_1

    .line 400
    return v1

    .line 403
    :cond_1
    iget-object v0, p0, Lorg/xerial/snappy/SnappyInputStream;->header:[B

    invoke-static {v0, v1}, Lorg/xerial/snappy/SnappyOutputStream;->readInt([BI)I

    move-result v0

    .line 404
    sget v3, Lorg/xerial/snappy/SnappyCodec;->MAGIC_HEADER_HEAD:I

    if-ne v0, v3, :cond_4

    .line 406
    invoke-static {}, Lorg/xerial/snappy/SnappyCodec;->headerSize()I

    move-result v0

    sub-int/2addr v0, v2

    .line 407
    iget-object v3, p0, Lorg/xerial/snappy/SnappyInputStream;->header:[B

    invoke-direct {p0, v3, v2, v0}, Lorg/xerial/snappy/SnappyInputStream;->readNext([BII)I

    move-result v2

    .line 408
    if-lt v2, v0, :cond_3

    .line 412
    iget-object v0, p0, Lorg/xerial/snappy/SnappyInputStream;->header:[B

    invoke-static {v0}, Lorg/xerial/snappy/SnappyInputStream;->isValidHeader([B)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 413
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyInputStream;->hasNextChunk()Z

    move-result v0

    return v0

    .line 416
    :cond_2
    return v1

    .line 409
    :cond_3
    new-instance v0, Lorg/xerial/snappy/SnappyIOException;

    sget-object v2, Lorg/xerial/snappy/SnappyErrorCode;->FAILED_TO_UNCOMPRESS:Lorg/xerial/snappy/SnappyErrorCode;

    const-string v3, "Insufficient header size in a concatenated block"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v3, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v2, v1}, Lorg/xerial/snappy/SnappyIOException;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw v0

    .line 421
    :cond_4
    iget-object v2, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    if-eqz v2, :cond_5

    iget-object v2, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    array-length v2, v2

    if-le v0, v2, :cond_6

    .line 422
    :cond_5
    new-array v2, v0, [B

    iput-object v2, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    .line 424
    :cond_6
    move v2, v1

    .line 425
    :goto_0
    if-ge v2, v0, :cond_8

    .line 426
    iget-object v3, p0, Lorg/xerial/snappy/SnappyInputStream;->in:Ljava/io/InputStream;

    iget-object v4, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    sub-int v5, v0, v2

    invoke-virtual {v3, v4, v2, v5}, Ljava/io/InputStream;->read([BII)I

    move-result v3

    .line 427
    const/4 v4, -0x1

    if-ne v3, v4, :cond_7

    .line 428
    goto :goto_1

    .line 430
    :cond_7
    add-int/2addr v2, v3

    .line 431
    goto :goto_0

    .line 432
    :cond_8
    :goto_1
    if-lt v2, v0, :cond_c

    .line 435
    iget-object v2, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    invoke-static {v2, v1, v0}, Lorg/xerial/snappy/Snappy;->uncompressedLength([BII)I

    move-result v2

    .line 436
    iget-object v3, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressed:[B

    if-eqz v3, :cond_9

    iget-object v3, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressed:[B

    array-length v3, v3

    if-le v2, v3, :cond_a

    .line 437
    :cond_9
    new-array v3, v2, [B

    iput-object v3, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressed:[B

    .line 439
    :cond_a
    iget-object v3, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    iget-object v4, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressed:[B

    invoke-static {v3, v1, v0, v4, v1}, Lorg/xerial/snappy/Snappy;->uncompress([BII[BI)I

    move-result v0

    .line 440
    if-ne v2, v0, :cond_b

    .line 443
    iput v0, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    .line 445
    const/4 v0, 0x1

    return v0

    .line 441
    :cond_b
    new-instance v1, Lorg/xerial/snappy/SnappyIOException;

    sget-object v3, Lorg/xerial/snappy/SnappyErrorCode;->INVALID_CHUNK_SIZE:Lorg/xerial/snappy/SnappyErrorCode;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    filled-new-array {v2, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v2, "expected %,d bytes, but decompressed chunk has %,d bytes"

    invoke-static {v2, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v3, v0}, Lorg/xerial/snappy/SnappyIOException;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw v1

    .line 433
    :cond_c
    new-instance v0, Ljava/io/IOException;

    const-string v1, "failed to read chunk"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public rawRead(Ljava/lang/Object;II)I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 195
    const/4 v0, 0x0

    .line 196
    :goto_0
    if-ge v0, p3, :cond_3

    .line 198
    iget v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    iget v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    if-lt v1, v2, :cond_2

    .line 199
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyInputStream;->hasNextChunk()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 200
    goto :goto_0

    .line 203
    :cond_0
    if-nez v0, :cond_1

    const/4 v0, -0x1

    :cond_1
    return v0

    .line 206
    :cond_2
    iget v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    iget v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    sub-int/2addr v1, v2

    sub-int v2, p3, v0

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 207
    iget-object v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressed:[B

    iget v3, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    add-int v4, p2, v0

    invoke-static {v2, v3, v1, p1, v4}, Lorg/xerial/snappy/Snappy;->arrayCopy(Ljava/lang/Object;IILjava/lang/Object;I)V

    .line 208
    add-int/2addr v0, v1

    .line 209
    iget v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    add-int/2addr v2, v1

    iput v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    .line 210
    goto :goto_0

    .line 212
    :cond_3
    return v0
.end method

.method public read()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 462
    iget v0, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    iget v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    if-ge v0, v1, :cond_0

    .line 463
    iget-object v0, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressed:[B

    iget v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    aget-byte v0, v0, v1

    and-int/lit16 v0, v0, 0xff

    return v0

    .line 466
    :cond_0
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyInputStream;->hasNextChunk()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 467
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyInputStream;->read()I

    move-result v0

    return v0

    .line 470
    :cond_1
    const/4 v0, -0x1

    return v0
.end method

.method public read([BII)I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 163
    const/4 v0, 0x0

    .line 164
    :goto_0
    if-ge v0, p3, :cond_3

    .line 166
    iget v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    iget v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    if-lt v1, v2, :cond_2

    .line 167
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyInputStream;->hasNextChunk()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 168
    goto :goto_0

    .line 171
    :cond_0
    if-nez v0, :cond_1

    const/4 v0, -0x1

    :cond_1
    return v0

    .line 174
    :cond_2
    iget v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    iget v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    sub-int/2addr v1, v2

    sub-int v2, p3, v0

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 175
    iget-object v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressed:[B

    iget v3, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    add-int v4, p2, v0

    invoke-static {v2, v3, p1, v4, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 176
    add-int/2addr v0, v1

    .line 177
    iget v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    add-int/2addr v2, v1

    iput v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    .line 178
    goto :goto_0

    .line 180
    :cond_3
    return v0
.end method

.method public read([D)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 272
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lorg/xerial/snappy/SnappyInputStream;->read([DII)I

    move-result p1

    return p1
.end method

.method public read([DII)I
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 258
    mul-int/lit8 p2, p2, 0x8

    mul-int/lit8 p3, p3, 0x8

    invoke-virtual {p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyInputStream;->rawRead(Ljava/lang/Object;II)I

    move-result p1

    return p1
.end method

.method public read([F)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 332
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lorg/xerial/snappy/SnappyInputStream;->read([FII)I

    move-result p1

    return p1
.end method

.method public read([FII)I
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 318
    mul-int/lit8 p2, p2, 0x4

    mul-int/lit8 p3, p3, 0x4

    invoke-virtual {p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyInputStream;->rawRead(Ljava/lang/Object;II)I

    move-result p1

    return p1
.end method

.method public read([I)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 286
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lorg/xerial/snappy/SnappyInputStream;->read([III)I

    move-result p1

    return p1
.end method

.method public read([III)I
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 302
    mul-int/lit8 p2, p2, 0x4

    mul-int/lit8 p3, p3, 0x4

    invoke-virtual {p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyInputStream;->rawRead(Ljava/lang/Object;II)I

    move-result p1

    return p1
.end method

.method public read([J)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 242
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lorg/xerial/snappy/SnappyInputStream;->read([JII)I

    move-result p1

    return p1
.end method

.method public read([JII)I
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 228
    mul-int/lit8 p2, p2, 0x8

    mul-int/lit8 p3, p3, 0x8

    invoke-virtual {p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyInputStream;->rawRead(Ljava/lang/Object;II)I

    move-result p1

    return p1
.end method

.method public read([S)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 362
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lorg/xerial/snappy/SnappyInputStream;->read([SII)I

    move-result p1

    return p1
.end method

.method public read([SII)I
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 348
    mul-int/lit8 p2, p2, 0x2

    mul-int/lit8 p3, p3, 0x2

    invoke-virtual {p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyInputStream;->rawRead(Ljava/lang/Object;II)I

    move-result p1

    return p1
.end method

.method protected readFully([BI)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 125
    const/4 v0, 0x1

    if-nez p2, :cond_0

    .line 126
    iput-boolean v0, p0, Lorg/xerial/snappy/SnappyInputStream;->finishedReading:Z

    .line 127
    return-void

    .line 130
    :cond_0
    const/16 v1, 0x2000

    invoke-static {v1, p2}, Ljava/lang/Math;->max(II)I

    move-result v1

    new-array v1, v1, [B

    iput-object v1, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    .line 131
    iget-object v1, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    const/4 v2, 0x0

    invoke-static {p1, v2, v1, v2, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 132
    nop

    .line 133
    nop

    :cond_1
    :goto_0
    iget-object p1, p0, Lorg/xerial/snappy/SnappyInputStream;->in:Ljava/io/InputStream;

    iget-object v1, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    iget-object v3, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    array-length v3, v3

    sub-int/2addr v3, p2

    invoke-virtual {p1, v1, p2, v3}, Ljava/io/InputStream;->read([BII)I

    move-result p1

    const/4 v1, -0x1

    if-eq p1, v1, :cond_2

    .line 134
    add-int/2addr p2, p1

    .line 135
    iget-object p1, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    array-length p1, p1

    if-lt p2, p1, :cond_1

    .line 136
    iget-object p1, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    array-length p1, p1

    mul-int/lit8 p1, p1, 0x2

    new-array p1, p1, [B

    .line 137
    iget-object v1, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    iget-object v3, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    array-length v3, v3

    invoke-static {v1, v2, p1, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 138
    iput-object p1, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    .line 139
    goto :goto_0

    .line 142
    :cond_2
    iput-boolean v0, p0, Lorg/xerial/snappy/SnappyInputStream;->finishedReading:Z

    .line 145
    iget-object p1, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    invoke-static {p1, v2, p2}, Lorg/xerial/snappy/Snappy;->uncompressedLength([BII)I

    move-result p1

    .line 146
    new-array v0, p1, [B

    iput-object v0, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressed:[B

    .line 147
    iget-object v0, p0, Lorg/xerial/snappy/SnappyInputStream;->compressed:[B

    iget-object v1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressed:[B

    invoke-static {v0, v2, p2, v1, v2}, Lorg/xerial/snappy/Snappy;->uncompress([BII[BI)I

    .line 148
    iput v2, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedCursor:I

    .line 149
    iput p1, p0, Lorg/xerial/snappy/SnappyInputStream;->uncompressedLimit:I

    .line 150
    return-void
.end method

.method protected readHeader()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 82
    const/4 v0, 0x0

    .line 83
    :goto_0
    iget-object v1, p0, Lorg/xerial/snappy/SnappyInputStream;->header:[B

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 84
    iget-object v1, p0, Lorg/xerial/snappy/SnappyInputStream;->in:Ljava/io/InputStream;

    iget-object v2, p0, Lorg/xerial/snappy/SnappyInputStream;->header:[B

    iget-object v3, p0, Lorg/xerial/snappy/SnappyInputStream;->header:[B

    array-length v3, v3

    sub-int/2addr v3, v0

    invoke-virtual {v1, v2, v0, v3}, Ljava/io/InputStream;->read([BII)I

    move-result v1

    .line 85
    const/4 v2, -0x1

    if-ne v1, v2, :cond_0

    .line 86
    goto :goto_1

    .line 88
    :cond_0
    add-int/2addr v0, v1

    .line 89
    goto :goto_0

    .line 92
    :cond_1
    :goto_1
    if-eqz v0, :cond_4

    .line 96
    iget-object v1, p0, Lorg/xerial/snappy/SnappyInputStream;->header:[B

    array-length v1, v1

    if-lt v0, v1, :cond_3

    iget-object v1, p0, Lorg/xerial/snappy/SnappyInputStream;->header:[B

    invoke-static {v1}, Lorg/xerial/snappy/SnappyCodec;->hasMagicHeaderPrefix([B)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_2

    .line 102
    :cond_2
    return-void

    .line 99
    :cond_3
    :goto_2
    iget-object v1, p0, Lorg/xerial/snappy/SnappyInputStream;->header:[B

    invoke-virtual {p0, v1, v0}, Lorg/xerial/snappy/SnappyInputStream;->readFully([BI)V

    .line 100
    return-void

    .line 94
    :cond_4
    new-instance v0, Lorg/xerial/snappy/SnappyIOException;

    sget-object v1, Lorg/xerial/snappy/SnappyErrorCode;->EMPTY_INPUT:Lorg/xerial/snappy/SnappyErrorCode;

    const-string v2, "Cannot decompress empty stream"

    invoke-direct {v0, v1, v2}, Lorg/xerial/snappy/SnappyIOException;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw v0
.end method
