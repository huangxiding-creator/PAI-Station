.class Lio/minio/S3Base$3$1;
.super Lio/minio/S3Base$ObjectIterator;
.source "S3Base.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/minio/S3Base$3;->iterator()Ljava/util/Iterator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private result:Lio/minio/messages/ListBucketResultV1;

.field final synthetic this$1:Lio/minio/S3Base$3;


# direct methods
.method constructor <init>(Lio/minio/S3Base$3;)V
    .locals 2
    .param p1, "this$1"    # Lio/minio/S3Base$3;

    .line 1410
    iput-object p1, p0, Lio/minio/S3Base$3$1;->this$1:Lio/minio/S3Base$3;

    iget-object v0, p1, Lio/minio/S3Base$3;->this$0:Lio/minio/S3Base;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lio/minio/S3Base$ObjectIterator;-><init>(Lio/minio/S3Base;Lio/minio/S3Base$1;)V

    .line 1411
    iput-object v1, p0, Lio/minio/S3Base$3$1;->result:Lio/minio/messages/ListBucketResultV1;

    return-void
.end method


# virtual methods
.method protected populateResult()V
    .locals 12
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

    .line 1418
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/S3Base$3$1;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    .line 1419
    iput-object v0, p0, Lio/minio/S3Base$3$1;->itemIterator:Ljava/util/Iterator;

    .line 1420
    iput-object v0, p0, Lio/minio/S3Base$3$1;->prefixIterator:Ljava/util/Iterator;

    .line 1422
    iget-object v1, p0, Lio/minio/S3Base$3$1;->result:Lio/minio/messages/ListBucketResultV1;

    if-nez v1, :cond_0

    iget-object v1, p0, Lio/minio/S3Base$3$1;->this$1:Lio/minio/S3Base$3;

    iget-object v1, v1, Lio/minio/S3Base$3;->val$args:Lio/minio/ListObjectsArgs;

    invoke-virtual {v1}, Lio/minio/ListObjectsArgs;->marker()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lio/minio/S3Base$3$1;->result:Lio/minio/messages/ListBucketResultV1;

    invoke-virtual {v1}, Lio/minio/messages/ListBucketResultV1;->nextMarker()Ljava/lang/String;

    move-result-object v1

    .line 1423
    .local v1, "nextMarker":Ljava/lang/String;
    :goto_0
    if-nez v1, :cond_1

    iget-object v1, p0, Lio/minio/S3Base$3$1;->lastObjectName:Ljava/lang/String;

    .line 1425
    :cond_1
    iget-object v2, p0, Lio/minio/S3Base$3$1;->this$1:Lio/minio/S3Base$3;

    iget-object v2, v2, Lio/minio/S3Base$3;->this$0:Lio/minio/S3Base;

    iget-object v3, p0, Lio/minio/S3Base$3$1;->this$1:Lio/minio/S3Base$3;

    iget-object v3, v3, Lio/minio/S3Base$3;->val$args:Lio/minio/ListObjectsArgs;

    .line 1427
    invoke-virtual {v3}, Lio/minio/ListObjectsArgs;->bucket()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lio/minio/S3Base$3$1;->this$1:Lio/minio/S3Base$3;

    iget-object v4, v4, Lio/minio/S3Base$3;->val$args:Lio/minio/ListObjectsArgs;

    .line 1428
    invoke-virtual {v4}, Lio/minio/ListObjectsArgs;->region()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lio/minio/S3Base$3$1;->this$1:Lio/minio/S3Base$3;

    iget-object v5, v5, Lio/minio/S3Base$3;->val$args:Lio/minio/ListObjectsArgs;

    .line 1429
    invoke-virtual {v5}, Lio/minio/ListObjectsArgs;->delimiter()Ljava/lang/String;

    move-result-object v5

    .line 1430
    iget-object v6, p0, Lio/minio/S3Base$3$1;->this$1:Lio/minio/S3Base$3;

    iget-object v6, v6, Lio/minio/S3Base$3;->val$args:Lio/minio/ListObjectsArgs;

    invoke-virtual {v6}, Lio/minio/ListObjectsArgs;->useUrlEncodingType()Z

    move-result v6

    if-eqz v6, :cond_2

    const-string/jumbo v0, "url"

    :cond_2
    move-object v6, v0

    iget-object v0, p0, Lio/minio/S3Base$3$1;->this$1:Lio/minio/S3Base$3;

    iget-object v0, v0, Lio/minio/S3Base$3;->val$args:Lio/minio/ListObjectsArgs;

    .line 1432
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->maxKeys()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    iget-object v0, p0, Lio/minio/S3Base$3$1;->this$1:Lio/minio/S3Base$3;

    iget-object v0, v0, Lio/minio/S3Base$3;->val$args:Lio/minio/ListObjectsArgs;

    .line 1433
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->prefix()Ljava/lang/String;

    move-result-object v9

    iget-object v0, p0, Lio/minio/S3Base$3$1;->this$1:Lio/minio/S3Base$3;

    iget-object v0, v0, Lio/minio/S3Base$3;->val$args:Lio/minio/ListObjectsArgs;

    .line 1434
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v10

    iget-object v0, p0, Lio/minio/S3Base$3$1;->this$1:Lio/minio/S3Base$3;

    iget-object v0, v0, Lio/minio/S3Base$3;->val$args:Lio/minio/ListObjectsArgs;

    .line 1435
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v11

    .line 1426
    move-object v7, v1

    invoke-virtual/range {v2 .. v11}, Lio/minio/S3Base;->listObjectsV1(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/ListObjectsV1Response;

    move-result-object v0

    .line 1436
    .local v0, "response":Lio/minio/ListObjectsV1Response;
    invoke-virtual {v0}, Lio/minio/ListObjectsV1Response;->result()Lio/minio/messages/ListBucketResultV1;

    move-result-object v2

    iput-object v2, p0, Lio/minio/S3Base$3$1;->result:Lio/minio/messages/ListBucketResultV1;

    .line 1437
    invoke-virtual {v0}, Lio/minio/ListObjectsV1Response;->result()Lio/minio/messages/ListBucketResultV1;

    move-result-object v2

    iput-object v2, p0, Lio/minio/S3Base$3$1;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    .line 1438
    return-void
.end method
