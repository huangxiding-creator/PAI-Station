.class public final Lorg/xerial/snappy/SnappyFramedInputStream;
.super Ljava/io/InputStream;
.source "SnappyFramedInputStream.java"

# interfaces
.implements Ljava/nio/channels/ReadableByteChannel;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/xerial/snappy/SnappyFramedInputStream$FrameData;,
        Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;,
        Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;
    }
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field private buffer:[B

.field private final bufferPool:Lorg/xerial/snappy/pool/BufferPool;

.field private closed:Z

.field private eof:Z

.field private final frameHeader:Ljava/nio/ByteBuffer;

.field private input:Ljava/nio/ByteBuffer;

.field private position:I

.field private final rbc:Ljava/nio/channels/ReadableByteChannel;

.field private uncompressedDirect:Ljava/nio/ByteBuffer;

.field private valid:I

.field private final verifyChecksums:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    .line 37
    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 96
    const/4 v0, 0x1

    invoke-static {}, Lorg/xerial/snappy/pool/DefaultPoolFactory;->getDefaultPool()Lorg/xerial/snappy/pool/BufferPool;

    move-result-object v1

    invoke-direct {p0, p1, v0, v1}, Lorg/xerial/snappy/SnappyFramedInputStream;-><init>(Ljava/io/InputStream;ZLorg/xerial/snappy/pool/BufferPool;)V

    .line 97
    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;Lorg/xerial/snappy/pool/BufferPool;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 110
    const/4 v0, 0x1

    invoke-direct {p0, p1, v0, p2}, Lorg/xerial/snappy/SnappyFramedInputStream;-><init>(Ljava/io/InputStream;ZLorg/xerial/snappy/pool/BufferPool;)V

    .line 111
    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 127
    invoke-static {}, Lorg/xerial/snappy/pool/DefaultPoolFactory;->getDefaultPool()Lorg/xerial/snappy/pool/BufferPool;

    move-result-object v0

    invoke-direct {p0, p1, p2, v0}, Lorg/xerial/snappy/SnappyFramedInputStream;-><init>(Ljava/io/InputStream;ZLorg/xerial/snappy/pool/BufferPool;)V

    .line 128
    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;ZLorg/xerial/snappy/pool/BufferPool;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 143
    invoke-static {p1}, Ljava/nio/channels/Channels;->newChannel(Ljava/io/InputStream;)Ljava/nio/channels/ReadableByteChannel;

    move-result-object p1

    invoke-direct {p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyFramedInputStream;-><init>(Ljava/nio/channels/ReadableByteChannel;ZLorg/xerial/snappy/pool/BufferPool;)V

    .line 144
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/ReadableByteChannel;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 173
    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lorg/xerial/snappy/SnappyFramedInputStream;-><init>(Ljava/nio/channels/ReadableByteChannel;Z)V

    .line 174
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/ReadableByteChannel;Lorg/xerial/snappy/pool/BufferPool;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 157
    const/4 v0, 0x1

    invoke-direct {p0, p1, v0, p2}, Lorg/xerial/snappy/SnappyFramedInputStream;-><init>(Ljava/nio/channels/ReadableByteChannel;ZLorg/xerial/snappy/pool/BufferPool;)V

    .line 158
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/ReadableByteChannel;Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 191
    invoke-static {}, Lorg/xerial/snappy/pool/DefaultPoolFactory;->getDefaultPool()Lorg/xerial/snappy/pool/BufferPool;

    move-result-object v0

    invoke-direct {p0, p1, p2, v0}, Lorg/xerial/snappy/SnappyFramedInputStream;-><init>(Ljava/nio/channels/ReadableByteChannel;ZLorg/xerial/snappy/pool/BufferPool;)V

    .line 192
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/ReadableByteChannel;ZLorg/xerial/snappy/pool/BufferPool;)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 206
    invoke-direct {p0}, Ljava/io/InputStream;-><init>()V

    .line 207
    if-eqz p1, :cond_3

    .line 211
    if-eqz p3, :cond_2

    .line 215
    iput-object p3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    .line 216
    iput-object p1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->rbc:Ljava/nio/channels/ReadableByteChannel;

    .line 217
    iput-boolean p2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->verifyChecksums:Z

    .line 219
    const p2, 0x10005

    invoke-direct {p0, p2}, Lorg/xerial/snappy/SnappyFramedInputStream;->allocateBuffersBasedOnSize(I)V

    .line 220
    const/4 p2, 0x4

    invoke-static {p2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object p2

    iput-object p2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->frameHeader:Ljava/nio/ByteBuffer;

    .line 223
    sget-object p2, Lorg/xerial/snappy/SnappyFramed;->HEADER_BYTES:[B

    .line 224
    array-length p3, p2

    new-array p3, p3, [B

    .line 225
    invoke-static {p3}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 227
    invoke-static {p1, v0}, Lorg/xerial/snappy/SnappyFramed;->readBytes(Ljava/nio/channels/ReadableByteChannel;Ljava/nio/ByteBuffer;)I

    move-result p1

    .line 228
    array-length v0, p2

    if-lt p1, v0, :cond_1

    .line 232
    invoke-static {p2, p3}, Ljava/util/Arrays;->equals([B[B)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 235
    return-void

    .line 233
    :cond_0
    new-instance p1, Ljava/io/IOException;

    const-string p2, "invalid stream header"

    invoke-direct {p1, p2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 229
    :cond_1
    new-instance p1, Ljava/io/EOFException;

    const-string p2, "encountered EOF while reading stream header"

    invoke-direct {p1, p2}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 212
    :cond_2
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "bufferPool is null"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 208
    :cond_3
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "in is null"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method private allocateBuffersBasedOnSize(I)V
    .locals 2

    .line 242
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    if-eqz v0, :cond_0

    .line 243
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    invoke-interface {v0, v1}, Lorg/xerial/snappy/pool/BufferPool;->releaseDirect(Ljava/nio/ByteBuffer;)V

    .line 246
    :cond_0
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    if-eqz v0, :cond_1

    .line 247
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    invoke-interface {v0, v1}, Lorg/xerial/snappy/pool/BufferPool;->releaseDirect(Ljava/nio/ByteBuffer;)V

    .line 250
    :cond_1
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    if-eqz v0, :cond_2

    .line 251
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    invoke-interface {v0, v1}, Lorg/xerial/snappy/pool/BufferPool;->releaseArray([B)V

    .line 254
    :cond_2
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    invoke-interface {v0, p1}, Lorg/xerial/snappy/pool/BufferPool;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    iput-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    .line 255
    invoke-static {p1}, Lorg/xerial/snappy/Snappy;->maxCompressedLength(I)I

    move-result p1

    .line 256
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    invoke-interface {v0, p1}, Lorg/xerial/snappy/pool/BufferPool;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    iput-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    .line 257
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    invoke-interface {v0, p1}, Lorg/xerial/snappy/pool/BufferPool;->allocateArray(I)[B

    move-result-object p1

    iput-object p1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    .line 258
    return-void
.end method

.method private ensureBuffer()Z
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 510
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->available()I

    move-result v0

    const/4 v1, 0x1

    if-lez v0, :cond_0

    .line 511
    return v1

    .line 513
    :cond_0
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->eof:Z

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    .line 514
    return v2

    .line 517
    :cond_1
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->readBlockHeader()Z

    move-result v0

    if-nez v0, :cond_2

    .line 518
    iput-boolean v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->eof:Z

    .line 519
    return v2

    .line 523
    :cond_2
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->frameHeader:Ljava/nio/ByteBuffer;

    invoke-direct {p0, v0}, Lorg/xerial/snappy/SnappyFramedInputStream;->getFrameMetaData(Ljava/nio/ByteBuffer;)Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;

    move-result-object v0

    .line 525
    sget-object v3, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->SKIP:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    iget-object v4, v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;->frameAction:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    if-ne v3, v4, :cond_3

    .line 526
    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->rbc:Ljava/nio/channels/ReadableByteChannel;

    iget v0, v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;->length:I

    iget-object v2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    .line 527
    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 526
    invoke-static {v1, v0, v2}, Lorg/xerial/snappy/SnappyFramed;->skip(Ljava/nio/channels/ReadableByteChannel;ILjava/nio/ByteBuffer;)I

    .line 528
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->ensureBuffer()Z

    move-result v0

    return v0

    .line 531
    :cond_3
    iget v3, v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;->length:I

    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v4

    if-le v3, v4, :cond_4

    .line 532
    iget v3, v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;->length:I

    invoke-direct {p0, v3}, Lorg/xerial/snappy/SnappyFramedInputStream;->allocateBuffersBasedOnSize(I)V

    .line 535
    :cond_4
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    move-result-object v3

    check-cast v3, Ljava/nio/ByteBuffer;

    .line 536
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    iget v4, v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;->length:I

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v3

    check-cast v3, Ljava/nio/ByteBuffer;

    .line 538
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->rbc:Ljava/nio/channels/ReadableByteChannel;

    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    invoke-static {v3, v4}, Lorg/xerial/snappy/SnappyFramed;->readBytes(Ljava/nio/channels/ReadableByteChannel;Ljava/nio/ByteBuffer;)I

    move-result v3

    .line 539
    iget v4, v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;->length:I

    if-ne v3, v4, :cond_9

    .line 542
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    move-result-object v3

    check-cast v3, Ljava/nio/ByteBuffer;

    .line 544
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    invoke-direct {p0, v3}, Lorg/xerial/snappy/SnappyFramedInputStream;->getFrameData(Ljava/nio/ByteBuffer;)Lorg/xerial/snappy/SnappyFramedInputStream$FrameData;

    move-result-object v3

    .line 546
    sget-object v4, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->UNCOMPRESS:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    iget-object v0, v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;->frameAction:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    if-ne v4, v0, :cond_6

    .line 548
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    iget v4, v3, Lorg/xerial/snappy/SnappyFramedInputStream$FrameData;->offset:I

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    .line 550
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    invoke-static {v0}, Lorg/xerial/snappy/Snappy;->uncompressedLength(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 552
    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v4

    if-le v0, v4, :cond_5

    .line 553
    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v5, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    invoke-interface {v4, v5}, Lorg/xerial/snappy/pool/BufferPool;->releaseDirect(Ljava/nio/ByteBuffer;)V

    .line 554
    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v5, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    invoke-interface {v4, v5}, Lorg/xerial/snappy/pool/BufferPool;->releaseArray([B)V

    .line 555
    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    invoke-interface {v4, v0}, Lorg/xerial/snappy/pool/BufferPool;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v4

    iput-object v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    .line 556
    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    invoke-interface {v4, v0}, Lorg/xerial/snappy/pool/BufferPool;->allocateArray(I)[B

    move-result-object v0

    iput-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    .line 559
    :cond_5
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    .line 561
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    invoke-static {v0, v4}, Lorg/xerial/snappy/Snappy;->uncompress(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;)I

    move-result v0

    iput v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->valid:I

    .line 563
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    iget v5, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->valid:I

    invoke-virtual {v0, v4, v2, v5}, Ljava/nio/ByteBuffer;->get([BII)Ljava/nio/ByteBuffer;

    .line 564
    iput v2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    .line 565
    goto :goto_0

    .line 568
    :cond_6
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    iget v4, v3, Lorg/xerial/snappy/SnappyFramedInputStream$FrameData;->offset:I

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    .line 569
    iput v2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    .line 570
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    iput v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->valid:I

    .line 571
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    iget-object v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    iget-object v5, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    invoke-virtual {v5}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v5

    invoke-virtual {v0, v4, v2, v5}, Ljava/nio/ByteBuffer;->get([BII)Ljava/nio/ByteBuffer;

    .line 574
    :goto_0
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->verifyChecksums:Z

    if-eqz v0, :cond_8

    .line 575
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    iget v2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    iget v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->valid:I

    iget v5, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    sub-int/2addr v4, v5

    invoke-static {v0, v2, v4}, Lorg/xerial/snappy/SnappyFramed;->maskedCrc32c([BII)I

    move-result v0

    .line 577
    iget v2, v3, Lorg/xerial/snappy/SnappyFramedInputStream$FrameData;->checkSum:I

    if-ne v2, v0, :cond_7

    goto :goto_1

    .line 578
    :cond_7
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Corrupt input: invalid checksum"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 582
    :cond_8
    :goto_1
    return v1

    .line 540
    :cond_9
    new-instance v0, Ljava/io/EOFException;

    const-string v1, "unexpectd EOF when reading frame"

    invoke-direct {v0, v1}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private getCrc32c(Ljava/nio/ByteBuffer;)I
    .locals 3

    .line 676
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    .line 678
    add-int/lit8 v1, v0, 0x3

    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x18

    add-int/lit8 v2, v0, 0x2

    .line 679
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    shl-int/lit8 v2, v2, 0x10

    or-int/2addr v1, v2

    add-int/lit8 v2, v0, 0x1

    .line 680
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    shl-int/lit8 v2, v2, 0x8

    or-int/2addr v1, v2

    .line 681
    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result p1

    and-int/lit16 p1, p1, 0xff

    or-int/2addr p1, v1

    .line 678
    return p1
.end method

.method private getFrameData(Ljava/nio/ByteBuffer;)Lorg/xerial/snappy/SnappyFramedInputStream$FrameData;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 670
    new-instance v0, Lorg/xerial/snappy/SnappyFramedInputStream$FrameData;

    invoke-direct {p0, p1}, Lorg/xerial/snappy/SnappyFramedInputStream;->getCrc32c(Ljava/nio/ByteBuffer;)I

    move-result p1

    const/4 v1, 0x4

    invoke-direct {v0, p1, v1}, Lorg/xerial/snappy/SnappyFramedInputStream$FrameData;-><init>(II)V

    return-object v0
.end method

.method private getFrameMetaData(Ljava/nio/ByteBuffer;)Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 612
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->hasArray()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 614
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object p1

    .line 616
    const/4 v0, 0x1

    aget-byte v0, p1, v0

    and-int/lit16 v0, v0, 0xff

    .line 617
    const/4 v1, 0x2

    aget-byte v1, p1, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    .line 618
    const/4 v1, 0x3

    aget-byte v1, p1, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x10

    or-int/2addr v0, v1

    .line 620
    nop

    .line 622
    const/4 v1, 0x0

    aget-byte p1, p1, v1

    and-int/lit16 p1, p1, 0xff

    .line 623
    const/4 v2, 0x5

    sparse-switch p1, :sswitch_data_0

    .line 643
    const/16 v2, 0x7f

    if-le p1, v2, :cond_2

    .line 650
    sget-object v2, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->SKIP:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    .line 651
    goto :goto_0

    .line 633
    :sswitch_0
    const/4 v1, 0x6

    if-ne v0, v1, :cond_0

    .line 638
    sget-object v2, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->SKIP:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    .line 639
    nop

    .line 640
    goto :goto_0

    .line 634
    :cond_0
    new-instance p1, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "stream identifier chunk with invalid length: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 629
    :sswitch_1
    sget-object v1, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->RAW:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    .line 630
    nop

    .line 631
    move v4, v2

    move-object v2, v1

    move v1, v4

    goto :goto_0

    .line 625
    :sswitch_2
    sget-object v1, Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;->UNCOMPRESS:Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;

    .line 626
    nop

    .line 627
    move v4, v2

    move-object v2, v1

    move v1, v4

    .line 654
    :goto_0
    if-lt v0, v1, :cond_1

    .line 659
    new-instance p1, Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;

    invoke-direct {p1, v2, v0}, Lorg/xerial/snappy/SnappyFramedInputStream$FrameMetaData;-><init>(Lorg/xerial/snappy/SnappyFramedInputStream$FrameAction;I)V

    return-object p1

    .line 655
    :cond_1
    new-instance v1, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "invalid length: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " for chunk flag: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 656
    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v1, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 644
    :cond_2
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unsupported unskippable chunk: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 645
    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 612
    :cond_3
    new-instance p1, Ljava/lang/AssertionError;

    invoke-direct {p1}, Ljava/lang/AssertionError;-><init>()V

    throw p1

    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_2
        0x1 -> :sswitch_1
        0xff -> :sswitch_0
    .end sparse-switch
.end method

.method private readBlockHeader()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 588
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->frameHeader:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    .line 589
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->rbc:Ljava/nio/channels/ReadableByteChannel;

    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->frameHeader:Ljava/nio/ByteBuffer;

    invoke-static {v0, v1}, Lorg/xerial/snappy/SnappyFramed;->readBytes(Ljava/nio/channels/ReadableByteChannel;Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 591
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 592
    const/4 v0, 0x0

    return v0

    .line 595
    :cond_0
    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->frameHeader:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v1

    if-lt v0, v1, :cond_1

    .line 598
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->frameHeader:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    .line 600
    const/4 v0, 0x1

    return v0

    .line 596
    :cond_1
    new-instance v0, Ljava/io/EOFException;

    const-string v1, "encountered EOF while reading block header"

    invoke-direct {v0, v1}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public available()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 308
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->closed:Z

    if-eqz v0, :cond_0

    .line 309
    const/4 v0, 0x0

    return v0

    .line 311
    :cond_0
    iget v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->valid:I

    iget v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    sub-int/2addr v0, v1

    return v0
.end method

.method public close()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 444
    const/4 v0, 0x1

    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->rbc:Ljava/nio/channels/ReadableByteChannel;

    invoke-interface {v2}, Ljava/nio/channels/ReadableByteChannel;->close()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 447
    iget-boolean v2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->closed:Z

    if-nez v2, :cond_2

    .line 448
    iput-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->closed:Z

    .line 450
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    if-eqz v0, :cond_0

    .line 451
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    invoke-interface {v0, v2}, Lorg/xerial/snappy/pool/BufferPool;->releaseDirect(Ljava/nio/ByteBuffer;)V

    .line 452
    iput-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    .line 455
    :cond_0
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    if-eqz v0, :cond_1

    .line 456
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    invoke-interface {v0, v2}, Lorg/xerial/snappy/pool/BufferPool;->releaseDirect(Ljava/nio/ByteBuffer;)V

    .line 457
    iput-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    .line 460
    :cond_1
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    if-eqz v0, :cond_2

    .line 461
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    invoke-interface {v0, v2}, Lorg/xerial/snappy/pool/BufferPool;->releaseArray([B)V

    .line 462
    iput-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    .line 466
    :cond_2
    return-void

    .line 447
    :catchall_0
    move-exception v2

    iget-boolean v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->closed:Z

    if-nez v3, :cond_5

    .line 448
    iput-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->closed:Z

    .line 450
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    if-eqz v0, :cond_3

    .line 451
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    invoke-interface {v0, v3}, Lorg/xerial/snappy/pool/BufferPool;->releaseDirect(Ljava/nio/ByteBuffer;)V

    .line 452
    iput-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->input:Ljava/nio/ByteBuffer;

    .line 455
    :cond_3
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    if-eqz v0, :cond_4

    .line 456
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    invoke-interface {v0, v3}, Lorg/xerial/snappy/pool/BufferPool;->releaseDirect(Ljava/nio/ByteBuffer;)V

    .line 457
    iput-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->uncompressedDirect:Ljava/nio/ByteBuffer;

    .line 460
    :cond_4
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    if-eqz v0, :cond_5

    .line 461
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->bufferPool:Lorg/xerial/snappy/pool/BufferPool;

    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    invoke-interface {v0, v3}, Lorg/xerial/snappy/pool/BufferPool;->releaseArray([B)V

    .line 462
    iput-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    .line 465
    :cond_5
    throw v2
.end method

.method public isOpen()Z
    .locals 1

    .line 320
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->closed:Z

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public read()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 264
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->closed:Z

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 265
    return v1

    .line 267
    :cond_0
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->ensureBuffer()Z

    move-result v0

    if-nez v0, :cond_1

    .line 268
    return v1

    .line 270
    :cond_1
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    iget v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    aget-byte v0, v0, v1

    and-int/lit16 v0, v0, 0xff

    return v0
.end method

.method public read(Ljava/nio/ByteBuffer;)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 331
    if-eqz p1, :cond_3

    .line 335
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->closed:Z

    if-nez v0, :cond_2

    .line 339
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    if-nez v0, :cond_0

    .line 340
    const/4 p1, 0x0

    return p1

    .line 342
    :cond_0
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->ensureBuffer()Z

    move-result v0

    if-nez v0, :cond_1

    .line 343
    const/4 p1, -0x1

    return p1

    .line 346
    :cond_1
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->available()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 347
    iget-object v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    iget v2, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    invoke-virtual {p1, v1, v2, v0}, Ljava/nio/ByteBuffer;->put([BII)Ljava/nio/ByteBuffer;

    .line 348
    iget p1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    add-int/2addr p1, v0

    iput p1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    .line 349
    return v0

    .line 336
    :cond_2
    new-instance p1, Ljava/nio/channels/ClosedChannelException;

    invoke-direct {p1}, Ljava/nio/channels/ClosedChannelException;-><init>()V

    throw p1

    .line 332
    :cond_3
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "dst is null"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public read([BII)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 278
    if-eqz p1, :cond_4

    .line 282
    if-ltz p2, :cond_3

    if-ltz p3, :cond_3

    add-int v0, p2, p3

    array-length v1, p1

    if-gt v0, v1, :cond_3

    .line 287
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->closed:Z

    if-nez v0, :cond_2

    .line 291
    if-nez p3, :cond_0

    .line 292
    const/4 p1, 0x0

    return p1

    .line 294
    :cond_0
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->ensureBuffer()Z

    move-result v0

    if-nez v0, :cond_1

    .line 295
    const/4 p1, -0x1

    return p1

    .line 298
    :cond_1
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->available()I

    move-result v0

    invoke-static {p3, v0}, Ljava/lang/Math;->min(II)I

    move-result p3

    .line 299
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    iget v1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    invoke-static {v0, v1, p1, p2, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 300
    iget p1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    add-int/2addr p1, p3

    iput p1, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    .line 301
    return p3

    .line 288
    :cond_2
    new-instance p1, Ljava/nio/channels/ClosedChannelException;

    invoke-direct {p1}, Ljava/nio/channels/ClosedChannelException;-><init>()V

    throw p1

    .line 283
    :cond_3
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "invalid offset ["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v0, "] and length ["

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    const/16 p3, 0x5d

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 279
    :cond_4
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "output is null"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public transferTo(Ljava/io/OutputStream;)J
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 371
    if-eqz p1, :cond_2

    .line 375
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->closed:Z

    if-nez v0, :cond_1

    .line 379
    const-wide/16 v0, 0x0

    .line 381
    :goto_0
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->ensureBuffer()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 382
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->available()I

    move-result v2

    .line 383
    iget-object v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    iget v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    invoke-virtual {p1, v3, v4, v2}, Ljava/io/OutputStream;->write([BII)V

    .line 384
    iget v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    add-int/2addr v3, v2

    iput v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    .line 385
    int-to-long v2, v2

    add-long/2addr v0, v2

    .line 386
    goto :goto_0

    .line 388
    :cond_0
    return-wide v0

    .line 376
    :cond_1
    new-instance p1, Ljava/nio/channels/ClosedChannelException;

    invoke-direct {p1}, Ljava/nio/channels/ClosedChannelException;-><init>()V

    throw p1

    .line 372
    :cond_2
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "os is null"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public transferTo(Ljava/nio/channels/WritableByteChannel;)J
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 411
    if-eqz p1, :cond_2

    .line 415
    iget-boolean v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->closed:Z

    if-nez v0, :cond_1

    .line 419
    iget-object v0, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->buffer:[B

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 421
    const-wide/16 v1, 0x0

    .line 423
    :goto_0
    invoke-direct {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->ensureBuffer()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 424
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    move-result-object v3

    check-cast v3, Ljava/nio/ByteBuffer;

    .line 425
    iget v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    move-result-object v3

    check-cast v3, Ljava/nio/ByteBuffer;

    .line 426
    iget v3, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyFramedInputStream;->available()I

    move-result v4

    add-int/2addr v3, v4

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v3

    check-cast v3, Ljava/nio/ByteBuffer;

    .line 428
    invoke-interface {p1, v0}, Ljava/nio/channels/WritableByteChannel;->write(Ljava/nio/ByteBuffer;)I

    .line 430
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    iget v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    sub-int/2addr v3, v4

    .line 431
    iget v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    add-int/2addr v4, v3

    iput v4, p0, Lorg/xerial/snappy/SnappyFramedInputStream;->position:I

    .line 433
    int-to-long v3, v3

    add-long/2addr v1, v3

    .line 434
    goto :goto_0

    .line 436
    :cond_0
    return-wide v1

    .line 416
    :cond_1
    new-instance p1, Ljava/nio/channels/ClosedChannelException;

    invoke-direct {p1}, Ljava/nio/channels/ClosedChannelException;-><init>()V

    throw p1

    .line 412
    :cond_2
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "wbc is null"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
