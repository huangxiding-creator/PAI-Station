.class public Lio/minio/credentials/WebIdentityProvider;
.super Lio/minio/credentials/WebIdentityClientGrantsProvider;
.source "WebIdentityProvider.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/credentials/WebIdentityProvider$WebIdentityResponse;
    }
.end annotation


# direct methods
.method public constructor <init>(Ljava/util/function/Supplier;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/OkHttpClient;)V
    .locals 0
    .param p1    # Ljava/util/function/Supplier;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "stsEndpoint"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p3, "durationSeconds"    # Ljava/lang/Integer;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p4, "policy"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p5, "roleArn"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p6, "roleSessionName"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p7, "customHttpClient"    # Lokhttp3/OkHttpClient;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/function/Supplier<",
            "Lio/minio/credentials/Jwt;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lokhttp3/OkHttpClient;",
            ")V"
        }
    .end annotation

    .line 46
    .local p1, "supplier":Ljava/util/function/Supplier;, "Ljava/util/function/Supplier<Lio/minio/credentials/Jwt;>;"
    invoke-direct/range {p0 .. p7}, Lio/minio/credentials/WebIdentityClientGrantsProvider;-><init>(Ljava/util/function/Supplier;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/OkHttpClient;)V

    .line 48
    return-void
.end method


# virtual methods
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

    .line 67
    const-class v0, Lio/minio/credentials/WebIdentityProvider$WebIdentityResponse;

    return-object v0
.end method

.method protected newUrlBuilder(Lio/minio/credentials/Jwt;)Lokhttp3/HttpUrl$Builder;
    .locals 8
    .param p1, "jwt"    # Lio/minio/credentials/Jwt;

    .line 52
    iget-object v1, p0, Lio/minio/credentials/WebIdentityProvider;->stsEndpoint:Lokhttp3/HttpUrl;

    .line 56
    invoke-virtual {p1}, Lio/minio/credentials/Jwt;->expiry()I

    move-result v0

    invoke-virtual {p0, v0}, Lio/minio/credentials/WebIdentityProvider;->getDurationSeconds(I)I

    move-result v3

    iget-object v4, p0, Lio/minio/credentials/WebIdentityProvider;->policy:Ljava/lang/String;

    iget-object v5, p0, Lio/minio/credentials/WebIdentityProvider;->roleArn:Ljava/lang/String;

    .line 59
    iget-object v0, p0, Lio/minio/credentials/WebIdentityProvider;->roleArn:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/credentials/WebIdentityProvider;->roleSessionName:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 60
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    move-object v6, v0

    goto :goto_0

    .line 61
    :cond_0
    iget-object v0, p0, Lio/minio/credentials/WebIdentityProvider;->roleSessionName:Ljava/lang/String;

    move-object v6, v0

    .line 53
    :goto_0
    const-string v2, "AssumeRoleWithWebIdentity"

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lio/minio/credentials/WebIdentityProvider;->newUrlBuilder(Lokhttp3/HttpUrl;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v0

    .line 62
    .local v0, "urlBuilder":Lokhttp3/HttpUrl$Builder;
    const-string v1, "WebIdentityToken"

    invoke-virtual {p1}, Lio/minio/credentials/Jwt;->token()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lokhttp3/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    return-object v1
.end method
