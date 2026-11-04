.class public final Lcom/rokid/security/sdk/ability/net/RetrofitClient;
.super Ljava/lang/Object;
.source "RetrofitClient.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;,
        Lcom/rokid/security/sdk/ability/net/RetrofitClient$DynamicUrlInterceptor;,
        Lcom/rokid/security/sdk/ability/net/RetrofitClient$ProgressInterceptor;,
        Lcom/rokid/security/sdk/ability/net/RetrofitClient$SingletonHolder;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nRetrofitClient.kt\nKotlin\n*S Kotlin\n*F\n+ 1 RetrofitClient.kt\ncom/rokid/security/sdk/ability/net/RetrofitClient\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,384:1\n1#2:385\n1855#3,2:386\n*S KotlinDebug\n*F\n+ 1 RetrofitClient.kt\ncom/rokid/security/sdk/ability/net/RetrofitClient\n*L\n307#1:386,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000@\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\t\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0018\u0000 #2\u00020\u0001:\u0004#$%&B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\'\u0010\r\u001a\u0002H\u000e\"\u0004\u0008\u0000\u0010\u000e2\u000c\u0010\u000f\u001a\u0008\u0012\u0004\u0012\u0002H\u000e0\u00102\u0006\u0010\u0011\u001a\u00020\u0012\u00a2\u0006\u0002\u0010\u0013J/\u0010\u0014\u001a\u0002H\u000e\"\u0004\u0008\u0000\u0010\u000e2\u000c\u0010\u000f\u001a\u0008\u0012\u0004\u0012\u0002H\u000e0\u00102\u0006\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u0015\u001a\u00020\u0016\u00a2\u0006\u0002\u0010\u0017J\u0008\u0010\u0018\u001a\u00020\u0008H\u0002J\u0006\u0010\u0019\u001a\u00020\u0008J\u0010\u0010\u001a\u001a\u00020\u00082\u0006\u0010\u0015\u001a\u00020\u0016H\u0002J\u0018\u0010\u001b\u001a\u00020\u00042\u0006\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u0015\u001a\u00020\u0016H\u0002J\u0006\u0010\u001c\u001a\u00020\u0008J\u0006\u0010\u001d\u001a\u00020\u0008J\u000e\u0010\u001e\u001a\u00020\u00042\u0006\u0010\u0011\u001a\u00020\u0012J\u0008\u0010\u001f\u001a\u00020 H\u0002J\u0008\u0010!\u001a\u00020\"H\u0002R\u0010\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0006\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0007\u001a\u00020\u00088FX\u0086\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000b\u0010\u000c\u001a\u0004\u0008\t\u0010\n\u00a8\u0006\'"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/RetrofitClient;",
        "",
        "()V",
        "mDownloadRetrofit",
        "Lretrofit2/Retrofit;",
        "mRetrofit",
        "mSseRetrofit",
        "okHttpClient",
        "Lokhttp3/OkHttpClient;",
        "getOkHttpClient",
        "()Lokhttp3/OkHttpClient;",
        "okHttpClient$delegate",
        "Lkotlin/Lazy;",
        "create",
        "T",
        "service",
        "Ljava/lang/Class;",
        "hostUrl",
        "",
        "(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;",
        "createDownloadService",
        "downloadListener",
        "Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;",
        "(Ljava/lang/Class;Ljava/lang/String;Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)Ljava/lang/Object;",
        "getClient",
        "getClient2",
        "getDownloadClient",
        "getDownloadRetrofit",
        "getGlideOkhttpClient",
        "getMinioClient",
        "getRetrofit",
        "initHeadInterceptor",
        "Lokhttp3/Interceptor;",
        "initInterceptor",
        "Lokhttp3/logging/HttpLoggingInterceptor;",
        "Companion",
        "DynamicUrlInterceptor",
        "ProgressInterceptor",
        "SingletonHolder",
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
.field private static final CALL_TIME_OUT:J = 0x78L

.field private static final CONNECT_TIMEOUT:J = 0x1eL

.field public static final Companion:Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;

.field private static final DOWNLOAD_CALL_TIME_OUT:J = 0xe10L

.field private static final DOWNLOAD_CONNECT_TIMEOUT:J = 0x1eL

.field private static final DOWNLOAD_READ_TIMEOUT:J = 0x258L

.field private static final DOWNLOAD_WRITE_TIMEOUT:J = 0x258L

.field private static final READ_TIMEOUT:J = 0x1eL

.field private static final WRITE_TIMEOUT:J = 0x1eL

.field private static final instance:Lcom/rokid/security/sdk/ability/net/RetrofitClient;


# instance fields
.field private mDownloadRetrofit:Lretrofit2/Retrofit;

.field private mRetrofit:Lretrofit2/Retrofit;

.field private mSseRetrofit:Lretrofit2/Retrofit;

.field private final okHttpClient$delegate:Lkotlin/Lazy;


# direct methods
.method public static synthetic $r8$lambda$--Rnbt4mi37GyvmmSS7yEi46xyA(Lokhttp3/Call;)Lokhttp3/EventListener;
    .locals 0

    invoke-static {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->getClient$lambda$0(Lokhttp3/Call;)Lokhttp3/EventListener;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$AbXeATof4hvZkeqdt8ZUnsJKVcM(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->initHeadInterceptor$lambda$5$lambda$4$lambda$3(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V

    return-void
.end method

.method public static synthetic $r8$lambda$HOpRXZlEFL4_S9Hp_GyxBXouT5s(Lokhttp3/Call;)Lokhttp3/EventListener;
    .locals 0

    invoke-static {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->getClient2$lambda$1(Lokhttp3/Call;)Lokhttp3/EventListener;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$iQFd5pjN8uhx4C_QZKnUd3oM3q4(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;
    .locals 0

    invoke-static {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->initHeadInterceptor$lambda$5(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->Companion:Lcom/rokid/security/sdk/ability/net/RetrofitClient$Companion;

    .line 38
    sget-object v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient$SingletonHolder;->INSTANCE:Lcom/rokid/security/sdk/ability/net/RetrofitClient$SingletonHolder;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$SingletonHolder;->getHolder()Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->instance:Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 58
    new-instance v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient$okHttpClient$2;

    invoke-direct {v0, p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$okHttpClient$2;-><init>(Lcom/rokid/security/sdk/ability/net/RetrofitClient;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->okHttpClient$delegate:Lkotlin/Lazy;

    .line 35
    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;-><init>()V

    return-void
.end method

.method public static final synthetic access$getClient(Lcom/rokid/security/sdk/ability/net/RetrofitClient;)Lokhttp3/OkHttpClient;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    .line 35
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->getClient()Lokhttp3/OkHttpClient;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getInstance$cp()Lcom/rokid/security/sdk/ability/net/RetrofitClient;
    .locals 1

    .line 35
    sget-object v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->instance:Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    return-object v0
.end method

.method private final getClient()Lokhttp3/OkHttpClient;
    .locals 10

    .line 66
    const/4 v0, 0x1

    new-array v1, v0, [Ljavax/net/ssl/TrustManager;

    new-instance v2, Lcom/rokid/security/sdk/ability/net/RetrofitClient$getClient$trustAllCerts$1;

    invoke-direct {v2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$getClient$trustAllCerts$1;-><init>()V

    const/4 v3, 0x0

    aput-object v2, v1, v3

    .line 65
    nop

    .line 73
    .local v1, "trustAllCerts":[Ljavax/net/ssl/TrustManager;
    const-string v2, "TLS"

    invoke-static {v2}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v2

    .line 74
    .local v2, "sslContext":Ljavax/net/ssl/SSLContext;
    new-instance v4, Ljava/security/SecureRandom;

    invoke-direct {v4}, Ljava/security/SecureRandom;-><init>()V

    const/4 v5, 0x0

    invoke-virtual {v2, v5, v1, v4}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 78
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactory()Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v4

    .line 79
    .local v4, "sslParams":Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    new-instance v5, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v5}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 80
    .local v5, "builder":Lokhttp3/OkHttpClient$Builder;
    sget-object v6, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getMethodProfix()Ljava/lang/String;

    move-result-object v6

    check-cast v6, Ljava/lang/CharSequence;

    invoke-interface {v6}, Ljava/lang/CharSequence;->length()I

    move-result v6

    if-lez v6, :cond_0

    move v6, v0

    goto :goto_0

    :cond_0
    move v6, v3

    :goto_0
    if-eqz v6, :cond_1

    .line 81
    new-instance v6, Lcom/rokid/security/sdk/ability/net/RetrofitClient$DynamicUrlInterceptor;

    sget-object v7, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v7}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getMethodProfix()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$DynamicUrlInterceptor;-><init>(Ljava/lang/String;)V

    check-cast v6, Lokhttp3/Interceptor;

    invoke-virtual {v5, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    .line 83
    :cond_1
    iget-object v6, v4, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->sSLSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    iget-object v7, v4, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->trustManager:Ljavax/net/ssl/X509TrustManager;

    invoke-virtual {v5, v6, v7}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v6

    .line 84
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v7

    invoke-virtual {v6, v7}, Lokhttp3/OkHttpClient$Builder;->hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v6

    .line 85
    const/4 v7, 0x3

    new-array v7, v7, [Lokhttp3/ConnectionSpec;

    sget-object v8, Lokhttp3/ConnectionSpec;->MODERN_TLS:Lokhttp3/ConnectionSpec;

    const-string v9, "MODERN_TLS"

    invoke-static {v8, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    aput-object v8, v7, v3

    sget-object v3, Lokhttp3/ConnectionSpec;->COMPATIBLE_TLS:Lokhttp3/ConnectionSpec;

    const-string v8, "COMPATIBLE_TLS"

    invoke-static {v3, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    aput-object v3, v7, v0

    sget-object v3, Lokhttp3/ConnectionSpec;->CLEARTEXT:Lokhttp3/ConnectionSpec;

    const-string v8, "CLEARTEXT"

    invoke-static {v3, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v8, 0x2

    aput-object v3, v7, v8

    invoke-static {v7}, Lkotlin/collections/CollectionsKt;->mutableListOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    invoke-virtual {v6, v3}, Lokhttp3/OkHttpClient$Builder;->connectionSpecs(Ljava/util/List;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    new-instance v6, Lcom/rokid/security/sdk/ability/net/RetrofitClient$$ExternalSyntheticLambda3;

    invoke-direct {v6}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$$ExternalSyntheticLambda3;-><init>()V

    .line 87
    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient$Builder;->eventListenerFactory(Lokhttp3/EventListener$Factory;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 88
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->initInterceptor()Lokhttp3/logging/HttpLoggingInterceptor;

    move-result-object v6

    check-cast v6, Lokhttp3/Interceptor;

    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 89
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->initHeadInterceptor()Lokhttp3/Interceptor;

    move-result-object v6

    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 90
    sget-object v6, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    check-cast v6, Lokhttp3/Interceptor;

    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 91
    const-wide/16 v6, 0x78

    sget-object v8, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v6, v7, v8}, Lokhttp3/OkHttpClient$Builder;->callTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 92
    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v7, 0x1e

    invoke-virtual {v3, v7, v8, v6}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 93
    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v7, v8, v6}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 94
    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v7, v8, v6}, Lokhttp3/OkHttpClient$Builder;->writeTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 95
    invoke-virtual {v3, v0}, Lokhttp3/OkHttpClient$Builder;->retryOnConnectionFailure(Z)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 96
    new-instance v3, Lokhttp3/ConnectionPool;

    const-wide/16 v6, 0xa

    sget-object v8, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const/16 v9, 0xf

    invoke-direct {v3, v9, v6, v7, v8}, Lokhttp3/ConnectionPool;-><init>(IJLjava/util/concurrent/TimeUnit;)V

    invoke-virtual {v0, v3}, Lokhttp3/OkHttpClient$Builder;->connectionPool(Lokhttp3/ConnectionPool;)Lokhttp3/OkHttpClient$Builder;

    .line 97
    invoke-virtual {v5}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    const-string v3, "builder.build()"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method private static final getClient$lambda$0(Lokhttp3/Call;)Lokhttp3/EventListener;
    .locals 1
    .param p0, "it"    # Lokhttp3/Call;

    .line 87
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpTimingEventListener;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpTimingEventListener;-><init>()V

    check-cast v0, Lokhttp3/EventListener;

    return-object v0
.end method

.method private static final getClient2$lambda$1(Lokhttp3/Call;)Lokhttp3/EventListener;
    .locals 1
    .param p0, "it"    # Lokhttp3/Call;

    .line 124
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpTimingEventListener;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpTimingEventListener;-><init>()V

    check-cast v0, Lokhttp3/EventListener;

    return-object v0
.end method

.method private final getDownloadClient(Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)Lokhttp3/OkHttpClient;
    .locals 8
    .param p1, "downloadListener"    # Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;

    .line 140
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactory()Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v0

    .line 141
    .local v0, "sslParams":Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    new-instance v1, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v1}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 142
    .local v1, "builder":Lokhttp3/OkHttpClient$Builder;
    sget-object v2, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getMethodProfix()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-lez v2, :cond_0

    move v2, v4

    goto :goto_0

    :cond_0
    move v2, v3

    :goto_0
    if-eqz v2, :cond_1

    .line 143
    new-instance v2, Lcom/rokid/security/sdk/ability/net/RetrofitClient$DynamicUrlInterceptor;

    sget-object v5, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getMethodProfix()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v2, v5}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$DynamicUrlInterceptor;-><init>(Ljava/lang/String;)V

    check-cast v2, Lokhttp3/Interceptor;

    invoke-virtual {v1, v2}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    .line 145
    :cond_1
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->sSLSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    iget-object v5, v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->trustManager:Ljavax/net/ssl/X509TrustManager;

    invoke-virtual {v1, v2, v5}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 146
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v5

    invoke-virtual {v2, v5}, Lokhttp3/OkHttpClient$Builder;->hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 147
    const/4 v5, 0x3

    new-array v5, v5, [Lokhttp3/ConnectionSpec;

    sget-object v6, Lokhttp3/ConnectionSpec;->MODERN_TLS:Lokhttp3/ConnectionSpec;

    aput-object v6, v5, v3

    sget-object v3, Lokhttp3/ConnectionSpec;->COMPATIBLE_TLS:Lokhttp3/ConnectionSpec;

    aput-object v3, v5, v4

    const/4 v3, 0x2

    sget-object v6, Lokhttp3/ConnectionSpec;->CLEARTEXT:Lokhttp3/ConnectionSpec;

    aput-object v6, v5, v3

    invoke-static {v5}, Lkotlin/collections/CollectionsKt;->mutableListOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    invoke-virtual {v2, v3}, Lokhttp3/OkHttpClient$Builder;->connectionSpecs(Ljava/util/List;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 149
    new-instance v3, Lcom/rokid/security/sdk/ability/net/RetrofitClient$ProgressInterceptor;

    invoke-direct {v3, p1}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$ProgressInterceptor;-><init>(Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)V

    check-cast v3, Lokhttp3/Interceptor;

    invoke-virtual {v2, v3}, Lokhttp3/OkHttpClient$Builder;->addNetworkInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 150
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->initHeadInterceptor()Lokhttp3/Interceptor;

    move-result-object v3

    invoke-virtual {v2, v3}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 151
    sget-object v3, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    check-cast v3, Lokhttp3/Interceptor;

    invoke-virtual {v2, v3}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 152
    const-wide/16 v5, 0xe10

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v2, v5, v6, v3}, Lokhttp3/OkHttpClient$Builder;->callTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 153
    const-wide/16 v5, 0x1e

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v2, v5, v6, v3}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 154
    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v5, 0x258

    invoke-virtual {v2, v5, v6, v3}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 155
    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v2, v5, v6, v3}, Lokhttp3/OkHttpClient$Builder;->writeTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 156
    invoke-virtual {v2, v4}, Lokhttp3/OkHttpClient$Builder;->retryOnConnectionFailure(Z)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 158
    new-instance v3, Lokhttp3/ConnectionPool;

    const-wide/16 v4, 0xa

    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const/16 v7, 0xf

    invoke-direct {v3, v7, v4, v5, v6}, Lokhttp3/ConnectionPool;-><init>(IJLjava/util/concurrent/TimeUnit;)V

    invoke-virtual {v2, v3}, Lokhttp3/OkHttpClient$Builder;->connectionPool(Lokhttp3/ConnectionPool;)Lokhttp3/OkHttpClient$Builder;

    .line 160
    invoke-virtual {v1}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v2

    const-string v3, "builder.build()"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v2
.end method

.method private final getDownloadRetrofit(Ljava/lang/String;Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)Lretrofit2/Retrofit;
    .locals 3
    .param p1, "hostUrl"    # Ljava/lang/String;
    .param p2, "downloadListener"    # Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;

    .line 356
    new-instance v0, Lretrofit2/Retrofit$Builder;

    invoke-direct {v0}, Lretrofit2/Retrofit$Builder;-><init>()V

    .line 357
    invoke-virtual {v0, p1}, Lretrofit2/Retrofit$Builder;->baseUrl(Ljava/lang/String;)Lretrofit2/Retrofit$Builder;

    move-result-object v0

    .line 358
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory;-><init>()V

    check-cast v1, Lretrofit2/CallAdapter$Factory;

    invoke-virtual {v0, v1}, Lretrofit2/Retrofit$Builder;->addCallAdapterFactory(Lretrofit2/CallAdapter$Factory;)Lretrofit2/Retrofit$Builder;

    move-result-object v0

    .line 359
    invoke-direct {p0, p2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->getDownloadClient(Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)Lokhttp3/OkHttpClient;

    move-result-object v1

    invoke-virtual {v0, v1}, Lretrofit2/Retrofit$Builder;->client(Lokhttp3/OkHttpClient;)Lretrofit2/Retrofit$Builder;

    move-result-object v0

    .line 360
    invoke-virtual {v0}, Lretrofit2/Retrofit$Builder;->build()Lretrofit2/Retrofit;

    move-result-object v0

    .line 361
    move-object v1, v0

    .line 385
    .local v1, "it":Lretrofit2/Retrofit;
    const/4 v2, 0x0

    .line 361
    .local v2, "$i$a$-also-RetrofitClient$getDownloadRetrofit$1":I
    iput-object v1, p0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->mDownloadRetrofit:Lretrofit2/Retrofit;

    .end local v1    # "it":Lretrofit2/Retrofit;
    .end local v2    # "$i$a$-also-RetrofitClient$getDownloadRetrofit$1":I
    const-string v1, "Builder()\n            .b\u2026 mDownloadRetrofit = it }"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 356
    return-object v0
.end method

.method private final initHeadInterceptor()Lokhttp3/Interceptor;
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$$ExternalSyntheticLambda0;-><init>()V

    .line 340
    return-object v0
.end method

.method private static final initHeadInterceptor$lambda$5(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;
    .locals 19
    .param p0, "chain"    # Lokhttp3/Interceptor$Chain;

    .line 284
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->ensureBusinessHeaders()V

    .line 285
    invoke-interface/range {p0 .. p0}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/Request;->newBuilder()Lokhttp3/Request$Builder;

    move-result-object v1

    .line 293
    .local v1, "build":Lokhttp3/Request$Builder;
    invoke-static {}, Lcom/rokid/utils/UUIDUtils;->generateUUID()Ljava/lang/String;

    move-result-object v2

    .line 294
    .local v2, "Request_Id":Ljava/lang/String;
    nop

    .line 295
    const-string v0, "Content-Type"

    const-string v3, "application/json"

    invoke-virtual {v1, v0, v3}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v0

    .line 296
    const-string v3, "clientType"

    const-string v4, "android"

    invoke-virtual {v0, v3, v4}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v0

    .line 297
    const-string v3, "Content-Disposition"

    const-string v4, "attachment"

    invoke-virtual {v0, v3, v4}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v0

    .line 298
    const-string v3, "X-Request-Id"

    invoke-virtual {v0, v3, v2}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v0

    .line 299
    move-object v3, v0

    .local v3, "$this$initHeadInterceptor_u24lambda_u245_u24lambda_u244":Lokhttp3/Request$Builder;
    const/4 v4, 0x0

    .line 300
    .local v4, "$i$a$-apply-RetrofitClient$initHeadInterceptor$1$newBuild$1":I
    sget-object v5, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v5

    const-string v6, "Accept-Language"

    invoke-virtual {v5, v6}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/CharSequence;

    if-eqz v5, :cond_1

    invoke-static {v5}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_0

    goto :goto_0

    :cond_0
    const/4 v5, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v5, 0x1

    :goto_1
    if-eqz v5, :cond_2

    .line 301
    sget-object v5, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->refreshAcceptLanguageFromSystemLocale()V

    .line 303
    :cond_2
    invoke-interface/range {p0 .. p0}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v5

    invoke-virtual {v5}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v5

    invoke-virtual {v5}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object v5

    const-string v7, "chain.request().url().toString()"

    invoke-static {v5, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 304
    .local v5, "url":Ljava/lang/String;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "initHeadInterceptor: url = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " Request_Id:"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    const-string v8, "HeadInterceptor"

    invoke-static {v8, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 305
    const/4 v7, 0x0

    .local v7, "path":Ljava/lang/Object;
    invoke-interface/range {p0 .. p0}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v9

    invoke-virtual {v9}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v9

    invoke-virtual {v9}, Lokhttp3/HttpUrl;->encodedPath()Ljava/lang/String;

    move-result-object v7

    .line 307
    sget-object v9, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v9}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getResList()Ljava/util/List;

    move-result-object v9

    check-cast v9, Ljava/lang/Iterable;

    .local v9, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v10, 0x0

    .line 386
    .local v10, "$i$f$forEach":I
    invoke-interface {v9}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :goto_2
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v12

    if-eqz v12, :cond_4

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    .local v12, "element$iv":Ljava/lang/Object;
    move-object v13, v12

    check-cast v13, Lcom/rokid/security/phone/sdk/base/data/ResItem;

    .local v13, "it":Lcom/rokid/security/phone/sdk/base/data/ResItem;
    const/4 v14, 0x0

    .line 308
    .local v14, "$i$a$-forEach-RetrofitClient$initHeadInterceptor$1$newBuild$1$1":I
    invoke-virtual {v13}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResourceAddress()Ljava/lang/String;

    move-result-object v15

    check-cast v15, Ljava/lang/CharSequence;

    const-string v6, "path"

    invoke-static {v7, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v6, v7

    check-cast v6, Ljava/lang/CharSequence;

    move-object/from16 v16, v1

    .end local v1    # "build":Lokhttp3/Request$Builder;
    .local v16, "build":Lokhttp3/Request$Builder;
    const/4 v1, 0x2

    move-object/from16 v17, v2

    .end local v2    # "Request_Id":Ljava/lang/String;
    .local v17, "Request_Id":Ljava/lang/String;
    const/4 v2, 0x0

    move/from16 v18, v4

    const/4 v4, 0x0

    .end local v4    # "$i$a$-apply-RetrofitClient$initHeadInterceptor$1$newBuild$1":I
    .local v18, "$i$a$-apply-RetrofitClient$initHeadInterceptor$1$newBuild$1":I
    invoke-static {v15, v6, v4, v1, v2}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 310
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/net/utils/UrlUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/UrlUtils;

    invoke-virtual {v13}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResourceAddress()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/UrlUtils;->getSegmentFromUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 312
    .local v1, "prex":Ljava/lang/String;
    invoke-interface/range {p0 .. p0}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/HttpUrl;->newBuilder()Lokhttp3/HttpUrl$Builder;

    move-result-object v2

    .line 313
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Lokhttp3/HttpUrl$Builder;->encodedPath(Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v2

    .line 314
    invoke-virtual {v2}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v2

    .line 312
    nop

    .line 315
    .local v2, "newUrl":Lokhttp3/HttpUrl;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "initHeadInterceptor: newUrl = "

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v8, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 316
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "initHeadInterceptor: newUrl2 = "

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v8, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 318
    invoke-virtual {v3, v2}, Lokhttp3/Request$Builder;->url(Lokhttp3/HttpUrl;)Lokhttp3/Request$Builder;

    .line 319
    const-string v6, "resId"

    invoke-virtual {v13}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResId()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v3, v6, v15}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 320
    const-string v6, "resOrgId"

    invoke-virtual {v13}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResOrgId()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v3, v6, v15}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 321
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "add headers [resId,"

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v13}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResId()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v15, "] "

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v8, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 322
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "add headers [resOrgId,"

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v13}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResOrgId()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v8, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 324
    .end local v1    # "prex":Ljava/lang/String;
    .end local v2    # "newUrl":Lokhttp3/HttpUrl;
    :cond_3
    nop

    .line 386
    .end local v13    # "it":Lcom/rokid/security/phone/sdk/base/data/ResItem;
    .end local v14    # "$i$a$-forEach-RetrofitClient$initHeadInterceptor$1$newBuild$1$1":I
    move-object/from16 v1, v16

    move-object/from16 v2, v17

    move/from16 v4, v18

    .end local v12    # "element$iv":Ljava/lang/Object;
    goto/16 :goto_2

    .line 387
    .end local v16    # "build":Lokhttp3/Request$Builder;
    .end local v17    # "Request_Id":Ljava/lang/String;
    .end local v18    # "$i$a$-apply-RetrofitClient$initHeadInterceptor$1$newBuild$1":I
    .local v1, "build":Lokhttp3/Request$Builder;
    .local v2, "Request_Id":Ljava/lang/String;
    .restart local v4    # "$i$a$-apply-RetrofitClient$initHeadInterceptor$1$newBuild$1":I
    :cond_4
    move-object/from16 v16, v1

    move-object/from16 v17, v2

    move/from16 v18, v4

    .line 325
    .end local v1    # "build":Lokhttp3/Request$Builder;
    .end local v2    # "Request_Id":Ljava/lang/String;
    .end local v4    # "$i$a$-apply-RetrofitClient$initHeadInterceptor$1$newBuild$1":I
    .end local v9    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v10    # "$i$f$forEach":I
    .restart local v16    # "build":Lokhttp3/Request$Builder;
    .restart local v17    # "Request_Id":Ljava/lang/String;
    .restart local v18    # "$i$a$-apply-RetrofitClient$initHeadInterceptor$1$newBuild$1":I
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v1

    new-instance v2, Lcom/rokid/security/sdk/ability/net/RetrofitClient$initHeadInterceptor$1$newBuild$1$2;

    invoke-direct {v2, v3}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$initHeadInterceptor$1$newBuild$1$2;-><init>(Lokhttp3/Request$Builder;)V

    check-cast v2, Lkotlin/jvm/functions/Function2;

    new-instance v4, Lcom/rokid/security/sdk/ability/net/RetrofitClient$$ExternalSyntheticLambda1;

    invoke-direct {v4, v2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$$ExternalSyntheticLambda1;-><init>(Lkotlin/jvm/functions/Function2;)V

    invoke-virtual {v1, v4}, Ljava/util/concurrent/ConcurrentHashMap;->forEach(Ljava/util/function/BiConsumer;)V

    .line 329
    nop

    .line 299
    .end local v3    # "$this$initHeadInterceptor_u24lambda_u245_u24lambda_u244":Lokhttp3/Request$Builder;
    .end local v5    # "url":Ljava/lang/String;
    .end local v7    # "path":Ljava/lang/Object;
    .end local v18    # "$i$a$-apply-RetrofitClient$initHeadInterceptor$1$newBuild$1":I
    nop

    .line 331
    invoke-virtual {v0}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v0

    .line 294
    move-object v1, v0

    .line 334
    .local v1, "newBuild":Lokhttp3/Request;
    nop

    .line 335
    move-object/from16 v2, p0

    :try_start_0
    invoke-interface {v2, v1}, Lokhttp3/Interceptor$Chain;->proceed(Lokhttp3/Request;)Lokhttp3/Response;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 336
    :catch_0
    move-exception v0

    move-object v3, v0

    move-object v0, v3

    .line 337
    .local v0, "e":Ljava/lang/Exception;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "request failed type="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v8, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 338
    throw v0
.end method

.method private static final initHeadInterceptor$lambda$5$lambda$4$lambda$3(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function2;
    .param p1, "p0"    # Ljava/lang/Object;
    .param p2, "p1"    # Ljava/lang/Object;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 325
    invoke-interface {p0, p1, p2}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private final initInterceptor()Lokhttp3/logging/HttpLoggingInterceptor;
    .locals 2

    .line 272
    new-instance v0, Lokhttp3/logging/HttpLoggingInterceptor;

    invoke-direct {v0}, Lokhttp3/logging/HttpLoggingInterceptor;-><init>()V

    .line 276
    .local v0, "loggingInterceptor":Lokhttp3/logging/HttpLoggingInterceptor;
    sget-object v1, Lokhttp3/logging/HttpLoggingInterceptor$Level;->BASIC:Lokhttp3/logging/HttpLoggingInterceptor$Level;

    invoke-virtual {v0, v1}, Lokhttp3/logging/HttpLoggingInterceptor;->setLevel(Lokhttp3/logging/HttpLoggingInterceptor$Level;)Lokhttp3/logging/HttpLoggingInterceptor;

    .line 277
    return-object v0
.end method


# virtual methods
.method public final create(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "service"    # Ljava/lang/Class;
    .param p2, "hostUrl"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;",
            "Ljava/lang/String;",
            ")TT;"
        }
    .end annotation

    const-string/jumbo v0, "service"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "hostUrl"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 367
    sget-object v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->instance:Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->getRetrofit(Ljava/lang/String;)Lretrofit2/Retrofit;

    move-result-object v0

    invoke-virtual {v0, p1}, Lretrofit2/Retrofit;->create(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final createDownloadService(Ljava/lang/Class;Ljava/lang/String;Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)Ljava/lang/Object;
    .locals 1
    .param p1, "service"    # Ljava/lang/Class;
    .param p2, "hostUrl"    # Ljava/lang/String;
    .param p3, "downloadListener"    # Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;",
            ")TT;"
        }
    .end annotation

    const-string/jumbo v0, "service"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "hostUrl"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "downloadListener"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 370
    sget-object v0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->instance:Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    invoke-direct {v0, p2, p3}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->getDownloadRetrofit(Ljava/lang/String;Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)Lretrofit2/Retrofit;

    move-result-object v0

    invoke-virtual {v0, p1}, Lretrofit2/Retrofit;->create(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final getClient2()Lokhttp3/OkHttpClient;
    .locals 10

    .line 103
    const/4 v0, 0x1

    new-array v1, v0, [Ljavax/net/ssl/TrustManager;

    new-instance v2, Lcom/rokid/security/sdk/ability/net/RetrofitClient$getClient2$trustAllCerts$1;

    invoke-direct {v2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$getClient2$trustAllCerts$1;-><init>()V

    const/4 v3, 0x0

    aput-object v2, v1, v3

    .line 102
    nop

    .line 110
    .local v1, "trustAllCerts":[Ljavax/net/ssl/TrustManager;
    const-string v2, "TLS"

    invoke-static {v2}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v2

    .line 111
    .local v2, "sslContext":Ljavax/net/ssl/SSLContext;
    new-instance v4, Ljava/security/SecureRandom;

    invoke-direct {v4}, Ljava/security/SecureRandom;-><init>()V

    const/4 v5, 0x0

    invoke-virtual {v2, v5, v1, v4}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 115
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactory()Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v4

    .line 116
    .local v4, "sslParams":Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    new-instance v5, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v5}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 117
    .local v5, "builder":Lokhttp3/OkHttpClient$Builder;
    sget-object v6, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getMethodProfix()Ljava/lang/String;

    move-result-object v6

    check-cast v6, Ljava/lang/CharSequence;

    invoke-interface {v6}, Ljava/lang/CharSequence;->length()I

    move-result v6

    if-lez v6, :cond_0

    move v6, v0

    goto :goto_0

    :cond_0
    move v6, v3

    :goto_0
    if-eqz v6, :cond_1

    .line 118
    new-instance v6, Lcom/rokid/security/sdk/ability/net/RetrofitClient$DynamicUrlInterceptor;

    sget-object v7, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v7}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getMethodProfix()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$DynamicUrlInterceptor;-><init>(Ljava/lang/String;)V

    check-cast v6, Lokhttp3/Interceptor;

    invoke-virtual {v5, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    .line 120
    :cond_1
    iget-object v6, v4, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->sSLSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    iget-object v7, v4, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->trustManager:Ljavax/net/ssl/X509TrustManager;

    invoke-virtual {v5, v6, v7}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v6

    .line 121
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v7

    invoke-virtual {v6, v7}, Lokhttp3/OkHttpClient$Builder;->hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v6

    .line 122
    const/4 v7, 0x3

    new-array v7, v7, [Lokhttp3/ConnectionSpec;

    sget-object v8, Lokhttp3/ConnectionSpec;->MODERN_TLS:Lokhttp3/ConnectionSpec;

    const-string v9, "MODERN_TLS"

    invoke-static {v8, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    aput-object v8, v7, v3

    sget-object v3, Lokhttp3/ConnectionSpec;->COMPATIBLE_TLS:Lokhttp3/ConnectionSpec;

    const-string v8, "COMPATIBLE_TLS"

    invoke-static {v3, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    aput-object v3, v7, v0

    sget-object v3, Lokhttp3/ConnectionSpec;->CLEARTEXT:Lokhttp3/ConnectionSpec;

    const-string v8, "CLEARTEXT"

    invoke-static {v3, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v8, 0x2

    aput-object v3, v7, v8

    invoke-static {v7}, Lkotlin/collections/CollectionsKt;->mutableListOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    invoke-virtual {v6, v3}, Lokhttp3/OkHttpClient$Builder;->connectionSpecs(Ljava/util/List;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    new-instance v6, Lcom/rokid/security/sdk/ability/net/RetrofitClient$$ExternalSyntheticLambda2;

    invoke-direct {v6}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$$ExternalSyntheticLambda2;-><init>()V

    .line 124
    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient$Builder;->eventListenerFactory(Lokhttp3/EventListener$Factory;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 125
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->initInterceptor()Lokhttp3/logging/HttpLoggingInterceptor;

    move-result-object v6

    check-cast v6, Lokhttp3/Interceptor;

    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 126
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->initHeadInterceptor()Lokhttp3/Interceptor;

    move-result-object v6

    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 127
    sget-object v6, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    check-cast v6, Lokhttp3/Interceptor;

    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 128
    const-wide/16 v6, 0x78

    sget-object v8, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v6, v7, v8}, Lokhttp3/OkHttpClient$Builder;->callTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 129
    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v7, 0x1e

    invoke-virtual {v3, v7, v8, v6}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 130
    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v7, v8, v6}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 131
    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v7, v8, v6}, Lokhttp3/OkHttpClient$Builder;->writeTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 132
    invoke-virtual {v3, v0}, Lokhttp3/OkHttpClient$Builder;->retryOnConnectionFailure(Z)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 133
    new-instance v3, Lokhttp3/ConnectionPool;

    const-wide/16 v6, 0xa

    sget-object v8, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const/16 v9, 0xf

    invoke-direct {v3, v9, v6, v7, v8}, Lokhttp3/ConnectionPool;-><init>(IJLjava/util/concurrent/TimeUnit;)V

    invoke-virtual {v0, v3}, Lokhttp3/OkHttpClient$Builder;->connectionPool(Lokhttp3/ConnectionPool;)Lokhttp3/OkHttpClient$Builder;

    .line 134
    invoke-virtual {v5}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    const-string v3, "builder.build()"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method public final getGlideOkhttpClient()Lokhttp3/OkHttpClient;
    .locals 7

    .line 254
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactory()Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v0

    .line 255
    .local v0, "sslParams":Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    new-instance v1, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v1}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 256
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->sSLSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->trustManager:Ljavax/net/ssl/X509TrustManager;

    invoke-virtual {v1, v2, v3}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 257
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v2

    invoke-virtual {v1, v2}, Lokhttp3/OkHttpClient$Builder;->hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 258
    const/4 v2, 0x3

    new-array v2, v2, [Lokhttp3/ConnectionSpec;

    sget-object v3, Lokhttp3/ConnectionSpec;->MODERN_TLS:Lokhttp3/ConnectionSpec;

    const-string v4, "MODERN_TLS"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v4, 0x0

    aput-object v3, v2, v4

    sget-object v3, Lokhttp3/ConnectionSpec;->COMPATIBLE_TLS:Lokhttp3/ConnectionSpec;

    const-string v4, "COMPATIBLE_TLS"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v4, 0x1

    aput-object v3, v2, v4

    sget-object v3, Lokhttp3/ConnectionSpec;->CLEARTEXT:Lokhttp3/ConnectionSpec;

    const-string v5, "CLEARTEXT"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v5, 0x2

    aput-object v3, v2, v5

    invoke-static {v2}, Lkotlin/collections/CollectionsKt;->mutableListOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Lokhttp3/OkHttpClient$Builder;->connectionSpecs(Ljava/util/List;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 259
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->initInterceptor()Lokhttp3/logging/HttpLoggingInterceptor;

    move-result-object v2

    check-cast v2, Lokhttp3/Interceptor;

    invoke-virtual {v1, v2}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 260
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->initHeadInterceptor()Lokhttp3/Interceptor;

    move-result-object v2

    invoke-virtual {v1, v2}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 261
    sget-object v2, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    check-cast v2, Lokhttp3/Interceptor;

    invoke-virtual {v1, v2}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 262
    const-wide/16 v2, 0x78

    sget-object v5, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v1, v2, v3, v5}, Lokhttp3/OkHttpClient$Builder;->callTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 263
    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v5, 0x1e

    invoke-virtual {v1, v5, v6, v2}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 264
    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v1, v5, v6, v2}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 265
    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v1, v5, v6, v2}, Lokhttp3/OkHttpClient$Builder;->writeTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 266
    invoke-virtual {v1, v4}, Lokhttp3/OkHttpClient$Builder;->retryOnConnectionFailure(Z)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 267
    new-instance v2, Lokhttp3/ConnectionPool;

    const-wide/16 v3, 0xa

    sget-object v5, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const/16 v6, 0xf

    invoke-direct {v2, v6, v3, v4, v5}, Lokhttp3/ConnectionPool;-><init>(IJLjava/util/concurrent/TimeUnit;)V

    invoke-virtual {v1, v2}, Lokhttp3/OkHttpClient$Builder;->connectionPool(Lokhttp3/ConnectionPool;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v1

    .line 255
    nop

    .line 268
    .local v1, "builder":Lokhttp3/OkHttpClient$Builder;
    invoke-virtual {v1}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v2

    const-string v3, "builder.build()"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v2
.end method

.method public final getMinioClient()Lokhttp3/OkHttpClient;
    .locals 10

    .line 219
    const/4 v0, 0x1

    new-array v1, v0, [Ljavax/net/ssl/TrustManager;

    new-instance v2, Lcom/rokid/security/sdk/ability/net/RetrofitClient$getMinioClient$trustAllCerts$1;

    invoke-direct {v2}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$getMinioClient$trustAllCerts$1;-><init>()V

    const/4 v3, 0x0

    aput-object v2, v1, v3

    .line 218
    nop

    .line 226
    .local v1, "trustAllCerts":[Ljavax/net/ssl/TrustManager;
    const-string v2, "TLS"

    invoke-static {v2}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v2

    .line 227
    .local v2, "sslContext":Ljavax/net/ssl/SSLContext;
    new-instance v4, Ljava/security/SecureRandom;

    invoke-direct {v4}, Ljava/security/SecureRandom;-><init>()V

    const/4 v5, 0x0

    invoke-virtual {v2, v5, v1, v4}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 231
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getSslSocketFactory()Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;

    move-result-object v4

    .line 232
    .local v4, "sslParams":Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;
    new-instance v5, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v5}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 233
    .local v5, "builder":Lokhttp3/OkHttpClient$Builder;
    sget-object v6, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getMethodProfix()Ljava/lang/String;

    move-result-object v6

    check-cast v6, Ljava/lang/CharSequence;

    invoke-interface {v6}, Ljava/lang/CharSequence;->length()I

    move-result v6

    if-lez v6, :cond_0

    move v6, v0

    goto :goto_0

    :cond_0
    move v6, v3

    :goto_0
    if-eqz v6, :cond_1

    .line 234
    new-instance v6, Lcom/rokid/security/sdk/ability/net/RetrofitClient$DynamicUrlInterceptor;

    sget-object v7, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v7}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getMethodProfix()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$DynamicUrlInterceptor;-><init>(Ljava/lang/String;)V

    check-cast v6, Lokhttp3/Interceptor;

    invoke-virtual {v5, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    .line 236
    :cond_1
    iget-object v6, v4, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->sSLSocketFactory:Ljavax/net/ssl/SSLSocketFactory;

    iget-object v7, v4, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils$SSLParams;->trustManager:Ljavax/net/ssl/X509TrustManager;

    invoke-virtual {v5, v6, v7}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v6

    .line 237
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/HttpsUtils;->getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;

    move-result-object v7

    invoke-virtual {v6, v7}, Lokhttp3/OkHttpClient$Builder;->hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v6

    .line 238
    const/4 v7, 0x3

    new-array v7, v7, [Lokhttp3/ConnectionSpec;

    sget-object v8, Lokhttp3/ConnectionSpec;->MODERN_TLS:Lokhttp3/ConnectionSpec;

    const-string v9, "MODERN_TLS"

    invoke-static {v8, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    aput-object v8, v7, v3

    sget-object v3, Lokhttp3/ConnectionSpec;->COMPATIBLE_TLS:Lokhttp3/ConnectionSpec;

    const-string v8, "COMPATIBLE_TLS"

    invoke-static {v3, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    aput-object v3, v7, v0

    sget-object v3, Lokhttp3/ConnectionSpec;->CLEARTEXT:Lokhttp3/ConnectionSpec;

    const-string v8, "CLEARTEXT"

    invoke-static {v3, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v8, 0x2

    aput-object v3, v7, v8

    invoke-static {v7}, Lkotlin/collections/CollectionsKt;->mutableListOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    invoke-virtual {v6, v3}, Lokhttp3/OkHttpClient$Builder;->connectionSpecs(Ljava/util/List;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 239
    sget-object v6, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/MinioHttpLoggingInterceptor;->create()Lokhttp3/Interceptor;

    move-result-object v6

    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 240
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->initHeadInterceptor()Lokhttp3/Interceptor;

    move-result-object v6

    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 241
    sget-object v6, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    check-cast v6, Lokhttp3/Interceptor;

    invoke-virtual {v3, v6}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 242
    const-wide/16 v6, 0x78

    sget-object v8, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v6, v7, v8}, Lokhttp3/OkHttpClient$Builder;->callTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 243
    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v7, 0x1e

    invoke-virtual {v3, v7, v8, v6}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 244
    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v7, v8, v6}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 245
    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v3, v7, v8, v6}, Lokhttp3/OkHttpClient$Builder;->writeTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v3

    .line 246
    invoke-virtual {v3, v0}, Lokhttp3/OkHttpClient$Builder;->retryOnConnectionFailure(Z)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 247
    new-instance v3, Lokhttp3/ConnectionPool;

    const-wide/16 v6, 0xa

    sget-object v8, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const/16 v9, 0xf

    invoke-direct {v3, v9, v6, v7, v8}, Lokhttp3/ConnectionPool;-><init>(IJLjava/util/concurrent/TimeUnit;)V

    invoke-virtual {v0, v3}, Lokhttp3/OkHttpClient$Builder;->connectionPool(Lokhttp3/ConnectionPool;)Lokhttp3/OkHttpClient$Builder;

    .line 248
    invoke-virtual {v5}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    const-string v3, "builder.build()"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method public final getOkHttpClient()Lokhttp3/OkHttpClient;
    .locals 1

    .line 58
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->okHttpClient$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/OkHttpClient;

    return-object v0
.end method

.method public final getRetrofit(Ljava/lang/String;)Lretrofit2/Retrofit;
    .locals 3
    .param p1, "hostUrl"    # Ljava/lang/String;

    const-string v0, "hostUrl"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 343
    new-instance v0, Lretrofit2/Retrofit$Builder;

    invoke-direct {v0}, Lretrofit2/Retrofit$Builder;-><init>()V

    .line 344
    invoke-virtual {v0, p1}, Lretrofit2/Retrofit$Builder;->baseUrl(Ljava/lang/String;)Lretrofit2/Retrofit$Builder;

    move-result-object v0

    .line 345
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lretrofit2/Retrofit$Builder;->validateEagerly(Z)Lretrofit2/Retrofit$Builder;

    move-result-object v0

    .line 346
    invoke-static {}, Lretrofit2/converter/gson/GsonConverterFactory;->create()Lretrofit2/converter/gson/GsonConverterFactory;

    move-result-object v1

    check-cast v1, Lretrofit2/Converter$Factory;

    invoke-virtual {v0, v1}, Lretrofit2/Retrofit$Builder;->addConverterFactory(Lretrofit2/Converter$Factory;)Lretrofit2/Retrofit$Builder;

    move-result-object v0

    .line 347
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory;-><init>()V

    check-cast v1, Lretrofit2/CallAdapter$Factory;

    invoke-virtual {v0, v1}, Lretrofit2/Retrofit$Builder;->addCallAdapterFactory(Lretrofit2/CallAdapter$Factory;)Lretrofit2/Retrofit$Builder;

    move-result-object v0

    .line 348
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->getClient()Lokhttp3/OkHttpClient;

    move-result-object v1

    invoke-virtual {v0, v1}, Lretrofit2/Retrofit$Builder;->client(Lokhttp3/OkHttpClient;)Lretrofit2/Retrofit$Builder;

    move-result-object v0

    .line 349
    invoke-virtual {v0}, Lretrofit2/Retrofit$Builder;->build()Lretrofit2/Retrofit;

    move-result-object v0

    .line 350
    move-object v1, v0

    .line 385
    .local v1, "it":Lretrofit2/Retrofit;
    const/4 v2, 0x0

    .line 350
    .local v2, "$i$a$-also-RetrofitClient$getRetrofit$1":I
    iput-object v1, p0, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->mRetrofit:Lretrofit2/Retrofit;

    .end local v1    # "it":Lretrofit2/Retrofit;
    .end local v2    # "$i$a$-also-RetrofitClient$getRetrofit$1":I
    const-string v1, "Builder()\n            .b\u2026 .also { mRetrofit = it }"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 343
    return-object v0
.end method
