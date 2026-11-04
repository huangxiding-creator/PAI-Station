.class public final Lorg/xerial/snappy/SnappyFramedOutputStream;
.super Ljava/io/OutputStream;
.source "SnappyFramedOutputStream.java"

# interfaces
.implements Ljava/nio/channels/WritableByteChannel;


# static fields
.field static final synthetic $assertionsDisabled:Z = false

.field public static final DEFAULT_BLOCK_SIZE:I = 0x10000

.field public static final DEFAULT_MIN_COMPRESSION_RATIO:D = 0.85

.field public static final MAX_BLOCK_SIZE:I = 0x10000


# instance fields
.field private final blockSize:I

.field private final buffer:Ljava/nio/ByteBuffer;

.field private final bufferPool:Lorg/xerial/snappy/pool/BufferPool;

.field private closed:Z

.field private final directInputBuffer:Ljava/nio/ByteBuffer;

.field private final headerBuffer:Ljava/nio/ByteBuffer;

.field private final minCompressionRatio:D

.field private final out:Ljava/nio/channels/WritableByteChannel;

.field private final outputBuffer:Ljava/nio/ByteBuffer;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    .line 33
    return-void
.end method

.method public constructor <init>(Ljava/io/OutputStream;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 90
    const-wide v3, 0x3feb333333333333L    # 0.85

    invoke-static {}, Lorg/xerial/snappy/pool/DefaultPoolFactory;->getDefaultPool()Lorg/xerial/snappy/pool/BufferPool;

    move-result-object v5

    const/high16 v2, 0x10000

    move-object v0, p0

    move-object v1, p1

    invoke-direct/range {v0 .. v5}, Lorg/xerial/snappy/SnappyFramedOutputStream;-><init>(Ljava/io/OutputStream;IDLorg/xerial/snappy/pool/BufferPool;)V

    .line 91
    return-void
.end method

.method public constructor <init>(Ljava/io/OutputStream;ID)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 127
    invoke-static {p1}, Ljava/nio/channels/Channels;->newChannel(Ljava/io/OutputStream;)Ljava/nio/channels/WritableByteChannel;

    move-result-object v1

    invoke-static {}, Lorg/xerial/snappy/pool/DefaultPoolFactory;->getDefaultPool()Lorg/xerial/snappy/pool/BufferPool;

    move-result-object v5

    move-object v0, p0

    move v2, p2

    move-wide v3, p3

    invoke-direct/range {v0 .. v5}, Lorg/xerial/snappy/SnappyFramedOutputStream;-><init>(Ljava/nio/channels/WritableByteChannel;IDLorg/xerial/snappy/pool/BufferPool;)V

    .line 128
    return-void
.end method

.method public constructor <init>(Ljava/io/OutputStream;IDLorg/xerial/snappy/pool/BufferPool;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 147
    invoke-static {p1}, Ljava/nio/channels/Channels;->newChannel(Ljava/io/OutputStream;)Ljava/nio/channels/WritableByteChannel;

    move-result-object v1

    move-object v0, p0

    move v2, p2

    move-wide v3, p3

    move-object v5, p5

    invoke-direct/range {v0 .. v5}, Lorg/xerial/snappy/SnappyFramedOutputStream;-><init>(Ljava/nio/channels/WritableByteChannel;IDLorg/xerial/snappy/pool/BufferPool;)V

    .line 148
    return-void
.end method

.method public constructor <init>(Ljava/io/OutputStream;Lorg/xerial/snappy/pool/BufferPool;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 105
    const/high16 v2, 0x10000

    const-wide v3, 0x3feb333333333333L    # 0.85

    move-object v0, p0

    move-object v1, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lorg/xerial/snappy/SnappyFramedOutputStream;-><init>(Ljava/io/OutputStream;IDLorg/xerial/snappy/pool/BufferPool;)V

    .line 106
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/WritableByteChannel;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 165
    const-wide v3, 0x3feb333333333333L    # 0.85

    invoke-static {}, Lorg/xerial/snappy/pool/DefaultPoolFactory;->getDefaultPool()Lorg/xerial/snappy/pool/BufferPool;

    move-result-object v5

    const/high16 v2, 0x10000

    move-object v0, p0

    move-object v1, p1

    invoke-direct/range {v0 .. v5}, Lorg/xerial/snappy/SnappyFramedOutputStream;-><init>(Ljava/nio/channels/WritableByteChannel;IDLorg/xerial/snappy/pool/BufferPool;)V

    .line 166
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/WritableByteChannel;ID)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 203
    invoke-static {}, Lorg/xerial/snappy/pool/DefaultPoolFactory;->getDefaultPool()Lorg/xerial/snappy/pool/BufferPool;

    move-result-object v5

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-wide v3, p3

    invoke-direct/range {v0 .. v5}, Lorg/xerial/snappy/SnappyFramedOutputStream;-><init>(Ljava/nio/channels/WritableByteChannel;IDLorg/xerial/snappy/pool/BufferPool;)V

    .line 204
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/WritableByteChannel;IDLorg/xerial/snappy/pool/BufferPool;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 223
    invoke-direct {p0}, Ljava/io/OutputStream;-><init>()V

    .line 62
    const/16 v0, 0x8

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    sget-object v1, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v0

    iput-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->headerBuffer:Ljava/nio/ByteBuffer;

    .line 224
    if-eqz p1, :cond_3

    .line 228
    if-eqz p5, :cond_2

    .line 232
    const-wide/16 v0, 0x0

    cmpg-double v0, p3, v0

    if-lez v0, :cond_1

    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    cmpl-double v0, p3, v0

    if-gtz v0, :cond_1

    .line 237
    if-lez p2, :cond_0

    const/high16 v0, 0x10000

    if-gt p2, v0, :cond_0

    .line 241
    iput p2, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->blockSize:I

    .line 242
    iput-object p1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->out:Ljava/nio/channels/WritableByteChannel;

    .line 243
    iput-wide p3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->minCompressionRatio:D

    .line 245
    iput-object p5, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    .line 246
    invoke-interface {p5, p2}, Lorg/xerial/snappy/pool/BufferPool;->allocateArray(I)[B

    move-result-object p3

    const/4 p4, 0x0

    invoke-static {p3, p4, p2}, Ljava/nio/ByteBuffer;->wrap([BII)Ljava/nio/ByteBuffer;

    move-result-object p3

    iput-object p3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    .line 247
    invoke-interface {p5, p2}, Lorg/xerial/snappy/pool/BufferPool;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object p3

    iput-object p3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->directInputBuffer:Ljava/nio/ByteBuffer;

    .line 248
    nop

    .line 249
    invoke-static {p2}, Lorg/xerial/snappy/Snappy;->maxCompressedLength(I)I

    move-result p2

    .line 248
    invoke-interface {p5, p2}, Lorg/xerial/snappy/pool/BufferPool;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object p2

    iput-object p2, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->outputBuffer:Ljava/nio/ByteBuffer;

    .line 251
    invoke-direct {p0, p1}, Lorg/xerial/snappy/SnappyFramedOutputStream;->writeHeader(Ljava/nio/channels/WritableByteChannel;)V

    .line 252
    return-void

    .line 238
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "block size "

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, " must be in (0, 65536]"

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 233
    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p5, "minCompressionRatio "

    invoke-virtual {p2, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p3, p4}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, " must be in (0,1.0]"

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 229
    :cond_2
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "buffer pool is null"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 225
    :cond_3
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "out is null"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public constructor <init>(Ljava/nio/channels/WritableByteChannel;Lorg/xerial/snappy/pool/BufferPool;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 183
    const/high16 v2, 0x10000

    const-wide v3, 0x3feb333333333333L    # 0.85

    move-object v0, p0

    move-object v1, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lorg/xerial/snappy/SnappyFramedOutputStream;-><init>(Ljava/nio/channels/WritableByteChannel;IDLorg/xerial/snappy/pool/BufferPool;)V

    .line 184
    return-void
.end method

.method private flushBuffer()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 481
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    if-lez v0, :cond_0

    .line 482
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    .line 483
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-direct {p0, v0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->writeCompressed(Ljava/nio/ByteBuffer;)V

    .line 484
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    .line 485
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->blockSize:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    .line 487
    :cond_0
    return-void
.end method

.method private writeBlock(Ljava/nio/channels/WritableByteChannel;Ljava/nio/ByteBuffer;ZI)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 545
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->headerBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    .line 546
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->headerBuffer:Ljava/nio/ByteBuffer;

    if-eqz p3, :cond_0

    const/4 p3, 0x0

    goto :goto_0

    .line 547
    :cond_0
    const/4 p3, 0x1

    :goto_0
    int-to-byte p3, p3

    .line 546
    invoke-virtual {v0, p3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 551
    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->remaining()I

    move-result p3

    add-int/lit8 p3, p3, 0x4

    .line 554
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->headerBuffer:Ljava/nio/ByteBuffer;

    int-to-byte v1, p3

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 555
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->headerBuffer:Ljava/nio/ByteBuffer;

    ushr-int/lit8 v1, p3, 0x8

    int-to-byte v1, v1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 556
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->headerBuffer:Ljava/nio/ByteBuffer;

    ushr-int/lit8 p3, p3, 0x10

    int-to-byte p3, p3

    invoke-virtual {v0, p3}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 559
    iget-object p3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->headerBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {p3, p4}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    .line 561
    iget-object p3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->headerBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {p3}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    move-result-object p3

    check-cast p3, Ljava/nio/ByteBuffer;

    .line 564
    iget-object p3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->headerBuffer:Ljava/nio/ByteBuffer;

    invoke-interface {p1, p3}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    .line 566
    invoke-interface {p1, p2}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    .line 567
    return-void
.end method

.method private writeCompressed(Ljava/nio/ByteBuffer;)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 502
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v0

    .line 503
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    .line 506
    const/4 v2, 0x0

    invoke-static {v0, v2, v1}, Lorg/xerial/snappy/SnappyFramed;->maskedCrc32c([BII)I

    move-result v0

    .line 508
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->directInputBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    move-result-object v3

    check-cast v3, Ljava/nio/ByteBuffer;

    .line 509
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->directInputBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v3, p1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    .line 510
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->directInputBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    move-result-object v3

    check-cast v3, Ljava/nio/ByteBuffer;

    .line 512
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->outputBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    move-result-object v3

    check-cast v3, Ljava/nio/ByteBuffer;

    .line 513
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->directInputBuffer:Ljava/nio/ByteBuffer;

    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->outputBuffer:Ljava/nio/ByteBuffer;

    invoke-static {v3, v4}, Lorg/xerial/snappy/Snappy;->compress(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;)I

    .line 515
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->outputBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v3

    .line 519
    int-to-double v3, v3

    int-to-double v5, v1

    div-double/2addr v3, v5

    iget-wide v5, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->minCompressionRatio:D

    cmpg-double v1, v3, v5

    if-gtz v1, :cond_0

    .line 520
    iget-object p1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->out:Ljava/nio/channels/WritableByteChannel;

    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->outputBuffer:Ljava/nio/ByteBuffer;

    const/4 v2, 0x1

    invoke-direct {p0, p1, v1, v2, v0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->writeBlock(Ljava/nio/channels/WritableByteChannel;Ljava/nio/ByteBuffer;ZI)V

    goto :goto_0

    .line 524
    :cond_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    move-result-object v1

    check-cast v1, Ljava/nio/ByteBuffer;

    .line 525
    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->out:Ljava/nio/channels/WritableByteChannel;

    invoke-direct {p0, v1, p1, v2, v0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->writeBlock(Ljava/nio/channels/WritableByteChannel;Ljava/nio/ByteBuffer;ZI)V

    .line 527
    :goto_0
    return-void
.end method

.method private writeHeader(Ljava/nio/channels/WritableByteChannel;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 264
    sget-object v0, Lorg/xerial/snappy/SnappyFramed;->HEADER_BYTES:[B

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    .line 265
    return-void
.end method


# virtual methods
.method public final close()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 457
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->closed:Z

    if-eqz v0, :cond_0

    .line 458
    return-void

    .line 461
    :cond_0
    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flush()V

    .line 462
    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->out:Ljava/nio/channels/WritableByteChannel;

    invoke-interface {v1}, Ljava/nio/channels/WritableByteChannel;->close()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 465
    iput-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->closed:Z

    .line 466
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    invoke-interface {v0, v1}, Lorg/xerial/snappy/pool/BufferPool;->releaseArray([B)V

    .line 467
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->directInputBuffer:Ljava/nio/ByteBuffer;

    invoke-interface {v0, v1}, Lorg/xerial/snappy/pool/BufferPool;->releaseDirect(Ljava/nio/ByteBuffer;)V

    .line 468
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->outputBuffer:Ljava/nio/ByteBuffer;

    invoke-interface {v0, v1}, Lorg/xerial/snappy/pool/BufferPool;->releaseDirect(Ljava/nio/ByteBuffer;)V

    .line 469
    nop

    .line 470
    return-void

    .line 465
    :catchall_0
    move-exception v1

    iput-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->closed:Z

    .line 466
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v2, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v2

    invoke-interface {v0, v2}, Lorg/xerial/snappy/pool/BufferPool;->releaseArray([B)V

    .line 467
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v2, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->directInputBuffer:Ljava/nio/ByteBuffer;

    invoke-interface {v0, v2}, Lorg/xerial/snappy/pool/BufferPool;->releaseDirect(Ljava/nio/ByteBuffer;)V

    .line 468
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v2, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->outputBuffer:Ljava/nio/ByteBuffer;

    invoke-interface {v0, v2}, Lorg/xerial/snappy/pool/BufferPool;->releaseDirect(Ljava/nio/ByteBuffer;)V

    .line 469
    throw v1
.end method

.method public final flush()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 447
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->closed:Z

    if-nez v0, :cond_0

    .line 450
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flushBuffer()V

    .line 451
    return-void

    .line 448
    :cond_0
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Stream is closed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public isOpen()Z
    .locals 1

    .line 273
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->closed:Z

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public transferFrom(Ljava/io/InputStream;)J
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 373
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->closed:Z

    if-nez v0, :cond_5

    .line 377
    if-eqz p1, :cond_4

    .line 381
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    if-nez v0, :cond_0

    .line 382
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flushBuffer()V

    .line 385
    :cond_0
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->hasArray()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 386
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v0

    .line 388
    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->arrayOffset()I

    move-result v1

    .line 389
    const-wide/16 v2, 0x0

    .line 391
    :goto_0
    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->position()I

    move-result v4

    add-int/2addr v4, v1

    iget-object v5, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    .line 392
    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v5

    .line 391
    invoke-virtual {p1, v0, v4, v5}, Ljava/io/InputStream;->read([BII)I

    move-result v4

    const/4 v5, -0x1

    if-eq v4, v5, :cond_2

    .line 393
    iget-object v5, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    iget-object v6, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->position()I

    move-result v6

    add-int/2addr v6, v4

    invoke-virtual {v5, v6}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    move-result-object v5

    check-cast v5, Ljava/nio/ByteBuffer;

    .line 395
    iget-object v5, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v5

    if-nez v5, :cond_1

    .line 396
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flushBuffer()V

    .line 399
    :cond_1
    int-to-long v4, v4

    add-long/2addr v2, v4

    goto :goto_0

    .line 402
    :cond_2
    return-wide v2

    .line 385
    :cond_3
    new-instance p1, Ljava/lang/AssertionError;

    invoke-direct {p1}, Ljava/lang/AssertionError;-><init>()V

    throw p1

    .line 378
    :cond_4
    new-instance p1, Ljava/lang/NullPointerException;

    invoke-direct {p1}, Ljava/lang/NullPointerException;-><init>()V

    throw p1

    .line 374
    :cond_5
    new-instance p1, Ljava/nio/channels/ClosedChannelException;

    invoke-direct {p1}, Ljava/nio/channels/ClosedChannelException;-><init>()V

    throw p1
.end method

.method public transferFrom(Ljava/nio/channels/ReadableByteChannel;)J
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 418
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->closed:Z

    if-nez v0, :cond_4

    .line 422
    if-eqz p1, :cond_3

    .line 426
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    if-nez v0, :cond_0

    .line 427
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flushBuffer()V

    .line 430
    :cond_0
    const-wide/16 v0, 0x0

    .line 432
    :goto_0
    iget-object v2, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-interface {p1, v2}, Ljava/nio/channels/ReadableByteChannel;->read(Ljava/nio/ByteBuffer;)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_2

    .line 433
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v3

    if-nez v3, :cond_1

    .line 434
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flushBuffer()V

    .line 437
    :cond_1
    int-to-long v2, v2

    add-long/2addr v0, v2

    goto :goto_0

    .line 440
    :cond_2
    return-wide v0

    .line 423
    :cond_3
    new-instance p1, Ljava/lang/NullPointerException;

    invoke-direct {p1}, Ljava/lang/NullPointerException;-><init>()V

    throw p1

    .line 419
    :cond_4
    new-instance p1, Ljava/nio/channels/ClosedChannelException;

    invoke-direct {p1}, Ljava/nio/channels/ClosedChannelException;-><init>()V

    throw p1
.end method

.method public write(Ljava/nio/ByteBuffer;)I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 325
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->closed:Z

    if-nez v0, :cond_3

    .line 329
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    if-gtz v0, :cond_0

    .line 330
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flushBuffer()V

    .line 333
    :cond_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    .line 336
    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v2

    if-lt v1, v2, :cond_1

    .line 337
    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    .line 338
    return v0

    .line 342
    :cond_1
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v1

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v2

    add-int/2addr v1, v2

    .line 344
    :goto_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v2

    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v3

    add-int/2addr v2, v3

    if-gt v2, v1, :cond_2

    .line 346
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v2

    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v3

    add-int/2addr v2, v3

    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v2

    check-cast v2, Ljava/nio/ByteBuffer;

    .line 347
    iget-object v2, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v2, p1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    .line 348
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flushBuffer()V

    goto :goto_0

    .line 352
    :cond_2
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v1

    check-cast v1, Ljava/nio/ByteBuffer;

    .line 355
    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    .line 357
    return v0

    .line 326
    :cond_3
    new-instance p1, Ljava/nio/channels/ClosedChannelException;

    invoke-direct {p1}, Ljava/nio/channels/ClosedChannelException;-><init>()V

    throw p1
.end method

.method public write(I)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 280
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->closed:Z

    if-nez v0, :cond_1

    .line 283
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    if-gtz v0, :cond_0

    .line 284
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flushBuffer()V

    .line 286
    :cond_0
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    int-to-byte p1, p1

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 287
    return-void

    .line 281
    :cond_1
    new-instance p1, Ljava/io/IOException;

    const-string v0, "Stream is closed"

    invoke-direct {p1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public write([BII)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 293
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->closed:Z

    if-nez v0, :cond_4

    .line 297
    if-eqz p1, :cond_3

    .line 300
    if-ltz p2, :cond_2

    array-length v0, p1

    if-gt p2, v0, :cond_2

    if-ltz p3, :cond_2

    add-int v0, p2, p3

    array-length v1, p1

    if-gt v0, v1, :cond_2

    if-ltz v0, :cond_2

    .line 306
    :goto_0
    if-lez p3, :cond_1

    .line 307
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    if-gtz v0, :cond_0

    .line 308
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flushBuffer()V

    .line 311
    :cond_0
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    invoke-static {p3, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 312
    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedOutputStream;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, p1, p2, v0}, Ljava/nio/ByteBuffer;->put([BII)Ljava/nio/ByteBuffer;

    .line 313
    add-int/2addr p2, v0

    .line 314
    sub-int/2addr p3, v0

    .line 315
    goto :goto_0

    .line 316
    :cond_1
    return-void

    .line 303
    :cond_2
    new-instance p1, Ljava/lang/IndexOutOfBoundsException;

    invoke-direct {p1}, Ljava/lang/IndexOutOfBoundsException;-><init>()V

    throw p1

    .line 298
    :cond_3
    new-instance p1, Ljava/lang/NullPointerException;

    invoke-direct {p1}, Ljava/lang/NullPointerException;-><init>()V

    throw p1

    .line 294
    :cond_4
    new-instance p1, Ljava/io/IOException;

    const-string p2, "Stream is closed"

    invoke-direct {p1, p2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
