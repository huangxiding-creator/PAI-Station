.class public Lio/minio/credentials/CertificateIdentityProvider;
.super Lio/minio/credentials/AssumeRoleBaseProvider;
.source "CertificateIdentityProvider.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/credentials/CertificateIdentityProvider$CertificateIdentityResponse;
    }
.end annotation


# static fields
.field private static final EMPTY_BODY:Lokhttp3/RequestBody;


# instance fields
.field private final request:Lokhttp3/Request;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 45
    nop

    .line 47
    const-string v0, "application/octet-stream"

    invoke-static {v0}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [B

    invoke-static {v0, v1}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;[B)Lokhttp3/RequestBody;

    move-result-object v0

    sput-object v0, Lio/minio/credentials/CertificateIdentityProvider;->EMPTY_BODY:Lokhttp3/RequestBody;

    .line 45
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;Ljava/lang/Integer;Lokhttp3/OkHttpClient;)V
    .locals 8
    .param p1, "stsEndpoint"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "sslSocketFactory"    # Ljavax/net/ssl/SSLSocketFactory;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p3, "trustManager"    # Ljavax/net/ssl/X509TrustManager;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p4, "durationSeconds"    # Ljava/lang/Integer;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p5, "customHttpClient"    # Lokhttp3/OkHttpClient;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/GeneralSecurityException;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 57
    invoke-direct {p0, p5, p2, p3}, Lio/minio/credentials/AssumeRoleBaseProvider;-><init>(Lokhttp3/OkHttpClient;Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)V

    .line 58
    const-string v0, "STS endpoint cannot be empty"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    move-object p1, v0

    check-cast p1, Ljava/lang/String;

    .line 59
    invoke-static {p1}, Lokhttp3/HttpUrl;->parse(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v0

    const-string v1, "Invalid STS endpoint"

    invoke-static {v0, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/HttpUrl;

    .line 60
    .local v0, "url":Lokhttp3/HttpUrl;
    invoke-virtual {v0}, Lokhttp3/HttpUrl;->isHttps()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 64
    nop

    .line 68
    invoke-static {p4}, Lio/minio/credentials/CertificateIdentityProvider;->getValidDurationSeconds(Ljava/lang/Integer;)I

    move-result v4

    .line 65
    const-string v3, "AssumeRoleWithCertificate"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v1, p0

    move-object v2, v0

    invoke-virtual/range {v1 .. v7}, Lio/minio/credentials/CertificateIdentityProvider;->newUrlBuilder(Lokhttp3/HttpUrl;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 72
    .local v1, "urlBuilder":Lokhttp3/HttpUrl$Builder;
    invoke-virtual {v1}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v0

    .line 73
    new-instance v2, Lokhttp3/Request$Builder;

    invoke-direct {v2}, Lokhttp3/Request$Builder;-><init>()V

    invoke-virtual {v2, v0}, Lokhttp3/Request$Builder;->url(Lokhttp3/HttpUrl;)Lokhttp3/Request$Builder;

    move-result-object v2

    const-string v3, "POST"

    sget-object v4, Lio/minio/credentials/CertificateIdentityProvider;->EMPTY_BODY:Lokhttp3/RequestBody;

    invoke-virtual {v2, v3, v4}, Lokhttp3/Request$Builder;->method(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v2

    iput-object v2, p0, Lio/minio/credentials/CertificateIdentityProvider;->request:Lokhttp3/Request;

    .line 74
    return-void

    .line 61
    .end local v1    # "urlBuilder":Lokhttp3/HttpUrl$Builder;
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "STS endpoint scheme must be HTTPS"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method


# virtual methods
.method protected getRequest()Lokhttp3/Request;
    .locals 1

    .line 78
    iget-object v0, p0, Lio/minio/credentials/CertificateIdentityProvider;->request:Lokhttp3/Request;

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

    .line 83
    const-class v0, Lio/minio/credentials/CertificateIdentityProvider$CertificateIdentityResponse;

    return-object v0
.end method
