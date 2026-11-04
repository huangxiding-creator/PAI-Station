.class public final Lio/minio/MinioAsyncClient$Builder;
.super Ljava/lang/Object;
.source "MinioAsyncClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/MinioAsyncClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field private baseUrl:Lokhttp3/HttpUrl;

.field private httpClient:Lokhttp3/OkHttpClient;

.field private isAccelerateHost:Z

.field private isAwsChinaHost:Z

.field private isAwsHost:Z

.field private isDualStackHost:Z

.field private isFipsHost:Z

.field private provider:Lio/minio/credentials/Provider;

.field private region:Ljava/lang/String;

.field private regionInUrl:Ljava/lang/String;

.field private useVirtualStyle:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 3217
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private extractRegion(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "endpoint"    # Ljava/lang/String;

    .line 3262
    const-string v0, "\\."

    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 3263
    .local v0, "tokens":[Ljava/lang/String;
    const/4 v1, 0x1

    aget-object v1, v0, v1

    .line 3266
    .local v1, "token":Ljava/lang/String;
    const-string v2, "dualstack"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 3267
    const/4 v2, 0x2

    aget-object v1, v0, v2

    .line 3271
    :cond_0
    const-string v2, "amazonaws"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 3272
    const/4 v2, 0x0

    return-object v2

    .line 3276
    :cond_1
    return-object v1
.end method

.method private isAwsAccelerateEndpoint(Ljava/lang/String;)Z
    .locals 1
    .param p1, "endpoint"    # Ljava/lang/String;

    .line 3236
    const-string/jumbo v0, "s3-accelerate."

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method private isAwsDualStackEndpoint(Ljava/lang/String;)Z
    .locals 1
    .param p1, "endpoint"    # Ljava/lang/String;

    .line 3247
    const-string v0, ".dualstack."

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method

.method private isAwsEndpoint(Ljava/lang/String;)Z
    .locals 1
    .param p1, "endpoint"    # Ljava/lang/String;

    .line 3240
    const-string/jumbo v0, "s3."

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 3241
    invoke-direct {p0, p1}, Lio/minio/MinioAsyncClient$Builder;->isAwsFipsEndpoint(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 3242
    invoke-direct {p0, p1}, Lio/minio/MinioAsyncClient$Builder;->isAwsAccelerateEndpoint(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    nop

    .line 3243
    const-string v0, ".amazonaws.com"

    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, ".amazonaws.com.cn"

    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v0, 0x1

    .line 3240
    :goto_1
    return v0
.end method

.method private isAwsFipsEndpoint(Ljava/lang/String;)Z
    .locals 1
    .param p1, "endpoint"    # Ljava/lang/String;

    .line 3232
    const-string/jumbo v0, "s3-fips."

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method private setBaseUrl(Lokhttp3/HttpUrl;)V
    .locals 3
    .param p1, "url"    # Lokhttp3/HttpUrl;

    .line 3280
    invoke-virtual {p1}, Lokhttp3/HttpUrl;->host()Ljava/lang/String;

    move-result-object v0

    .line 3282
    .local v0, "host":Ljava/lang/String;
    invoke-direct {p0, v0}, Lio/minio/MinioAsyncClient$Builder;->isAwsEndpoint(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, p0, Lio/minio/MinioAsyncClient$Builder;->isAwsHost:Z

    .line 3283
    const/4 v1, 0x0

    iput-boolean v1, p0, Lio/minio/MinioAsyncClient$Builder;->isAwsChinaHost:Z

    .line 3284
    iget-boolean v1, p0, Lio/minio/MinioAsyncClient$Builder;->isAwsHost:Z

    if-eqz v1, :cond_1

    .line 3285
    const-string v1, ".cn"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, p0, Lio/minio/MinioAsyncClient$Builder;->isAwsChinaHost:Z

    .line 3286
    nop

    .line 3287
    invoke-virtual {p1}, Lokhttp3/HttpUrl;->newBuilder()Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 3288
    iget-boolean v2, p0, Lio/minio/MinioAsyncClient$Builder;->isAwsChinaHost:Z

    if-eqz v2, :cond_0

    const-string v2, "amazonaws.com.cn"

    goto :goto_0

    :cond_0
    const-string v2, "amazonaws.com"

    :goto_0
    invoke-virtual {v1, v2}, Lokhttp3/HttpUrl$Builder;->host(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 3289
    invoke-virtual {v1}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object p1

    .line 3290
    invoke-direct {p0, v0}, Lio/minio/MinioAsyncClient$Builder;->isAwsFipsEndpoint(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, p0, Lio/minio/MinioAsyncClient$Builder;->isFipsHost:Z

    .line 3291
    invoke-direct {p0, v0}, Lio/minio/MinioAsyncClient$Builder;->isAwsAccelerateEndpoint(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, p0, Lio/minio/MinioAsyncClient$Builder;->isAccelerateHost:Z

    .line 3292
    invoke-direct {p0, v0}, Lio/minio/MinioAsyncClient$Builder;->isAwsDualStackEndpoint(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, p0, Lio/minio/MinioAsyncClient$Builder;->isDualStackHost:Z

    .line 3293
    invoke-direct {p0, v0}, Lio/minio/MinioAsyncClient$Builder;->extractRegion(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lio/minio/MinioAsyncClient$Builder;->regionInUrl:Ljava/lang/String;

    .line 3294
    const/4 v1, 0x1

    iput-boolean v1, p0, Lio/minio/MinioAsyncClient$Builder;->useVirtualStyle:Z

    goto :goto_1

    .line 3296
    :cond_1
    const-string v1, "aliyuncs.com"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, p0, Lio/minio/MinioAsyncClient$Builder;->useVirtualStyle:Z

    .line 3299
    :goto_1
    iput-object p1, p0, Lio/minio/MinioAsyncClient$Builder;->baseUrl:Lokhttp3/HttpUrl;

    .line 3300
    return-void
.end method


# virtual methods
.method public build()Lio/minio/MinioAsyncClient;
    .locals 12

    .line 3354
    iget-object v0, p0, Lio/minio/MinioAsyncClient$Builder;->baseUrl:Lokhttp3/HttpUrl;

    const-string v1, "endpoint"

    invoke-static {v0, v1}, Lio/minio/http/HttpUtils;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 3355
    iget-boolean v0, p0, Lio/minio/MinioAsyncClient$Builder;->isAwsChinaHost:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lio/minio/MinioAsyncClient$Builder;->regionInUrl:Ljava/lang/String;

    if-nez v0, :cond_1

    iget-object v0, p0, Lio/minio/MinioAsyncClient$Builder;->region:Ljava/lang/String;

    if-eqz v0, :cond_0

    goto :goto_0

    .line 3356
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Region missing in Amazon S3 China endpoint "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lio/minio/MinioAsyncClient$Builder;->baseUrl:Lokhttp3/HttpUrl;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 3360
    :cond_1
    :goto_0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$Builder;->httpClient:Lokhttp3/OkHttpClient;

    if-nez v0, :cond_2

    .line 3361
    sget-wide v1, Lio/minio/S3Base;->DEFAULT_CONNECTION_TIMEOUT:J

    sget-wide v3, Lio/minio/S3Base;->DEFAULT_CONNECTION_TIMEOUT:J

    sget-wide v5, Lio/minio/S3Base;->DEFAULT_CONNECTION_TIMEOUT:J

    .line 3362
    invoke-static/range {v1 .. v6}, Lio/minio/http/HttpUtils;->newDefaultHttpClient(JJJ)Lokhttp3/OkHttpClient;

    move-result-object v0

    iput-object v0, p0, Lio/minio/MinioAsyncClient$Builder;->httpClient:Lokhttp3/OkHttpClient;

    .line 3364
    iget-object v0, p0, Lio/minio/MinioAsyncClient$Builder;->region:Ljava/lang/String;

    if-nez v0, :cond_2

    iget-object v0, p0, Lio/minio/MinioAsyncClient$Builder;->regionInUrl:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/MinioAsyncClient$Builder;->region:Ljava/lang/String;

    .line 3367
    :cond_2
    new-instance v0, Lio/minio/MinioAsyncClient;

    iget-object v2, p0, Lio/minio/MinioAsyncClient$Builder;->baseUrl:Lokhttp3/HttpUrl;

    iget-object v3, p0, Lio/minio/MinioAsyncClient$Builder;->region:Ljava/lang/String;

    iget-boolean v4, p0, Lio/minio/MinioAsyncClient$Builder;->isAwsHost:Z

    iget-boolean v5, p0, Lio/minio/MinioAsyncClient$Builder;->isFipsHost:Z

    iget-boolean v6, p0, Lio/minio/MinioAsyncClient$Builder;->isAccelerateHost:Z

    iget-boolean v7, p0, Lio/minio/MinioAsyncClient$Builder;->isDualStackHost:Z

    iget-boolean v8, p0, Lio/minio/MinioAsyncClient$Builder;->useVirtualStyle:Z

    iget-object v9, p0, Lio/minio/MinioAsyncClient$Builder;->provider:Lio/minio/credentials/Provider;

    iget-object v10, p0, Lio/minio/MinioAsyncClient$Builder;->httpClient:Lokhttp3/OkHttpClient;

    const/4 v11, 0x0

    move-object v1, v0

    invoke-direct/range {v1 .. v11}, Lio/minio/MinioAsyncClient;-><init>(Lokhttp3/HttpUrl;Ljava/lang/String;ZZZZZLio/minio/credentials/Provider;Lokhttp3/OkHttpClient;Lio/minio/MinioAsyncClient$1;)V

    return-object v0
.end method

.method public credentials(Ljava/lang/String;Ljava/lang/String;)Lio/minio/MinioAsyncClient$Builder;
    .locals 2
    .param p1, "accessKey"    # Ljava/lang/String;
    .param p2, "secretKey"    # Ljava/lang/String;

    .line 3338
    new-instance v0, Lio/minio/credentials/StaticProvider;

    const/4 v1, 0x0

    invoke-direct {v0, p1, p2, v1}, Lio/minio/credentials/StaticProvider;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lio/minio/MinioAsyncClient$Builder;->provider:Lio/minio/credentials/Provider;

    .line 3339
    return-object p0
.end method

.method public credentialsProvider(Lio/minio/credentials/Provider;)Lio/minio/MinioAsyncClient$Builder;
    .locals 0
    .param p1, "provider"    # Lio/minio/credentials/Provider;

    .line 3343
    iput-object p1, p0, Lio/minio/MinioAsyncClient$Builder;->provider:Lio/minio/credentials/Provider;

    .line 3344
    return-object p0
.end method

.method public endpoint(Ljava/lang/String;)Lio/minio/MinioAsyncClient$Builder;
    .locals 1
    .param p1, "endpoint"    # Ljava/lang/String;

    .line 3303
    invoke-static {p1}, Lio/minio/http/HttpUtils;->getBaseUrl(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/MinioAsyncClient$Builder;->setBaseUrl(Lokhttp3/HttpUrl;)V

    .line 3304
    return-object p0
.end method

.method public endpoint(Ljava/lang/String;IZ)Lio/minio/MinioAsyncClient$Builder;
    .locals 3
    .param p1, "endpoint"    # Ljava/lang/String;
    .param p2, "port"    # I
    .param p3, "secure"    # Z

    .line 3308
    invoke-static {p1}, Lio/minio/http/HttpUtils;->getBaseUrl(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v0

    .line 3309
    .local v0, "url":Lokhttp3/HttpUrl;
    const/4 v1, 0x1

    if-lt p2, v1, :cond_1

    const v1, 0xffff

    if-gt p2, v1, :cond_1

    .line 3312
    invoke-virtual {v0}, Lokhttp3/HttpUrl;->newBuilder()Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    invoke-virtual {v1, p2}, Lokhttp3/HttpUrl$Builder;->port(I)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    if-eqz p3, :cond_0

    const-string v2, "https"

    goto :goto_0

    :cond_0
    const-string v2, "http"

    :goto_0
    invoke-virtual {v1, v2}, Lokhttp3/HttpUrl$Builder;->scheme(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v0

    .line 3314
    invoke-direct {p0, v0}, Lio/minio/MinioAsyncClient$Builder;->setBaseUrl(Lokhttp3/HttpUrl;)V

    .line 3315
    return-object p0

    .line 3310
    :cond_1
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "port must be in range of 1 to 65535"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public endpoint(Ljava/net/URL;)Lio/minio/MinioAsyncClient$Builder;
    .locals 1
    .param p1, "url"    # Ljava/net/URL;

    .line 3319
    const-string/jumbo v0, "url"

    invoke-static {p1, v0}, Lio/minio/http/HttpUtils;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 3320
    invoke-static {p1}, Lokhttp3/HttpUrl;->get(Ljava/net/URL;)Lokhttp3/HttpUrl;

    move-result-object v0

    invoke-virtual {p0, v0}, Lio/minio/MinioAsyncClient$Builder;->endpoint(Lokhttp3/HttpUrl;)Lio/minio/MinioAsyncClient$Builder;

    move-result-object v0

    return-object v0
.end method

.method public endpoint(Lokhttp3/HttpUrl;)Lio/minio/MinioAsyncClient$Builder;
    .locals 1
    .param p1, "url"    # Lokhttp3/HttpUrl;

    .line 3324
    const-string/jumbo v0, "url"

    invoke-static {p1, v0}, Lio/minio/http/HttpUtils;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 3325
    invoke-static {p1}, Lio/minio/http/HttpUtils;->validateUrl(Lokhttp3/HttpUrl;)V

    .line 3326
    invoke-direct {p0, p1}, Lio/minio/MinioAsyncClient$Builder;->setBaseUrl(Lokhttp3/HttpUrl;)V

    .line 3327
    return-object p0
.end method

.method public httpClient(Lokhttp3/OkHttpClient;)Lio/minio/MinioAsyncClient$Builder;
    .locals 1
    .param p1, "httpClient"    # Lokhttp3/OkHttpClient;

    .line 3348
    const-string v0, "http client"

    invoke-static {p1, v0}, Lio/minio/http/HttpUtils;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 3349
    iput-object p1, p0, Lio/minio/MinioAsyncClient$Builder;->httpClient:Lokhttp3/OkHttpClient;

    .line 3350
    return-object p0
.end method

.method public region(Ljava/lang/String;)Lio/minio/MinioAsyncClient$Builder;
    .locals 1
    .param p1, "region"    # Ljava/lang/String;

    .line 3331
    const-string v0, "region"

    invoke-static {p1, v0}, Lio/minio/http/HttpUtils;->validateNullOrNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 3332
    iput-object p1, p0, Lio/minio/MinioAsyncClient$Builder;->regionInUrl:Ljava/lang/String;

    .line 3333
    iput-object p1, p0, Lio/minio/MinioAsyncClient$Builder;->region:Ljava/lang/String;

    .line 3334
    return-object p0
.end method
