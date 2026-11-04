.class Lio/minio/S3Base$2$1;
.super Lio/minio/S3Base$ObjectIterator;
.source "S3Base.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/minio/S3Base$2;->iterator()Ljava/util/Iterator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private result:Lio/minio/messages/ListBucketResultV2;

.field final synthetic this$1:Lio/minio/S3Base$2;


# direct methods
.method constructor <init>(Lio/minio/S3Base$2;)V
    .locals 2
    .param p1, "this$1"    # Lio/minio/S3Base$2;

    .line 1371
    iput-object p1, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v0, p1, Lio/minio/S3Base$2;->this$0:Lio/minio/S3Base;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lio/minio/S3Base$ObjectIterator;-><init>(Lio/minio/S3Base;Lio/minio/S3Base$1;)V

    .line 1372
    iput-object v1, p0, Lio/minio/S3Base$2$1;->result:Lio/minio/messages/ListBucketResultV2;

    return-void
.end method


# virtual methods
.method protected populateResult()V
    .locals 15
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

    .line 1379
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/S3Base$2$1;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    .line 1380
    iput-object v0, p0, Lio/minio/S3Base$2$1;->itemIterator:Ljava/util/Iterator;

    .line 1381
    iput-object v0, p0, Lio/minio/S3Base$2$1;->prefixIterator:Ljava/util/Iterator;

    .line 1383
    iget-object v1, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v2, v1, Lio/minio/S3Base$2;->this$0:Lio/minio/S3Base;

    iget-object v1, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v1, v1, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    .line 1385
    invoke-virtual {v1}, Lio/minio/ListObjectsArgs;->bucket()Ljava/lang/String;

    move-result-object v3

    iget-object v1, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v1, v1, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    .line 1386
    invoke-virtual {v1}, Lio/minio/ListObjectsArgs;->region()Ljava/lang/String;

    move-result-object v4

    iget-object v1, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v1, v1, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    .line 1387
    invoke-virtual {v1}, Lio/minio/ListObjectsArgs;->delimiter()Ljava/lang/String;

    move-result-object v5

    .line 1388
    iget-object v1, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v1, v1, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    invoke-virtual {v1}, Lio/minio/ListObjectsArgs;->useUrlEncodingType()Z

    move-result v1

    if-eqz v1, :cond_0

    const-string/jumbo v0, "url"

    :cond_0
    move-object v6, v0

    iget-object v0, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v0, v0, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    .line 1389
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->startAfter()Ljava/lang/String;

    move-result-object v7

    iget-object v0, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v0, v0, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    .line 1390
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->maxKeys()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    iget-object v0, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v0, v0, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    .line 1391
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->prefix()Ljava/lang/String;

    move-result-object v9

    .line 1392
    iget-object v0, p0, Lio/minio/S3Base$2$1;->result:Lio/minio/messages/ListBucketResultV2;

    if-nez v0, :cond_1

    iget-object v0, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v0, v0, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->continuationToken()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lio/minio/S3Base$2$1;->result:Lio/minio/messages/ListBucketResultV2;

    invoke-virtual {v0}, Lio/minio/messages/ListBucketResultV2;->nextContinuationToken()Ljava/lang/String;

    move-result-object v0

    :goto_0
    move-object v10, v0

    iget-object v0, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v0, v0, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    .line 1393
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->fetchOwner()Z

    move-result v11

    iget-object v0, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v0, v0, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    .line 1394
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->includeUserMetadata()Z

    move-result v12

    iget-object v0, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v0, v0, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    .line 1395
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v13

    iget-object v0, p0, Lio/minio/S3Base$2$1;->this$1:Lio/minio/S3Base$2;

    iget-object v0, v0, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

    .line 1396
    invoke-virtual {v0}, Lio/minio/ListObjectsArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v14

    .line 1384
    invoke-virtual/range {v2 .. v14}, Lio/minio/S3Base;->listObjectsV2(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;ZZLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/ListObjectsV2Response;

    move-result-object v0

    .line 1397
    .local v0, "response":Lio/minio/ListObjectsV2Response;
    invoke-virtual {v0}, Lio/minio/ListObjectsV2Response;->result()Lio/minio/messages/ListBucketResultV2;

    move-result-object v1

    iput-object v1, p0, Lio/minio/S3Base$2$1;->result:Lio/minio/messages/ListBucketResultV2;

    .line 1398
    invoke-virtual {v0}, Lio/minio/ListObjectsV2Response;->result()Lio/minio/messages/ListBucketResultV2;

    move-result-object v1

    iput-object v1, p0, Lio/minio/S3Base$2$1;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    .line 1399
    return-void
.end method
