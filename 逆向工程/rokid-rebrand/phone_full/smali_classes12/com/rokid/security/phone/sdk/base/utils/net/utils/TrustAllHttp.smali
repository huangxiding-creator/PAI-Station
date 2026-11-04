.class public final Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;
.super Ljava/lang/Object;
.source "TrustAllHttp.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00008\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J7\u0010\u0003\u001a\u00020\u00042\u0008\u0008\u0002\u0010\u0005\u001a\u00020\u00062\u0008\u0008\u0002\u0010\u0007\u001a\u00020\u00062\u0019\u0008\u0002\u0010\u0008\u001a\u0013\u0012\u0004\u0012\u00020\n\u0012\u0004\u0012\u00020\u000b0\t\u00a2\u0006\u0002\u0008\u000cH\u0007J\u0010\u0010\r\u001a\u00020\u000e2\u0006\u0010\u000f\u001a\u00020\u0010H\u0007\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;",
        "",
        "()V",
        "createOkHttpClient",
        "Lokhttp3/OkHttpClient;",
        "connectTimeoutMs",
        "",
        "readTimeoutMs",
        "configure",
        "Lkotlin/Function1;",
        "Lokhttp3/OkHttpClient$Builder;",
        "",
        "Lkotlin/ExtensionFunctionType;",
        "openConnection",
        "Ljava/net/HttpURLConnection;",
        "url",
        "Ljava/net/URL;",
        "base-utils_release"
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final createOkHttpClient()Lokhttp3/OkHttpClient;
    .locals 7
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const/4 v5, 0x7

    const/4 v6, 0x0

    const-wide/16 v0, 0x0

    const-wide/16 v2, 0x0

    const/4 v4, 0x0

    invoke-static/range {v0 .. v6}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;->createOkHttpClient$default(JJLkotlin/jvm/functions/Function1;ILjava/lang/Object;)Lokhttp3/OkHttpClient;

    move-result-object v0

    return-object v0
.end method

.method public static final createOkHttpClient(J)Lokhttp3/OkHttpClient;
    .locals 7
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const/4 v5, 0x6

    const/4 v6, 0x0

    const-wide/16 v2, 0x0

    const/4 v4, 0x0

    move-wide v0, p0

    invoke-static/range {v0 .. v6}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;->createOkHttpClient$default(JJLkotlin/jvm/functions/Function1;ILjava/lang/Object;)Lokhttp3/OkHttpClient;

    move-result-object v0

    return-object v0
.end method

.method public static final createOkHttpClient(JJ)Lokhttp3/OkHttpClient;
    .locals 7
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v4, 0x0

    move-wide v0, p0

    move-wide v2, p2

    invoke-static/range {v0 .. v6}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;->createOkHttpClient$default(JJLkotlin/jvm/functions/Function1;ILjava/lang/Object;)Lokhttp3/OkHttpClient;

    move-result-object v0

    return-object v0
.end method

.method public static final createOkHttpClient(JJLkotlin/jvm/functions/Function1;)Lokhttp3/OkHttpClient;
    .locals 4
    .param p0, "connectTimeoutMs"    # J
    .param p2, "readTimeoutMs"    # J
    .param p4, "configure"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(JJ",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lokhttp3/OkHttpClient$Builder;",
            "Lkotlin/Unit;",
            ">;)",
            "Lokhttp3/OkHttpClient;"
        }
    .end annotation

    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "configure"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 33
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactory()Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v0

    .line 34
    .local v0, "sslParams":Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    new-instance v1, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v1}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 35
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->sSLSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->trustManager:Ljavax/net/ssl/X509TrustManager;

    invoke-virtual {v1, v2, v3}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 36
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v2

    invoke-virtual {v1, v2}, Lokhttp3/OkHttpClient$Builder;->hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 37
    sget-object v2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v1, p0, p1, v2}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 38
    sget-object v2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v1, p2, p3, v2}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 39
    invoke-interface {p4, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 40
    invoke-virtual {v1}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v1

    const-string v2, "Builder()\n            .s\u2026ure)\n            .build()"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    return-object v1
.end method

.method public static synthetic createOkHttpClient$default(JJLkotlin/jvm/functions/Function1;ILjava/lang/Object;)Lokhttp3/OkHttpClient;
    .locals 2

    .line 28
    and-int/lit8 p6, p5, 0x1

    const-wide/16 v0, 0x7530

    if-eqz p6, :cond_0

    .line 29
    move-wide p0, v0

    .line 28
    :cond_0
    and-int/lit8 p6, p5, 0x2

    if-eqz p6, :cond_1

    .line 30
    move-wide p2, v0

    .line 28
    :cond_1
    and-int/lit8 p5, p5, 0x4

    if-eqz p5, :cond_2

    .line 31
    sget-object p4, Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp$createOkHttpClient$1;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp$createOkHttpClient$1;

    check-cast p4, Lkotlin/jvm/functions/Function1;

    .line 28
    :cond_2
    invoke-static {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;->createOkHttpClient(JJLkotlin/jvm/functions/Function1;)Lokhttp3/OkHttpClient;

    move-result-object p0

    return-object p0
.end method

.method public static final openConnection(Ljava/net/URL;)Ljava/net/HttpURLConnection;
    .locals 4
    .param p0, "url"    # Ljava/net/URL;
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string/jumbo v0, "url"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    invoke-virtual {p0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    const-string v1, "null cannot be cast to non-null type java.net.HttpURLConnection"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Ljava/net/HttpURLConnection;

    .line 18
    .local v0, "connection":Ljava/net/HttpURLConnection;
    instance-of v1, v0, Ljavax/net/ssl/HttpsURLConnection;

    if-eqz v1, :cond_0

    .line 19
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactory()Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v1

    .line 20
    .local v1, "sslParams":Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    move-object v2, v0

    check-cast v2, Ljavax/net/ssl/HttpsURLConnection;

    iget-object v3, v1, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->sSLSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    invoke-virtual {v2, v3}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 21
    move-object v2, v0

    check-cast v2, Ljavax/net/ssl/HttpsURLConnection;

    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 23
    .end local v1    # "sslParams":Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    :cond_0
    return-object v0
.end method
