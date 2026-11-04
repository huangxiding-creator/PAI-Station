.class Lio/minio/HttpRequestBody;
.super Lokhttp3/RequestBody;
.source "HttpRequestBody.java"


# instance fields
.field private bytes:[B

.field private contentType:Ljava/lang/String;

.field private length:I

.field private partSource:Lio/minio/PartSource;


# direct methods
.method constructor <init>(Lio/minio/PartSource;Ljava/lang/String;)V
    .locals 0
    .param p1, "partSource"    # Lio/minio/PartSource;
    .param p2, "contentType"    # Ljava/lang/String;

    .line 32
    invoke-direct {p0}, Lokhttp3/RequestBody;-><init>()V

    .line 33
    iput-object p1, p0, Lio/minio/HttpRequestBody;->partSource:Lio/minio/PartSource;

    .line 34
    iput-object p2, p0, Lio/minio/HttpRequestBody;->contentType:Ljava/lang/String;

    .line 35
    return-void
.end method

.method constructor <init>([BILjava/lang/String;)V
    .locals 0
    .param p1, "bytes"    # [B
    .param p2, "length"    # I
    .param p3, "contentType"    # Ljava/lang/String;

    .line 37
    invoke-direct {p0}, Lokhttp3/RequestBody;-><init>()V

    .line 38
    iput-object p1, p0, Lio/minio/HttpRequestBody;->bytes:[B

    .line 39
    iput p2, p0, Lio/minio/HttpRequestBody;->length:I

    .line 40
    iput-object p3, p0, Lio/minio/HttpRequestBody;->contentType:Ljava/lang/String;

    .line 41
    return-void
.end method


# virtual methods
.method public contentLength()J
    .locals 2

    .line 52
    iget-object v0, p0, Lio/minio/HttpRequestBody;->partSource:Lio/minio/PartSource;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/HttpRequestBody;->partSource:Lio/minio/PartSource;

    invoke-virtual {v0}, Lio/minio/PartSource;->size()J

    move-result-wide v0

    goto :goto_0

    :cond_0
    iget v0, p0, Lio/minio/HttpRequestBody;->length:I

    int-to-long v0, v0

    :goto_0
    return-wide v0
.end method

.method public contentType()Lokhttp3/MediaType;
    .locals 2

    .line 45
    const/4 v0, 0x0

    .line 46
    .local v0, "mediaType":Lokhttp3/MediaType;
    iget-object v1, p0, Lio/minio/HttpRequestBody;->contentType:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lio/minio/HttpRequestBody;->contentType:Ljava/lang/String;

    invoke-static {v1}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v0

    .line 47
    :cond_0
    if-nez v0, :cond_1

    const-string v1, "application/octet-stream"

    invoke-static {v1}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v1

    goto :goto_0

    :cond_1
    move-object v1, v0

    :goto_0
    return-object v1
.end method

.method public writeTo(Lokio/BufferedSink;)V
    .locals 3
    .param p1, "sink"    # Lokio/BufferedSink;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 57
    iget-object v0, p0, Lio/minio/HttpRequestBody;->partSource:Lio/minio/PartSource;

    if-eqz v0, :cond_0

    .line 58
    iget-object v0, p0, Lio/minio/HttpRequestBody;->partSource:Lio/minio/PartSource;

    invoke-virtual {v0}, Lio/minio/PartSource;->source()Lokio/Source;

    move-result-object v0

    iget-object v1, p0, Lio/minio/HttpRequestBody;->partSource:Lio/minio/PartSource;

    invoke-virtual {v1}, Lio/minio/PartSource;->size()J

    move-result-wide v1

    invoke-interface {p1, v0, v1, v2}, Lokio/BufferedSink;->write(Lokio/Source;J)Lokio/BufferedSink;

    goto :goto_0

    .line 60
    :cond_0
    iget-object v0, p0, Lio/minio/HttpRequestBody;->bytes:[B

    const/4 v1, 0x0

    iget v2, p0, Lio/minio/HttpRequestBody;->length:I

    invoke-interface {p1, v0, v1, v2}, Lokio/BufferedSink;->write([BII)Lokio/BufferedSink;

    .line 62
    :goto_0
    return-void
.end method
