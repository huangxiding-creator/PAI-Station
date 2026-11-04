.class public Lio/minio/credentials/LdapIdentityProvider;
.super Lio/minio/credentials/AssumeRoleBaseProvider;
.source "LdapIdentityProvider.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/credentials/LdapIdentityProvider$LdapIdentityResponse;
    }
.end annotation


# static fields
.field private static final EMPTY_BODY:Lokhttp3/RequestBody;


# instance fields
.field private final request:Lokhttp3/Request;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 41
    nop

    .line 43
    const-string v0, "application/octet-stream"

    invoke-static {v0}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [B

    invoke-static {v0, v1}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;[B)Lokhttp3/RequestBody;

    move-result-object v0

    sput-object v0, Lio/minio/credentials/LdapIdentityProvider;->EMPTY_BODY:Lokhttp3/RequestBody;

    .line 41
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Lokhttp3/OkHttpClient;)V
    .locals 8
    .param p1, "stsEndpoint"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "ldapUsername"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p3, "ldapPassword"    # Ljava/lang/String;
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
    .param p6, "customHttpClient"    # Lokhttp3/OkHttpClient;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 53
    invoke-direct {p0, p6}, Lio/minio/credentials/AssumeRoleBaseProvider;-><init>(Lokhttp3/OkHttpClient;)V

    .line 54
    const-string v0, "STS endpoint cannot be empty"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    move-object p1, v0

    check-cast p1, Ljava/lang/String;

    .line 55
    invoke-static {p1}, Lokhttp3/HttpUrl;->parse(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v0

    const-string v1, "Invalid STS endpoint"

    invoke-static {v0, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/HttpUrl;

    .line 56
    .local v0, "url":Lokhttp3/HttpUrl;
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 59
    const-string v1, "LDAP password must not be null"

    invoke-static {p3, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    .line 61
    nop

    .line 65
    invoke-static {p4}, Lio/minio/credentials/LdapIdentityProvider;->getValidDurationSeconds(Ljava/lang/Integer;)I

    move-result v4

    .line 62
    const-string v3, "AssumeRoleWithLDAPIdentity"

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v1, p0

    move-object v2, v0

    move-object v5, p5

    invoke-virtual/range {v1 .. v7}, Lio/minio/credentials/LdapIdentityProvider;->newUrlBuilder(Lokhttp3/HttpUrl;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 69
    .local v1, "urlBuilder":Lokhttp3/HttpUrl$Builder;
    nop

    .line 71
    const-string v2, "LDAPUsername"

    invoke-virtual {v1, v2, p2}, Lokhttp3/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v2

    .line 72
    const-string v3, "LDAPPassword"

    invoke-virtual {v2, v3, p3}, Lokhttp3/HttpUrl$Builder;->addQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v2

    .line 73
    invoke-virtual {v2}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v0

    .line 74
    new-instance v2, Lokhttp3/Request$Builder;

    invoke-direct {v2}, Lokhttp3/Request$Builder;-><init>()V

    invoke-virtual {v2, v0}, Lokhttp3/Request$Builder;->url(Lokhttp3/HttpUrl;)Lokhttp3/Request$Builder;

    move-result-object v2

    const-string v3, "POST"

    sget-object v4, Lio/minio/credentials/LdapIdentityProvider;->EMPTY_BODY:Lokhttp3/RequestBody;

    invoke-virtual {v2, v3, v4}, Lokhttp3/Request$Builder;->method(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v2

    iput-object v2, p0, Lio/minio/credentials/LdapIdentityProvider;->request:Lokhttp3/Request;

    .line 75
    return-void

    .line 57
    .end local v1    # "urlBuilder":Lokhttp3/HttpUrl$Builder;
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "LDAP username must be provided"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/OkHttpClient;)V
    .locals 7
    .param p1, "stsEndpoint"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "ldapUsername"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p3, "ldapPassword"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p4, "customHttpClient"    # Lokhttp3/OkHttpClient;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 82
    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v6, p4

    invoke-direct/range {v0 .. v6}, Lio/minio/credentials/LdapIdentityProvider;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Lokhttp3/OkHttpClient;)V

    .line 83
    return-void
.end method


# virtual methods
.method protected getRequest()Lokhttp3/Request;
    .locals 1

    .line 87
    iget-object v0, p0, Lio/minio/credentials/LdapIdentityProvider;->request:Lokhttp3/Request;

    return-object v0
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

    .line 92
    const-class v0, Lio/minio/credentials/LdapIdentityProvider$LdapIdentityResponse;

    return-object v0
.end method
