.class Lio/minio/S3Base$4$1;
.super Lio/minio/S3Base$ObjectIterator;
.source "S3Base.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/minio/S3Base$4;->iterator()Ljava/util/Iterator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private result:Lio/minio/messages/ListVersionsResult;

.field final synthetic this$1:Lio/minio/S3Base$4;


# direct methods
.method constructor <init>(Lio/minio/S3Base$4;)V
    .locals 2
    .param p1, "this$1"    # Lio/minio/S3Base$4;

    .line 1449
    iput-object p1, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v0, p1, Lio/minio/S3Base$4;->this$0:Lio/minio/S3Base;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lio/minio/S3Base$ObjectIterator;-><init>(Lio/minio/S3Base;Lio/minio/S3Base$1;)V

    .line 1450
    iput-object v1, p0, Lio/minio/S3Base$4$1;->result:Lio/minio/messages/ListVersionsResult;

    return-void
.end method


# virtual methods
.method protected populateResult()V
    .locals 13
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

    .line 1457
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/S3Base$4$1;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    .line 1458
    iput-object v0, p0, Lio/minio/S3Base$4$1;->itemIterator:Ljava/util/Iterator;

    .line 1459
    iput-object v0, p0, Lio/minio/S3Base$4$1;->prefixIterator:Ljava/util/Iterator;

    .line 1461
    iget-object v1, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v2, v1, Lio/minio/S3Base$4;->this$0:Lio/minio/S3Base;

    iget-object v1, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v1, v1, Lio/minio/S3Base$4;->val$args:Lio/minio/ListObjectsArgs;

    .line 1463
    invoke-virtual {v1}, Lio/minio/ListObjectsArgs;->bucket()Ljava/lang/String;

    move-result-object v3

    iget-object v1, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v1, v1, Lio/minio/S3Base$4;->val$args:Lio/minio/ListObjectsArgs;

    .line 1464
    invoke-virtual {v1}, Lio/minio/ListObjectsArgs;->region()Ljava/lang/String;

    move-result-object v4

    iget-object v1, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v1, v1, Lio/minio/S3Base$4;->val$args:Lio/minio/ListObjectsArgs;

    .line 1465
    invoke-virtual {v1}, Lio/minio/ListObjectsArgs;->delimiter()Ljava/lang/String;

    move-result-object v5

    .line 1466
    iget-object v1, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v1, v1, Lio/minio/S3Base$4;->val$args:Lio/minio/ListObjectsArgs;

    invoke-virtual {v1}, Lio/minio/ListObjectsArgs;->useUrlEncodingType()Z

    move-result v1

    if-eqz v1, :cond_0

    const-string/jumbo v0, "url"

    :cond_0
    move-object v6, v0

    .line 1467
    iget-object v0, p0, Lio/minio/S3Base$4$1;->result:Lio/minio/messages/ListVersionsResult;

    if-nez v0, :cond_1

    iget-object v0, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v0, v0, Lio/minio/S3Base$4;->val$args:Lio/minio/ListObjectsArgs;

    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->keyMarker()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lio/minio/S3Base$4$1;->result:Lio/minio/messages/ListVersionsResult;

    invoke-virtual {v0}, Lio/minio/messages/ListVersionsResult;->nextKeyMarker()Ljava/lang/String;

    move-result-object v0

    :goto_0
    move-object v7, v0

    iget-object v0, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v0, v0, Lio/minio/S3Base$4;->val$args:Lio/minio/ListObjectsArgs;

    .line 1468
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->maxKeys()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    iget-object v0, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v0, v0, Lio/minio/S3Base$4;->val$args:Lio/minio/ListObjectsArgs;

    .line 1469
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->prefix()Ljava/lang/String;

    move-result-object v9

    .line 1470
    iget-object v0, p0, Lio/minio/S3Base$4$1;->result:Lio/minio/messages/ListVersionsResult;

    if-nez v0, :cond_2

    iget-object v0, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v0, v0, Lio/minio/S3Base$4;->val$args:Lio/minio/ListObjectsArgs;

    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->versionIdMarker()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lio/minio/S3Base$4$1;->result:Lio/minio/messages/ListVersionsResult;

    invoke-virtual {v0}, Lio/minio/messages/ListVersionsResult;->nextVersionIdMarker()Ljava/lang/String;

    move-result-object v0

    :goto_1
    move-object v10, v0

    iget-object v0, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v0, v0, Lio/minio/S3Base$4;->val$args:Lio/minio/ListObjectsArgs;

    .line 1471
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v11

    iget-object v0, p0, Lio/minio/S3Base$4$1;->this$1:Lio/minio/S3Base$4;

    iget-object v0, v0, Lio/minio/S3Base$4;->val$args:Lio/minio/ListObjectsArgs;

    .line 1472
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v12

    .line 1462
    invoke-virtual/range {v2 .. v12}, Lio/minio/S3Base;->listObjectVersions(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/ListObjectVersionsResponse;

    move-result-object v0

    .line 1473
    .local v0, "response":Lio/minio/ListObjectVersionsResponse;
    invoke-virtual {v0}, Lio/minio/ListObjectVersionsResponse;->result()Lio/minio/messages/ListVersionsResult;

    move-result-object v1

    iput-object v1, p0, Lio/minio/S3Base$4$1;->result:Lio/minio/messages/ListVersionsResult;

    .line 1474
    invoke-virtual {v0}, Lio/minio/ListObjectVersionsResponse;->result()Lio/minio/messages/ListVersionsResult;

    move-result-object v1

    iput-object v1, p0, Lio/minio/S3Base$4$1;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    .line 1475
    return-void
.end method
