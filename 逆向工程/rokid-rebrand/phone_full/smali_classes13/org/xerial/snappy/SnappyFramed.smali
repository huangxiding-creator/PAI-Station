.class final Lorg/xerial/snappy/SnappyFramed;
.super Ljava/lang/Object;
.source "SnappyFramed.java"


# static fields
.field public static final COMPRESSED_DATA_FLAG:I = 0x0

.field public static final HEADER_BYTES:[B

.field private static final MASK_DELTA:I = -0x5d7d1528

.field public static final STREAM_IDENTIFIER_FLAG:I = 0xff

.field public static final UNCOMPRESSED_DATA_FLAG:I = 0x1


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 30
    const/16 v0, 0xa

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    sput-object v0, Lorg/xerial/snappy/SnappyFramed;->HEADER_BYTES:[B

    return-void

    :array_0
    .array-data 1
        -0x1t
        0x6t
        0x0t
        0x0t
        0x73t
        0x4et
        0x61t
        0x50t
        0x70t
        0x59t
    .end array-data
.end method

.method constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static mask(I)I
    .locals 1

    .line 62
    ushr-int/lit8 v0, p0, 0xf

    shl-int/lit8 p0, p0, 0x11

    or-int/2addr p0, v0

    const v0, -0x5d7d1528

    add-int/2addr p0, v0

    return p0
.end method

.method public static maskedCrc32c([B)I
    .locals 2

    .line 36
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lorg/xerial/snappy/SnappyFramed;->maskedCrc32c([BII)I

    move-result p0

    return p0
.end method

.method public static maskedCrc32c([BII)I
    .locals 1

    .line 41
    new-instance v0, Lorg/xerial/snappy/PureJavaCrc32C;

    invoke-direct {v0}, Lorg/xerial/snappy/PureJavaCrc32C;-><init>()V

    .line 42
    invoke-virtual {v0, p0, p1, p2}, Lorg/xerial/snappy/PureJavaCrc32C;->update([BII)V

    .line 43
    invoke-virtual {v0}, Lorg/xerial/snappy/PureJavaCrc32C;->getIntegerValue()I

    move-result p0

    invoke-static {p0}, Lorg/xerial/snappy/SnappyFramed;->mask(I)I

    move-result p0

    return p0
.end method

.method static final readBytes(Ljava/nio/channels/ReadableByteChannel;Ljava/nio/ByteBuffer;)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 69
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    .line 71
    nop

    .line 74
    invoke-interface {p0, p1}, Ljava/nio/channels/ReadableByteChannel;->read(Ljava/nio/ByteBuffer;)I

    move-result v1

    .line 76
    nop

    .line 79
    if-ge v1, v0, :cond_2

    move v0, v1

    .line 81
    :cond_0
    :goto_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v2

    if-eqz v2, :cond_1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_1

    .line 82
    invoke-interface {p0, p1}, Ljava/nio/channels/ReadableByteChannel;->read(Ljava/nio/ByteBuffer;)I

    move-result v1

    .line 85
    if-eq v1, v2, :cond_0

    .line 86
    add-int/2addr v0, v1

    goto :goto_0

    .line 91
    :cond_1
    move v1, v0

    :cond_2
    if-lez v1, :cond_3

    .line 92
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result p0

    invoke-virtual {p1, p0}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object p0

    check-cast p0, Ljava/nio/ByteBuffer;

    goto :goto_1

    .line 95
    :cond_3
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->limit()I

    move-result p0

    invoke-virtual {p1, p0}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    move-result-object p0

    check-cast p0, Ljava/nio/ByteBuffer;

    .line 98
    :goto_1
    return v1
.end method

.method static skip(Ljava/nio/channels/ReadableByteChannel;ILjava/nio/ByteBuffer;)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 104
    const/4 v0, 0x0

    if-gtz p1, :cond_0

    .line 105
    return v0

    .line 108
    :cond_0
    nop

    .line 109
    move v1, p1

    .line 110
    :cond_1
    :goto_0
    if-lez v1, :cond_3

    const/4 v2, -0x1

    if-eq v0, v2, :cond_3

    .line 111
    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    .line 112
    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v0

    if-ge v1, v0, :cond_2

    .line 113
    invoke-virtual {p2, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object v0

    check-cast v0, Ljava/nio/ByteBuffer;

    .line 116
    :cond_2
    invoke-interface {p0, p2}, Ljava/nio/channels/ReadableByteChannel;->read(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 117
    if-lez v0, :cond_1

    .line 118
    sub-int/2addr v1, v0

    goto :goto_0

    .line 122
    :cond_3
    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    move-result-object p0

    check-cast p0, Ljava/nio/ByteBuffer;

    .line 123
    sub-int/2addr p1, v1

    return p1
.end method
