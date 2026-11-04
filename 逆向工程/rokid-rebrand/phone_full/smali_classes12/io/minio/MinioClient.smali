.class public Lio/minio/MinioClient;
.super Ljava/lang/Object;
.source "MinioClient.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/MinioClient$Builder;
    }
.end annotation


# instance fields
.field private asyncClient:Lio/minio/MinioAsyncClient;


# direct methods
.method private constructor <init>(Lio/minio/MinioAsyncClient;)V
    .locals 1
    .param p1, "asyncClient"    # Lio/minio/MinioAsyncClient;

    .line 101
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 99
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    .line 102
    iput-object p1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    .line 103
    return-void
.end method

.method synthetic constructor <init>(Lio/minio/MinioAsyncClient;Lio/minio/MinioClient$1;)V
    .locals 0
    .param p1, "x0"    # Lio/minio/MinioAsyncClient;
    .param p2, "x1"    # Lio/minio/MinioClient$1;

    .line 98
    invoke-direct {p0, p1}, Lio/minio/MinioClient;-><init>(Lio/minio/MinioAsyncClient;)V

    return-void
.end method

.method protected constructor <init>(Lio/minio/MinioClient;)V
    .locals 1
    .param p1, "client"    # Lio/minio/MinioClient;

    .line 105
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 99
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    .line 106
    iget-object v0, p1, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    iput-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    .line 107
    return-void
.end method

.method public static builder()Lio/minio/MinioClient$Builder;
    .locals 1

    .line 2439
    new-instance v0, Lio/minio/MinioClient$Builder;

    invoke-direct {v0}, Lio/minio/MinioClient$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public bucketExists(Lio/minio/BucketExistsArgs;)Z
    .locals 2
    .param p1, "args"    # Lio/minio/BucketExistsArgs;
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

    .line 853
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->bucketExists(Lio/minio/BucketExistsArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 856
    :catch_0
    move-exception v0

    .line 857
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 858
    const/4 v1, 0x0

    return v1

    .line 854
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 855
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public composeObject(Lio/minio/ComposeObjectArgs;)Lio/minio/ObjectWriteResponse;
    .locals 2
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;
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

    .line 444
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->composeObject(Lio/minio/ComposeObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ObjectWriteResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 447
    :catch_0
    move-exception v0

    .line 448
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 449
    const/4 v1, 0x0

    return-object v1

    .line 445
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 446
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public copyObject(Lio/minio/CopyObjectArgs;)Lio/minio/ObjectWriteResponse;
    .locals 2
    .param p1, "args"    # Lio/minio/CopyObjectArgs;
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

    .line 373
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->copyObject(Lio/minio/CopyObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ObjectWriteResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 376
    :catch_0
    move-exception v0

    .line 377
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 378
    const/4 v1, 0x0

    return-object v1

    .line 374
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 375
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public deleteBucketEncryption(Lio/minio/DeleteBucketEncryptionArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/DeleteBucketEncryptionArgs;
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

    .line 2083
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->deleteBucketEncryption(Lio/minio/DeleteBucketEncryptionArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2088
    goto :goto_0

    .line 2086
    :catch_0
    move-exception v0

    .line 2087
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2089
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 2084
    :catch_1
    move-exception v0

    .line 2085
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public deleteBucketLifecycle(Lio/minio/DeleteBucketLifecycleArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/DeleteBucketLifecycleArgs;
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

    .line 1612
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->deleteBucketLifecycle(Lio/minio/DeleteBucketLifecycleArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1617
    goto :goto_0

    .line 1615
    :catch_0
    move-exception v0

    .line 1616
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1618
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1613
    :catch_1
    move-exception v0

    .line 1614
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public deleteBucketNotification(Lio/minio/DeleteBucketNotificationArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/DeleteBucketNotificationArgs;
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

    .line 1763
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->deleteBucketNotification(Lio/minio/DeleteBucketNotificationArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1768
    goto :goto_0

    .line 1766
    :catch_0
    move-exception v0

    .line 1767
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1769
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1764
    :catch_1
    move-exception v0

    .line 1765
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public deleteBucketPolicy(Lio/minio/DeleteBucketPolicyArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/DeleteBucketPolicyArgs;
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

    .line 1537
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->deleteBucketPolicy(Lio/minio/DeleteBucketPolicyArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1542
    goto :goto_0

    .line 1540
    :catch_0
    move-exception v0

    .line 1541
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1543
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1538
    :catch_1
    move-exception v0

    .line 1539
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public deleteBucketReplication(Lio/minio/DeleteBucketReplicationArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/DeleteBucketReplicationArgs;
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

    .line 1885
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->deleteBucketReplication(Lio/minio/DeleteBucketReplicationArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1890
    goto :goto_0

    .line 1888
    :catch_0
    move-exception v0

    .line 1889
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1891
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1886
    :catch_1
    move-exception v0

    .line 1887
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public deleteBucketTags(Lio/minio/DeleteBucketTagsArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/DeleteBucketTagsArgs;
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

    .line 2183
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->deleteBucketTags(Lio/minio/DeleteBucketTagsArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2188
    goto :goto_0

    .line 2186
    :catch_0
    move-exception v0

    .line 2187
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2189
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 2184
    :catch_1
    move-exception v0

    .line 2185
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public deleteObjectLockConfiguration(Lio/minio/DeleteObjectLockConfigurationArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/DeleteObjectLockConfigurationArgs;
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

    .line 1037
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->deleteObjectLockConfiguration(Lio/minio/DeleteObjectLockConfigurationArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1042
    goto :goto_0

    .line 1040
    :catch_0
    move-exception v0

    .line 1041
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1043
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1038
    :catch_1
    move-exception v0

    .line 1039
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public deleteObjectTags(Lio/minio/DeleteObjectTagsArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/DeleteObjectTagsArgs;
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

    .line 2289
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->deleteObjectTags(Lio/minio/DeleteObjectTagsArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2294
    goto :goto_0

    .line 2292
    :catch_0
    move-exception v0

    .line 2293
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2295
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 2290
    :catch_1
    move-exception v0

    .line 2291
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public disableAccelerateEndpoint()V
    .locals 1

    .line 2415
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0}, Lio/minio/MinioAsyncClient;->disableAccelerateEndpoint()V

    .line 2416
    return-void
.end method

.method public disableDualStackEndpoint()V
    .locals 1

    .line 2425
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0}, Lio/minio/MinioAsyncClient;->disableDualStackEndpoint()V

    .line 2426
    return-void
.end method

.method public disableObjectLegalHold(Lio/minio/DisableObjectLegalHoldArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/DisableObjectLegalHoldArgs;
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

    .line 1226
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->disableObjectLegalHold(Lio/minio/DisableObjectLegalHoldArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1231
    goto :goto_0

    .line 1229
    :catch_0
    move-exception v0

    .line 1230
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1232
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1227
    :catch_1
    move-exception v0

    .line 1228
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public disableVirtualStyleEndpoint()V
    .locals 1

    .line 2435
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0}, Lio/minio/MinioAsyncClient;->disableVirtualStyleEndpoint()V

    .line 2436
    return-void
.end method

.method public downloadObject(Lio/minio/DownloadObjectArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/DownloadObjectArgs;
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

    .line 247
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->downloadObject(Lio/minio/DownloadObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 252
    goto :goto_0

    .line 250
    :catch_0
    move-exception v0

    .line 251
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 253
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 248
    :catch_1
    move-exception v0

    .line 249
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public enableAccelerateEndpoint()V
    .locals 1

    .line 2410
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0}, Lio/minio/MinioAsyncClient;->enableAccelerateEndpoint()V

    .line 2411
    return-void
.end method

.method public enableDualStackEndpoint()V
    .locals 1

    .line 2420
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0}, Lio/minio/MinioAsyncClient;->enableDualStackEndpoint()V

    .line 2421
    return-void
.end method

.method public enableObjectLegalHold(Lio/minio/EnableObjectLegalHoldArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/EnableObjectLegalHoldArgs;
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

    .line 1190
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->enableObjectLegalHold(Lio/minio/EnableObjectLegalHoldArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1195
    goto :goto_0

    .line 1193
    :catch_0
    move-exception v0

    .line 1194
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1196
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1191
    :catch_1
    move-exception v0

    .line 1192
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public enableVirtualStyleEndpoint()V
    .locals 1

    .line 2430
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0}, Lio/minio/MinioAsyncClient;->enableVirtualStyleEndpoint()V

    .line 2431
    return-void
.end method

.method public getBucketEncryption(Lio/minio/GetBucketEncryptionArgs;)Lio/minio/messages/SseConfiguration;
    .locals 2
    .param p1, "args"    # Lio/minio/GetBucketEncryptionArgs;
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

    .line 2050
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getBucketEncryption(Lio/minio/GetBucketEncryptionArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/SseConfiguration;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2053
    :catch_0
    move-exception v0

    .line 2054
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2055
    const/4 v1, 0x0

    return-object v1

    .line 2051
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 2052
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getBucketLifecycle(Lio/minio/GetBucketLifecycleArgs;)Lio/minio/messages/LifecycleConfiguration;
    .locals 2
    .param p1, "args"    # Lio/minio/GetBucketLifecycleArgs;
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

    .line 1647
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getBucketLifecycle(Lio/minio/GetBucketLifecycleArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/LifecycleConfiguration;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1650
    :catch_0
    move-exception v0

    .line 1651
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1652
    const/4 v1, 0x0

    return-object v1

    .line 1648
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1649
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getBucketNotification(Lio/minio/GetBucketNotificationArgs;)Lio/minio/messages/NotificationConfiguration;
    .locals 2
    .param p1, "args"    # Lio/minio/GetBucketNotificationArgs;
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

    .line 1682
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getBucketNotification(Lio/minio/GetBucketNotificationArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/NotificationConfiguration;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1685
    :catch_0
    move-exception v0

    .line 1686
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1687
    const/4 v1, 0x0

    return-object v1

    .line 1683
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1684
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getBucketPolicy(Lio/minio/GetBucketPolicyArgs;)Ljava/lang/String;
    .locals 2
    .param p1, "args"    # Lio/minio/GetBucketPolicyArgs;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/BucketPolicyTooLargeException;,
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

    .line 1451
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getBucketPolicy(Lio/minio/GetBucketPolicyArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1454
    :catch_0
    move-exception v0

    .line 1455
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1456
    const-string v1, ""

    return-object v1

    .line 1452
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1453
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getBucketReplication(Lio/minio/GetBucketReplicationArgs;)Lio/minio/messages/ReplicationConfiguration;
    .locals 2
    .param p1, "args"    # Lio/minio/GetBucketReplicationArgs;
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

    .line 1797
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getBucketReplication(Lio/minio/GetBucketReplicationArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ReplicationConfiguration;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1800
    :catch_0
    move-exception v0

    .line 1801
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1802
    const/4 v1, 0x0

    return-object v1

    .line 1798
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1799
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getBucketTags(Lio/minio/GetBucketTagsArgs;)Lio/minio/messages/Tags;
    .locals 2
    .param p1, "args"    # Lio/minio/GetBucketTagsArgs;
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

    .line 2116
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getBucketTags(Lio/minio/GetBucketTagsArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Tags;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2119
    :catch_0
    move-exception v0

    .line 2120
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2121
    const/4 v1, 0x0

    return-object v1

    .line 2117
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 2118
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getBucketVersioning(Lio/minio/GetBucketVersioningArgs;)Lio/minio/messages/VersioningConfiguration;
    .locals 2
    .param p1, "args"    # Lio/minio/GetBucketVersioningArgs;
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

    .line 970
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getBucketVersioning(Lio/minio/GetBucketVersioningArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/VersioningConfiguration;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 973
    :catch_0
    move-exception v0

    .line 974
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 975
    const/4 v1, 0x0

    return-object v1

    .line 971
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 972
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getObject(Lio/minio/GetObjectArgs;)Lio/minio/GetObjectResponse;
    .locals 2
    .param p1, "args"    # Lio/minio/GetObjectArgs;
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

    .line 209
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getObject(Lio/minio/GetObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/GetObjectResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 212
    :catch_0
    move-exception v0

    .line 213
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 214
    const/4 v1, 0x0

    return-object v1

    .line 210
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 211
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getObjectLockConfiguration(Lio/minio/GetObjectLockConfigurationArgs;)Lio/minio/messages/ObjectLockConfiguration;
    .locals 2
    .param p1, "args"    # Lio/minio/GetObjectLockConfigurationArgs;
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

    .line 1074
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getObjectLockConfiguration(Lio/minio/GetObjectLockConfigurationArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ObjectLockConfiguration;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1077
    :catch_0
    move-exception v0

    .line 1078
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1079
    const/4 v1, 0x0

    return-object v1

    .line 1075
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1076
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getObjectRetention(Lio/minio/GetObjectRetentionArgs;)Lio/minio/messages/Retention;
    .locals 2
    .param p1, "args"    # Lio/minio/GetObjectRetentionArgs;
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

    .line 1153
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getObjectRetention(Lio/minio/GetObjectRetentionArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Retention;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1156
    :catch_0
    move-exception v0

    .line 1157
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1158
    const/4 v1, 0x0

    return-object v1

    .line 1154
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1155
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getObjectTags(Lio/minio/GetObjectTagsArgs;)Lio/minio/messages/Tags;
    .locals 2
    .param p1, "args"    # Lio/minio/GetObjectTagsArgs;
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

    .line 2217
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getObjectTags(Lio/minio/GetObjectTagsArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Tags;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2220
    :catch_0
    move-exception v0

    .line 2221
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2222
    const/4 v1, 0x0

    return-object v1

    .line 2218
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 2219
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public getPresignedObjectUrl(Lio/minio/GetPresignedObjectUrlArgs;)Ljava/lang/String;
    .locals 1
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

    .line 515
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getPresignedObjectUrl(Lio/minio/GetPresignedObjectUrlArgs;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getPresignedPostFormData(Lio/minio/PostPolicy;)Ljava/util/Map;
    .locals 1
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

    .line 580
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->getPresignedPostFormData(Lio/minio/PostPolicy;)Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public ignoreCertCheck()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/KeyManagementException;,
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 2374
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0}, Lio/minio/MinioAsyncClient;->ignoreCertCheck()V

    .line 2375
    return-void
.end method

.method public isObjectLegalHoldEnabled(Lio/minio/IsObjectLegalHoldEnabledArgs;)Z
    .locals 2
    .param p1, "args"    # Lio/minio/IsObjectLegalHoldEnabledArgs;
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

    .line 1270
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->isObjectLegalHoldEnabled(Lio/minio/IsObjectLegalHoldEnabledArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 1273
    :catch_0
    move-exception v0

    .line 1274
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1275
    const/4 v1, 0x0

    return v1

    .line 1271
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1272
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public listBuckets()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/Bucket;",
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

    .line 778
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0}, Lio/minio/MinioAsyncClient;->listBuckets()Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 781
    :catch_0
    move-exception v0

    .line 782
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 783
    const/4 v1, 0x0

    return-object v1

    .line 779
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 780
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public listBuckets(Lio/minio/ListBucketsArgs;)Ljava/util/List;
    .locals 2
    .param p1, "args"    # Lio/minio/ListBucketsArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/ListBucketsArgs;",
            ")",
            "Ljava/util/List<",
            "Lio/minio/messages/Bucket;",
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

    .line 814
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->listBuckets(Lio/minio/ListBucketsArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 817
    :catch_0
    move-exception v0

    .line 818
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 819
    const/4 v1, 0x0

    return-object v1

    .line 815
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 816
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
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

    .line 749
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->listObjects(Lio/minio/ListObjectsArgs;)Ljava/lang/Iterable;

    move-result-object v0

    return-object v0
.end method

.method public listenBucketNotification(Lio/minio/ListenBucketNotificationArgs;)Lio/minio/CloseableIterator;
    .locals 1
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

    .line 1937
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->listenBucketNotification(Lio/minio/ListenBucketNotificationArgs;)Lio/minio/CloseableIterator;

    move-result-object v0

    return-object v0
.end method

.method public makeBucket(Lio/minio/MakeBucketArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/MakeBucketArgs;
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

    .line 904
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->makeBucket(Lio/minio/MakeBucketArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 909
    goto :goto_0

    .line 907
    :catch_0
    move-exception v0

    .line 908
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 910
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 905
    :catch_1
    move-exception v0

    .line 906
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public putObject(Lio/minio/PutObjectArgs;)Lio/minio/ObjectWriteResponse;
    .locals 2
    .param p1, "args"    # Lio/minio/PutObjectArgs;
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

    .line 1371
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->putObject(Lio/minio/PutObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ObjectWriteResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1374
    :catch_0
    move-exception v0

    .line 1375
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1376
    const/4 v1, 0x0

    return-object v1

    .line 1372
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1373
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public removeBucket(Lio/minio/RemoveBucketArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/RemoveBucketArgs;
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

    .line 1302
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->removeBucket(Lio/minio/RemoveBucketArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1307
    goto :goto_0

    .line 1305
    :catch_0
    move-exception v0

    .line 1306
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1308
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1303
    :catch_1
    move-exception v0

    .line 1304
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public removeObject(Lio/minio/RemoveObjectArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/RemoveObjectArgs;
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

    .line 625
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->removeObject(Lio/minio/RemoveObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 630
    goto :goto_0

    .line 628
    :catch_0
    move-exception v0

    .line 629
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 631
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 626
    :catch_1
    move-exception v0

    .line 627
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
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

    .line 656
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->removeObjects(Lio/minio/RemoveObjectsArgs;)Ljava/lang/Iterable;

    move-result-object v0

    return-object v0
.end method

.method public restoreObject(Lio/minio/RestoreObjectArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/RestoreObjectArgs;
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

    .line 697
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->restoreObject(Lio/minio/RestoreObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 702
    goto :goto_0

    .line 700
    :catch_0
    move-exception v0

    .line 701
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 703
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 698
    :catch_1
    move-exception v0

    .line 699
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public selectObjectContent(Lio/minio/SelectObjectContentArgs;)Lio/minio/SelectResponseStream;
    .locals 1
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

    .line 1989
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->selectObjectContent(Lio/minio/SelectObjectContentArgs;)Lio/minio/SelectResponseStream;

    move-result-object v0

    return-object v0
.end method

.method public setAppInfo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "version"    # Ljava/lang/String;

    .line 2385
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1, p2}, Lio/minio/MinioAsyncClient;->setAppInfo(Ljava/lang/String;Ljava/lang/String;)V

    .line 2386
    return-void
.end method

.method public setBucketEncryption(Lio/minio/SetBucketEncryptionArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/SetBucketEncryptionArgs;
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

    .line 2016
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->setBucketEncryption(Lio/minio/SetBucketEncryptionArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2021
    goto :goto_0

    .line 2019
    :catch_0
    move-exception v0

    .line 2020
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2022
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 2017
    :catch_1
    move-exception v0

    .line 2018
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setBucketLifecycle(Lio/minio/SetBucketLifecycleArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/SetBucketLifecycleArgs;
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

    .line 1581
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->setBucketLifecycle(Lio/minio/SetBucketLifecycleArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1586
    goto :goto_0

    .line 1584
    :catch_0
    move-exception v0

    .line 1585
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1587
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1582
    :catch_1
    move-exception v0

    .line 1583
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setBucketNotification(Lio/minio/SetBucketNotificationArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/SetBucketNotificationArgs;
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

    .line 1731
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->setBucketNotification(Lio/minio/SetBucketNotificationArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1736
    goto :goto_0

    .line 1734
    :catch_0
    move-exception v0

    .line 1735
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1737
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1732
    :catch_1
    move-exception v0

    .line 1733
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setBucketPolicy(Lio/minio/SetBucketPolicyArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/SetBucketPolicyArgs;
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

    .line 1506
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->setBucketPolicy(Lio/minio/SetBucketPolicyArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1511
    goto :goto_0

    .line 1509
    :catch_0
    move-exception v0

    .line 1510
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1512
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1507
    :catch_1
    move-exception v0

    .line 1508
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setBucketReplication(Lio/minio/SetBucketReplicationArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/SetBucketReplicationArgs;
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

    .line 1853
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->setBucketReplication(Lio/minio/SetBucketReplicationArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1858
    goto :goto_0

    .line 1856
    :catch_0
    move-exception v0

    .line 1857
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1859
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1854
    :catch_1
    move-exception v0

    .line 1855
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setBucketTags(Lio/minio/SetBucketTagsArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/SetBucketTagsArgs;
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

    .line 2152
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->setBucketTags(Lio/minio/SetBucketTagsArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2157
    goto :goto_0

    .line 2155
    :catch_0
    move-exception v0

    .line 2156
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2158
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 2153
    :catch_1
    move-exception v0

    .line 2154
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setBucketVersioning(Lio/minio/SetBucketVersioningArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/SetBucketVersioningArgs;
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

    .line 936
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->setBucketVersioning(Lio/minio/SetBucketVersioningArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 941
    goto :goto_0

    .line 939
    :catch_0
    move-exception v0

    .line 940
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 942
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 937
    :catch_1
    move-exception v0

    .line 938
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setObjectLockConfiguration(Lio/minio/SetObjectLockConfigurationArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/SetObjectLockConfigurationArgs;
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

    .line 1005
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->setObjectLockConfiguration(Lio/minio/SetObjectLockConfigurationArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1010
    goto :goto_0

    .line 1008
    :catch_0
    move-exception v0

    .line 1009
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1011
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1006
    :catch_1
    move-exception v0

    .line 1007
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setObjectRetention(Lio/minio/SetObjectRetentionArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/SetObjectRetentionArgs;
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

    .line 1114
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->setObjectRetention(Lio/minio/SetObjectRetentionArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1119
    goto :goto_0

    .line 1117
    :catch_0
    move-exception v0

    .line 1118
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1120
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 1115
    :catch_1
    move-exception v0

    .line 1116
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setObjectTags(Lio/minio/SetObjectTagsArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/SetObjectTagsArgs;
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

    .line 2257
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->setObjectTags(Lio/minio/SetObjectTagsArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2262
    goto :goto_0

    .line 2260
    :catch_0
    move-exception v0

    .line 2261
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2263
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_0
    return-void

    .line 2258
    :catch_1
    move-exception v0

    .line 2259
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public setTimeout(JJJ)V
    .locals 7
    .param p1, "connectTimeout"    # J
    .param p3, "writeTimeout"    # J
    .param p5, "readTimeout"    # J

    .line 2359
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    move-wide v1, p1

    move-wide v3, p3

    move-wide v5, p5

    invoke-virtual/range {v0 .. v6}, Lio/minio/MinioAsyncClient;->setTimeout(JJJ)V

    .line 2360
    return-void
.end method

.method public statObject(Lio/minio/StatObjectArgs;)Lio/minio/StatObjectResponse;
    .locals 2
    .param p1, "args"    # Lio/minio/StatObjectArgs;
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

    .line 165
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->statObject(Lio/minio/StatObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/StatObjectResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 168
    :catch_0
    move-exception v0

    .line 169
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 170
    const/4 v1, 0x0

    return-object v1

    .line 166
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 167
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public traceOff()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2405
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0}, Lio/minio/MinioAsyncClient;->traceOff()V

    .line 2406
    return-void
.end method

.method public traceOn(Ljava/io/OutputStream;)V
    .locals 1
    .param p1, "traceStream"    # Ljava/io/OutputStream;

    .line 2395
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->traceOn(Ljava/io/OutputStream;)V

    .line 2396
    return-void
.end method

.method public uploadObject(Lio/minio/UploadObjectArgs;)Lio/minio/ObjectWriteResponse;
    .locals 2
    .param p1, "args"    # Lio/minio/UploadObjectArgs;
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

    .line 1416
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->uploadObject(Lio/minio/UploadObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ObjectWriteResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1419
    :catch_0
    move-exception v0

    .line 1420
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1421
    const/4 v1, 0x0

    return-object v1

    .line 1417
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1418
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public uploadSnowballObjects(Lio/minio/UploadSnowballObjectsArgs;)Lio/minio/ObjectWriteResponse;
    .locals 2
    .param p1, "args"    # Lio/minio/UploadSnowballObjectsArgs;
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

    .line 2336
    :try_start_0
    iget-object v0, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient;->uploadSnowballObjects(Lio/minio/UploadSnowballObjectsArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ObjectWriteResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2339
    :catch_0
    move-exception v0

    .line 2340
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    iget-object v1, p0, Lio/minio/MinioClient;->asyncClient:Lio/minio/MinioAsyncClient;

    invoke-virtual {v1, v0}, Lio/minio/MinioAsyncClient;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2341
    const/4 v1, 0x0

    return-object v1

    .line 2337
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 2338
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method
