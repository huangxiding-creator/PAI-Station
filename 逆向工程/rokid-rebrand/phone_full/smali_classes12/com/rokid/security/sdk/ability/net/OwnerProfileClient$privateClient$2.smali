.class final Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2;
.super Lkotlin/jvm/internal/Lambda;
.source "OwnerProfileClient.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function0<",
        "Lokhttp3/OkHttpClient;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0010\u0000\u001a\n \u0002*\u0004\u0018\u00010\u00010\u0001H\n\u00a2\u0006\u0002\u0008\u0003"
    }
    d2 = {
        "<anonymous>",
        "Lokhttp3/OkHttpClient;",
        "kotlin.jvm.PlatformType",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2;


# direct methods
.method public static synthetic $r8$lambda$DHR-o7hRSraUZ1h8AupGfmz7Myg(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2;->invoke$lambda$0(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z

    move-result p0

    return p0
.end method

.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2;

    return-void
.end method

.method constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method

.method private static final invoke$lambda$0(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z
    .locals 0

    .line 33
    const/4 p0, 0x1

    return p0
.end method


# virtual methods
.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 24
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2;->invoke()Lokhttp3/OkHttpClient;

    move-result-object v0

    return-object v0
.end method

.method public final invoke()Lokhttp3/OkHttpClient;
    .locals 5

    .line 25
    new-instance v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2$trust$1;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2$trust$1;-><init>()V

    .line 30
    .local v0, "trust":Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2$trust$1;
    const-string v1, "TLS"

    invoke-static {v1}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v1

    .line 31
    .local v1, "tls":Ljavax/net/ssl/SSLContext;
    const/4 v2, 0x1

    new-array v2, v2, [Ljavax/net/ssl/TrustManager;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    new-instance v3, Ljava/security/SecureRandom;

    invoke-direct {v3}, Ljava/security/SecureRandom;-><init>()V

    const/4 v4, 0x0

    invoke-virtual {v1, v4, v2, v3}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 32
    invoke-static {}, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->access$getClient$p()Lokhttp3/OkHttpClient;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/OkHttpClient;->newBuilder()Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    invoke-virtual {v1}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v3

    move-object v4, v0

    check-cast v4, Ljavax/net/ssl/X509TrustManager;

    invoke-virtual {v2, v3, v4}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    new-instance v3, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2$$ExternalSyntheticLambda0;

    invoke-direct {v3}, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2$$ExternalSyntheticLambda0;-><init>()V

    .line 33
    invoke-virtual {v2, v3}, Lokhttp3/OkHttpClient$Builder;->hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v2

    return-object v2
.end method
