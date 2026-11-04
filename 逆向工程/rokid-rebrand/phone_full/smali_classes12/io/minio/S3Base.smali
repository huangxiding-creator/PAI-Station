.class public abstract Lio/minio/S3Base;
.super Ljava/lang/Object;
.source "S3Base.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/S3Base$NotificationResultRecords;,
        Lio/minio/S3Base$ObjectIterator;
    }
.end annotation


# static fields
.field protected static final DEFAULT_CONNECTION_TIMEOUT:J

.field private static final END_HTTP:Ljava/lang/String; = "----------END-HTTP----------"

.field protected static final MAX_BUCKET_POLICY_SIZE:I = 0x5000

.field protected static final NO_SUCH_BUCKET:Ljava/lang/String; = "NoSuchBucket"

.field protected static final NO_SUCH_BUCKET_MESSAGE:Ljava/lang/String; = "Bucket does not exist"

.field protected static final NO_SUCH_BUCKET_POLICY:Ljava/lang/String; = "NoSuchBucketPolicy"

.field protected static final NO_SUCH_OBJECT_LOCK_CONFIGURATION:Ljava/lang/String; = "NoSuchObjectLockConfiguration"

.field private static final RETRY_HEAD:Ljava/lang/String; = "RetryHead"

.field protected static final SERVER_SIDE_ENCRYPTION_CONFIGURATION_NOT_FOUND_ERROR:Ljava/lang/String; = "ServerSideEncryptionConfigurationNotFoundError"

.field private static final TRACE_QUERY_PARAMS:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final UPLOAD_ID:Ljava/lang/String; = "uploadId"

.field protected static final US_EAST_1:Ljava/lang/String; = "us-east-1"


# instance fields
.field protected baseUrl:Lokhttp3/HttpUrl;

.field private httpClient:Lokhttp3/OkHttpClient;

.field private isAccelerateHost:Z

.field private isAwsHost:Z

.field private isDualStackHost:Z

.field private isFipsHost:Z

.field protected provider:Lio/minio/credentials/Provider;

.field protected region:Ljava/lang/String;

.field protected final regionCache:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private traceStream:Ljava/io/PrintWriter;

.field private useVirtualStyle:Z

.field private userAgent:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 107
    const/4 v0, 0x0

    :try_start_0
    new-array v0, v0, [B

    const/4 v1, 0x0

    invoke-static {v1, v0}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;[B)Lokhttp3/RequestBody;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodError; {:try_start_0 .. :try_end_0} :catch_0

    .line 112
    nop

    .line 121
    sget-object v0, Ljava/util/concurrent/TimeUnit;->MINUTES:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v1, 0x5

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v0

    sput-wide v0, Lio/minio/S3Base;->DEFAULT_CONNECTION_TIMEOUT:J

    .line 130
    nop

    .line 131
    const-string v0, "retention"

    const-string v1, "legal-hold"

    const-string/jumbo v2, "tagging"

    const-string/jumbo v3, "uploadId"

    invoke-static {v0, v1, v2, v3}, Lcom/google/common/collect/ImmutableSet;->of(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Lcom/google/common/collect/ImmutableSet;

    move-result-object v0

    sput-object v0, Lio/minio/S3Base;->TRACE_QUERY_PARAMS:Ljava/util/Set;

    .line 130
    return-void

    .line 110
    :catch_0
    move-exception v0

    .line 111
    .local v0, "ex":Ljava/lang/NoSuchMethodError;
    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "Unsupported OkHttp library found. Must use okhttp >= 4.8.1"

    invoke-direct {v1, v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected constructor <init>(Lio/minio/S3Base;)V
    .locals 1
    .param p1, "client"    # Lio/minio/S3Base;

    .line 167
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 125
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lio/minio/S3Base;->regionCache:Ljava/util/Map;

    .line 133
    sget-object v0, Lio/minio/MinioProperties;->INSTANCE:Lio/minio/MinioProperties;

    invoke-virtual {v0}, Lio/minio/MinioProperties;->getDefaultUserAgent()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base;->userAgent:Ljava/lang/String;

    .line 168
    iget-object v0, p1, Lio/minio/S3Base;->baseUrl:Lokhttp3/HttpUrl;

    iput-object v0, p0, Lio/minio/S3Base;->baseUrl:Lokhttp3/HttpUrl;

    .line 169
    iget-object v0, p1, Lio/minio/S3Base;->region:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/S3Base;->region:Ljava/lang/String;

    .line 170
    iget-boolean v0, p1, Lio/minio/S3Base;->isAwsHost:Z

    iput-boolean v0, p0, Lio/minio/S3Base;->isAwsHost:Z

    .line 171
    iget-boolean v0, p1, Lio/minio/S3Base;->isFipsHost:Z

    iput-boolean v0, p0, Lio/minio/S3Base;->isFipsHost:Z

    .line 172
    iget-boolean v0, p1, Lio/minio/S3Base;->isAccelerateHost:Z

    iput-boolean v0, p0, Lio/minio/S3Base;->isAccelerateHost:Z

    .line 173
    iget-boolean v0, p1, Lio/minio/S3Base;->isDualStackHost:Z

    iput-boolean v0, p0, Lio/minio/S3Base;->isDualStackHost:Z

    .line 174
    iget-boolean v0, p1, Lio/minio/S3Base;->useVirtualStyle:Z

    iput-boolean v0, p0, Lio/minio/S3Base;->useVirtualStyle:Z

    .line 175
    iget-object v0, p1, Lio/minio/S3Base;->provider:Lio/minio/credentials/Provider;

    iput-object v0, p0, Lio/minio/S3Base;->provider:Lio/minio/credentials/Provider;

    .line 176
    iget-object v0, p1, Lio/minio/S3Base;->httpClient:Lokhttp3/OkHttpClient;

    iput-object v0, p0, Lio/minio/S3Base;->httpClient:Lokhttp3/OkHttpClient;

    .line 177
    return-void
.end method

.method protected constructor <init>(Lokhttp3/HttpUrl;Ljava/lang/String;ZZZZZLio/minio/credentials/Provider;Lokhttp3/OkHttpClient;)V
    .locals 1
    .param p1, "baseUrl"    # Lokhttp3/HttpUrl;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "isAwsHost"    # Z
    .param p4, "isFipsHost"    # Z
    .param p5, "isAccelerateHost"    # Z
    .param p6, "isDualStackHost"    # Z
    .param p7, "useVirtualStyle"    # Z
    .param p8, "provider"    # Lio/minio/credentials/Provider;
    .param p9, "httpClient"    # Lokhttp3/OkHttpClient;

    .line 155
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 125
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lio/minio/S3Base;->regionCache:Ljava/util/Map;

    .line 133
    sget-object v0, Lio/minio/MinioProperties;->INSTANCE:Lio/minio/MinioProperties;

    invoke-virtual {v0}, Lio/minio/MinioProperties;->getDefaultUserAgent()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base;->userAgent:Ljava/lang/String;

    .line 156
    iput-object p1, p0, Lio/minio/S3Base;->baseUrl:Lokhttp3/HttpUrl;

    .line 157
    iput-object p2, p0, Lio/minio/S3Base;->region:Ljava/lang/String;

    .line 158
    iput-boolean p3, p0, Lio/minio/S3Base;->isAwsHost:Z

    .line 159
    iput-boolean p4, p0, Lio/minio/S3Base;->isFipsHost:Z

    .line 160
    iput-boolean p5, p0, Lio/minio/S3Base;->isAccelerateHost:Z

    .line 161
    iput-boolean p6, p0, Lio/minio/S3Base;->isDualStackHost:Z

    .line 162
    iput-boolean p7, p0, Lio/minio/S3Base;->useVirtualStyle:Z

    .line 163
    iput-object p8, p0, Lio/minio/S3Base;->provider:Lio/minio/credentials/Provider;

    .line 164
    iput-object p9, p0, Lio/minio/S3Base;->httpClient:Lokhttp3/OkHttpClient;

    .line 165
    return-void
.end method

.method static synthetic access$000()Ljava/util/Set;
    .locals 1

    .line 104
    sget-object v0, Lio/minio/S3Base;->TRACE_QUERY_PARAMS:Ljava/util/Set;

    return-object v0
.end method

.method static synthetic access$100(Lio/minio/S3Base;Lio/minio/http/Method;Ljava/lang/String;Lokhttp3/Response;Z)[Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lio/minio/S3Base;
    .param p1, "x1"    # Lio/minio/http/Method;
    .param p2, "x2"    # Ljava/lang/String;
    .param p3, "x3"    # Lokhttp3/Response;
    .param p4, "x4"    # Z

    .line 104
    invoke-direct {p0, p1, p2, p3, p4}, Lio/minio/S3Base;->handleRedirectResponse(Lio/minio/http/Method;Ljava/lang/String;Lokhttp3/Response;Z)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private getCommonListObjectsQueryParams(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Lcom/google/common/collect/Multimap;
    .locals 4
    .param p1, "delimiter"    # Ljava/lang/String;
    .param p2, "encodingType"    # Ljava/lang/String;
    .param p3, "maxKeys"    # Ljava/lang/Integer;
    .param p4, "prefix"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 1606
    const/4 v0, 0x6

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "delimiter"

    aput-object v2, v0, v1

    .line 1609
    const-string v1, ""

    if-nez p1, :cond_0

    move-object v2, v1

    goto :goto_0

    :cond_0
    move-object v2, p1

    :goto_0
    const/4 v3, 0x1

    aput-object v2, v0, v3

    const/4 v2, 0x2

    const-string v3, "max-keys"

    aput-object v3, v0, v2

    .line 1611
    invoke-virtual {p3}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-lez v2, :cond_1

    invoke-virtual {p3}, Ljava/lang/Integer;->intValue()I

    move-result v2

    goto :goto_1

    :cond_1
    const/16 v2, 0x3e8

    :goto_1
    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x3

    aput-object v2, v0, v3

    const/4 v2, 0x4

    const-string v3, "prefix"

    aput-object v3, v0, v2

    .line 1613
    if-nez p4, :cond_2

    goto :goto_2

    :cond_2
    move-object v1, p4

    :goto_2
    const/4 v2, 0x5

    aput-object v1, v0, v2

    .line 1607
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 1614
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz p2, :cond_3

    const-string v1, "encoding-type"

    invoke-interface {v0, v1, p2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 1615
    :cond_3
    return-object v0
.end method

.method private handleRedirectResponse(Lio/minio/http/Method;Ljava/lang/String;Lokhttp3/Response;Z)[Ljava/lang/String;
    .locals 5
    .param p1, "method"    # Lio/minio/http/Method;
    .param p2, "bucketName"    # Ljava/lang/String;
    .param p3, "response"    # Lokhttp3/Response;
    .param p4, "retry"    # Z

    .line 254
    const/4 v0, 0x0

    .line 255
    .local v0, "code":Ljava/lang/String;
    const/4 v1, 0x0

    .line 257
    .local v1, "message":Ljava/lang/String;
    invoke-virtual {p3}, Lokhttp3/Response;->code()I

    move-result v2

    const/16 v3, 0x12d

    if-ne v2, v3, :cond_0

    .line 258
    const-string v0, "PermanentRedirect"

    .line 259
    const-string v1, "Moved Permanently"

    goto :goto_0

    .line 260
    :cond_0
    invoke-virtual {p3}, Lokhttp3/Response;->code()I

    move-result v2

    const/16 v3, 0x133

    if-ne v2, v3, :cond_1

    .line 261
    const-string v0, "Redirect"

    .line 262
    const-string v1, "Temporary redirect"

    goto :goto_0

    .line 263
    :cond_1
    invoke-virtual {p3}, Lokhttp3/Response;->code()I

    move-result v2

    const/16 v3, 0x190

    if-ne v2, v3, :cond_2

    .line 264
    const-string v0, "BadRequest"

    .line 265
    const-string v1, "Bad request"

    .line 268
    :cond_2
    :goto_0
    invoke-virtual {p3}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    const-string/jumbo v3, "x-amz-bucket-region"

    invoke-virtual {v2, v3}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 269
    .local v2, "region":Ljava/lang/String;
    if-eqz v1, :cond_3

    if-eqz v2, :cond_3

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ". Use region "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 271
    :cond_3
    if-eqz p4, :cond_4

    if-eqz v2, :cond_4

    sget-object v3, Lio/minio/http/Method;->HEAD:Lio/minio/http/Method;

    .line 273
    invoke-virtual {p1, v3}, Lio/minio/http/Method;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    if-eqz p2, :cond_4

    iget-object v3, p0, Lio/minio/S3Base;->regionCache:Ljava/util/Map;

    .line 275
    invoke-interface {v3, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    if-eqz v3, :cond_4

    .line 276
    const-string v0, "RetryHead"

    .line 277
    const/4 v1, 0x0

    .line 280
    :cond_4
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/String;

    const/4 v4, 0x0

    aput-object v0, v3, v4

    const/4 v4, 0x1

    aput-object v1, v3, v4

    return-object v3
.end method

.method static synthetic lambda$abortMultipartUploadAsync$10(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Response;)Lio/minio/AbortMultipartUploadResponse;
    .locals 7
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "uploadId"    # Ljava/lang/String;
    .param p4, "response"    # Lokhttp3/Response;

    .line 1785
    :try_start_0
    new-instance v6, Lio/minio/AbortMultipartUploadResponse;

    .line 1786
    invoke-virtual {p4}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v1

    move-object v0, v6

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lio/minio/AbortMultipartUploadResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1788
    invoke-virtual {p4}, Lokhttp3/Response;->close()V

    .line 1785
    return-object v6

    .line 1788
    :catchall_0
    move-exception v0

    invoke-virtual {p4}, Lokhttp3/Response;->close()V

    .line 1789
    throw v0
.end method

.method static synthetic lambda$calculatePartCountAsync$6()Ljava/lang/Integer;
    .locals 1

    .line 1086
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method

.method static synthetic lambda$calculatePartCountAsync$7(Lio/minio/ComposeSource;Ljava/util/List;I[JLjava/lang/Integer;Lio/minio/StatObjectResponse;)Ljava/lang/Integer;
    .locals 17
    .param p0, "src"    # Lio/minio/ComposeSource;
    .param p1, "sources"    # Ljava/util/List;
    .param p2, "i"    # I
    .param p3, "objectSize"    # [J
    .param p4, "partCount"    # Ljava/lang/Integer;
    .param p5, "statObjectResponse"    # Lio/minio/StatObjectResponse;

    .line 1094
    move/from16 v0, p2

    invoke-virtual/range {p5 .. p5}, Lio/minio/StatObjectResponse;->size()J

    move-result-wide v1

    invoke-virtual/range {p5 .. p5}, Lio/minio/StatObjectResponse;->etag()Ljava/lang/String;

    move-result-object v3

    move-object/from16 v4, p0

    invoke-virtual {v4, v1, v2, v3}, Lio/minio/ComposeSource;->buildHeaders(JLjava/lang/String;)V

    .line 1096
    invoke-virtual/range {p5 .. p5}, Lio/minio/StatObjectResponse;->size()J

    move-result-wide v1

    .line 1097
    .local v1, "size":J
    invoke-virtual/range {p0 .. p0}, Lio/minio/ComposeSource;->length()Ljava/lang/Long;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 1098
    invoke-virtual/range {p0 .. p0}, Lio/minio/ComposeSource;->length()Ljava/lang/Long;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    goto :goto_0

    .line 1099
    :cond_0
    invoke-virtual/range {p0 .. p0}, Lio/minio/ComposeSource;->offset()Ljava/lang/Long;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 1100
    invoke-virtual/range {p0 .. p0}, Lio/minio/ComposeSource;->offset()Ljava/lang/Long;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    sub-long/2addr v1, v5

    .line 1103
    :cond_1
    :goto_0
    const-wide/32 v5, 0x500000

    cmp-long v3, v1, v5

    const/high16 v7, 0x500000

    const-string v8, "/"

    const-string/jumbo v9, "source "

    const/4 v10, 0x1

    if-gez v3, :cond_3

    .line 1104
    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v3

    if-eq v3, v10, :cond_3

    .line 1105
    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v3

    if-ne v0, v3, :cond_2

    goto :goto_1

    .line 1106
    :cond_2
    new-instance v3, Ljava/lang/IllegalArgumentException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 1108
    invoke-virtual/range {p0 .. p0}, Lio/minio/ComposeSource;->bucket()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 1110
    invoke-virtual/range {p0 .. p0}, Lio/minio/ComposeSource;->object()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ": size "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " must be greater than "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 1117
    :cond_3
    :goto_1
    const/4 v3, 0x0

    aget-wide v11, p3, v3

    add-long/2addr v11, v1

    aput-wide v11, p3, v3

    .line 1118
    aget-wide v11, p3, v3

    const-wide v13, 0x50000000000L

    cmp-long v3, v11, v13

    if-gtz v3, :cond_9

    .line 1124
    const-wide v11, 0x140000000L

    cmp-long v3, v1, v11

    if-lez v3, :cond_7

    .line 1125
    div-long v13, v1, v11

    .line 1126
    .local v13, "count":J
    mul-long/2addr v11, v13

    sub-long v11, v1, v11

    .line 1127
    .local v11, "lastPartSize":J
    const-wide/16 v15, 0x0

    cmp-long v3, v11, v15

    if-lez v3, :cond_4

    .line 1128
    const-wide/16 v15, 0x1

    add-long/2addr v13, v15

    goto :goto_2

    .line 1130
    :cond_4
    const-wide v11, 0x140000000L

    .line 1133
    :goto_2
    cmp-long v3, v11, v5

    if-gez v3, :cond_6

    .line 1134
    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v3

    if-eq v3, v10, :cond_6

    .line 1135
    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v3

    if-ne v0, v3, :cond_5

    goto :goto_3

    .line 1136
    :cond_5
    new-instance v3, Ljava/lang/IllegalArgumentException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 1138
    invoke-virtual/range {p0 .. p0}, Lio/minio/ComposeSource;->bucket()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 1140
    invoke-virtual/range {p0 .. p0}, Lio/minio/ComposeSource;->object()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ": for multipart split upload of "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ", last part size is less than "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 1147
    :cond_6
    :goto_3
    invoke-virtual/range {p4 .. p4}, Ljava/lang/Integer;->intValue()I

    move-result v3

    long-to-int v5, v13

    add-int/2addr v3, v5

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    .line 1148
    .end local v11    # "lastPartSize":J
    .end local v13    # "count":J
    .end local p4    # "partCount":Ljava/lang/Integer;
    .local v3, "partCount":Ljava/lang/Integer;
    goto :goto_4

    .line 1149
    .end local v3    # "partCount":Ljava/lang/Integer;
    .restart local p4    # "partCount":Ljava/lang/Integer;
    :cond_7
    invoke-virtual/range {p4 .. p4}, Ljava/lang/Integer;->intValue()I

    move-result v3

    add-int/2addr v3, v10

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    .line 1152
    .end local p4    # "partCount":Ljava/lang/Integer;
    .restart local v3    # "partCount":Ljava/lang/Integer;
    :goto_4
    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v5

    const/16 v6, 0x2710

    if-gt v5, v6, :cond_8

    .line 1157
    return-object v3

    .line 1153
    :cond_8
    new-instance v5, Ljava/lang/IllegalArgumentException;

    const-string v6, "Compose sources create more than allowed multipart count 10000"

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 1119
    .end local v3    # "partCount":Ljava/lang/Integer;
    .restart local p4    # "partCount":Ljava/lang/Integer;
    :cond_9
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v5, "destination object size must be less than 5497558138880"

    invoke-direct {v3, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method static synthetic lambda$completeMultipartUploadAsync$12(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Response;)Lio/minio/ObjectWriteResponse;
    .locals 11
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "response"    # Lokhttp3/Response;

    .line 1896
    :try_start_0
    invoke-virtual {p3}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/ResponseBody;->string()Ljava/lang/String;

    move-result-object v0

    .line 1897
    .local v0, "bodyContent":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    move-object v0, v1

    .line 1898
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string/jumbo v2, "x-amz-version-id"

    if-nez v1, :cond_1

    .line 1900
    :try_start_1
    const-class v1, Lio/minio/messages/ErrorResponse;

    invoke-static {v1, v0}, Lio/minio/Xml;->validate(Ljava/lang/Class;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 1908
    goto :goto_0

    .line 1901
    :cond_0
    const-class v1, Lio/minio/messages/ErrorResponse;

    invoke-static {v1, v0}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/minio/messages/ErrorResponse;

    .line 1902
    .local v1, "errorResponse":Lio/minio/messages/ErrorResponse;
    new-instance v3, Ljava/util/concurrent/CompletionException;

    new-instance v4, Lio/minio/errors/ErrorResponseException;

    const/4 v5, 0x0

    invoke-direct {v4, v1, p3, v5}, Lio/minio/errors/ErrorResponseException;-><init>(Lio/minio/messages/ErrorResponse;Lokhttp3/Response;Ljava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local v0    # "bodyContent":Ljava/lang/String;
    .end local p0    # "bucketName":Ljava/lang/String;
    .end local p1    # "region":Ljava/lang/String;
    .end local p2    # "objectName":Ljava/lang/String;
    .end local p3    # "response":Lokhttp3/Response;
    throw v3
    :try_end_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1905
    .end local v1    # "errorResponse":Lio/minio/messages/ErrorResponse;
    .restart local v0    # "bodyContent":Ljava/lang/String;
    .restart local p0    # "bucketName":Ljava/lang/String;
    .restart local p1    # "region":Ljava/lang/String;
    .restart local p2    # "objectName":Ljava/lang/String;
    .restart local p3    # "response":Lokhttp3/Response;
    :catch_0
    move-exception v1

    .line 1911
    :goto_0
    :try_start_2
    const-class v1, Lio/minio/messages/CompleteMultipartUploadOutput;

    .line 1912
    invoke-static {v1, v0}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/minio/messages/CompleteMultipartUploadOutput;

    .line 1913
    .local v1, "result":Lio/minio/messages/CompleteMultipartUploadOutput;
    new-instance v10, Lio/minio/ObjectWriteResponse;

    .line 1914
    invoke-virtual {p3}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v4

    .line 1915
    invoke-virtual {v1}, Lio/minio/messages/CompleteMultipartUploadOutput;->bucket()Ljava/lang/String;

    move-result-object v5

    .line 1916
    invoke-virtual {v1}, Lio/minio/messages/CompleteMultipartUploadOutput;->location()Ljava/lang/String;

    move-result-object v6

    .line 1917
    invoke-virtual {v1}, Lio/minio/messages/CompleteMultipartUploadOutput;->object()Ljava/lang/String;

    move-result-object v7

    .line 1918
    invoke-virtual {v1}, Lio/minio/messages/CompleteMultipartUploadOutput;->etag()Ljava/lang/String;

    move-result-object v8

    .line 1919
    invoke-virtual {p3, v2}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    move-object v3, v10

    invoke-direct/range {v3 .. v9}, Lio/minio/ObjectWriteResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catch Lio/minio/errors/XmlParserException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1939
    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 1913
    return-object v10

    .line 1920
    .end local v1    # "result":Lio/minio/messages/CompleteMultipartUploadOutput;
    :catch_1
    move-exception v1

    .line 1922
    .local v1, "e":Lio/minio/errors/XmlParserException;
    :try_start_3
    const-class v3, Lio/minio/S3Base;

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "S3 service returned unknown XML for CompleteMultipartUpload REST API. "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1923
    invoke-virtual {v3, v4}, Ljava/util/logging/Logger;->warning(Ljava/lang/String;)V

    .line 1929
    .end local v1    # "e":Lio/minio/errors/XmlParserException;
    :cond_1
    new-instance v8, Lio/minio/ObjectWriteResponse;

    .line 1930
    invoke-virtual {p3}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v3

    .line 1935
    invoke-virtual {p3, v2}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const/4 v6, 0x0

    move-object v1, v8

    move-object v2, v3

    move-object v3, p0

    move-object v4, p1

    move-object v5, p2

    invoke-direct/range {v1 .. v7}, Lio/minio/ObjectWriteResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1939
    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 1929
    return-object v8

    .line 1939
    .end local v0    # "bodyContent":Ljava/lang/String;
    :catchall_0
    move-exception v0

    goto :goto_1

    .line 1936
    :catch_2
    move-exception v0

    .line 1937
    .local v0, "e":Ljava/io/IOException;
    :try_start_4
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "bucketName":Ljava/lang/String;
    .end local p1    # "region":Ljava/lang/String;
    .end local p2    # "objectName":Ljava/lang/String;
    .end local p3    # "response":Lokhttp3/Response;
    throw v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 1939
    .end local v0    # "e":Ljava/io/IOException;
    .restart local p0    # "bucketName":Ljava/lang/String;
    .restart local p1    # "region":Ljava/lang/String;
    .restart local p2    # "objectName":Ljava/lang/String;
    .restart local p3    # "response":Lokhttp3/Response;
    :goto_1
    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 1940
    throw v0
.end method

.method static synthetic lambda$createMultipartUploadAsync$14(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Response;)Lio/minio/CreateMultipartUploadResponse;
    .locals 7
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "response"    # Lokhttp3/Response;

    .line 2052
    :try_start_0
    const-class v0, Lio/minio/messages/InitiateMultipartUploadResult;

    .line 2054
    invoke-virtual {p3}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    .line 2053
    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    move-object v6, v0

    check-cast v6, Lio/minio/messages/InitiateMultipartUploadResult;

    .line 2055
    .local v6, "result":Lio/minio/messages/InitiateMultipartUploadResult;
    new-instance v0, Lio/minio/CreateMultipartUploadResponse;

    .line 2056
    invoke-virtual {p3}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    move-object v1, v0

    move-object v3, p0

    move-object v4, p1

    move-object v5, p2

    invoke-direct/range {v1 .. v6}, Lio/minio/CreateMultipartUploadResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/InitiateMultipartUploadResult;)V
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2060
    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 2055
    return-object v0

    .line 2060
    .end local v6    # "result":Lio/minio/messages/InitiateMultipartUploadResult;
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 2057
    :catch_0
    move-exception v0

    .line 2058
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "bucketName":Ljava/lang/String;
    .end local p1    # "region":Ljava/lang/String;
    .end local p2    # "objectName":Ljava/lang/String;
    .end local p3    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2060
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "bucketName":Ljava/lang/String;
    .restart local p1    # "region":Ljava/lang/String;
    .restart local p2    # "objectName":Ljava/lang/String;
    .restart local p3    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 2061
    throw v0
.end method

.method static synthetic lambda$deleteObjectsAsync$16(Ljava/lang/String;Ljava/lang/String;Lokhttp3/Response;)Lio/minio/DeleteObjectsResponse;
    .locals 5
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "response"    # Lokhttp3/Response;

    .line 2175
    :try_start_0
    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/ResponseBody;->string()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2177
    .local v0, "bodyContent":Ljava/lang/String;
    :try_start_1
    const-class v1, Lio/minio/messages/DeleteError;

    invoke-static {v1, v0}, Lio/minio/Xml;->validate(Ljava/lang/Class;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 2178
    const-class v1, Lio/minio/messages/DeleteError;

    invoke-static {v1, v0}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/minio/messages/DeleteError;

    .line 2179
    .local v1, "error":Lio/minio/messages/DeleteError;
    new-instance v2, Lio/minio/messages/DeleteResult;

    invoke-direct {v2, v1}, Lio/minio/messages/DeleteResult;-><init>(Lio/minio/messages/DeleteError;)V

    .line 2180
    .local v2, "result":Lio/minio/messages/DeleteResult;
    new-instance v3, Lio/minio/DeleteObjectsResponse;

    .line 2181
    invoke-virtual {p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v4

    invoke-direct {v3, v4, p0, p1, v2}, Lio/minio/DeleteObjectsResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/DeleteResult;)V
    :try_end_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2193
    invoke-virtual {p2}, Lokhttp3/Response;->close()V

    .line 2180
    return-object v3

    .line 2186
    .end local v1    # "error":Lio/minio/messages/DeleteError;
    .end local v2    # "result":Lio/minio/messages/DeleteResult;
    :cond_0
    goto :goto_0

    .line 2183
    :catch_0
    move-exception v1

    .line 2188
    :goto_0
    :try_start_2
    const-class v1, Lio/minio/messages/DeleteResult;

    invoke-static {v1, v0}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/minio/messages/DeleteResult;

    .line 2189
    .local v1, "result":Lio/minio/messages/DeleteResult;
    new-instance v2, Lio/minio/DeleteObjectsResponse;

    invoke-virtual {p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v3

    invoke-direct {v2, v3, p0, p1, v1}, Lio/minio/DeleteObjectsResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/DeleteResult;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Lio/minio/errors/XmlParserException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 2193
    invoke-virtual {p2}, Lokhttp3/Response;->close()V

    .line 2189
    return-object v2

    .line 2193
    .end local v0    # "bodyContent":Ljava/lang/String;
    .end local v1    # "result":Lio/minio/messages/DeleteResult;
    :catchall_0
    move-exception v0

    goto :goto_2

    .line 2190
    :catch_1
    move-exception v0

    goto :goto_1

    :catch_2
    move-exception v0

    .line 2191
    .local v0, "e":Ljava/lang/Exception;
    :goto_1
    :try_start_3
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "bucketName":Ljava/lang/String;
    .end local p1    # "region":Ljava/lang/String;
    .end local p2    # "response":Lokhttp3/Response;
    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 2193
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local p0    # "bucketName":Ljava/lang/String;
    .restart local p1    # "region":Ljava/lang/String;
    .restart local p2    # "response":Lokhttp3/Response;
    :goto_2
    invoke-virtual {p2}, Lokhttp3/Response;->close()V

    .line 2194
    throw v0
.end method

.method static synthetic lambda$executeDeleteAsync$5(Lokhttp3/Response;)Lokhttp3/Response;
    .locals 1
    .param p0, "response"    # Lokhttp3/Response;

    .line 982
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/ResponseBody;->close()V

    .line 983
    :cond_0
    return-object p0
.end method

.method static synthetic lambda$executeHeadAsync$3(Ljava/lang/Throwable;)Lokhttp3/Response;
    .locals 3
    .param p0, "e"    # Ljava/lang/Throwable;

    .line 926
    instance-of v0, p0, Lio/minio/errors/ErrorResponseException;

    if-eqz v0, :cond_0

    .line 927
    move-object v0, p0

    check-cast v0, Lio/minio/errors/ErrorResponseException;

    .line 928
    .local v0, "ex":Lio/minio/errors/ErrorResponseException;
    invoke-virtual {v0}, Lio/minio/errors/ErrorResponseException;->errorResponse()Lio/minio/messages/ErrorResponse;

    move-result-object v1

    invoke-virtual {v1}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v1

    const-string v2, "RetryHead"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 929
    const/4 v1, 0x0

    return-object v1

    .line 932
    .end local v0    # "ex":Lio/minio/errors/ErrorResponseException;
    :cond_0
    new-instance v0, Ljava/util/concurrent/CompletionException;

    invoke-direct {v0, p0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method

.method static synthetic lambda$httpHeaders$0(Ljava/lang/String;)Z
    .locals 1
    .param p0, "encoding"    # Ljava/lang/String;

    .line 377
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method static synthetic lambda$listMultipartUploadsAsync$31(Ljava/lang/String;Ljava/lang/String;Lokhttp3/Response;)Lio/minio/ListMultipartUploadsResponse;
    .locals 3
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "response"    # Lokhttp3/Response;

    .line 3126
    :try_start_0
    const-class v0, Lio/minio/messages/ListMultipartUploadsResult;

    .line 3127
    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ListMultipartUploadsResult;

    .line 3128
    .local v0, "result":Lio/minio/messages/ListMultipartUploadsResult;
    new-instance v1, Lio/minio/ListMultipartUploadsResponse;

    .line 3129
    invoke-virtual {p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    invoke-direct {v1, v2, p0, p1, v0}, Lio/minio/ListMultipartUploadsResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ListMultipartUploadsResult;)V
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 3133
    invoke-virtual {p2}, Lokhttp3/Response;->close()V

    .line 3128
    return-object v1

    .line 3133
    .end local v0    # "result":Lio/minio/messages/ListMultipartUploadsResult;
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 3130
    :catch_0
    move-exception v0

    .line 3131
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "bucketName":Ljava/lang/String;
    .end local p1    # "region":Ljava/lang/String;
    .end local p2    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3133
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "bucketName":Ljava/lang/String;
    .restart local p1    # "region":Ljava/lang/String;
    .restart local p2    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p2}, Lokhttp3/Response;->close()V

    .line 3134
    throw v0
.end method

.method static synthetic lambda$listObjectVersionsAsync$22(Ljava/lang/String;Ljava/lang/String;Lokhttp3/Response;)Lio/minio/ListObjectVersionsResponse;
    .locals 3
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "response"    # Lokhttp3/Response;

    .line 2608
    :try_start_0
    const-class v0, Lio/minio/messages/ListVersionsResult;

    .line 2609
    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ListVersionsResult;

    .line 2610
    .local v0, "result":Lio/minio/messages/ListVersionsResult;
    new-instance v1, Lio/minio/ListObjectVersionsResponse;

    .line 2611
    invoke-virtual {p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    invoke-direct {v1, v2, p0, p1, v0}, Lio/minio/ListObjectVersionsResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ListVersionsResult;)V
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2615
    invoke-virtual {p2}, Lokhttp3/Response;->close()V

    .line 2610
    return-object v1

    .line 2615
    .end local v0    # "result":Lio/minio/messages/ListVersionsResult;
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 2612
    :catch_0
    move-exception v0

    .line 2613
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "bucketName":Ljava/lang/String;
    .end local p1    # "region":Ljava/lang/String;
    .end local p2    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2615
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "bucketName":Ljava/lang/String;
    .restart local p1    # "region":Ljava/lang/String;
    .restart local p2    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p2}, Lokhttp3/Response;->close()V

    .line 2616
    throw v0
.end method

.method static synthetic lambda$listObjectsV1Async$20(Ljava/lang/String;Ljava/lang/String;Lokhttp3/Response;)Lio/minio/ListObjectsV1Response;
    .locals 3
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "response"    # Lokhttp3/Response;

    .line 2469
    :try_start_0
    const-class v0, Lio/minio/messages/ListBucketResultV1;

    .line 2470
    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ListBucketResultV1;

    .line 2471
    .local v0, "result":Lio/minio/messages/ListBucketResultV1;
    new-instance v1, Lio/minio/ListObjectsV1Response;

    invoke-virtual {p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    invoke-direct {v1, v2, p0, p1, v0}, Lio/minio/ListObjectsV1Response;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ListBucketResultV1;)V
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2475
    invoke-virtual {p2}, Lokhttp3/Response;->close()V

    .line 2471
    return-object v1

    .line 2475
    .end local v0    # "result":Lio/minio/messages/ListBucketResultV1;
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 2472
    :catch_0
    move-exception v0

    .line 2473
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "bucketName":Ljava/lang/String;
    .end local p1    # "region":Ljava/lang/String;
    .end local p2    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2475
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "bucketName":Ljava/lang/String;
    .restart local p1    # "region":Ljava/lang/String;
    .restart local p2    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p2}, Lokhttp3/Response;->close()V

    .line 2476
    throw v0
.end method

.method static synthetic lambda$listObjectsV2Async$18(Ljava/lang/String;Ljava/lang/String;Lokhttp3/Response;)Lio/minio/ListObjectsV2Response;
    .locals 3
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "response"    # Lokhttp3/Response;

    .line 2326
    :try_start_0
    const-class v0, Lio/minio/messages/ListBucketResultV2;

    .line 2327
    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ListBucketResultV2;

    .line 2328
    .local v0, "result":Lio/minio/messages/ListBucketResultV2;
    new-instance v1, Lio/minio/ListObjectsV2Response;

    invoke-virtual {p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    invoke-direct {v1, v2, p0, p1, v0}, Lio/minio/ListObjectsV2Response;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ListBucketResultV2;)V
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2332
    invoke-virtual {p2}, Lokhttp3/Response;->close()V

    .line 2328
    return-object v1

    .line 2332
    .end local v0    # "result":Lio/minio/messages/ListBucketResultV2;
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 2329
    :catch_0
    move-exception v0

    .line 2330
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "bucketName":Ljava/lang/String;
    .end local p1    # "region":Ljava/lang/String;
    .end local p2    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2332
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "bucketName":Ljava/lang/String;
    .restart local p1    # "region":Ljava/lang/String;
    .restart local p2    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p2}, Lokhttp3/Response;->close()V

    .line 2333
    throw v0
.end method

.method static synthetic lambda$listPartsAsync$33(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Response;)Lio/minio/ListPartsResponse;
    .locals 7
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "response"    # Lokhttp3/Response;

    .line 3269
    :try_start_0
    const-class v0, Lio/minio/messages/ListPartsResult;

    .line 3270
    invoke-virtual {p3}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    move-object v6, v0

    check-cast v6, Lio/minio/messages/ListPartsResult;

    .line 3271
    .local v6, "result":Lio/minio/messages/ListPartsResult;
    new-instance v0, Lio/minio/ListPartsResponse;

    .line 3272
    invoke-virtual {p3}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    move-object v1, v0

    move-object v3, p0

    move-object v4, p1

    move-object v5, p2

    invoke-direct/range {v1 .. v6}, Lio/minio/ListPartsResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/ListPartsResult;)V
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 3276
    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 3271
    return-object v0

    .line 3276
    .end local v6    # "result":Lio/minio/messages/ListPartsResult;
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 3273
    :catch_0
    move-exception v0

    .line 3274
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "bucketName":Ljava/lang/String;
    .end local p1    # "region":Ljava/lang/String;
    .end local p2    # "objectName":Ljava/lang/String;
    .end local p3    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3276
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "bucketName":Ljava/lang/String;
    .restart local p1    # "region":Ljava/lang/String;
    .restart local p2    # "objectName":Ljava/lang/String;
    .restart local p3    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 3277
    throw v0
.end method

.method static synthetic lambda$putObjectAsync$24(Lio/minio/PartReader;)Lio/minio/PartSource;
    .locals 2
    .param p0, "partReader"    # Lio/minio/PartReader;

    .line 2828
    :try_start_0
    invoke-virtual {p0}, Lio/minio/PartReader;->getPart()Lio/minio/PartSource;

    move-result-object v0
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2829
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 2830
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method static synthetic lambda$putObjectAsync$27(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Response;)Lio/minio/ObjectWriteResponse;
    .locals 8
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "response"    # Lokhttp3/Response;

    .line 2910
    :try_start_0
    new-instance v7, Lio/minio/ObjectWriteResponse;

    .line 2911
    invoke-virtual {p3}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v1

    const-string v0, "ETag"

    .line 2915
    invoke-virtual {p3, v0}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "\""

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string/jumbo v0, "x-amz-version-id"

    .line 2916
    invoke-virtual {p3, v0}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object v0, v7

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    invoke-direct/range {v0 .. v6}, Lio/minio/ObjectWriteResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2918
    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 2910
    return-object v7

    .line 2918
    :catchall_0
    move-exception v0

    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 2919
    throw v0
.end method

.method static synthetic lambda$putObjectAsync$29(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Response;)Lio/minio/ObjectWriteResponse;
    .locals 8
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "response"    # Lokhttp3/Response;

    .line 2991
    :try_start_0
    new-instance v7, Lio/minio/ObjectWriteResponse;

    .line 2992
    invoke-virtual {p3}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v1

    const-string v0, "ETag"

    .line 2996
    invoke-virtual {p3, v0}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "\""

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string/jumbo v0, "x-amz-version-id"

    .line 2997
    invoke-virtual {p3, v0}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object v0, v7

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    invoke-direct/range {v0 .. v6}, Lio/minio/ObjectWriteResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2999
    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 2991
    return-object v7

    .line 2999
    :catchall_0
    move-exception v0

    invoke-virtual {p3}, Lokhttp3/Response;->close()V

    .line 3000
    throw v0
.end method

.method static synthetic lambda$statObjectAsync$8(Lio/minio/StatObjectArgs;Lokhttp3/Response;)Lio/minio/StatObjectResponse;
    .locals 5
    .param p0, "args"    # Lio/minio/StatObjectArgs;
    .param p1, "response"    # Lokhttp3/Response;

    .line 1728
    new-instance v0, Lio/minio/StatObjectResponse;

    .line 1729
    invoke-virtual {p1}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v1

    invoke-virtual {p0}, Lio/minio/StatObjectArgs;->bucket()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0}, Lio/minio/StatObjectArgs;->region()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lio/minio/StatObjectArgs;->object()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v0, v1, v2, v3, v4}, Lio/minio/StatObjectResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 1728
    return-object v0
.end method

.method static synthetic lambda$uploadPartAsync$35(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILokhttp3/Response;)Lio/minio/UploadPartResponse;
    .locals 9
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "uploadId"    # Ljava/lang/String;
    .param p4, "partNumber"    # I
    .param p5, "response"    # Lokhttp3/Response;

    .line 3396
    :try_start_0
    new-instance v8, Lio/minio/UploadPartResponse;

    .line 3397
    invoke-virtual {p5}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v1

    const-string v0, "ETag"

    .line 3403
    invoke-virtual {p5, v0}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "\""

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    move-object v0, v8

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move v6, p4

    invoke-direct/range {v0 .. v7}, Lio/minio/UploadPartResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 3405
    invoke-virtual {p5}, Lokhttp3/Response;->close()V

    .line 3396
    return-object v8

    .line 3405
    :catchall_0
    move-exception v0

    invoke-virtual {p5}, Lokhttp3/Response;->close()V

    .line 3406
    throw v0
.end method

.method static synthetic lambda$uploadPartAsync$37(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILokhttp3/Response;)Lio/minio/UploadPartResponse;
    .locals 9
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "uploadId"    # Ljava/lang/String;
    .param p4, "partNumber"    # I
    .param p5, "response"    # Lokhttp3/Response;

    .line 3493
    :try_start_0
    new-instance v8, Lio/minio/UploadPartResponse;

    .line 3494
    invoke-virtual {p5}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v1

    const-string v0, "ETag"

    .line 3500
    invoke-virtual {p5, v0}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "\""

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    move-object v0, v8

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move v6, p4

    invoke-direct/range {v0 .. v7}, Lio/minio/UploadPartResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 3502
    invoke-virtual {p5}, Lokhttp3/Response;->close()V

    .line 3493
    return-object v8

    .line 3502
    :catchall_0
    move-exception v0

    invoke-virtual {p5}, Lokhttp3/Response;->close()V

    .line 3503
    throw v0
.end method

.method static synthetic lambda$uploadPartCopyAsync$39(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILokhttp3/Response;)Lio/minio/UploadPartCopyResponse;
    .locals 9
    .param p0, "bucketName"    # Ljava/lang/String;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "uploadId"    # Ljava/lang/String;
    .param p4, "partNumber"    # I
    .param p5, "response"    # Lokhttp3/Response;

    .line 3672
    :try_start_0
    const-class v0, Lio/minio/messages/CopyPartResult;

    .line 3673
    invoke-virtual {p5}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    move-object v8, v0

    check-cast v8, Lio/minio/messages/CopyPartResult;

    .line 3674
    .local v8, "result":Lio/minio/messages/CopyPartResult;
    new-instance v0, Lio/minio/UploadPartCopyResponse;

    .line 3675
    invoke-virtual {p5}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    move-object v1, v0

    move-object v3, p0

    move-object v4, p1

    move-object v5, p2

    move-object v6, p3

    move v7, p4

    invoke-direct/range {v1 .. v8}, Lio/minio/UploadPartCopyResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILio/minio/messages/CopyPartResult;)V
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 3685
    invoke-virtual {p5}, Lokhttp3/Response;->close()V

    .line 3674
    return-object v0

    .line 3685
    .end local v8    # "result":Lio/minio/messages/CopyPartResult;
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 3682
    :catch_0
    move-exception v0

    .line 3683
    .local v0, "e":Lio/minio/errors/XmlParserException;
    :try_start_1
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    .end local p0    # "bucketName":Ljava/lang/String;
    .end local p1    # "region":Ljava/lang/String;
    .end local p2    # "objectName":Ljava/lang/String;
    .end local p3    # "uploadId":Ljava/lang/String;
    .end local p4    # "partNumber":I
    .end local p5    # "response":Lokhttp3/Response;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3685
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    .restart local p0    # "bucketName":Ljava/lang/String;
    .restart local p1    # "region":Ljava/lang/String;
    .restart local p2    # "objectName":Ljava/lang/String;
    .restart local p3    # "uploadId":Ljava/lang/String;
    .restart local p4    # "partNumber":I
    .restart local p5    # "response":Lokhttp3/Response;
    :goto_0
    invoke-virtual {p5}, Lokhttp3/Response;->close()V

    .line 3686
    throw v0
.end method

.method private newTraceBuilder(Lokhttp3/Request;Ljava/lang/String;)Ljava/lang/StringBuilder;
    .locals 6
    .param p1, "request"    # Lokhttp3/Request;
    .param p2, "body"    # Ljava/lang/String;

    .line 453
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 454
    .local v0, "traceBuilder":Ljava/lang/StringBuilder;
    const-string v1, "---------START-HTTP---------\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 455
    invoke-virtual {p1}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/HttpUrl;->encodedPath()Ljava/lang/String;

    move-result-object v1

    .line 456
    .local v1, "encodedPath":Ljava/lang/String;
    invoke-virtual {p1}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/HttpUrl;->encodedQuery()Ljava/lang/String;

    move-result-object v2

    .line 457
    .local v2, "encodedQuery":Ljava/lang/String;
    if-eqz v2, :cond_0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "?"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 458
    :cond_0
    invoke-virtual {p1}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " HTTP/1.1\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 459
    nop

    .line 461
    invoke-virtual {p1}, Lokhttp3/Request;->headers()Lokhttp3/Headers;

    move-result-object v3

    .line 462
    invoke-virtual {v3}, Lokhttp3/Headers;->toString()Ljava/lang/String;

    move-result-object v3

    .line 463
    const-string v4, "Signature=([0-9a-f]+)"

    const-string v5, "Signature=*REDACTED*"

    invoke-virtual {v3, v4, v5}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 464
    const-string v4, "Credential=([^/]+)"

    const-string v5, "Credential=*REDACTED*"

    invoke-virtual {v3, v4, v5}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 459
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 465
    if-eqz p2, :cond_1

    const-string v3, "\n"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 466
    :cond_1
    return-object v0
.end method

.method private putMultipartObjectAsync(Lio/minio/PutObjectBaseArgs;Lcom/google/common/collect/Multimap;Lio/minio/PartReader;Lio/minio/PartSource;)Ljava/util/concurrent/CompletableFuture;
    .locals 7
    .param p1, "args"    # Lio/minio/PutObjectBaseArgs;
    .param p3, "partReader"    # Lio/minio/PartReader;
    .param p4, "firstPartSource"    # Lio/minio/PartSource;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/PutObjectBaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lio/minio/PartReader;",
            "Lio/minio/PartSource;",
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

    .line 2726
    .local p2, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v6, Lio/minio/S3Base$$ExternalSyntheticLambda37;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lio/minio/S3Base$$ExternalSyntheticLambda37;-><init>(Lio/minio/S3Base;Lio/minio/PutObjectBaseArgs;Lcom/google/common/collect/Multimap;Lio/minio/PartReader;Lio/minio/PartSource;)V

    invoke-static {v6}, Ljava/util/concurrent/CompletableFuture;->supplyAsync(Ljava/util/function/Supplier;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method private putObjectAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/PartSource;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "partSource"    # Lio/minio/PartSource;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lio/minio/PartSource;",
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

    .line 2885
    .local p5, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p6, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v8, Lio/minio/S3Base$$ExternalSyntheticLambda25;

    move-object v1, v8

    move-object v2, p0

    move-object v3, p1

    move-object v4, p3

    move-object v5, p5

    move-object v6, p6

    move-object v7, p4

    invoke-direct/range {v1 .. v7}, Lio/minio/S3Base$$ExternalSyntheticLambda25;-><init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Lio/minio/PartSource;)V

    .line 2886
    invoke-virtual {v0, v8}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda26;

    invoke-direct {v1, p1, p2, p3}, Lio/minio/S3Base$$ExternalSyntheticLambda26;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 2907
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2885
    return-object v0
.end method

.method private uploadParts(Lio/minio/PutObjectBaseArgs;Ljava/lang/String;Lio/minio/PartReader;Lio/minio/PartSource;)[Lio/minio/messages/Part;
    .locals 13
    .param p1, "args"    # Lio/minio/PutObjectBaseArgs;
    .param p2, "uploadId"    # Ljava/lang/String;
    .param p3, "partReader"    # Lio/minio/PartReader;
    .param p4, "firstPartSource"    # Lio/minio/PartSource;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/InterruptedException;,
            Ljava/util/concurrent/ExecutionException;,
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/security/InvalidKeyException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/XmlParserException;
        }
    .end annotation

    .line 2687
    const/16 v0, 0x2710

    new-array v0, v0, [Lio/minio/messages/Part;

    .line 2688
    .local v0, "parts":[Lio/minio/messages/Part;
    const/4 v1, 0x0

    .line 2689
    .local v1, "partNumber":I
    move-object/from16 v2, p4

    move-object v11, v2

    .line 2691
    .local v11, "partSource":Lio/minio/PartSource;
    :goto_0
    add-int/lit8 v1, v1, 0x1

    .line 2693
    const/4 v2, 0x0

    .line 2695
    .local v2, "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/PutObjectBaseArgs;->sse()Lio/minio/ServerSideEncryption;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-virtual {p1}, Lio/minio/PutObjectBaseArgs;->sse()Lio/minio/ServerSideEncryption;

    move-result-object v3

    instance-of v3, v3, Lio/minio/ServerSideEncryptionCustomerKey;

    if-eqz v3, :cond_0

    .line 2696
    invoke-virtual {p1}, Lio/minio/PutObjectBaseArgs;->sse()Lio/minio/ServerSideEncryption;

    move-result-object v3

    invoke-virtual {v3}, Lio/minio/ServerSideEncryption;->headers()Ljava/util/Map;

    move-result-object v3

    invoke-static {v3}, Lcom/google/common/collect/Multimaps;->forMap(Ljava/util/Map;)Lcom/google/common/collect/SetMultimap;

    move-result-object v2

    move-object v12, v2

    goto :goto_1

    .line 2699
    :cond_0
    move-object v12, v2

    .end local v2    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local v12, "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :goto_1
    nop

    .line 2701
    invoke-virtual {p1}, Lio/minio/PutObjectBaseArgs;->bucket()Ljava/lang/String;

    move-result-object v3

    .line 2702
    invoke-virtual {p1}, Lio/minio/PutObjectBaseArgs;->region()Ljava/lang/String;

    move-result-object v4

    .line 2703
    invoke-virtual {p1}, Lio/minio/PutObjectBaseArgs;->object()Ljava/lang/String;

    move-result-object v5

    .line 2700
    const/4 v10, 0x0

    move-object v2, p0

    move-object v6, v11

    move v7, v1

    move-object v8, p2

    move-object v9, v12

    invoke-virtual/range {v2 .. v10}, Lio/minio/S3Base;->uploadPartAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/PartSource;ILjava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v2

    .line 2709
    invoke-virtual {v2}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lio/minio/UploadPartResponse;

    .line 2710
    .local v2, "response":Lio/minio/UploadPartResponse;
    add-int/lit8 v3, v1, -0x1

    new-instance v4, Lio/minio/messages/Part;

    invoke-virtual {v2}, Lio/minio/UploadPartResponse;->etag()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v1, v5}, Lio/minio/messages/Part;-><init>(ILjava/lang/String;)V

    aput-object v4, v0, v3

    .line 2712
    invoke-virtual/range {p3 .. p3}, Lio/minio/PartReader;->getPart()Lio/minio/PartSource;

    move-result-object v11

    .line 2713
    if-nez v11, :cond_1

    .line 2716
    .end local v2    # "response":Lio/minio/UploadPartResponse;
    .end local v12    # "ssecHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    return-object v0

    .line 2714
    :cond_1
    goto :goto_0
.end method


# virtual methods
.method protected abortMultipartUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/AbortMultipartUploadResponse;
    .locals 2
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "uploadId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
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
            "Lio/minio/AbortMultipartUploadResponse;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Ljava/io/IOException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1828
    .local p5, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p6, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p6}, Lio/minio/S3Base;->abortMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1830
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/AbortMultipartUploadResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1828
    return-object v0

    .line 1833
    :catch_0
    move-exception v0

    .line 1834
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1835
    const/4 v1, 0x0

    return-object v1

    .line 1831
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1832
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected abortMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "uploadId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
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
            "Lio/minio/AbortMultipartUploadResponse;",
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

    .line 1760
    .local p5, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p6, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v8, Lio/minio/S3Base$$ExternalSyntheticLambda16;

    move-object v1, v8

    move-object v2, p0

    move-object v3, p1

    move-object v4, p3

    move-object v5, p5

    move-object v6, p6

    move-object v7, p4

    invoke-direct/range {v1 .. v7}, Lio/minio/S3Base$$ExternalSyntheticLambda16;-><init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/String;)V

    .line 1761
    invoke-virtual {v0, v8}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda17;

    invoke-direct {v1, p1, p2, p3, p4}, Lio/minio/S3Base$$ExternalSyntheticLambda17;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 1782
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1760
    return-object v0
.end method

.method protected buildUrl(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;)Lokhttp3/HttpUrl;
    .locals 9
    .param p1, "method"    # Lio/minio/http/Method;
    .param p2, "bucketName"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "region"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/http/Method;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lokhttp3/HttpUrl;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 291
    .local p5, "queryParamMap":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p2, :cond_1

    if-nez p3, :cond_0

    goto :goto_0

    .line 292
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "null bucket name for object \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 295
    :cond_1
    :goto_0
    iget-object v0, p0, Lio/minio/S3Base;->baseUrl:Lokhttp3/HttpUrl;

    invoke-virtual {v0}, Lokhttp3/HttpUrl;->newBuilder()Lokhttp3/HttpUrl$Builder;

    move-result-object v0

    .line 296
    .local v0, "urlBuilder":Lokhttp3/HttpUrl$Builder;
    iget-object v1, p0, Lio/minio/S3Base;->baseUrl:Lokhttp3/HttpUrl;

    invoke-virtual {v1}, Lokhttp3/HttpUrl;->host()Ljava/lang/String;

    move-result-object v1

    .line 297
    .local v1, "host":Ljava/lang/String;
    const-string v2, "."

    if-eqz p2, :cond_11

    .line 298
    const/4 v3, 0x0

    .line 299
    .local v3, "enforcePathStyle":Z
    sget-object v4, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;

    if-ne p1, v4, :cond_2

    if-nez p3, :cond_2

    if-nez p5, :cond_2

    .line 302
    const/4 v3, 0x1

    goto :goto_1

    .line 303
    :cond_2
    if-eqz p5, :cond_3

    const-string v4, "location"

    invoke-interface {p5, v4}, Lcom/google/common/collect/Multimap;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 305
    const/4 v3, 0x1

    goto :goto_1

    .line 306
    :cond_3
    invoke-virtual {p2, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_4

    iget-object v4, p0, Lio/minio/S3Base;->baseUrl:Lokhttp3/HttpUrl;

    invoke-virtual {v4}, Lokhttp3/HttpUrl;->isHttps()Z

    move-result v4

    if-eqz v4, :cond_4

    .line 308
    const/4 v3, 0x1

    .line 311
    :cond_4
    :goto_1
    iget-boolean v4, p0, Lio/minio/S3Base;->isAwsHost:Z

    if-eqz v4, :cond_b

    .line 312
    const-string/jumbo v4, "s3."

    .line 313
    .local v4, "s3Domain":Ljava/lang/String;
    iget-boolean v5, p0, Lio/minio/S3Base;->isFipsHost:Z

    if-eqz v5, :cond_5

    .line 314
    const-string/jumbo v4, "s3-fips."

    goto :goto_2

    .line 315
    :cond_5
    iget-boolean v5, p0, Lio/minio/S3Base;->isAccelerateHost:Z

    if-eqz v5, :cond_7

    .line 316
    invoke-virtual {p2, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_6

    .line 323
    if-nez v3, :cond_7

    const-string/jumbo v4, "s3-accelerate."

    goto :goto_2

    .line 317
    :cond_6
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "bucket name \'"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\' with \'.\' is not allowed for accelerated endpoint"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v2, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 326
    :cond_7
    :goto_2
    const-string v5, ""

    .line 327
    .local v5, "dualStack":Ljava/lang/String;
    iget-boolean v6, p0, Lio/minio/S3Base;->isDualStackHost:Z

    if-eqz v6, :cond_8

    const-string v5, "dualstack."

    .line 329
    :cond_8
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 330
    .local v6, "endpoint":Ljava/lang/String;
    if-nez v3, :cond_9

    iget-boolean v7, p0, Lio/minio/S3Base;->isAccelerateHost:Z

    if-nez v7, :cond_a

    :cond_9
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 332
    :cond_a
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 335
    .end local v4    # "s3Domain":Ljava/lang/String;
    .end local v5    # "dualStack":Ljava/lang/String;
    .end local v6    # "endpoint":Ljava/lang/String;
    :cond_b
    if-nez v3, :cond_d

    iget-boolean v4, p0, Lio/minio/S3Base;->useVirtualStyle:Z

    if-nez v4, :cond_c

    goto :goto_3

    .line 339
    :cond_c
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Lokhttp3/HttpUrl$Builder;->host(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    goto :goto_4

    .line 336
    :cond_d
    :goto_3
    invoke-virtual {v0, v1}, Lokhttp3/HttpUrl$Builder;->host(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 337
    invoke-static {p2}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Lokhttp3/HttpUrl$Builder;->addEncodedPathSegment(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 342
    :goto_4
    if-eqz p3, :cond_10

    .line 344
    const-string v4, "/"

    invoke-virtual {p3, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    array-length v5, v4

    const/4 v6, 0x0

    :goto_5
    if-ge v6, v5, :cond_f

    aget-object v7, v4, v6

    .line 345
    .local v7, "token":Ljava/lang/String;
    invoke-virtual {v7, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_e

    const-string v8, ".."

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_e

    .line 344
    .end local v7    # "token":Ljava/lang/String;
    add-int/lit8 v6, v6, 0x1

    goto :goto_5

    .line 346
    .restart local v7    # "token":Ljava/lang/String;
    :cond_e
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v4, "object name with \'.\' or \'..\' path segment is not supported"

    invoke-direct {v2, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 351
    .end local v7    # "token":Ljava/lang/String;
    :cond_f
    invoke-static {p3}, Lio/minio/S3Escaper;->encodePath(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lokhttp3/HttpUrl$Builder;->addEncodedPathSegments(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 353
    .end local v3    # "enforcePathStyle":Z
    :cond_10
    goto :goto_6

    .line 354
    :cond_11
    iget-boolean v3, p0, Lio/minio/S3Base;->isAwsHost:Z

    if-eqz v3, :cond_12

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "s3."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lokhttp3/HttpUrl$Builder;->host(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 357
    :cond_12
    :goto_6
    if-eqz p5, :cond_13

    .line 358
    invoke-interface {p5}, Lcom/google/common/collect/Multimap;->entries()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_7
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_13

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .line 359
    .local v3, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    nop

    .line 360
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-static {v5}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 359
    invoke-virtual {v0, v4, v5}, Lokhttp3/HttpUrl$Builder;->addEncodedQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 361
    .end local v3    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    goto :goto_7

    .line 364
    :cond_13
    invoke-virtual {v0}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v2

    return-object v2
.end method

.method protected calculatePartCount(Ljava/util/List;)I
    .locals 28
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lio/minio/ComposeSource;",
            ">;)I"
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

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1170
    .local p1, "sources":Ljava/util/List;, "Ljava/util/List<Lio/minio/ComposeSource;>;"
    move-object/from16 v1, p0

    const-wide/16 v2, 0x0

    .line 1171
    .local v2, "objectSize":J
    const/4 v0, 0x0

    .line 1172
    .local v0, "partCount":I
    const/4 v4, 0x0

    .line 1173
    .local v4, "i":I
    invoke-interface/range {p1 .. p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    move-wide/from16 v26, v2

    move v2, v0

    move v0, v4

    move-wide/from16 v3, v26

    .end local v4    # "i":I
    .local v0, "i":I
    .local v2, "partCount":I
    .local v3, "objectSize":J
    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_a

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lio/minio/ComposeSource;

    .line 1174
    .local v6, "src":Lio/minio/ComposeSource;
    add-int/lit8 v7, v0, 0x1

    .line 1175
    .end local v0    # "i":I
    .local v7, "i":I
    const/4 v8, 0x0

    .line 1177
    .local v8, "stat":Lio/minio/StatObjectResponse;
    :try_start_0
    new-instance v0, Lio/minio/StatObjectArgs;

    invoke-direct {v0, v6}, Lio/minio/StatObjectArgs;-><init>(Lio/minio/ObjectReadArgs;)V

    invoke-virtual {v1, v0}, Lio/minio/S3Base;->statObjectAsync(Lio/minio/StatObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/StatObjectResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v8, v0

    .line 1182
    goto :goto_1

    .line 1180
    :catch_0
    move-exception v0

    .line 1181
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {v1, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1184
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :goto_1
    invoke-virtual {v8}, Lio/minio/StatObjectResponse;->size()J

    move-result-wide v9

    invoke-virtual {v8}, Lio/minio/StatObjectResponse;->etag()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v9, v10, v0}, Lio/minio/ComposeSource;->buildHeaders(JLjava/lang/String;)V

    .line 1186
    invoke-virtual {v8}, Lio/minio/StatObjectResponse;->size()J

    move-result-wide v9

    .line 1187
    .local v9, "size":J
    invoke-virtual {v6}, Lio/minio/ComposeSource;->length()Ljava/lang/Long;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 1188
    invoke-virtual {v6}, Lio/minio/ComposeSource;->length()Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v9

    goto :goto_2

    .line 1189
    :cond_0
    invoke-virtual {v6}, Lio/minio/ComposeSource;->offset()Ljava/lang/Long;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 1190
    invoke-virtual {v6}, Lio/minio/ComposeSource;->offset()Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v11

    sub-long/2addr v9, v11

    .line 1193
    :cond_1
    :goto_2
    const-wide/32 v11, 0x500000

    cmp-long v0, v9, v11

    const/high16 v13, 0x500000

    const-string v14, "/"

    const-string/jumbo v15, "source "

    const/4 v11, 0x1

    if-gez v0, :cond_3

    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v0

    if-eq v0, v11, :cond_3

    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v0

    if-ne v7, v0, :cond_2

    goto :goto_3

    .line 1194
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 1196
    invoke-virtual {v6}, Lio/minio/ComposeSource;->bucket()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 1198
    invoke-virtual {v6}, Lio/minio/ComposeSource;->object()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v11, ": size "

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v11, " must be greater than "

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1205
    :cond_3
    :goto_3
    add-long/2addr v3, v9

    .line 1206
    const-wide v18, 0x50000000000L

    cmp-long v0, v3, v18

    if-gtz v0, :cond_9

    .line 1211
    const-wide v18, 0x140000000L

    cmp-long v0, v9, v18

    if-lez v0, :cond_7

    .line 1212
    div-long v20, v9, v18

    .line 1213
    .local v20, "count":J
    mul-long v18, v18, v20

    sub-long v18, v9, v18

    .line 1214
    .local v18, "lastPartSize":J
    const-wide/16 v22, 0x0

    cmp-long v0, v18, v22

    if-lez v0, :cond_4

    .line 1215
    const-wide/16 v22, 0x1

    add-long v20, v20, v22

    move-wide/from16 v24, v20

    goto :goto_4

    .line 1217
    :cond_4
    const-wide v18, 0x140000000L

    move-wide/from16 v24, v20

    .line 1220
    .end local v20    # "count":J
    .local v24, "count":J
    :goto_4
    const-wide/32 v16, 0x500000

    cmp-long v0, v18, v16

    if-gez v0, :cond_6

    .line 1221
    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v0

    if-eq v0, v11, :cond_6

    .line 1222
    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v0

    if-ne v7, v0, :cond_5

    goto :goto_5

    .line 1223
    :cond_5
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 1225
    invoke-virtual {v6}, Lio/minio/ComposeSource;->bucket()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 1227
    invoke-virtual {v6}, Lio/minio/ComposeSource;->object()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v11, ": for multipart split upload of "

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v11, ", last part size is less than "

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1234
    :cond_6
    :goto_5
    move-wide/from16 v11, v24

    .end local v24    # "count":J
    .local v11, "count":J
    long-to-int v0, v11

    add-int/2addr v2, v0

    .line 1235
    .end local v11    # "count":J
    .end local v18    # "lastPartSize":J
    goto :goto_6

    .line 1236
    :cond_7
    add-int/lit8 v2, v2, 0x1

    .line 1239
    :goto_6
    const/16 v0, 0x2710

    if-gt v2, v0, :cond_8

    .line 1244
    .end local v6    # "src":Lio/minio/ComposeSource;
    .end local v8    # "stat":Lio/minio/StatObjectResponse;
    .end local v9    # "size":J
    move v0, v7

    goto/16 :goto_0

    .line 1240
    .restart local v6    # "src":Lio/minio/ComposeSource;
    .restart local v8    # "stat":Lio/minio/StatObjectResponse;
    .restart local v9    # "size":J
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v5, "Compose sources create more than allowed multipart count 10000"

    invoke-direct {v0, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1207
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v5, "destination object size must be less than 5497558138880"

    invoke-direct {v0, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1178
    .end local v9    # "size":J
    :catch_1
    move-exception v0

    .line 1179
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v5, Ljava/lang/RuntimeException;

    invoke-direct {v5, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v5

    .line 1246
    .end local v6    # "src":Lio/minio/ComposeSource;
    .end local v7    # "i":I
    .end local v8    # "stat":Lio/minio/StatObjectResponse;
    .local v0, "i":I
    :cond_a
    return v2
.end method

.method protected calculatePartCountAsync(Ljava/util/List;)Ljava/util/concurrent/CompletableFuture;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lio/minio/ComposeSource;",
            ">;)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Ljava/lang/Integer;",
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

    .line 1083
    .local p1, "sources":Ljava/util/List;, "Ljava/util/List<Lio/minio/ComposeSource;>;"
    const/4 v0, 0x1

    new-array v0, v0, [J

    const-wide/16 v1, 0x0

    const/4 v3, 0x0

    aput-wide v1, v0, v3

    .line 1084
    .local v0, "objectSize":[J
    const/4 v1, 0x0

    .line 1086
    .local v1, "index":I
    new-instance v2, Lio/minio/S3Base$$ExternalSyntheticLambda9;

    invoke-direct {v2}, Lio/minio/S3Base$$ExternalSyntheticLambda9;-><init>()V

    invoke-static {v2}, Ljava/util/concurrent/CompletableFuture;->supplyAsync(Ljava/util/function/Supplier;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v2

    .line 1087
    .local v2, "completableFuture":Ljava/util/concurrent/CompletableFuture;, "Ljava/util/concurrent/CompletableFuture<Ljava/lang/Integer;>;"
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lio/minio/ComposeSource;

    .line 1088
    .local v4, "src":Lio/minio/ComposeSource;
    add-int/lit8 v1, v1, 0x1

    .line 1089
    move v5, v1

    .line 1090
    .local v5, "i":I
    new-instance v6, Lio/minio/StatObjectArgs;

    invoke-direct {v6, v4}, Lio/minio/StatObjectArgs;-><init>(Lio/minio/ObjectReadArgs;)V

    .line 1092
    invoke-virtual {p0, v6}, Lio/minio/S3Base;->statObjectAsync(Lio/minio/StatObjectArgs;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v6

    new-instance v7, Lio/minio/S3Base$$ExternalSyntheticLambda10;

    invoke-direct {v7, v4, p1, v5, v0}, Lio/minio/S3Base$$ExternalSyntheticLambda10;-><init>(Lio/minio/ComposeSource;Ljava/util/List;I[J)V

    .line 1091
    invoke-virtual {v2, v6, v7}, Ljava/util/concurrent/CompletableFuture;->thenCombine(Ljava/util/concurrent/CompletionStage;Ljava/util/function/BiFunction;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v2

    .line 1159
    .end local v4    # "src":Lio/minio/ComposeSource;
    .end local v5    # "i":I
    goto :goto_0

    .line 1161
    :cond_0
    return-object v2
.end method

.method protected checkArgs(Lio/minio/BaseArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/BaseArgs;

    .line 181
    if-eqz p1, :cond_0

    .line 182
    return-void

    .line 181
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "null arguments"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected completeMultipartUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Lio/minio/messages/Part;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/ObjectWriteResponse;
    .locals 2
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
            "Lio/minio/ObjectWriteResponse;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Ljava/io/IOException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1981
    .local p6, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p7, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p7}, Lio/minio/S3Base;->completeMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Lio/minio/messages/Part;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1983
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ObjectWriteResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1981
    return-object v0

    .line 1986
    :catch_0
    move-exception v0

    .line 1987
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1988
    const/4 v1, 0x0

    return-object v1

    .line 1984
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1985
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected completeMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Lio/minio/messages/Part;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 13
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

    .line 1869
    .local p6, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p7, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    move-object v7, p0

    move-object/from16 v8, p7

    invoke-virtual {p0, v8}, Lio/minio/S3Base;->newMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v9

    .line 1870
    .local v9, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    const-string/jumbo v0, "uploadId"

    move-object/from16 v10, p4

    invoke-interface {v9, v0, v10}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 1871
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v11

    new-instance v12, Lio/minio/S3Base$$ExternalSyntheticLambda33;

    move-object v0, v12

    move-object v1, p0

    move-object v2, p1

    move-object/from16 v3, p3

    move-object/from16 v4, p6

    move-object v5, v9

    move-object/from16 v6, p5

    invoke-direct/range {v0 .. v6}, Lio/minio/S3Base$$ExternalSyntheticLambda33;-><init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;[Lio/minio/messages/Part;)V

    .line 1872
    invoke-virtual {v11, v12}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda34;

    move-object v3, p2

    move-object/from16 v4, p3

    invoke-direct {v1, p1, p2, v4}, Lio/minio/S3Base$$ExternalSyntheticLambda34;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 1893
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1871
    return-object v0
.end method

.method protected createMultipartUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/CreateMultipartUploadResponse;
    .locals 2
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
            "Lio/minio/CreateMultipartUploadResponse;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Ljava/io/IOException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 2098
    .local p4, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p5, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p5}, Lio/minio/S3Base;->createMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2099
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/CreateMultipartUploadResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2098
    return-object v0

    .line 2102
    :catch_0
    move-exception v0

    .line 2103
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2104
    const/4 v1, 0x0

    return-object v1

    .line 2100
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 2101
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected createMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 10
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

    .line 2018
    .local p4, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p5, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0, p5}, Lio/minio/S3Base;->newMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    .line 2019
    .local v6, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    const-string/jumbo v0, "uploads"

    const-string v1, ""

    invoke-interface {v6, v0, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2021
    invoke-virtual {p0, p4}, Lio/minio/S3Base;->newMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v7

    .line 2023
    .local v7, "headersCopy":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v0, "Content-Type"

    invoke-interface {v7, v0}, Lcom/google/common/collect/Multimap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 2024
    const-string v1, "application/octet-stream"

    invoke-interface {v7, v0, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2027
    :cond_0
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v8

    new-instance v9, Lio/minio/S3Base$$ExternalSyntheticLambda18;

    move-object v0, v9

    move-object v1, p0

    move-object v2, p1

    move-object v3, p3

    move-object v4, v7

    move-object v5, v6

    invoke-direct/range {v0 .. v5}, Lio/minio/S3Base$$ExternalSyntheticLambda18;-><init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)V

    .line 2028
    invoke-virtual {v8, v9}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda19;

    invoke-direct {v1, p1, p2, p3}, Lio/minio/S3Base$$ExternalSyntheticLambda19;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 2049
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2027
    return-object v0
.end method

.method protected createRequest(Lokhttp3/HttpUrl;Lio/minio/http/Method;Lokhttp3/Headers;Ljava/lang/Object;ILio/minio/credentials/Credentials;)Lokhttp3/Request;
    .locals 8
    .param p1, "url"    # Lokhttp3/HttpUrl;
    .param p2, "method"    # Lio/minio/http/Method;
    .param p3, "headers"    # Lokhttp3/Headers;
    .param p4, "body"    # Ljava/lang/Object;
    .param p5, "length"    # I
    .param p6, "creds"    # Lio/minio/credentials/Credentials;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;,
            Ljava/io/IOException;,
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 394
    new-instance v0, Lokhttp3/Request$Builder;

    invoke-direct {v0}, Lokhttp3/Request$Builder;-><init>()V

    .line 395
    .local v0, "requestBuilder":Lokhttp3/Request$Builder;
    invoke-virtual {v0, p1}, Lokhttp3/Request$Builder;->url(Lokhttp3/HttpUrl;)Lokhttp3/Request$Builder;

    .line 397
    if-eqz p3, :cond_0

    invoke-virtual {v0, p3}, Lokhttp3/Request$Builder;->headers(Lokhttp3/Headers;)Lokhttp3/Request$Builder;

    .line 398
    :cond_0
    const-string v1, "Host"

    invoke-static {p1}, Lio/minio/http/HttpUtils;->getHostHeader(Lokhttp3/HttpUrl;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 400
    const-string v1, "Accept-Encoding"

    const-string v2, "identity"

    invoke-virtual {v0, v1, v2}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 401
    const-string v1, "User-Agent"

    iget-object v2, p0, Lio/minio/S3Base;->userAgent:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 403
    const-string v1, "1B2M2Y8AsgTpgAmY7PhCfg=="

    .line 404
    .local v1, "md5Hash":Ljava/lang/String;
    const/4 v2, 0x0

    if-eqz p4, :cond_2

    .line 405
    instance-of v3, p4, [B

    if-eqz v3, :cond_1

    move-object v3, p4

    check-cast v3, [B

    invoke-static {v3, p5}, Lio/minio/Digest;->md5Hash([BI)Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_1
    move-object v3, v2

    :goto_0
    move-object v1, v3

    .line 408
    :cond_2
    const/4 v3, 0x0

    .line 409
    .local v3, "sha256Hash":Ljava/lang/String;
    if-eqz p6, :cond_5

    .line 410
    const-string v3, "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

    .line 411
    invoke-virtual {p1}, Lokhttp3/HttpUrl;->isHttps()Z

    move-result v4

    if-nez v4, :cond_4

    .line 412
    if-eqz p4, :cond_5

    .line 413
    instance-of v4, p4, Lio/minio/PartSource;

    if-eqz v4, :cond_3

    .line 414
    move-object v4, p4

    check-cast v4, Lio/minio/PartSource;

    invoke-virtual {v4}, Lio/minio/PartSource;->sha256Hash()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    .line 415
    :cond_3
    instance-of v4, p4, [B

    if-eqz v4, :cond_5

    .line 416
    move-object v4, p4

    check-cast v4, [B

    invoke-static {v4, p5}, Lio/minio/Digest;->sha256Hash([BI)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    .line 421
    :cond_4
    const-string v3, "UNSIGNED-PAYLOAD"

    .line 422
    if-eqz p4, :cond_5

    instance-of v4, p4, Lio/minio/PartSource;

    if-eqz v4, :cond_5

    .line 423
    move-object v4, p4

    check-cast v4, Lio/minio/PartSource;

    invoke-virtual {v4}, Lio/minio/PartSource;->sha256Hash()Ljava/lang/String;

    move-result-object v3

    .line 428
    :cond_5
    :goto_1
    if-eqz v1, :cond_6

    const-string v4, "Content-MD5"

    invoke-virtual {v0, v4, v1}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 429
    :cond_6
    if-eqz v3, :cond_7

    const-string/jumbo v4, "x-amz-content-sha256"

    invoke-virtual {v0, v4, v3}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 431
    :cond_7
    if-eqz p6, :cond_8

    invoke-virtual {p6}, Lio/minio/credentials/Credentials;->sessionToken()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_8

    .line 432
    const-string v4, "X-Amz-Security-Token"

    invoke-virtual {p6}, Lio/minio/credentials/Credentials;->sessionToken()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v4, v5}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 435
    :cond_8
    invoke-static {}, Ljava/time/ZonedDateTime;->now()Ljava/time/ZonedDateTime;

    move-result-object v4

    .line 436
    .local v4, "date":Ljava/time/ZonedDateTime;
    sget-object v5, Lio/minio/Time;->AMZ_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-virtual {v4, v5}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v5

    const-string/jumbo v6, "x-amz-date"

    invoke-virtual {v0, v6, v5}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 438
    const/4 v5, 0x0

    .line 439
    .local v5, "requestBody":Lokhttp3/RequestBody;
    if-eqz p4, :cond_b

    .line 440
    if-eqz p3, :cond_9

    const-string v2, "Content-Type"

    invoke-virtual {p3, v2}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 441
    .local v2, "contentType":Ljava/lang/String;
    :cond_9
    instance-of v6, p4, Lio/minio/PartSource;

    if-eqz v6, :cond_a

    .line 442
    new-instance v6, Lio/minio/HttpRequestBody;

    move-object v7, p4

    check-cast v7, Lio/minio/PartSource;

    invoke-direct {v6, v7, v2}, Lio/minio/HttpRequestBody;-><init>(Lio/minio/PartSource;Ljava/lang/String;)V

    move-object v5, v6

    goto :goto_2

    .line 444
    :cond_a
    new-instance v6, Lio/minio/HttpRequestBody;

    move-object v7, p4

    check-cast v7, [B

    invoke-direct {v6, v7, p5, v2}, Lio/minio/HttpRequestBody;-><init>([BILjava/lang/String;)V

    move-object v5, v6

    .line 448
    .end local v2    # "contentType":Ljava/lang/String;
    :cond_b
    :goto_2
    invoke-virtual {p2}, Lio/minio/http/Method;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v5}, Lokhttp3/Request$Builder;->method(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    .line 449
    invoke-virtual {v0}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v2

    return-object v2
.end method

.method protected deleteObjects(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;ZZLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/DeleteObjectsResponse;
    .locals 2
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p4, "quiet"    # Z
    .param p5, "bypassGovernanceMode"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lio/minio/messages/DeleteObject;",
            ">;ZZ",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lio/minio/DeleteObjectsResponse;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Ljava/io/IOException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 2235
    .local p3, "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    .local p6, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p7, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p7}, Lio/minio/S3Base;->deleteObjectsAsync(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;ZZLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2243
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/DeleteObjectsResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2235
    return-object v0

    .line 2246
    :catch_0
    move-exception v0

    .line 2247
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2248
    const/4 v1, 0x0

    return-object v1

    .line 2244
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 2245
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected deleteObjectsAsync(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;ZZLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 13
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p4, "quiet"    # Z
    .param p5, "bypassGovernanceMode"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lio/minio/messages/DeleteObject;",
            ">;ZZ",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/DeleteObjectsResponse;",
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

    .line 2138
    .local p3, "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    .local p6, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p7, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    move-object v7, p0

    if-nez p3, :cond_0

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    move-object v8, v0

    .end local p3    # "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    .local v0, "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    goto :goto_0

    .end local v0    # "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    .restart local p3    # "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    :cond_0
    move-object/from16 v8, p3

    .line 2140
    .end local p3    # "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    .local v8, "objectList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    :goto_0
    invoke-interface {v8}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0x3e8

    if-gt v0, v1, :cond_2

    .line 2144
    nop

    .line 2147
    if-eqz p5, :cond_1

    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "x-amz-bypass-governance-retention"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string/jumbo v2, "true"

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Lio/minio/S3Base;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    goto :goto_1

    :cond_1
    const/4 v0, 0x0

    .line 2145
    :goto_1
    move-object/from16 v9, p6

    invoke-virtual {p0, v9, v0}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v10

    .line 2149
    .local v10, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    move-object v5, v8

    .line 2150
    .local v5, "objects":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v11

    new-instance v12, Lio/minio/S3Base$$ExternalSyntheticLambda38;

    move-object v0, v12

    move-object v1, p0

    move-object v2, p1

    move-object v3, v10

    move-object/from16 v4, p7

    move/from16 v6, p4

    invoke-direct/range {v0 .. v6}, Lio/minio/S3Base$$ExternalSyntheticLambda38;-><init>(Lio/minio/S3Base;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/util/List;Z)V

    .line 2151
    invoke-virtual {v11, v12}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda39;

    move-object v3, p2

    invoke-direct {v1, p1, p2}, Lio/minio/S3Base$$ExternalSyntheticLambda39;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 2172
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2150
    return-object v0

    .line 2141
    .end local v5    # "objects":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/DeleteObject;>;"
    .end local v10    # "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_2
    move-object v2, p1

    move-object v3, p2

    move-object/from16 v9, p6

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "list of objects must not be more than 1000"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public disableAccelerateEndpoint()V
    .locals 1

    .line 1693
    const/4 v0, 0x0

    iput-boolean v0, p0, Lio/minio/S3Base;->isAccelerateHost:Z

    .line 1694
    return-void
.end method

.method public disableDualStackEndpoint()V
    .locals 1

    .line 1703
    const/4 v0, 0x0

    iput-boolean v0, p0, Lio/minio/S3Base;->isDualStackHost:Z

    .line 1704
    return-void
.end method

.method public disableVirtualStyleEndpoint()V
    .locals 1

    .line 1713
    const/4 v0, 0x0

    iput-boolean v0, p0, Lio/minio/S3Base;->useVirtualStyle:Z

    .line 1714
    return-void
.end method

.method public enableAccelerateEndpoint()V
    .locals 1

    .line 1688
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/minio/S3Base;->isAccelerateHost:Z

    .line 1689
    return-void
.end method

.method public enableDualStackEndpoint()V
    .locals 1

    .line 1698
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/minio/S3Base;->isDualStackHost:Z

    .line 1699
    return-void
.end method

.method public enableVirtualStyleEndpoint()V
    .locals 1

    .line 1708
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/minio/S3Base;->useVirtualStyle:Z

    .line 1709
    return-void
.end method

.method protected execute(Lio/minio/http/Method;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Lokhttp3/Response;
    .locals 16
    .param p1, "method"    # Lio/minio/http/Method;
    .param p2, "args"    # Lio/minio/BaseArgs;
    .param p5, "body"    # Ljava/lang/Object;
    .param p6, "length"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/http/Method;",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/Object;",
            "I)",
            "Lokhttp3/Response;"
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

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 800
    .local p3, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    move-object/from16 v9, p0

    move-object/from16 v10, p2

    const/4 v0, 0x0

    .line 801
    .local v0, "bucketName":Ljava/lang/String;
    const/4 v1, 0x0

    .line 802
    .local v1, "region":Ljava/lang/String;
    const/4 v2, 0x0

    .line 804
    .local v2, "objectName":Ljava/lang/String;
    instance-of v3, v10, Lio/minio/BucketArgs;

    if-eqz v3, :cond_0

    .line 805
    move-object v3, v10

    check-cast v3, Lio/minio/BucketArgs;

    invoke-virtual {v3}, Lio/minio/BucketArgs;->bucket()Ljava/lang/String;

    move-result-object v0

    .line 806
    move-object v3, v10

    check-cast v3, Lio/minio/BucketArgs;

    invoke-virtual {v3}, Lio/minio/BucketArgs;->region()Ljava/lang/String;

    move-result-object v1

    move-object v11, v0

    move-object v12, v1

    goto :goto_0

    .line 804
    :cond_0
    move-object v11, v0

    move-object v12, v1

    .line 809
    .end local v0    # "bucketName":Ljava/lang/String;
    .end local v1    # "region":Ljava/lang/String;
    .local v11, "bucketName":Ljava/lang/String;
    .local v12, "region":Ljava/lang/String;
    :goto_0
    instance-of v0, v10, Lio/minio/ObjectArgs;

    if-eqz v0, :cond_1

    move-object v0, v10

    check-cast v0, Lio/minio/ObjectArgs;

    invoke-virtual {v0}, Lio/minio/ObjectArgs;->object()Ljava/lang/String;

    move-result-object v2

    :cond_1
    move-object v13, v2

    .line 811
    .end local v2    # "objectName":Ljava/lang/String;
    .local v13, "objectName":Ljava/lang/String;
    nop

    .line 815
    invoke-virtual {v9, v11, v12}, Lio/minio/S3Base;->getRegion(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 816
    invoke-virtual/range {p2 .. p2}, Lio/minio/BaseArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v0

    move-object/from16 v14, p3

    invoke-virtual {v9, v0, v14}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    invoke-virtual {v9, v0}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v5

    .line 817
    invoke-virtual/range {p2 .. p2}, Lio/minio/BaseArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v0

    move-object/from16 v15, p4

    invoke-virtual {v9, v0, v15}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    .line 811
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object v2, v11

    move-object v3, v13

    move-object/from16 v7, p5

    move/from16 v8, p6

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->execute(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Lokhttp3/Response;

    move-result-object v0

    return-object v0
.end method

.method protected execute(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Lokhttp3/Response;
    .locals 3
    .param p1, "method"    # Lio/minio/http/Method;
    .param p2, "bucketName"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "region"    # Ljava/lang/String;
    .param p5, "headers"    # Lokhttp3/Headers;
    .param p7, "body"    # Ljava/lang/Object;
    .param p8, "length"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/http/Method;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lokhttp3/Headers;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/Object;",
            "I)",
            "Lokhttp3/Response;"
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

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 772
    .local p6, "queryParamMap":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    nop

    .line 773
    invoke-virtual/range {p0 .. p8}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 775
    .local v0, "completableFuture":Ljava/util/concurrent/CompletableFuture;, "Ljava/util/concurrent/CompletableFuture<Lokhttp3/Response;>;"
    :try_start_0
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lokhttp3/Response;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 778
    :catch_0
    move-exception v1

    .line 779
    .local v1, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v1}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 780
    const/4 v2, 0x0

    return-object v2

    .line 776
    .end local v1    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v1

    .line 777
    .local v1, "e":Ljava/lang/InterruptedException;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2
.end method

.method protected executeAsync(Lio/minio/http/Method;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;
    .locals 16
    .param p1, "method"    # Lio/minio/http/Method;
    .param p2, "args"    # Lio/minio/BaseArgs;
    .param p5, "body"    # Ljava/lang/Object;
    .param p6, "length"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/http/Method;",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/Object;",
            "I)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lokhttp3/Response;",
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

    .line 716
    .local p3, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p4, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    move-object/from16 v10, p2

    instance-of v0, v10, Lio/minio/BucketArgs;

    if-eqz v0, :cond_0

    .line 717
    move-object v0, v10

    check-cast v0, Lio/minio/BucketArgs;

    invoke-virtual {v0}, Lio/minio/BucketArgs;->bucket()Ljava/lang/String;

    move-result-object v0

    .line 718
    .local v0, "bucketName":Ljava/lang/String;
    move-object v1, v10

    check-cast v1, Lio/minio/BucketArgs;

    invoke-virtual {v1}, Lio/minio/BucketArgs;->region()Ljava/lang/String;

    move-result-object v1

    move-object v11, v0

    move-object v12, v1

    .local v1, "region":Ljava/lang/String;
    goto :goto_0

    .line 720
    .end local v0    # "bucketName":Ljava/lang/String;
    .end local v1    # "region":Ljava/lang/String;
    :cond_0
    const/4 v0, 0x0

    .line 721
    .restart local v0    # "bucketName":Ljava/lang/String;
    const/4 v1, 0x0

    move-object v11, v0

    move-object v12, v1

    .line 724
    .end local v0    # "bucketName":Ljava/lang/String;
    .local v11, "bucketName":Ljava/lang/String;
    .local v12, "region":Ljava/lang/String;
    :goto_0
    instance-of v0, v10, Lio/minio/ObjectArgs;

    if-eqz v0, :cond_1

    .line 725
    move-object v0, v10

    check-cast v0, Lio/minio/ObjectArgs;

    invoke-virtual {v0}, Lio/minio/ObjectArgs;->object()Ljava/lang/String;

    move-result-object v0

    move-object v13, v0

    .local v0, "objectName":Ljava/lang/String;
    goto :goto_1

    .line 727
    .end local v0    # "objectName":Ljava/lang/String;
    :cond_1
    const/4 v0, 0x0

    move-object v13, v0

    .line 730
    .local v13, "objectName":Ljava/lang/String;
    :goto_1
    move-object/from16 v14, p0

    invoke-virtual {v14, v11, v12}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v15

    new-instance v9, Lio/minio/S3Base$$ExternalSyntheticLambda6;

    move-object v0, v9

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object v3, v11

    move-object v4, v13

    move-object/from16 v5, p2

    move-object/from16 v6, p3

    move-object/from16 v7, p4

    move-object/from16 v8, p5

    move-object v10, v9

    move/from16 v9, p6

    invoke-direct/range {v0 .. v9}, Lio/minio/S3Base$$ExternalSyntheticLambda6;-><init>(Lio/minio/S3Base;Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)V

    .line 731
    invoke-virtual {v15, v10}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 730
    return-object v0
.end method

.method protected executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;
    .locals 23
    .param p1, "method"    # Lio/minio/http/Method;
    .param p2, "bucketName"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "region"    # Ljava/lang/String;
    .param p5, "headers"    # Lokhttp3/Headers;
    .param p7, "body"    # Ljava/lang/Object;
    .param p8, "length"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/http/Method;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lokhttp3/Headers;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/Object;",
            "I)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lokhttp3/Response;",
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

    .line 481
    .local p6, "queryParamMap":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    move-object/from16 v10, p0

    move-object/from16 v11, p1

    move-object/from16 v0, p7

    const/4 v1, 0x0

    .line 482
    .local v1, "traceRequestBody":Z
    if-eqz v0, :cond_1

    instance-of v2, v0, Lio/minio/PartSource;

    if-nez v2, :cond_1

    instance-of v2, v0, [B

    if-nez v2, :cond_1

    .line 484
    instance-of v2, v0, Ljava/lang/CharSequence;

    if-eqz v2, :cond_0

    .line 485
    invoke-virtual/range {p7 .. p7}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v2, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v2

    .local v2, "bytes":[B
    goto :goto_0

    .line 487
    .end local v2    # "bytes":[B
    :cond_0
    invoke-static/range {p7 .. p7}, Lio/minio/Xml;->marshal(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v2, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v2

    .line 490
    .restart local v2    # "bytes":[B
    :goto_0
    move-object v0, v2

    .line 491
    .end local p7    # "body":Ljava/lang/Object;
    .local v0, "body":Ljava/lang/Object;
    array-length v3, v2

    .line 492
    .end local p8    # "length":I
    .local v3, "length":I
    const/4 v1, 0x1

    move v13, v1

    move v12, v3

    goto :goto_1

    .line 495
    .end local v0    # "body":Ljava/lang/Object;
    .end local v2    # "bytes":[B
    .end local v3    # "length":I
    .restart local p7    # "body":Ljava/lang/Object;
    .restart local p8    # "length":I
    :cond_1
    move/from16 v12, p8

    move v13, v1

    .end local v1    # "traceRequestBody":Z
    .end local p7    # "body":Ljava/lang/Object;
    .end local p8    # "length":I
    .restart local v0    # "body":Ljava/lang/Object;
    .local v12, "length":I
    .local v13, "traceRequestBody":Z
    :goto_1
    if-nez v0, :cond_3

    sget-object v1, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;

    if-eq v11, v1, :cond_2

    sget-object v1, Lio/minio/http/Method;->POST:Lio/minio/http/Method;

    if-ne v11, v1, :cond_3

    .line 496
    :cond_2
    sget-object v0, Lio/minio/http/HttpUtils;->EMPTY_BODY:[B

    move-object v14, v0

    goto :goto_2

    .line 499
    :cond_3
    move-object v14, v0

    .end local v0    # "body":Ljava/lang/Object;
    .local v14, "body":Ljava/lang/Object;
    :goto_2
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object/from16 v4, p4

    move-object/from16 v5, p6

    invoke-virtual/range {v0 .. v5}, Lio/minio/S3Base;->buildUrl(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;)Lokhttp3/HttpUrl;

    move-result-object v15

    .line 500
    .local v15, "url":Lokhttp3/HttpUrl;
    iget-object v0, v10, Lio/minio/S3Base;->provider:Lio/minio/credentials/Provider;

    const/4 v7, 0x0

    if-nez v0, :cond_4

    move-object v0, v7

    goto :goto_3

    :cond_4
    iget-object v0, v10, Lio/minio/S3Base;->provider:Lio/minio/credentials/Provider;

    invoke-interface {v0}, Lio/minio/credentials/Provider;->fetch()Lio/minio/credentials/Credentials;

    move-result-object v0

    :goto_3
    move-object/from16 v16, v0

    .line 501
    .local v16, "creds":Lio/minio/credentials/Credentials;
    move-object/from16 v0, p0

    move-object v1, v15

    move-object/from16 v2, p1

    move-object/from16 v3, p5

    move-object v4, v14

    move v5, v12

    move-object/from16 v6, v16

    invoke-virtual/range {v0 .. v6}, Lio/minio/S3Base;->createRequest(Lokhttp3/HttpUrl;Lio/minio/http/Method;Lokhttp3/Headers;Ljava/lang/Object;ILio/minio/credentials/Credentials;)Lokhttp3/Request;

    move-result-object v0

    .line 502
    .local v0, "req":Lokhttp3/Request;
    if-eqz v16, :cond_5

    .line 503
    nop

    .line 507
    invoke-virtual/range {v16 .. v16}, Lio/minio/credentials/Credentials;->accessKey()Ljava/lang/String;

    move-result-object v1

    .line 508
    invoke-virtual/range {v16 .. v16}, Lio/minio/credentials/Credentials;->secretKey()Ljava/lang/String;

    move-result-object v2

    .line 509
    const-string/jumbo v3, "x-amz-content-sha256"

    invoke-virtual {v0, v3}, Lokhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 504
    move-object/from16 v9, p4

    invoke-static {v0, v9, v1, v2, v3}, Lio/minio/Signer;->signV4S3(Lokhttp3/Request;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request;

    move-result-object v0

    move-object/from16 v17, v0

    goto :goto_4

    .line 502
    :cond_5
    move-object/from16 v9, p4

    move-object/from16 v17, v0

    .line 511
    .end local v0    # "req":Lokhttp3/Request;
    .local v17, "req":Lokhttp3/Request;
    :goto_4
    move-object/from16 v8, v17

    .line 513
    .local v8, "request":Lokhttp3/Request;
    nop

    .line 515
    if-eqz v13, :cond_6

    new-instance v7, Ljava/lang/String;

    move-object v0, v14

    check-cast v0, [B

    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v7, v0, v1}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 514
    :cond_6
    invoke-direct {v10, v8, v7}, Lio/minio/S3Base;->newTraceBuilder(Lokhttp3/Request;Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    .line 516
    .local v7, "traceBuilder":Ljava/lang/StringBuilder;
    iget-object v6, v10, Lio/minio/S3Base;->traceStream:Ljava/io/PrintWriter;

    .line 517
    .local v6, "traceStream":Ljava/io/PrintWriter;
    if-eqz v6, :cond_7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 518
    :cond_7
    const-string v0, "\n"

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 520
    iget-object v0, v10, Lio/minio/S3Base;->httpClient:Lokhttp3/OkHttpClient;

    .line 521
    .local v0, "httpClient":Lokhttp3/OkHttpClient;
    instance-of v1, v14, [B

    if-nez v1, :cond_9

    sget-object v1, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;

    if-eq v11, v1, :cond_8

    sget-object v1, Lio/minio/http/Method;->POST:Lio/minio/http/Method;

    if-ne v11, v1, :cond_9

    .line 523
    :cond_8
    iget-object v1, v10, Lio/minio/S3Base;->httpClient:Lokhttp3/OkHttpClient;

    invoke-virtual {v1}, Lokhttp3/OkHttpClient;->newBuilder()Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lokhttp3/OkHttpClient$Builder;->retryOnConnectionFailure(Z)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    move-object v5, v0

    goto :goto_5

    .line 526
    :cond_9
    move-object v5, v0

    .end local v0    # "httpClient":Lokhttp3/OkHttpClient;
    .local v5, "httpClient":Lokhttp3/OkHttpClient;
    :goto_5
    new-instance v0, Ljava/util/concurrent/CompletableFuture;

    invoke-direct {v0}, Ljava/util/concurrent/CompletableFuture;-><init>()V

    move-object/from16 v18, v0

    .line 527
    .local v18, "completableFuture":Ljava/util/concurrent/CompletableFuture;, "Ljava/util/concurrent/CompletableFuture<Lokhttp3/Response;>;"
    nop

    .line 528
    invoke-virtual {v5, v8}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v4

    new-instance v3, Lio/minio/S3Base$1;

    move-object v0, v3

    move-object/from16 v1, p0

    move-object/from16 v2, v18

    move-object v10, v3

    move-object v3, v7

    move-object v11, v4

    move-object v4, v6

    move-object/from16 v19, v5

    .end local v5    # "httpClient":Lokhttp3/OkHttpClient;
    .local v19, "httpClient":Lokhttp3/OkHttpClient;
    move-object/from16 v5, p6

    move-object/from16 v20, v6

    .end local v6    # "traceStream":Ljava/io/PrintWriter;
    .local v20, "traceStream":Ljava/io/PrintWriter;
    move-object/from16 v6, p1

    move-object/from16 v21, v7

    .end local v7    # "traceBuilder":Ljava/lang/StringBuilder;
    .local v21, "traceBuilder":Ljava/lang/StringBuilder;
    move-object/from16 v7, p3

    move-object/from16 v22, v8

    .end local v8    # "request":Lokhttp3/Request;
    .local v22, "request":Lokhttp3/Request;
    move-object/from16 v8, p2

    move-object/from16 v9, v22

    invoke-direct/range {v0 .. v9}, Lio/minio/S3Base$1;-><init>(Lio/minio/S3Base;Ljava/util/concurrent/CompletableFuture;Ljava/lang/StringBuilder;Ljava/io/PrintWriter;Lcom/google/common/collect/Multimap;Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Request;)V

    .line 529
    invoke-interface {v11, v10}, Lokhttp3/Call;->enqueue(Lokhttp3/Callback;)V

    .line 699
    return-object v18
.end method

.method protected executeDelete(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lokhttp3/Response;
    .locals 2
    .param p1, "args"    # Lio/minio/BaseArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lokhttp3/Response;"
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

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 999
    .local p2, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual {p0, p1, p2, p3}, Lio/minio/S3Base;->executeDeleteAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/Response;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1002
    :catch_0
    move-exception v0

    .line 1003
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1004
    const/4 v1, 0x0

    return-object v1

    .line 1000
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1001
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected executeDeleteAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 7
    .param p1, "args"    # Lio/minio/BaseArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lokhttp3/Response;",
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

    .line 979
    .local p2, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    sget-object v1, Lio/minio/http/Method;->DELETE:Lio/minio/http/Method;

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    invoke-virtual/range {v0 .. v6}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lio/minio/S3Base$$ExternalSyntheticLambda0;-><init>()V

    .line 980
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 979
    return-object v0
.end method

.method protected executeGet(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lokhttp3/Response;
    .locals 2
    .param p1, "args"    # Lio/minio/BaseArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lokhttp3/Response;"
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

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 909
    .local p2, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual {p0, p1, p2, p3}, Lio/minio/S3Base;->executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/Response;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 912
    :catch_0
    move-exception v0

    .line 913
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 914
    const/4 v1, 0x0

    return-object v1

    .line 910
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 911
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected executeGetAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 7
    .param p1, "args"    # Lio/minio/BaseArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lokhttp3/Response;",
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

    .line 894
    .local p2, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    sget-object v1, Lio/minio/http/Method;->GET:Lio/minio/http/Method;

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    invoke-virtual/range {v0 .. v6}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method protected executeHead(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lokhttp3/Response;
    .locals 2
    .param p1, "args"    # Lio/minio/BaseArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lokhttp3/Response;"
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

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 965
    .local p2, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual {p0, p1, p2, p3}, Lio/minio/S3Base;->executeHeadAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/Response;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 968
    :catch_0
    move-exception v0

    .line 969
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 970
    const/4 v1, 0x0

    return-object v1

    .line 966
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 967
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected executeHeadAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 7
    .param p1, "args"    # Lio/minio/BaseArgs;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lokhttp3/Response;",
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

    .line 923
    .local p2, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    sget-object v1, Lio/minio/http/Method;->HEAD:Lio/minio/http/Method;

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    invoke-virtual/range {v0 .. v6}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda23;

    invoke-direct {v1}, Lio/minio/S3Base$$ExternalSyntheticLambda23;-><init>()V

    .line 924
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->exceptionally(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda24;

    invoke-direct {v1, p0, p1, p2, p3}, Lio/minio/S3Base$$ExternalSyntheticLambda24;-><init>(Lio/minio/S3Base;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)V

    .line 934
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 923
    return-object v0
.end method

.method protected executePost(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;)Lokhttp3/Response;
    .locals 2
    .param p1, "args"    # Lio/minio/BaseArgs;
    .param p4, "data"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/Object;",
            ")",
            "Lokhttp3/Response;"
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

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1034
    .local p2, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lio/minio/S3Base;->executePostAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/Response;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1037
    :catch_0
    move-exception v0

    .line 1038
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1039
    const/4 v1, 0x0

    return-object v1

    .line 1035
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1036
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected executePostAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;
    .locals 7
    .param p1, "args"    # Lio/minio/BaseArgs;
    .param p4, "data"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/Object;",
            ")",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lokhttp3/Response;",
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

    .line 1016
    .local p2, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    sget-object v1, Lio/minio/http/Method;->POST:Lio/minio/http/Method;

    const/4 v6, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-virtual/range {v0 .. v6}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method protected executePut(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Lokhttp3/Response;
    .locals 2
    .param p1, "args"    # Lio/minio/BaseArgs;
    .param p4, "data"    # Ljava/lang/Object;
    .param p5, "length"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/Object;",
            "I)",
            "Lokhttp3/Response;"
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

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1071
    .local p2, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p5}, Lio/minio/S3Base;->executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/Response;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1074
    :catch_0
    move-exception v0

    .line 1075
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1076
    const/4 v1, 0x0

    return-object v1

    .line 1072
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1073
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected executePutAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;
    .locals 7
    .param p1, "args"    # Lio/minio/BaseArgs;
    .param p4, "data"    # Ljava/lang/Object;
    .param p5, "length"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/BaseArgs;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/Object;",
            "I)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lokhttp3/Response;",
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

    .line 1052
    .local p2, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p3, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    sget-object v1, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move v6, p5

    invoke-virtual/range {v0 .. v6}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method protected getRegion(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
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

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 880
    :try_start_0
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 883
    :catch_0
    move-exception v0

    .line 884
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 885
    const/4 v1, 0x0

    return-object v1

    .line 881
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 882
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;
    .locals 10
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
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

    .line 826
    if-eqz p2, :cond_2

    .line 828
    iget-object v0, p0, Lio/minio/S3Base;->region:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lio/minio/S3Base;->region:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 829
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "region must be "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lio/minio/S3Base;->region:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", but passed "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 832
    :cond_1
    :goto_0
    invoke-static {p2}, Ljava/util/concurrent/CompletableFuture;->completedFuture(Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0

    .line 835
    :cond_2
    iget-object v0, p0, Lio/minio/S3Base;->region:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lio/minio/S3Base;->region:Ljava/lang/String;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 836
    iget-object v0, p0, Lio/minio/S3Base;->region:Ljava/lang/String;

    invoke-static {v0}, Ljava/util/concurrent/CompletableFuture;->completedFuture(Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0

    .line 838
    :cond_3
    if-eqz p1, :cond_6

    iget-object v0, p0, Lio/minio/S3Base;->provider:Lio/minio/credentials/Provider;

    if-nez v0, :cond_4

    goto :goto_1

    .line 841
    :cond_4
    iget-object v0, p0, Lio/minio/S3Base;->regionCache:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object p2, v0

    check-cast p2, Ljava/lang/String;

    .line 842
    if-eqz p2, :cond_5

    invoke-static {p2}, Ljava/util/concurrent/CompletableFuture;->completedFuture(Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0

    .line 845
    :cond_5
    sget-object v2, Lio/minio/http/Method;->GET:Lio/minio/http/Method;

    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v3, "location"

    aput-object v3, v0, v1

    const/4 v1, 0x1

    const/4 v3, 0x0

    aput-object v3, v0, v1

    .line 847
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v7

    .line 846
    const/4 v4, 0x0

    const-string/jumbo v5, "us-east-1"

    const/4 v6, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v1, p0

    move-object v3, p1

    invoke-virtual/range {v1 .. v9}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 848
    .local v0, "future":Ljava/util/concurrent/CompletableFuture;, "Ljava/util/concurrent/CompletableFuture<Lokhttp3/Response;>;"
    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda13;

    invoke-direct {v1, p0, p1}, Lio/minio/S3Base$$ExternalSyntheticLambda13;-><init>(Lio/minio/S3Base;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    return-object v1

    .line 839
    .end local v0    # "future":Ljava/util/concurrent/CompletableFuture;, "Ljava/util/concurrent/CompletableFuture<Lokhttp3/Response;>;"
    :cond_6
    :goto_1
    const-string/jumbo v0, "us-east-1"

    invoke-static {v0}, Ljava/util/concurrent/CompletableFuture;->completedFuture(Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0
.end method

.method protected httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lokhttp3/Headers;"
        }
    .end annotation

    .line 369
    .local p1, "headerMap":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v0, Lokhttp3/Headers$Builder;

    invoke-direct {v0}, Lokhttp3/Headers$Builder;-><init>()V

    .line 370
    .local v0, "builder":Lokhttp3/Headers$Builder;
    if-nez p1, :cond_0

    invoke-virtual {v0}, Lokhttp3/Headers$Builder;->build()Lokhttp3/Headers;

    move-result-object v1

    return-object v1

    .line 372
    :cond_0
    const-string v1, "Content-Encoding"

    invoke-interface {p1, v1}, Lcom/google/common/collect/Multimap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 373
    nop

    .line 375
    invoke-interface {p1, v1}, Lcom/google/common/collect/Multimap;->get(Ljava/lang/Object;)Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->stream()Ljava/util/stream/Stream;

    move-result-object v2

    .line 376
    invoke-interface {v2}, Ljava/util/stream/Stream;->distinct()Ljava/util/stream/Stream;

    move-result-object v2

    new-instance v3, Lio/minio/S3Base$$ExternalSyntheticLambda5;

    invoke-direct {v3}, Lio/minio/S3Base$$ExternalSyntheticLambda5;-><init>()V

    .line 377
    invoke-interface {v2, v3}, Ljava/util/stream/Stream;->filter(Ljava/util/function/Predicate;)Ljava/util/stream/Stream;

    move-result-object v2

    .line 378
    const-string v3, ","

    invoke-static {v3}, Ljava/util/stream/Collectors;->joining(Ljava/lang/CharSequence;)Ljava/util/stream/Collector;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/stream/Stream;->collect(Ljava/util/stream/Collector;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 373
    invoke-virtual {v0, v1, v2}, Lokhttp3/Headers$Builder;->add(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Headers$Builder;

    .line 381
    :cond_1
    invoke-interface {p1}, Lcom/google/common/collect/Multimap;->entries()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .line 382
    .local v3, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v4, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 383
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {v0, v4, v5}, Lokhttp3/Headers$Builder;->addUnsafeNonAscii(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Headers$Builder;

    .line 385
    .end local v3    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_2
    goto :goto_0

    .line 387
    :cond_3
    invoke-virtual {v0}, Lokhttp3/Headers$Builder;->build()Lokhttp3/Headers;

    move-result-object v1

    return-object v1
.end method

.method public ignoreCertCheck()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/KeyManagementException;,
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 1648
    iget-object v0, p0, Lio/minio/S3Base;->httpClient:Lokhttp3/OkHttpClient;

    invoke-static {v0}, Lio/minio/http/HttpUtils;->disableCertCheck(Lokhttp3/OkHttpClient;)Lokhttp3/OkHttpClient;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base;->httpClient:Lokhttp3/OkHttpClient;

    .line 1649
    return-void
.end method

.method synthetic lambda$abortMultipartUploadAsync$9$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "extraHeaders"    # Lcom/google/common/collect/Multimap;
    .param p4, "extraQueryParams"    # Lcom/google/common/collect/Multimap;
    .param p5, "uploadId"    # Ljava/lang/String;
    .param p6, "location"    # Ljava/lang/String;

    .line 1764
    :try_start_0
    sget-object v1, Lio/minio/http/Method;->DELETE:Lio/minio/http/Method;

    .line 1769
    invoke-virtual {p0, p3}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v5

    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const-string/jumbo v2, "uploadId"

    const/4 v3, 0x0

    aput-object v2, v0, v3

    const/4 v2, 0x1

    aput-object p5, v0, v2

    .line 1770
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    invoke-virtual {p0, p4, v0}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    .line 1764
    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p6

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1773
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

    .line 1779
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$completeMultipartUploadAsync$11$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;[Lio/minio/messages/Part;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "extraHeaders"    # Lcom/google/common/collect/Multimap;
    .param p4, "queryParams"    # Lcom/google/common/collect/Multimap;
    .param p5, "parts"    # [Lio/minio/messages/Part;
    .param p6, "location"    # Ljava/lang/String;

    .line 1875
    :try_start_0
    sget-object v1, Lio/minio/http/Method;->POST:Lio/minio/http/Method;

    .line 1880
    invoke-virtual {p0, p3}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v5

    new-instance v7, Lio/minio/messages/CompleteMultipartUpload;

    invoke-direct {v7, p5}, Lio/minio/messages/CompleteMultipartUpload;-><init>([Lio/minio/messages/Part;)V

    .line 1875
    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p6

    move-object v6, p4

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1884
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

    .line 1890
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$createMultipartUploadAsync$13$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "headersCopy"    # Lcom/google/common/collect/Multimap;
    .param p4, "queryParams"    # Lcom/google/common/collect/Multimap;
    .param p5, "location"    # Ljava/lang/String;

    .line 2031
    :try_start_0
    sget-object v1, Lio/minio/http/Method;->POST:Lio/minio/http/Method;

    .line 2036
    invoke-virtual {p0, p3}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v5

    .line 2031
    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p5

    move-object v6, p4

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2040
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

    .line 2046
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$deleteObjectsAsync$15$io-minio-S3Base(Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/util/List;ZLjava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "headers"    # Lcom/google/common/collect/Multimap;
    .param p3, "extraQueryParams"    # Lcom/google/common/collect/Multimap;
    .param p4, "objects"    # Ljava/util/List;
    .param p5, "quiet"    # Z
    .param p6, "location"    # Ljava/lang/String;

    .line 2154
    :try_start_0
    sget-object v1, Lio/minio/http/Method;->POST:Lio/minio/http/Method;

    .line 2159
    invoke-virtual {p0, p2}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v5

    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const-string v2, "delete"

    const/4 v3, 0x0

    aput-object v2, v0, v3

    const-string v2, ""

    const/4 v3, 0x1

    aput-object v2, v0, v3

    .line 2160
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    invoke-virtual {p0, p3, v0}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v6

    new-instance v7, Lio/minio/messages/DeleteRequest;

    invoke-direct {v7, p4, p5}, Lio/minio/messages/DeleteRequest;-><init>(Ljava/util/List;Z)V

    .line 2154
    const/4 v3, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v4, p6

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2163
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

    .line 2169
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$executeAsync$1$io-minio-S3Base(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;ILjava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 13
    .param p1, "method"    # Lio/minio/http/Method;
    .param p2, "bucketName"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "args"    # Lio/minio/BaseArgs;
    .param p5, "headers"    # Lcom/google/common/collect/Multimap;
    .param p6, "queryParams"    # Lcom/google/common/collect/Multimap;
    .param p7, "body"    # Ljava/lang/Object;
    .param p8, "length"    # I
    .param p9, "location"    # Ljava/lang/String;

    .line 734
    move-object v10, p0

    .line 739
    :try_start_0
    invoke-virtual/range {p4 .. p4}, Lio/minio/BaseArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_11
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_10
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_f
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_e
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_d
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_c

    move-object/from16 v11, p5

    :try_start_1
    invoke-virtual {p0, v0, v11}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    invoke-virtual {p0, v0}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v6

    .line 740
    invoke-virtual/range {p4 .. p4}, Lio/minio/BaseArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v0
    :try_end_1
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_1 .. :try_end_1} :catch_b
    .catch Lio/minio/errors/InternalException; {:try_start_1 .. :try_end_1} :catch_a
    .catch Ljava/security/InvalidKeyException; {:try_start_1 .. :try_end_1} :catch_9
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_6

    move-object/from16 v12, p6

    :try_start_2
    invoke-virtual {p0, v0, v12}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v7

    .line 734
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object/from16 v4, p3

    move-object/from16 v5, p9

    move-object/from16 v8, p7

    move/from16 v9, p8

    invoke-virtual/range {v1 .. v9}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_2
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_2 .. :try_end_2} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_2 .. :try_end_2} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_2 .. :try_end_2} :catch_0

    return-object v0

    .line 743
    :catch_0
    move-exception v0

    goto :goto_2

    :catch_1
    move-exception v0

    goto :goto_2

    :catch_2
    move-exception v0

    goto :goto_2

    :catch_3
    move-exception v0

    goto :goto_2

    :catch_4
    move-exception v0

    goto :goto_2

    :catch_5
    move-exception v0

    goto :goto_2

    :catch_6
    move-exception v0

    goto :goto_1

    :catch_7
    move-exception v0

    goto :goto_1

    :catch_8
    move-exception v0

    goto :goto_1

    :catch_9
    move-exception v0

    goto :goto_1

    :catch_a
    move-exception v0

    goto :goto_1

    :catch_b
    move-exception v0

    goto :goto_1

    :catch_c
    move-exception v0

    goto :goto_0

    :catch_d
    move-exception v0

    goto :goto_0

    :catch_e
    move-exception v0

    goto :goto_0

    :catch_f
    move-exception v0

    goto :goto_0

    :catch_10
    move-exception v0

    goto :goto_0

    :catch_11
    move-exception v0

    :goto_0
    move-object/from16 v11, p5

    :goto_1
    move-object/from16 v12, p6

    .line 749
    .local v0, "e":Ljava/lang/Exception;
    :goto_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$executeHeadAsync$4$io-minio-S3Base(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Lokhttp3/Response;)Ljava/util/concurrent/CompletionStage;
    .locals 8
    .param p1, "args"    # Lio/minio/BaseArgs;
    .param p2, "headers"    # Lcom/google/common/collect/Multimap;
    .param p3, "queryParams"    # Lcom/google/common/collect/Multimap;
    .param p4, "response"    # Lokhttp3/Response;

    .line 936
    if-eqz p4, :cond_0

    .line 937
    invoke-static {p4}, Ljava/util/concurrent/CompletableFuture;->completedFuture(Ljava/lang/Object;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0

    .line 941
    :cond_0
    :try_start_0
    sget-object v2, Lio/minio/http/Method;->HEAD:Lio/minio/http/Method;

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v1, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-virtual/range {v1 .. v7}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 942
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

    .line 948
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$getRegionAsync$2$io-minio-S3Base(Ljava/lang/String;Lokhttp3/Response;)Ljava/lang/String;
    .locals 4
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "response"    # Lokhttp3/Response;

    .line 851
    :try_start_0
    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    .line 852
    .local v0, "body":Lokhttp3/ResponseBody;
    :try_start_1
    const-class v1, Lio/minio/messages/LocationConstraint;

    invoke-virtual {v0}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v2

    invoke-static {v1, v2}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/minio/messages/LocationConstraint;

    .line 853
    .local v1, "lc":Lio/minio/messages/LocationConstraint;
    invoke-virtual {v1}, Lio/minio/messages/LocationConstraint;->location()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {v1}, Lio/minio/messages/LocationConstraint;->location()Ljava/lang/String;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_0

    .line 855
    :cond_0
    invoke-virtual {v1}, Lio/minio/messages/LocationConstraint;->location()Ljava/lang/String;

    move-result-object v2

    const-string v3, "EU"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 856
    const-string v2, "eu-west-1"

    .local v2, "location":Ljava/lang/String;
    goto :goto_1

    .line 858
    .end local v2    # "location":Ljava/lang/String;
    :cond_1
    invoke-virtual {v1}, Lio/minio/messages/LocationConstraint;->location()Ljava/lang/String;

    move-result-object v2

    .restart local v2    # "location":Ljava/lang/String;
    goto :goto_1

    .line 854
    .end local v2    # "location":Ljava/lang/String;
    :cond_2
    :goto_0
    const-string/jumbo v2, "us-east-1"
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 860
    .end local v1    # "lc":Lio/minio/messages/LocationConstraint;
    .restart local v2    # "location":Ljava/lang/String;
    :goto_1
    if-eqz v0, :cond_3

    :try_start_2
    invoke-virtual {v0}, Lokhttp3/ResponseBody;->close()V
    :try_end_2
    .catch Lio/minio/errors/XmlParserException; {:try_start_2 .. :try_end_2} :catch_0

    .line 862
    .end local v0    # "body":Lokhttp3/ResponseBody;
    :cond_3
    nop

    .line 864
    iget-object v0, p0, Lio/minio/S3Base;->regionCache:Ljava/util/Map;

    invoke-interface {v0, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 865
    return-object v2

    .line 851
    .end local v2    # "location":Ljava/lang/String;
    .restart local v0    # "body":Lokhttp3/ResponseBody;
    :catchall_0
    move-exception v1

    if-eqz v0, :cond_4

    :try_start_3
    invoke-virtual {v0}, Lokhttp3/ResponseBody;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_2

    :catchall_1
    move-exception v2

    :try_start_4
    invoke-virtual {v1, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local p1    # "bucketName":Ljava/lang/String;
    .end local p2    # "response":Lokhttp3/Response;
    :cond_4
    :goto_2
    throw v1
    :try_end_4
    .catch Lio/minio/errors/XmlParserException; {:try_start_4 .. :try_end_4} :catch_0

    .line 860
    .end local v0    # "body":Lokhttp3/ResponseBody;
    .restart local p1    # "bucketName":Ljava/lang/String;
    .restart local p2    # "response":Lokhttp3/Response;
    :catch_0
    move-exception v0

    .line 861
    .local v0, "e":Lio/minio/errors/XmlParserException;
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$listMultipartUploadsAsync$30$io-minio-S3Base(Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "extraHeaders"    # Lcom/google/common/collect/Multimap;
    .param p3, "queryParams"    # Lcom/google/common/collect/Multimap;
    .param p4, "location"    # Ljava/lang/String;

    .line 3105
    :try_start_0
    sget-object v1, Lio/minio/http/Method;->GET:Lio/minio/http/Method;

    .line 3110
    invoke-virtual {p0, p2}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v5

    .line 3105
    const/4 v3, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v4, p4

    move-object v6, p3

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 3114
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

    .line 3120
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$listObjectVersionsAsync$21$io-minio-S3Base(Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "extraHeaders"    # Lcom/google/common/collect/Multimap;
    .param p3, "queryParams"    # Lcom/google/common/collect/Multimap;
    .param p4, "location"    # Ljava/lang/String;

    .line 2587
    :try_start_0
    sget-object v1, Lio/minio/http/Method;->GET:Lio/minio/http/Method;

    .line 2592
    invoke-virtual {p0, p2}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v5

    .line 2587
    const/4 v3, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v4, p4

    move-object v6, p3

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2596
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

    .line 2602
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$listObjectsV1Async$19$io-minio-S3Base(Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "extraHeaders"    # Lcom/google/common/collect/Multimap;
    .param p3, "queryParams"    # Lcom/google/common/collect/Multimap;
    .param p4, "location"    # Ljava/lang/String;

    .line 2448
    :try_start_0
    sget-object v1, Lio/minio/http/Method;->GET:Lio/minio/http/Method;

    .line 2453
    invoke-virtual {p0, p2}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v5

    .line 2448
    const/4 v3, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v4, p4

    move-object v6, p3

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2457
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

    .line 2463
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$listObjectsV2Async$17$io-minio-S3Base(Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "extraHeaders"    # Lcom/google/common/collect/Multimap;
    .param p3, "queryParams"    # Lcom/google/common/collect/Multimap;
    .param p4, "location"    # Ljava/lang/String;

    .line 2305
    :try_start_0
    sget-object v1, Lio/minio/http/Method;->GET:Lio/minio/http/Method;

    .line 2310
    invoke-virtual {p0, p2}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v5

    .line 2305
    const/4 v3, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v4, p4

    move-object v6, p3

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2314
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

    .line 2320
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$listPartsAsync$32$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "extraHeaders"    # Lcom/google/common/collect/Multimap;
    .param p4, "queryParams"    # Lcom/google/common/collect/Multimap;
    .param p5, "location"    # Ljava/lang/String;

    .line 3248
    :try_start_0
    sget-object v1, Lio/minio/http/Method;->GET:Lio/minio/http/Method;

    .line 3253
    invoke-virtual {p0, p3}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v5

    .line 3248
    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p5

    move-object v6, p4

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 3257
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

    .line 3263
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$putMultipartObjectAsync$23$io-minio-S3Base(Lio/minio/PutObjectBaseArgs;Lcom/google/common/collect/Multimap;Lio/minio/PartReader;Lio/minio/PartSource;)Lio/minio/ObjectWriteResponse;
    .locals 16
    .param p1, "args"    # Lio/minio/PutObjectBaseArgs;
    .param p2, "headers"    # Lcom/google/common/collect/Multimap;
    .param p3, "partReader"    # Lio/minio/PartReader;
    .param p4, "firstPartSource"    # Lio/minio/PartSource;

    .line 2728
    const/4 v1, 0x0

    .line 2729
    .local v1, "uploadId":Ljava/lang/String;
    const/4 v2, 0x0

    .line 2731
    .local v2, "response":Lio/minio/ObjectWriteResponse;
    nop

    .line 2733
    :try_start_0
    invoke-virtual/range {p1 .. p1}, Lio/minio/PutObjectBaseArgs;->bucket()Ljava/lang/String;

    move-result-object v4

    .line 2734
    invoke-virtual/range {p1 .. p1}, Lio/minio/PutObjectBaseArgs;->region()Ljava/lang/String;

    move-result-object v5

    .line 2735
    invoke-virtual/range {p1 .. p1}, Lio/minio/PutObjectBaseArgs;->object()Ljava/lang/String;

    move-result-object v6

    .line 2737
    invoke-virtual/range {p1 .. p1}, Lio/minio/PutObjectBaseArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v8

    .line 2732
    move-object/from16 v3, p0

    move-object/from16 v7, p2

    invoke-virtual/range {v3 .. v8}, Lio/minio/S3Base;->createMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2738
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/CreateMultipartUploadResponse;

    .line 2739
    .local v0, "createMultipartUploadResponse":Lio/minio/CreateMultipartUploadResponse;
    invoke-virtual {v0}, Lio/minio/CreateMultipartUploadResponse;->result()Lio/minio/messages/InitiateMultipartUploadResult;

    move-result-object v3

    invoke-virtual {v3}, Lio/minio/messages/InitiateMultipartUploadResult;->uploadId()Ljava/lang/String;

    move-result-object v3
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_f
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_e
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_d
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_c
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_b
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_a
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_9
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_8

    move-object v1, v3

    .line 2740
    move-object/from16 v12, p0

    move-object/from16 v13, p1

    move-object/from16 v14, p3

    move-object/from16 v15, p4

    :try_start_1
    invoke-direct {v12, v13, v1, v14, v15}, Lio/minio/S3Base;->uploadParts(Lio/minio/PutObjectBaseArgs;Ljava/lang/String;Lio/minio/PartReader;Lio/minio/PartSource;)[Lio/minio/messages/Part;

    move-result-object v9

    .line 2741
    .local v9, "parts":[Lio/minio/messages/Part;
    nop

    .line 2743
    invoke-virtual/range {p1 .. p1}, Lio/minio/PutObjectBaseArgs;->bucket()Ljava/lang/String;

    move-result-object v5

    invoke-virtual/range {p1 .. p1}, Lio/minio/PutObjectBaseArgs;->region()Ljava/lang/String;

    move-result-object v6

    invoke-virtual/range {p1 .. p1}, Lio/minio/PutObjectBaseArgs;->object()Ljava/lang/String;

    move-result-object v7

    .line 2742
    const/4 v10, 0x0

    const/4 v11, 0x0

    move-object/from16 v4, p0

    move-object v8, v1

    invoke-virtual/range {v4 .. v11}, Lio/minio/S3Base;->completeMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Lio/minio/messages/Part;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v3

    .line 2744
    invoke-virtual {v3}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lio/minio/ObjectWriteResponse;
    :try_end_1
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Lio/minio/errors/InternalException; {:try_start_1 .. :try_end_1} :catch_6
    .catch Ljava/security/InvalidKeyException; {:try_start_1 .. :try_end_1} :catch_5
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_4
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_1 .. :try_end_1} :catch_0

    move-object v2, v3

    .line 2784
    .end local v0    # "createMultipartUploadResponse":Lio/minio/CreateMultipartUploadResponse;
    .end local v9    # "parts":[Lio/minio/messages/Part;
    goto/16 :goto_2

    .line 2745
    :catch_0
    move-exception v0

    goto :goto_1

    :catch_1
    move-exception v0

    goto :goto_1

    :catch_2
    move-exception v0

    goto :goto_1

    :catch_3
    move-exception v0

    goto :goto_1

    :catch_4
    move-exception v0

    goto :goto_1

    :catch_5
    move-exception v0

    goto :goto_1

    :catch_6
    move-exception v0

    goto :goto_1

    :catch_7
    move-exception v0

    goto :goto_1

    :catch_8
    move-exception v0

    goto :goto_0

    :catch_9
    move-exception v0

    goto :goto_0

    :catch_a
    move-exception v0

    goto :goto_0

    :catch_b
    move-exception v0

    goto :goto_0

    :catch_c
    move-exception v0

    goto :goto_0

    :catch_d
    move-exception v0

    goto :goto_0

    :catch_e
    move-exception v0

    goto :goto_0

    :catch_f
    move-exception v0

    :goto_0
    move-object/from16 v12, p0

    move-object/from16 v13, p1

    move-object/from16 v14, p3

    move-object/from16 v15, p4

    :goto_1
    move-object v10, v0

    .line 2753
    .local v10, "e":Ljava/lang/Exception;
    if-nez v1, :cond_2

    .line 2754
    move-object v0, v10

    .line 2755
    .local v0, "throwable":Ljava/lang/Throwable;
    instance-of v3, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v3, :cond_0

    .line 2756
    move-object v3, v0

    check-cast v3, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v3}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2758
    :cond_0
    instance-of v3, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v3, :cond_1

    .line 2759
    move-object v3, v0

    check-cast v3, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v3}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 2761
    :cond_1
    new-instance v3, Ljava/util/concurrent/CompletionException;

    invoke-direct {v3, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v3

    .line 2764
    .end local v0    # "throwable":Ljava/lang/Throwable;
    :cond_2
    nop

    .line 2765
    :try_start_2
    invoke-virtual/range {p1 .. p1}, Lio/minio/PutObjectBaseArgs;->bucket()Ljava/lang/String;

    move-result-object v4

    invoke-virtual/range {p1 .. p1}, Lio/minio/PutObjectBaseArgs;->region()Ljava/lang/String;

    move-result-object v5

    invoke-virtual/range {p1 .. p1}, Lio/minio/PutObjectBaseArgs;->object()Ljava/lang/String;

    move-result-object v6

    .line 2764
    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object/from16 v3, p0

    move-object v7, v1

    invoke-virtual/range {v3 .. v9}, Lio/minio/S3Base;->abortMultipartUploadAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2766
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;
    :try_end_2
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_2 .. :try_end_2} :catch_17
    .catch Lio/minio/errors/InternalException; {:try_start_2 .. :try_end_2} :catch_16
    .catch Ljava/security/InvalidKeyException; {:try_start_2 .. :try_end_2} :catch_15
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_14
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_2 .. :try_end_2} :catch_13
    .catch Lio/minio/errors/XmlParserException; {:try_start_2 .. :try_end_2} :catch_12
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_11
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_2 .. :try_end_2} :catch_10

    .line 2783
    nop

    .line 2785
    .end local v10    # "e":Ljava/lang/Exception;
    :goto_2
    return-object v2

    .line 2767
    .restart local v10    # "e":Ljava/lang/Exception;
    :catch_10
    move-exception v0

    goto :goto_3

    :catch_11
    move-exception v0

    goto :goto_3

    :catch_12
    move-exception v0

    goto :goto_3

    :catch_13
    move-exception v0

    goto :goto_3

    :catch_14
    move-exception v0

    goto :goto_3

    :catch_15
    move-exception v0

    goto :goto_3

    :catch_16
    move-exception v0

    goto :goto_3

    :catch_17
    move-exception v0

    .line 2775
    .local v0, "ex":Ljava/lang/Exception;
    :goto_3
    move-object v3, v0

    .line 2776
    .local v3, "throwable":Ljava/lang/Throwable;
    instance-of v4, v3, Ljava/util/concurrent/ExecutionException;

    if-eqz v4, :cond_3

    .line 2777
    move-object v4, v3

    check-cast v4, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v4}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v3

    .line 2779
    :cond_3
    instance-of v4, v3, Ljava/util/concurrent/CompletionException;

    if-eqz v4, :cond_4

    .line 2780
    move-object v4, v3

    check-cast v4, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v4}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v3

    .line 2782
    :cond_4
    new-instance v4, Ljava/util/concurrent/CompletionException;

    invoke-direct {v4, v3}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v4
.end method

.method synthetic lambda$putObjectAsync$25$io-minio-S3Base(Lio/minio/PartReader;Lio/minio/PutObjectBaseArgs;Lcom/google/common/collect/Multimap;Lio/minio/PartSource;)Ljava/util/concurrent/CompletionStage;
    .locals 9
    .param p1, "partReader"    # Lio/minio/PartReader;
    .param p2, "args"    # Lio/minio/PutObjectBaseArgs;
    .param p3, "headers"    # Lcom/google/common/collect/Multimap;
    .param p4, "partSource"    # Lio/minio/PartSource;

    .line 2836
    :try_start_0
    invoke-virtual {p1}, Lio/minio/PartReader;->partCount()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 2837
    nop

    .line 2838
    invoke-virtual {p2}, Lio/minio/PutObjectBaseArgs;->bucket()Ljava/lang/String;

    move-result-object v3

    .line 2839
    invoke-virtual {p2}, Lio/minio/PutObjectBaseArgs;->region()Ljava/lang/String;

    move-result-object v4

    .line 2840
    invoke-virtual {p2}, Lio/minio/PutObjectBaseArgs;->object()Ljava/lang/String;

    move-result-object v5

    .line 2843
    invoke-virtual {p2}, Lio/minio/PutObjectBaseArgs;->extraQueryParams()Lcom/google/common/collect/Multimap;

    move-result-object v8

    .line 2837
    move-object v2, p0

    move-object v6, p4

    move-object v7, p3

    invoke-direct/range {v2 .. v8}, Lio/minio/S3Base;->putObjectAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/PartSource;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0

    .line 2845
    :cond_0
    invoke-direct {p0, p2, p3, p1, p4}, Lio/minio/S3Base;->putMultipartObjectAsync(Lio/minio/PutObjectBaseArgs;Lcom/google/common/collect/Multimap;Lio/minio/PartReader;Lio/minio/PartSource;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2847
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

    .line 2853
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$putObjectAsync$26$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Lio/minio/PartSource;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 9
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "headers"    # Lcom/google/common/collect/Multimap;
    .param p4, "extraQueryParams"    # Lcom/google/common/collect/Multimap;
    .param p5, "partSource"    # Lio/minio/PartSource;
    .param p6, "location"    # Ljava/lang/String;

    .line 2889
    :try_start_0
    sget-object v1, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;

    .line 2894
    invoke-virtual {p0, p3}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v5

    .line 2889
    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p6

    move-object v6, p4

    move-object v7, p5

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 2898
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

    .line 2904
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$putObjectAsync$28$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;JLjava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 14
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "headers"    # Lcom/google/common/collect/Multimap;
    .param p4, "extraQueryParams"    # Lcom/google/common/collect/Multimap;
    .param p5, "data"    # Ljava/lang/Object;
    .param p6, "length"    # J
    .param p8, "location"    # Ljava/lang/String;

    .line 2970
    :try_start_0
    sget-object v2, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_11
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_10
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_f
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_e
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_d
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_c

    .line 2975
    move-object v10, p0

    move-object/from16 v11, p3

    :try_start_1
    invoke-virtual {p0, v11}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v6
    :try_end_1
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_1 .. :try_end_1} :catch_b
    .catch Lio/minio/errors/InternalException; {:try_start_1 .. :try_end_1} :catch_a
    .catch Ljava/security/InvalidKeyException; {:try_start_1 .. :try_end_1} :catch_9
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_6

    move-wide/from16 v12, p6

    long-to-int v9, v12

    .line 2970
    move-object v1, p0

    move-object v3, p1

    move-object/from16 v4, p2

    move-object/from16 v5, p8

    move-object/from16 v7, p4

    move-object/from16 v8, p5

    :try_start_2
    invoke-virtual/range {v1 .. v9}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_2
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_2 .. :try_end_2} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_2 .. :try_end_2} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_2 .. :try_end_2} :catch_0

    return-object v0

    .line 2979
    :catch_0
    move-exception v0

    goto :goto_2

    :catch_1
    move-exception v0

    goto :goto_2

    :catch_2
    move-exception v0

    goto :goto_2

    :catch_3
    move-exception v0

    goto :goto_2

    :catch_4
    move-exception v0

    goto :goto_2

    :catch_5
    move-exception v0

    goto :goto_2

    :catch_6
    move-exception v0

    goto :goto_1

    :catch_7
    move-exception v0

    goto :goto_1

    :catch_8
    move-exception v0

    goto :goto_1

    :catch_9
    move-exception v0

    goto :goto_1

    :catch_a
    move-exception v0

    goto :goto_1

    :catch_b
    move-exception v0

    goto :goto_1

    :catch_c
    move-exception v0

    goto :goto_0

    :catch_d
    move-exception v0

    goto :goto_0

    :catch_e
    move-exception v0

    goto :goto_0

    :catch_f
    move-exception v0

    goto :goto_0

    :catch_10
    move-exception v0

    goto :goto_0

    :catch_11
    move-exception v0

    :goto_0
    move-object v10, p0

    move-object/from16 v11, p3

    :goto_1
    move-wide/from16 v12, p6

    .line 2985
    .local v0, "e":Ljava/lang/Exception;
    :goto_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$uploadPartAsync$34$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;ILjava/lang/String;Lio/minio/PartSource;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 13
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "extraHeaders"    # Lcom/google/common/collect/Multimap;
    .param p4, "extraQueryParams"    # Lcom/google/common/collect/Multimap;
    .param p5, "partNumber"    # I
    .param p6, "uploadId"    # Ljava/lang/String;
    .param p7, "partSource"    # Lio/minio/PartSource;
    .param p8, "location"    # Ljava/lang/String;

    .line 3372
    move-object v10, p0

    :try_start_0
    sget-object v2, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_11
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_10
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_f
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_e
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_d
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_c

    .line 3377
    move-object/from16 v11, p3

    :try_start_1
    invoke-virtual {p0, v11}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v6

    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "partNumber"

    const/4 v3, 0x0

    aput-object v1, v0, v3

    .line 3381
    invoke-static/range {p5 .. p5}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const-string/jumbo v1, "uploadId"

    const/4 v3, 0x2

    aput-object v1, v0, v3

    const/4 v1, 0x3

    aput-object p6, v0, v1

    .line 3380
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0
    :try_end_1
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_1 .. :try_end_1} :catch_b
    .catch Lio/minio/errors/InternalException; {:try_start_1 .. :try_end_1} :catch_a
    .catch Ljava/security/InvalidKeyException; {:try_start_1 .. :try_end_1} :catch_9
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_6

    .line 3378
    move-object/from16 v12, p4

    :try_start_2
    invoke-virtual {p0, v12, v0}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v7

    .line 3372
    const/4 v9, 0x0

    move-object v1, p0

    move-object v3, p1

    move-object v4, p2

    move-object/from16 v5, p8

    move-object/from16 v8, p7

    invoke-virtual/range {v1 .. v9}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_2
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_2 .. :try_end_2} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_2 .. :try_end_2} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_2 .. :try_end_2} :catch_0

    return-object v0

    .line 3384
    :catch_0
    move-exception v0

    goto :goto_2

    :catch_1
    move-exception v0

    goto :goto_2

    :catch_2
    move-exception v0

    goto :goto_2

    :catch_3
    move-exception v0

    goto :goto_2

    :catch_4
    move-exception v0

    goto :goto_2

    :catch_5
    move-exception v0

    goto :goto_2

    :catch_6
    move-exception v0

    goto :goto_1

    :catch_7
    move-exception v0

    goto :goto_1

    :catch_8
    move-exception v0

    goto :goto_1

    :catch_9
    move-exception v0

    goto :goto_1

    :catch_a
    move-exception v0

    goto :goto_1

    :catch_b
    move-exception v0

    goto :goto_1

    :catch_c
    move-exception v0

    goto :goto_0

    :catch_d
    move-exception v0

    goto :goto_0

    :catch_e
    move-exception v0

    goto :goto_0

    :catch_f
    move-exception v0

    goto :goto_0

    :catch_10
    move-exception v0

    goto :goto_0

    :catch_11
    move-exception v0

    :goto_0
    move-object/from16 v11, p3

    :goto_1
    move-object/from16 v12, p4

    .line 3390
    .local v0, "e":Ljava/lang/Exception;
    :goto_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$uploadPartAsync$36$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;ILjava/lang/String;Ljava/lang/Object;JLjava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 15
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "extraHeaders"    # Lcom/google/common/collect/Multimap;
    .param p4, "extraQueryParams"    # Lcom/google/common/collect/Multimap;
    .param p5, "partNumber"    # I
    .param p6, "uploadId"    # Ljava/lang/String;
    .param p7, "data"    # Ljava/lang/Object;
    .param p8, "length"    # J
    .param p10, "location"    # Ljava/lang/String;

    .line 3469
    move-object v10, p0

    :try_start_0
    sget-object v2, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_17
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_16
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_15
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_14
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_13
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_12

    .line 3474
    move-object/from16 v11, p3

    :try_start_1
    invoke-virtual {p0, v11}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v6

    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "partNumber"

    const/4 v3, 0x0

    aput-object v1, v0, v3

    .line 3478
    invoke-static/range {p5 .. p5}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const-string/jumbo v1, "uploadId"

    const/4 v3, 0x2

    aput-object v1, v0, v3

    const/4 v1, 0x3

    aput-object p6, v0, v1

    .line 3477
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0
    :try_end_1
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_1 .. :try_end_1} :catch_11
    .catch Lio/minio/errors/InternalException; {:try_start_1 .. :try_end_1} :catch_10
    .catch Ljava/security/InvalidKeyException; {:try_start_1 .. :try_end_1} :catch_f
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_e
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_1 .. :try_end_1} :catch_d
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_c

    .line 3475
    move-object/from16 v12, p4

    :try_start_2
    invoke-virtual {p0, v12, v0}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v7
    :try_end_2
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_2 .. :try_end_2} :catch_b
    .catch Lio/minio/errors/InternalException; {:try_start_2 .. :try_end_2} :catch_a
    .catch Ljava/security/InvalidKeyException; {:try_start_2 .. :try_end_2} :catch_9
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_8
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_2 .. :try_end_2} :catch_7
    .catch Lio/minio/errors/XmlParserException; {:try_start_2 .. :try_end_2} :catch_6

    move-wide/from16 v13, p8

    long-to-int v9, v13

    .line 3469
    move-object v1, p0

    move-object/from16 v3, p1

    move-object/from16 v4, p2

    move-object/from16 v5, p10

    move-object/from16 v8, p7

    :try_start_3
    invoke-virtual/range {v1 .. v9}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_3
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_3 .. :try_end_3} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_3 .. :try_end_3} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_3 .. :try_end_3} :catch_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_3 .. :try_end_3} :catch_0

    return-object v0

    .line 3481
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

    goto :goto_3

    :catch_6
    move-exception v0

    goto :goto_2

    :catch_7
    move-exception v0

    goto :goto_2

    :catch_8
    move-exception v0

    goto :goto_2

    :catch_9
    move-exception v0

    goto :goto_2

    :catch_a
    move-exception v0

    goto :goto_2

    :catch_b
    move-exception v0

    goto :goto_2

    :catch_c
    move-exception v0

    goto :goto_1

    :catch_d
    move-exception v0

    goto :goto_1

    :catch_e
    move-exception v0

    goto :goto_1

    :catch_f
    move-exception v0

    goto :goto_1

    :catch_10
    move-exception v0

    goto :goto_1

    :catch_11
    move-exception v0

    goto :goto_1

    :catch_12
    move-exception v0

    goto :goto_0

    :catch_13
    move-exception v0

    goto :goto_0

    :catch_14
    move-exception v0

    goto :goto_0

    :catch_15
    move-exception v0

    goto :goto_0

    :catch_16
    move-exception v0

    goto :goto_0

    :catch_17
    move-exception v0

    :goto_0
    move-object/from16 v11, p3

    :goto_1
    move-object/from16 v12, p4

    :goto_2
    move-wide/from16 v13, p8

    .line 3487
    .local v0, "e":Ljava/lang/Exception;
    :goto_3
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic lambda$uploadPartCopyAsync$38$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;ILjava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;
    .locals 13
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectName"    # Ljava/lang/String;
    .param p3, "headers"    # Lcom/google/common/collect/Multimap;
    .param p4, "extraQueryParams"    # Lcom/google/common/collect/Multimap;
    .param p5, "partNumber"    # I
    .param p6, "uploadId"    # Ljava/lang/String;
    .param p7, "location"    # Ljava/lang/String;

    .line 3648
    move-object v10, p0

    :try_start_0
    sget-object v2, Lio/minio/http/Method;->PUT:Lio/minio/http/Method;
    :try_end_0
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_0 .. :try_end_0} :catch_11
    .catch Lio/minio/errors/InternalException; {:try_start_0 .. :try_end_0} :catch_10
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_f
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_e
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_d
    .catch Lio/minio/errors/XmlParserException; {:try_start_0 .. :try_end_0} :catch_c

    .line 3653
    move-object/from16 v11, p3

    :try_start_1
    invoke-virtual {p0, v11}, Lio/minio/S3Base;->httpHeaders(Lcom/google/common/collect/Multimap;)Lokhttp3/Headers;

    move-result-object v6

    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "partNumber"

    const/4 v3, 0x0

    aput-object v1, v0, v3

    .line 3657
    invoke-static/range {p5 .. p5}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const-string/jumbo v1, "uploadId"

    const/4 v3, 0x2

    aput-object v1, v0, v3

    const/4 v1, 0x3

    aput-object p6, v0, v1

    .line 3656
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0
    :try_end_1
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_1 .. :try_end_1} :catch_b
    .catch Lio/minio/errors/InternalException; {:try_start_1 .. :try_end_1} :catch_a
    .catch Ljava/security/InvalidKeyException; {:try_start_1 .. :try_end_1} :catch_9
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_8
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_6

    .line 3654
    move-object/from16 v12, p4

    :try_start_2
    invoke-virtual {p0, v12, v0}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v7

    .line 3648
    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v1, p0

    move-object v3, p1

    move-object v4, p2

    move-object/from16 v5, p7

    invoke-virtual/range {v1 .. v9}, Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0
    :try_end_2
    .catch Lio/minio/errors/InsufficientDataException; {:try_start_2 .. :try_end_2} :catch_5
    .catch Lio/minio/errors/InternalException; {:try_start_2 .. :try_end_2} :catch_4
    .catch Ljava/security/InvalidKeyException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_2 .. :try_end_2} :catch_0

    return-object v0

    .line 3660
    :catch_0
    move-exception v0

    goto :goto_2

    :catch_1
    move-exception v0

    goto :goto_2

    :catch_2
    move-exception v0

    goto :goto_2

    :catch_3
    move-exception v0

    goto :goto_2

    :catch_4
    move-exception v0

    goto :goto_2

    :catch_5
    move-exception v0

    goto :goto_2

    :catch_6
    move-exception v0

    goto :goto_1

    :catch_7
    move-exception v0

    goto :goto_1

    :catch_8
    move-exception v0

    goto :goto_1

    :catch_9
    move-exception v0

    goto :goto_1

    :catch_a
    move-exception v0

    goto :goto_1

    :catch_b
    move-exception v0

    goto :goto_1

    :catch_c
    move-exception v0

    goto :goto_0

    :catch_d
    move-exception v0

    goto :goto_0

    :catch_e
    move-exception v0

    goto :goto_0

    :catch_f
    move-exception v0

    goto :goto_0

    :catch_10
    move-exception v0

    goto :goto_0

    :catch_11
    move-exception v0

    :goto_0
    move-object/from16 v11, p3

    :goto_1
    move-object/from16 v12, p4

    .line 3666
    .local v0, "e":Ljava/lang/Exception;
    :goto_2
    new-instance v1, Ljava/util/concurrent/CompletionException;

    invoke-direct {v1, v0}, Ljava/util/concurrent/CompletionException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected listMultipartUploads(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/ListMultipartUploadsResponse;
    .locals 2
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "delimiter"    # Ljava/lang/String;
    .param p4, "encodingType"    # Ljava/lang/String;
    .param p5, "keyMarker"    # Ljava/lang/String;
    .param p6, "maxUploads"    # Ljava/lang/Integer;
    .param p7, "prefix"    # Ljava/lang/String;
    .param p8, "uploadIdMarker"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
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
            "Lio/minio/ListMultipartUploadsResponse;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Ljava/io/IOException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3181
    .local p9, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p10, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p10}, Lio/minio/S3Base;->listMultipartUploadsAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 3192
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ListMultipartUploadsResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 3181
    return-object v0

    .line 3195
    :catch_0
    move-exception v0

    .line 3196
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 3197
    const/4 v1, 0x0

    return-object v1

    .line 3193
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 3194
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected listMultipartUploadsAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 4
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "delimiter"    # Ljava/lang/String;
    .param p4, "encodingType"    # Ljava/lang/String;
    .param p5, "keyMarker"    # Ljava/lang/String;
    .param p6, "maxUploads"    # Ljava/lang/Integer;
    .param p7, "prefix"    # Ljava/lang/String;
    .param p8, "uploadIdMarker"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
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
            "Lio/minio/ListMultipartUploadsResponse;",
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

    .line 3085
    .local p9, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p10, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    const/16 v0, 0x8

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "uploads"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, ""

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v3, "delimiter"

    aput-object v3, v0, v1

    .line 3092
    if-eqz p3, :cond_0

    move-object v1, p3

    goto :goto_0

    :cond_0
    move-object v1, v2

    :goto_0
    const/4 v3, 0x3

    aput-object v1, v0, v3

    const/4 v1, 0x4

    const-string v3, "max-uploads"

    aput-object v3, v0, v1

    .line 3094
    if-eqz p6, :cond_1

    invoke-virtual {p6}, Ljava/lang/Integer;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_1
    const-string v1, "1000"

    :goto_1
    const/4 v3, 0x5

    aput-object v1, v0, v3

    const/4 v1, 0x6

    const-string v3, "prefix"

    aput-object v3, v0, v1

    .line 3096
    if-eqz p7, :cond_2

    move-object v2, p7

    :cond_2
    const/4 v1, 0x7

    aput-object v2, v0, v1

    .line 3088
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 3086
    invoke-virtual {p0, p10, v0}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 3097
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz p4, :cond_3

    const-string v1, "encoding-type"

    invoke-interface {v0, v1, p4}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 3098
    :cond_3
    if-eqz p5, :cond_4

    const-string v1, "key-marker"

    invoke-interface {v0, v1, p5}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 3099
    :cond_4
    if-eqz p8, :cond_5

    const-string/jumbo v1, "upload-id-marker"

    invoke-interface {v0, v1, p8}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 3101
    :cond_5
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/S3Base$$ExternalSyntheticLambda20;

    invoke-direct {v2, p0, p1, p9, v0}, Lio/minio/S3Base$$ExternalSyntheticLambda20;-><init>(Lio/minio/S3Base;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)V

    .line 3102
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/S3Base$$ExternalSyntheticLambda21;

    invoke-direct {v2, p1, p2}, Lio/minio/S3Base$$ExternalSyntheticLambda21;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 3123
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 3101
    return-object v1
.end method

.method protected listObjectVersions(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/ListObjectVersionsResponse;
    .locals 2
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "delimiter"    # Ljava/lang/String;
    .param p4, "encodingType"    # Ljava/lang/String;
    .param p5, "keyMarker"    # Ljava/lang/String;
    .param p6, "maxKeys"    # Ljava/lang/Integer;
    .param p7, "prefix"    # Ljava/lang/String;
    .param p8, "versionIdMarker"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
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
            "Lio/minio/ListObjectVersionsResponse;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Ljava/io/IOException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 2663
    .local p9, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p10, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p10}, Lio/minio/S3Base;->listObjectVersionsAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2674
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ListObjectVersionsResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2663
    return-object v0

    .line 2677
    :catch_0
    move-exception v0

    .line 2678
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2679
    const/4 v1, 0x0

    return-object v1

    .line 2675
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 2676
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected listObjectVersions(Lio/minio/ListObjectsArgs;)Ljava/lang/Iterable;
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

    .line 1446
    new-instance v0, Lio/minio/S3Base$4;

    invoke-direct {v0, p0, p1}, Lio/minio/S3Base$4;-><init>(Lio/minio/S3Base;Lio/minio/ListObjectsArgs;)V

    return-object v0
.end method

.method protected listObjectVersionsAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "delimiter"    # Ljava/lang/String;
    .param p4, "encodingType"    # Ljava/lang/String;
    .param p5, "keyMarker"    # Ljava/lang/String;
    .param p6, "maxKeys"    # Ljava/lang/Integer;
    .param p7, "prefix"    # Ljava/lang/String;
    .param p8, "versionIdMarker"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
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
            "Lio/minio/ListObjectVersionsResponse;",
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

    .line 2575
    .local p9, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p10, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    nop

    .line 2578
    invoke-direct {p0, p3, p4, p6, p7}, Lio/minio/S3Base;->getCommonListObjectsQueryParams(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 2576
    invoke-virtual {p0, p10, v0}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 2579
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz p5, :cond_0

    const-string v1, "key-marker"

    invoke-interface {v0, v1, p5}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2580
    :cond_0
    if-eqz p8, :cond_1

    const-string/jumbo v1, "version-id-marker"

    invoke-interface {v0, v1, p8}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2581
    :cond_1
    const-string/jumbo v1, "versions"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2583
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/S3Base$$ExternalSyntheticLambda3;

    invoke-direct {v2, p0, p1, p9, v0}, Lio/minio/S3Base$$ExternalSyntheticLambda3;-><init>(Lio/minio/S3Base;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)V

    .line 2584
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/S3Base$$ExternalSyntheticLambda4;

    invoke-direct {v2, p1, p2}, Lio/minio/S3Base$$ExternalSyntheticLambda4;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 2605
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 2583
    return-object v1
.end method

.method protected listObjectsV1(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/ListObjectsV1Response;
    .locals 2
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "delimiter"    # Ljava/lang/String;
    .param p4, "encodingType"    # Ljava/lang/String;
    .param p5, "marker"    # Ljava/lang/String;
    .param p6, "maxKeys"    # Ljava/lang/Integer;
    .param p7, "prefix"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
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
            "Lio/minio/ListObjectsV1Response;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Ljava/io/IOException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 2520
    .local p8, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p9, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p9}, Lio/minio/S3Base;->listObjectsV1Async(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2530
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ListObjectsV1Response;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2520
    return-object v0

    .line 2533
    :catch_0
    move-exception v0

    .line 2534
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2535
    const/4 v1, 0x0

    return-object v1

    .line 2531
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 2532
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected listObjectsV1(Lio/minio/ListObjectsArgs;)Ljava/lang/Iterable;
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

    .line 1407
    new-instance v0, Lio/minio/S3Base$3;

    invoke-direct {v0, p0, p1}, Lio/minio/S3Base$3;-><init>(Lio/minio/S3Base;Lio/minio/ListObjectsArgs;)V

    return-object v0
.end method

.method protected listObjectsV1Async(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "delimiter"    # Ljava/lang/String;
    .param p4, "encodingType"    # Ljava/lang/String;
    .param p5, "marker"    # Ljava/lang/String;
    .param p6, "maxKeys"    # Ljava/lang/Integer;
    .param p7, "prefix"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
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
            "Lio/minio/ListObjectsV1Response;",
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

    .line 2438
    .local p8, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p9, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    nop

    .line 2441
    invoke-direct {p0, p3, p4, p6, p7}, Lio/minio/S3Base;->getCommonListObjectsQueryParams(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 2439
    invoke-virtual {p0, p9, v0}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 2442
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz p5, :cond_0

    const-string v1, "marker"

    invoke-interface {v0, v1, p5}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2444
    :cond_0
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/S3Base$$ExternalSyntheticLambda35;

    invoke-direct {v2, p0, p1, p8, v0}, Lio/minio/S3Base$$ExternalSyntheticLambda35;-><init>(Lio/minio/S3Base;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)V

    .line 2445
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/S3Base$$ExternalSyntheticLambda36;

    invoke-direct {v2, p1, p2}, Lio/minio/S3Base$$ExternalSyntheticLambda36;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 2466
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 2444
    return-object v1
.end method

.method protected listObjectsV2(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;ZZLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/ListObjectsV2Response;
    .locals 2
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "delimiter"    # Ljava/lang/String;
    .param p4, "encodingType"    # Ljava/lang/String;
    .param p5, "startAfter"    # Ljava/lang/String;
    .param p6, "maxKeys"    # Ljava/lang/Integer;
    .param p7, "prefix"    # Ljava/lang/String;
    .param p8, "continuationToken"    # Ljava/lang/String;
    .param p9, "fetchOwner"    # Z
    .param p10, "includeUserMetadata"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "ZZ",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lio/minio/ListObjectsV2Response;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/InvalidKeyException;,
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;,
            Ljava/io/IOException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 2383
    .local p11, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p12, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p12}, Lio/minio/S3Base;->listObjectsV2Async(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;ZZLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2396
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ListObjectsV2Response;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 2383
    return-object v0

    .line 2399
    :catch_0
    move-exception v0

    .line 2400
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 2401
    const/4 v1, 0x0

    return-object v1

    .line 2397
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 2398
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected listObjectsV2(Lio/minio/ListObjectsArgs;)Ljava/lang/Iterable;
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

    .line 1368
    new-instance v0, Lio/minio/S3Base$2;

    invoke-direct {v0, p0, p1}, Lio/minio/S3Base$2;-><init>(Lio/minio/S3Base;Lio/minio/ListObjectsArgs;)V

    return-object v0
.end method

.method protected listObjectsV2Async(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;ZZLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 3
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "delimiter"    # Ljava/lang/String;
    .param p4, "encodingType"    # Ljava/lang/String;
    .param p5, "startAfter"    # Ljava/lang/String;
    .param p6, "maxKeys"    # Ljava/lang/Integer;
    .param p7, "prefix"    # Ljava/lang/String;
    .param p8, "continuationToken"    # Ljava/lang/String;
    .param p9, "fetchOwner"    # Z
    .param p10, "includeUserMetadata"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "ZZ",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/ListObjectsV2Response;",
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

    .line 2291
    .local p11, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p12, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    nop

    .line 2294
    invoke-direct {p0, p3, p4, p6, p7}, Lio/minio/S3Base;->getCommonListObjectsQueryParams(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 2292
    invoke-virtual {p0, p12, v0}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 2295
    .local v0, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v1, "list-type"

    const-string v2, "2"

    invoke-interface {v0, v1, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2296
    if-eqz p8, :cond_0

    const-string v1, "continuation-token"

    invoke-interface {v0, v1, p8}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2297
    :cond_0
    const-string/jumbo v1, "true"

    if-eqz p9, :cond_1

    const-string v2, "fetch-owner"

    invoke-interface {v0, v2, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2298
    :cond_1
    if-eqz p5, :cond_2

    const-string/jumbo v2, "start-after"

    invoke-interface {v0, v2, p5}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2299
    :cond_2
    if-eqz p10, :cond_3

    const-string v2, "metadata"

    invoke-interface {v0, v2, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2301
    :cond_3
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/S3Base$$ExternalSyntheticLambda1;

    invoke-direct {v2, p0, p1, p11, v0}, Lio/minio/S3Base$$ExternalSyntheticLambda1;-><init>(Lio/minio/S3Base;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)V

    .line 2302
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    new-instance v2, Lio/minio/S3Base$$ExternalSyntheticLambda2;

    invoke-direct {v2, p1, p2}, Lio/minio/S3Base$$ExternalSyntheticLambda2;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 2323
    invoke-virtual {v1, v2}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v1

    .line 2301
    return-object v1
.end method

.method protected listParts(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/ListPartsResponse;
    .locals 2
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
            "Lio/minio/ListPartsResponse;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Ljava/io/IOException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3319
    .local p7, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p8, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p8}, Lio/minio/S3Base;->listPartsAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 3328
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ListPartsResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 3319
    return-object v0

    .line 3331
    :catch_0
    move-exception v0

    .line 3332
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 3333
    const/4 v1, 0x0

    return-object v1

    .line 3329
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 3330
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected listPartsAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 11
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

    .line 3232
    .local p7, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p8, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    move-object v6, p0

    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string/jumbo v2, "uploadId"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    aput-object p6, v0, v1

    const/4 v1, 0x2

    const-string v2, "max-parts"

    aput-object v2, v0, v1

    .line 3239
    if-eqz p4, :cond_0

    invoke-virtual {p4}, Ljava/lang/Integer;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    const-string v1, "1000"

    :goto_0
    const/4 v2, 0x3

    aput-object v1, v0, v2

    .line 3235
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 3233
    move-object/from16 v7, p8

    invoke-virtual {p0, v7, v0}, Lio/minio/S3Base;->merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v8

    .line 3240
    .local v8, "queryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz p5, :cond_1

    .line 3241
    const-string v0, "part-number-marker"

    invoke-virtual/range {p5 .. p5}, Ljava/lang/Integer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v8, v0, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 3244
    :cond_1
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v9

    new-instance v10, Lio/minio/S3Base$$ExternalSyntheticLambda14;

    move-object v0, v10

    move-object v1, p0

    move-object v2, p1

    move-object v3, p3

    move-object/from16 v4, p7

    move-object v5, v8

    invoke-direct/range {v0 .. v5}, Lio/minio/S3Base$$ExternalSyntheticLambda14;-><init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)V

    .line 3245
    invoke-virtual {v9, v10}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda15;

    move-object v3, p2

    move-object v4, p3

    invoke-direct {v1, p1, p2, p3}, Lio/minio/S3Base$$ExternalSyntheticLambda15;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 3266
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 3244
    return-object v0
.end method

.method protected merge(Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 187
    .local p1, "m1":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p2, "m2":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    .line 188
    .local v0, "map":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz p1, :cond_0

    invoke-interface {v0, p1}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 189
    :cond_0
    if-eqz p2, :cond_1

    invoke-interface {v0, p2}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 190
    :cond_1
    return-object v0
.end method

.method protected newMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 214
    .local p1, "map":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz p1, :cond_0

    invoke-static {p1}, Lcom/google/common/collect/HashMultimap;->create(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method protected newMultimap(Ljava/util/Map;)Lcom/google/common/collect/Multimap;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 209
    .local p1, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz p1, :cond_0

    invoke-static {p1}, Lcom/google/common/collect/Multimaps;->forMap(Ljava/util/Map;)Lcom/google/common/collect/SetMultimap;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method protected varargs newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;
    .locals 4
    .param p1, "keysAndValues"    # [Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/String;",
            ")",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 195
    array-length v0, p1

    rem-int/lit8 v0, v0, 0x2

    if-nez v0, :cond_1

    .line 199
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    .line 200
    .local v0, "map":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_0

    .line 201
    aget-object v2, p1, v1

    add-int/lit8 v3, v1, 0x1

    aget-object v3, p1, v3

    invoke-interface {v0, v2, v3}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 200
    add-int/lit8 v1, v1, 0x2

    goto :goto_0

    .line 204
    .end local v1    # "i":I
    :cond_0
    return-object v0

    .line 196
    .end local v0    # "map":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Expected alternating keys and values"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected newPartReader(Ljava/lang/Object;JJI)Lio/minio/PartReader;
    .locals 8
    .param p1, "data"    # Ljava/lang/Object;
    .param p2, "objectSize"    # J
    .param p4, "partSize"    # J
    .param p6, "partCount"    # I

    .line 1482
    instance-of v0, p1, Ljava/io/RandomAccessFile;

    if-eqz v0, :cond_0

    .line 1483
    new-instance v0, Lio/minio/PartReader;

    move-object v2, p1

    check-cast v2, Ljava/io/RandomAccessFile;

    move-object v1, v0

    move-wide v3, p2

    move-wide v5, p4

    move v7, p6

    invoke-direct/range {v1 .. v7}, Lio/minio/PartReader;-><init>(Ljava/io/RandomAccessFile;JJI)V

    return-object v0

    .line 1486
    :cond_0
    instance-of v0, p1, Ljava/io/InputStream;

    if-eqz v0, :cond_1

    .line 1487
    new-instance v0, Lio/minio/PartReader;

    move-object v2, p1

    check-cast v2, Ljava/io/InputStream;

    move-object v1, v0

    move-wide v3, p2

    move-wide v5, p4

    move v7, p6

    invoke-direct/range {v1 .. v7}, Lio/minio/PartReader;-><init>(Ljava/io/InputStream;JJI)V

    return-object v0

    .line 1490
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method protected putObject(Lio/minio/PutObjectBaseArgs;Ljava/lang/Object;JJILjava/lang/String;)Lio/minio/ObjectWriteResponse;
    .locals 2
    .param p1, "args"    # Lio/minio/PutObjectBaseArgs;
    .param p2, "data"    # Ljava/lang/Object;
    .param p3, "objectSize"    # J
    .param p5, "partSize"    # J
    .param p7, "partCount"    # I
    .param p8, "contentType"    # Ljava/lang/String;
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

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1510
    :try_start_0
    invoke-virtual/range {p0 .. p8}, Lio/minio/S3Base;->putObjectAsync(Lio/minio/PutObjectBaseArgs;Ljava/lang/Object;JJILjava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ObjectWriteResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1513
    :catch_0
    move-exception v0

    .line 1514
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 1515
    const/4 v1, 0x0

    return-object v1

    .line 1511
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 1512
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected putObject(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;JLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/ObjectWriteResponse;
    .locals 2
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "data"    # Ljava/lang/Object;
    .param p5, "length"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            "J",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lio/minio/ObjectWriteResponse;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Ljava/io/IOException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3039
    .local p7, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p8, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p8}, Lio/minio/S3Base;->putObjectAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;JLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 3040
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/ObjectWriteResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 3039
    return-object v0

    .line 3043
    :catch_0
    move-exception v0

    .line 3044
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 3045
    const/4 v1, 0x0

    return-object v1

    .line 3041
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 3042
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected putObjectAsync(Lio/minio/PutObjectBaseArgs;Ljava/lang/Object;JJILjava/lang/String;)Ljava/util/concurrent/CompletableFuture;
    .locals 7
    .param p1, "args"    # Lio/minio/PutObjectBaseArgs;
    .param p2, "data"    # Ljava/lang/Object;
    .param p3, "objectSize"    # J
    .param p5, "partSize"    # J
    .param p7, "partCount"    # I
    .param p8, "contentType"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/PutObjectBaseArgs;",
            "Ljava/lang/Object;",
            "JJI",
            "Ljava/lang/String;",
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

    .line 2816
    move-object v0, p0

    move-object v1, p2

    move-wide v2, p3

    move-wide v4, p5

    move v6, p7

    invoke-virtual/range {v0 .. v6}, Lio/minio/S3Base;->newPartReader(Ljava/lang/Object;JJI)Lio/minio/PartReader;

    move-result-object v0

    .line 2817
    .local v0, "partReader":Lio/minio/PartReader;
    if-eqz v0, :cond_1

    .line 2821
    invoke-virtual {p1}, Lio/minio/PutObjectBaseArgs;->extraHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v1

    invoke-virtual {p0, v1}, Lio/minio/S3Base;->newMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v1

    .line 2822
    .local v1, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p1}, Lio/minio/PutObjectBaseArgs;->genHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v2

    invoke-interface {v1, v2}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 2823
    const-string v2, "Content-Type"

    invoke-interface {v1, v2}, Lcom/google/common/collect/Multimap;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-interface {v1, v2, p8}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2825
    :cond_0
    new-instance v2, Lio/minio/S3Base$$ExternalSyntheticLambda11;

    invoke-direct {v2, v0}, Lio/minio/S3Base$$ExternalSyntheticLambda11;-><init>(Lio/minio/PartReader;)V

    invoke-static {v2}, Ljava/util/concurrent/CompletableFuture;->supplyAsync(Ljava/util/function/Supplier;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v2

    new-instance v3, Lio/minio/S3Base$$ExternalSyntheticLambda22;

    invoke-direct {v3, p0, v0, p1, v1}, Lio/minio/S3Base$$ExternalSyntheticLambda22;-><init>(Lio/minio/S3Base;Lio/minio/PartReader;Lio/minio/PutObjectBaseArgs;Lcom/google/common/collect/Multimap;)V

    .line 2833
    invoke-virtual {v2, v3}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v2

    .line 2825
    return-object v2

    .line 2818
    .end local v1    # "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_1
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "data must be RandomAccessFile or InputStream"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method protected putObjectAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;JLcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 13
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "data"    # Ljava/lang/Object;
    .param p5, "length"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            "J",
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

    .line 2951
    .local p7, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p8, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    move-object/from16 v9, p4

    instance-of v0, v9, Ljava/io/InputStream;

    if-nez v0, :cond_1

    instance-of v0, v9, Ljava/io/RandomAccessFile;

    if-nez v0, :cond_1

    instance-of v0, v9, [B

    if-nez v0, :cond_1

    instance-of v0, v9, Ljava/lang/CharSequence;

    if-eqz v0, :cond_0

    goto :goto_0

    .line 2955
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "data must be InputStream, RandomAccessFile, byte[] or String"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 2959
    :cond_1
    :goto_0
    const/4 v6, 0x1

    move-object v0, p0

    move-object/from16 v1, p4

    move-wide/from16 v2, p5

    move-wide/from16 v4, p5

    invoke-virtual/range {v0 .. v6}, Lio/minio/S3Base;->newPartReader(Ljava/lang/Object;JJI)Lio/minio/PartReader;

    move-result-object v10

    .line 2961
    .local v10, "partReader":Lio/minio/PartReader;
    if-eqz v10, :cond_2

    .line 2962
    nop

    .line 2963
    invoke-virtual {v10}, Lio/minio/PartReader;->getPart()Lio/minio/PartSource;

    move-result-object v4

    .line 2962
    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object/from16 v3, p3

    move-object/from16 v5, p7

    move-object/from16 v6, p8

    invoke-direct/range {v0 .. v6}, Lio/minio/S3Base;->putObjectAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/PartSource;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0

    .line 2966
    :cond_2
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v11

    new-instance v12, Lio/minio/S3Base$$ExternalSyntheticLambda29;

    move-object v0, v12

    move-object v1, p0

    move-object v2, p1

    move-object/from16 v3, p3

    move-object/from16 v4, p7

    move-object/from16 v5, p8

    move-object/from16 v6, p4

    move-wide/from16 v7, p5

    invoke-direct/range {v0 .. v8}, Lio/minio/S3Base$$ExternalSyntheticLambda29;-><init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;J)V

    .line 2967
    invoke-virtual {v11, v12}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda30;

    move-object v3, p2

    move-object/from16 v4, p3

    invoke-direct {v1, p1, p2, v4}, Lio/minio/S3Base$$ExternalSyntheticLambda30;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 2988
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 2966
    return-object v0
.end method

.method public setAppInfo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "version"    # Ljava/lang/String;

    .line 1659
    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    goto :goto_0

    .line 1660
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lio/minio/MinioProperties;->INSTANCE:Lio/minio/MinioProperties;

    .line 1661
    invoke-virtual {v1}, Lio/minio/MinioProperties;->getDefaultUserAgent()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base;->userAgent:Ljava/lang/String;

    .line 1662
    return-void

    .line 1659
    :cond_1
    :goto_0
    return-void
.end method

.method public setTimeout(JJJ)V
    .locals 7
    .param p1, "connectTimeout"    # J
    .param p3, "writeTimeout"    # J
    .param p5, "readTimeout"    # J

    .line 1632
    iget-object v0, p0, Lio/minio/S3Base;->httpClient:Lokhttp3/OkHttpClient;

    .line 1633
    move-wide v1, p1

    move-wide v3, p3

    move-wide v5, p5

    invoke-static/range {v0 .. v6}, Lio/minio/http/HttpUtils;->setTimeout(Lokhttp3/OkHttpClient;JJJ)Lokhttp3/OkHttpClient;

    move-result-object v0

    iput-object v0, p0, Lio/minio/S3Base;->httpClient:Lokhttp3/OkHttpClient;

    .line 1634
    return-void
.end method

.method protected statObjectAsync(Lio/minio/StatObjectArgs;)Ljava/util/concurrent/CompletableFuture;
    .locals 4
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

    .line 1720
    invoke-virtual {p0, p1}, Lio/minio/S3Base;->checkArgs(Lio/minio/BaseArgs;)V

    .line 1721
    iget-object v0, p0, Lio/minio/S3Base;->baseUrl:Lokhttp3/HttpUrl;

    invoke-virtual {p1, v0}, Lio/minio/StatObjectArgs;->validateSsec(Lokhttp3/HttpUrl;)V

    .line 1722
    nop

    .line 1724
    invoke-virtual {p1}, Lio/minio/StatObjectArgs;->getHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 1725
    invoke-virtual {p1}, Lio/minio/StatObjectArgs;->versionId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string/jumbo v3, "versionId"

    aput-object v3, v1, v2

    const/4 v2, 0x1

    invoke-virtual {p1}, Lio/minio/StatObjectArgs;->versionId()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {p0, v1}, Lio/minio/S3Base;->newMultimap([Ljava/lang/String;)Lcom/google/common/collect/Multimap;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 1722
    :goto_0
    invoke-virtual {p0, p1, v0, v1}, Lio/minio/S3Base;->executeHeadAsync(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v1, Lio/minio/S3Base$$ExternalSyntheticLambda12;

    invoke-direct {v1, p1}, Lio/minio/S3Base$$ExternalSyntheticLambda12;-><init>(Lio/minio/StatObjectArgs;)V

    .line 1726
    invoke-virtual {v0, v1}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 1722
    return-object v0
.end method

.method public throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V
    .locals 4
    .param p1, "e"    # Ljava/util/concurrent/ExecutionException;
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

    .line 222
    if-nez p1, :cond_0

    return-void

    .line 224
    :cond_0
    invoke-virtual {p1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 226
    .local v0, "ex":Ljava/lang/Throwable;
    instance-of v1, v0, Ljava/util/concurrent/CompletionException;

    if-eqz v1, :cond_1

    .line 227
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/CompletionException;

    invoke-virtual {v1}, Ljava/util/concurrent/CompletionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 230
    :cond_1
    instance-of v1, v0, Ljava/util/concurrent/ExecutionException;

    if-eqz v1, :cond_2

    .line 231
    move-object v1, v0

    check-cast v1, Ljava/util/concurrent/ExecutionException;

    invoke-virtual {v1}, Ljava/util/concurrent/ExecutionException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 235
    :cond_2
    nop

    .end local p1    # "e":Ljava/util/concurrent/ExecutionException;
    :try_start_0
    throw v0
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_9
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

    .line 247
    .restart local p1    # "e":Ljava/util/concurrent/ExecutionException;
    :catchall_0
    move-exception v1

    .line 248
    .local v1, "exc":Ljava/lang/Throwable;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-virtual {v1}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v3

    if-nez v3, :cond_3

    move-object v3, v1

    goto :goto_0

    :cond_3
    invoke-virtual {v1}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v3

    :goto_0
    invoke-direct {v2, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2

    .line 236
    .end local v1    # "exc":Ljava/lang/Throwable;
    :catch_0
    move-exception v1

    goto :goto_1

    :catch_1
    move-exception v1

    goto :goto_1

    :catch_2
    move-exception v1

    goto :goto_1

    :catch_3
    move-exception v1

    goto :goto_1

    :catch_4
    move-exception v1

    goto :goto_1

    :catch_5
    move-exception v1

    goto :goto_1

    :catch_6
    move-exception v1

    goto :goto_1

    :catch_7
    move-exception v1

    goto :goto_1

    :catch_8
    move-exception v1

    goto :goto_1

    :catch_9
    move-exception v1

    .line 246
    .local v1, "exc":Ljava/lang/Exception;
    :goto_1
    throw v1
.end method

.method public traceOff()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1683
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/S3Base;->traceStream:Ljava/io/PrintWriter;

    .line 1684
    return-void
.end method

.method public traceOn(Ljava/io/OutputStream;)V
    .locals 3
    .param p1, "traceStream"    # Ljava/io/OutputStream;

    .line 1671
    if-eqz p1, :cond_0

    .line 1672
    new-instance v0, Ljava/io/PrintWriter;

    new-instance v1, Ljava/io/OutputStreamWriter;

    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v1, p1, v2}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/nio/charset/Charset;)V

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Ljava/io/PrintWriter;-><init>(Ljava/io/Writer;Z)V

    iput-object v0, p0, Lio/minio/S3Base;->traceStream:Ljava/io/PrintWriter;

    .line 1674
    return-void

    .line 1671
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string/jumbo v1, "trace stream must be provided"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected uploadPart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;JLjava/lang/String;ILcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/UploadPartResponse;
    .locals 2
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
            "Lio/minio/UploadPartResponse;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Ljava/io/IOException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3547
    .local p9, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p10, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p10}, Lio/minio/S3Base;->uploadPartAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;JLjava/lang/String;ILcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 3557
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/UploadPartResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 3547
    return-object v0

    .line 3560
    :catch_0
    move-exception v0

    .line 3561
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 3562
    const/4 v1, 0x0

    return-object v1

    .line 3558
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 3559
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected uploadPartAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/PartSource;ILjava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 11
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "partSource"    # Lio/minio/PartSource;
    .param p5, "partNumber"    # I
    .param p6, "uploadId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lio/minio/PartSource;",
            "I",
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

    .line 3368
    .local p7, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p8, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v10, Lio/minio/S3Base$$ExternalSyntheticLambda7;

    move-object v1, v10

    move-object v2, p0

    move-object v3, p1

    move-object v4, p3

    move-object/from16 v5, p7

    move-object/from16 v6, p8

    move/from16 v7, p5

    move-object/from16 v8, p6

    move-object v9, p4

    invoke-direct/range {v1 .. v9}, Lio/minio/S3Base$$ExternalSyntheticLambda7;-><init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;ILjava/lang/String;Lio/minio/PartSource;)V

    .line 3369
    invoke-virtual {v0, v10}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v7, Lio/minio/S3Base$$ExternalSyntheticLambda8;

    move-object v1, v7

    move-object v2, p1

    move-object v3, p2

    move-object/from16 v5, p6

    move/from16 v6, p5

    invoke-direct/range {v1 .. v6}, Lio/minio/S3Base$$ExternalSyntheticLambda8;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 3393
    invoke-virtual {v0, v7}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 3368
    return-object v0
.end method

.method protected uploadPartAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;JLjava/lang/String;ILcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 15
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

    .line 3443
    .local p9, "extraHeaders":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p10, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    move-object/from16 v11, p4

    instance-of v0, v11, Ljava/io/InputStream;

    if-nez v0, :cond_1

    instance-of v0, v11, Ljava/io/RandomAccessFile;

    if-nez v0, :cond_1

    instance-of v0, v11, [B

    if-nez v0, :cond_1

    instance-of v0, v11, Ljava/lang/CharSequence;

    if-eqz v0, :cond_0

    goto :goto_0

    .line 3447
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "data must be InputStream, RandomAccessFile, byte[] or String"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 3451
    :cond_1
    :goto_0
    const/4 v6, 0x1

    move-object v0, p0

    move-object/from16 v1, p4

    move-wide/from16 v2, p5

    move-wide/from16 v4, p5

    invoke-virtual/range {v0 .. v6}, Lio/minio/S3Base;->newPartReader(Ljava/lang/Object;JJI)Lio/minio/PartReader;

    move-result-object v12

    .line 3453
    .local v12, "partReader":Lio/minio/PartReader;
    if-eqz v12, :cond_2

    .line 3454
    nop

    .line 3458
    invoke-virtual {v12}, Lio/minio/PartReader;->getPart()Lio/minio/PartSource;

    move-result-object v4

    .line 3454
    move-object v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move/from16 v5, p8

    move-object/from16 v6, p7

    move-object/from16 v7, p9

    move-object/from16 v8, p10

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->uploadPartAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lio/minio/PartSource;ILjava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    return-object v0

    .line 3465
    :cond_2
    invoke-virtual/range {p0 .. p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v13

    new-instance v14, Lio/minio/S3Base$$ExternalSyntheticLambda31;

    move-object v0, v14

    move-object v1, p0

    move-object/from16 v2, p1

    move-object/from16 v3, p3

    move-object/from16 v4, p9

    move-object/from16 v5, p10

    move/from16 v6, p8

    move-object/from16 v7, p7

    move-object/from16 v8, p4

    move-wide/from16 v9, p5

    invoke-direct/range {v0 .. v10}, Lio/minio/S3Base$$ExternalSyntheticLambda31;-><init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;ILjava/lang/String;Ljava/lang/Object;J)V

    .line 3466
    invoke-virtual {v13, v14}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v7, Lio/minio/S3Base$$ExternalSyntheticLambda32;

    move-object v1, v7

    move-object/from16 v3, p2

    move-object/from16 v4, p3

    move-object/from16 v5, p7

    invoke-direct/range {v1 .. v6}, Lio/minio/S3Base$$ExternalSyntheticLambda32;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 3490
    invoke-virtual {v0, v7}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 3465
    return-object v0
.end method

.method protected uploadPartCopy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Lio/minio/UploadPartCopyResponse;
    .locals 2
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "uploadId"    # Ljava/lang/String;
    .param p5, "partNumber"    # I
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
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lio/minio/UploadPartCopyResponse;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Lio/minio/errors/InsufficientDataException;,
            Ljava/io/IOException;,
            Ljava/security/InvalidKeyException;,
            Lio/minio/errors/ServerException;,
            Lio/minio/errors/XmlParserException;,
            Lio/minio/errors/ErrorResponseException;,
            Lio/minio/errors/InternalException;,
            Lio/minio/errors/InvalidResponseException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 3603
    .local p6, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p7, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    invoke-virtual/range {p0 .. p7}, Lio/minio/S3Base;->uploadPartCopyAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 3605
    invoke-virtual {v0}, Ljava/util/concurrent/CompletableFuture;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/UploadPartCopyResponse;
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_0

    .line 3603
    return-object v0

    .line 3608
    :catch_0
    move-exception v0

    .line 3609
    .local v0, "e":Ljava/util/concurrent/ExecutionException;
    invoke-virtual {p0, v0}, Lio/minio/S3Base;->throwEncapsulatedException(Ljava/util/concurrent/ExecutionException;)V

    .line 3610
    const/4 v1, 0x0

    return-object v1

    .line 3606
    .end local v0    # "e":Ljava/util/concurrent/ExecutionException;
    :catch_1
    move-exception v0

    .line 3607
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected uploadPartCopyAsync(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)Ljava/util/concurrent/CompletableFuture;
    .locals 10
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "objectName"    # Ljava/lang/String;
    .param p4, "uploadId"    # Ljava/lang/String;
    .param p5, "partNumber"    # I
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
            ">;",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/concurrent/CompletableFuture<",
            "Lio/minio/UploadPartCopyResponse;",
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

    .line 3644
    .local p6, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    .local p7, "extraQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0, p1, p2}, Lio/minio/S3Base;->getRegionAsync(Ljava/lang/String;Ljava/lang/String;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v9, Lio/minio/S3Base$$ExternalSyntheticLambda27;

    move-object v1, v9

    move-object v2, p0

    move-object v3, p1

    move-object v4, p3

    move-object/from16 v5, p6

    move-object/from16 v6, p7

    move v7, p5

    move-object v8, p4

    invoke-direct/range {v1 .. v8}, Lio/minio/S3Base$$ExternalSyntheticLambda27;-><init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;ILjava/lang/String;)V

    .line 3645
    invoke-virtual {v0, v9}, Ljava/util/concurrent/CompletableFuture;->thenCompose(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    new-instance v7, Lio/minio/S3Base$$ExternalSyntheticLambda28;

    move-object v1, v7

    move-object v2, p1

    move-object v3, p2

    move-object v5, p4

    move v6, p5

    invoke-direct/range {v1 .. v6}, Lio/minio/S3Base$$ExternalSyntheticLambda28;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 3669
    invoke-virtual {v0, v7}, Ljava/util/concurrent/CompletableFuture;->thenApply(Ljava/util/function/Function;)Ljava/util/concurrent/CompletableFuture;

    move-result-object v0

    .line 3644
    return-object v0
.end method
