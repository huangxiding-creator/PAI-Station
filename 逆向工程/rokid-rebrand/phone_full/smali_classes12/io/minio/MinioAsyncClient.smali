.class public Lio/minio/MinioAsyncClient;
.super Lio/minio/S3Base;
.source "MinioAsyncClient.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/MinioAsyncClient$Builder;
    }
.end annotation


# direct methods
.method protected constructor <init>(Lio/minio/MinioAsyncClient;)V
    .locals 0
    .param p1, "client"    # Lio/minio/MinioAsyncClient;

    .line 158
    invoke-direct {p0, p1}, Lio/minio/S3Base;-><init>(Lio/minio/S3Base;)V

    .line 159
    return-void
.end method

.method private constructor <init>(Lokhttp3/HttpUrl;Ljava/lang/String;ZZZZZLio/minio/credentials/Provider;Lokhttp3/OkHttpClient;)V
    .locals 0
    .param p1, "baseUrl"    # Lokhttp3/HttpUrl;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "isAwsHost"    # Z
    .param p4, "isFipsHost"    # Z
    .param p5, "isAccelerateHost"    # Z
    .param p6, "isDualStackHost"    # Z
    .param p7, "useVirtualStyle"    # Z
    .param p8, "provider"    # Lio/minio/credentials/Provider;
    .param p9, "httpClient"    # Lokhttp3/OkHttpClient;

    .line 145
    invoke-direct/range {p0 .. p9}, Lio/minio/S3Base;-><init>(Lokhttp3/HttpUrl;Ljava/lang/String;ZZZZZLio/minio/credentials/Provider;Lokhttp3/OkHttpClient;)V

    .line 155
    return-void
.end method

.method synthetic constructor <init>(Lokhttp3/HttpUrl;Ljava/lang/String;ZZZZZLio/minio/credentials/Provider;Lokhttp3/OkHttpClient;Lio/minio/MinioAsyncClient$1;)V
    .locals 0
    .param p1, "x0"    # Lokhttp3/HttpUrl;
    .param p2, "x1"    # Ljava/lang/String;
    .param p3, "x2"    # Z
    .param p4, "x3"    # Z
    .param p5, "x4"    # Z
    .param p6, "x5"    # Z
    .param p7, "x6"    # Z
    .param p8, "x7"    # Lio/minio/credentials/Provider;
    .param p9, "x8"    # Lokhttp3/OkHttpClient;
    .param p10, "x9"    # Lio/minio/MinioAsyncClient$1;

    .line 134
    invoke-direct/range {p0 .. p9}, Lio/minio/MinioAsyncClient;-><init>(Lokhttp3/HttpUrl;Ljava/lang/String;ZZZZZLio/minio/credentials/Provider;Lokhttp3/OkHttpClient;)V

    return-void
.end method

.method public static builder()Lio/minio/MinioAsyncClient$Builder;
    .locals 1

    .line 3213
    new-instance v0, Lio/minio/MinioAsyncClient$Builder;

    invoke-direct {v0}, Lio/minio/MinioAsyncClient$Builder;-><init>()V

    return-object v0
.end method

.method private downloadObject(Ljava/lang/String;ZLio/minio/StatObjectResponse;Lio/minio/GetObjectResponse;)V
    .locals 10
    .param p1, "filename"    # Ljava/lang/String;
    .param p2, "overwrite"    # Z
    .param p3, "statObjectResponse"    # Lio/minio/StatObjectResponse;
    .param p4, "getObjectResponse"    # Lio/minio/GetObjectResponse;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 265
    const/4 v0, 0x0

    .line 267
    .local v0, "os":Ljava/io/OutputStream;
    const/4 v1, 0x0

    :try_start_0
    new-array v2, v1, [Ljava/lang/String;

    invoke-static {p1, v2}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v2

    .line 268
    .local v2, "filePath":Ljava/nio/file/Path;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 269
    invoke-virtual {p3}, Lio/minio/StatObjectResponse;->etag()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".part.minio"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 270
    .local v3, "tempFilename":Ljava/lang/String;
    new-array v4, v1, [Ljava/lang/String;

    invoke-static {v3, v4}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v4

    .line 271
    .local v4, "tempFilePath":Ljava/nio/file/Path;
    new-array v5, v1, [Ljava/nio/file/LinkOption;

    invoke-static {v4, v5}, Ljava/nio/file/Files;->exists(Ljava/nio/file/Path;[Ljava/nio/file/LinkOption;)Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-static {v4}, Ljava/nio/file/Files;->delete(Ljava/nio/file/Path;)V

    .line 272
    :cond_0
    const/4 v5, 0x2

    new-array v5, v5, [Ljava/nio/file/OpenOption;

    sget-object v6, Ljava/nio/file/StandardOpenOption;->CREATE:Ljava/nio/file/StandardOpenOption;

    aput-object v6, v5, v1

    sget-object v6, Ljava/nio/file/StandardOpenOption;->WRITE:Ljava/nio/file/StandardOpenOption;

    const/4 v7, 0x1

    aput-object v6, v5, v7

    invoke-static {v4, v5}, Ljava/nio/file/Files;->newOutputStream(Ljava/nio/file/Path;[Ljava/nio/file/OpenOption;)Ljava/io/OutputStream;

    move-result-object v5

    move-object v0, v5

    .line 273
    invoke-static {p4, v0}, Lcom/google/common/io/ByteStreams;->copy(Ljava/io/InputStream;Ljava/io/OutputStream;)J

    move-result-wide v5

    .line 274
    .local v5, "bytesWritten":J
    invoke-virtual {p3}, Lio/minio/StatObjectResponse;->size()J

    move-result-wide v8

    cmp-long v8, v5, v8

    if-nez v8, :cond_3

    .line 283
    if-eqz p2, :cond_1

    .line 284
    new-array v7, v7, [Ljava/nio/file/CopyOption;

    sget-object v8, Ljava/nio/file/StandardCopyOption;->REPLACE_EXISTING:Ljava/nio/file/StandardCopyOption;

    aput-object v8, v7, v1

    invoke-static {v4, v2, v7}, Ljava/nio/file/Files;->move(Ljava/nio/file/Path;Ljava/nio/file/Path;[Ljava/nio/file/CopyOption;)Ljava/nio/file/Path;

    goto :goto_0

    .line 286
    :cond_1
    new-array v1, v1, [Ljava/nio/file/CopyOption;

    invoke-static {v4, v2, v1}, Ljava/nio/file/Files;->move(Ljava/nio/file/Path;Ljava/nio/file/Path;[Ljava/nio/file/CopyOption;)Ljava/nio/file/Path;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 289
    .end local v2    # "filePath":Ljava/nio/file/Path;
    .end local v3    # "tempFilename":Ljava/lang/String;
    .end local v4    # "tempFilePath":Ljava/nio/file/Path;
    .end local v5    # "bytesWritten":J
    :goto_0
    invoke-virtual {p4}, Lio/minio/GetObjectResponse;->close()V

    .line 290
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    .line 292
    :cond_2
    return-void

    .line 275
    .restart local v2    # "filePath":Ljava/nio/file/Path;
    .restart local v3    # "tempFilename":Ljava/lang/String;
    .restart local v4    # "tempFilePath":Ljava/nio/file/Path;
    .restart local v5    # "bytesWritten":J
    :cond_3
    :try_start_1
    new-instance v1, Ljava/io/IOException;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ": unexpected data written.  expected = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    .line 278
    invoke-virtual {p3}, Lio/minio/StatObjectResponse;->size()J

    move-result-wide v8

    invoke-virtual {v7, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", written = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v1, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local v0    # "os":Ljava/io/OutputStream;
    .end local p1    # "filename":Ljava/lang/String;
    .end local p2    # "overwrite":Z
    .end local p3    # "statObjectResponse":Lio/minio/StatObjectResponse;
    .end local p4    # "getObjectResponse":Lio/minio/GetObjectResponse;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 289
    .end local v2    # "filePath":Ljava/nio/file/Path;
    .end local v3    # "tempFilename":Ljava/lang/String;
    .end local v4    # "tempFilePath":Ljava/nio/file/Path;
    .end local v5    # "bytesWritten":J
    .restart local v0    # "os":Ljava/io/OutputStream;
    .restart local p1    # "filename":Ljava/lang/String;
    .restart local p2    # "overwrite":Z
    .restart local p3    # "statObjectResponse":Lio/minio/StatObjectResponse;
    .restart local p4    # "getObjectResponse":Lio/minio/GetObjectResponse;
    :catchall_0
    move-exception v1

    invoke-virtual {p4}, Lio/minio/GetObjectResponse;->close()V

    .line 290
    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    .line 291
    :cond_4
    throw v1
.end method

.method static synthetic lambda$bucketExists$25(Ljava/lang/Throwable;)Lokhttp3/Response;
    .locals 3
    .param p0, "e"    # Ljava/lang/Throwable;

    .line 1393
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 1395
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_0

    .line 1396
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 1399
    :cond_0
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_1

    .line 1400
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 1403
    :cond_1
    instance-of v1, v0, Lio/minio/errors/ErrorResponseException;

    if-eqz v1, :cond_2

    .line 1404
    move-object v1, v0

    check-cast v1, Lio/minio/errors/ErrorResponseException;

    invoke-virtual {v1}, Lio/minio/errors/ErrorResponseException;->errorResponse()Lio/minio/messages/ErrorResponse;

    move-result-object v1

    invoke-virtual {v1}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v1

    const-string v2, "NoSuchBucket"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1405
    const/4 v1, 0x0

    return-object v1

    .line 1408
    :cond_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$bucketExists$26(Lokhttp3/Response;)Ljava/lang/Boolean;
    .locals 1
    .param p0, "response"    # Lokhttp3/Response;

    .line 1413
    if-eqz p0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    :try_start_0
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1415
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1413
    :cond_1
    return-object v0

    .line 1415
    :catchall_0
    move-exception v0

    if-eqz p0, :cond_2

    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1416
    :cond_2
    throw v0
.end method

.method static synthetic lambda$composeObject$10([ILio/minio/ComposeObjectArgs;Ljava/lang/Integer;)Ljava/lang/Boolean;
    .locals 3
    .param p0, "partCount"    # [I
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;
    .param p2, "count"    # Ljava/lang/Integer;

    .line 638
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/4 v1, 0x0

    aput v0, p0, v1

    .line 639
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    .line 640
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->sources()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ComposeSource;

    invoke-virtual {v0}, Lio/minio/ComposeSource;->offset()Ljava/lang/Long;

    move-result-object v0

    if-nez v0, :cond_0

    .line 641
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->sources()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ComposeSource;

    invoke-virtual {v0}, Lio/minio/ComposeSource;->length()Ljava/lang/Long;

    move-result-object v0

    if-nez v0, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    nop

    .line 639
    :goto_0
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method

.method static synthetic lambda$composeObject$14([Ljava/lang/String;Lio/minio/CreateMultipartUploadResponse;)Ljava/lang/String;
    .locals 2
    .param p0, "uploadIdCopy"    # [Ljava/lang/String;
    .param p1, "createMultipartUploadResponse"    # Lio/minio/CreateMultipartUploadResponse;

    .line 692
    invoke-virtual {p1}, Lio/minio/CreateMultipartUploadResponse;->result()Lio/minio/messages/InitiateMultipartUploadResult;

    move-result-object v0

    invoke-virtual {v0}, Lio/minio/messages/InitiateMultipartUploadResult;->uploadId()Ljava/lang/String;

    move-result-object v0

    .line 693
    .local v0, "uploadId":Ljava/lang/String;
    const/4 v1, 0x0

    aput-object v0, p0, v1

    .line 694
    return-object v0
.end method

.method static synthetic lambda$composeObject$15([I)[Lio/minio/messages/Part;
    .locals 1
    .param p0, "partCount"    # [I

    .line 708
    const/4 v0, 0x0

    aget v0, p0, v0

    new-array v0, v0, [Lio/minio/messages/Part;

    return-object v0
.end method

.method static synthetic lambda$copyObject$3(Lio/minio/CopyObjectArgs;)Ljava/lang/Boolean;
    .locals 1
    .param p0, "args"    # Lio/minio/CopyObjectArgs;

    .line 457
    invoke-virtual {p0}, Lio/minio/CopyObjectArgs;->source()Lio/minio/CopySource;

    move-result-object v0

    invoke-virtual {v0}, Lio/minio/CopySource;->offset()Ljava/lang/Long;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lio/minio/CopyObjectArgs;->source()Lio/minio/CopySource;

    move-result-object v0

    invoke-virtual {v0}, Lio/minio/CopySource;->length()Ljava/lang/Long;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method

.method static synthetic lambda$copyObject$5(Lio/minio/StatObjectResponse;)Ljava/lang/Long;
    .locals 2
    .param p0, "stat"    # Lio/minio/StatObjectResponse;

    .line 474
    if-nez p0, :cond_0

    const-wide/16 v0, -0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lio/minio/StatObjectResponse;->size()J

    move-result-wide v0

    :goto_0
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    return-object v0
.end method

.method static synthetic lambda$copyObject$7(Lio/minio/CopyObjectArgs;Lokhttp3/Response;)Lio/minio/ObjectWriteResponse;
    .locals 9
    .param p0, "args"    # Lio/minio/CopyObjectArgs;
    .param p1, "response"    # Lokhttp3/Response;

    .line 528
    :try_start_0
    const-class v0, Lio/minio/messages/CopyObjectResult;

    .line 529
    invoke-virtual {p1}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/CopyObjectResult;

    .line 530
    .local v0, "result":Lio/minio/messages/CopyObjectResult;
    new-instance v8, Lio/minio/ObjectWriteResponse;

    .line 531
    invoke-virtual {p1}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    .line 532
    invoke-virtual {p0}, Lio/minio/CopyObjectArgs;->bucket()Ljava/lang/String;

    move-result-object v3

    .line 533
    invoke-virtual {p0}, Lio/minio/CopyObjectArgs;->region()Ljava/lang/String;

    move-result-object v4

    .line 534
    invoke-virtual {p0}, Lio/minio/CopyObjectArgs;->object()Ljava/lang/String;

    move-result-object v5

    .line 535
    invoke-virtual {v0}, Lio/minio/messages/CopyObjectResult;->etag()Ljava/lang/String;

    move-result-object v6

    const-string/jumbo v1, "x-amz-version-id"

    .line 536
    invoke-virtual {p1, v1}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    move-object v1, v8

    invoke-direct/range {v1 .. v7}, Lio/minio/ObjectWriteResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 540
    invoke-virtual {p1}, Lokhttp3/Response;->close()V

    .line 530
    return-object v8

    .line 540
    .end local v0    # "result":Lio/minio/messages/CopyObjectResult;
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 537
    :catch_0
    move-exception v0

    .line 538
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "args":Lio/minio/CopyObjectArgs;
    .end local p1    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 540
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "args":Lio/minio/CopyObjectArgs;
    .restart local p1    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p1}, Lokhttp3/Response;->close()V

    .line 541
    throw v0
.end method

.method static synthetic lambda$deleteBucketEncryption$62(Ljava/lang/Throwable;)Lokhttp3/Response;
    .locals 3
    .param p0, "e"    # Ljava/lang/Throwable;

    .line 2830
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2832
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_0

    .line 2833
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2836
    :cond_0
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_1

    .line 2837
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2840
    :cond_1
    instance-of v1, v0, Lio/minio/errors/ErrorResponseException;

    if-eqz v1, :cond_2

    .line 2841
    move-object v1, v0

    check-cast v1, Lio/minio/errors/ErrorResponseException;

    .line 2842
    invoke-virtual {v1}, Lio/minio/errors/ErrorResponseException;->errorResponse()Lio/minio/messages/ErrorResponse;

    move-result-object v1

    .line 2843
    invoke-virtual {v1}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v1

    .line 2844
    const-string v2, "ServerSideEncryptionConfigurationNotFoundError"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 2845
    const/4 v1, 0x0

    return-object v1

    .line 2848
    :cond_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$deleteBucketEncryption$63(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2852
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2853
    :cond_0
    return-void
.end method

.method static synthetic lambda$deleteBucketLifecycle$49(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2281
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$deleteBucketNotification$54(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2443
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$deleteBucketPolicy$46(Ljava/lang/Throwable;)Lokhttp3/Response;
    .locals 3
    .param p0, "e"    # Ljava/lang/Throwable;

    .line 2196
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2198
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_0

    .line 2199
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2202
    :cond_0
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_1

    .line 2203
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2206
    :cond_1
    instance-of v1, v0, Lio/minio/errors/ErrorResponseException;

    if-eqz v1, :cond_2

    .line 2207
    move-object v1, v0

    check-cast v1, Lio/minio/errors/ErrorResponseException;

    .line 2208
    invoke-virtual {v1}, Lio/minio/errors/ErrorResponseException;->errorResponse()Lio/minio/messages/ErrorResponse;

    move-result-object v1

    .line 2209
    invoke-virtual {v1}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v1

    .line 2210
    const-string v2, "NoSuchBucketPolicy"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 2211
    const/4 v1, 0x0

    return-object v1

    .line 2214
    :cond_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$deleteBucketPolicy$47(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2218
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2219
    :cond_0
    return-void
.end method

.method static synthetic lambda$deleteBucketReplication$58(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2582
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$deleteBucketTags$67(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2960
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$deleteObjectLockConfiguration$31(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 1607
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$deleteObjectTags$70(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 3057
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$disableObjectLegalHold$37(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 1809
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$downloadObject$2(Ljava/lang/Object;)V
    .locals 0
    .param p0, "nullValue"    # Ljava/lang/Object;

    .line 336
    return-void
.end method

.method static synthetic lambda$enableObjectLegalHold$36(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 1778
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$getBucketEncryption$60(Ljava/lang/Throwable;)Lokhttp3/Response;
    .locals 3
    .param p0, "e"    # Ljava/lang/Throwable;

    .line 2773
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2775
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_0

    .line 2776
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2779
    :cond_0
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_1

    .line 2780
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2783
    :cond_1
    instance-of v1, v0, Lio/minio/errors/ErrorResponseException;

    if-eqz v1, :cond_2

    .line 2784
    move-object v1, v0

    check-cast v1, Lio/minio/errors/ErrorResponseException;

    .line 2785
    invoke-virtual {v1}, Lio/minio/errors/ErrorResponseException;->errorResponse()Lio/minio/messages/ErrorResponse;

    move-result-object v1

    .line 2786
    invoke-virtual {v1}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v1

    .line 2787
    const-string v2, "ServerSideEncryptionConfigurationNotFoundError"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 2788
    const/4 v1, 0x0

    return-object v1

    .line 2791
    :cond_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$getBucketEncryption$61(Lokhttp3/Response;)Lio/minio/messages/SseConfiguration;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .line 2795
    if-nez p0, :cond_0

    new-instance v0, Lio/minio/messages/SseConfiguration;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lio/minio/messages/SseConfiguration;-><init>(Lio/minio/messages/SseConfigurationRule;)V

    return-object v0

    .line 2797
    :cond_0
    :try_start_0
    const-class v0, Lio/minio/messages/SseConfiguration;

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/SseConfiguration;
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2801
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2797
    return-object v0

    .line 2801
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 2798
    :catch_0
    move-exception v0

    .line 2799
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2801
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2802
    throw v0
.end method

.method static synthetic lambda$getBucketLifecycle$50(Ljava/lang/Throwable;)Lokhttp3/Response;
    .locals 3
    .param p0, "e"    # Ljava/lang/Throwable;

    .line 2310
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2312
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_0

    .line 2313
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2316
    :cond_0
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_1

    .line 2317
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2320
    :cond_1
    instance-of v1, v0, Lio/minio/errors/ErrorResponseException;

    if-eqz v1, :cond_2

    .line 2321
    move-object v1, v0

    check-cast v1, Lio/minio/errors/ErrorResponseException;

    .line 2322
    invoke-virtual {v1}, Lio/minio/errors/ErrorResponseException;->errorResponse()Lio/minio/messages/ErrorResponse;

    move-result-object v1

    .line 2323
    invoke-virtual {v1}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v1

    .line 2324
    const-string v2, "NoSuchLifecycleConfiguration"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 2325
    const/4 v1, 0x0

    return-object v1

    .line 2328
    :cond_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$getBucketLifecycle$51(Lokhttp3/Response;)Lio/minio/messages/LifecycleConfiguration;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .line 2332
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 2334
    :cond_0
    :try_start_0
    const-class v0, Lio/minio/messages/LifecycleConfiguration;

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/LifecycleConfiguration;
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2338
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2334
    return-object v0

    .line 2338
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 2335
    :catch_0
    move-exception v0

    .line 2336
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2338
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2339
    throw v0
.end method

.method static synthetic lambda$getBucketNotification$52(Lokhttp3/Response;)Lio/minio/messages/NotificationConfiguration;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .line 2370
    :try_start_0
    const-class v0, Lio/minio/messages/NotificationConfiguration;

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/NotificationConfiguration;
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2374
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2370
    return-object v0

    .line 2374
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 2371
    :catch_0
    move-exception v0

    .line 2372
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2374
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2375
    throw v0
.end method

.method static synthetic lambda$getBucketPolicy$43(Ljava/lang/Throwable;)Lokhttp3/Response;
    .locals 3
    .param p0, "e"    # Ljava/lang/Throwable;

    .line 2061
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2063
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_0

    .line 2064
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2067
    :cond_0
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_1

    .line 2068
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2071
    :cond_1
    instance-of v1, v0, Lio/minio/errors/ErrorResponseException;

    if-eqz v1, :cond_2

    .line 2072
    move-object v1, v0

    check-cast v1, Lio/minio/errors/ErrorResponseException;

    .line 2073
    invoke-virtual {v1}, Lio/minio/errors/ErrorResponseException;->errorResponse()Lio/minio/messages/ErrorResponse;

    move-result-object v1

    .line 2074
    invoke-virtual {v1}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v1

    .line 2075
    const-string v2, "NoSuchBucketPolicy"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 2076
    const/4 v1, 0x0

    return-object v1

    .line 2079
    :cond_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$getBucketPolicy$44(Lio/minio/GetBucketPolicyArgs;Lokhttp3/Response;)Ljava/lang/String;
    .locals 6
    .param p0, "args"    # Lio/minio/GetBucketPolicyArgs;
    .param p1, "response"    # Lokhttp3/Response;

    .line 2083
    if-nez p1, :cond_0

    const-string v0, ""

    return-object v0

    .line 2085
    :cond_0
    const/16 v0, 0x5000

    :try_start_0
    new-array v1, v0, [B

    .line 2086
    .local v1, "buf":[B
    const/4 v2, 0x0

    .line 2087
    .local v2, "bytesRead":I
    invoke-virtual {p1}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v3

    invoke-virtual {v3}, Lokhttp3/ResponseBody;->byteStream()Ljava/io/InputStream;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v1, v4, v0}, Ljava/io/InputStream;->read([BII)I

    move-result v3

    move v2, v3

    .line 2088
    if-ltz v2, :cond_4

    .line 2095
    if-ne v2, v0, :cond_3

    .line 2096
    const/4 v0, 0x0

    .line 2097
    .local v0, "byteRead":I
    :goto_0
    if-nez v0, :cond_3

    .line 2098
    invoke-virtual {p1}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v3

    invoke-virtual {v3}, Lokhttp3/ResponseBody;->byteStream()Ljava/io/InputStream;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/InputStream;->read()I

    move-result v3

    move v0, v3

    .line 2099
    if-gez v0, :cond_1

    .line 2100
    goto :goto_1

    .line 2103
    :cond_1
    if-gtz v0, :cond_2

    goto :goto_0

    .line 2104
    :cond_2
    new-instance v3, Ljava/util/concurrent/CompletionException;

    new-instance v4, Lio/minio/errors/BucketPolicyTooLargeException;

    .line 2105
    invoke-virtual {p0}, Lio/minio/GetBucketPolicyArgs;->bucket()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Lio/minio/errors/BucketPolicyTooLargeException;-><init>(Ljava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "args":Lio/minio/GetBucketPolicyArgs;
    .end local p1    # "response":Lokhttp3/Response;
    throw v3

    .line 2110
    .end local v0    # "byteRead":I
    .restart local p0    # "args":Lio/minio/GetBucketPolicyArgs;
    .restart local p1    # "response":Lokhttp3/Response;
    :cond_3
    :goto_1
    new-instance v0, Ljava/lang/String;

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v0, v1, v4, v2, v3}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2114
    invoke-virtual {p1}, Lokhttp3/Response;->close()V

    .line 2110
    return-object v0

    .line 2089
    :cond_4
    :try_start_1
    new-instance v0, Ljava/util/concurrent/CompletionException;

    new-instance v3, Ljava/io/IOException;

    const-string/jumbo v4, "unexpected EOF when reading bucket policy"

    invoke-direct {v3, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v3}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "args":Lio/minio/GetBucketPolicyArgs;
    .end local p1    # "response":Lokhttp3/Response;
    throw v0
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2114
    .end local v1    # "buf":[B
    .end local v2    # "bytesRead":I
    .restart local p0    # "args":Lio/minio/GetBucketPolicyArgs;
    .restart local p1    # "response":Lokhttp3/Response;
    :catchall_0
    move-exception v0

    goto :goto_2

    .line 2111
    :catch_0
    move-exception v0

    .line 2112
    .local v0, "e":Ljava/io/IOException;
    :try_start_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "args":Lio/minio/GetBucketPolicyArgs;
    .end local p1    # "response":Lokhttp3/Response;
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 2114
    .end local v0    # "e":Ljava/io/IOException;
    .restart local p0    # "args":Lio/minio/GetBucketPolicyArgs;
    .restart local p1    # "response":Lokhttp3/Response;
    :goto_2
    invoke-virtual {p1}, Lokhttp3/Response;->close()V

    .line 2115
    throw v0
.end method

.method static synthetic lambda$getBucketReplication$55(Ljava/lang/Throwable;)Lokhttp3/Response;
    .locals 3
    .param p0, "e"    # Ljava/lang/Throwable;

    .line 2472
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2474
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_0

    .line 2475
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2478
    :cond_0
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_1

    .line 2479
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2482
    :cond_1
    instance-of v1, v0, Lio/minio/errors/ErrorResponseException;

    if-eqz v1, :cond_2

    .line 2483
    move-object v1, v0

    check-cast v1, Lio/minio/errors/ErrorResponseException;

    .line 2484
    invoke-virtual {v1}, Lio/minio/errors/ErrorResponseException;->errorResponse()Lio/minio/messages/ErrorResponse;

    move-result-object v1

    .line 2485
    invoke-virtual {v1}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v1

    .line 2486
    const-string v2, "ReplicationConfigurationNotFoundError"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 2487
    const/4 v1, 0x0

    return-object v1

    .line 2490
    :cond_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$getBucketReplication$56(Lokhttp3/Response;)Lio/minio/messages/ReplicationConfiguration;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .line 2494
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 2496
    :cond_0
    :try_start_0
    const-class v0, Lio/minio/messages/ReplicationConfiguration;

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ReplicationConfiguration;
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2500
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2496
    return-object v0

    .line 2500
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 2497
    :catch_0
    move-exception v0

    .line 2498
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2500
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2501
    throw v0
.end method

.method static synthetic lambda$getBucketTags$64(Ljava/lang/Throwable;)Lokhttp3/Response;
    .locals 3
    .param p0, "e"    # Ljava/lang/Throwable;

    .line 2880
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2882
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_0

    .line 2883
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2886
    :cond_0
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_1

    .line 2887
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2890
    :cond_1
    instance-of v1, v0, Lio/minio/errors/ErrorResponseException;

    if-eqz v1, :cond_2

    .line 2891
    move-object v1, v0

    check-cast v1, Lio/minio/errors/ErrorResponseException;

    invoke-virtual {v1}, Lio/minio/errors/ErrorResponseException;->errorResponse()Lio/minio/messages/ErrorResponse;

    move-result-object v1

    invoke-virtual {v1}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v1

    const-string v2, "NoSuchTagSet"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 2892
    const/4 v1, 0x0

    return-object v1

    .line 2895
    :cond_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$getBucketTags$65(Lokhttp3/Response;)Lio/minio/messages/Tags;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .line 2899
    if-nez p0, :cond_0

    new-instance v0, Lio/minio/messages/Tags;

    invoke-direct {v0}, Lio/minio/messages/Tags;-><init>()V

    return-object v0

    .line 2901
    :cond_0
    :try_start_0
    const-class v0, Lio/minio/messages/Tags;

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Tags;
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2905
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2901
    return-object v0

    .line 2905
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 2902
    :catch_0
    move-exception v0

    .line 2903
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2905
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2906
    throw v0
.end method

.method static synthetic lambda$getBucketVersioning$29(Lokhttp3/Response;)Lio/minio/messages/VersioningConfiguration;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .line 1547
    :try_start_0
    const-class v0, Lio/minio/messages/VersioningConfiguration;

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/VersioningConfiguration;
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1551
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1547
    return-object v0

    .line 1551
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 1548
    :catch_0
    move-exception v0

    .line 1549
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1551
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1552
    throw v0
.end method

.method static synthetic lambda$getObject$0(Lio/minio/GetObjectArgs;Lokhttp3/Response;)Lio/minio/GetObjectResponse;
    .locals 7
    .param p0, "args"    # Lio/minio/GetObjectArgs;
    .param p1, "response"    # Lokhttp3/Response;

    .line 250
    new-instance v6, Lio/minio/GetObjectResponse;

    .line 251
    invoke-virtual {p1}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v1

    .line 252
    invoke-virtual {p0}, Lio/minio/GetObjectArgs;->bucket()Ljava/lang/String;

    move-result-object v2

    .line 253
    invoke-virtual {p0}, Lio/minio/GetObjectArgs;->region()Ljava/lang/String;

    move-result-object v3

    .line 254
    invoke-virtual {p0}, Lio/minio/GetObjectArgs;->object()Ljava/lang/String;

    move-result-object v4

    .line 255
    invoke-virtual {p1}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/ResponseBody;->byteStream()Ljava/io/InputStream;

    move-result-object v5

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Lio/minio/GetObjectResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;)V

    .line 250
    return-object v6
.end method

.method static synthetic lambda$getObjectLockConfiguration$32(Lokhttp3/Response;)Lio/minio/messages/ObjectLockConfiguration;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .line 1637
    :try_start_0
    const-class v0, Lio/minio/messages/ObjectLockConfiguration;

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ObjectLockConfiguration;
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1641
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1637
    return-object v0

    .line 1641
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 1638
    :catch_0
    move-exception v0

    .line 1639
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1641
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1642
    throw v0
.end method

.method static synthetic lambda$getObjectRetention$34(Ljava/lang/Throwable;)Lokhttp3/Response;
    .locals 3
    .param p0, "e"    # Ljava/lang/Throwable;

    .line 1717
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 1719
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_0

    .line 1720
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 1723
    :cond_0
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_1

    .line 1724
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 1727
    :cond_1
    instance-of v1, v0, Lio/minio/errors/ErrorResponseException;

    if-eqz v1, :cond_2

    .line 1728
    move-object v1, v0

    check-cast v1, Lio/minio/errors/ErrorResponseException;

    .line 1729
    invoke-virtual {v1}, Lio/minio/errors/ErrorResponseException;->errorResponse()Lio/minio/messages/ErrorResponse;

    move-result-object v1

    .line 1730
    invoke-virtual {v1}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v1

    .line 1731
    const-string v2, "NoSuchObjectLockConfiguration"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1732
    const/4 v1, 0x0

    return-object v1

    .line 1735
    :cond_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$getObjectRetention$35(Lokhttp3/Response;)Lio/minio/messages/Retention;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .line 1739
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 1741
    :cond_0
    :try_start_0
    const-class v0, Lio/minio/messages/Retention;

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Retention;
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1745
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1741
    return-object v0

    .line 1745
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 1742
    :catch_0
    move-exception v0

    .line 1743
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1745
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1746
    throw v0
.end method

.method static synthetic lambda$getObjectTags$68(Lokhttp3/Response;)Lio/minio/messages/Tags;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .line 2991
    :try_start_0
    const-class v0, Lio/minio/messages/Tags;

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Tags;
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2995
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2991
    return-object v0

    .line 2995
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 2992
    :catch_0
    move-exception v0

    .line 2993
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2995
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 2996
    throw v0
.end method

.method static synthetic lambda$isObjectLegalHoldEnabled$38(Ljava/lang/Throwable;)Lokhttp3/Response;
    .locals 3
    .param p0, "e"    # Ljava/lang/Throwable;

    .line 1843
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 1845
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_0

    .line 1846
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 1849
    :cond_0
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_1

    .line 1850
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 1853
    :cond_1
    instance-of v1, v0, Lio/minio/errors/ErrorResponseException;

    if-eqz v1, :cond_2

    .line 1854
    move-object v1, v0

    check-cast v1, Lio/minio/errors/ErrorResponseException;

    .line 1855
    invoke-virtual {v1}, Lio/minio/errors/ErrorResponseException;->errorResponse()Lio/minio/messages/ErrorResponse;

    move-result-object v1

    .line 1856
    invoke-virtual {v1}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v1

    .line 1857
    const-string v2, "NoSuchObjectLockConfiguration"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1858
    const/4 v1, 0x0

    return-object v1

    .line 1861
    :cond_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$isObjectLegalHoldEnabled$39(Lokhttp3/Response;)Ljava/lang/Boolean;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .line 1865
    if-nez p0, :cond_0

    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    .line 1867
    :cond_0
    :try_start_0
    const-class v0, Lio/minio/messages/LegalHold;

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/LegalHold;

    .line 1868
    .local v0, "result":Lio/minio/messages/LegalHold;
    invoke-virtual {v0}, Lio/minio/messages/LegalHold;->status()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1872
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1868
    return-object v1

    .line 1872
    .end local v0    # "result":Lio/minio/messages/LegalHold;
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 1869
    :catch_0
    move-exception v0

    .line 1870
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1872
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1873
    throw v0
.end method

.method static synthetic lambda$listBuckets$24(Lokhttp3/Response;)Ljava/util/List;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .line 1359
    :try_start_0
    const-class v0, Lio/minio/messages/ListAllMyBucketsResult;

    .line 1360
    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ListAllMyBucketsResult;

    .line 1361
    .local v0, "result":Lio/minio/messages/ListAllMyBucketsResult;
    invoke-virtual {v0}, Lio/minio/messages/ListAllMyBucketsResult;->buckets()Ljava/util/List;

    move-result-object v1
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1365
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1361
    return-object v1

    .line 1365
    .end local v0    # "result":Lio/minio/messages/ListAllMyBucketsResult;
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 1362
    :catch_0
    move-exception v0

    .line 1363
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1365
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    .line 1366
    throw v0
.end method

.method static synthetic lambda$removeObject$22(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 1087
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$restoreObject$23(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 1257
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$setBucketEncryption$59(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2745
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$setBucketLifecycle$48(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2256
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$setBucketNotification$53(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2417
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$setBucketPolicy$45(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2168
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$setBucketReplication$57(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2557
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$setBucketTags$66(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 2935
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$setBucketVersioning$28(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 1517
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$setObjectLockConfiguration$30(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 1580
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$setObjectRetention$33(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 1684
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$setObjectTags$69(Lokhttp3/Response;)V
    .locals 0
    .param p0, "response"    # Lokhttp3/Response;

    .line 3031
    invoke-virtual {p0}, Lokhttp3/Response;->close()V

    return-void
.end method

.method static synthetic lambda$uploadObject$41(Ljava/io/RandomAccessFile;Ljava/lang/Throwable;)Lio/minio/ObjectWriteResponse;
    .locals 2
    .param p0, "file"    # Ljava/io/RandomAccessFile;
    .param p1, "e"    # Ljava/lang/Throwable;

    .line 2008
    :try_start_0
    invoke-virtual {p0}, Ljava/io/RandomAccessFile;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2011
    nop

    .line 2013
    invoke-virtual {p1}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2015
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_0

    .line 2016
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2019
    :cond_0
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_1

    .line 2020
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2023
    :cond_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 2009
    .end local v0    # "ex":Ljava/lang/Throwable;
    :catch_0
    move-exception v0

    .line 2010
    .local v0, "ex":Ljava/io/IOException;
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$uploadObject$42(Ljava/io/RandomAccessFile;Lio/minio/ObjectWriteResponse;)Lio/minio/ObjectWriteResponse;
    .locals 2
    .param p0, "file"    # Ljava/io/RandomAccessFile;
    .param p1, "objectWriteResponse"    # Lio/minio/ObjectWriteResponse;

    .line 2028
    :try_start_0
    invoke-virtual {p0}, Ljava/io/RandomAccessFile;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2031
    nop

    .line 2032
    return-object p1

    .line 2029
    :catch_0
    move-exception v0

    .line 2030
    .local v0, "e":Ljava/io/IOException;
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$uploadPartCopy$9([Lio/minio/messages/Part;ILio/minio/UploadPartCopyResponse;)[Lio/minio/messages/Part;
    .locals 3
    .param p0, "parts"    # [Lio/minio/messages/Part;
    .param p1, "partNumber"    # I
    .param p2, "uploadPartCopyResponse"    # Lio/minio/UploadPartCopyResponse;

    .line 567
    add-int/lit8 v0, p1, -0x1

    new-instance v1, Lio/minio/messages/Part;

    invoke-virtual {p2}, Lio/minio/UploadPartCopyResponse;->result()Lio/minio/messages/CopyPartResult;

    move-result-object v2

    invoke-virtual {v2}, Lio/minio/messages/CopyPartResult;->etag()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, p1, v2}, Lio/minio/messages/Part;-><init>(ILjava/lang/String;)V

    aput-object v1, p0, v0

    .line 568
    return-object p0
.end method

.method static synthetic lambda$uploadSnowballObjects$71(Lio/minio/UploadSnowballObjectsArgs;)Ljava/io/ByteArrayOutputStream;
    .locals 12
    .param p0, "args"    # Lio/minio/UploadSnowballObjectsArgs;

    .line 3100
    const/4 v0, 0x0

    .line 3101
    .local v0, "fos":Ljava/io/FileOutputStream;
    const/4 v1, 0x0

    .line 3102
    .local v1, "bos":Ljava/io/BufferedOutputStream;
    const/4 v2, 0x0

    .line 3103
    .local v2, "sos":Lorg/xerial/snappy/SnappyFramedOutputStream;
    const/4 v3, 0x0

    .line 3104
    .local v3, "baos":Ljava/io/ByteArrayOutputStream;
    const/4 v4, 0x0

    .line 3107
    .local v4, "tarOutputStream":Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;
    const/4 v5, 0x0

    .line 3108
    .local v5, "os":Ljava/io/OutputStream;
    :try_start_0
    invoke-virtual {p0}, Lio/minio/UploadSnowballObjectsArgs;->stagingFilename()Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_0

    .line 3109
    new-instance v6, Ljava/io/FileOutputStream;

    invoke-virtual {p0}, Lio/minio/UploadSnowballObjectsArgs;->stagingFilename()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V

    move-object v0, v6

    .line 3110
    new-instance v6, Ljava/io/BufferedOutputStream;

    invoke-direct {v6, v0}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object v1, v6

    .line 3111
    move-object v5, v1

    goto :goto_0

    .line 3113
    :cond_0
    new-instance v6, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v6}, Ljava/io/ByteArrayOutputStream;-><init>()V

    move-object v3, v6

    .line 3114
    move-object v5, v3

    .line 3117
    :goto_0
    invoke-virtual {p0}, Lio/minio/UploadSnowballObjectsArgs;->compression()Z

    move-result v6

    if-eqz v6, :cond_1

    .line 3118
    new-instance v6, Lorg/xerial/snappy/SnappyFramedOutputStream;

    invoke-direct {v6, v5}, Lorg/xerial/snappy/SnappyFramedOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object v2, v6

    .line 3119
    move-object v5, v2

    .line 3122
    :cond_1
    new-instance v6, Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;

    invoke-direct {v6, v5}, Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object v4, v6

    .line 3123
    const/4 v6, 0x3

    invoke-virtual {v4, v6}, Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;->setLongFileMode(I)V

    .line 3124
    invoke-virtual {p0}, Lio/minio/UploadSnowballObjectsArgs;->objects()Ljava/lang/Iterable;

    move-result-object v6

    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_1
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_4

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lio/minio/SnowballObject;

    .line 3125
    .local v7, "object":Lio/minio/SnowballObject;
    invoke-virtual {v7}, Lio/minio/SnowballObject;->filename()Ljava/lang/String;

    move-result-object v8

    if-eqz v8, :cond_2

    .line 3126
    invoke-virtual {v7}, Lio/minio/SnowballObject;->filename()Ljava/lang/String;

    move-result-object v8

    const/4 v9, 0x0

    new-array v9, v9, [Ljava/lang/String;

    invoke-static {v8, v9}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v8

    .line 3127
    .local v8, "filePath":Ljava/nio/file/Path;
    new-instance v9, Lorg/apache/commons/compress/archivers/tar/TarArchiveEntry;

    invoke-interface {v8}, Ljava/nio/file/Path;->toFile()Ljava/io/File;

    move-result-object v10

    invoke-virtual {v7}, Lio/minio/SnowballObject;->name()Ljava/lang/String;

    move-result-object v11

    invoke-direct {v9, v10, v11}, Lorg/apache/commons/compress/archivers/tar/TarArchiveEntry;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 3128
    .local v9, "entry":Lorg/apache/commons/compress/archivers/tar/TarArchiveEntry;
    invoke-virtual {v4, v9}, Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;->putArchiveEntry(Lorg/apache/commons/compress/archivers/ArchiveEntry;)V

    .line 3129
    invoke-static {v8, v4}, Ljava/nio/file/Files;->copy(Ljava/nio/file/Path;Ljava/io/OutputStream;)J

    .line 3130
    nop

    .end local v8    # "filePath":Ljava/nio/file/Path;
    .end local v9    # "entry":Lorg/apache/commons/compress/archivers/tar/TarArchiveEntry;
    goto :goto_2

    .line 3131
    :cond_2
    new-instance v8, Lorg/apache/commons/compress/archivers/tar/TarArchiveEntry;

    invoke-virtual {v7}, Lio/minio/SnowballObject;->name()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Lorg/apache/commons/compress/archivers/tar/TarArchiveEntry;-><init>(Ljava/lang/String;)V

    .line 3132
    .local v8, "entry":Lorg/apache/commons/compress/archivers/tar/TarArchiveEntry;
    invoke-virtual {v7}, Lio/minio/SnowballObject;->modificationTime()Ljava/time/ZonedDateTime;

    move-result-object v9

    if-eqz v9, :cond_3

    .line 3133
    invoke-virtual {v7}, Lio/minio/SnowballObject;->modificationTime()Ljava/time/ZonedDateTime;

    move-result-object v9

    invoke-virtual {v9}, Ljava/time/ZonedDateTime;->toInstant()Ljava/time/Instant;

    move-result-object v9

    invoke-static {v9}, Ljava/util/Date;->from(Ljava/time/Instant;)Ljava/util/Date;

    move-result-object v9

    invoke-virtual {v8, v9}, Lorg/apache/commons/compress/archivers/tar/TarArchiveEntry;->setModTime(Ljava/util/Date;)V

    .line 3135
    :cond_3
    invoke-virtual {v7}, Lio/minio/SnowballObject;->size()J

    move-result-wide v9

    invoke-virtual {v8, v9, v10}, Lorg/apache/commons/compress/archivers/tar/TarArchiveEntry;->setSize(J)V

    .line 3136
    invoke-virtual {v4, v8}, Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;->putArchiveEntry(Lorg/apache/commons/compress/archivers/ArchiveEntry;)V

    .line 3137
    invoke-virtual {v7}, Lio/minio/SnowballObject;->stream()Ljava/io/InputStream;

    move-result-object v9

    invoke-static {v9, v4}, Lcom/google/common/io/ByteStreams;->copy(Ljava/io/InputStream;Ljava/io/OutputStream;)J

    .line 3139
    .end local v8    # "entry":Lorg/apache/commons/compress/archivers/tar/TarArchiveEntry;
    :goto_2
    invoke-virtual {v4}, Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;->closeArchiveEntry()V

    .line 3140
    .end local v7    # "object":Lio/minio/SnowballObject;
    goto :goto_1

    .line 3141
    :cond_4
    invoke-virtual {v4}, Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;->finish()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 3146
    .end local v5    # "os":Ljava/io/OutputStream;
    :try_start_1
    invoke-virtual {v4}, Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;->flush()V

    .line 3147
    if-eqz v2, :cond_5

    invoke-virtual {v2}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flush()V

    .line 3148
    :cond_5
    if-eqz v1, :cond_6

    invoke-virtual {v1}, Ljava/io/BufferedOutputStream;->flush()V

    .line 3149
    :cond_6
    if-eqz v0, :cond_7

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    .line 3150
    :cond_7
    invoke-virtual {v4}, Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;->close()V

    .line 3151
    if-eqz v2, :cond_8

    invoke-virtual {v2}, Lorg/xerial/snappy/SnappyFramedOutputStream;->close()V

    .line 3152
    :cond_8
    if-eqz v1, :cond_9

    invoke-virtual {v1}, Ljava/io/BufferedOutputStream;->close()V

    .line 3153
    :cond_9
    if-eqz v0, :cond_a

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 3156
    :cond_a
    nop

    .line 3158
    return-object v3

    .line 3154
    :catch_0
    move-exception v5

    .line 3155
    .local v5, "e":Ljava/io/IOException;
    new-instance v6, Ljava/util/concurrent/CompletionException;

    invoke-direct {v6, v5}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v6

    .line 3145
    .end local v5    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v5

    goto :goto_3

    .line 3142
    :catch_1
    move-exception v5

    .line 3143
    .restart local v5    # "e":Ljava/io/IOException;
    :try_start_2
    new-instance v6, Ljava/util/concurrent/CompletionException;

    invoke-direct {v6, v5}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local v0    # "fos":Ljava/io/FileOutputStream;
    .end local v1    # "bos":Ljava/io/BufferedOutputStream;
    .end local v2    # "sos":Lorg/xerial/snappy/SnappyFramedOutputStream;
    .end local v3    # "baos":Ljava/io/ByteArrayOutputStream;
    .end local v4    # "tarOutputStream":Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;
    .end local p0    # "args":Lio/minio/UploadSnowballObjectsArgs;
    throw v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 3146
    .end local v5    # "e":Ljava/io/IOException;
    .restart local v0    # "fos":Ljava/io/FileOutputStream;
    .restart local v1    # "bos":Ljava/io/BufferedOutputStream;
    .restart local v2    # "sos":Lorg/xerial/snappy/SnappyFramedOutputStream;
    .restart local v3    # "baos":Ljava/io/ByteArrayOutputStream;
    .restart local v4    # "tarOutputStream":Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;
    .restart local p0    # "args":Lio/minio/UploadSnowballObjectsArgs;
    :goto_3
    if-eqz v4, :cond_b

    :try_start_3
    invoke-virtual {v4}, Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;->flush()V

    goto :goto_4

    .line 3154
    :catch_2
    move-exception v5

    goto :goto_5

    .line 3147
    :cond_b
    :goto_4
    if-eqz v2, :cond_c

    invoke-virtual {v2}, Lorg/xerial/snappy/SnappyFramedOutputStream;->flush()V

    .line 3148
    :cond_c
    if-eqz v1, :cond_d

    invoke-virtual {v1}, Ljava/io/BufferedOutputStream;->flush()V

    .line 3149
    :cond_d
    if-eqz v0, :cond_e

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    .line 3150
    :cond_e
    if-eqz v4, :cond_f

    invoke-virtual {v4}, Lorg/apache/commons/compress/archivers/tar/TarArchiveOutputStream;->close()V

    .line 3151
    :cond_f
    if-eqz v2, :cond_10

    invoke-virtual {v2}, Lorg/xerial/snappy/SnappyFramedOutputStream;->close()V

    .line 3152
    :cond_10
    if-eqz v1, :cond_11

    invoke-virtual {v1}, Ljava/io/BufferedOutputStream;->close()V

    .line 3153
    :cond_11
    if-eqz v0, :cond_12

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_6

    .line 3155
    .restart local v5    # "e":Ljava/io/IOException;
    :goto_5
    new-instance v6, Ljava/util/concurrent/CompletionException;

    invoke-direct {v6, v5}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v6

    .line 3156
    .end local v5    # "e":Ljava/io/IOException;
    :cond_12
    :goto_6
    nop

    .line 3157
    throw v5
.end method

.method private uploadPartCopy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILcom/google/common/collect/Multimap;[Lio/minio/messages/Part;)Ljava/util/concurrent/CompletableFuture;
    .locals 8
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "uploadId"    # Ljava/lang/String;
    .param p5, "partNumber"    # I
    .param p7, "parts"    # [Lio/minio/messages/Part;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "I",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;[",
            "Lio/minio/messages/Part;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "[",
            "Lio/minio/messages/Part;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 564
    .local p6, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    const/4 v7, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move v5, p5

    move-object v6, p6

    invoke-virtual/range {v0 .. v7}, Lio/minio/MinioAsyncClient;->uploadPartCopyAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda19;

    invoke-direct {v1, p7, p5}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda19;-><init>([Lio/minio/messages/Part;I)V

    .line 565
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 564
    return-object v0
.end method


# virtual methods
.method public bucketExists(Lio/minio/BucketExistsArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 2
    .param p1, "args"    # Lio/minio/BucketExistsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/BucketExistsArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1390
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, v0}, Lio/minio/MinioAsyncClient;->executeHeadAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda70;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda70;-><init>()V

    .line 1391
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda71;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda71;-><init>()V

    .line 1410
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1390
    return-object v0
.end method

.method public composeObject(Lio/minio/ComposeObjectArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 10
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/ComposeObjectArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/ObjectWriteResponse;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 629
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 630
    iget-object v0, p0, Lio/minio/MinioAsyncClient;->baseUrl:Lokhttp3/HttpUrl;

    invoke-virtual {p1, v0}, Lio/minio/ComposeObjectArgs;->validateSse(Lokhttp3/HttpUrl;)V

    .line 631
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->sources()Ljava/util/List;

    move-result-object v0

    .line 632
    .local v0, "sources":Ljava/util/List;, "Ljava/util/List<Lio/minio/ComposeSource;>;"
    const/4 v1, 0x0

    filled-new-array {v1}, [I

    move-result-object v2

    move-object v7, v2

    .line 633
    .local v7, "partCount":[I
    const/4 v2, 0x1

    new-array v4, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object v2, v4, v1

    .line 635
    .local v4, "uploadIdCopy":[Ljava/lang/String;
    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->calculatePartCountAsync(Ljava/util/List;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda36;

    invoke-direct {v2, v7, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda36;-><init>([ILio/minio/ComposeObjectArgs;)V

    .line 636
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda37;

    invoke-direct {v2, p0, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda37;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/ComposeObjectArgs;)V

    .line 643
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v8

    new-instance v9, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda38;

    move-object v1, v9

    move-object v2, p0

    move-object v3, p1

    move-object v5, v7

    move-object v6, v0

    invoke-direct/range {v1 .. v6}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda38;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/ComposeObjectArgs;[Ljava/lang/String;[ILjava/util/List;)V

    .line 659
    invoke-virtual {v8, v9}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 635
    return-object v1
.end method

.method public copyObject(Lio/minio/CopyObjectArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 2
    .param p1, "args"    # Lio/minio/CopyObjectArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/CopyObjectArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/ObjectWriteResponse;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 453
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 454
    iget-object v0, p0, Lio/minio/MinioAsyncClient;->baseUrl:Lokhttp3/HttpUrl;

    invoke-virtual {p1, v0}, Lio/minio/CopyObjectArgs;->validateSse(Lokhttp3/HttpUrl;)V

    .line 456
    new-instance v0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda10;

    invoke-direct {v0, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda10;-><init>(Lio/minio/CopyObjectArgs;)V

    invoke-static {v0}, Ljava/util/concurrent/CompletableFuture;->supplyAsync(Ljava/util/function/Supplier;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda12;

    invoke-direct {v1, p0, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda12;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/CopyObjectArgs;)V

    .line 458
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda13;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda13;-><init>()V

    .line 474
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda14;

    invoke-direct {v1, p0, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda14;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/CopyObjectArgs;)V

    .line 475
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda15;

    invoke-direct {v1, p0, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda15;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/CopyObjectArgs;)V

    .line 505
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 456
    return-object v0
.end method

.method public deleteBucketEncryption(Lio/minio/DeleteBucketEncryptionArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/DeleteBucketEncryptionArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/DeleteBucketEncryptionArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2826
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2827
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "encryption"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeDeleteAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda44;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda44;-><init>()V

    .line 2828
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda55;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda55;-><init>()V

    .line 2850
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2827
    return-object v0
.end method

.method public deleteBucketLifecycle(Lio/minio/DeleteBucketLifecycleArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/DeleteBucketLifecycleArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/DeleteBucketLifecycleArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2279
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2280
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "lifecycle"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeDeleteAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda30;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda30;-><init>()V

    .line 2281
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2280
    return-object v0
.end method

.method public deleteBucketNotification(Lio/minio/DeleteBucketNotificationArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "args"    # Lio/minio/DeleteBucketNotificationArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/DeleteBucketNotificationArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2440
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2441
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "notification"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    .line 2442
    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    new-instance v7, Lio/minio/messages/NotificationConfiguration;

    invoke-direct {v7}, Lio/minio/messages/NotificationConfiguration;-><init>()V

    .line 2441
    const/4 v5, 0x0

    const/4 v8, 0x0

    move-object v3, p0

    move-object v4, p1

    invoke-virtual/range {v3 .. v8}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda0;-><init>()V

    .line 2443
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2441
    return-object v0
.end method

.method public deleteBucketPolicy(Lio/minio/DeleteBucketPolicyArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/DeleteBucketPolicyArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/DeleteBucketPolicyArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2192
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2193
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "policy"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeDeleteAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda54;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda54;-><init>()V

    .line 2194
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda56;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda56;-><init>()V

    .line 2216
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2193
    return-object v0
.end method

.method public deleteBucketReplication(Lio/minio/DeleteBucketReplicationArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/DeleteBucketReplicationArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/DeleteBucketReplicationArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2580
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2581
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "replication"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeDeleteAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda45;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda45;-><init>()V

    .line 2582
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2581
    return-object v0
.end method

.method public deleteBucketTags(Lio/minio/DeleteBucketTagsArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/DeleteBucketTagsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/DeleteBucketTagsArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2958
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2959
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "tagging"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeDeleteAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda42;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda42;-><init>()V

    .line 2960
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2959
    return-object v0
.end method

.method public deleteObjectLockConfiguration(Lio/minio/DeleteObjectLockConfigurationArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "args"    # Lio/minio/DeleteObjectLockConfigurationArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/DeleteObjectLockConfigurationArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1604
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1605
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "object-lock"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    .line 1606
    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    new-instance v7, Lio/minio/messages/ObjectLockConfiguration;

    invoke-direct {v7}, Lio/minio/messages/ObjectLockConfiguration;-><init>()V

    .line 1605
    const/4 v5, 0x0

    const/4 v8, 0x0

    move-object v3, p0

    move-object v4, p1

    invoke-virtual/range {v3 .. v8}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda18;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda18;-><init>()V

    .line 1607
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1605
    return-object v0
.end method

.method public deleteObjectTags(Lio/minio/DeleteObjectTagsArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/DeleteObjectTagsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/DeleteObjectTagsArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 3054
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 3055
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "tagging"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 3056
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/DeleteObjectTagsArgs;->versionId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string/jumbo v1, "versionId"

    invoke-virtual {p1}, Lio/minio/DeleteObjectTagsArgs;->versionId()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 3057
    :cond_0
    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeDeleteAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda9;

    invoke-direct {v2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda9;-><init>()V

    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    return-object v1
.end method

.method public disableObjectLegalHold(Lio/minio/DisableObjectLegalHoldArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 10
    .param p1, "args"    # Lio/minio/DisableObjectLegalHoldArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/DisableObjectLegalHoldArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1805
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1806
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "legal-hold"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const/4 v1, 0x1

    const-string v3, ""

    aput-object v3, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 1807
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/DisableObjectLegalHoldArgs;->versionId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string/jumbo v1, "versionId"

    invoke-virtual {p1}, Lio/minio/DisableObjectLegalHoldArgs;->versionId()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v1, v3}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 1808
    :cond_0
    new-instance v8, Lio/minio/messages/LegalHold;

    invoke-direct {v8, v2}, Lio/minio/messages/LegalHold;-><init>(Z)V

    const/4 v9, 0x0

    const/4 v6, 0x0

    move-object v4, p0

    move-object v5, p1

    move-object v7, v0

    invoke-virtual/range {v4 .. v9}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda43;

    invoke-direct {v2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda43;-><init>()V

    .line 1809
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 1808
    return-object v1
.end method

.method public downloadObject(Lio/minio/DownloadObjectArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 5
    .param p1, "args"    # Lio/minio/DownloadObjectArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/DownloadObjectArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 319
    invoke-virtual {p1}, Lio/minio/DownloadObjectArgs;->filename()Ljava/lang/String;

    move-result-object v0

    .line 320
    .local v0, "filename":Ljava/lang/String;
    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/String;

    invoke-static {v0, v2}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v2

    .line 321
    .local v2, "filePath":Ljava/nio/file/Path;
    invoke-virtual {p1}, Lio/minio/DownloadObjectArgs;->overwrite()Z

    move-result v3

    if-nez v3, :cond_1

    new-array v1, v1, [Ljava/nio/file/LinkOption;

    invoke-static {v2, v1}, Ljava/nio/file/Files;->exists(Ljava/nio/file/Path;[Ljava/nio/file/LinkOption;)Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 322
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Destination file "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " already exists"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 325
    :cond_1
    :goto_0
    new-instance v1, Lio/minio/StatObjectArgs;

    invoke-direct {v1, p1}, Lio/minio/StatObjectArgs;-><init>(Lio/minio/ObjectReadArgs;)V

    invoke-virtual {p0, v1}, Lio/minio/MinioAsyncClient;->statObjectAsync(Lio/minio/StatObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v3, Lio/minio/GetObjectArgs;

    invoke-direct {v3, p1}, Lio/minio/GetObjectArgs;-><init>(Lio/minio/DownloadObjectArgs;)V

    .line 327
    invoke-virtual {p0, v3}, Lio/minio/MinioAsyncClient;->getObject(Lio/minio/GetObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v3

    new-instance v4, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda40;

    invoke-direct {v4, p0, v0, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda40;-><init>(Lio/minio/MinioAsyncClient;Ljava/lang/String;Lio/minio/DownloadObjectArgs;)V

    .line 326
    invoke-virtual {v1, v3, v4}, Ljava/util/concurrent/CompletableFuture;->thenCombine(Ljava/util/concurrent/CompletionStage;Ljava/util/function/BiFunction;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v3, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda41;

    invoke-direct {v3}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda41;-><init>()V

    .line 336
    invoke-virtual {v1, v3}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 325
    return-object v1
.end method

.method public enableObjectLegalHold(Lio/minio/EnableObjectLegalHoldArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "args"    # Lio/minio/EnableObjectLegalHoldArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/EnableObjectLegalHoldArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1774
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1775
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "legal-hold"

    aput-object v2, v0, v1

    const-string v1, ""

    const/4 v2, 0x1

    aput-object v1, v0, v2

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 1776
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/EnableObjectLegalHoldArgs;->versionId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string/jumbo v1, "versionId"

    invoke-virtual {p1}, Lio/minio/EnableObjectLegalHoldArgs;->versionId()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v1, v3}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 1777
    :cond_0
    new-instance v7, Lio/minio/messages/LegalHold;

    invoke-direct {v7, v2}, Lio/minio/messages/LegalHold;-><init>(Z)V

    const/4 v8, 0x0

    const/4 v5, 0x0

    move-object v3, p0

    move-object v4, p1

    move-object v6, v0

    invoke-virtual/range {v3 .. v8}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda32;

    invoke-direct {v2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda32;-><init>()V

    .line 1778
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 1777
    return-object v1
.end method

.method public getBucketEncryption(Lio/minio/GetBucketEncryptionArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/GetBucketEncryptionArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/GetBucketEncryptionArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/messages/SseConfiguration;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2769
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2770
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "encryption"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda11;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda11;-><init>()V

    .line 2771
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda22;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda22;-><init>()V

    .line 2793
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2770
    return-object v0
.end method

.method public getBucketLifecycle(Lio/minio/GetBucketLifecycleArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/GetBucketLifecycleArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/GetBucketLifecycleArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/messages/LifecycleConfiguration;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2306
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2307
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "lifecycle"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda67;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda67;-><init>()V

    .line 2308
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda68;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda68;-><init>()V

    .line 2330
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2307
    return-object v0
.end method

.method public getBucketNotification(Lio/minio/GetBucketNotificationArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/GetBucketNotificationArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/GetBucketNotificationArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/messages/NotificationConfiguration;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2365
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2366
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "notification"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda8;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda8;-><init>()V

    .line 2367
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2366
    return-object v0
.end method

.method public getBucketPolicy(Lio/minio/GetBucketPolicyArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/GetBucketPolicyArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/GetBucketPolicyArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2057
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2058
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "policy"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda46;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda46;-><init>()V

    .line 2059
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda47;

    invoke-direct {v1, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda47;-><init>(Lio/minio/GetBucketPolicyArgs;)V

    .line 2081
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2058
    return-object v0
.end method

.method public getBucketReplication(Lio/minio/GetBucketReplicationArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/GetBucketReplicationArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/GetBucketReplicationArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/messages/ReplicationConfiguration;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2468
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2469
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "replication"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda20;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda20;-><init>()V

    .line 2470
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda21;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda21;-><init>()V

    .line 2492
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2469
    return-object v0
.end method

.method public getBucketTags(Lio/minio/GetBucketTagsArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/GetBucketTagsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/GetBucketTagsArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/messages/Tags;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2876
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2877
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "tagging"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda34;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda34;-><init>()V

    .line 2878
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda35;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda35;-><init>()V

    .line 2897
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2877
    return-object v0
.end method

.method public getBucketVersioning(Lio/minio/GetBucketVersioningArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/GetBucketVersioningArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/GetBucketVersioningArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/messages/VersioningConfiguration;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1542
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1543
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "versioning"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda57;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda57;-><init>()V

    .line 1544
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1543
    return-object v0
.end method

.method public getObject(Lio/minio/GetObjectArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 4
    .param p1, "args"    # Lio/minio/GetObjectArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/GetObjectArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/GetObjectResponse;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 242
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 243
    iget-object v0, p0, Lio/minio/MinioAsyncClient;->baseUrl:Lokhttp3/HttpUrl;

    invoke-virtual {p1, v0}, Lio/minio/GetObjectArgs;->validateSsec(Lokhttp3/HttpUrl;)V

    .line 244
    nop

    .line 246
    invoke-virtual {p1}, Lio/minio/GetObjectArgs;->getHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 247
    invoke-virtual {p1}, Lio/minio/GetObjectArgs;->versionId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string/jumbo v3, "versionId"

    aput-object v3, v1, v2

    const/4 v2, 0x1

    invoke-virtual {p1}, Lio/minio/GetObjectArgs;->versionId()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {p0, v1}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 244
    :goto_0
    invoke-virtual {p0, p1, v0, v1}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda31;

    invoke-direct {v1, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda31;-><init>(Lio/minio/GetObjectArgs;)V

    .line 248
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 244
    return-object v0
.end method

.method public getObjectLockConfiguration(Lio/minio/GetObjectLockConfigurationArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/GetObjectLockConfigurationArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/GetObjectLockConfigurationArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/messages/ObjectLockConfiguration;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1632
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1633
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "object-lock"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda66;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda66;-><init>()V

    .line 1634
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1633
    return-object v0
.end method

.method public getObjectRetention(Lio/minio/GetObjectRetentionArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/GetObjectRetentionArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/GetObjectRetentionArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/messages/Retention;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1711
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1712
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "retention"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 1713
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/GetObjectRetentionArgs;->versionId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string/jumbo v1, "versionId"

    invoke-virtual {p1}, Lio/minio/GetObjectRetentionArgs;->versionId()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 1714
    :cond_0
    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda2;

    invoke-direct {v2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda2;-><init>()V

    .line 1715
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda3;

    invoke-direct {v2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda3;-><init>()V

    .line 1737
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 1714
    return-object v1
.end method

.method public getObjectTags(Lio/minio/GetObjectTagsArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/GetObjectTagsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/GetObjectTagsArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/messages/Tags;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2984
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2985
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "tagging"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 2986
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/GetObjectTagsArgs;->versionId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string/jumbo v1, "versionId"

    invoke-virtual {p1}, Lio/minio/GetObjectTagsArgs;->versionId()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2987
    :cond_0
    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda62;

    invoke-direct {v2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda62;-><init>()V

    .line 2988
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 2987
    return-object v1
.end method

.method public getPresignedObjectUrl(Lio/minio/GetPresignedObjectUrlArgs;)Ljava/lang/String;
    .locals 17
    .param p1, "args"    # Lio/minio/GetPresignedObjectUrlArgs;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/InvalidResponseException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ServerException;
        }
    .end annotation

    .line 924
    move-object/from16 v14, p0

    invoke-virtual/range {p0 .. p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 927
    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->method()Lio/minio/http/Method;

    move-result-object v0

    sget-object v1, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;

    const/4 v7, 0x0

    if-eq v0, v1, :cond_1

    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->method()Lio/minio/http/Method;

    move-result-object v0

    sget-object v1, Lio/minio/http/Method;->POST:Lio/minio/http/Method;

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    move-object v11, v7

    goto :goto_1

    :cond_1
    :goto_0
    sget-object v0, Lio/minio/http/HttpUtils;->EMPTY_BODY:[B

    move-object v11, v0

    .line 929
    .local v11, "body":[B
    :goto_1
    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v0

    invoke-virtual {v14, v0}, Lio/minio/MinioAsyncClient;->newMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v15

    .line 930
    .local v15, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->versionId()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    const-string/jumbo v0, "versionId"

    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->versionId()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v15, v0, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 932
    :cond_2
    const/4 v1, 0x0

    .line 934
    .local v1, "region":Ljava/lang/String;
    :try_start_0
    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->bucket()Ljava/lang/String;

    move-result-object v0

    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->region()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v14, v0, v2}, Lio/minio/MinioAsyncClient;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v0

    .line 939
    goto :goto_2

    .line 937
    :catch_0
    move-exception v0

    .line 938
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {v14, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    move-object v0, v1

    .line 941
    .end local v1    # "region":Ljava/lang/String;
    .local v0, "region":Ljava/lang/String;
    :goto_2
    iget-object v1, v14, Lio/minio/MinioAsyncClient;->provider:Lio/minio/credentials/Provider;

    if-nez v1, :cond_3

    .line 942
    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->method()Lio/minio/http/Method;

    move-result-object v2

    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->bucket()Ljava/lang/String;

    move-result-object v3

    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->object()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v1, p0

    move-object v5, v0

    move-object v6, v15

    invoke-virtual/range {v1 .. v6}, Lio/minio/MinioAsyncClient;->buildUrl(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;)Lokhttp3/HttpUrl;

    move-result-object v1

    .line 943
    .local v1, "url":Lokhttp3/HttpUrl;
    invoke-virtual {v1}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 946
    .end local v1    # "url":Lokhttp3/HttpUrl;
    :cond_3
    iget-object v1, v14, Lio/minio/MinioAsyncClient;->provider:Lio/minio/credentials/Provider;

    invoke-interface {v1}, Lio/minio/credentials/Provider;->fetch()Lio/minio/credentials/Credentials;

    move-result-object v16

    .line 947
    .local v16, "creds":Lio/minio/credentials/Credentials;
    invoke-virtual/range {v16 .. v16}, Lio/minio/credentials/Credentials;->sessionToken()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    const-string v1, "X-Amz-Security-Token"

    invoke-virtual/range {v16 .. v16}, Lio/minio/credentials/Credentials;->sessionToken()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v15, v1, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 948
    :cond_4
    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->method()Lio/minio/http/Method;

    move-result-object v2

    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->bucket()Ljava/lang/String;

    move-result-object v3

    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->object()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v1, p0

    move-object v5, v0

    move-object v6, v15

    invoke-virtual/range {v1 .. v6}, Lio/minio/MinioAsyncClient;->buildUrl(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;)Lokhttp3/HttpUrl;

    move-result-object v1

    .line 949
    .restart local v1    # "url":Lokhttp3/HttpUrl;
    nop

    .line 952
    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->method()Lio/minio/http/Method;

    move-result-object v9

    .line 953
    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v2

    if-nez v2, :cond_5

    move-object v10, v7

    goto :goto_3

    :cond_5
    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v2

    invoke-virtual {v14, v2}, Lio/minio/MinioAsyncClient;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v2

    move-object v10, v2

    .line 950
    :goto_3
    const/4 v12, 0x0

    move-object/from16 v7, p0

    move-object v8, v1

    move-object/from16 v13, v16

    invoke-virtual/range {v7 .. v13}, Lio/minio/MinioAsyncClient;->createRequest(Lokhttp3/HttpUrl;Lio/minio/http/Method;Lokhttp3/Headers;Ljava/lang/Object;ILio/minio/credentials/Credentials;)Lokhttp3/Request;

    move-result-object v2

    .line 957
    .local v2, "request":Lokhttp3/Request;
    invoke-virtual/range {v16 .. v16}, Lio/minio/credentials/Credentials;->accessKey()Ljava/lang/String;

    move-result-object v3

    invoke-virtual/range {v16 .. v16}, Lio/minio/credentials/Credentials;->secretKey()Ljava/lang/String;

    move-result-object v4

    invoke-virtual/range {p1 .. p1}, Lio/minio/GetPresignedObjectUrlArgs;->expiry()I

    move-result v5

    invoke-static {v2, v0, v3, v4, v5}, Lio/minio/Signer;->presignV4(Lokhttp3/Request;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lokhttp3/HttpUrl;

    move-result-object v1

    .line 958
    invoke-virtual {v1}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 935
    .end local v0    # "region":Ljava/lang/String;
    .end local v2    # "request":Lokhttp3/Request;
    .end local v16    # "creds":Lio/minio/credentials/Credentials;
    .local v1, "region":Ljava/lang/String;
    :catch_1
    move-exception v0

    .line 936
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2
.end method

.method public getPresignedPostFormData(Lio/minio/PostPolicy;)Ljava/util/Map;
    .locals 3
    .param p1, "policy"    # Lio/minio/PostPolicy;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/PostPolicy;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/InvalidResponseException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1023
    iget-object v0, p0, Lio/minio/MinioAsyncClient;->provider:Lio/minio/credentials/Provider;

    if-eqz v0, :cond_0

    .line 1028
    const/4 v0, 0x0

    .line 1030
    .local v0, "region":Ljava/lang/String;
    :try_start_0
    invoke-virtual {p1}, Lio/minio/PostPolicy;->bucket()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lio/minio/MinioAsyncClient;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 1035
    goto :goto_0

    .line 1033
    :catch_0
    move-exception v1

    .line 1034
    .local v1, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v1}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1036
    .end local v1    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    iget-object v1, p0, Lio/minio/MinioAsyncClient;->provider:Lio/minio/credentials/Provider;

    invoke-interface {v1}, Lio/minio/credentials/Provider;->fetch()Lio/minio/credentials/Credentials;

    move-result-object v1

    invoke-virtual {p1, v1, v0}, Lio/minio/PostPolicy;->formData(Lio/minio/credentials/Credentials;Ljava/lang/String;)Ljava/util/Map;

    move-result-object v1

    return-object v1

    .line 1031
    :catch_1
    move-exception v1

    .line 1032
    .local v1, "e":Ljava/lang/InterruptedException;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2

    .line 1024
    .end local v0    # "region":Ljava/lang/String;
    .end local v1    # "e":Ljava/lang/InterruptedException;
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Anonymous access does not require presigned post form-data"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public isObjectLegalHoldEnabled(Lio/minio/IsObjectLegalHoldEnabledArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/IsObjectLegalHoldEnabledArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/IsObjectLegalHoldEnabledArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1837
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1838
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "legal-hold"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 1839
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/IsObjectLegalHoldEnabledArgs;->versionId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string/jumbo v1, "versionId"

    invoke-virtual {p1}, Lio/minio/IsObjectLegalHoldEnabledArgs;->versionId()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 1840
    :cond_0
    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda64;

    invoke-direct {v2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda64;-><init>()V

    .line 1841
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda65;

    invoke-direct {v2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda65;-><init>()V

    .line 1863
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 1840
    return-object v1
.end method

.method synthetic lambda$composeObject$11$io-minio-MinioAsyncClient(Lio/minio/ComposeObjectArgs;Ljava/lang/Boolean;)Ljava/util/concurrent/CompletionStage;
    .locals 2
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;
    .param p2, "copyObjectFlag"    # Ljava/lang/Boolean;

    .line 645
    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 647
    :try_start_0
    new-instance v0, Lio/minio/CopyObjectArgs;

    invoke-direct {v0, p1}, Lio/minio/CopyObjectArgs;-><init>(Lio/minio/ComposeObjectArgs;)V

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->copyObject(Lio/minio/CopyObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 648
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_0

    :catch_4
    move-exception v0

    goto :goto_0

    :catch_5
    move-exception v0

    .line 654
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 657
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/util/concurrent/CompletableFuture;->completedFuture(Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method synthetic lambda$composeObject$12$io-minio-MinioAsyncClient(Lio/minio/ComposeObjectArgs;)Lcom/google/common/collect/Multimap;
    .locals 2
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;

    .line 668
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v0

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 669
    .local v0, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->genHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 670
    return-object v0
.end method

.method synthetic lambda$composeObject$13$io-minio-MinioAsyncClient(Lio/minio/ComposeObjectArgs;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletionStage;
    .locals 6
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;
    .param p2, "headers"    # Lcom/google/common/collect/Multimap;

    .line 675
    nop

    .line 676
    :try_start_0
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->bucket()Ljava/lang/String;

    move-result-object v1

    .line 677
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->region()Ljava/lang/String;

    move-result-object v2

    .line 678
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->object()Ljava/lang/String;

    move-result-object v3

    .line 680
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v5

    .line 675
    move-object v0, p0

    move-object v4, p2

    invoke-virtual/range {v0 .. v5}, Lio/minio/MinioAsyncClient;->createMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 681
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_0

    :catch_4
    move-exception v0

    goto :goto_0

    :catch_5
    move-exception v0

    .line 687
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$composeObject$16$io-minio-MinioAsyncClient(Lio/minio/ComposeObjectArgs;Ljava/lang/String;ILcom/google/common/collect/Multimap;[Lio/minio/messages/Part;)Ljava/util/concurrent/CompletionStage;
    .locals 8
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;
    .param p2, "uploadId"    # Ljava/lang/String;
    .param p3, "partNum"    # I
    .param p4, "headers"    # Lcom/google/common/collect/Multimap;
    .param p5, "parts"    # [Lio/minio/messages/Part;

    .line 750
    nop

    .line 751
    :try_start_0
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->bucket()Ljava/lang/String;

    move-result-object v1

    .line 752
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->region()Ljava/lang/String;

    move-result-object v2

    .line 753
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->object()Ljava/lang/String;

    move-result-object v3

    .line 750
    move-object v0, p0

    move-object v4, p2

    move v5, p3

    move-object v6, p4

    move-object v7, p5

    invoke-direct/range {v0 .. v7}, Lio/minio/MinioAsyncClient;->uploadPartCopy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILcom/google/common/collect/Multimap;[Lio/minio/messages/Part;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 758
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_0

    :catch_4
    move-exception v0

    goto :goto_0

    :catch_5
    move-exception v0

    .line 764
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$composeObject$17$io-minio-MinioAsyncClient(Lio/minio/ComposeObjectArgs;Ljava/lang/String;ILcom/google/common/collect/Multimap;[Lio/minio/messages/Part;)Ljava/util/concurrent/CompletionStage;
    .locals 8
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;
    .param p2, "uploadId"    # Ljava/lang/String;
    .param p3, "partNum"    # I
    .param p4, "headersCopy"    # Lcom/google/common/collect/Multimap;
    .param p5, "parts"    # [Lio/minio/messages/Part;

    .line 788
    nop

    .line 789
    :try_start_0
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->bucket()Ljava/lang/String;

    move-result-object v1

    .line 790
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->region()Ljava/lang/String;

    move-result-object v2

    .line 791
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->object()Ljava/lang/String;

    move-result-object v3

    .line 788
    move-object v0, p0

    move-object v4, p2

    move v5, p3

    move-object v6, p4

    move-object v7, p5

    invoke-direct/range {v0 .. v7}, Lio/minio/MinioAsyncClient;->uploadPartCopy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILcom/google/common/collect/Multimap;[Lio/minio/messages/Part;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 796
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_0

    :catch_4
    move-exception v0

    goto :goto_0

    :catch_5
    move-exception v0

    .line 802
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$composeObject$18$io-minio-MinioAsyncClient(Lio/minio/ComposeObjectArgs;[ILjava/util/List;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 29
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;
    .param p2, "partCount"    # [I
    .param p3, "sources"    # Ljava/util/List;
    .param p4, "uploadId"    # Ljava/lang/String;

    .line 698
    move-object/from16 v7, p0

    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v8

    .line 699
    .local v8, "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual/range {p1 .. p1}, Lio/minio/ComposeObjectArgs;->sse()Lio/minio/ServerSideEncryption;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 700
    invoke-virtual/range {p1 .. p1}, Lio/minio/ComposeObjectArgs;->sse()Lio/minio/ServerSideEncryption;

    move-result-object v0

    instance-of v0, v0, Lio/minio/ServerSideEncryptionCustomerKey;

    if-eqz v0, :cond_0

    .line 701
    invoke-virtual/range {p1 .. p1}, Lio/minio/ComposeObjectArgs;->sse()Lio/minio/ServerSideEncryption;

    move-result-object v0

    invoke-virtual {v0}, Lio/minio/ServerSideEncryption;->headers()Ljava/util/Map;

    move-result-object v0

    invoke-virtual {v7, v0}, Lio/minio/MinioAsyncClient;->newMultimap(Ljava/util/Map;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    invoke-interface {v8, v0}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 704
    :cond_0
    const/4 v0, 0x0

    .line 705
    .local v0, "partNumber":I
    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda25;

    move-object/from16 v9, p2

    invoke-direct {v1, v9}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda25;-><init>([I)V

    .line 706
    invoke-static {v1}, Ljava/util/concurrent/CompletableFuture;->supplyAsync(Ljava/util/function/Supplier;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 710
    .local v1, "future":Ljava/util/concurrent/CompletableFuture;, "Ljava/util/concurrent/CompletableFuture<[Lio/minio/messages/Part;>;"
    invoke-interface/range {p3 .. p3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v10

    move-object v11, v1

    move v1, v0

    .end local v0    # "partNumber":I
    .local v1, "partNumber":I
    .local v11, "future":Ljava/util/concurrent/CompletableFuture;, "Ljava/util/concurrent/CompletableFuture<[Lio/minio/messages/Part;>;"
    :goto_0
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_9

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    move-object v12, v0

    check-cast v12, Lio/minio/ComposeSource;

    .line 711
    .local v12, "src":Lio/minio/ComposeSource;
    const-wide/16 v2, 0x0

    .line 713
    .local v2, "size":J
    :try_start_0
    invoke-virtual {v12}, Lio/minio/ComposeSource;->objectSize()J

    move-result-wide v4
    :try_end_0
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_1

    move-wide v2, v4

    .line 716
    nop

    .line 717
    invoke-virtual {v12}, Lio/minio/ComposeSource;->length()Ljava/lang/Long;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 718
    invoke-virtual {v12}, Lio/minio/ComposeSource;->length()Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    move-wide v13, v2

    goto :goto_1

    .line 719
    :cond_1
    invoke-virtual {v12}, Lio/minio/ComposeSource;->offset()Ljava/lang/Long;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 720
    invoke-virtual {v12}, Lio/minio/ComposeSource;->offset()Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    sub-long/2addr v2, v4

    move-wide v13, v2

    goto :goto_1

    .line 719
    :cond_2
    move-wide v13, v2

    .line 722
    .end local v2    # "size":J
    .local v13, "size":J
    :goto_1
    const-wide/16 v2, 0x0

    .line 723
    .local v2, "offset":J
    invoke-virtual {v12}, Lio/minio/ComposeSource;->offset()Ljava/lang/Long;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-virtual {v12}, Lio/minio/ComposeSource;->offset()Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    :cond_3
    move-wide v3, v2

    .line 727
    .end local v2    # "offset":J
    .local v3, "offset":J
    :try_start_1
    invoke-virtual {v12}, Lio/minio/ComposeSource;->headers()Lcom/google/common/collect/Multimap;

    move-result-object v0

    invoke-virtual {v7, v0}, Lio/minio/MinioAsyncClient;->newMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0
    :try_end_1
    .catch Lio/minio/errors/InternalException; {:try_start_1 .. :try_end_1} :catch_0

    .line 730
    .local v0, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    nop

    .line 731
    invoke-interface {v0, v8}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 733
    const-wide v15, 0x140000000L

    cmp-long v2, v13, v15

    const-string v6, "-"

    const-string v5, "bytes="

    const-string/jumbo v15, "x-amz-copy-source-range"

    if-gtz v2, :cond_6

    .line 734
    add-int/lit8 v16, v1, 0x1

    .line 735
    .end local v1    # "partNumber":I
    .local v16, "partNumber":I
    invoke-virtual {v12}, Lio/minio/ComposeSource;->length()Ljava/lang/Long;

    move-result-object v1

    const-wide/16 v17, 0x1

    if-eqz v1, :cond_4

    .line 736
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 738
    invoke-virtual {v12}, Lio/minio/ComposeSource;->length()Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    add-long/2addr v5, v3

    sub-long v5, v5, v17

    invoke-virtual {v1, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 736
    invoke-interface {v0, v15, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    goto :goto_2

    .line 739
    :cond_4
    invoke-virtual {v12}, Lio/minio/ComposeSource;->offset()Ljava/lang/Long;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 740
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    add-long v5, v3, v13

    sub-long v5, v5, v17

    invoke-virtual {v1, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v15, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 745
    :cond_5
    :goto_2
    move/from16 v5, v16

    .line 746
    .local v5, "partNum":I
    new-instance v15, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda26;

    move-object v1, v15

    move-object/from16 v2, p0

    move-wide/from16 v19, v3

    .end local v3    # "offset":J
    .local v19, "offset":J
    move-object/from16 v3, p1

    move-object/from16 v4, p4

    move-object v6, v0

    invoke-direct/range {v1 .. v6}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda26;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/ComposeObjectArgs;Ljava/lang/String;ILcom/google/common/collect/Multimap;)V

    .line 747
    invoke-virtual {v11, v15}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v11

    .line 767
    move/from16 v1, v16

    goto/16 :goto_0

    .line 733
    .end local v5    # "partNum":I
    .end local v16    # "partNumber":I
    .end local v19    # "offset":J
    .restart local v1    # "partNumber":I
    .restart local v3    # "offset":J
    :cond_6
    move-wide/from16 v19, v3

    .line 770
    .end local v3    # "offset":J
    .restart local v19    # "offset":J
    :goto_3
    const-wide/16 v2, 0x0

    cmp-long v2, v13, v2

    if-lez v2, :cond_8

    .line 771
    add-int/lit8 v16, v1, 0x1

    .line 773
    .end local v1    # "partNumber":I
    .restart local v16    # "partNumber":I
    move-wide/from16 v3, v19

    .line 774
    .local v3, "startBytes":J
    const-wide v17, 0x140000000L

    add-long v1, v3, v17

    .line 775
    .local v1, "endBytes":J
    cmp-long v21, v13, v17

    if-gez v21, :cond_7

    .line 776
    add-long v1, v3, v13

    .line 778
    :cond_7
    move-object/from16 v21, v8

    .end local v8    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local v21, "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {v7, v0}, Lio/minio/MinioAsyncClient;->newMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v8

    .line 779
    .local v8, "headersCopy":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    move-object/from16 v22, v0

    .end local v0    # "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local v22, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v8, v15, v0}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 783
    move-object v0, v5

    move/from16 v5, v16

    .line 784
    .restart local v5    # "partNum":I
    move-object/from16 v23, v0

    new-instance v0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;

    move-wide/from16 v24, v1

    .end local v1    # "endBytes":J
    .local v24, "endBytes":J
    move-object v1, v0

    move-object/from16 v2, p0

    move-wide/from16 v26, v3

    .end local v3    # "startBytes":J
    .local v26, "startBytes":J
    move-object/from16 v3, p1

    move-object/from16 v4, p4

    move-object/from16 v28, v6

    move-object v6, v8

    invoke-direct/range {v1 .. v6}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/ComposeObjectArgs;Ljava/lang/String;ILcom/google/common/collect/Multimap;)V

    .line 785
    invoke-virtual {v11, v0}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v11

    .line 805
    move-wide/from16 v19, v26

    .line 806
    sub-long v1, v24, v26

    sub-long/2addr v13, v1

    .line 807
    .end local v5    # "partNum":I
    .end local v8    # "headersCopy":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v24    # "endBytes":J
    .end local v26    # "startBytes":J
    move/from16 v1, v16

    move-object/from16 v8, v21

    move-object/from16 v0, v22

    move-object/from16 v5, v23

    move-object/from16 v6, v28

    goto :goto_3

    .line 770
    .end local v16    # "partNumber":I
    .end local v21    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v22    # "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v0    # "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local v1, "partNumber":I
    .local v8, "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_8
    move-object/from16 v22, v0

    move-object/from16 v21, v8

    .line 808
    .end local v0    # "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v8    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v12    # "src":Lio/minio/ComposeSource;
    .end local v13    # "size":J
    .end local v19    # "offset":J
    .restart local v21    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    goto/16 :goto_0

    .line 728
    .end local v21    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local v3, "offset":J
    .restart local v8    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v12    # "src":Lio/minio/ComposeSource;
    .restart local v13    # "size":J
    :catch_0
    move-exception v0

    move-wide/from16 v19, v3

    move-object/from16 v21, v8

    .line 729
    .end local v3    # "offset":J
    .end local v8    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local v0, "e":Lio/minio/errors/InternalException;
    .restart local v19    # "offset":J
    .restart local v21    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v2, Ljava/util/concurrent/CompletionException;

    invoke-direct {v2, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v2

    .line 714
    .end local v0    # "e":Lio/minio/errors/InternalException;
    .end local v13    # "size":J
    .end local v19    # "offset":J
    .end local v21    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local v2, "size":J
    .restart local v8    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :catch_1
    move-exception v0

    move-object/from16 v21, v8

    move-object v4, v0

    .end local v8    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v21    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    move-object v0, v4

    .line 715
    .restart local v0    # "e":Lio/minio/errors/InternalException;
    new-instance v4, Ljava/util/concurrent/CompletionException;

    invoke-direct {v4, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v4

    .line 810
    .end local v0    # "e":Lio/minio/errors/InternalException;
    .end local v2    # "size":J
    .end local v12    # "src":Lio/minio/ComposeSource;
    .end local v21    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v8    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_9
    return-object v11
.end method

.method synthetic lambda$composeObject$19$io-minio-MinioAsyncClient(Lio/minio/ComposeObjectArgs;[Ljava/lang/String;[Lio/minio/messages/Part;)Ljava/util/concurrent/CompletionStage;
    .locals 8
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;
    .param p2, "uploadIdCopy"    # [Ljava/lang/String;
    .param p3, "parts"    # [Lio/minio/messages/Part;

    .line 815
    nop

    .line 816
    :try_start_0
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->bucket()Ljava/lang/String;

    move-result-object v1

    .line 817
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->region()Ljava/lang/String;

    move-result-object v2

    .line 818
    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->object()Ljava/lang/String;

    move-result-object v3

    const/4 v0, 0x0

    aget-object v4, p2, v0

    .line 815
    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v0, p0

    move-object v5, p3

    invoke-virtual/range {v0 .. v7}, Lio/minio/MinioAsyncClient;->completeMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Lio/minio/messages/Part;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 823
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_0

    :catch_4
    move-exception v0

    goto :goto_0

    :catch_5
    move-exception v0

    .line 829
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$composeObject$20$io-minio-MinioAsyncClient([Ljava/lang/String;Lio/minio/ComposeObjectArgs;Ljava/lang/Throwable;)Lio/minio/ObjectWriteResponse;
    .locals 9
    .param p1, "uploadIdCopy"    # [Ljava/lang/String;
    .param p2, "args"    # Lio/minio/ComposeObjectArgs;
    .param p3, "e"    # Ljava/lang/Throwable;

    .line 835
    const/4 v0, 0x0

    aget-object v1, p1, v0

    if-eqz v1, :cond_0

    .line 837
    nop

    .line 838
    :try_start_0
    invoke-virtual {p2}, Lio/minio/ComposeObjectArgs;->bucket()Ljava/lang/String;

    move-result-object v3

    .line 839
    invoke-virtual {p2}, Lio/minio/ComposeObjectArgs;->region()Ljava/lang/String;

    move-result-object v4

    .line 840
    invoke-virtual {p2}, Lio/minio/ComposeObjectArgs;->object()Ljava/lang/String;

    move-result-object v5

    aget-object v6, p1, v0

    .line 837
    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v2, p0

    invoke-virtual/range {v2 .. v8}, Lio/minio/MinioAsyncClient;->abortMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 844
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_6
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 854
    goto :goto_1

    .line 845
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_0

    :catch_4
    move-exception v0

    goto :goto_0

    :catch_5
    move-exception v0

    goto :goto_0

    :catch_6
    move-exception v0

    goto :goto_0

    :catch_7
    move-exception v0

    .line 853
    .local v0, "ex":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 856
    .end local v0    # "ex":Ljava/lang/Exception;
    :cond_0
    :goto_1
    new-instance v0, Ljava/util/concurrent/CompletionException;

    invoke-direct {v0, p3}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method

.method synthetic lambda$composeObject$21$io-minio-MinioAsyncClient(Lio/minio/ComposeObjectArgs;[Ljava/lang/String;[ILjava/util/List;Lio/minio/ObjectWriteResponse;)Ljava/util/concurrent/CompletionStage;
    .locals 2
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;
    .param p2, "uploadIdCopy"    # [Ljava/lang/String;
    .param p3, "partCount"    # [I
    .param p4, "sources"    # Ljava/util/List;
    .param p5, "objectWriteResponse"    # Lio/minio/ObjectWriteResponse;

    .line 661
    if-eqz p5, :cond_0

    .line 662
    invoke-static {p5}, Ljava/util/concurrent/CompletableFuture;->completedFuture(Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0

    .line 665
    :cond_0
    new-instance v0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda48;

    invoke-direct {v0, p0, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda48;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/ComposeObjectArgs;)V

    .line 666
    invoke-static {v0}, Ljava/util/concurrent/CompletableFuture;->supplyAsync(Ljava/util/function/Supplier;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda49;

    invoke-direct {v1, p0, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda49;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/ComposeObjectArgs;)V

    .line 672
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda50;

    invoke-direct {v1, p2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda50;-><init>([Ljava/lang/String;)V

    .line 690
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda51;

    invoke-direct {v1, p0, p1, p3, p4}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda51;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/ComposeObjectArgs;[ILjava/util/List;)V

    .line 696
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda52;

    invoke-direct {v1, p0, p1, p2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda52;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/ComposeObjectArgs;[Ljava/lang/String;)V

    .line 812
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 833
    .local v0, "completableFuture":Ljava/util/concurrent/CompletableFuture;, "Ljava/util/concurrent/CompletableFuture<Lio/minio/ObjectWriteResponse;>;"
    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda53;

    invoke-direct {v1, p0, p2, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda53;-><init>(Lio/minio/MinioAsyncClient;[Ljava/lang/String;Lio/minio/ComposeObjectArgs;)V

    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    .line 858
    return-object v0
.end method

.method synthetic lambda$copyObject$4$io-minio-MinioAsyncClient(Lio/minio/CopyObjectArgs;Ljava/lang/Boolean;)Ljava/util/concurrent/CompletionStage;
    .locals 2
    .param p1, "args"    # Lio/minio/CopyObjectArgs;
    .param p2, "condition"    # Ljava/lang/Boolean;

    .line 460
    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 462
    :try_start_0
    new-instance v0, Lio/minio/StatObjectArgs;

    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->source()Lio/minio/CopySource;

    move-result-object v1

    invoke-direct {v0, v1}, Lio/minio/StatObjectArgs;-><init>(Lio/minio/ObjectReadArgs;)V

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->statObjectAsync(Lio/minio/StatObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 463
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_0

    :catch_4
    move-exception v0

    goto :goto_0

    :catch_5
    move-exception v0

    .line 469
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 472
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/util/concurrent/CompletableFuture;->completedFuture(Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method synthetic lambda$copyObject$6$io-minio-MinioAsyncClient(Lio/minio/CopyObjectArgs;Ljava/lang/Long;)Ljava/util/concurrent/CompletionStage;
    .locals 4
    .param p1, "args"    # Lio/minio/CopyObjectArgs;
    .param p2, "size"    # Ljava/lang/Long;

    .line 477
    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->source()Lio/minio/CopySource;

    move-result-object v0

    invoke-virtual {v0}, Lio/minio/CopySource;->offset()Ljava/lang/Long;

    move-result-object v0

    if-nez v0, :cond_1

    .line 478
    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->source()Lio/minio/CopySource;

    move-result-object v0

    invoke-virtual {v0}, Lio/minio/CopySource;->length()Ljava/lang/Long;

    move-result-object v0

    if-nez v0, :cond_1

    .line 479
    invoke-virtual {p2}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    const-wide v2, 0x140000000L

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    goto :goto_0

    .line 503
    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/util/concurrent/CompletableFuture;->completedFuture(Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0

    .line 480
    :cond_1
    :goto_0
    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->metadataDirective()Lio/minio/Directive;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 481
    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->metadataDirective()Lio/minio/Directive;

    move-result-object v0

    sget-object v1, Lio/minio/Directive;->COPY:Lio/minio/Directive;

    if-eq v0, v1, :cond_2

    goto :goto_1

    .line 482
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "COPY metadata directive is not applicable to source object size greater than 5 GiB"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 486
    :cond_3
    :goto_1
    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->taggingDirective()Lio/minio/Directive;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->taggingDirective()Lio/minio/Directive;

    move-result-object v0

    sget-object v1, Lio/minio/Directive;->COPY:Lio/minio/Directive;

    if-eq v0, v1, :cond_4

    goto :goto_2

    .line 487
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "COPY tagging directive is not applicable to source object size greater than 5 GiB"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 493
    :cond_5
    :goto_2
    :try_start_0
    new-instance v0, Lio/minio/ComposeObjectArgs;

    invoke-direct {v0, p1}, Lio/minio/ComposeObjectArgs;-><init>(Lio/minio/CopyObjectArgs;)V

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->composeObject(Lio/minio/ComposeObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 494
    :catch_0
    move-exception v0

    goto :goto_3

    :catch_1
    move-exception v0

    goto :goto_3

    :catch_2
    move-exception v0

    goto :goto_3

    :catch_3
    move-exception v0

    goto :goto_3

    :catch_4
    move-exception v0

    goto :goto_3

    :catch_5
    move-exception v0

    .line 500
    .local v0, "e":Ljava/lang/Exception;
    :goto_3
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$copyObject$8$io-minio-MinioAsyncClient(Lio/minio/CopyObjectArgs;Lio/minio/ObjectWriteResponse;)Ljava/util/concurrent/CompletionStage;
    .locals 7
    .param p1, "args"    # Lio/minio/CopyObjectArgs;
    .param p2, "objectWriteResponse"    # Lio/minio/ObjectWriteResponse;

    .line 507
    if-eqz p2, :cond_0

    .line 508
    invoke-static {p2}, Ljava/util/concurrent/CompletableFuture;->completedFuture(Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0

    .line 511
    :cond_0
    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->genHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 513
    .local v0, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->metadataDirective()Lio/minio/Directive;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 514
    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->metadataDirective()Lio/minio/Directive;

    move-result-object v1

    invoke-virtual {v1}, Lio/minio/Directive;->name()Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "x-amz-metadata-directive"

    invoke-interface {v0, v2, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 517
    :cond_1
    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->taggingDirective()Lio/minio/Directive;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 518
    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->taggingDirective()Lio/minio/Directive;

    move-result-object v1

    invoke-virtual {v1}, Lio/minio/Directive;->name()Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "x-amz-tagging-directive"

    invoke-interface {v0, v2, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 521
    :cond_2
    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->source()Lio/minio/CopySource;

    move-result-object v1

    invoke-virtual {v1}, Lio/minio/CopySource;->genCopyHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 524
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v4, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, v0

    :try_start_0
    invoke-virtual/range {v1 .. v6}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda61;

    invoke-direct {v2, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda61;-><init>(Lio/minio/CopyObjectArgs;)V

    .line 525
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    .line 524
    return-object v1

    .line 543
    :catch_0
    move-exception v1

    goto :goto_0

    :catch_1
    move-exception v1

    goto :goto_0

    :catch_2
    move-exception v1

    goto :goto_0

    :catch_3
    move-exception v1

    goto :goto_0

    :catch_4
    move-exception v1

    goto :goto_0

    :catch_5
    move-exception v1

    .line 549
    .local v1, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v2, Ljava/util/concurrent/CompletionException;

    invoke-direct {v2, v1}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v2
.end method

.method synthetic lambda$downloadObject$1$io-minio-MinioAsyncClient(Ljava/lang/String;Lio/minio/DownloadObjectArgs;Lio/minio/StatObjectResponse;Lio/minio/GetObjectResponse;)Ljava/lang/Object;
    .locals 2
    .param p1, "filename"    # Ljava/lang/String;
    .param p2, "args"    # Lio/minio/DownloadObjectArgs;
    .param p3, "statObjectResponse"    # Lio/minio/StatObjectResponse;
    .param p4, "getObjectResponse"    # Lio/minio/GetObjectResponse;

    .line 330
    :try_start_0
    invoke-virtual {p2}, Lio/minio/DownloadObjectArgs;->overwrite()Z

    move-result v0

    invoke-direct {p0, p1, v0, p3, p4}, Lio/minio/MinioAsyncClient;->downloadObject(Ljava/lang/String;ZLio/minio/StatObjectResponse;Lio/minio/GetObjectResponse;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 331
    const/4 v0, 0x0

    return-object v0

    .line 332
    :catch_0
    move-exception v0

    .line 333
    .local v0, "e":Ljava/io/IOException;
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$makeBucket$27$io-minio-MinioAsyncClient(Lio/minio/MakeBucketArgs;Ljava/lang/String;Lokhttp3/Response;)V
    .locals 2
    .param p1, "args"    # Lio/minio/MakeBucketArgs;
    .param p2, "location"    # Ljava/lang/String;
    .param p3, "response"    # Lokhttp3/Response;

    .line 1490
    iget-object v0, p0, Lio/minio/MinioAsyncClient;->regionCache:Ljava/util/Map;

    invoke-virtual {p1}, Lio/minio/MakeBucketArgs;->bucket()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1491
    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 1492
    return-void
.end method

.method synthetic lambda$removeBucket$40$io-minio-MinioAsyncClient(Lio/minio/RemoveBucketArgs;Lokhttp3/Response;)V
    .locals 2
    .param p1, "args"    # Lio/minio/RemoveBucketArgs;
    .param p2, "response"    # Lokhttp3/Response;

    .line 1899
    iget-object v0, p0, Lio/minio/MinioAsyncClient;->regionCache:Ljava/util/Map;

    invoke-virtual {p1}, Lio/minio/RemoveBucketArgs;->bucket()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method synthetic lambda$uploadSnowballObjects$72$io-minio-MinioAsyncClient(Lio/minio/UploadSnowballObjectsArgs;Ljava/io/ByteArrayOutputStream;)Ljava/util/concurrent/CompletionStage;
    .locals 12
    .param p1, "args"    # Lio/minio/UploadSnowballObjectsArgs;
    .param p2, "baos"    # Ljava/io/ByteArrayOutputStream;

    .line 3162
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v0

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 3163
    .local v0, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->genHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 3164
    const-string v1, "X-Amz-Meta-Snowball-Auto-Extract"

    const-string/jumbo v2, "true"

    invoke-interface {v0, v1, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 3166
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->stagingFilename()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_0

    .line 3167
    invoke-virtual {p2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v10

    .line 3169
    .local v10, "data":[B
    nop

    .line 3170
    :try_start_0
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->bucket()Ljava/lang/String;

    move-result-object v2

    .line 3171
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->region()Ljava/lang/String;

    move-result-object v3

    .line 3172
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->object()Ljava/lang/String;

    move-result-object v4

    array-length v1, v10

    int-to-long v6, v1

    .line 3176
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v9

    .line 3169
    move-object v1, p0

    move-object v5, v10

    move-object v8, v0

    invoke-virtual/range {v1 .. v9}, Lio/minio/MinioAsyncClient;->putObjectAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;JLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 3177
    :catch_0
    move-exception v1

    goto :goto_0

    :catch_1
    move-exception v1

    goto :goto_0

    :catch_2
    move-exception v1

    goto :goto_0

    :catch_3
    move-exception v1

    goto :goto_0

    :catch_4
    move-exception v1

    goto :goto_0

    :catch_5
    move-exception v1

    .line 3183
    .local v1, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v2, Ljava/util/concurrent/CompletionException;

    invoke-direct {v2, v1}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v2

    .line 3187
    .end local v1    # "e":Ljava/lang/Exception;
    .end local v10    # "data":[B
    :cond_0
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->stagingFilename()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    invoke-static {v1, v2}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v1

    invoke-interface {v1}, Ljava/nio/file/Path;->toFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->length()J

    move-result-wide v10

    .line 3188
    .local v10, "length":J
    const-wide v1, 0x50000000000L

    cmp-long v1, v10, v1

    if-gtz v1, :cond_1

    .line 3192
    :try_start_1
    new-instance v5, Ljava/io/RandomAccessFile;

    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->stagingFilename()Ljava/lang/String;

    move-result-object v1

    const-string v2, "r"

    invoke-direct {v5, v1, v2}, Ljava/io/RandomAccessFile;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_1 .. :try_end_1} :catch_b
    .catch Lio/minio/errors/InternalException; {:try_start_1 .. :try_end_1} :catch_a
    .catch Ljava/security/InvalidKeyException; {:try_start_1 .. :try_end_1} :catch_9
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_6

    .line 3193
    .local v5, "file":Ljava/io/RandomAccessFile;
    nop

    .line 3194
    :try_start_2
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->bucket()Ljava/lang/String;

    move-result-object v2

    .line 3195
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->region()Ljava/lang/String;

    move-result-object v3

    .line 3196
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->object()Ljava/lang/String;

    move-result-object v4

    .line 3200
    invoke-virtual {p1}, Lio/minio/UploadSnowballObjectsArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v9

    .line 3193
    move-object v1, p0

    move-wide v6, v10

    move-object v8, v0

    invoke-virtual/range {v1 .. v9}, Lio/minio/MinioAsyncClient;->putObjectAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;JLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 3201
    :try_start_3
    invoke-virtual {v5}, Ljava/io/RandomAccessFile;->close()V
    :try_end_3
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_3 .. :try_end_3} :catch_b
    .catch Lio/minio/errors/InternalException; {:try_start_3 .. :try_end_3} :catch_a
    .catch Ljava/security/InvalidKeyException; {:try_start_3 .. :try_end_3} :catch_9
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_8
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_3 .. :try_end_3} :catch_7
    .catch Lio/minio/errors/XmlParserException; {:try_start_3 .. :try_end_3} :catch_6

    .line 3193
    return-object v1

    .line 3192
    :catchall_0
    move-exception v1

    :try_start_4
    invoke-virtual {v5}, Ljava/io/RandomAccessFile;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v2

    :try_start_5
    invoke-virtual {v1, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v10    # "length":J
    .end local p1    # "args":Lio/minio/UploadSnowballObjectsArgs;
    .end local p2    # "baos":Ljava/io/ByteArrayOutputStream;
    :goto_1
    throw v1
    :try_end_5
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_5 .. :try_end_5} :catch_b
    .catch Lio/minio/errors/InternalException; {:try_start_5 .. :try_end_5} :catch_a
    .catch Ljava/security/InvalidKeyException; {:try_start_5 .. :try_end_5} :catch_9
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_8
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_5 .. :try_end_5} :catch_7
    .catch Lio/minio/errors/XmlParserException; {:try_start_5 .. :try_end_5} :catch_6

    .line 3201
    .end local v5    # "file":Ljava/io/RandomAccessFile;
    .restart local v0    # "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v10    # "length":J
    .restart local p1    # "args":Lio/minio/UploadSnowballObjectsArgs;
    .restart local p2    # "baos":Ljava/io/ByteArrayOutputStream;
    :catch_6
    move-exception v1

    goto :goto_2

    :catch_7
    move-exception v1

    goto :goto_2

    :catch_8
    move-exception v1

    goto :goto_2

    :catch_9
    move-exception v1

    goto :goto_2

    :catch_a
    move-exception v1

    goto :goto_2

    :catch_b
    move-exception v1

    .line 3207
    .restart local v1    # "e":Ljava/lang/Exception;
    :goto_2
    new-instance v2, Ljava/util/concurrent/CompletionException;

    invoke-direct {v2, v1}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v2

    .line 3189
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_1
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "tarball size "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " is more than maximum allowed 5TiB"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public listBuckets()Ljava/util/concurrent/CompletableFuture;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/util/List<",
            "Lio/minio/messages/Bucket;",
            ">;>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1333
    invoke-static {}, Lio/minio/ListBucketsArgs;->builder()Lio/minio/ListBucketsArgs$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lio/minio/ListBucketsArgs$Builder;->build()Lio/minio/BaseArgs;

    move-result-object v0

    check-cast v0, Lio/minio/ListBucketsArgs;

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->listBuckets(Lio/minio/ListBucketsArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method public listBuckets(Lio/minio/ListBucketsArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 2
    .param p1, "args"    # Lio/minio/ListBucketsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/ListBucketsArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/util/List<",
            "Lio/minio/messages/Bucket;",
            ">;>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1355
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda6;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda6;-><init>()V

    .line 1356
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1355
    return-object v0
.end method

.method public listObjects(Lio/minio/ListObjectsArgs;)Ljava/lang/Iterable;
    .locals 1
    .param p1, "args"    # Lio/minio/ListObjectsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/ListObjectsArgs;",
            ")",
            "Ljava/lang/Iterable<",
            "Lio/minio/Result<",
            "Lio/minio/messages/Item;",
            ">;>;"
        }
    .end annotation

    .line 1304
    invoke-virtual {p1}, Lio/minio/ListObjectsArgs;->includeVersions()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {p1}, Lio/minio/ListObjectsArgs;->versionIdMarker()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 1308
    :cond_0
    invoke-virtual {p1}, Lio/minio/ListObjectsArgs;->useApiVersion1()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1309
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->listObjectsV1(Lio/minio/ListObjectsArgs;)Ljava/lang/Iterable;

    move-result-object v0

    return-object v0

    .line 1312
    :cond_1
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->listObjectsV2(Lio/minio/ListObjectsArgs;)Ljava/lang/Iterable;

    move-result-object v0

    return-object v0

    .line 1305
    :cond_2
    :goto_0
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->listObjectVersions(Lio/minio/ListObjectsArgs;)Ljava/lang/Iterable;

    move-result-object v0

    return-object v0
.end method

.method public listenBucketNotification(Lio/minio/ListenBucketNotificationArgs;)Lio/minio/CloseableIterator;
    .locals 6
    .param p1, "args"    # Lio/minio/ListenBucketNotificationArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/ListenBucketNotificationArgs;",
            ")",
            "Lio/minio/CloseableIterator<",
            "Lio/minio/Result<",
            "Lio/minio/messages/NotificationRecords;",
            ">;>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/InvalidResponseException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2629
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2631
    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "prefix"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    .line 2632
    invoke-virtual {p1}, Lio/minio/ListenBucketNotificationArgs;->prefix()Ljava/lang/String;

    move-result-object v1

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const/4 v1, 0x2

    const-string/jumbo v3, "suffix"

    aput-object v3, v0, v1

    const/4 v1, 0x3

    invoke-virtual {p1}, Lio/minio/ListenBucketNotificationArgs;->suffix()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 2633
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/ListenBucketNotificationArgs;->events()[Ljava/lang/String;

    move-result-object v1

    array-length v3, v1

    :goto_0
    if-ge v2, v3, :cond_0

    aget-object v4, v1, v2

    .line 2634
    .local v4, "event":Ljava/lang/String;
    const-string v5, "events"

    invoke-interface {v0, v5, v4}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2633
    .end local v4    # "event":Ljava/lang/String;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 2637
    :cond_0
    const/4 v1, 0x0

    .line 2639
    .local v1, "response":Lokhttp3/Response;
    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {p0, p1, v2, v0}, Lio/minio/MinioAsyncClient;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lokhttp3/Response;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v2

    .line 2644
    goto :goto_1

    .line 2642
    :catch_0
    move-exception v2

    .line 2643
    .local v2, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v2}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2645
    .end local v2    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_1
    new-instance v2, Lio/minio/S3Base$NotificationResultRecords;

    invoke-direct {v2, v1}, Lio/minio/S3Base$NotificationResultRecords;-><init>(Lokhttp3/Response;)V

    .line 2646
    .local v2, "result":Lio/minio/S3Base$NotificationResultRecords;
    invoke-virtual {v2}, Lio/minio/S3Base$NotificationResultRecords;->closeableIterator()Lio/minio/CloseableIterator;

    move-result-object v3

    return-object v3

    .line 2640
    .end local v2    # "result":Lio/minio/S3Base$NotificationResultRecords;
    :catch_1
    move-exception v2

    .line 2641
    .local v2, "e":Ljava/lang/InterruptedException;
    new-instance v3, Ljava/lang/RuntimeException;

    invoke-direct {v3, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v3
.end method

.method public makeBucket(Lio/minio/MakeBucketArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 13
    .param p1, "args"    # Lio/minio/MakeBucketArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/MakeBucketArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1458
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1460
    invoke-virtual {p1}, Lio/minio/MakeBucketArgs;->region()Ljava/lang/String;

    move-result-object v0

    .line 1461
    .local v0, "region":Ljava/lang/String;
    iget-object v1, p0, Lio/minio/MinioAsyncClient;->region:Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lio/minio/MinioAsyncClient;->region:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_2

    .line 1463
    if-eqz v0, :cond_1

    iget-object v1, p0, Lio/minio/MinioAsyncClient;->region:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 1464
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "region must be "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lio/minio/MinioAsyncClient;->region:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", but passed "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 1468
    :cond_1
    :goto_0
    iget-object v0, p0, Lio/minio/MinioAsyncClient;->region:Ljava/lang/String;

    .line 1471
    :cond_2
    if-nez v0, :cond_3

    .line 1472
    const-string/jumbo v0, "us-east-1"

    .line 1476
    :cond_3
    invoke-virtual {p1}, Lio/minio/MakeBucketArgs;->objectLock()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_4

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string/jumbo v4, "x-amz-bucket-object-lock-enabled"

    aput-object v4, v1, v3

    const/4 v3, 0x1

    const-string/jumbo v4, "true"

    aput-object v4, v1, v3

    invoke-virtual {p0, v1}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v1

    goto :goto_1

    :cond_4
    move-object v1, v2

    .line 1477
    .local v1, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :goto_1
    move-object v12, v0

    .line 1479
    .local v12, "location":Ljava/lang/String;
    sget-object v4, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;

    .line 1481
    invoke-virtual {p1}, Lio/minio/MakeBucketArgs;->bucket()Ljava/lang/String;

    move-result-object v5

    .line 1484
    invoke-virtual {p1}, Lio/minio/MakeBucketArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v3

    invoke-virtual {p0, v3, v1}, Lio/minio/MinioAsyncClient;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v3

    invoke-virtual {p0, v3}, Lio/minio/MinioAsyncClient;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v8

    .line 1485
    invoke-virtual {p1}, Lio/minio/MakeBucketArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v9

    .line 1486
    const-string/jumbo v3, "us-east-1"

    invoke-virtual {v12, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    goto :goto_2

    :cond_5
    new-instance v2, Lio/minio/messages/CreateBucketConfiguration;

    invoke-direct {v2, v12}, Lio/minio/messages/CreateBucketConfiguration;-><init>(Ljava/lang/String;)V

    :goto_2
    move-object v10, v2

    .line 1479
    const/4 v6, 0x0

    const/4 v11, 0x0

    move-object v3, p0

    move-object v7, v12

    invoke-virtual/range {v3 .. v11}, Lio/minio/MinioAsyncClient;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v2

    new-instance v3, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda1;

    invoke-direct {v3, p0, p1, v12}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda1;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/MakeBucketArgs;Ljava/lang/String;)V

    .line 1488
    invoke-virtual {v2, v3}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v2

    .line 1479
    return-object v2
.end method

.method public putObject(Lio/minio/PutObjectArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 10
    .param p1, "args"    # Lio/minio/PutObjectArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/PutObjectArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/ObjectWriteResponse;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1958
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1959
    iget-object v0, p0, Lio/minio/MinioAsyncClient;->baseUrl:Lokhttp3/HttpUrl;

    invoke-virtual {p1, v0}, Lio/minio/PutObjectArgs;->validateSse(Lokhttp3/HttpUrl;)V

    .line 1960
    nop

    .line 1962
    invoke-virtual {p1}, Lio/minio/PutObjectArgs;->stream()Ljava/io/BufferedInputStream;

    move-result-object v3

    .line 1963
    invoke-virtual {p1}, Lio/minio/PutObjectArgs;->objectSize()J

    move-result-wide v4

    .line 1964
    invoke-virtual {p1}, Lio/minio/PutObjectArgs;->partSize()J

    move-result-wide v6

    .line 1965
    invoke-virtual {p1}, Lio/minio/PutObjectArgs;->partCount()I

    move-result v8

    .line 1966
    invoke-virtual {p1}, Lio/minio/PutObjectArgs;->contentType()Ljava/lang/String;

    move-result-object v9

    .line 1960
    move-object v1, p0

    move-object v2, p1

    invoke-virtual/range {v1 .. v9}, Lio/minio/MinioAsyncClient;->putObjectAsync(Lio/minio/PutObjectBaseArgs;Ljava/lang/Object;JJILjava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method public removeBucket(Lio/minio/RemoveBucketArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 2
    .param p1, "args"    # Lio/minio/RemoveBucketArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/RemoveBucketArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1897
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1898
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, v0}, Lio/minio/MinioAsyncClient;->executeDeleteAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda16;

    invoke-direct {v1, p0, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda16;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/RemoveBucketArgs;)V

    .line 1899
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1898
    return-object v0
.end method

.method public removeObject(Lio/minio/RemoveObjectArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 6
    .param p1, "args"    # Lio/minio/RemoveObjectArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/RemoveObjectArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1080
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1081
    nop

    .line 1083
    invoke-virtual {p1}, Lio/minio/RemoveObjectArgs;->bypassGovernanceMode()Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    if-eqz v0, :cond_0

    .line 1084
    new-array v0, v3, [Ljava/lang/String;

    const-string/jumbo v5, "x-amz-bypass-governance-retention"

    aput-object v5, v0, v2

    const-string/jumbo v5, "true"

    aput-object v5, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    goto :goto_0

    .line 1085
    :cond_0
    move-object v0, v4

    .line 1086
    :goto_0
    invoke-virtual {p1}, Lio/minio/RemoveObjectArgs;->versionId()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_1

    new-array v3, v3, [Ljava/lang/String;

    const-string/jumbo v4, "versionId"

    aput-object v4, v3, v2

    invoke-virtual {p1}, Lio/minio/RemoveObjectArgs;->versionId()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v3, v1

    invoke-virtual {p0, v3}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v4

    .line 1081
    :cond_1
    invoke-virtual {p0, p1, v0, v4}, Lio/minio/MinioAsyncClient;->executeDeleteAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda7;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda7;-><init>()V

    .line 1087
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1081
    return-object v0
.end method

.method public removeObjects(Lio/minio/RemoveObjectsArgs;)Ljava/lang/Iterable;
    .locals 1
    .param p1, "args"    # Lio/minio/RemoveObjectsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/RemoveObjectsArgs;",
            ")",
            "Ljava/lang/Iterable<",
            "Lio/minio/Result<",
            "Lio/minio/messages/DeleteError;",
            ">;>;"
        }
    .end annotation

    .line 1113
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1115
    new-instance v0, Lio/minio/MinioAsyncClient$1;

    invoke-direct {v0, p0, p1}, Lio/minio/MinioAsyncClient$1;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/RemoveObjectsArgs;)V

    return-object v0
.end method

.method public restoreObject(Lio/minio/RestoreObjectArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "args"    # Lio/minio/RestoreObjectArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/RestoreObjectArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1255
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1256
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "restore"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    invoke-virtual {p1}, Lio/minio/RestoreObjectArgs;->request()Lio/minio/messages/RestoreRequest;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {p0, p1, v2, v0, v1}, Lio/minio/MinioAsyncClient;->executePostAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda23;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda23;-><init>()V

    .line 1257
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1256
    return-object v0
.end method

.method public selectObjectContent(Lio/minio/SelectObjectContentArgs;)Lio/minio/SelectResponseStream;
    .locals 11
    .param p1, "args"    # Lio/minio/SelectObjectContentArgs;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/InvalidResponseException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2698
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2699
    iget-object v0, p0, Lio/minio/MinioAsyncClient;->baseUrl:Lokhttp3/HttpUrl;

    invoke-virtual {p1, v0}, Lio/minio/SelectObjectContentArgs;->validateSsec(Lokhttp3/HttpUrl;)V

    .line 2700
    const/4 v0, 0x0

    .line 2702
    .local v0, "response":Lokhttp3/Response;
    nop

    .line 2705
    :try_start_0
    invoke-virtual {p1}, Lio/minio/SelectObjectContentArgs;->ssec()Lio/minio/ServerSideEncryptionCustomerKey;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {p1}, Lio/minio/SelectObjectContentArgs;->ssec()Lio/minio/ServerSideEncryptionCustomerKey;

    move-result-object v1

    invoke-virtual {v1}, Lio/minio/ServerSideEncryptionCustomerKey;->headers()Ljava/util/Map;

    move-result-object v1

    invoke-virtual {p0, v1}, Lio/minio/MinioAsyncClient;->newMultimap(Ljava/util/Map;)Lcom/google/common/collect/Multimap;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    const/4 v2, 0x4

    new-array v2, v2, [Ljava/lang/String;

    const-string/jumbo v3, "select"

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const-string v3, ""

    const/4 v4, 0x1

    aput-object v3, v2, v4

    const-string/jumbo v3, "select-type"

    const/4 v4, 0x2

    aput-object v3, v2, v4

    const-string v3, "2"

    const/4 v4, 0x3

    aput-object v3, v2, v4

    .line 2706
    invoke-virtual {p0, v2}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v2

    new-instance v10, Lio/minio/messages/SelectObjectContentRequest;

    .line 2708
    invoke-virtual {p1}, Lio/minio/SelectObjectContentArgs;->sqlExpression()Ljava/lang/String;

    move-result-object v4

    .line 2709
    invoke-virtual {p1}, Lio/minio/SelectObjectContentArgs;->requestProgress()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5

    .line 2710
    invoke-virtual {p1}, Lio/minio/SelectObjectContentArgs;->inputSerialization()Lio/minio/messages/InputSerialization;

    move-result-object v6

    .line 2711
    invoke-virtual {p1}, Lio/minio/SelectObjectContentArgs;->outputSerialization()Lio/minio/messages/OutputSerialization;

    move-result-object v7

    .line 2712
    invoke-virtual {p1}, Lio/minio/SelectObjectContentArgs;->scanStartRange()Ljava/lang/Long;

    move-result-object v8

    .line 2713
    invoke-virtual {p1}, Lio/minio/SelectObjectContentArgs;->scanEndRange()Ljava/lang/Long;

    move-result-object v9

    move-object v3, v10

    invoke-direct/range {v3 .. v9}, Lio/minio/messages/SelectObjectContentRequest;-><init>(Ljava/lang/String;ZLio/minio/messages/InputSerialization;Lio/minio/messages/OutputSerialization;Ljava/lang/Long;Ljava/lang/Long;)V

    .line 2703
    invoke-virtual {p0, p1, v1, v2, v10}, Lio/minio/MinioAsyncClient;->executePostAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 2714
    invoke-virtual {v1}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lokhttp3/Response;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 2719
    goto :goto_1

    .line 2717
    :catch_0
    move-exception v1

    .line 2718
    .local v1, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v1}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2720
    .end local v1    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_1
    new-instance v1, Lio/minio/SelectResponseStream;

    invoke-virtual {v0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/ResponseBody;->byteStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-direct {v1, v2}, Lio/minio/SelectResponseStream;-><init>(Ljava/io/InputStream;)V

    return-object v1

    .line 2715
    :catch_1
    move-exception v1

    .line 2716
    .local v1, "e":Ljava/lang/InterruptedException;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2
.end method

.method public setBucketEncryption(Lio/minio/SetBucketEncryptionArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "args"    # Lio/minio/SetBucketEncryptionArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/SetBucketEncryptionArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2743
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2744
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "encryption"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    invoke-virtual {p1}, Lio/minio/SetBucketEncryptionArgs;->config()Lio/minio/messages/SseConfiguration;

    move-result-object v7

    const/4 v8, 0x0

    const/4 v5, 0x0

    move-object v3, p0

    move-object v4, p1

    invoke-virtual/range {v3 .. v8}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda29;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda29;-><init>()V

    .line 2745
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2744
    return-object v0
.end method

.method public setBucketLifecycle(Lio/minio/SetBucketLifecycleArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "args"    # Lio/minio/SetBucketLifecycleArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/SetBucketLifecycleArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2254
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2255
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "lifecycle"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    invoke-virtual {p1}, Lio/minio/SetBucketLifecycleArgs;->config()Lio/minio/messages/LifecycleConfiguration;

    move-result-object v7

    const/4 v8, 0x0

    const/4 v5, 0x0

    move-object v3, p0

    move-object v4, p1

    invoke-virtual/range {v3 .. v8}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda39;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda39;-><init>()V

    .line 2256
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2255
    return-object v0
.end method

.method public setBucketNotification(Lio/minio/SetBucketNotificationArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "args"    # Lio/minio/SetBucketNotificationArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/SetBucketNotificationArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2415
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2416
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "notification"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    invoke-virtual {p1}, Lio/minio/SetBucketNotificationArgs;->config()Lio/minio/messages/NotificationConfiguration;

    move-result-object v7

    const/4 v8, 0x0

    const/4 v5, 0x0

    move-object v3, p0

    move-object v4, p1

    invoke-virtual/range {v3 .. v8}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda58;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda58;-><init>()V

    .line 2417
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2416
    return-object v0
.end method

.method public setBucketPolicy(Lio/minio/SetBucketPolicyArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 11
    .param p1, "args"    # Lio/minio/SetBucketPolicyArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/SetBucketPolicyArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2161
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2162
    const/4 v0, 0x2

    new-array v1, v0, [Ljava/lang/String;

    const-string v2, "Content-Type"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "application/json"

    const/4 v4, 0x1

    aput-object v2, v1, v4

    .line 2164
    invoke-virtual {p0, v1}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v7

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "policy"

    aput-object v1, v0, v3

    const-string v1, ""

    aput-object v1, v0, v4

    .line 2165
    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v8

    .line 2166
    invoke-virtual {p1}, Lio/minio/SetBucketPolicyArgs;->config()Ljava/lang/String;

    move-result-object v9

    .line 2162
    const/4 v10, 0x0

    move-object v5, p0

    move-object v6, p1

    invoke-virtual/range {v5 .. v10}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda63;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda63;-><init>()V

    .line 2168
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2162
    return-object v0
.end method

.method public setBucketReplication(Lio/minio/SetBucketReplicationArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 10
    .param p1, "args"    # Lio/minio/SetBucketReplicationArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/SetBucketReplicationArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2548
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2549
    nop

    .line 2551
    invoke-virtual {p1}, Lio/minio/SetBucketReplicationArgs;->objectLockToken()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    const/4 v3, 0x2

    if-eqz v0, :cond_0

    .line 2552
    new-array v0, v3, [Ljava/lang/String;

    const-string/jumbo v4, "x-amz-bucket-object-lock-token"

    aput-object v4, v0, v2

    invoke-virtual {p1}, Lio/minio/SetBucketReplicationArgs;->objectLockToken()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    move-object v6, v0

    goto :goto_0

    .line 2553
    :cond_0
    const/4 v0, 0x0

    move-object v6, v0

    :goto_0
    new-array v0, v3, [Ljava/lang/String;

    const-string v3, "replication"

    aput-object v3, v0, v2

    const-string v2, ""

    aput-object v2, v0, v1

    .line 2554
    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v7

    .line 2555
    invoke-virtual {p1}, Lio/minio/SetBucketReplicationArgs;->config()Lio/minio/messages/ReplicationConfiguration;

    move-result-object v8

    .line 2549
    const/4 v9, 0x0

    move-object v4, p0

    move-object v5, p1

    invoke-virtual/range {v4 .. v9}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda69;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda69;-><init>()V

    .line 2557
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2549
    return-object v0
.end method

.method public setBucketTags(Lio/minio/SetBucketTagsArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "args"    # Lio/minio/SetBucketTagsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/SetBucketTagsArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2933
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2934
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "tagging"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    invoke-virtual {p1}, Lio/minio/SetBucketTagsArgs;->tags()Lio/minio/messages/Tags;

    move-result-object v7

    const/4 v8, 0x0

    const/4 v5, 0x0

    move-object v3, p0

    move-object v4, p1

    invoke-virtual/range {v3 .. v8}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda72;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda72;-><init>()V

    .line 2935
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2934
    return-object v0
.end method

.method public setBucketVersioning(Lio/minio/SetBucketVersioningArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "args"    # Lio/minio/SetBucketVersioningArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/SetBucketVersioningArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1515
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1516
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "versioning"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    invoke-virtual {p1}, Lio/minio/SetBucketVersioningArgs;->config()Lio/minio/messages/VersioningConfiguration;

    move-result-object v7

    const/4 v8, 0x0

    const/4 v5, 0x0

    move-object v3, p0

    move-object v4, p1

    invoke-virtual/range {v3 .. v8}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda17;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda17;-><init>()V

    .line 1517
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1516
    return-object v0
.end method

.method public setObjectLockConfiguration(Lio/minio/SetObjectLockConfigurationArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "args"    # Lio/minio/SetObjectLockConfigurationArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/SetObjectLockConfigurationArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1578
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1579
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "object-lock"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    invoke-virtual {p1}, Lio/minio/SetObjectLockConfigurationArgs;->config()Lio/minio/messages/ObjectLockConfiguration;

    move-result-object v7

    const/4 v8, 0x0

    const/4 v5, 0x0

    move-object v3, p0

    move-object v4, p1

    invoke-virtual/range {v3 .. v8}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda24;

    invoke-direct {v1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda24;-><init>()V

    .line 1580
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1579
    return-object v0
.end method

.method public setObjectRetention(Lio/minio/SetObjectRetentionArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 11
    .param p1, "args"    # Lio/minio/SetObjectRetentionArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/SetObjectRetentionArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 1673
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1674
    const/4 v0, 0x2

    new-array v1, v0, [Ljava/lang/String;

    const-string v2, "retention"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, ""

    const/4 v4, 0x1

    aput-object v2, v1, v4

    invoke-virtual {p0, v1}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v1

    .line 1675
    .local v1, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/SetObjectRetentionArgs;->versionId()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    const-string/jumbo v2, "versionId"

    invoke-virtual {p1}, Lio/minio/SetObjectRetentionArgs;->versionId()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v1, v2, v5}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 1676
    :cond_0
    nop

    .line 1678
    invoke-virtual {p1}, Lio/minio/SetObjectRetentionArgs;->bypassGovernanceMode()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1679
    new-array v0, v0, [Ljava/lang/String;

    const-string/jumbo v2, "x-amz-bypass-governance-retention"

    aput-object v2, v0, v3

    const-string v2, "True"

    aput-object v2, v0, v4

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    move-object v7, v0

    goto :goto_0

    .line 1680
    :cond_1
    const/4 v0, 0x0

    move-object v7, v0

    .line 1682
    :goto_0
    invoke-virtual {p1}, Lio/minio/SetObjectRetentionArgs;->config()Lio/minio/messages/Retention;

    move-result-object v9

    .line 1676
    const/4 v10, 0x0

    move-object v5, p0

    move-object v6, p1

    move-object v8, v1

    invoke-virtual/range {v5 .. v10}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda33;

    invoke-direct {v2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda33;-><init>()V

    .line 1684
    invoke-virtual {v0, v2}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1676
    return-object v0
.end method

.method public setObjectTags(Lio/minio/SetObjectTagsArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "args"    # Lio/minio/SetObjectTagsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/SetObjectTagsArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Void;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 3027
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 3028
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "tagging"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 3029
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/SetObjectTagsArgs;->versionId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const-string/jumbo v1, "versionId"

    invoke-virtual {p1}, Lio/minio/SetObjectTagsArgs;->versionId()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 3030
    :cond_0
    invoke-virtual {p1}, Lio/minio/SetObjectTagsArgs;->tags()Lio/minio/messages/Tags;

    move-result-object v7

    const/4 v8, 0x0

    const/4 v5, 0x0

    move-object v3, p0

    move-object v4, p1

    move-object v6, v0

    invoke-virtual/range {v3 .. v8}, Lio/minio/MinioAsyncClient;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda28;

    invoke-direct {v2}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda28;-><init>()V

    .line 3031
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 3030
    return-object v1
.end method

.method public statObject(Lio/minio/StatObjectArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 1
    .param p1, "args"    # Lio/minio/StatObjectArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/StatObjectArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/StatObjectResponse;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 212
    invoke-super {p0, p1}, Lio/minio/S3Base;->statObjectAsync(Lio/minio/StatObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method public uploadObject(Lio/minio/UploadObjectArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 12
    .param p1, "args"    # Lio/minio/UploadObjectArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/UploadObjectArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/ObjectWriteResponse;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2000
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 2001
    iget-object v0, p0, Lio/minio/MinioAsyncClient;->baseUrl:Lokhttp3/HttpUrl;

    invoke-virtual {p1, v0}, Lio/minio/UploadObjectArgs;->validateSse(Lokhttp3/HttpUrl;)V

    .line 2002
    new-instance v0, Ljava/io/RandomAccessFile;

    invoke-virtual {p1}, Lio/minio/UploadObjectArgs;->filename()Ljava/lang/String;

    move-result-object v1

    const-string v2, "r"

    invoke-direct {v0, v1, v2}, Ljava/io/RandomAccessFile;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 2003
    .local v0, "file":Ljava/io/RandomAccessFile;
    nop

    .line 2004
    invoke-virtual {p1}, Lio/minio/UploadObjectArgs;->objectSize()J

    move-result-wide v6

    invoke-virtual {p1}, Lio/minio/UploadObjectArgs;->partSize()J

    move-result-wide v8

    invoke-virtual {p1}, Lio/minio/UploadObjectArgs;->partCount()I

    move-result v10

    invoke-virtual {p1}, Lio/minio/UploadObjectArgs;->contentType()Ljava/lang/String;

    move-result-object v11

    .line 2003
    move-object v3, p0

    move-object v4, p1

    move-object v5, v0

    invoke-virtual/range {v3 .. v11}, Lio/minio/MinioAsyncClient;->putObjectAsync(Lio/minio/PutObjectBaseArgs;Ljava/lang/Object;JJILjava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda59;

    invoke-direct {v2, v0}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda59;-><init>(Ljava/io/RandomAccessFile;)V

    .line 2005
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda60;

    invoke-direct {v2, v0}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda60;-><init>(Ljava/io/RandomAccessFile;)V

    .line 2025
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 2003
    return-object v1
.end method

.method public uploadSnowballObjects(Lio/minio/UploadSnowballObjectsArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 2
    .param p1, "args"    # Lio/minio/UploadSnowballObjectsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/UploadSnowballObjectsArgs;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/ObjectWriteResponse;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 3096
    invoke-virtual {p0, p1}, Lio/minio/MinioAsyncClient;->checkArgs(Lio/minio/BaseArgs;)V

    .line 3098
    new-instance v0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda4;

    invoke-direct {v0, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda4;-><init>(Lio/minio/UploadSnowballObjectsArgs;)V

    invoke-static {v0}, Ljava/util/concurrent/CompletableFuture;->supplyAsync(Ljava/util/function/Supplier;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda5;

    invoke-direct {v1, p0, p1}, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda5;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/UploadSnowballObjectsArgs;)V

    .line 3160
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 3098
    return-object v0
.end method
