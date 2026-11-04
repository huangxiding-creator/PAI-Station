.class public Lcom/rokid/security/phone/sdk/server/filesystem/MyMinioAsyncClient;
.super Lio/minio/MinioAsyncClient;
.source "MyMinioAsyncClient.java"


# direct methods
.method protected constructor <init>(Lio/minio/MinioAsyncClient;)V
    .locals 0
    .param p1, "client"    # Lio/minio/MinioAsyncClient;

    .line 23
    invoke-direct {p0, p1}, Lio/minio/MinioAsyncClient;-><init>(Lio/minio/MinioAsyncClient;)V

    .line 24
    return-void
.end method


# virtual methods
.method protected completeMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Lio/minio/messages/Part;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "uploadId"    # Ljava/lang/String;
    .param p5, "parts"    # [Lio/minio/messages/Part;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "[",
            "Lio/minio/messages/Part;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
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

    .line 45
    .local p6, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p7, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-super/range {p0 .. p7}, Lio/minio/MinioAsyncClient;->completeMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Lio/minio/messages/Part;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method protected createMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/CreateMultipartUploadResponse;",
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

    .line 33
    .local p4, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p5, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-super/range {p0 .. p5}, Lio/minio/MinioAsyncClient;->createMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method protected listPartsAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "maxParts"    # Ljava/lang/Integer;
    .param p5, "partNumberMarker"    # Ljava/lang/Integer;
    .param p6, "uploadId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/ListPartsResponse;",
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

    .line 58
    .local p7, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p8, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-super/range {p0 .. p8}, Lio/minio/MinioAsyncClient;->listPartsAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method protected uploadPartAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;JLjava/lang/String;ILcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "data"    # Ljava/lang/Object;
    .param p5, "length"    # J
    .param p7, "uploadId"    # Ljava/lang/String;
    .param p8, "partNumber"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            "J",
            "Ljava/lang/String;",
            "I",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/UploadPartResponse;",
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

    .line 72
    .local p9, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p10, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-super/range {p0 .. p10}, Lio/minio/MinioAsyncClient;->uploadPartAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;JLjava/lang/String;ILcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method
