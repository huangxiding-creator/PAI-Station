.class public abstract Lio/minio/credentials/AssumeRoleBaseProvider;
.super Ljava/lang/Object;
.source "AssumeRoleBaseProvider.java"

# interfaces
.implements Lio/minio/credentials/Provider;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/credentials/AssumeRoleBaseProvider$Response;
    }
.end annotation


# static fields
.field public static final DEFAULT_DURATION_SECONDS:I


# instance fields
.field private credentials:Lio/minio/credentials/Credentials;

.field private final httpClient:Lokhttp3/OkHttpClient;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 37
    sget-object v0, Ljava/util/concurrent/TimeUnit;->HOURS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v1, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/TimeUnit;->toSeconds(J)J

    move-result-wide v0

    long-to-int v0, v0

    sput v0, Lio/minio/credentials/AssumeRoleBaseProvider;->DEFAULT_DURATION_SECONDS:I

    return-void
.end method

.method public constructor <init>(Lokhttp3/OkHttpClient;)V
    .locals 4
    .param p1, "customHttpClient"    # Lokhttp3/OkHttpClient;

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    nop

    .line 45
    if-eqz p1, :cond_0

    .line 46
    move-object v0, p1

    goto :goto_0

    .line 47
    :cond_0
    new-instance v0, Lokhttp3/OkHttpClient;

    invoke-direct {v0}, Lokhttp3/OkHttpClient;-><init>()V

    invoke-virtual {v0}, Lokhttp3/OkHttpClient;->newBuilder()Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Lokhttp3/Protocol;

    const/4 v2, 0x0

    sget-object v3, Lokhttp3/Protocol;->HTTP_1_1:Lokhttp3/Protocol;

    aput-object v3, v1, v2

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lokhttp3/OkHttpClient$Builder;->protocols(Ljava/util/List;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lio/minio/credentials/AssumeRoleBaseProvider;->httpClient:Lokhttp3/OkHttpClient;

    .line 48
    return-void
.end method

.method public constructor <init>(Lokhttp3/OkHttpClient;Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)V
    .locals 4
    .param p1, "customHttpClient"    # Lokhttp3/OkHttpClient;
    .param p2, "sslSocketFactory"    # Ljavax/net/ssl/SSLSocketFactory;
    .param p3, "trustManager"    # Ljavax/net/ssl/X509TrustManager;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/GeneralSecurityException;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 54
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 55
    if-eqz p1, :cond_1

    .line 56
    if-nez p2, :cond_0

    if-nez p3, :cond_0

    .line 61
    iput-object p1, p0, Lio/minio/credentials/AssumeRoleBaseProvider;->httpClient:Lokhttp3/OkHttpClient;

    goto :goto_0

    .line 57
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Either sslSocketFactory/trustManager or custom HTTP client must be provided"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 63
    :cond_1
    if-eqz p2, :cond_2

    if-eqz p3, :cond_2

    .line 70
    new-instance v0, Lokhttp3/OkHttpClient;

    invoke-direct {v0}, Lokhttp3/OkHttpClient;-><init>()V

    .line 72
    invoke-virtual {v0}, Lokhttp3/OkHttpClient;->newBuilder()Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Lokhttp3/Protocol;

    const/4 v2, 0x0

    sget-object v3, Lokhttp3/Protocol;->HTTP_1_1:Lokhttp3/Protocol;

    aput-object v3, v1, v2

    .line 73
    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lokhttp3/OkHttpClient$Builder;->protocols(Ljava/util/List;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 74
    invoke-virtual {v0, p2, p3}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 75
    invoke-virtual {v0}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    iput-object v0, p0, Lio/minio/credentials/AssumeRoleBaseProvider;->httpClient:Lokhttp3/OkHttpClient;

    .line 77
    :goto_0
    return-void

    .line 64
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Both sslSocketFactory and trustManager must be provided"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected static getValidDurationSeconds(Ljava/lang/Integer;)I
    .locals 2
    .param p0, "duration"    # Ljava/lang/Integer;

    .line 98
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    sget v1, Lio/minio/credentials/AssumeRoleBaseProvider;->DEFAULT_DURATION_SECONDS:I

    if-le v0, v1, :cond_0

    .line 99
    invoke-virtual {p0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    goto :goto_0

    .line 100
    :cond_0
    sget v0, Lio/minio/credentials/AssumeRoleBaseProvider;->DEFAULT_DURATION_SECONDS:I

    .line 98
    :goto_0
    return v0
.end method


# virtual methods
.method public declared-synchronized fetch()Lio/minio/credentials/Credentials;
    .locals 4

    monitor-enter p0

    .line 81
    :try_start_0
    iget-object v0, p0, Lio/minio/credentials/AssumeRoleBaseProvider;->credentials:Lio/minio/credentials/Credentials;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/credentials/AssumeRoleBaseProvider;->credentials:Lio/minio/credentials/Credentials;

    invoke-virtual {v0}, Lio/minio/credentials/Credentials;->isExpired()Z

    move-result v0

    if-nez v0, :cond_0

    .line 82
    iget-object v0, p0, Lio/minio/credentials/AssumeRoleBaseProvider;->credentials:Lio/minio/credentials/Credentials;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    monitor-exit p0

    return-object v0

    .line 85
    .end local p0    # "this":Lio/minio/credentials/AssumeRoleBaseProvider;
    :cond_0
    :try_start_1
    iget-object v0, p0, Lio/minio/credentials/AssumeRoleBaseProvider;->httpClient:Lokhttp3/OkHttpClient;

    invoke-virtual {p0}, Lio/minio/credentials/AssumeRoleBaseProvider;->getRequest()Lokhttp3/Request;

    move-result-object v1

    invoke-virtual {v0, v1}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v0

    invoke-interface {v0}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object v0
    :try_end_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    .line 86
    .local v0, "response":Lokhttp3/Response;
    :try_start_2
    invoke-virtual {v0}, Lokhttp3/Response;->isSuccessful()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 90
    invoke-virtual {p0, v0}, Lio/minio/credentials/AssumeRoleBaseProvider;->parseResponse(Lokhttp3/Response;)Lio/minio/credentials/Credentials;

    move-result-object v1

    iput-object v1, p0, Lio/minio/credentials/AssumeRoleBaseProvider;->credentials:Lio/minio/credentials/Credentials;

    .line 91
    iget-object v1, p0, Lio/minio/credentials/AssumeRoleBaseProvider;->credentials:Lio/minio/credentials/Credentials;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 92
    if-eqz v0, :cond_1

    :try_start_3
    invoke-virtual {v0}, Lokhttp3/Response;->close()V
    :try_end_3
    .catch Lio/minio/errors/XmlParserException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 91
    :cond_1
    monitor-exit p0

    return-object v1

    .line 87
    :cond_2
    :try_start_4
    new-instance v1, Ljava/security/ProviderException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "STS service failed with HTTP status code "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Lokhttp3/Response;->code()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    .end local v0    # "response":Lokhttp3/Response;
    throw v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 85
    .restart local v0    # "response":Lokhttp3/Response;
    :catchall_0
    move-exception v1

    if-eqz v0, :cond_3

    :try_start_5
    invoke-virtual {v0}, Lokhttp3/Response;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v2

    :try_start_6
    invoke-virtual {v1, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_3
    :goto_0
    throw v1
    :try_end_6
    .catch Lio/minio/errors/XmlParserException; {:try_start_6 .. :try_end_6} :catch_1
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_0
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 92
    .end local v0    # "response":Lokhttp3/Response;
    :catch_0
    move-exception v0

    goto :goto_1

    :catch_1
    move-exception v0

    .line 93
    .local v0, "e":Ljava/lang/Exception;
    :goto_1
    :try_start_7
    new-instance v1, Ljava/security/ProviderException;

    const-string v2, "Unable to parse STS response"

    invoke-direct {v1, v2, v0}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 80
    .end local v0    # "e":Ljava/lang/Exception;
    :catchall_2
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected abstract getRequest()Lokhttp3/Request;
.end method

.method protected abstract getResponseClass()Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "+",
            "Lio/minio/credentials/AssumeRoleBaseProvider$Response;",
            ">;"
        }
    .end annotation
.end method

.method protected newUrlBuilder(Lokhttp3/HttpUrl;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;
    .locals 3
    .param p1, "url"    # Lokhttp3/HttpUrl;
    .param p2, "action"    # Ljava/lang/String;
    .param p3, "durationSeconds"    # I
    .param p4, "policy"    # Ljava/lang/String;
    .param p5, "roleArn"    # Ljava/lang/String;
    .param p6, "roleSessionName"    # Ljava/lang/String;

    .line 110
    nop

    .line 111
    invoke-virtual {p1}, Lokhttp3/HttpUrl;->newBuilder()Lokhttp3/HttpUrl$Builder;

    move-result-object v0

    .line 112
    const-string v1, "Action"

    invoke-virtual {v0, v1, p2}, Lokhttp3/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v0

    .line 113
    const-string v1, "Version"

    const-string v2, "2011-06-15"

    invoke-virtual {v0, v1, v2}, Lokhttp3/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v0

    .line 115
    .local v0, "urlBuilder":Lokhttp3/HttpUrl$Builder;
    if-lez p3, :cond_0

    .line 116
    const-string v1, "DurationSeconds"

    invoke-static {p3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lokhttp3/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 119
    :cond_0
    if-eqz p4, :cond_1

    .line 120
    const-string v1, "Policy"

    invoke-virtual {v0, v1, p4}, Lokhttp3/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 123
    :cond_1
    if-eqz p5, :cond_2

    .line 124
    const-string v1, "RoleArn"

    invoke-virtual {v0, v1, p5}, Lokhttp3/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 127
    :cond_2
    if-eqz p6, :cond_3

    .line 128
    const-string v1, "RoleSessionName"

    invoke-virtual {v0, v1, p6}, Lokhttp3/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 131
    :cond_3
    return-object v0
.end method

.method protected parseResponse(Lokhttp3/Response;)Lio/minio/credentials/Credentials;
    .locals 2
    .param p1, "response"    # Lokhttp3/Response;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/XmlParserException;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 136
    invoke-virtual {p0}, Lio/minio/credentials/AssumeRoleBaseProvider;->getResponseClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {p1}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/io/Reader;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/credentials/AssumeRoleBaseProvider$Response;

    .line 137
    .local v0, "result":Lio/minio/credentials/AssumeRoleBaseProvider$Response;
    invoke-interface {v0}, Lio/minio/credentials/AssumeRoleBaseProvider$Response;->getCredentials()Lio/minio/credentials/Credentials;

    move-result-object v1

    return-object v1
.end method
