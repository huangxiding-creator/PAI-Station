.class abstract Lio/minio/S3Base$ObjectIterator;
.super Ljava/lang/Object;
.source "S3Base.java"

# interfaces
.implements Ljava/util/Iterator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/S3Base;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x402
    name = "ObjectIterator"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Iterator<",
        "Lio/minio/Result<",
        "Lio/minio/messages/Item;",
        ">;>;"
    }
.end annotation


# instance fields
.field protected completed:Z

.field protected deleteMarkerIterator:Ljava/util/Iterator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Iterator<",
            "Lio/minio/messages/DeleteMarker;",
            ">;"
        }
    .end annotation
.end field

.field protected error:Lio/minio/Result;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lio/minio/Result<",
            "Lio/minio/messages/Item;",
            ">;"
        }
    .end annotation
.end field

.field protected itemIterator:Ljava/util/Iterator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Iterator<",
            "+",
            "Lio/minio/messages/Item;",
            ">;"
        }
    .end annotation
.end field

.field protected lastObjectName:Ljava/lang/String;

.field protected listObjectsResult:Lio/minio/messages/ListObjectsResult;

.field protected prefixIterator:Ljava/util/Iterator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Iterator<",
            "Lio/minio/messages/Prefix;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lio/minio/S3Base;


# direct methods
.method private constructor <init>(Lio/minio/S3Base;)V
    .locals 0

    .line 1249
    iput-object p1, p0, Lio/minio/S3Base$ObjectIterator;->this$0:Lio/minio/S3Base;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1254
    const/4 p1, 0x0

    iput-boolean p1, p0, Lio/minio/S3Base$ObjectIterator;->completed:Z

    return-void
.end method

.method synthetic constructor <init>(Lio/minio/S3Base;Lio/minio/S3Base$1;)V
    .locals 0
    .param p1, "x0"    # Lio/minio/S3Base;
    .param p2, "x1"    # Lio/minio/S3Base$1;

    .line 1249
    invoke-direct {p0, p1}, Lio/minio/S3Base$ObjectIterator;-><init>(Lio/minio/S3Base;)V

    return-void
.end method


# virtual methods
.method public hasNext()Z
    .locals 3

    .line 1291
    iget-boolean v0, p0, Lio/minio/S3Base$ObjectIterator;->completed:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    .line 1293
    :cond_0
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->error:Lio/minio/Result;

    if-nez v0, :cond_1

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->itemIterator:Ljava/util/Iterator;

    if-nez v0, :cond_1

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->deleteMarkerIterator:Ljava/util/Iterator;

    if-nez v0, :cond_1

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->prefixIterator:Ljava/util/Iterator;

    if-nez v0, :cond_1

    .line 1297
    invoke-virtual {p0}, Lio/minio/S3Base$ObjectIterator;->populate()V

    .line 1300
    :cond_1
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->error:Lio/minio/Result;

    if-nez v0, :cond_2

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->itemIterator:Ljava/util/Iterator;

    .line 1301
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->deleteMarkerIterator:Ljava/util/Iterator;

    .line 1302
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->prefixIterator:Ljava/util/Iterator;

    .line 1303
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    .line 1304
    invoke-virtual {v0}, Lio/minio/messages/ListObjectsResult;->isTruncated()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1305
    invoke-virtual {p0}, Lio/minio/S3Base$ObjectIterator;->populate()V

    .line 1308
    :cond_2
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->error:Lio/minio/Result;

    const/4 v2, 0x1

    if-eqz v0, :cond_3

    return v2

    .line 1309
    :cond_3
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->itemIterator:Ljava/util/Iterator;

    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    return v2

    .line 1310
    :cond_4
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->deleteMarkerIterator:Ljava/util/Iterator;

    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    return v2

    .line 1311
    :cond_5
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->prefixIterator:Ljava/util/Iterator;

    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    return v2

    .line 1313
    :cond_6
    iput-boolean v2, p0, Lio/minio/S3Base$ObjectIterator;->completed:Z

    .line 1314
    return v1
.end method

.method public next()Lio/minio/Result;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lio/minio/Result<",
            "Lio/minio/messages/Item;",
            ">;"
        }
    .end annotation

    .line 1319
    iget-boolean v0, p0, Lio/minio/S3Base$ObjectIterator;->completed:Z

    if-nez v0, :cond_7

    .line 1320
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->error:Lio/minio/Result;

    if-nez v0, :cond_0

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->itemIterator:Ljava/util/Iterator;

    if-nez v0, :cond_0

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->deleteMarkerIterator:Ljava/util/Iterator;

    if-nez v0, :cond_0

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->prefixIterator:Ljava/util/Iterator;

    if-nez v0, :cond_0

    .line 1324
    invoke-virtual {p0}, Lio/minio/S3Base$ObjectIterator;->populate()V

    .line 1327
    :cond_0
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->error:Lio/minio/Result;

    if-nez v0, :cond_1

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->itemIterator:Ljava/util/Iterator;

    .line 1328
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->deleteMarkerIterator:Ljava/util/Iterator;

    .line 1329
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->prefixIterator:Ljava/util/Iterator;

    .line 1330
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    .line 1331
    invoke-virtual {v0}, Lio/minio/messages/ListObjectsResult;->isTruncated()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1332
    invoke-virtual {p0}, Lio/minio/S3Base$ObjectIterator;->populate()V

    .line 1335
    :cond_1
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->error:Lio/minio/Result;

    const/4 v1, 0x1

    if-eqz v0, :cond_2

    .line 1336
    iput-boolean v1, p0, Lio/minio/S3Base$ObjectIterator;->completed:Z

    .line 1337
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->error:Lio/minio/Result;

    return-object v0

    .line 1340
    :cond_2
    const/4 v0, 0x0

    .line 1341
    .local v0, "item":Lio/minio/messages/Item;
    iget-object v2, p0, Lio/minio/S3Base$ObjectIterator;->itemIterator:Ljava/util/Iterator;

    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 1342
    iget-object v2, p0, Lio/minio/S3Base$ObjectIterator;->itemIterator:Ljava/util/Iterator;

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    move-object v0, v2

    check-cast v0, Lio/minio/messages/Item;

    .line 1343
    iget-object v2, p0, Lio/minio/S3Base$ObjectIterator;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    invoke-virtual {v2}, Lio/minio/messages/ListObjectsResult;->encodingType()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lio/minio/messages/Item;->setEncodingType(Ljava/lang/String;)V

    .line 1344
    invoke-virtual {v0}, Lio/minio/messages/Item;->objectName()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lio/minio/S3Base$ObjectIterator;->lastObjectName:Ljava/lang/String;

    goto :goto_0

    .line 1345
    :cond_3
    iget-object v2, p0, Lio/minio/S3Base$ObjectIterator;->deleteMarkerIterator:Ljava/util/Iterator;

    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    .line 1346
    iget-object v2, p0, Lio/minio/S3Base$ObjectIterator;->deleteMarkerIterator:Ljava/util/Iterator;

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    move-object v0, v2

    check-cast v0, Lio/minio/messages/Item;

    goto :goto_0

    .line 1347
    :cond_4
    iget-object v2, p0, Lio/minio/S3Base$ObjectIterator;->prefixIterator:Ljava/util/Iterator;

    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 1348
    iget-object v2, p0, Lio/minio/S3Base$ObjectIterator;->prefixIterator:Ljava/util/Iterator;

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lio/minio/messages/Prefix;

    invoke-virtual {v2}, Lio/minio/messages/Prefix;->toItem()Lio/minio/messages/Item;

    move-result-object v0

    .line 1351
    :cond_5
    :goto_0
    if-eqz v0, :cond_6

    .line 1352
    iget-object v1, p0, Lio/minio/S3Base$ObjectIterator;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    invoke-virtual {v1}, Lio/minio/messages/ListObjectsResult;->encodingType()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lio/minio/messages/Item;->setEncodingType(Ljava/lang/String;)V

    .line 1353
    new-instance v1, Lio/minio/Result;

    invoke-direct {v1, v0}, Lio/minio/Result;-><init>(Ljava/lang/Object;)V

    return-object v1

    .line 1356
    :cond_6
    iput-boolean v1, p0, Lio/minio/S3Base$ObjectIterator;->completed:Z

    .line 1357
    new-instance v1, Ljava/util/NoSuchElementException;

    invoke-direct {v1}, Ljava/util/NoSuchElementException;-><init>()V

    throw v1

    .line 1319
    .end local v0    # "item":Lio/minio/messages/Item;
    :cond_7
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0
.end method

.method public bridge synthetic next()Ljava/lang/Object;
    .locals 1

    .line 1249
    invoke-virtual {p0}, Lio/minio/S3Base$ObjectIterator;->next()Lio/minio/Result;

    move-result-object v0

    return-object v0
.end method

.method protected declared-synchronized populate()V
    .locals 2

    monitor-enter p0

    .line 1265
    :try_start_0
    invoke-virtual {p0}, Lio/minio/S3Base$ObjectIterator;->populateResult()V
    :try_end_0
    .catch Lio/minio/errors/ErrorResponseException; {:try_start_0 .. :try_end_0} :catch_8
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_6
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InvalidResponseException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Lio/minio/errors/ServerException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1276
    goto :goto_1

    .line 1264
    .end local p0    # "this":Lio/minio/S3Base$ObjectIterator;
    :catchall_0
    move-exception v0

    goto :goto_3

    .line 1266
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

    goto :goto_0

    :catch_8
    move-exception v0

    .line 1275
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    :try_start_1
    new-instance v1, Lio/minio/Result;

    invoke-direct {v1, v0}, Lio/minio/Result;-><init>(Ljava/lang/Exception;)V

    iput-object v1, p0, Lio/minio/S3Base$ObjectIterator;->error:Lio/minio/Result;

    .line 1278
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    if-eqz v0, :cond_0

    .line 1279
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    invoke-virtual {v0}, Lio/minio/messages/ListObjectsResult;->contents()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base$ObjectIterator;->itemIterator:Ljava/util/Iterator;

    .line 1280
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    invoke-virtual {v0}, Lio/minio/messages/ListObjectsResult;->deleteMarkers()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base$ObjectIterator;->deleteMarkerIterator:Ljava/util/Iterator;

    .line 1281
    iget-object v0, p0, Lio/minio/S3Base$ObjectIterator;->listObjectsResult:Lio/minio/messages/ListObjectsResult;

    invoke-virtual {v0}, Lio/minio/messages/ListObjectsResult;->commonPrefixes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base$ObjectIterator;->prefixIterator:Ljava/util/Iterator;

    goto :goto_2

    .line 1283
    :cond_0
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    invoke-virtual {v0}, Ljava/util/LinkedList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base$ObjectIterator;->itemIterator:Ljava/util/Iterator;

    .line 1284
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    invoke-virtual {v0}, Ljava/util/LinkedList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base$ObjectIterator;->deleteMarkerIterator:Ljava/util/Iterator;

    .line 1285
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    invoke-virtual {v0}, Ljava/util/LinkedList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base$ObjectIterator;->prefixIterator:Ljava/util/Iterator;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1287
    :goto_2
    monitor-exit p0

    return-void

    .line 1264
    :goto_3
    monitor-exit p0

    throw v0
.end method

.method protected abstract populateResult()V
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
.end method

.method public remove()V
    .locals 1

    .line 1362
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method
