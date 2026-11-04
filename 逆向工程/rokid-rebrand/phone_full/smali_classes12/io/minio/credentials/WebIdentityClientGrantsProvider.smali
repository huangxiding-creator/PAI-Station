.class public abstract Lio/minio/credentials/WebIdentityClientGrantsProvider;
.super Lio/minio/credentials/AssumeRoleBaseProvider;
.source "WebIdentityClientGrantsProvider.java"


# static fields
.field private static final EMPTY_BODY:Lokhttp3/RequestBody;

.field public static final MAX_DURATION_SECONDS:I

.field public static final MIN_DURATION_SECONDS:I


# instance fields
.field protected final durationSeconds:Ljava/lang/Integer;

.field protected final policy:Ljava/lang/String;

.field protected final roleArn:Ljava/lang/String;

.field protected final roleSessionName:Ljava/lang/String;

.field protected final stsEndpoint:Lokhttp3/HttpUrl;

.field private final supplier:Ljava/util/function/Supplier;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/function/Supplier<",
            "Lio/minio/credentials/Jwt;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 32
    sget-object v0, Ljava/util/concurrent/TimeUnit;->MINUTES:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v1, 0xf

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/TimeUnit;->toSeconds(J)J

    move-result-wide v0

    long-to-int v0, v0

    sput v0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->MIN_DURATION_SECONDS:I

    .line 33
    sget-object v0, Ljava/util/concurrent/TimeUnit;->DAYS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v1, 0x7

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/TimeUnit;->toSeconds(J)J

    move-result-wide v0

    long-to-int v0, v0

    sput v0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->MAX_DURATION_SECONDS:I

    .line 34
    nop

    .line 36
    const-string v0, "application/octet-stream"

    invoke-static {v0}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [B

    invoke-static {v0, v1}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;[B)Lokhttp3/RequestBody;

    move-result-object v0

    sput-object v0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->EMPTY_BODY:Lokhttp3/RequestBody;

    .line 34
    return-void
.end method

.method public constructor <init>(Ljava/util/function/Supplier;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/OkHttpClient;)V
    .locals 2
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

    .line 52
    .local p1, "supplier":Ljava/util/function/Supplier;, "Ljava/util/function/Supplier<Lio/minio/credentials/Jwt;>;"
    invoke-direct {p0, p7}, Lio/minio/credentials/AssumeRoleBaseProvider;-><init>(Lokhttp3/OkHttpClient;)V

    .line 53
    const-string v0, "JWT token supplier must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/function/Supplier;

    iput-object v0, p0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->supplier:Ljava/util/function/Supplier;

    .line 54
    const-string v0, "STS endpoint cannot be empty"

    invoke-static {p2, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    move-object p2, v0

    check-cast p2, Ljava/lang/String;

    .line 55
    invoke-static {p2}, Lokhttp3/HttpUrl;->parse(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v0

    const-string v1, "Invalid STS endpoint"

    invoke-static {v0, v1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/HttpUrl;

    iput-object v0, p0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->stsEndpoint:Lokhttp3/HttpUrl;

    .line 56
    iput-object p3, p0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->durationSeconds:Ljava/lang/Integer;

    .line 57
    iput-object p4, p0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->policy:Ljava/lang/String;

    .line 58
    iput-object p5, p0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->roleArn:Ljava/lang/String;

    .line 59
    iput-object p6, p0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->roleSessionName:Ljava/lang/String;

    .line 60
    return-void
.end method


# virtual methods
.method protected getDurationSeconds(I)I
    .locals 1
    .param p1, "expiry"    # I

    .line 63
    iget-object v0, p0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->durationSeconds:Ljava/lang/Integer;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->durationSeconds:Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-lez v0, :cond_0

    .line 64
    iget-object v0, p0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->durationSeconds:Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result p1

    .line 67
    :cond_0
    sget v0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->MAX_DURATION_SECONDS:I

    if-le p1, v0, :cond_1

    .line 68
    sget v0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->MAX_DURATION_SECONDS:I

    return v0

    .line 71
    :cond_1
    if-gtz p1, :cond_2

    .line 72
    return p1

    .line 75
    :cond_2
    sget v0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->MIN_DURATION_SECONDS:I

    if-ge p1, v0, :cond_3

    sget v0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->MIN_DURATION_SECONDS:I

    goto :goto_0

    :cond_3
    move v0, p1

    :goto_0
    return v0
.end method

.method protected getRequest()Lokhttp3/Request;
    .locals 5

    .line 80
    iget-object v0, p0, Lio/minio/credentials/WebIdentityClientGrantsProvider;->supplier:Ljava/util/function/Supplier;

    invoke-interface {v0}, Ljava/util/function/Supplier;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/credentials/Jwt;

    .line 81
    .local v0, "jwt":Lio/minio/credentials/Jwt;
    invoke-virtual {p0, v0}, Lio/minio/credentials/WebIdentityClientGrantsProvider;->newUrlBuilder(Lio/minio/credentials/Jwt;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 82
    .local v1, "urlBuilder":Lokhttp3/HttpUrl$Builder;
    new-instance v2, Lokhttp3/Request$Builder;

    invoke-direct {v2}, Lokhttp3/Request$Builder;-><init>()V

    invoke-virtual {v1}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v3

    invoke-virtual {v2, v3}, Lokhttp3/Request$Builder;->url(Lokhttp3/HttpUrl;)Lokhttp3/Request$Builder;

    move-result-object v2

    const-string v3, "POST"

    sget-object v4, Lio/minio/credentials/WebIdentityClientGrantsProvider;->EMPTY_BODY:Lokhttp3/RequestBody;

    invoke-virtual {v2, v3, v4}, Lokhttp3/Request$Builder;->method(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v2

    return-object v2
.end method

.method protected abstract newUrlBuilder(Lio/minio/credentials/Jwt;)Lokhttp3/HttpUrl$Builder;
.end method
