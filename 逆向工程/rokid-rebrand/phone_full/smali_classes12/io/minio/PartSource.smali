.class Lio/minio/PartSource;
.super Ljava/lang/Object;
.source "PartSource.java"


# instance fields
.field private buffers:[Lio/minio/ByteBufferStream;

.field private file:Ljava/io/RandomAccessFile;

.field private md5Hash:Ljava/lang/String;

.field private partNumber:I

.field private position:J

.field private sha256Hash:Ljava/lang/String;

.field private size:J


# direct methods
.method private constructor <init>(IJLjava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "partNumber"    # I
    .param p2, "size"    # J
    .param p4, "md5Hash"    # Ljava/lang/String;
    .param p5, "sha256Hash"    # Ljava/lang/String;

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    iput p1, p0, Lio/minio/PartSource;->partNumber:I

    .line 49
    iput-wide p2, p0, Lio/minio/PartSource;->size:J

    .line 50
    iput-object p4, p0, Lio/minio/PartSource;->md5Hash:Ljava/lang/String;

    .line 51
    iput-object p5, p0, Lio/minio/PartSource;->sha256Hash:Ljava/lang/String;

    .line 52
    return-void
.end method

.method public constructor <init>(ILjava/io/RandomAccessFile;JLjava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p1, "partNumber"    # I
    .param p2, "file"    # Ljava/io/RandomAccessFile;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p3, "size"    # J
    .param p5, "md5Hash"    # Ljava/lang/String;
    .param p6, "sha256Hash"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 57
    move-object v0, p0

    move v1, p1

    move-wide v2, p3

    move-object v4, p5

    move-object v5, p6

    invoke-direct/range {v0 .. v5}, Lio/minio/PartSource;-><init>(IJLjava/lang/String;Ljava/lang/String;)V

    .line 58
    const-string v0, "file must not be null"

    invoke-static {p2, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/RandomAccessFile;

    iput-object v0, p0, Lio/minio/PartSource;->file:Ljava/io/RandomAccessFile;

    .line 59
    iget-object v0, p0, Lio/minio/PartSource;->file:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v0

    iput-wide v0, p0, Lio/minio/PartSource;->position:J

    .line 60
    return-void
.end method

.method public constructor <init>(I[Lio/minio/ByteBufferStream;JLjava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p1, "partNumber"    # I
    .param p2, "buffers"    # [Lio/minio/ByteBufferStream;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p3, "size"    # J
    .param p5, "md5Hash"    # Ljava/lang/String;
    .param p6, "sha256Hash"    # Ljava/lang/String;

    .line 68
    move-object v0, p0

    move v1, p1

    move-wide v2, p3

    move-object v4, p5

    move-object v5, p6

    invoke-direct/range {v0 .. v5}, Lio/minio/PartSource;-><init>(IJLjava/lang/String;Ljava/lang/String;)V

    .line 69
    const-string v0, "buffers must not be null"

    invoke-static {p2, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/minio/ByteBufferStream;

    iput-object v0, p0, Lio/minio/PartSource;->buffers:[Lio/minio/ByteBufferStream;

    .line 70
    return-void
.end method


# virtual methods
.method public md5Hash()Ljava/lang/String;
    .locals 1

    .line 81
    iget-object v0, p0, Lio/minio/PartSource;->md5Hash:Ljava/lang/String;

    return-object v0
.end method

.method public partNumber()I
    .locals 1

    .line 73
    iget v0, p0, Lio/minio/PartSource;->partNumber:I

    return v0
.end method

.method public sha256Hash()Ljava/lang/String;
    .locals 1

    .line 85
    iget-object v0, p0, Lio/minio/PartSource;->sha256Hash:Ljava/lang/String;

    return-object v0
.end method

.method public size()J
    .locals 2

    .line 77
    iget-wide v0, p0, Lio/minio/PartSource;->size:J

    return-wide v0
.end method

.method public source()Lokio/Source;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 89
    iget-object v0, p0, Lio/minio/PartSource;->file:Ljava/io/RandomAccessFile;

    if-eqz v0, :cond_0

    .line 90
    iget-object v0, p0, Lio/minio/PartSource;->file:Ljava/io/RandomAccessFile;

    iget-wide v1, p0, Lio/minio/PartSource;->position:J

    invoke-virtual {v0, v1, v2}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 91
    iget-object v0, p0, Lio/minio/PartSource;->file:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v0

    invoke-static {v0}, Ljava/nio/channels/Channels;->newInputStream(Ljava/nio/channels/ReadableByteChannel;)Ljava/io/InputStream;

    move-result-object v0

    invoke-static {v0}, Lokio/Okio;->source(Ljava/io/InputStream;)Lokio/Source;

    move-result-object v0

    return-object v0

    .line 94
    :cond_0
    iget-object v0, p0, Lio/minio/PartSource;->buffers:[Lio/minio/ByteBufferStream;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0}, Lio/minio/ByteBufferStream;->inputStream()Ljava/io/InputStream;

    move-result-object v0

    .line 95
    .local v0, "stream":Ljava/io/InputStream;
    iget-object v1, p0, Lio/minio/PartSource;->buffers:[Lio/minio/ByteBufferStream;

    array-length v1, v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_1

    invoke-static {v0}, Lokio/Okio;->source(Ljava/io/InputStream;)Lokio/Source;

    move-result-object v1

    return-object v1

    .line 97
    :cond_1
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 98
    .local v1, "streams":Ljava/util/List;, "Ljava/util/List<Ljava/io/InputStream;>;"
    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 99
    const/4 v3, 0x1

    .local v3, "i":I
    :goto_0
    iget-object v4, p0, Lio/minio/PartSource;->buffers:[Lio/minio/ByteBufferStream;

    array-length v4, v4

    if-ge v3, v4, :cond_3

    .line 100
    iget-object v4, p0, Lio/minio/PartSource;->buffers:[Lio/minio/ByteBufferStream;

    aget-object v4, v4, v3

    invoke-virtual {v4}, Lio/minio/ByteBufferStream;->size()I

    move-result v4

    if-nez v4, :cond_2

    goto :goto_1

    .line 101
    :cond_2
    iget-object v4, p0, Lio/minio/PartSource;->buffers:[Lio/minio/ByteBufferStream;

    aget-object v4, v4, v3

    invoke-virtual {v4}, Lio/minio/ByteBufferStream;->inputStream()Ljava/io/InputStream;

    move-result-object v4

    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 99
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 103
    .end local v3    # "i":I
    :cond_3
    :goto_1
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    if-ne v3, v2, :cond_4

    invoke-static {v0}, Lokio/Okio;->source(Ljava/io/InputStream;)Lokio/Source;

    move-result-object v2

    return-object v2

    .line 104
    :cond_4
    new-instance v2, Ljava/io/SequenceInputStream;

    invoke-static {v1}, Ljava/util/Collections;->enumeration(Ljava/util/Collection;)Ljava/util/Enumeration;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/SequenceInputStream;-><init>(Ljava/util/Enumeration;)V

    invoke-static {v2}, Lokio/Okio;->source(Ljava/io/InputStream;)Lokio/Source;

    move-result-object v2

    return-object v2
.end method
