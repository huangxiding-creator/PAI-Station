.class public Lio/minio/credentials/IamAwsProvider;
.super Lio/minio/credentials/EnvironmentProvider;
.source "IamAwsProvider.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/credentials/IamAwsProvider$EcsCredentials;
    }
.end annotation


# instance fields
.field private credentials:Lio/minio/credentials/Credentials;

.field private final customEndpoint:Lokhttp3/HttpUrl;

.field private final httpClient:Lokhttp3/OkHttpClient;

.field private final mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lokhttp3/OkHttpClient;)V
    .locals 5
    .param p1, "customEndpoint"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p2, "customHttpClient"    # Lokhttp3/OkHttpClient;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 57
    invoke-direct {p0}, Lio/minio/credentials/EnvironmentProvider;-><init>()V

    .line 58
    nop

    .line 59
    if-eqz p1, :cond_0

    .line 60
    invoke-static {p1}, Lokhttp3/HttpUrl;->parse(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v0

    const-string v1, "Invalid custom endpoint"

    invoke-static {v0, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/HttpUrl;

    goto :goto_0

    .line 61
    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-object v0, p0, Lio/minio/credentials/IamAwsProvider;->customEndpoint:Lokhttp3/HttpUrl;

    .line 64
    nop

    .line 65
    const/4 v0, 0x0

    const/4 v1, 0x1

    if-eqz p2, :cond_1

    .line 66
    move-object v2, p2

    goto :goto_1

    .line 67
    :cond_1
    new-instance v2, Lokhttp3/OkHttpClient;

    invoke-direct {v2}, Lokhttp3/OkHttpClient;-><init>()V

    invoke-virtual {v2}, Lokhttp3/OkHttpClient;->newBuilder()Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    new-array v3, v1, [Lokhttp3/Protocol;

    sget-object v4, Lokhttp3/Protocol;->HTTP_1_1:Lokhttp3/Protocol;

    aput-object v4, v3, v0

    invoke-static {v3}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    invoke-virtual {v2, v3}, Lokhttp3/OkHttpClient$Builder;->protocols(Ljava/util/List;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v2

    :goto_1
    iput-object v2, p0, Lio/minio/credentials/IamAwsProvider;->httpClient:Lokhttp3/OkHttpClient;

    .line 68
    nop

    .line 69
    invoke-static {}, Lcom/fasterxml/jackson/databind/json/JsonMapper;->builder()Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;

    move-result-object v2

    sget-object v3, Lcom/fasterxml/jackson/databind/DeserializationFeature;->FAIL_ON_UNKNOWN_PROPERTIES:Lcom/fasterxml/jackson/databind/DeserializationFeature;

    .line 70
    invoke-virtual {v2, v3, v0}, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;->configure(Lcom/fasterxml/jackson/databind/DeserializationFeature;Z)Lcom/fasterxml/jackson/databind/cfg/MapperBuilder;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;

    sget-object v2, Lcom/fasterxml/jackson/databind/MapperFeature;->ACCEPT_CASE_INSENSITIVE_PROPERTIES:Lcom/fasterxml/jackson/databind/MapperFeature;

    .line 71
    invoke-virtual {v0, v2, v1}, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;->configure(Lcom/fasterxml/jackson/databind/MapperFeature;Z)Lcom/fasterxml/jackson/databind/cfg/MapperBuilder;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;

    .line 72
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;->build()Lcom/fasterxml/jackson/databind/ObjectMapper;

    move-result-object v0

    iput-object v0, p0, Lio/minio/credentials/IamAwsProvider;->mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

    .line 73
    return-void
.end method

.method private checkLoopbackHost(Lokhttp3/HttpUrl;)V
    .locals 5
    .param p1, "url"    # Lokhttp3/HttpUrl;

    .line 77
    :try_start_0
    invoke-virtual {p1}, Lokhttp3/HttpUrl;->host()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/net/InetAddress;->getAllByName(Ljava/lang/String;)[Ljava/net/InetAddress;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 78
    .local v3, "addr":Ljava/net/InetAddress;
    invoke-virtual {v3}, Ljava/net/InetAddress;->isLoopbackAddress()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 77
    .end local v3    # "addr":Ljava/net/InetAddress;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 79
    .restart local v3    # "addr":Ljava/net/InetAddress;
    :cond_0
    new-instance v0, Ljava/security/ProviderException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lokhttp3/HttpUrl;->host()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is not loopback only host"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    .end local p1    # "url":Lokhttp3/HttpUrl;
    throw v0
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    .line 84
    .end local v3    # "addr":Ljava/net/InetAddress;
    .restart local p1    # "url":Lokhttp3/HttpUrl;
    :cond_1
    nop

    .line 85
    return-void

    .line 82
    :catch_0
    move-exception v0

    .line 83
    .local v0, "e":Ljava/net/UnknownHostException;
    new-instance v1, Ljava/security/ProviderException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Host in "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " is not loopback address"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private fetchCredentials(Ljava/lang/String;)Lio/minio/credentials/Credentials;
    .locals 10
    .param p1, "tokenFile"    # Ljava/lang/String;

    .line 88
    iget-object v0, p0, Lio/minio/credentials/IamAwsProvider;->customEndpoint:Lokhttp3/HttpUrl;

    .line 89
    .local v0, "url":Lokhttp3/HttpUrl;
    if-nez v0, :cond_1

    .line 90
    const-string v1, "AWS_REGION"

    invoke-virtual {p0, v1}, Lio/minio/credentials/IamAwsProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 93
    .local v1, "region":Ljava/lang/String;
    if-nez v1, :cond_0

    .line 94
    const-string v2, "https://sts.amazonaws.com"

    goto :goto_0

    .line 95
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "https://sts."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".amazonaws.com"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 92
    :goto_0
    invoke-static {v2}, Lokhttp3/HttpUrl;->parse(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v0

    .line 98
    .end local v1    # "region":Ljava/lang/String;
    :cond_1
    new-instance v9, Lio/minio/credentials/WebIdentityProvider;

    new-instance v2, Lio/minio/credentials/IamAwsProvider$$ExternalSyntheticLambda0;

    invoke-direct {v2, p1}, Lio/minio/credentials/IamAwsProvider$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    .line 108
    invoke-virtual {v0}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object v3

    .line 111
    const-string v1, "AWS_ROLE_ARN"

    invoke-virtual {p0, v1}, Lio/minio/credentials/IamAwsProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 112
    const-string v1, "AWS_ROLE_SESSION_NAME"

    invoke-virtual {p0, v1}, Lio/minio/credentials/IamAwsProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    iget-object v8, p0, Lio/minio/credentials/IamAwsProvider;->httpClient:Lokhttp3/OkHttpClient;

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, v9

    invoke-direct/range {v1 .. v8}, Lio/minio/credentials/WebIdentityProvider;-><init>(Ljava/util/function/Supplier;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/OkHttpClient;)V

    .line 114
    .local v1, "provider":Lio/minio/credentials/Provider;
    invoke-interface {v1}, Lio/minio/credentials/Provider;->fetch()Lio/minio/credentials/Credentials;

    move-result-object v2

    iput-object v2, p0, Lio/minio/credentials/IamAwsProvider;->credentials:Lio/minio/credentials/Credentials;

    .line 115
    iget-object v2, p0, Lio/minio/credentials/IamAwsProvider;->credentials:Lio/minio/credentials/Credentials;

    return-object v2
.end method

.method private fetchCredentials(Lokhttp3/HttpUrl;Ljava/lang/String;Ljava/lang/String;)Lio/minio/credentials/Credentials;
    .locals 6
    .param p1, "url"    # Lokhttp3/HttpUrl;
    .param p2, "tokenHeader"    # Ljava/lang/String;
    .param p3, "token"    # Ljava/lang/String;

    .line 119
    new-instance v0, Lokhttp3/Request$Builder;

    invoke-direct {v0}, Lokhttp3/Request$Builder;-><init>()V

    invoke-virtual {v0, p1}, Lokhttp3/Request$Builder;->url(Lokhttp3/HttpUrl;)Lokhttp3/Request$Builder;

    move-result-object v0

    const-string v1, "GET"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lokhttp3/Request$Builder;->method(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v0

    .line 120
    .local v0, "builder":Lokhttp3/Request$Builder;
    if-eqz p3, :cond_0

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0, p2, p3}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 121
    :cond_0
    :try_start_0
    iget-object v1, p0, Lio/minio/credentials/IamAwsProvider;->httpClient:Lokhttp3/OkHttpClient;

    invoke-virtual {v0}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v2

    invoke-virtual {v1, v2}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v1

    invoke-interface {v1}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object v1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 122
    .local v1, "response":Lokhttp3/Response;
    :try_start_1
    invoke-virtual {v1}, Lokhttp3/Response;->isSuccessful()Z

    move-result v2

    if-eqz v2, :cond_4

    .line 126
    iget-object v2, p0, Lio/minio/credentials/IamAwsProvider;->mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

    invoke-virtual {v1}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v3

    invoke-virtual {v3}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v3

    const-class v4, Lio/minio/credentials/IamAwsProvider$EcsCredentials;

    invoke-virtual {v2, v3, v4}, Lcom/fasterxml/jackson/databind/ObjectMapper;->readValue(Ljava/io/Reader;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lio/minio/credentials/IamAwsProvider$EcsCredentials;

    .line 127
    .local v2, "creds":Lio/minio/credentials/IamAwsProvider$EcsCredentials;
    invoke-virtual {v2}, Lio/minio/credentials/IamAwsProvider$EcsCredentials;->code()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_2

    invoke-virtual {v2}, Lio/minio/credentials/IamAwsProvider$EcsCredentials;->code()Ljava/lang/String;

    move-result-object v3

    const-string v4, "Success"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    goto :goto_0

    .line 128
    :cond_1
    new-instance v3, Ljava/security/ProviderException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " failed with code "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 129
    invoke-virtual {v2}, Lio/minio/credentials/IamAwsProvider$EcsCredentials;->code()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " and message "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Lio/minio/credentials/IamAwsProvider$EcsCredentials;->message()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    .end local v0    # "builder":Lokhttp3/Request$Builder;
    .end local v1    # "response":Lokhttp3/Response;
    .end local p1    # "url":Lokhttp3/HttpUrl;
    .end local p2    # "tokenHeader":Ljava/lang/String;
    .end local p3    # "token":Ljava/lang/String;
    throw v3

    .line 131
    .restart local v0    # "builder":Lokhttp3/Request$Builder;
    .restart local v1    # "response":Lokhttp3/Response;
    .restart local p1    # "url":Lokhttp3/HttpUrl;
    .restart local p2    # "tokenHeader":Ljava/lang/String;
    .restart local p3    # "token":Ljava/lang/String;
    :cond_2
    :goto_0
    invoke-virtual {v2}, Lio/minio/credentials/IamAwsProvider$EcsCredentials;->toCredentials()Lio/minio/credentials/Credentials;

    move-result-object v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 132
    if-eqz v1, :cond_3

    :try_start_2
    invoke-virtual {v1}, Lokhttp3/Response;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 131
    :cond_3
    return-object v3

    .line 123
    .end local v2    # "creds":Lio/minio/credentials/IamAwsProvider$EcsCredentials;
    :cond_4
    :try_start_3
    new-instance v2, Ljava/security/ProviderException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " failed with HTTP status code "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Lokhttp3/Response;->code()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    .end local v0    # "builder":Lokhttp3/Request$Builder;
    .end local v1    # "response":Lokhttp3/Response;
    .end local p1    # "url":Lokhttp3/HttpUrl;
    .end local p2    # "tokenHeader":Ljava/lang/String;
    .end local p3    # "token":Ljava/lang/String;
    throw v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 121
    .restart local v0    # "builder":Lokhttp3/Request$Builder;
    .restart local v1    # "response":Lokhttp3/Response;
    .restart local p1    # "url":Lokhttp3/HttpUrl;
    .restart local p2    # "tokenHeader":Ljava/lang/String;
    .restart local p3    # "token":Ljava/lang/String;
    :catchall_0
    move-exception v2

    if-eqz v1, :cond_5

    :try_start_4
    invoke-virtual {v1}, Lokhttp3/Response;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v3

    :try_start_5
    invoke-virtual {v2, v3}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "builder":Lokhttp3/Request$Builder;
    .end local p1    # "url":Lokhttp3/HttpUrl;
    .end local p2    # "tokenHeader":Ljava/lang/String;
    .end local p3    # "token":Ljava/lang/String;
    :cond_5
    :goto_1
    throw v2
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_0

    .line 132
    .end local v1    # "response":Lokhttp3/Response;
    .restart local v0    # "builder":Lokhttp3/Request$Builder;
    .restart local p1    # "url":Lokhttp3/HttpUrl;
    .restart local p2    # "tokenHeader":Ljava/lang/String;
    .restart local p3    # "token":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 133
    .local v1, "e":Ljava/io/IOException;
    new-instance v2, Ljava/security/ProviderException;

    const-string v3, "Unable to parse response"

    invoke-direct {v2, v3, v1}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2
.end method

.method private fetchImdsToken()Ljava/lang/String;
    .locals 6

    .line 138
    iget-object v0, p0, Lio/minio/credentials/IamAwsProvider;->customEndpoint:Lokhttp3/HttpUrl;

    .line 139
    .local v0, "url":Lokhttp3/HttpUrl;
    if-nez v0, :cond_0

    .line 140
    const-string v1, "http://169.254.169.254/latest/api/token"

    invoke-static {v1}, Lokhttp3/HttpUrl;->parse(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v0

    goto :goto_0

    .line 142
    :cond_0
    new-instance v1, Lokhttp3/HttpUrl$Builder;

    invoke-direct {v1}, Lokhttp3/HttpUrl$Builder;-><init>()V

    .line 144
    invoke-virtual {v0}, Lokhttp3/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lokhttp3/HttpUrl$Builder;->scheme(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 145
    invoke-virtual {v0}, Lokhttp3/HttpUrl;->host()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lokhttp3/HttpUrl$Builder;->host(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 146
    const-string v2, "latest/api/token"

    invoke-virtual {v1, v2}, Lokhttp3/HttpUrl$Builder;->addPathSegments(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 147
    invoke-virtual {v1}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v0

    .line 149
    :goto_0
    const-string v1, ""

    .line 150
    .local v1, "token":Ljava/lang/String;
    new-instance v2, Lokhttp3/Request$Builder;

    invoke-direct {v2}, Lokhttp3/Request$Builder;-><init>()V

    .line 152
    invoke-virtual {v2, v0}, Lokhttp3/Request$Builder;->url(Lokhttp3/HttpUrl;)Lokhttp3/Request$Builder;

    move-result-object v2

    const/4 v3, 0x0

    new-array v3, v3, [B

    .line 154
    const/4 v4, 0x0

    invoke-static {v4, v3}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;[B)Lokhttp3/RequestBody;

    move-result-object v3

    const-string v4, "PUT"

    invoke-virtual {v2, v4, v3}, Lokhttp3/Request$Builder;->method(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v2

    .line 155
    const-string v3, "X-aws-ec2-metadata-token-ttl-seconds"

    const-string v4, "21600"

    invoke-virtual {v2, v3, v4}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v2

    .line 156
    invoke-virtual {v2}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v2

    .line 157
    .local v2, "request":Lokhttp3/Request;
    :try_start_0
    iget-object v3, p0, Lio/minio/credentials/IamAwsProvider;->httpClient:Lokhttp3/OkHttpClient;

    invoke-virtual {v3, v2}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v3

    invoke-interface {v3}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object v3
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 158
    .local v3, "response":Lokhttp3/Response;
    :try_start_1
    invoke-virtual {v3}, Lokhttp3/Response;->isSuccessful()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-virtual {v3}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v4

    invoke-virtual {v4}, Lokhttp3/ResponseBody;->string()Ljava/lang/String;

    move-result-object v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object v1, v4

    .line 159
    :cond_1
    if-eqz v3, :cond_2

    :try_start_2
    invoke-virtual {v3}, Lokhttp3/Response;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 161
    .end local v3    # "response":Lokhttp3/Response;
    :cond_2
    goto :goto_2

    .line 157
    .restart local v3    # "response":Lokhttp3/Response;
    :catchall_0
    move-exception v4

    if-eqz v3, :cond_3

    :try_start_3
    invoke-virtual {v3}, Lokhttp3/Response;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v5

    :try_start_4
    invoke-virtual {v4, v5}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "url":Lokhttp3/HttpUrl;
    .end local v1    # "token":Ljava/lang/String;
    .end local v2    # "request":Lokhttp3/Request;
    :cond_3
    :goto_1
    throw v4
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    .line 159
    .end local v3    # "response":Lokhttp3/Response;
    .restart local v0    # "url":Lokhttp3/HttpUrl;
    .restart local v1    # "token":Ljava/lang/String;
    .restart local v2    # "request":Lokhttp3/Request;
    :catch_0
    move-exception v3

    .line 160
    .local v3, "e":Ljava/io/IOException;
    const-string v1, ""

    .line 162
    .end local v3    # "e":Ljava/io/IOException;
    :goto_2
    return-object v1
.end method

.method private getIamRoleName(Lokhttp3/HttpUrl;Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p1, "url"    # Lokhttp3/HttpUrl;
    .param p2, "token"    # Ljava/lang/String;

    .line 166
    const/4 v0, 0x0

    .line 167
    .local v0, "roleNames":[Ljava/lang/String;
    new-instance v1, Lokhttp3/Request$Builder;

    invoke-direct {v1}, Lokhttp3/Request$Builder;-><init>()V

    invoke-virtual {v1, p1}, Lokhttp3/Request$Builder;->url(Lokhttp3/HttpUrl;)Lokhttp3/Request$Builder;

    move-result-object v1

    const-string v2, "GET"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lokhttp3/Request$Builder;->method(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v1

    .line 168
    .local v1, "builder":Lokhttp3/Request$Builder;
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "X-aws-ec2-metadata-token"

    invoke-virtual {v1, v2, p2}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 169
    :cond_0
    :try_start_0
    iget-object v2, p0, Lio/minio/credentials/IamAwsProvider;->httpClient:Lokhttp3/OkHttpClient;

    invoke-virtual {v1}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v3

    invoke-virtual {v2, v3}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v2

    invoke-interface {v2}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object v2
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 170
    .local v2, "response":Lokhttp3/Response;
    :try_start_1
    invoke-virtual {v2}, Lokhttp3/Response;->isSuccessful()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 174
    invoke-virtual {v2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v3

    invoke-virtual {v3}, Lokhttp3/ResponseBody;->string()Ljava/lang/String;

    move-result-object v3

    const-string v4, "\\R"

    invoke-virtual {v3, v4}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object v0, v3

    .line 175
    if-eqz v2, :cond_1

    :try_start_2
    invoke-virtual {v2}, Lokhttp3/Response;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 177
    .end local v2    # "response":Lokhttp3/Response;
    :cond_1
    nop

    .line 179
    array-length v2, v0

    if-eqz v2, :cond_2

    .line 183
    const/4 v2, 0x0

    aget-object v2, v0, v2

    return-object v2

    .line 180
    :cond_2
    new-instance v2, Ljava/security/ProviderException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "No IAM roles attached to EC2 service "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 171
    .restart local v2    # "response":Lokhttp3/Response;
    :cond_3
    :try_start_3
    new-instance v3, Ljava/security/ProviderException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " failed with HTTP status code "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Lokhttp3/Response;->code()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;)V

    .end local v0    # "roleNames":[Ljava/lang/String;
    .end local v1    # "builder":Lokhttp3/Request$Builder;
    .end local v2    # "response":Lokhttp3/Response;
    .end local p1    # "url":Lokhttp3/HttpUrl;
    .end local p2    # "token":Ljava/lang/String;
    throw v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 169
    .restart local v0    # "roleNames":[Ljava/lang/String;
    .restart local v1    # "builder":Lokhttp3/Request$Builder;
    .restart local v2    # "response":Lokhttp3/Response;
    .restart local p1    # "url":Lokhttp3/HttpUrl;
    .restart local p2    # "token":Ljava/lang/String;
    :catchall_0
    move-exception v3

    if-eqz v2, :cond_4

    :try_start_4
    invoke-virtual {v2}, Lokhttp3/Response;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v4

    :try_start_5
    invoke-virtual {v3, v4}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    .end local v0    # "roleNames":[Ljava/lang/String;
    .end local v1    # "builder":Lokhttp3/Request$Builder;
    .end local p1    # "url":Lokhttp3/HttpUrl;
    .end local p2    # "token":Ljava/lang/String;
    :cond_4
    :goto_0
    throw v3
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_0

    .line 175
    .end local v2    # "response":Lokhttp3/Response;
    .restart local v0    # "roleNames":[Ljava/lang/String;
    .restart local v1    # "builder":Lokhttp3/Request$Builder;
    .restart local p1    # "url":Lokhttp3/HttpUrl;
    .restart local p2    # "token":Ljava/lang/String;
    :catch_0
    move-exception v2

    .line 176
    .local v2, "e":Ljava/io/IOException;
    new-instance v3, Ljava/security/ProviderException;

    const-string v4, "Unable to parse response"

    invoke-direct {v3, v4, v2}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v3
.end method

.method private getIamRoleNamedUrl(Ljava/lang/String;)Lokhttp3/HttpUrl;
    .locals 3
    .param p1, "token"    # Ljava/lang/String;

    .line 187
    iget-object v0, p0, Lio/minio/credentials/IamAwsProvider;->customEndpoint:Lokhttp3/HttpUrl;

    .line 188
    .local v0, "url":Lokhttp3/HttpUrl;
    if-nez v0, :cond_0

    .line 189
    const-string v1, "http://169.254.169.254/latest/meta-data/iam/security-credentials/"

    invoke-static {v1}, Lokhttp3/HttpUrl;->parse(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v0

    goto :goto_0

    .line 191
    :cond_0
    new-instance v1, Lokhttp3/HttpUrl$Builder;

    invoke-direct {v1}, Lokhttp3/HttpUrl$Builder;-><init>()V

    .line 193
    invoke-virtual {v0}, Lokhttp3/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lokhttp3/HttpUrl$Builder;->scheme(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 194
    invoke-virtual {v0}, Lokhttp3/HttpUrl;->host()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lokhttp3/HttpUrl$Builder;->host(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 195
    const-string v2, "latest/meta-data/iam/security-credentials/"

    invoke-virtual {v1, v2}, Lokhttp3/HttpUrl$Builder;->addPathSegments(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 196
    invoke-virtual {v1}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v0

    .line 199
    :goto_0
    invoke-direct {p0, v0, p1}, Lio/minio/credentials/IamAwsProvider;->getIamRoleName(Lokhttp3/HttpUrl;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 200
    .local v1, "roleName":Ljava/lang/String;
    invoke-virtual {v0}, Lokhttp3/HttpUrl;->newBuilder()Lokhttp3/HttpUrl$Builder;

    move-result-object v2

    invoke-virtual {v2, v1}, Lokhttp3/HttpUrl$Builder;->addPathSegment(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v2

    return-object v2
.end method

.method static synthetic lambda$fetchCredentials$0(Ljava/lang/String;)Lio/minio/credentials/Jwt;
    .locals 5
    .param p0, "tokenFile"    # Ljava/lang/String;

    .line 102
    const/4 v0, 0x0

    :try_start_0
    new-array v1, v0, [Ljava/lang/String;

    invoke-static {p0, v1}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v1

    invoke-static {v1}, Ljava/nio/file/Files;->readAllBytes(Ljava/nio/file/Path;)[B

    move-result-object v1

    .line 103
    .local v1, "data":[B
    new-instance v2, Lio/minio/credentials/Jwt;

    new-instance v3, Ljava/lang/String;

    sget-object v4, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v3, v1, v4}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    invoke-direct {v2, v3, v0}, Lio/minio/credentials/Jwt;-><init>(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 104
    .end local v1    # "data":[B
    :catch_0
    move-exception v0

    .line 105
    .local v0, "e":Ljava/io/IOException;
    new-instance v1, Ljava/security/ProviderException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error in reading file "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method


# virtual methods
.method public declared-synchronized fetch()Lio/minio/credentials/Credentials;
    .locals 6

    monitor-enter p0

    .line 205
    :try_start_0
    iget-object v0, p0, Lio/minio/credentials/IamAwsProvider;->credentials:Lio/minio/credentials/Credentials;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/credentials/IamAwsProvider;->credentials:Lio/minio/credentials/Credentials;

    invoke-virtual {v0}, Lio/minio/credentials/Credentials;->isExpired()Z

    move-result v0

    if-nez v0, :cond_0

    .line 206
    iget-object v0, p0, Lio/minio/credentials/IamAwsProvider;->credentials:Lio/minio/credentials/Credentials;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 209
    .end local p0    # "this":Lio/minio/credentials/IamAwsProvider;
    :cond_0
    :try_start_1
    iget-object v0, p0, Lio/minio/credentials/IamAwsProvider;->customEndpoint:Lokhttp3/HttpUrl;

    .line 210
    .local v0, "url":Lokhttp3/HttpUrl;
    const-string v1, "AWS_WEB_IDENTITY_TOKEN_FILE"

    invoke-virtual {p0, v1}, Lio/minio/credentials/IamAwsProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 211
    .local v1, "tokenFile":Ljava/lang/String;
    if-eqz v1, :cond_1

    .line 212
    invoke-direct {p0, v1}, Lio/minio/credentials/IamAwsProvider;->fetchCredentials(Ljava/lang/String;)Lio/minio/credentials/Credentials;

    move-result-object v2

    iput-object v2, p0, Lio/minio/credentials/IamAwsProvider;->credentials:Lio/minio/credentials/Credentials;

    .line 213
    iget-object v2, p0, Lio/minio/credentials/IamAwsProvider;->credentials:Lio/minio/credentials/Credentials;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-object v2

    .line 216
    :cond_1
    :try_start_2
    const-string v2, "Authorization"

    .line 217
    .local v2, "tokenHeader":Ljava/lang/String;
    const-string v3, "AWS_CONTAINER_AUTHORIZATION_TOKEN"

    invoke-virtual {p0, v3}, Lio/minio/credentials/IamAwsProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 218
    .local v3, "token":Ljava/lang/String;
    const-string v4, "AWS_CONTAINER_CREDENTIALS_RELATIVE_URI"

    invoke-virtual {p0, v4}, Lio/minio/credentials/IamAwsProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_2

    .line 219
    if-nez v0, :cond_5

    .line 220
    new-instance v4, Lokhttp3/HttpUrl$Builder;

    invoke-direct {v4}, Lokhttp3/HttpUrl$Builder;-><init>()V

    const-string v5, "http"

    .line 222
    invoke-virtual {v4, v5}, Lokhttp3/HttpUrl$Builder;->scheme(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v4

    const-string v5, "169.254.170.2"

    .line 223
    invoke-virtual {v4, v5}, Lokhttp3/HttpUrl$Builder;->host(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v4

    const-string v5, "AWS_CONTAINER_CREDENTIALS_RELATIVE_URI"

    .line 224
    invoke-virtual {p0, v5}, Lio/minio/credentials/IamAwsProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Lokhttp3/HttpUrl$Builder;->addPathSegments(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v4

    .line 225
    invoke-virtual {v4}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v4

    move-object v0, v4

    goto :goto_0

    .line 227
    :cond_2
    const-string v4, "AWS_CONTAINER_CREDENTIALS_FULL_URI"

    invoke-virtual {p0, v4}, Lio/minio/credentials/IamAwsProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_4

    .line 228
    if-nez v0, :cond_3

    .line 229
    const-string v4, "AWS_CONTAINER_CREDENTIALS_FULL_URI"

    invoke-virtual {p0, v4}, Lio/minio/credentials/IamAwsProvider;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lokhttp3/HttpUrl;->parse(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v4

    move-object v0, v4

    .line 231
    :cond_3
    invoke-direct {p0, v0}, Lio/minio/credentials/IamAwsProvider;->checkLoopbackHost(Lokhttp3/HttpUrl;)V

    goto :goto_0

    .line 233
    :cond_4
    invoke-direct {p0}, Lio/minio/credentials/IamAwsProvider;->fetchImdsToken()Ljava/lang/String;

    move-result-object v4

    move-object v3, v4

    .line 234
    const-string v4, "X-aws-ec2-metadata-token"

    move-object v2, v4

    .line 235
    invoke-direct {p0, v3}, Lio/minio/credentials/IamAwsProvider;->getIamRoleNamedUrl(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v4

    move-object v0, v4

    .line 238
    :cond_5
    :goto_0
    invoke-direct {p0, v0, v2, v3}, Lio/minio/credentials/IamAwsProvider;->fetchCredentials(Lokhttp3/HttpUrl;Ljava/lang/String;Ljava/lang/String;)Lio/minio/credentials/Credentials;

    move-result-object v4

    iput-object v4, p0, Lio/minio/credentials/IamAwsProvider;->credentials:Lio/minio/credentials/Credentials;

    .line 239
    iget-object v4, p0, Lio/minio/credentials/IamAwsProvider;->credentials:Lio/minio/credentials/Credentials;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit p0

    return-object v4

    .line 204
    .end local v0    # "url":Lokhttp3/HttpUrl;
    .end local v1    # "tokenFile":Ljava/lang/String;
    .end local v2    # "tokenHeader":Ljava/lang/String;
    .end local v3    # "token":Ljava/lang/String;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
