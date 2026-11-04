.class public Lorg/xerial/snappy/SnappyOutputStream;
.super Ljava/io/OutputStream;
.source "SnappyOutputStream.java"


# static fields
.field static final DEFAULT_BLOCK_SIZE:I = 0x8000

.field static final MIN_BLOCK_SIZE:I = 0x400


# instance fields
.field private final blockSize:I

.field private closed:Z

.field private headerWritten:Z

.field protected inputBuffer:[B

.field private final inputBufferAllocator:Lorg/xerial/snappy/buffer/BufferAllocator;

.field private inputCursor:I

.field protected final out:Ljava/io/OutputStream;

.field protected outputBuffer:[B

.field private final outputBufferAllocator:Lorg/xerial/snappy/buffer/BufferAllocator;

.field private outputCursor:I


# direct methods
.method public constructor <init>(Ljava/io/OutputStream;)V
    .locals 1

    .line 81
    const v0, 0x8000

    invoke-direct {p0, p1, v0}, Lorg/xerial/snappy/SnappyOutputStream;-><init>(Ljava/io/OutputStream;I)V

    .line 82
    return-void
.end method

.method public constructor <init>(Ljava/io/OutputStream;I)V
    .locals 1

    .line 91
    invoke-static {}, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->getBufferAllocatorFactory()Lorg/xerial/snappy/buffer/BufferAllocatorFactory;

    move-result-object v0

    invoke-direct {p0, p1, p2, v0}, Lorg/xerial/snappy/SnappyOutputStream;-><init>(Ljava/io/OutputStream;ILorg/xerial/snappy/buffer/BufferAllocatorFactory;)V

    .line 92
    return-void
.end method

.method public constructor <init>(Ljava/io/OutputStream;ILorg/xerial/snappy/buffer/BufferAllocatorFactory;)V
    .locals 1

    .line 95
    invoke-direct {p0}, Ljava/io/OutputStream;-><init>()V

    .line 74
    const/4 v0, 0x0

    iput v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    .line 75
    iput v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    .line 96
    iput-object p1, p0, Lorg/xerial/snappy/SnappyOutputStream;->out:Ljava/io/OutputStream;

    .line 97
    const/16 p1, 0x400

    invoke-static {p1, p2}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Lorg/xerial/snappy/SnappyOutputStream;->blockSize:I

    .line 98
    nop

    .line 99
    sget p1, Lorg/xerial/snappy/SnappyCodec;->HEADER_SIZE:I

    add-int/lit8 p1, p1, 0x4

    invoke-static {p2}, Lorg/xerial/snappy/Snappy;->maxCompressedLength(I)I

    move-result v0

    add-int/2addr p1, v0

    .line 101
    invoke-interface {p3, p2}, Lorg/xerial/snappy/buffer/BufferAllocatorFactory;->getBufferAllocator(I)Lorg/xerial/snappy/buffer/BufferAllocator;

    move-result-object v0

    iput-object v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBufferAllocator:Lorg/xerial/snappy/buffer/BufferAllocator;

    .line 102
    invoke-interface {p3, p1}, Lorg/xerial/snappy/buffer/BufferAllocatorFactory;->getBufferAllocator(I)Lorg/xerial/snappy/buffer/BufferAllocator;

    move-result-object p3

    iput-object p3, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBufferAllocator:Lorg/xerial/snappy/buffer/BufferAllocator;

    .line 104
    iget-object p3, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBufferAllocator:Lorg/xerial/snappy/buffer/BufferAllocator;

    invoke-interface {p3, p2}, Lorg/xerial/snappy/buffer/BufferAllocator;->allocate(I)[B

    move-result-object p2

    iput-object p2, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBuffer:[B

    .line 105
    iget-object p2, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBufferAllocator:Lorg/xerial/snappy/buffer/BufferAllocator;

    invoke-interface {p2, p1}, Lorg/xerial/snappy/buffer/BufferAllocator;->allocate(I)[B

    move-result-object p1

    iput-object p1, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBuffer:[B

    .line 106
    return-void
.end method

.method private hasSufficientOutputBufferFor(I)Z
    .locals 2

    .line 267
    invoke-static {p1}, Lorg/xerial/snappy/Snappy;->maxCompressedLength(I)I

    move-result p1

    .line 268
    iget-object v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBuffer:[B

    array-length v0, v0

    iget v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    sub-int/2addr v0, v1

    add-int/lit8 v0, v0, -0x4

    if-ge p1, v0, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method static readInt([BI)I
    .locals 3

    .line 349
    aget-byte v0, p0, p1

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x18

    .line 350
    add-int/lit8 v1, p1, 0x1

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x10

    .line 351
    add-int/lit8 v2, p1, 0x2

    aget-byte v2, p0, v2

    and-int/lit16 v2, v2, 0xff

    shl-int/lit8 v2, v2, 0x8

    .line 352
    add-int/lit8 p1, p1, 0x3

    aget-byte p0, p0, p1

    and-int/lit16 p0, p0, 0xff

    .line 353
    or-int p1, v0, v1

    or-int/2addr p1, v2

    or-int/2addr p0, p1

    return p0
.end method

.method static writeInt([BII)V
    .locals 2

    .line 341
    shr-int/lit8 v0, p2, 0x18

    and-int/lit16 v0, v0, 0xff

    int-to-byte v0, v0

    aput-byte v0, p0, p1

    .line 342
    add-int/lit8 v0, p1, 0x1

    shr-int/lit8 v1, p2, 0x10

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 343
    add-int/lit8 v0, p1, 0x2

    shr-int/lit8 v1, p2, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, p0, v0

    .line 344
    add-int/lit8 p1, p1, 0x3

    shr-int/lit8 p2, p2, 0x0

    and-int/lit16 p2, p2, 0xff

    int-to-byte p2, p2

    aput-byte p2, p0, p1

    .line 345
    return-void
.end method


# virtual methods
.method public close()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 415
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->closed:Z

    if-eqz v0, :cond_0

    .line 416
    return-void

    .line 419
    :cond_0
    const/4 v0, 0x1

    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyOutputStream;->flush()V

    .line 420
    iget-object v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->out:Ljava/io/OutputStream;

    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 423
    iput-boolean v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->closed:Z

    .line 424
    iget-object v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBufferAllocator:Lorg/xerial/snappy/buffer/BufferAllocator;

    iget-object v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBuffer:[B

    invoke-interface {v0, v2}, Lorg/xerial/snappy/buffer/BufferAllocator;->release([B)V

    .line 425
    iget-object v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBufferAllocator:Lorg/xerial/snappy/buffer/BufferAllocator;

    iget-object v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBuffer:[B

    invoke-interface {v0, v2}, Lorg/xerial/snappy/buffer/BufferAllocator;->release([B)V

    .line 426
    iput-object v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBuffer:[B

    .line 427
    iput-object v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBuffer:[B

    .line 428
    nop

    .line 429
    return-void

    .line 423
    :catchall_0
    move-exception v2

    iput-boolean v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->closed:Z

    .line 424
    iget-object v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBufferAllocator:Lorg/xerial/snappy/buffer/BufferAllocator;

    iget-object v3, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBuffer:[B

    invoke-interface {v0, v3}, Lorg/xerial/snappy/buffer/BufferAllocator;->release([B)V

    .line 425
    iget-object v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBufferAllocator:Lorg/xerial/snappy/buffer/BufferAllocator;

    iget-object v3, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBuffer:[B

    invoke-interface {v0, v3}, Lorg/xerial/snappy/buffer/BufferAllocator;->release([B)V

    .line 426
    iput-object v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBuffer:[B

    .line 427
    iput-object v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBuffer:[B

    .line 428
    throw v2
.end method

.method protected compressInput()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 368
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->headerWritten:Z

    if-nez v0, :cond_0

    .line 369
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyOutputStream;->writeHeader()I

    move-result v0

    iput v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    .line 370
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->headerWritten:Z

    .line 372
    :cond_0
    iget v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    if-gtz v0, :cond_1

    .line 373
    return-void

    .line 376
    :cond_1
    iget v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    invoke-direct {p0, v0}, Lorg/xerial/snappy/SnappyOutputStream;->hasSufficientOutputBufferFor(I)Z

    move-result v0

    if-nez v0, :cond_2

    .line 377
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyOutputStream;->dumpOutput()V

    .line 379
    :cond_2
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyOutputStream;->writeBlockPreemble()V

    .line 380
    iget-object v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBuffer:[B

    iget v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    iget-object v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBuffer:[B

    iget v3, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    add-int/lit8 v3, v3, 0x4

    const/4 v4, 0x0

    invoke-static {v0, v4, v1, v2, v3}, Lorg/xerial/snappy/Snappy;->compress([BII[BI)I

    move-result v0

    .line 382
    iget-object v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBuffer:[B

    iget v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    invoke-static {v1, v2, v0}, Lorg/xerial/snappy/SnappyOutputStream;->writeInt([BII)V

    .line 383
    iget v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    add-int/lit8 v0, v0, 0x4

    add-int/2addr v1, v0

    iput v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    .line 384
    iput v4, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    .line 385
    return-void
.end method

.method protected dumpOutput()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 359
    iget v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    if-lez v0, :cond_0

    .line 360
    iget-object v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->out:Ljava/io/OutputStream;

    iget-object v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBuffer:[B

    iget v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/OutputStream;->write([BII)V

    .line 361
    iput v3, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    .line 363
    :cond_0
    return-void
.end method

.method public flush()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 331
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->closed:Z

    if-nez v0, :cond_0

    .line 334
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyOutputStream;->compressInput()V

    .line 335
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyOutputStream;->dumpOutput()V

    .line 336
    iget-object v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->out:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V

    .line 337
    return-void

    .line 332
    :cond_0
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Stream is closed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public rawWrite(Ljava/lang/Object;II)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 282
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->closed:Z

    if-nez v0, :cond_3

    .line 285
    const/4 v0, 0x0

    .line 286
    :goto_0
    if-ge v0, p3, :cond_2

    .line 287
    sub-int v1, p3, v0

    iget v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->blockSize:I

    iget v3, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    sub-int/2addr v2, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 289
    if-lez v1, :cond_0

    .line 290
    add-int v2, p2, v0

    iget-object v3, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBuffer:[B

    iget v4, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    invoke-static {p1, v2, v1, v3, v4}, Lorg/xerial/snappy/Snappy;->arrayCopy(Ljava/lang/Object;IILjava/lang/Object;I)V

    .line 291
    iget v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    add-int/2addr v2, v1

    iput v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    .line 293
    :cond_0
    iget v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    iget v3, p0, Lorg/xerial/snappy/SnappyOutputStream;->blockSize:I

    if-ge v2, v3, :cond_1

    .line 294
    return-void

    .line 297
    :cond_1
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyOutputStream;->compressInput()V

    .line 298
    add-int/2addr v0, v1

    .line 299
    goto :goto_0

    .line 300
    :cond_2
    return-void

    .line 283
    :cond_3
    new-instance p1, Ljava/io/IOException;

    const-string p2, "Stream is closed"

    invoke-direct {p1, p2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public write(I)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 315
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->closed:Z

    if-nez v0, :cond_1

    .line 318
    iget v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    iget-object v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBuffer:[B

    array-length v1, v1

    if-lt v0, v1, :cond_0

    .line 319
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyOutputStream;->compressInput()V

    .line 321
    :cond_0
    iget-object v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBuffer:[B

    iget v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    int-to-byte p1, p1

    aput-byte p1, v0, v1

    .line 322
    return-void

    .line 316
    :cond_1
    new-instance p1, Ljava/io/IOException;

    const-string v0, "Stream is closed"

    invoke-direct {p1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public write([BII)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 115
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->closed:Z

    if-nez v0, :cond_3

    .line 118
    const/4 v0, 0x0

    .line 119
    :goto_0
    if-ge v0, p3, :cond_2

    .line 120
    sub-int v1, p3, v0

    iget v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->blockSize:I

    iget v3, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    sub-int/2addr v2, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    .line 122
    if-lez v1, :cond_0

    .line 123
    add-int v2, p2, v0

    iget-object v3, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputBuffer:[B

    iget v4, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    invoke-static {p1, v2, v3, v4, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 124
    iget v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    add-int/2addr v2, v1

    iput v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    .line 126
    :cond_0
    iget v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    iget v3, p0, Lorg/xerial/snappy/SnappyOutputStream;->blockSize:I

    if-ge v2, v3, :cond_1

    .line 127
    return-void

    .line 130
    :cond_1
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyOutputStream;->compressInput()V

    .line 131
    add-int/2addr v0, v1

    .line 132
    goto :goto_0

    .line 133
    :cond_2
    return-void

    .line 116
    :cond_3
    new-instance p1, Ljava/io/IOException;

    const-string p2, "Stream is closed"

    invoke-direct {p1, p2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public write([D)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 226
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lorg/xerial/snappy/SnappyOutputStream;->write([DII)V

    .line 227
    return-void
.end method

.method public write([DII)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 160
    mul-int/lit8 p2, p2, 0x8

    mul-int/lit8 p3, p3, 0x8

    invoke-virtual {p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyOutputStream;->rawWrite(Ljava/lang/Object;II)V

    .line 161
    return-void
.end method

.method public write([F)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 238
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lorg/xerial/snappy/SnappyOutputStream;->write([FII)V

    .line 239
    return-void
.end method

.method public write([FII)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 174
    mul-int/lit8 p2, p2, 0x4

    mul-int/lit8 p3, p3, 0x4

    invoke-virtual {p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyOutputStream;->rawWrite(Ljava/lang/Object;II)V

    .line 175
    return-void
.end method

.method public write([I)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 250
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lorg/xerial/snappy/SnappyOutputStream;->write([III)V

    .line 251
    return-void
.end method

.method public write([III)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 188
    mul-int/lit8 p2, p2, 0x4

    mul-int/lit8 p3, p3, 0x4

    invoke-virtual {p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyOutputStream;->rawWrite(Ljava/lang/Object;II)V

    .line 189
    return-void
.end method

.method public write([J)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 214
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lorg/xerial/snappy/SnappyOutputStream;->write([JII)V

    .line 215
    return-void
.end method

.method public write([JII)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 146
    mul-int/lit8 p2, p2, 0x8

    mul-int/lit8 p3, p3, 0x8

    invoke-virtual {p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyOutputStream;->rawWrite(Ljava/lang/Object;II)V

    .line 147
    return-void
.end method

.method public write([S)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 262
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lorg/xerial/snappy/SnappyOutputStream;->write([SII)V

    .line 263
    return-void
.end method

.method public write([SII)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 202
    mul-int/lit8 p2, p2, 0x2

    mul-int/lit8 p3, p3, 0x2

    invoke-virtual {p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyOutputStream;->rawWrite(Ljava/lang/Object;II)V

    .line 203
    return-void
.end method

.method protected writeBlockPreemble()V
    .locals 0

    .line 398
    return-void
.end method

.method protected writeCurrentDataSize()V
    .locals 3

    .line 401
    iget-object v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBuffer:[B

    iget v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    iget v2, p0, Lorg/xerial/snappy/SnappyOutputStream;->inputCursor:I

    invoke-static {v0, v1, v2}, Lorg/xerial/snappy/SnappyOutputStream;->writeInt([BII)V

    .line 402
    iget v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    add-int/lit8 v0, v0, 0x4

    iput v0, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputCursor:I

    .line 403
    return-void
.end method

.method protected writeHeader()I
    .locals 3

    .line 388
    sget-object v0, Lorg/xerial/snappy/SnappyCodec;->currentHeader:Lorg/xerial/snappy/SnappyCodec;

    iget-object v1, p0, Lorg/xerial/snappy/SnappyOutputStream;->outputBuffer:[B

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lorg/xerial/snappy/SnappyCodec;->writeHeader([BI)I

    move-result v0

    return v0
.end method
