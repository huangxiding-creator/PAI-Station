.class Lio/minio/PartReader;
.super Ljava/lang/Object;
.source "PartReader.java"


# static fields
.field private static final CHUNK_SIZE:J = 0x7fffffffL


# instance fields
.field private buf16k:[B

.field private buffers:[Lio/minio/ByteBufferStream;

.field eof:Z

.field private file:Ljava/io/RandomAccessFile;

.field private objectSize:J

.field private oneByte:[B

.field private partCount:I

.field private partNumber:I

.field private partSize:J

.field private stream:Ljava/io/InputStream;

.field private totalDataRead:J


# direct methods
.method private constructor <init>(JJI)V
    .locals 8
    .param p1, "objectSize"    # J
    .param p3, "partSize"    # J
    .param p5, "partCount"    # I

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    const/16 v0, 0x4000

    new-array v0, v0, [B

    iput-object v0, p0, Lio/minio/PartReader;->buf16k:[B

    .line 49
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/PartReader;->oneByte:[B

    .line 53
    iput-wide p1, p0, Lio/minio/PartReader;->objectSize:J

    .line 54
    iput-wide p3, p0, Lio/minio/PartReader;->partSize:J

    .line 55
    iput p5, p0, Lio/minio/PartReader;->partCount:I

    .line 57
    const-wide/32 v0, 0x7fffffff

    div-long v2, p3, v0

    .line 58
    .local v2, "bufferCount":J
    mul-long/2addr v0, v2

    sub-long v0, p3, v0

    const-wide/16 v4, 0x0

    cmp-long v0, v0, v4

    const-wide/16 v6, 0x1

    if-lez v0, :cond_0

    add-long/2addr v2, v6

    .line 59
    :cond_0
    cmp-long v0, v2, v4

    if-nez v0, :cond_1

    add-long/2addr v2, v6

    .line 61
    :cond_1
    long-to-int v0, v2

    new-array v0, v0, [Lio/minio/ByteBufferStream;

    iput-object v0, p0, Lio/minio/PartReader;->buffers:[Lio/minio/ByteBufferStream;

    .line 62
    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;JJI)V
    .locals 6
    .param p1, "stream"    # Ljava/io/InputStream;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "objectSize"    # J
    .param p4, "partSize"    # J
    .param p6, "partCount"    # I

    .line 71
    move-object v0, p0

    move-wide v1, p2

    move-wide v3, p4

    move v5, p6

    invoke-direct/range {v0 .. v5}, Lio/minio/PartReader;-><init>(JJI)V

    .line 72
    const-string/jumbo v0, "stream must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/InputStream;

    iput-object v0, p0, Lio/minio/PartReader;->stream:Ljava/io/InputStream;

    .line 73
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v1, p0, Lio/minio/PartReader;->buffers:[Lio/minio/ByteBufferStream;

    array-length v1, v1

    if-ge v0, v1, :cond_0

    iget-object v1, p0, Lio/minio/PartReader;->buffers:[Lio/minio/ByteBufferStream;

    new-instance v2, Lio/minio/ByteBufferStream;

    invoke-direct {v2}, Lio/minio/ByteBufferStream;-><init>()V

    aput-object v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 74
    .end local v0    # "i":I
    :cond_0
    return-void
.end method

.method public constructor <init>(Ljava/io/RandomAccessFile;JJI)V
    .locals 6
    .param p1, "file"    # Ljava/io/RandomAccessFile;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "objectSize"    # J
    .param p4, "partSize"    # J
    .param p6, "partCount"    # I

    .line 65
    move-object v0, p0

    move-wide v1, p2

    move-wide v3, p4

    move v5, p6

    invoke-direct/range {v0 .. v5}, Lio/minio/PartReader;-><init>(JJI)V

    .line 66
    const-string v0, "file must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/RandomAccessFile;

    iput-object v0, p0, Lio/minio/PartReader;->file:Ljava/io/RandomAccessFile;

    .line 67
    iget-wide v0, p0, Lio/minio/PartReader;->objectSize:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_0

    .line 68
    return-void

    .line 67
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "object size must be provided"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private read(JLjava/security/MessageDigest;)J
    .locals 2
    .param p1, "size"    # J
    .param p3, "sha256"    # Ljava/security/MessageDigest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 147
    iget-object v0, p0, Lio/minio/PartReader;->file:Ljava/io/RandomAccessFile;

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, p2, p3}, Lio/minio/PartReader;->readFile(JLjava/security/MessageDigest;)J

    move-result-wide v0

    goto :goto_0

    :cond_0
    invoke-direct {p0, p1, p2, p3}, Lio/minio/PartReader;->readStream(JLjava/security/MessageDigest;)J

    move-result-wide v0

    :goto_0
    return-wide v0
.end method

.method private readFile(JLjava/security/MessageDigest;)J
    .locals 10
    .param p1, "size"    # J
    .param p3, "sha256"    # Ljava/security/MessageDigest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 130
    iget-object v0, p0, Lio/minio/PartReader;->file:Ljava/io/RandomAccessFile;

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v0

    .line 131
    .local v0, "position":J
    const-wide/16 v2, 0x0

    .line 133
    .local v2, "totalBytesRead":J
    :goto_0
    cmp-long v4, v2, p1

    if-gez v4, :cond_2

    .line 134
    sub-long v4, p1, v2

    .line 135
    .local v4, "bytesToRead":J
    iget-object v6, p0, Lio/minio/PartReader;->buf16k:[B

    array-length v6, v6

    int-to-long v6, v6

    cmp-long v6, v4, v6

    if-lez v6, :cond_0

    iget-object v6, p0, Lio/minio/PartReader;->buf16k:[B

    array-length v6, v6

    int-to-long v4, v6

    .line 136
    :cond_0
    iget-object v6, p0, Lio/minio/PartReader;->file:Ljava/io/RandomAccessFile;

    iget-object v7, p0, Lio/minio/PartReader;->buf16k:[B

    long-to-int v8, v4

    const/4 v9, 0x0

    invoke-virtual {v6, v7, v9, v8}, Ljava/io/RandomAccessFile;->read([BII)I

    move-result v6

    .line 137
    .local v6, "bytesRead":I
    if-ltz v6, :cond_1

    .line 138
    iget-object v7, p0, Lio/minio/PartReader;->buf16k:[B

    invoke-virtual {p3, v7, v9, v6}, Ljava/security/MessageDigest;->update([BII)V

    .line 139
    int-to-long v7, v6

    add-long/2addr v2, v7

    .line 140
    .end local v4    # "bytesToRead":J
    .end local v6    # "bytesRead":I
    goto :goto_0

    .line 137
    .restart local v4    # "bytesToRead":J
    .restart local v6    # "bytesRead":I
    :cond_1
    new-instance v7, Ljava/io/IOException;

    const-string/jumbo v8, "unexpected EOF"

    invoke-direct {v7, v8}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v7

    .line 142
    .end local v4    # "bytesToRead":J
    .end local v6    # "bytesRead":I
    :cond_2
    iget-object v4, p0, Lio/minio/PartReader;->file:Ljava/io/RandomAccessFile;

    invoke-virtual {v4, v0, v1}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 143
    return-wide v2
.end method

.method private readStream(JLjava/security/MessageDigest;)J
    .locals 22
    .param p1, "size"    # J
    .param p3, "sha256"    # Ljava/security/MessageDigest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 105
    move-object/from16 v0, p0

    const-wide/32 v1, 0x7fffffff

    div-long v3, p1, v1

    .line 106
    .local v3, "count":J
    mul-long v5, v3, v1

    sub-long v5, p1, v5

    .line 107
    .local v5, "lastChunkSize":J
    const-wide/16 v7, 0x0

    cmp-long v9, v5, v7

    const-wide/16 v10, 0x1

    if-lez v9, :cond_0

    .line 108
    add-long/2addr v3, v10

    goto :goto_0

    .line 110
    :cond_0
    const-wide/32 v5, 0x7fffffff

    .line 113
    :goto_0
    const-wide/16 v12, 0x0

    .line 114
    .local v12, "totalBytesRead":J
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_1
    iget-object v14, v0, Lio/minio/PartReader;->buffers:[Lio/minio/ByteBufferStream;

    array-length v14, v14

    if-ge v9, v14, :cond_1

    iget-object v14, v0, Lio/minio/PartReader;->buffers:[Lio/minio/ByteBufferStream;

    aget-object v14, v14, v9

    invoke-virtual {v14}, Lio/minio/ByteBufferStream;->reset()V

    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .line 115
    .end local v9    # "i":I
    :cond_1
    const-wide/16 v14, 0x1

    .local v14, "i":J
    :goto_2
    cmp-long v9, v14, v3

    if-gtz v9, :cond_3

    iget-boolean v9, v0, Lio/minio/PartReader;->eof:Z

    if-nez v9, :cond_3

    .line 116
    cmp-long v9, v14, v3

    if-eqz v9, :cond_2

    move-wide/from16 v16, v1

    goto :goto_3

    :cond_2
    move-wide/from16 v16, v5

    :goto_3
    move-wide/from16 v18, v16

    .line 117
    .local v18, "chunkSize":J
    iget-object v9, v0, Lio/minio/PartReader;->buffers:[Lio/minio/ByteBufferStream;

    sub-long v1, v14, v10

    long-to-int v1, v1

    aget-object v1, v9, v1

    move-object/from16 v2, p3

    move-wide/from16 v7, v18

    .end local v18    # "chunkSize":J
    .local v7, "chunkSize":J
    invoke-direct {v0, v1, v7, v8, v2}, Lio/minio/PartReader;->readStreamChunk(Lio/minio/ByteBufferStream;JLjava/security/MessageDigest;)J

    move-result-wide v20

    .line 118
    .local v20, "bytesRead":J
    add-long v12, v12, v20

    .line 115
    .end local v7    # "chunkSize":J
    .end local v20    # "bytesRead":J
    add-long/2addr v14, v10

    const-wide/32 v1, 0x7fffffff

    const-wide/16 v7, 0x0

    goto :goto_2

    :cond_3
    move-object/from16 v2, p3

    .line 121
    .end local v14    # "i":J
    iget-boolean v1, v0, Lio/minio/PartReader;->eof:Z

    if-nez v1, :cond_5

    iget-wide v7, v0, Lio/minio/PartReader;->objectSize:J

    const-wide/16 v9, 0x0

    cmp-long v1, v7, v9

    if-gez v1, :cond_5

    .line 122
    const/4 v1, 0x1

    new-array v7, v1, [B

    iput-object v7, v0, Lio/minio/PartReader;->oneByte:[B

    .line 123
    iget-object v7, v0, Lio/minio/PartReader;->stream:Ljava/io/InputStream;

    iget-object v8, v0, Lio/minio/PartReader;->oneByte:[B

    invoke-virtual {v7, v8}, Ljava/io/InputStream;->read([B)I

    move-result v7

    if-gez v7, :cond_4

    goto :goto_4

    :cond_4
    const/4 v1, 0x0

    :goto_4
    iput-boolean v1, v0, Lio/minio/PartReader;->eof:Z

    .line 126
    :cond_5
    return-wide v12
.end method

.method private readStreamChunk(Lio/minio/ByteBufferStream;JLjava/security/MessageDigest;)J
    .locals 9
    .param p1, "buffer"    # Lio/minio/ByteBufferStream;
    .param p2, "size"    # J
    .param p4, "sha256"    # Ljava/security/MessageDigest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 78
    const-wide/16 v0, 0x0

    .line 80
    .local v0, "totalBytesRead":J
    iget-object v2, p0, Lio/minio/PartReader;->oneByte:[B

    if-eqz v2, :cond_0

    .line 81
    iget-object v2, p0, Lio/minio/PartReader;->oneByte:[B

    invoke-virtual {p1, v2}, Lio/minio/ByteBufferStream;->write([B)V

    .line 82
    iget-object v2, p0, Lio/minio/PartReader;->oneByte:[B

    invoke-virtual {p4, v2}, Ljava/security/MessageDigest;->update([B)V

    .line 83
    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    .line 84
    const/4 v2, 0x0

    iput-object v2, p0, Lio/minio/PartReader;->oneByte:[B

    .line 87
    :cond_0
    :goto_0
    cmp-long v2, v0, p2

    if-gez v2, :cond_5

    .line 88
    sub-long v2, p2, v0

    .line 89
    .local v2, "bytesToRead":J
    iget-object v4, p0, Lio/minio/PartReader;->buf16k:[B

    array-length v4, v4

    int-to-long v4, v4

    cmp-long v4, v2, v4

    if-lez v4, :cond_1

    iget-object v4, p0, Lio/minio/PartReader;->buf16k:[B

    array-length v4, v4

    int-to-long v2, v4

    .line 90
    :cond_1
    iget-object v4, p0, Lio/minio/PartReader;->stream:Ljava/io/InputStream;

    iget-object v5, p0, Lio/minio/PartReader;->buf16k:[B

    long-to-int v6, v2

    const/4 v7, 0x0

    invoke-virtual {v4, v5, v7, v6}, Ljava/io/InputStream;->read([BII)I

    move-result v4

    .line 91
    .local v4, "bytesRead":I
    if-gez v4, :cond_2

    const/4 v5, 0x1

    goto :goto_1

    :cond_2
    move v5, v7

    :goto_1
    iput-boolean v5, p0, Lio/minio/PartReader;->eof:Z

    .line 92
    iget-boolean v5, p0, Lio/minio/PartReader;->eof:Z

    if-eqz v5, :cond_4

    .line 93
    iget-wide v5, p0, Lio/minio/PartReader;->objectSize:J

    const-wide/16 v7, 0x0

    cmp-long v5, v5, v7

    if-gez v5, :cond_3

    goto :goto_2

    .line 94
    :cond_3
    new-instance v5, Ljava/io/IOException;

    const-string/jumbo v6, "unexpected EOF"

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 96
    :cond_4
    iget-object v5, p0, Lio/minio/PartReader;->buf16k:[B

    invoke-virtual {p1, v5, v7, v4}, Lio/minio/ByteBufferStream;->write([BII)V

    .line 97
    iget-object v5, p0, Lio/minio/PartReader;->buf16k:[B

    invoke-virtual {p4, v5, v7, v4}, Ljava/security/MessageDigest;->update([BII)V

    .line 98
    int-to-long v5, v4

    add-long/2addr v0, v5

    .line 99
    .end local v2    # "bytesToRead":J
    .end local v4    # "bytesRead":I
    goto :goto_0

    .line 101
    :cond_5
    :goto_2
    return-wide v0
.end method


# virtual methods
.method public getPart()Lio/minio/PartSource;
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 151
    iget v0, p0, Lio/minio/PartReader;->partNumber:I

    iget v1, p0, Lio/minio/PartReader;->partCount:I

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 153
    :cond_0
    iget v0, p0, Lio/minio/PartReader;->partNumber:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lio/minio/PartReader;->partNumber:I

    .line 155
    const-string v0, "SHA-256"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    .line 157
    .local v0, "sha256":Ljava/security/MessageDigest;
    iget-wide v1, p0, Lio/minio/PartReader;->partSize:J

    .line 158
    .local v1, "partSize":J
    iget v3, p0, Lio/minio/PartReader;->partNumber:I

    iget v4, p0, Lio/minio/PartReader;->partCount:I

    if-ne v3, v4, :cond_1

    iget-wide v3, p0, Lio/minio/PartReader;->objectSize:J

    iget-wide v5, p0, Lio/minio/PartReader;->totalDataRead:J

    sub-long v1, v3, v5

    .line 159
    :cond_1
    invoke-direct {p0, v1, v2, v0}, Lio/minio/PartReader;->read(JLjava/security/MessageDigest;)J

    move-result-wide v10

    .line 160
    .local v10, "bytesRead":J
    iget-wide v3, p0, Lio/minio/PartReader;->totalDataRead:J

    add-long/2addr v3, v10

    iput-wide v3, p0, Lio/minio/PartReader;->totalDataRead:J

    .line 161
    iget-wide v3, p0, Lio/minio/PartReader;->objectSize:J

    const-wide/16 v5, 0x0

    cmp-long v3, v3, v5

    if-gez v3, :cond_2

    iget-boolean v3, p0, Lio/minio/PartReader;->eof:Z

    if-eqz v3, :cond_2

    iget v3, p0, Lio/minio/PartReader;->partNumber:I

    iput v3, p0, Lio/minio/PartReader;->partCount:I

    .line 163
    :cond_2
    invoke-static {}, Lcom/google/common/io/BaseEncoding;->base16()Lcom/google/common/io/BaseEncoding;

    move-result-object v3

    invoke-virtual {v0}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/google/common/io/BaseEncoding;->encode([B)Ljava/lang/String;

    move-result-object v3

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v3, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v12

    .line 165
    .local v12, "sha256Hash":Ljava/lang/String;
    iget-object v3, p0, Lio/minio/PartReader;->file:Ljava/io/RandomAccessFile;

    if-eqz v3, :cond_3

    .line 166
    new-instance v13, Lio/minio/PartSource;

    iget v4, p0, Lio/minio/PartReader;->partNumber:I

    iget-object v5, p0, Lio/minio/PartReader;->file:Ljava/io/RandomAccessFile;

    const/4 v8, 0x0

    move-object v3, v13

    move-wide v6, v10

    move-object v9, v12

    invoke-direct/range {v3 .. v9}, Lio/minio/PartSource;-><init>(ILjava/io/RandomAccessFile;JLjava/lang/String;Ljava/lang/String;)V

    return-object v13

    .line 169
    :cond_3
    new-instance v13, Lio/minio/PartSource;

    iget v4, p0, Lio/minio/PartReader;->partNumber:I

    iget-object v5, p0, Lio/minio/PartReader;->buffers:[Lio/minio/ByteBufferStream;

    const/4 v8, 0x0

    move-object v3, v13

    move-wide v6, v10

    move-object v9, v12

    invoke-direct/range {v3 .. v9}, Lio/minio/PartSource;-><init>(I[Lio/minio/ByteBufferStream;JLjava/lang/String;Ljava/lang/String;)V

    return-object v13
.end method

.method public partCount()I
    .locals 1

    .line 173
    iget v0, p0, Lio/minio/PartReader;->partCount:I

    return v0
.end method
