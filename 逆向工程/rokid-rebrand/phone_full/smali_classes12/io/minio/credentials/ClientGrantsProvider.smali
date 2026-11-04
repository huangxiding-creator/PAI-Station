.class public Lio/minio/credentials/ClientGrantsProvider;
.super Lio/minio/credentials/WebIdentityClientGrantsProvider;
.source "ClientGrantsProvider.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/credentials/ClientGrantsProvider$ClientGrantsResponse;
    }
.end annotation


# direct methods
.method public constructor <init>(Ljava/util/function/Supplier;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Lokhttp3/OkHttpClient;)V
    .locals 8
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
    .param p5, "customHttpClient"    # Lokhttp3/OkHttpClient;
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
            "Lokhttp3/OkHttpClient;",
            ")V"
        }
    .end annotation

    .line 44
    .local p1, "supplier":Ljava/util/function/Supplier;, "Ljava/util/function/Supplier<Lio/minio/credentials/Jwt;>;"
    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v7, p5

    invoke-direct/range {v0 .. v7}, Lio/minio/credentials/WebIdentityClientGrantsProvider;-><init>(Ljava/util/function/Supplier;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/OkHttpClient;)V

    .line 45
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

    .line 62
    const-class v0, Lio/minio/credentials/ClientGrantsProvider$ClientGrantsResponse;

    return-object v0
.end method

.method protected newUrlBuilder(Lio/minio/credentials/Jwt;)Lokhttp3/HttpUrl$Builder;
    .locals 7
    .param p1, "jwt"    # Lio/minio/credentials/Jwt;

    .line 49
    iget-object v1, p0, Lio/minio/credentials/ClientGrantsProvider;->stsEndpoint:Lokhttp3/HttpUrl;

    .line 53
    invoke-virtual {p1}, Lio/minio/credentials/Jwt;->expiry()I

    move-result v0

    invoke-virtual {p0, v0}, Lio/minio/credentials/ClientGrantsProvider;->getDurationSeconds(I)I

    move-result v3

    iget-object v4, p0, Lio/minio/credentials/ClientGrantsProvider;->policy:Ljava/lang/String;

    .line 50
    const-string v2, "AssumeRoleWithClientGrants"

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    invoke-virtual/range {v0 .. v6}, Lio/minio/credentials/ClientGrantsProvider;->newUrlBuilder(Lokhttp3/HttpUrl;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v0

    .line 57
    .local v0, "urlBuilder":Lokhttp3/HttpUrl$Builder;
    const-string v1, "Token"

    invoke-virtual {p1}, Lio/minio/credentials/Jwt;->token()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lokhttp3/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    return-object v1
.end method
