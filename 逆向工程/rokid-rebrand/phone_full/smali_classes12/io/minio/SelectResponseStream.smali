.class public Lio/minio/SelectResponseStream;
.super Ljava/io/InputStream;
.source "SelectResponseStream.java"


# instance fields
.field private crcHasher:Ljava/util/zip/CRC32;

.field private headerValueLen:[B

.field private inputStream:Ljava/io/InputStream;

.field private messageCrc:[B

.field private payloadStream:Ljava/io/ByteArrayInputStream;

.field private prelude:[B

.field private preludeCrc:[B

.field private stats:Lio/minio/messages/Stats;


# direct methods
.method public constructor <init>(Ljava/io/InputStream;)V
    .locals 2
    .param p1, "inputStream"    # Ljava/io/InputStream;

    .line 49
    invoke-direct {p0}, Ljava/io/InputStream;-><init>()V

    .line 41
    const/16 v0, 0x8

    new-array v0, v0, [B

    iput-object v0, p0, Lio/minio/SelectResponseStream;->prelude:[B

    .line 42
    const/4 v0, 0x4

    new-array v1, v0, [B

    iput-object v1, p0, Lio/minio/SelectResponseStream;->preludeCrc:[B

    .line 43
    new-array v0, v0, [B

    iput-object v0, p0, Lio/minio/SelectResponseStream;->messageCrc:[B

    .line 44
    const/4 v0, 0x2

    new-array v0, v0, [B

    iput-object v0, p0, Lio/minio/SelectResponseStream;->headerValueLen:[B

    .line 46
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/SelectResponseStream;->stats:Lio/minio/messages/Stats;

    .line 47
    iput-object v0, p0, Lio/minio/SelectResponseStream;->payloadStream:Ljava/io/ByteArrayInputStream;

    .line 50
    iput-object p1, p0, Lio/minio/SelectResponseStream;->inputStream:Ljava/io/InputStream;

    .line 51
    new-instance v0, Ljava/util/zip/CRC32;

    invoke-direct {v0}, Ljava/util/zip/CRC32;-><init>()V

    iput-object v0, p0, Lio/minio/SelectResponseStream;->crcHasher:Ljava/util/zip/CRC32;

    .line 52
    return-void
.end method

.method private decodeHeaderData(Ljava/io/ByteArrayInputStream;)Ljava/util/Map;
    .locals 10
    .param p1, "bais"    # Ljava/io/ByteArrayInputStream;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/ByteArrayInputStream;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 55
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 57
    .local v0, "headerMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :goto_0
    invoke-virtual {p1}, Ljava/io/ByteArrayInputStream;->read()I

    move-result v1

    move v2, v1

    .local v2, "n":I
    if-ltz v1, :cond_5

    .line 58
    and-int/lit16 v1, v2, 0xff

    .line 59
    .local v1, "len":I
    new-array v3, v1, [B

    .line 60
    .local v3, "b":[B
    const/4 v4, 0x0

    invoke-virtual {p1, v3, v4, v1}, Ljava/io/ByteArrayInputStream;->read([BII)I

    move-result v5

    const-string v6, "insufficient data"

    if-ltz v5, :cond_4

    .line 63
    new-instance v5, Ljava/lang/String;

    sget-object v7, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v5, v3, v7}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 65
    .local v5, "name":Ljava/lang/String;
    invoke-virtual {p1}, Ljava/io/ByteArrayInputStream;->read()I

    move-result v2

    .line 66
    if-ltz v2, :cond_3

    .line 69
    and-int/lit16 v7, v2, 0xff

    const/4 v8, 0x7

    if-ne v7, v8, :cond_2

    .line 73
    iget-object v7, p0, Lio/minio/SelectResponseStream;->headerValueLen:[B

    const/4 v8, 0x2

    invoke-virtual {p1, v7, v4, v8}, Ljava/io/ByteArrayInputStream;->read([BII)I

    move-result v7

    if-ltz v7, :cond_1

    .line 76
    iget-object v7, p0, Lio/minio/SelectResponseStream;->headerValueLen:[B

    aget-byte v7, v7, v4

    and-int/lit16 v7, v7, 0xff

    shl-int/lit8 v7, v7, 0x8

    iget-object v8, p0, Lio/minio/SelectResponseStream;->headerValueLen:[B

    const/4 v9, 0x1

    aget-byte v8, v8, v9

    and-int/lit16 v8, v8, 0xff

    or-int v1, v7, v8

    .line 77
    new-array v3, v1, [B

    .line 78
    invoke-virtual {p1, v3, v4, v1}, Ljava/io/ByteArrayInputStream;->read([BII)I

    move-result v4

    if-ltz v4, :cond_0

    .line 81
    new-instance v4, Ljava/lang/String;

    sget-object v6, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v4, v3, v6}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 83
    .local v4, "value":Ljava/lang/String;
    invoke-interface {v0, v5, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 84
    .end local v1    # "len":I
    .end local v3    # "b":[B
    .end local v4    # "value":Ljava/lang/String;
    .end local v5    # "name":Ljava/lang/String;
    goto :goto_0

    .line 79
    .restart local v1    # "len":I
    .restart local v3    # "b":[B
    .restart local v5    # "name":Ljava/lang/String;
    :cond_0
    new-instance v4, Ljava/io/IOException;

    invoke-direct {v4, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 74
    :cond_1
    new-instance v4, Ljava/io/IOException;

    invoke-direct {v4, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 70
    :cond_2
    new-instance v4, Ljava/io/IOException;

    const-string v6, "header value type is not 7"

    invoke-direct {v4, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 67
    :cond_3
    new-instance v4, Ljava/io/IOException;

    invoke-direct {v4, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 61
    .end local v5    # "name":Ljava/lang/String;
    :cond_4
    new-instance v4, Ljava/io/IOException;

    invoke-direct {v4, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 86
    .end local v1    # "len":I
    .end local v3    # "b":[B
    :cond_5
    return-object v0
.end method

.method private populate()Z
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/EOFException;,
            Ljava/io/IOException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/MinioException;
        }
    .end annotation

    .line 90
    iget-object v0, p0, Lio/minio/SelectResponseStream;->inputStream:Ljava/io/InputStream;

    iget-object v1, p0, Lio/minio/SelectResponseStream;->prelude:[B

    invoke-static {v0, v1}, Lcom/google/common/io/ByteStreams;->readFully(Ljava/io/InputStream;[B)V

    .line 91
    iget-object v0, p0, Lio/minio/SelectResponseStream;->inputStream:Ljava/io/InputStream;

    iget-object v1, p0, Lio/minio/SelectResponseStream;->preludeCrc:[B

    invoke-static {v0, v1}, Lcom/google/common/io/ByteStreams;->readFully(Ljava/io/InputStream;[B)V

    .line 92
    iget-object v0, p0, Lio/minio/SelectResponseStream;->crcHasher:Ljava/util/zip/CRC32;

    invoke-virtual {v0}, Ljava/util/zip/CRC32;->reset()V

    .line 93
    iget-object v0, p0, Lio/minio/SelectResponseStream;->crcHasher:Ljava/util/zip/CRC32;

    iget-object v1, p0, Lio/minio/SelectResponseStream;->prelude:[B

    invoke-virtual {v0, v1}, Ljava/util/zip/CRC32;->update([B)V

    .line 94
    iget-object v0, p0, Lio/minio/SelectResponseStream;->crcHasher:Ljava/util/zip/CRC32;

    invoke-virtual {v0}, Ljava/util/zip/CRC32;->getValue()J

    move-result-wide v0

    long-to-int v0, v0

    iget-object v1, p0, Lio/minio/SelectResponseStream;->preludeCrc:[B

    invoke-static {v1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v1

    const-string v2, ", got: "

    if-ne v0, v1, :cond_8

    .line 102
    iget-object v0, p0, Lio/minio/SelectResponseStream;->prelude:[B

    const/4 v1, 0x0

    const/4 v3, 0x4

    invoke-static {v0, v1, v3}, Ljava/nio/ByteBuffer;->wrap([BII)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v0

    .line 103
    .local v0, "totalLength":I
    add-int/lit8 v4, v0, -0xc

    sub-int/2addr v4, v3

    new-array v4, v4, [B

    .line 104
    .local v4, "data":[B
    iget-object v5, p0, Lio/minio/SelectResponseStream;->inputStream:Ljava/io/InputStream;

    invoke-static {v5, v4}, Lcom/google/common/io/ByteStreams;->readFully(Ljava/io/InputStream;[B)V

    .line 105
    iget-object v5, p0, Lio/minio/SelectResponseStream;->inputStream:Ljava/io/InputStream;

    iget-object v6, p0, Lio/minio/SelectResponseStream;->messageCrc:[B

    invoke-static {v5, v6}, Lcom/google/common/io/ByteStreams;->readFully(Ljava/io/InputStream;[B)V

    .line 106
    iget-object v5, p0, Lio/minio/SelectResponseStream;->crcHasher:Ljava/util/zip/CRC32;

    invoke-virtual {v5}, Ljava/util/zip/CRC32;->reset()V

    .line 107
    iget-object v5, p0, Lio/minio/SelectResponseStream;->crcHasher:Ljava/util/zip/CRC32;

    iget-object v6, p0, Lio/minio/SelectResponseStream;->prelude:[B

    invoke-virtual {v5, v6}, Ljava/util/zip/CRC32;->update([B)V

    .line 108
    iget-object v5, p0, Lio/minio/SelectResponseStream;->crcHasher:Ljava/util/zip/CRC32;

    iget-object v6, p0, Lio/minio/SelectResponseStream;->preludeCrc:[B

    invoke-virtual {v5, v6}, Ljava/util/zip/CRC32;->update([B)V

    .line 109
    iget-object v5, p0, Lio/minio/SelectResponseStream;->crcHasher:Ljava/util/zip/CRC32;

    invoke-virtual {v5, v4}, Ljava/util/zip/CRC32;->update([B)V

    .line 110
    iget-object v5, p0, Lio/minio/SelectResponseStream;->crcHasher:Ljava/util/zip/CRC32;

    invoke-virtual {v5}, Ljava/util/zip/CRC32;->getValue()J

    move-result-wide v5

    long-to-int v5, v5

    iget-object v6, p0, Lio/minio/SelectResponseStream;->messageCrc:[B

    invoke-static {v6}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v6

    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v6

    if-ne v5, v6, :cond_7

    .line 118
    iget-object v2, p0, Lio/minio/SelectResponseStream;->prelude:[B

    invoke-static {v2, v3, v3}, Ljava/nio/ByteBuffer;->wrap([BII)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v2

    .line 119
    .local v2, "headerLength":I
    const/4 v3, 0x0

    .line 121
    .local v3, "headerMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    new-instance v5, Ljava/io/ByteArrayInputStream;

    invoke-direct {v5, v4, v1, v2}, Ljava/io/ByteArrayInputStream;-><init>([BII)V

    invoke-direct {p0, v5}, Lio/minio/SelectResponseStream;->decodeHeaderData(Ljava/io/ByteArrayInputStream;)Ljava/util/Map;

    move-result-object v5
    :try_end_0
    .catch Ljava/io/EOFException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v3, v5

    .line 124
    nop

    .line 126
    const-string v5, ":message-type"

    invoke-interface {v3, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    const-string v6, "error"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_6

    .line 131
    const-string v5, ":event-type"

    invoke-interface {v3, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    const-string v7, "End"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_5

    .line 135
    sub-int v6, v0, v2

    add-int/lit8 v6, v6, -0x10

    .line 137
    .local v6, "payloadLength":I
    invoke-interface {v3, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    const-string v8, "Cont"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_4

    const/4 v7, 0x1

    if-ge v6, v7, :cond_0

    goto/16 :goto_0

    .line 141
    :cond_0
    new-instance v8, Ljava/io/ByteArrayInputStream;

    invoke-direct {v8, v4, v2, v6}, Ljava/io/ByteArrayInputStream;-><init>([BII)V

    .line 144
    .local v8, "payloadStream":Ljava/io/ByteArrayInputStream;
    invoke-interface {v3, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    const-string v10, "Progress"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 145
    const-class v5, Lio/minio/messages/Progress;

    new-instance v7, Ljava/io/InputStreamReader;

    sget-object v9, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v7, v8, v9}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    .line 147
    invoke-static {v5, v7}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lio/minio/messages/Stats;

    .line 149
    .local v5, "stats":Lio/minio/messages/Stats;
    iput-object v5, p0, Lio/minio/SelectResponseStream;->stats:Lio/minio/messages/Stats;

    .line 150
    return v1

    .line 153
    .end local v5    # "stats":Lio/minio/messages/Stats;
    :cond_1
    invoke-interface {v3, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    const-string v10, "Stats"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_2

    .line 154
    const-class v5, Lio/minio/messages/Stats;

    new-instance v7, Ljava/io/InputStreamReader;

    sget-object v9, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v7, v8, v9}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    .line 155
    invoke-static {v5, v7}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lio/minio/messages/Stats;

    .line 156
    .restart local v5    # "stats":Lio/minio/messages/Stats;
    iput-object v5, p0, Lio/minio/SelectResponseStream;->stats:Lio/minio/messages/Stats;

    .line 157
    return v1

    .line 160
    .end local v5    # "stats":Lio/minio/messages/Stats;
    :cond_2
    invoke-interface {v3, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    const-string v9, "Records"

    invoke-virtual {v1, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 161
    iput-object v8, p0, Lio/minio/SelectResponseStream;->payloadStream:Ljava/io/ByteArrayInputStream;

    .line 162
    return v7

    .line 165
    :cond_3
    new-instance v1, Lio/minio/errors/InternalException;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "unknown event-type \'"

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-interface {v3, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v7, "\'"

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x0

    invoke-direct {v1, v5, v7}, Lio/minio/errors/InternalException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v1

    .line 138
    .end local v8    # "payloadStream":Ljava/io/ByteArrayInputStream;
    :cond_4
    :goto_0
    return v1

    .line 132
    .end local v6    # "payloadLength":I
    :cond_5
    new-instance v1, Ljava/io/EOFException;

    invoke-direct {v1}, Ljava/io/EOFException;-><init>()V

    throw v1

    .line 127
    :cond_6
    new-instance v1, Lio/minio/errors/MinioException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    .line 128
    const-string v6, ":error-code"

    invoke-interface {v3, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ":"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ":error-message"

    invoke-interface {v3, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v1, v5}, Lio/minio/errors/MinioException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 122
    :catch_0
    move-exception v1

    .line 123
    .local v1, "e":Ljava/io/EOFException;
    new-instance v5, Ljava/io/IOException;

    const-string v6, "invalid header read"

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 111
    .end local v1    # "e":Ljava/io/EOFException;
    .end local v2    # "headerLength":I
    .end local v3    # "headerMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_7
    new-instance v1, Ljava/io/IOException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "message CRC mismatch; expected: "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v5, p0, Lio/minio/SelectResponseStream;->crcHasher:Ljava/util/zip/CRC32;

    .line 113
    invoke-virtual {v5}, Ljava/util/zip/CRC32;->getValue()J

    move-result-wide v5

    long-to-int v5, v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lio/minio/SelectResponseStream;->messageCrc:[B

    .line 115
    invoke-static {v3}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 95
    .end local v0    # "totalLength":I
    .end local v4    # "data":[B
    :cond_8
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "prelude CRC mismatch; expected: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lio/minio/SelectResponseStream;->crcHasher:Ljava/util/zip/CRC32;

    .line 97
    invoke-virtual {v3}, Ljava/util/zip/CRC32;->getValue()J

    move-result-wide v3

    long-to-int v3, v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lio/minio/SelectResponseStream;->preludeCrc:[B

    .line 99
    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 191
    iget-object v0, p0, Lio/minio/SelectResponseStream;->inputStream:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 192
    return-void
.end method

.method public read()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 170
    iget-object v0, p0, Lio/minio/SelectResponseStream;->payloadStream:Ljava/io/ByteArrayInputStream;

    if-nez v0, :cond_1

    .line 172
    :goto_0
    :try_start_0
    invoke-direct {p0}, Lio/minio/SelectResponseStream;->populate()Z

    move-result v0
    :try_end_0
    .catch Ljava/io/EOFException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/MinioException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v0, :cond_0

    goto :goto_0

    .line 178
    :cond_0
    goto :goto_1

    .line 176
    :catch_0
    move-exception v0

    .line 177
    .local v0, "e":Lio/minio/errors/MinioException;
    new-instance v1, Ljava/io/IOException;

    invoke-direct {v1, v0}, Ljava/io/IOException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 174
    .end local v0    # "e":Lio/minio/errors/MinioException;
    :catch_1
    move-exception v0

    .line 175
    .local v0, "e":Ljava/io/EOFException;
    const/4 v1, -0x1

    return v1

    .line 181
    .end local v0    # "e":Ljava/io/EOFException;
    :cond_1
    :goto_1
    iget-object v0, p0, Lio/minio/SelectResponseStream;->payloadStream:Ljava/io/ByteArrayInputStream;

    invoke-virtual {v0}, Ljava/io/ByteArrayInputStream;->read()I

    move-result v0

    .line 182
    .local v0, "n":I
    if-gez v0, :cond_2

    .line 183
    const/4 v1, 0x0

    iput-object v1, p0, Lio/minio/SelectResponseStream;->payloadStream:Ljava/io/ByteArrayInputStream;

    .line 184
    invoke-virtual {p0}, Lio/minio/SelectResponseStream;->read()I

    move-result v1

    return v1

    .line 187
    :cond_2
    return v0
.end method

.method public stats()Lio/minio/messages/Stats;
    .locals 1

    .line 196
    iget-object v0, p0, Lio/minio/SelectResponseStream;->stats:Lio/minio/messages/Stats;

    return-object v0
.end method
