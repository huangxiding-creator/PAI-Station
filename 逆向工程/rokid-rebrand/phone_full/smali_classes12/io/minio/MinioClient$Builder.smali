.class public final Lio/minio/MinioClient$Builder;
.super Ljava/lang/Object;
.source "MinioClient.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/MinioClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field private asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 2446
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2444
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/MinioClient$Builder;->asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;

    .line 2447
    invoke-static {}, Lio/minio/MinioAsyncClient;->builder()Lio/minio/MinioAsyncClient$Builder;

    move-result-object v0

    iput-object v0, p0, Lio/minio/MinioClient$Builder;->asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;

    .line 2448
    return-void
.end method


# virtual methods
.method public build()Lio/minio/MinioClient;
    .locals 3

    .line 2491
    iget-object v0, p0, Lio/minio/MinioClient$Builder;->asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;

    invoke-virtual {v0}, Lio/minio/MinioAsyncClient$Builder;->build()Lio/minio/MinioAsyncClient;

    move-result-object v0

    .line 2492
    .local v0, "asyncClient":Lio/minio/MinioAsyncClient;
    new-instance v1, Lio/minio/MinioClient;

    const/4 v2, 0x0

    invoke-direct {v1, v0, v2}, Lio/minio/MinioClient;-><init>(Lio/minio/MinioAsyncClient;Lio/minio/MinioClient$1;)V

    return-object v1
.end method

.method public credentials(Ljava/lang/String;Ljava/lang/String;)Lio/minio/MinioClient$Builder;
    .locals 1
    .param p1, "accessKey"    # Ljava/lang/String;
    .param p2, "secretKey"    # Ljava/lang/String;

    .line 2476
    iget-object v0, p0, Lio/minio/MinioClient$Builder;->asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;

    invoke-virtual {v0, p1, p2}, Lio/minio/MinioAsyncClient$Builder;->credentials(Ljava/lang/String;Ljava/lang/String;)Lio/minio/MinioAsyncClient$Builder;

    .line 2477
    return-object p0
.end method

.method public credentialsProvider(Lio/minio/credentials/Provider;)Lio/minio/MinioClient$Builder;
    .locals 1
    .param p1, "provider"    # Lio/minio/credentials/Provider;

    .line 2481
    iget-object v0, p0, Lio/minio/MinioClient$Builder;->asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient$Builder;->credentialsProvider(Lio/minio/credentials/Provider;)Lio/minio/MinioAsyncClient$Builder;

    .line 2482
    return-object p0
.end method

.method public endpoint(Ljava/lang/String;)Lio/minio/MinioClient$Builder;
    .locals 1
    .param p1, "endpoint"    # Ljava/lang/String;

    .line 2451
    iget-object v0, p0, Lio/minio/MinioClient$Builder;->asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient$Builder;->endpoint(Ljava/lang/String;)Lio/minio/MinioAsyncClient$Builder;

    .line 2452
    return-object p0
.end method

.method public endpoint(Ljava/lang/String;IZ)Lio/minio/MinioClient$Builder;
    .locals 1
    .param p1, "endpoint"    # Ljava/lang/String;
    .param p2, "port"    # I
    .param p3, "secure"    # Z

    .line 2456
    iget-object v0, p0, Lio/minio/MinioClient$Builder;->asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;

    invoke-virtual {v0, p1, p2, p3}, Lio/minio/MinioAsyncClient$Builder;->endpoint(Ljava/lang/String;IZ)Lio/minio/MinioAsyncClient$Builder;

    .line 2457
    return-object p0
.end method

.method public endpoint(Ljava/net/URL;)Lio/minio/MinioClient$Builder;
    .locals 1
    .param p1, "url"    # Ljava/net/URL;

    .line 2461
    iget-object v0, p0, Lio/minio/MinioClient$Builder;->asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient$Builder;->endpoint(Ljava/net/URL;)Lio/minio/MinioAsyncClient$Builder;

    .line 2462
    return-object p0
.end method

.method public endpoint(Lokhttp3/HttpUrl;)Lio/minio/MinioClient$Builder;
    .locals 1
    .param p1, "url"    # Lokhttp3/HttpUrl;

    .line 2466
    iget-object v0, p0, Lio/minio/MinioClient$Builder;->asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient$Builder;->endpoint(Lokhttp3/HttpUrl;)Lio/minio/MinioAsyncClient$Builder;

    .line 2467
    return-object p0
.end method

.method public httpClient(Lokhttp3/OkHttpClient;)Lio/minio/MinioClient$Builder;
    .locals 1
    .param p1, "httpClient"    # Lokhttp3/OkHttpClient;

    .line 2486
    iget-object v0, p0, Lio/minio/MinioClient$Builder;->asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient$Builder;->httpClient(Lokhttp3/OkHttpClient;)Lio/minio/MinioAsyncClient$Builder;

    .line 2487
    return-object p0
.end method

.method public region(Ljava/lang/String;)Lio/minio/MinioClient$Builder;
    .locals 1
    .param p1, "region"    # Ljava/lang/String;

    .line 2471
    iget-object v0, p0, Lio/minio/MinioClient$Builder;->asyncClientBuilder:Lio/minio/MinioAsyncClient$Builder;

    invoke-virtual {v0, p1}, Lio/minio/MinioAsyncClient$Builder;->region(Ljava/lang/String;)Lio/minio/MinioAsyncClient$Builder;

    .line 2472
    return-object p0
.end method
