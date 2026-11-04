.class public Lio/minio/credentials/AssumeRoleProvider;
.super Lio/minio/credentials/AssumeRoleBaseProvider;
.source "AssumeRoleProvider.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/credentials/AssumeRoleProvider$AssumeRoleResponse;
    }
.end annotation


# instance fields
.field private final accessKey:Ljava/lang/String;

.field private final contentSha256:Ljava/lang/String;

.field private final region:Ljava/lang/String;

.field private final request:Lokhttp3/Request;

.field private final secretKey:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/OkHttpClient;)V
    .locals 15
    .param p1, "stsEndpoint"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "accessKey"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p3, "secretKey"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p4, "durationSeconds"    # Ljava/lang/Integer;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p5, "policy"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p6, "region"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p7, "roleArn"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p8, "roleSessionName"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p9, "externalId"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p10, "customHttpClient"    # Lokhttp3/OkHttpClient;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 66
    move-object v7, p0

    move-object/from16 v8, p9

    move-object/from16 v9, p10

    invoke-direct {p0, v9}, Lio/minio/credentials/AssumeRoleBaseProvider;-><init>(Lokhttp3/OkHttpClient;)V

    .line 67
    const-string v0, "STS endpoint cannot be empty"

    move-object/from16 v1, p1

    invoke-static {v1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    move-object v10, v0

    check-cast v10, Ljava/lang/String;

    .line 68
    .end local p1    # "stsEndpoint":Ljava/lang/String;
    .local v10, "stsEndpoint":Ljava/lang/String;
    invoke-static {v10}, Lokhttp3/HttpUrl;->parse(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v0

    const-string v1, "Invalid STS endpoint"

    invoke-static {v0, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    move-object v11, v0

    check-cast v11, Lokhttp3/HttpUrl;

    .line 69
    .local v11, "url":Lokhttp3/HttpUrl;
    const-string v0, "Access key must not be null"

    move-object/from16 v1, p2

    invoke-static {v1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    move-object v12, v0

    check-cast v12, Ljava/lang/String;

    .line 70
    .end local p2    # "accessKey":Ljava/lang/String;
    .local v12, "accessKey":Ljava/lang/String;
    invoke-virtual {v12}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_7

    .line 73
    iput-object v12, v7, Lio/minio/credentials/AssumeRoleProvider;->accessKey:Ljava/lang/String;

    .line 74
    const-string v0, "Secret key must not be null"

    move-object/from16 v13, p3

    invoke-static {v13, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, v7, Lio/minio/credentials/AssumeRoleProvider;->secretKey:Ljava/lang/String;

    .line 75
    if-eqz p6, :cond_0

    move-object/from16 v0, p6

    goto :goto_0

    :cond_0
    const-string v0, ""

    :goto_0
    iput-object v0, v7, Lio/minio/credentials/AssumeRoleProvider;->region:Ljava/lang/String;

    .line 77
    if-eqz v8, :cond_2

    invoke-virtual/range {p9 .. p9}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x2

    if-lt v0, v1, :cond_1

    invoke-virtual/range {p9 .. p9}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x4c8

    if-gt v0, v1, :cond_1

    goto :goto_1

    .line 78
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Length of ExternalId must be in between 2 and 1224"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 81
    :cond_2
    :goto_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11}, Lokhttp3/HttpUrl;->host()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v11}, Lokhttp3/HttpUrl;->port()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 83
    .local v0, "host":Ljava/lang/String;
    invoke-virtual {v11}, Lokhttp3/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object v1

    const-string v2, "http"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-virtual {v11}, Lokhttp3/HttpUrl;->port()I

    move-result v1

    const/16 v2, 0x50

    if-eq v1, v2, :cond_4

    .line 84
    :cond_3
    invoke-virtual {v11}, Lokhttp3/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object v1

    const-string v2, "https"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-virtual {v11}, Lokhttp3/HttpUrl;->port()I

    move-result v1

    const/16 v2, 0x1bb

    if-ne v1, v2, :cond_5

    .line 85
    :cond_4
    invoke-virtual {v11}, Lokhttp3/HttpUrl;->host()Ljava/lang/String;

    move-result-object v0

    move-object v14, v0

    goto :goto_2

    .line 88
    :cond_5
    move-object v14, v0

    .end local v0    # "host":Ljava/lang/String;
    .local v14, "host":Ljava/lang/String;
    :goto_2
    nop

    .line 92
    invoke-static/range {p4 .. p4}, Lio/minio/credentials/AssumeRoleProvider;->getValidDurationSeconds(Ljava/lang/Integer;)I

    move-result v3

    .line 89
    const-string v2, "AssumeRole"

    move-object v0, p0

    move-object v1, v11

    move-object/from16 v4, p5

    move-object/from16 v5, p7

    move-object/from16 v6, p8

    invoke-virtual/range {v0 .. v6}, Lio/minio/credentials/AssumeRoleProvider;->newUrlBuilder(Lokhttp3/HttpUrl;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v0

    .line 96
    .local v0, "urlBuilder":Lokhttp3/HttpUrl$Builder;
    if-eqz v8, :cond_6

    .line 97
    const-string v1, "ExternalId"

    invoke-virtual {v0, v1, v8}, Lokhttp3/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 100
    :cond_6
    invoke-virtual {v0}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/HttpUrl;->encodedQuery()Ljava/lang/String;

    move-result-object v1

    .line 101
    .local v1, "data":Ljava/lang/String;
    invoke-static {v1}, Lio/minio/Digest;->sha256Hash(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v7, Lio/minio/credentials/AssumeRoleProvider;->contentSha256:Ljava/lang/String;

    .line 102
    new-instance v2, Lokhttp3/Request$Builder;

    invoke-direct {v2}, Lokhttp3/Request$Builder;-><init>()V

    .line 104
    invoke-virtual {v2, v11}, Lokhttp3/Request$Builder;->url(Lokhttp3/HttpUrl;)Lokhttp3/Request$Builder;

    move-result-object v2

    .line 105
    const-string v3, "Host"

    invoke-virtual {v2, v3, v14}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v2

    .line 109
    const-string v3, "application/x-www-form-urlencoded"

    invoke-static {v3}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v3

    invoke-static {v3, v1}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;Ljava/lang/String;)Lokhttp3/RequestBody;

    move-result-object v3

    .line 106
    const-string v4, "POST"

    invoke-virtual {v2, v4, v3}, Lokhttp3/Request$Builder;->method(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v2

    .line 110
    invoke-virtual {v2}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v2

    iput-object v2, v7, Lio/minio/credentials/AssumeRoleProvider;->request:Lokhttp3/Request;

    .line 111
    return-void

    .line 71
    .end local v0    # "urlBuilder":Lokhttp3/HttpUrl$Builder;
    .end local v1    # "data":Ljava/lang/String;
    .end local v14    # "host":Ljava/lang/String;
    :cond_7
    move-object/from16 v13, p3

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Access key must not be empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method protected getRequest()Lokhttp3/Request;
    .locals 5

    .line 116
    :try_start_0
    iget-object v0, p0, Lio/minio/credentials/AssumeRoleProvider;->request:Lokhttp3/Request;

    .line 118
    invoke-virtual {v0}, Lokhttp3/Request;->newBuilder()Lokhttp3/Request$Builder;

    move-result-object v0

    const-string/jumbo v1, "x-amz-date"

    .line 119
    invoke-static {}, Ljava/time/ZonedDateTime;->now()Ljava/time/ZonedDateTime;

    move-result-object v2

    sget-object v3, Lio/minio/Time;->AMZ_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-virtual {v2, v3}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v0

    .line 120
    invoke-virtual {v0}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v0

    iget-object v1, p0, Lio/minio/credentials/AssumeRoleProvider;->region:Ljava/lang/String;

    iget-object v2, p0, Lio/minio/credentials/AssumeRoleProvider;->accessKey:Ljava/lang/String;

    iget-object v3, p0, Lio/minio/credentials/AssumeRoleProvider;->secretKey:Ljava/lang/String;

    iget-object v4, p0, Lio/minio/credentials/AssumeRoleProvider;->contentSha256:Ljava/lang/String;

    .line 116
    invoke-static {v0, v1, v2, v3, v4}, Lio/minio/Signer;->signV4Sts(Lokhttp3/Request;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request;

    move-result-object v0
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 125
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 126
    .local v0, "e":Ljava/security/GeneralSecurityException;
    :goto_0
    new-instance v1, Ljava/security/ProviderException;

    const-string v2, "Signature calculation failed"

    invoke-direct {v1, v2, v0}, Ljava/security/ProviderException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected getResponseClass()Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "+",
            "Lio/minio/credentials/AssumeRoleBaseProvider$Response;",
            ">;"
        }
    .end annotation

    .line 132
    const-class v0, Lio/minio/credentials/AssumeRoleProvider$AssumeRoleResponse;

    return-object v0
.end method
