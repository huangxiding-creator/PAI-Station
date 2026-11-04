.class public Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;
.super Lokhttp3/RequestBody;
.source "ProgressTouchableRequestBody.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/alibaba/sdk/android/oss/model/OSSRequest;",
        ">",
        "Lokhttp3/RequestBody;"
    }
.end annotation


# static fields
.field private static final SEGMENT_SIZE:I = 0x800


# instance fields
.field private callback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

.field private contentLength:J

.field private contentType:Ljava/lang/String;

.field private inputStream:Ljava/io/InputStream;

.field private request:Lcom/alibaba/sdk/android/oss/model/OSSRequest;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/io/InputStream;JLjava/lang/String;Lcom/alibaba/sdk/android/oss/network/ExecutionContext;)V
    .locals 1
    .param p1, "input"    # Ljava/io/InputStream;
    .param p2, "contentLength"    # J
    .param p4, "contentType"    # Ljava/lang/String;
    .param p5, "context"    # Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    .line 28
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;, "Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody<TT;>;"
    invoke-direct {p0}, Lokhttp3/RequestBody;-><init>()V

    .line 29
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->inputStream:Ljava/io/InputStream;

    .line 30
    iput-object p4, p0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->contentType:Ljava/lang/String;

    .line 31
    iput-wide p2, p0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->contentLength:J

    .line 32
    invoke-virtual {p5}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getProgressCallback()Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->callback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    .line 33
    invoke-virtual {p5}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getRequest()Lcom/alibaba/sdk/android/oss/model/OSSRequest;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->request:Lcom/alibaba/sdk/android/oss/model/OSSRequest;

    .line 34
    return-void
.end method


# virtual methods
.method public contentLength()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 43
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;, "Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody<TT;>;"
    iget-wide v0, p0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->contentLength:J

    return-wide v0
.end method

.method public contentType()Lokhttp3/MediaType;
    .locals 1

    .line 38
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;, "Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody<TT;>;"
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->contentType:Ljava/lang/String;

    invoke-static {v0}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v0

    return-object v0
.end method

.method public writeTo(Lokio/BufferedSink;)V
    .locals 17
    .param p1, "sink"    # Lokio/BufferedSink;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 48
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;, "Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody<TT;>;"
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->inputStream:Ljava/io/InputStream;

    invoke-static {v1}, Lokio/Okio;->source(Ljava/io/InputStream;)Lokio/Source;

    move-result-object v1

    .line 49
    .local v1, "source":Lokio/Source;
    const-wide/16 v2, 0x0

    .line 52
    .local v2, "total":J
    :cond_0
    :goto_0
    iget-wide v4, v0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->contentLength:J

    cmp-long v4, v2, v4

    if-gez v4, :cond_2

    .line 53
    iget-wide v4, v0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->contentLength:J

    sub-long/2addr v4, v2

    .line 54
    .local v4, "remain":J
    const-wide/16 v6, 0x800

    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v6

    .line 56
    .local v6, "toRead":J
    invoke-interface/range {p1 .. p1}, Lokio/BufferedSink;->buffer()Lokio/Buffer;

    move-result-object v8

    invoke-interface {v1, v8, v6, v7}, Lokio/Source;->read(Lokio/Buffer;J)J

    move-result-wide v8

    .line 57
    .local v8, "read":J
    const-wide/16 v10, -0x1

    cmp-long v10, v8, v10

    if-nez v10, :cond_1

    .line 58
    goto :goto_1

    .line 61
    :cond_1
    add-long/2addr v2, v8

    .line 62
    invoke-interface/range {p1 .. p1}, Lokio/BufferedSink;->flush()V

    .line 64
    iget-object v10, v0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->callback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    if-eqz v10, :cond_0

    const-wide/16 v10, 0x0

    cmp-long v10, v2, v10

    if-eqz v10, :cond_0

    .line 65
    iget-object v11, v0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->callback:Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;

    iget-object v12, v0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->request:Lcom/alibaba/sdk/android/oss/model/OSSRequest;

    iget-wide v13, v0, Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;->contentLength:J

    move-wide v15, v13

    move-wide v13, v2

    invoke-interface/range {v11 .. v16}, Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;->onProgress(Ljava/lang/Object;JJ)V

    goto :goto_0

    .line 68
    .end local v4    # "remain":J
    .end local v6    # "toRead":J
    .end local v8    # "read":J
    :cond_2
    :goto_1
    if-eqz v1, :cond_3

    .line 69
    invoke-interface {v1}, Lokio/Source;->close()V

    .line 71
    :cond_3
    return-void
.end method
