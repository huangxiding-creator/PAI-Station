.class public final Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;
.super Ljava/lang/Object;
.source "OkHttpSSEClient.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$Companion;,
        Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;,
        Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$TrustAllCerts;,
        Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$TrustAllHostnameVerifier;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOkHttpSSEClient.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OkHttpSSEClient.kt\ncom/rokid/security/sdk/ability/net/OkHttpSSEClient\n+ 2 _Maps.kt\nkotlin/collections/MapsKt___MapsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,360:1\n215#2,2:361\n1#3:363\n*S KotlinDebug\n*F\n+ 1 OkHttpSSEClient.kt\ncom/rokid/security/sdk/ability/net/OkHttpSSEClient\n*L\n123#1:361,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0080\u0001\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0003\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\t\n\u0002\u0008\u0008\u0018\u0000 02\u00020\u0001:\u00040123B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0016\u0010\u0014\u001a\u00020\u00152\u0006\u0010\u0016\u001a\u00020\u00042\u0006\u0010\u0017\u001a\u00020\u0018J\u0008\u0010\u0019\u001a\u00020\u001aH\u0002J\u0006\u0010\u001b\u001a\u00020\u001aJ\u0008\u0010\u001c\u001a\u00020\u001dH\u0002J(\u0010\u001e\u001a\u00020\u001a2\u0006\u0010\u0016\u001a\u00020\u00042\u0006\u0010\u001f\u001a\u00020\u00042\u0006\u0010 \u001a\u00020!2\u0008\u0008\u0002\u0010\"\u001a\u00020#J\u001c\u0010$\u001a\u00020\u000b2\u0008\u0010%\u001a\u0004\u0018\u00010&2\u0008\u0010\'\u001a\u0004\u0018\u00010(H\u0002JD\u0010)\u001a\u00020\u001a2\u0006\u0010*\u001a\u00020\u00152\u0006\u0010 \u001a\u00020!2\u0006\u0010+\u001a\u00020,2\u0006\u0010-\u001a\u00020#2\u0006\u0010\"\u001a\u00020#2\u0008\u0010.\u001a\u0004\u0018\u00010&2\u0008\u0010\'\u001a\u0004\u0018\u00010(H\u0002J0\u0010/\u001a\u00020\u001a2\u0006\u0010*\u001a\u00020\u00152\u0006\u0010 \u001a\u00020!2\u0006\u0010+\u001a\u00020,2\u0006\u0010-\u001a\u00020#2\u0006\u0010\"\u001a\u00020#H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u0007\u001a\n \t*\u0004\u0018\u00010\u00080\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u000c\u001a\n \t*\u0004\u0018\u00010\r0\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u000fX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0010\u001a\u00020\u0011X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0012\u001a\u0004\u0018\u00010\u0013X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u00064"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;",
        "",
        "()V",
        "TAG",
        "",
        "eventSource",
        "Lokhttp3/sse/EventSource;",
        "eventSourceFactory",
        "Lokhttp3/sse/EventSource$Factory;",
        "kotlin.jvm.PlatformType",
        "isClosed",
        "",
        "okHttpClient",
        "Lokhttp3/OkHttpClient;",
        "requestSequence",
        "Ljava/util/concurrent/atomic/AtomicLong;",
        "retryHandler",
        "Landroid/os/Handler;",
        "retryRunnable",
        "Ljava/lang/Runnable;",
        "buildSSERequest",
        "Lokhttp3/Request;",
        "url",
        "requestBody",
        "Lokhttp3/RequestBody;",
        "cancelPendingRetry",
        "",
        "close",
        "createSSLSocketFactory",
        "Ljavax/net/ssl/SSLSocketFactory;",
        "getAiChat",
        "jsonBody",
        "listener",
        "Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;",
        "maxTransientRetries",
        "",
        "isTransientNetworkFailure",
        "t",
        "",
        "response",
        "Lokhttp3/Response;",
        "scheduleRetry",
        "request",
        "requestId",
        "",
        "retryCount",
        "throwable",
        "startEventSource",
        "Companion",
        "SSECallback",
        "TrustAllCerts",
        "TrustAllHostnameVerifier",
        "sdk-common-ability_release"
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
.field private static final Companion:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$Companion;

.field private static final RETRYABLE_HTTP_CODES:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static final RETRY_DELAYS_MILLIS:[J


# instance fields
.field private final TAG:Ljava/lang/String;

.field private eventSource:Lokhttp3/sse/EventSource;

.field private final eventSourceFactory:Lokhttp3/sse/EventSource$Factory;

.field private volatile isClosed:Z

.field private final okHttpClient:Lokhttp3/OkHttpClient;

.field private final requestSequence:Ljava/util/concurrent/atomic/AtomicLong;

.field private final retryHandler:Landroid/os/Handler;

.field private retryRunnable:Ljava/lang/Runnable;


# direct methods
.method public static synthetic $r8$lambda$eOgFCK_rknZXfYtUk_KScTSbbIE(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;JLokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;II)V
    .locals 0

    invoke-static/range {p0 .. p6}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->scheduleRetry$lambda$2(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;JLokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;II)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->Companion:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$Companion;

    .line 353
    const/4 v0, 0x2

    new-array v1, v0, [J

    fill-array-data v1, :array_0

    sput-object v1, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->RETRY_DELAYS_MILLIS:[J

    .line 354
    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Integer;

    const/16 v2, 0x1f6

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const/16 v2, 0x1f7

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const/4 v3, 0x1

    aput-object v2, v1, v3

    const/16 v2, 0x1f8

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v0

    invoke-static {v1}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->RETRYABLE_HTTP_CODES:Ljava/util/Set;

    return-void

    :array_0
    .array-data 8
        0x1f4
        0x5dc
    .end array-data
.end method

.method public constructor <init>()V
    .locals 5

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 35
    const-string v0, "OkHttpSSEClient"

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    .line 44
    nop

    .line 38
    new-instance v0, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v0}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 39
    const-wide/16 v1, 0xa

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, v2, v3}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 40
    const-wide/16 v1, 0x1e

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, v2, v3}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 41
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->createSSLSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v1

    new-instance v2, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$TrustAllCerts;

    invoke-direct {v2}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$TrustAllCerts;-><init>()V

    check-cast v2, Ljavax/net/ssl/X509TrustManager;

    invoke-virtual {v0, v1, v2}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 42
    new-instance v1, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$TrustAllHostnameVerifier;

    invoke-direct {v1}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$TrustAllHostnameVerifier;-><init>()V

    check-cast v1, Ljavax/net/ssl/HostnameVerifier;

    invoke-virtual {v0, v1}, Lokhttp3/OkHttpClient$Builder;->hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 43
    sget-object v1, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    check-cast v1, Lokhttp3/Interceptor;

    invoke-virtual {v0, v1}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 44
    invoke-virtual {v0}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->okHttpClient:Lokhttp3/OkHttpClient;

    .line 47
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->okHttpClient:Lokhttp3/OkHttpClient;

    invoke-static {v0}, Lokhttp3/sse/EventSources;->createFactory(Lokhttp3/OkHttpClient;)Lokhttp3/sse/EventSource$Factory;

    move-result-object v0

    move-object v1, v0

    .local v1, "it":Lokhttp3/sse/EventSource$Factory;
    const/4 v2, 0x0

    .line 48
    .local v2, "$i$a$-also-OkHttpSSEClient$eventSourceFactory$1":I
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    const-string v4, "EventSourceFactory\u521d\u59cb\u5316\u5b8c\u6210"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 49
    nop

    .line 47
    .end local v1    # "it":Lokhttp3/sse/EventSource$Factory;
    .end local v2    # "$i$a$-also-OkHttpSSEClient$eventSourceFactory$1":I
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->eventSourceFactory:Lokhttp3/sse/EventSource$Factory;

    .line 55
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->retryHandler:Landroid/os/Handler;

    .line 56
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, 0x0

    invoke-direct {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->requestSequence:Ljava/util/concurrent/atomic/AtomicLong;

    .line 34
    return-void
.end method

.method public static final synthetic access$getRETRYABLE_HTTP_CODES$cp()Ljava/util/Set;
    .locals 1

    .line 34
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->RETRYABLE_HTTP_CODES:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getRETRY_DELAYS_MILLIS$cp()[J
    .locals 1

    .line 34
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->RETRY_DELAYS_MILLIS:[J

    return-object v0
.end method

.method public static final synthetic access$getRequestSequence$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/util/concurrent/atomic/AtomicLong;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 34
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->requestSequence:Ljava/util/concurrent/atomic/AtomicLong;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 34
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$isClosed$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 34
    iget-boolean v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->isClosed:Z

    return v0
.end method

.method public static final synthetic access$isTransientNetworkFailure(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;Ljava/lang/Throwable;Lokhttp3/Response;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;
    .param p1, "t"    # Ljava/lang/Throwable;
    .param p2, "response"    # Lokhttp3/Response;

    .line 34
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->isTransientNetworkFailure(Ljava/lang/Throwable;Lokhttp3/Response;)Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$scheduleRetry(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;Lokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;JIILjava/lang/Throwable;Lokhttp3/Response;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;
    .param p1, "request"    # Lokhttp3/Request;
    .param p2, "listener"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;
    .param p3, "requestId"    # J
    .param p5, "retryCount"    # I
    .param p6, "maxTransientRetries"    # I
    .param p7, "throwable"    # Ljava/lang/Throwable;
    .param p8, "response"    # Lokhttp3/Response;

    .line 34
    invoke-direct/range {p0 .. p8}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->scheduleRetry(Lokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;JIILjava/lang/Throwable;Lokhttp3/Response;)V

    return-void
.end method

.method private final cancelPendingRetry()V
    .locals 3

    .line 323
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->retryRunnable:Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->retryHandler:Landroid/os/Handler;

    .line 363
    .local v0, "p0":Ljava/lang/Runnable;
    const/4 v2, 0x0

    .line 323
    .local v2, "$i$a$-let-OkHttpSSEClient$cancelPendingRetry$1":I
    invoke-virtual {v1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 324
    .end local v0    # "p0":Ljava/lang/Runnable;
    .end local v2    # "$i$a$-let-OkHttpSSEClient$cancelPendingRetry$1":I
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->retryRunnable:Ljava/lang/Runnable;

    .line 325
    return-void
.end method

.method private final createSSLSocketFactory()Ljavax/net/ssl/SSLSocketFactory;
    .locals 4

    .line 64
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "\u5f00\u59cb\u521b\u5efa\u4fe1\u4efb\u6240\u6709\u8bc1\u4e66\u7684SSLSocketFactory"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 65
    nop

    .line 66
    :try_start_0
    const-string v0, "SSL"

    invoke-static {v0}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v0

    .line 67
    .local v0, "sslContext":Ljavax/net/ssl/SSLContext;
    const/4 v1, 0x1

    new-array v1, v1, [Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$TrustAllCerts;

    new-instance v2, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$TrustAllCerts;

    invoke-direct {v2}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$TrustAllCerts;-><init>()V

    const/4 v3, 0x0

    aput-object v2, v1, v3

    check-cast v1, [Ljavax/net/ssl/TrustManager;

    new-instance v2, Ljava/security/SecureRandom;

    invoke-direct {v2}, Ljava/security/SecureRandom;-><init>()V

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v1, v2}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 68
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    const-string v2, "SSLSocketFactory\u521b\u5efa\u6210\u529f"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 69
    invoke-virtual {v0}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v1

    .line 65
    .end local v0    # "sslContext":Ljavax/net/ssl/SSLContext;
    const-string/jumbo v0, "{\n            val sslCon\u2026t.socketFactory\n        }"

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 70
    :catch_0
    move-exception v0

    .line 71
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SSLSocketFactory\u521b\u5efa\u5931\u8d25: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2, v0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 72
    new-instance v1, Ljava/lang/RuntimeException;

    move-object v2, v0

    check-cast v2, Ljava/lang/Throwable;

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public static synthetic getAiChat$default(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;IILjava/lang/Object;)V
    .locals 0

    .line 140
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_0

    .line 144
    const/4 p4, 0x0

    .line 140
    :cond_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->getAiChat(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;I)V

    return-void
.end method

.method private final isTransientNetworkFailure(Ljava/lang/Throwable;Lokhttp3/Response;)Z
    .locals 3
    .param p1, "t"    # Ljava/lang/Throwable;
    .param p2, "response"    # Lokhttp3/Response;

    .line 305
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->RETRYABLE_HTTP_CODES:Ljava/util/Set;

    check-cast v0, Ljava/lang/Iterable;

    if-eqz p2, :cond_0

    invoke-virtual {p2}, Lokhttp3/Response;->code()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-static {v0, v1}, Lkotlin/collections/CollectionsKt;->contains(Ljava/lang/Iterable;Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    .line 306
    return v1

    .line 308
    :cond_1
    move-object v0, p1

    .line 309
    .local v0, "cause":Ljava/lang/Throwable;
    :goto_1
    if-eqz v0, :cond_4

    .line 310
    instance-of v2, v0, Ljava/net/UnknownHostException;

    if-nez v2, :cond_3

    .line 311
    instance-of v2, v0, Ljava/net/ConnectException;

    if-nez v2, :cond_3

    .line 312
    instance-of v2, v0, Ljava/net/SocketTimeoutException;

    if-nez v2, :cond_3

    .line 313
    instance-of v2, v0, Ljava/net/NoRouteToHostException;

    if-eqz v2, :cond_2

    goto :goto_2

    .line 317
    :cond_2
    invoke-virtual {v0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    goto :goto_1

    .line 315
    :cond_3
    :goto_2
    return v1

    .line 319
    :cond_4
    const/4 v1, 0x0

    return v1
.end method

.method private final scheduleRetry(Lokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;JIILjava/lang/Throwable;Lokhttp3/Response;)V
    .locals 15
    .param p1, "request"    # Lokhttp3/Request;
    .param p2, "listener"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;
    .param p3, "requestId"    # J
    .param p5, "retryCount"    # I
    .param p6, "maxTransientRetries"    # I
    .param p7, "throwable"    # Ljava/lang/Throwable;
    .param p8, "response"    # Lokhttp3/Response;

    .line 282
    move-object v8, p0

    move/from16 v9, p5

    add-int/lit8 v10, v9, 0x1

    .line 283
    .local v10, "nextRetryCount":I
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->RETRY_DELAYS_MILLIS:[J

    .line 284
    sget-object v1, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->RETRY_DELAYS_MILLIS:[J

    invoke-static {v1}, Lkotlin/collections/ArraysKt;->getLastIndex([J)I

    move-result v1

    invoke-static {v9, v1}, Lkotlin/ranges/RangesKt;->coerceAtMost(II)I

    move-result v1

    aget-wide v1, v0, v1

    .line 283
    move-wide v11, v1

    .line 287
    .local v11, "delayMillis":J
    iget-object v0, v8, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    .line 288
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SSE\u77ac\u6001\u7f51\u7edc\u5f02\u5e38\uff0c"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v11, v12}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "ms\u540e\u91cd\u8bd5 attempt="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 289
    nop

    .line 288
    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x2f

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 289
    nop

    .line 288
    move/from16 v13, p6

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 289
    nop

    .line 288
    const-string v2, " error="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 290
    const/4 v2, 0x0

    if-eqz p7, :cond_0

    invoke-virtual/range {p7 .. p7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_0
    move-object v3, v2

    :goto_0
    if-nez v3, :cond_2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "HTTP_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    if-eqz p8, :cond_1

    invoke-virtual/range {p8 .. p8}, Lokhttp3/Response;->code()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    :cond_1
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 288
    :cond_2
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 286
    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 292
    new-instance v14, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;

    move-object v0, v14

    move-object v1, p0

    move-wide/from16 v2, p3

    move-object/from16 v4, p1

    move-object/from16 v5, p2

    move v6, v10

    move/from16 v7, p6

    invoke-direct/range {v0 .. v7}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;JLokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;II)V

    .line 300
    .local v0, "runnable":Ljava/lang/Runnable;
    iput-object v0, v8, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->retryRunnable:Ljava/lang/Runnable;

    .line 301
    iget-object v1, v8, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->retryHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0, v11, v12}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 302
    return-void
.end method

.method private static final scheduleRetry$lambda$2(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;JLokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;II)V
    .locals 7
    .param p0, "this$0"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;
    .param p1, "$requestId"    # J
    .param p3, "$request"    # Lokhttp3/Request;
    .param p4, "$listener"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;
    .param p5, "$nextRetryCount"    # I
    .param p6, "$maxTransientRetries"    # I

    const-string/jumbo v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$request"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$listener"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 293
    iget-boolean v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->isClosed:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->requestSequence:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    cmp-long v0, p1, v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 297
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->retryRunnable:Ljava/lang/Runnable;

    .line 298
    move-object v0, p0

    move-object v1, p3

    move-object v2, p4

    move-wide v3, p1

    move v5, p5

    move v6, p6

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->startEventSource(Lokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;JII)V

    .line 299
    return-void

    .line 294
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SSE\u91cd\u8bd5\u5df2\u53d6\u6d88 requestId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 295
    return-void
.end method

.method private final startEventSource(Lokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;JII)V
    .locals 12
    .param p1, "request"    # Lokhttp3/Request;
    .param p2, "listener"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;
    .param p3, "requestId"    # J
    .param p5, "retryCount"    # I
    .param p6, "maxTransientRetries"    # I

    .line 170
    move-object v9, p0

    new-instance v2, Lkotlin/jvm/internal/Ref$BooleanRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$BooleanRef;-><init>()V

    .line 172
    .local v2, "connectionOpened":Lkotlin/jvm/internal/Ref$BooleanRef;
    iget-object v10, v9, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->eventSourceFactory:Lokhttp3/sse/EventSource$Factory;

    .line 173
    nop

    .line 174
    new-instance v11, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;

    move-object v0, v11

    move-object v1, p0

    move-object v3, p2

    move-wide v4, p3

    move/from16 v6, p5

    move/from16 v7, p6

    move-object v8, p1

    invoke-direct/range {v0 .. v8}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;-><init>(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;Lkotlin/jvm/internal/Ref$BooleanRef;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;JIILokhttp3/Request;)V

    check-cast v11, Lokhttp3/sse/EventSourceListener;

    .line 172
    move-object v0, p1

    invoke-interface {v10, p1, v11}, Lokhttp3/sse/EventSource$Factory;->newEventSource(Lokhttp3/Request;Lokhttp3/sse/EventSourceListener;)Lokhttp3/sse/EventSource;

    move-result-object v1

    iput-object v1, v9, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->eventSource:Lokhttp3/sse/EventSource;

    .line 271
    return-void
.end method


# virtual methods
.method public final buildSSERequest(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request;
    .locals 11
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "requestBody"    # Lokhttp3/RequestBody;

    const-string/jumbo v0, "url"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "requestBody"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 114
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u5f00\u59cb\u6784\u5efaSSE\u8bf7\u6c42\uff0cURL: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 115
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->ensureBusinessHeaders()V

    .line 116
    new-instance v0, Lokhttp3/Request$Builder;

    invoke-direct {v0}, Lokhttp3/Request$Builder;-><init>()V

    .line 117
    invoke-virtual {v0, p1}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v0

    .line 118
    const-string v1, "Accept"

    const-string/jumbo v2, "text/event-stream"

    invoke-virtual {v0, v1, v2}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v0

    .line 119
    invoke-virtual {v0, p2}, Lokhttp3/Request$Builder;->post(Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v0

    .line 116
    nop

    .line 122
    .local v0, "requestBuilder":Lokhttp3/Request$Builder;
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u5f00\u59cb\u6dfb\u52a0SecuritySDKEnv\u5934\u90e8\uff0c\u5171"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/concurrent/ConcurrentHashMap;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x4e2a

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 123
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v1

    check-cast v1, Ljava/util/Map;

    .local v1, "$this$forEach$iv":Ljava/util/Map;
    const/4 v2, 0x0

    .line 361
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map$Entry;

    .local v4, "element$iv":Ljava/util/Map$Entry;
    const/4 v5, 0x0

    .line 123
    .local v5, "$i$a$-forEach-OkHttpSSEClient$buildSSERequest$1":I
    invoke-interface {v4}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .local v6, "key":Ljava/lang/String;
    invoke-interface {v4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 124
    .local v7, "value":Ljava/lang/String;
    invoke-virtual {v0}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v8

    invoke-virtual {v8, v6}, Lokhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    if-nez v8, :cond_0

    .line 125
    invoke-virtual {v0, v6, v7}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 126
    iget-object v8, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v10, "\u6dfb\u52a0\u5934\u90e8\u6210\u529f: name="

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    .line 128
    :cond_0
    iget-object v8, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v10, "\u5934\u90e8\u5df2\u5b58\u5728\uff0c\u8df3\u8fc7: ["

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const/16 v10, 0x5d

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 130
    :goto_1
    nop

    .line 361
    .end local v5    # "$i$a$-forEach-OkHttpSSEClient$buildSSERequest$1":I
    .end local v6    # "key":Ljava/lang/String;
    .end local v7    # "value":Ljava/lang/String;
    nop

    .end local v4    # "element$iv":Ljava/util/Map$Entry;
    goto :goto_0

    .line 362
    :cond_1
    nop

    .line 132
    .end local v1    # "$this$forEach$iv":Ljava/util/Map;
    .end local v2    # "$i$f$forEach":I
    invoke-virtual {v0}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v1

    .line 133
    .local v1, "request":Lokhttp3/Request;
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SSE\u8bf7\u6c42\u6784\u5efa\u5b8c\u6210\uff0c\u8bf7\u6c42\u65b9\u6cd5: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string/jumbo v4, "\uff0c\u5934\u90e8\u6570\u91cf: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Lokhttp3/Request;->headers()Lokhttp3/Headers;

    move-result-object v4

    invoke-virtual {v4}, Lokhttp3/Headers;->size()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 134
    const-string v2, "request"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v1
.end method

.method public final close()V
    .locals 2

    .line 332
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "\u5f00\u59cb\u5173\u95edSSE\u8fde\u63a5"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 333
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->isClosed:Z

    .line 334
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->requestSequence:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    .line 335
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->cancelPendingRetry()V

    .line 336
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->eventSource:Lokhttp3/sse/EventSource;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lokhttp3/sse/EventSource;->cancel()V

    .line 337
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->eventSource:Lokhttp3/sse/EventSource;

    .line 338
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    const-string v1, "SSE\u8fde\u63a5\u5173\u95ed\u6d41\u7a0b\u5b8c\u6210"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 339
    return-void
.end method

.method public final getAiChat(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;I)V
    .locals 17
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "jsonBody"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;
    .param p4, "maxTransientRetries"    # I

    move-object/from16 v7, p0

    move-object/from16 v8, p1

    move-object/from16 v9, p2

    const-string/jumbo v0, "url"

    invoke-static {v8, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "jsonBody"

    invoke-static {v9, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    move-object/from16 v10, p3

    invoke-static {v10, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 147
    const/4 v0, 0x0

    iput-boolean v0, v7, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->isClosed:Z

    .line 148
    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->cancelPendingRetry()V

    .line 149
    iget-object v1, v7, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->requestSequence:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v11

    .line 150
    .local v11, "requestId":J
    iget-object v1, v7, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u5f00\u59cb\u53d1\u9001SSE\u8bf7\u6c42\uff0cURL: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", payloadLength="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {p2 .. p2}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 156
    const-string v1, "application/json; charset=utf-8"

    invoke-static {v1}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v13

    .line 157
    .local v13, "mediaType":Lokhttp3/MediaType;
    invoke-static {v13, v9}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;Ljava/lang/String;)Lokhttp3/RequestBody;

    move-result-object v14

    .line 158
    .local v14, "requestBody":Lokhttp3/RequestBody;
    const-string v1, "requestBody"

    invoke-static {v14, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v7, v8, v14}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->buildSSERequest(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request;

    move-result-object v15

    .line 160
    .local v15, "request":Lokhttp3/Request;
    const/4 v5, 0x0

    move/from16 v6, p4

    invoke-static {v6, v0}, Lkotlin/ranges/RangesKt;->coerceAtLeast(II)I

    move-result v16

    move-object/from16 v0, p0

    move-object v1, v15

    move-object/from16 v2, p3

    move-wide v3, v11

    move/from16 v6, v16

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->startEventSource(Lokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;JII)V

    .line 161
    return-void
.end method
