.class public Lcom/amazonaws/services/s3/internal/AWSS3V4Signer;
.super Lcom/amazonaws/auth/AWS4Signer;
.source "AWSS3V4Signer.java"


# static fields
.field private static final CONTENT_SHA_256:Ljava/lang/String; = "STREAMING-AWS4-HMAC-SHA256-PAYLOAD"

.field private static final DEFAULT_BYTE_LENGTH:I = 0x1000


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 42
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/amazonaws/auth/AWS4Signer;-><init>(Z)V

    .line 43
    return-void
.end method

.method static getContentLength(Lcom/amazonaws/Request;)J
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;)J"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 136
    .local p0, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    invoke-interface {p0}, Lcom/amazonaws/Request;->getContent()Ljava/io/InputStream;

    move-result-object v0

    .line 137
    .local v0, "content":Ljava/io/InputStream;
    invoke-virtual {v0}, Ljava/io/InputStream;->markSupported()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 141
    const-wide/16 v1, 0x0

    .line 142
    .local v1, "contentLength":J
    const/16 v3, 0x1000

    new-array v3, v3, [B

    .line 144
    .local v3, "tmp":[B
    const/4 v4, -0x1

    invoke-virtual {v0, v4}, Ljava/io/InputStream;->mark(I)V

    .line 145
    :goto_0
    invoke-virtual {v0, v3}, Ljava/io/InputStream;->read([B)I

    move-result v5

    move v6, v5

    .local v6, "read":I
    if-eq v5, v4, :cond_0

    .line 146
    int-to-long v7, v6

    add-long/2addr v1, v7

    goto :goto_0

    .line 148
    :cond_0
    invoke-virtual {v0}, Ljava/io/InputStream;->reset()V

    .line 150
    return-wide v1

    .line 138
    .end local v1    # "contentLength":J
    .end local v3    # "tmp":[B
    .end local v6    # "read":I
    :cond_1
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    const-string v2, "Failed to get content length"

    invoke-direct {v1, v2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private static useChunkEncoding(Lcom/amazonaws/Request;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;)Z"
        }
    .end annotation

    .line 122
    .local p0, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    const/4 v0, 0x0

    .line 123
    .local v0, "chunkedEncodingEnabled":Z
    invoke-interface {p0}, Lcom/amazonaws/Request;->getOriginalRequest()Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v1

    instance-of v1, v1, Lcom/amazonaws/services/s3/model/PutObjectRequest;

    if-nez v1, :cond_0

    .line 124
    invoke-interface {p0}, Lcom/amazonaws/Request;->getOriginalRequest()Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v1

    instance-of v1, v1, Lcom/amazonaws/services/s3/model/UploadPartRequest;

    if-eqz v1, :cond_1

    .line 125
    :cond_0
    const/4 v0, 0x1

    .line 127
    :cond_1
    return v0
.end method


# virtual methods
.method protected calculateContentHash(Lcom/amazonaws/Request;)Ljava/lang/String;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 79
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    const-string/jumbo v0, "x-amz-content-sha256"

    const-string v1, "required"

    invoke-interface {p1, v0, v1}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 80
    invoke-static {p1}, Lcom/amazonaws/services/s3/internal/AWSS3V4Signer;->useChunkEncoding(Lcom/amazonaws/Request;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 81
    nop

    .line 82
    invoke-interface {p1}, Lcom/amazonaws/Request;->getHeaders()Ljava/util/Map;

    move-result-object v0

    const-string v1, "Content-Length"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 84
    .local v0, "contentLength":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 85
    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    .local v2, "originalContentLength":J
    goto :goto_0

    .line 97
    .end local v2    # "originalContentLength":J
    :cond_0
    :try_start_0
    invoke-static {p1}, Lcom/amazonaws/services/s3/internal/AWSS3V4Signer;->getContentLength(Lcom/amazonaws/Request;)J

    move-result-wide v2
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 102
    .restart local v2    # "originalContentLength":J
    nop

    .line 104
    :goto_0
    nop

    .line 105
    invoke-static {v2, v3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    .line 104
    const-string/jumbo v5, "x-amz-decoded-content-length"

    invoke-interface {p1, v5, v4}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 108
    nop

    .line 111
    invoke-static {v2, v3}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->calculateStreamContentLength(J)J

    move-result-wide v4

    .line 110
    invoke-static {v4, v5}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    .line 108
    invoke-interface {p1, v1, v4}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 112
    const-string v1, "STREAMING-AWS4-HMAC-SHA256-PAYLOAD"

    return-object v1

    .line 98
    .end local v2    # "originalContentLength":J
    :catch_0
    move-exception v1

    .line 99
    .local v1, "e":Ljava/io/IOException;
    new-instance v2, Lcom/amazonaws/AmazonClientException;

    const-string v3, "Cannot get the content-lenght of the request content."

    invoke-direct {v2, v3, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 114
    .end local v0    # "contentLength":Ljava/lang/String;
    .end local v1    # "e":Ljava/io/IOException;
    :cond_1
    invoke-super {p0, p1}, Lcom/amazonaws/auth/AWS4Signer;->calculateContentHash(Lcom/amazonaws/Request;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected calculateContentHashPresign(Lcom/amazonaws/Request;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 66
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    const-string v0, "UNSIGNED-PAYLOAD"

    return-object v0
.end method

.method protected processRequestPayload(Lcom/amazonaws/Request;Lcom/amazonaws/auth/AWS4Signer$HeaderSigningResult;)V
    .locals 13
    .param p2, "headerSigningResult"    # Lcom/amazonaws/auth/AWS4Signer$HeaderSigningResult;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Lcom/amazonaws/auth/AWS4Signer$HeaderSigningResult;",
            ")V"
        }
    .end annotation

    .line 51
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    invoke-static {p1}, Lcom/amazonaws/services/s3/internal/AWSS3V4Signer;->useChunkEncoding(Lcom/amazonaws/Request;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 52
    invoke-interface {p1}, Lcom/amazonaws/Request;->getContent()Ljava/io/InputStream;

    move-result-object v0

    .line 53
    .local v0, "payloadStream":Ljava/io/InputStream;
    invoke-virtual {p2}, Lcom/amazonaws/auth/AWS4Signer$HeaderSigningResult;->getDateTime()Ljava/lang/String;

    move-result-object v8

    .line 54
    .local v8, "dateTime":Ljava/lang/String;
    invoke-virtual {p2}, Lcom/amazonaws/auth/AWS4Signer$HeaderSigningResult;->getScope()Ljava/lang/String;

    move-result-object v9

    .line 55
    .local v9, "keyPath":Ljava/lang/String;
    invoke-virtual {p2}, Lcom/amazonaws/auth/AWS4Signer$HeaderSigningResult;->getKSigning()[B

    move-result-object v10

    .line 56
    .local v10, "kSigning":[B
    nop

    .line 57
    invoke-virtual {p2}, Lcom/amazonaws/auth/AWS4Signer$HeaderSigningResult;->getSignature()[B

    move-result-object v1

    .line 56
    invoke-static {v1}, Lcom/amazonaws/util/BinaryUtils;->toHex([B)Ljava/lang/String;

    move-result-object v11

    .line 58
    .local v11, "signature":Ljava/lang/String;
    new-instance v12, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;

    move-object v1, v12

    move-object v2, v0

    move-object v3, v10

    move-object v4, v8

    move-object v5, v9

    move-object v6, v11

    move-object v7, p0

    invoke-direct/range {v1 .. v7}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;-><init>(Ljava/io/InputStream;[BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/auth/AWS4Signer;)V

    .line 60
    .local v1, "chunkEncodededStream":Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;
    invoke-interface {p1, v1}, Lcom/amazonaws/Request;->setContent(Ljava/io/InputStream;)V

    .line 62
    .end local v0    # "payloadStream":Ljava/io/InputStream;
    .end local v1    # "chunkEncodededStream":Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;
    .end local v8    # "dateTime":Ljava/lang/String;
    .end local v9    # "keyPath":Ljava/lang/String;
    .end local v10    # "kSigning":[B
    .end local v11    # "signature":Ljava/lang/String;
    :cond_0
    return-void
.end method
