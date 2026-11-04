.class public Lcom/amazonaws/http/JsonResponseHandler;
.super Ljava/lang/Object;
.source "JsonResponseHandler.java"

# interfaces
.implements Lcom/amazonaws/http/HttpResponseHandler;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/amazonaws/http/HttpResponseHandler<",
        "Lcom/amazonaws/AmazonWebServiceResponse<",
        "TT;>;>;"
    }
.end annotation


# static fields
.field private static final log:Lcom/amazonaws/logging/Log;


# instance fields
.field public needsConnectionLeftOpen:Z

.field private responseUnmarshaller:Lcom/amazonaws/transform/Unmarshaller;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/amazonaws/transform/Unmarshaller<",
            "TT;",
            "Lcom/amazonaws/transform/JsonUnmarshallerContext;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 53
    const-string v0, "com.amazonaws.request"

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/String;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/http/JsonResponseHandler;->log:Lcom/amazonaws/logging/Log;

    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/transform/Unmarshaller;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/transform/Unmarshaller<",
            "TT;",
            "Lcom/amazonaws/transform/JsonUnmarshallerContext;",
            ">;)V"
        }
    .end annotation

    .line 67
    .local p0, "this":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<TT;>;"
    .local p1, "responseUnmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<TT;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 56
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/amazonaws/http/JsonResponseHandler;->needsConnectionLeftOpen:Z

    .line 68
    iput-object p1, p0, Lcom/amazonaws/http/JsonResponseHandler;->responseUnmarshaller:Lcom/amazonaws/transform/Unmarshaller;

    .line 76
    iget-object v0, p0, Lcom/amazonaws/http/JsonResponseHandler;->responseUnmarshaller:Lcom/amazonaws/transform/Unmarshaller;

    if-nez v0, :cond_0

    .line 77
    new-instance v0, Lcom/amazonaws/transform/VoidJsonUnmarshaller;

    invoke-direct {v0}, Lcom/amazonaws/transform/VoidJsonUnmarshaller;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/http/JsonResponseHandler;->responseUnmarshaller:Lcom/amazonaws/transform/Unmarshaller;

    .line 79
    :cond_0
    return-void
.end method


# virtual methods
.method public handle(Lcom/amazonaws/http/HttpResponse;)Lcom/amazonaws/AmazonWebServiceResponse;
    .locals 17
    .param p1, "response"    # Lcom/amazonaws/http/HttpResponse;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/http/HttpResponse;",
            ")",
            "Lcom/amazonaws/AmazonWebServiceResponse<",
            "TT;>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 86
    .local p0, "this":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<TT;>;"
    move-object/from16 v1, p0

    const-string v2, "Error closing json parser"

    sget-object v0, Lcom/amazonaws/http/JsonResponseHandler;->log:Lcom/amazonaws/logging/Log;

    const-string v3, "Parsing service response JSON"

    invoke-interface {v0, v3}, Lcom/amazonaws/logging/Log;->trace(Ljava/lang/Object;)V

    .line 88
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/http/HttpResponse;->getHeaders()Ljava/util/Map;

    move-result-object v0

    const-string/jumbo v3, "x-amz-crc32"

    invoke-interface {v0, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v3, v0

    check-cast v3, Ljava/lang/String;

    .line 92
    .local v3, "crc32Checksum":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/http/HttpResponse;->getRawContent()Ljava/io/InputStream;

    move-result-object v0

    .line 93
    .local v0, "content":Ljava/io/InputStream;
    if-nez v0, :cond_0

    .line 95
    new-instance v4, Ljava/io/ByteArrayInputStream;

    const-string/jumbo v5, "{}"

    sget-object v6, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    invoke-virtual {v5, v6}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    move-object v0, v4

    .line 98
    :cond_0
    sget-object v4, Lcom/amazonaws/http/JsonResponseHandler;->log:Lcom/amazonaws/logging/Log;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "CRC32Checksum = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 99
    sget-object v4, Lcom/amazonaws/http/JsonResponseHandler;->log:Lcom/amazonaws/logging/Log;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "content encoding = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/http/HttpResponse;->getHeaders()Ljava/util/Map;

    move-result-object v6

    const-string v7, "Content-Encoding"

    invoke-interface {v6, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 101
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/http/HttpResponse;->getHeaders()Ljava/util/Map;

    move-result-object v4

    invoke-interface {v4, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    const-string v5, "gzip"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    .line 103
    .local v4, "isGzipEncoded":Z
    const/4 v5, 0x0

    .line 109
    .local v5, "checksumCalculatingInputStream":Lcom/amazonaws/util/CRC32ChecksumCalculatingInputStream;
    if-eqz v3, :cond_1

    .line 110
    new-instance v6, Lcom/amazonaws/util/CRC32ChecksumCalculatingInputStream;

    invoke-direct {v6, v0}, Lcom/amazonaws/util/CRC32ChecksumCalculatingInputStream;-><init>(Ljava/io/InputStream;)V

    move-object v5, v6

    .line 111
    move-object v0, v5

    .line 114
    :cond_1
    if-eqz v4, :cond_2

    .line 115
    new-instance v6, Ljava/util/zip/GZIPInputStream;

    invoke-direct {v6, v0}, Ljava/util/zip/GZIPInputStream;-><init>(Ljava/io/InputStream;)V

    move-object v0, v6

    goto :goto_0

    .line 114
    :cond_2
    move-object v6, v0

    .line 118
    .end local v0    # "content":Ljava/io/InputStream;
    .local v6, "content":Ljava/io/InputStream;
    :goto_0
    new-instance v0, Ljava/io/InputStreamReader;

    sget-object v7, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    invoke-direct {v0, v6, v7}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    invoke-static {v0}, Lcom/amazonaws/util/json/JsonUtils;->getJsonReader(Ljava/io/Reader;)Lcom/amazonaws/util/json/AwsJsonReader;

    move-result-object v7

    .line 122
    .local v7, "jsonReader":Lcom/amazonaws/util/json/AwsJsonReader;
    :try_start_0
    new-instance v0, Lcom/amazonaws/AmazonWebServiceResponse;

    invoke-direct {v0}, Lcom/amazonaws/AmazonWebServiceResponse;-><init>()V

    move-object v8, v0

    .line 123
    .local v8, "awsResponse":Lcom/amazonaws/AmazonWebServiceResponse;, "Lcom/amazonaws/AmazonWebServiceResponse<TT;>;"
    new-instance v0, Lcom/amazonaws/transform/JsonUnmarshallerContext;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    move-object/from16 v9, p1

    :try_start_1
    invoke-direct {v0, v7, v9}, Lcom/amazonaws/transform/JsonUnmarshallerContext;-><init>(Lcom/amazonaws/util/json/AwsJsonReader;Lcom/amazonaws/http/HttpResponse;)V

    move-object v10, v0

    .line 126
    .local v10, "unmarshallerContext":Lcom/amazonaws/transform/JsonUnmarshallerContext;
    iget-object v0, v1, Lcom/amazonaws/http/JsonResponseHandler;->responseUnmarshaller:Lcom/amazonaws/transform/Unmarshaller;

    invoke-interface {v0, v10}, Lcom/amazonaws/transform/Unmarshaller;->unmarshall(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v11, v0

    .line 128
    .local v11, "result":Ljava/lang/Object;, "TT;"
    if-eqz v5, :cond_4

    .line 129
    invoke-static {v3}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v12

    .line 130
    .local v12, "serverSideCRC":J
    invoke-virtual {v5}, Lcom/amazonaws/util/CRC32ChecksumCalculatingInputStream;->getCRC32Checksum()J

    move-result-wide v14

    .line 131
    .local v14, "clientSideCRC":J
    cmp-long v0, v14, v12

    if-nez v0, :cond_3

    move-object/from16 v16, v3

    goto :goto_1

    .line 132
    :cond_3
    new-instance v0, Lcom/amazonaws/internal/CRC32MismatchException;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-object/from16 v16, v3

    .end local v3    # "crc32Checksum":Ljava/lang/String;
    .local v16, "crc32Checksum":Ljava/lang/String;
    :try_start_2
    const-string v3, "Client calculated crc32 checksum didn\'t match that calculated by server side"

    invoke-direct {v0, v3}, Lcom/amazonaws/internal/CRC32MismatchException;-><init>(Ljava/lang/String;)V

    .end local v4    # "isGzipEncoded":Z
    .end local v5    # "checksumCalculatingInputStream":Lcom/amazonaws/util/CRC32ChecksumCalculatingInputStream;
    .end local v6    # "content":Ljava/io/InputStream;
    .end local v7    # "jsonReader":Lcom/amazonaws/util/json/AwsJsonReader;
    .end local v16    # "crc32Checksum":Ljava/lang/String;
    .end local p1    # "response":Lcom/amazonaws/http/HttpResponse;
    throw v0

    .line 128
    .end local v12    # "serverSideCRC":J
    .end local v14    # "clientSideCRC":J
    .restart local v3    # "crc32Checksum":Ljava/lang/String;
    .restart local v4    # "isGzipEncoded":Z
    .restart local v5    # "checksumCalculatingInputStream":Lcom/amazonaws/util/CRC32ChecksumCalculatingInputStream;
    .restart local v6    # "content":Ljava/io/InputStream;
    .restart local v7    # "jsonReader":Lcom/amazonaws/util/json/AwsJsonReader;
    .restart local p1    # "response":Lcom/amazonaws/http/HttpResponse;
    :cond_4
    move-object/from16 v16, v3

    .line 137
    .end local v3    # "crc32Checksum":Ljava/lang/String;
    .restart local v16    # "crc32Checksum":Ljava/lang/String;
    :goto_1
    invoke-virtual {v8, v11}, Lcom/amazonaws/AmazonWebServiceResponse;->setResult(Ljava/lang/Object;)V

    .line 139
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    move-object v3, v0

    .line 140
    .local v3, "metadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v0, "AWS_REQUEST_ID"

    .line 141
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/http/HttpResponse;->getHeaders()Ljava/util/Map;

    move-result-object v12

    const-string/jumbo v13, "x-amzn-RequestId"

    invoke-interface {v12, v13}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    .line 140
    invoke-interface {v3, v0, v12}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 142
    new-instance v0, Lcom/amazonaws/ResponseMetadata;

    invoke-direct {v0, v3}, Lcom/amazonaws/ResponseMetadata;-><init>(Ljava/util/Map;)V

    invoke-virtual {v8, v0}, Lcom/amazonaws/AmazonWebServiceResponse;->setResponseMetadata(Lcom/amazonaws/ResponseMetadata;)V

    .line 144
    sget-object v0, Lcom/amazonaws/http/JsonResponseHandler;->log:Lcom/amazonaws/logging/Log;

    const-string v12, "Done parsing service response"

    invoke-interface {v0, v12}, Lcom/amazonaws/logging/Log;->trace(Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 145
    nop

    .line 147
    iget-boolean v0, v1, Lcom/amazonaws/http/JsonResponseHandler;->needsConnectionLeftOpen:Z

    if-nez v0, :cond_5

    .line 149
    :try_start_3
    invoke-interface {v7}, Lcom/amazonaws/util/json/AwsJsonReader;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    .line 152
    goto :goto_2

    .line 150
    :catch_0
    move-exception v0

    move-object v12, v0

    move-object v0, v12

    .line 151
    .local v0, "e":Ljava/io/IOException;
    sget-object v12, Lcom/amazonaws/http/JsonResponseHandler;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v12, v2, v0}, Lcom/amazonaws/logging/Log;->warn(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 145
    .end local v0    # "e":Ljava/io/IOException;
    :cond_5
    :goto_2
    return-object v8

    .line 147
    .end local v3    # "metadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v8    # "awsResponse":Lcom/amazonaws/AmazonWebServiceResponse;, "Lcom/amazonaws/AmazonWebServiceResponse<TT;>;"
    .end local v10    # "unmarshallerContext":Lcom/amazonaws/transform/JsonUnmarshallerContext;
    .end local v11    # "result":Ljava/lang/Object;, "TT;"
    :catchall_0
    move-exception v0

    move-object v3, v0

    goto :goto_4

    .end local v16    # "crc32Checksum":Ljava/lang/String;
    .local v3, "crc32Checksum":Ljava/lang/String;
    :catchall_1
    move-exception v0

    goto :goto_3

    :catchall_2
    move-exception v0

    move-object/from16 v9, p1

    :goto_3
    move-object/from16 v16, v3

    move-object v3, v0

    .end local v3    # "crc32Checksum":Ljava/lang/String;
    .restart local v16    # "crc32Checksum":Ljava/lang/String;
    :goto_4
    iget-boolean v0, v1, Lcom/amazonaws/http/JsonResponseHandler;->needsConnectionLeftOpen:Z

    if-nez v0, :cond_6

    .line 149
    :try_start_4
    invoke-interface {v7}, Lcom/amazonaws/util/json/AwsJsonReader;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1

    .line 152
    goto :goto_5

    .line 150
    :catch_1
    move-exception v0

    move-object v8, v0

    move-object v0, v8

    .line 151
    .restart local v0    # "e":Ljava/io/IOException;
    sget-object v8, Lcom/amazonaws/http/JsonResponseHandler;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v8, v2, v0}, Lcom/amazonaws/logging/Log;->warn(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 154
    .end local v0    # "e":Ljava/io/IOException;
    :cond_6
    :goto_5
    throw v3
.end method

.method public bridge synthetic handle(Lcom/amazonaws/http/HttpResponse;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 47
    .local p0, "this":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<TT;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/http/JsonResponseHandler;->handle(Lcom/amazonaws/http/HttpResponse;)Lcom/amazonaws/AmazonWebServiceResponse;

    move-result-object p1

    return-object p1
.end method

.method public needsConnectionLeftOpen()Z
    .locals 1

    .line 177
    .local p0, "this":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<TT;>;"
    iget-boolean v0, p0, Lcom/amazonaws/http/JsonResponseHandler;->needsConnectionLeftOpen:Z

    return v0
.end method

.method protected registerAdditionalMetadataExpressions(Lcom/amazonaws/transform/JsonUnmarshallerContext;)V
    .locals 0
    .param p1, "unmarshallerContext"    # Lcom/amazonaws/transform/JsonUnmarshallerContext;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 166
    .local p0, "this":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<TT;>;"
    return-void
.end method
