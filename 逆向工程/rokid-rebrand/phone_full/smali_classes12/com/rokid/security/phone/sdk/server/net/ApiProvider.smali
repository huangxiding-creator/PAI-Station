.class public final Lcom/rokid/security/phone/sdk/server/net/ApiProvider;
.super Ljava/lang/Object;
.source "ApiProvider.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nApiProvider.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ApiProvider.kt\ncom/rokid/security/phone/sdk/server/net/ApiProvider\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,76:1\n1#2:77\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000<\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u000b\u001a\u00020\u0004J\u0006\u0010\u000c\u001a\u00020\u0006J\u000e\u0010\r\u001a\u00020\u00082\u0006\u0010\u000e\u001a\u00020\u000fJ\u0006\u0010\u0010\u001a\u00020\nJ\u0006\u0010\u0011\u001a\u00020\u0012J\u001a\u0010\u0013\u001a\u00020\u00142\u0008\u0010\u0015\u001a\u0004\u0018\u00010\u00142\u0006\u0010\u0016\u001a\u00020\u0014H\u0002J\u0010\u0010\u0017\u001a\u0004\u0018\u00010\u0014*\u0004\u0018\u00010\u0014H\u0002R\u0010\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0018"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/net/ApiProvider;",
        "",
        "()V",
        "api",
        "Lcom/rokid/security/phone/sdk/server/net/ApiService;",
        "authApi",
        "Lcom/rokid/security/phone/sdk/server/net/AuthApiService;",
        "downloadApi",
        "Lcom/rokid/security/phone/sdk/server/net/DownloadApi;",
        "ossApi",
        "Lcom/rokid/security/phone/sdk/server/net/OssApiService;",
        "getApi",
        "getAuthApi",
        "getDownloadFileApi",
        "listener",
        "Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;",
        "getOssApi",
        "refreshApi",
        "",
        "requireBaseUrl",
        "",
        "url",
        "name",
        "asValidBaseUrl",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

.field private static api:Lcom/rokid/security/phone/sdk/server/net/ApiService;

.field private static authApi:Lcom/rokid/security/phone/sdk/server/net/AuthApiService;

.field private static downloadApi:Lcom/rokid/security/phone/sdk/server/net/DownloadApi;

.field private static ossApi:Lcom/rokid/security/phone/sdk/server/net/OssApiService;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final asValidBaseUrl(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "$this$asValidBaseUrl"    # Ljava/lang/String;

    .line 24
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    move-object v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v0

    :goto_0
    if-nez v1, :cond_1

    const-string v1, ""

    .line 25
    .local v1, "value":Ljava/lang/String;
    :cond_1
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_2

    const/4 v2, 0x1

    goto :goto_1

    :cond_2
    move v2, v3

    :goto_1
    if-eqz v2, :cond_3

    .line 26
    return-object v0

    .line 28
    :cond_3
    const-string v2, "http://"

    const/4 v4, 0x2

    invoke-static {v1, v2, v3, v4, v0}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_4

    const-string v2, "https://"

    invoke-static {v1, v2, v3, v4, v0}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    :cond_4
    move-object v0, v1

    :cond_5
    return-object v0
.end method

.method private final requireBaseUrl(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "name"    # Ljava/lang/String;

    .line 32
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->asValidBaseUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    return-object v0

    .line 33
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is empty"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public final getApi()Lcom/rokid/security/phone/sdk/server/net/ApiService;
    .locals 4

    .line 44
    sget-object v0, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->api:Lcom/rokid/security/phone/sdk/server/net/ApiService;

    if-nez v0, :cond_0

    sget-object v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->Companion:Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;->getInstance()Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    move-result-object v0

    const-class v1, Lcom/rokid/security/phone/sdk/server/net/ApiService;

    .line 46
    sget-object v2, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getHostUrl()Ljava/lang/String;

    move-result-object v2

    const-string v3, "api hostUrl"

    invoke-direct {p0, v2, v3}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->requireBaseUrl(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 44
    invoke-virtual {v0, v1, v2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->create(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/net/ApiService;

    :cond_0
    return-object v0
.end method

.method public final getAuthApi()Lcom/rokid/security/phone/sdk/server/net/AuthApiService;
    .locals 4

    .line 37
    sget-object v0, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->authApi:Lcom/rokid/security/phone/sdk/server/net/AuthApiService;

    if-nez v0, :cond_0

    sget-object v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->Companion:Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;->getInstance()Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    move-result-object v0

    const-class v1, Lcom/rokid/security/phone/sdk/server/net/AuthApiService;

    .line 39
    sget-object v2, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getHostUrl()Ljava/lang/String;

    move-result-object v2

    const-string v3, "auth hostUrl"

    invoke-direct {p0, v2, v3}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->requireBaseUrl(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 37
    invoke-virtual {v0, v1, v2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->create(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/net/AuthApiService;

    :cond_0
    return-object v0
.end method

.method public final getDownloadFileApi(Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)Lcom/rokid/security/phone/sdk/server/net/DownloadApi;
    .locals 4
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 58
    sget-object v0, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->downloadApi:Lcom/rokid/security/phone/sdk/server/net/DownloadApi;

    if-nez v0, :cond_0

    .line 59
    sget-object v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->Companion:Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;->getInstance()Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    move-result-object v0

    const-class v1, Lcom/rokid/security/phone/sdk/server/net/DownloadApi;

    .line 61
    sget-object v2, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getHostUrl()Ljava/lang/String;

    move-result-object v2

    const-string v3, "download hostUrl"

    invoke-direct {p0, v2, v3}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->requireBaseUrl(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 62
    nop

    .line 59
    invoke-virtual {v0, v1, v2, p1}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->createDownloadService(Ljava/lang/Class;Ljava/lang/String;Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/net/DownloadApi;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->downloadApi:Lcom/rokid/security/phone/sdk/server/net/DownloadApi;

    .line 65
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->downloadApi:Lcom/rokid/security/phone/sdk/server/net/DownloadApi;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    return-object v0
.end method

.method public final getOssApi()Lcom/rokid/security/phone/sdk/server/net/OssApiService;
    .locals 4

    .line 52
    sget-object v0, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->ossApi:Lcom/rokid/security/phone/sdk/server/net/OssApiService;

    if-nez v0, :cond_0

    sget-object v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->Companion:Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;->getInstance()Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    move-result-object v0

    const-class v1, Lcom/rokid/security/phone/sdk/server/net/OssApiService;

    .line 54
    sget-object v2, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getHostUrl()Ljava/lang/String;

    move-result-object v2

    const-string v3, "oss hostUrl"

    invoke-direct {p0, v2, v3}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->requireBaseUrl(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 52
    invoke-virtual {v0, v1, v2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->create(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/net/OssApiService;

    :cond_0
    return-object v0
.end method

.method public final refreshApi()V
    .locals 6

    .line 69
    sget-object v0, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getHostUrl()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->asValidBaseUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 70
    .local v0, "commonBaseUrl":Ljava/lang/String;
    const/4 v1, 0x0

    if-eqz v0, :cond_0

    move-object v2, v0

    .line 77
    .local v2, "it":Ljava/lang/String;
    const/4 v3, 0x0

    .line 70
    .local v3, "$i$a$-let-ApiProvider$refreshApi$1":I
    sget-object v4, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->Companion:Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;->getInstance()Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    move-result-object v4

    const-class v5, Lcom/rokid/security/phone/sdk/server/net/AuthApiService;

    invoke-virtual {v4, v5, v2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->create(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/rokid/security/phone/sdk/server/net/AuthApiService;

    .end local v2    # "it":Ljava/lang/String;
    .end local v3    # "$i$a$-let-ApiProvider$refreshApi$1":I
    goto :goto_0

    :cond_0
    move-object v4, v1

    :goto_0
    sput-object v4, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->authApi:Lcom/rokid/security/phone/sdk/server/net/AuthApiService;

    .line 71
    if-eqz v0, :cond_1

    move-object v2, v0

    .line 77
    .restart local v2    # "it":Ljava/lang/String;
    const/4 v3, 0x0

    .line 71
    .local v3, "$i$a$-let-ApiProvider$refreshApi$2":I
    sget-object v4, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->Companion:Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;->getInstance()Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    move-result-object v4

    const-class v5, Lcom/rokid/security/phone/sdk/server/net/ApiService;

    invoke-virtual {v4, v5, v2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->create(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/rokid/security/phone/sdk/server/net/ApiService;

    .end local v2    # "it":Ljava/lang/String;
    .end local v3    # "$i$a$-let-ApiProvider$refreshApi$2":I
    goto :goto_1

    :cond_1
    move-object v4, v1

    :goto_1
    sput-object v4, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->api:Lcom/rokid/security/phone/sdk/server/net/ApiService;

    .line 72
    sput-object v1, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->ossApi:Lcom/rokid/security/phone/sdk/server/net/OssApiService;

    .line 73
    sput-object v1, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->downloadApi:Lcom/rokid/security/phone/sdk/server/net/DownloadApi;

    .line 74
    return-void
.end method
