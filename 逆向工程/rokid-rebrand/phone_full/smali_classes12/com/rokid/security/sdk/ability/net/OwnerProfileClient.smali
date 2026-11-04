.class public final Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;
.super Ljava/lang/Object;
.source "OwnerProfileClient.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOwnerProfileClient.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OwnerProfileClient.kt\ncom/rokid/security/sdk/ability/net/OwnerProfileClient\n+ 2 _Maps.kt\nkotlin/collections/MapsKt___MapsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,127:1\n215#2,2:128\n1#3:130\n*S KotlinDebug\n*F\n+ 1 OwnerProfileClient.kt\ncom/rokid/security/sdk/ability/net/OwnerProfileClient\n*L\n70#1:128,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00006\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J4\u0010\u000f\u001a\u0004\u0018\u00010\u00102\u0006\u0010\u0011\u001a\u00020\u00062\u0006\u0010\u0012\u001a\u00020\u00062\u0006\u0010\u0013\u001a\u00020\u00062\u0008\u0008\u0002\u0010\u0014\u001a\u00020\u00152\u0008\u0008\u0002\u0010\u0016\u001a\u00020\u0015J2\u0010\u0017\u001a\u00020\u00182\u0006\u0010\u0011\u001a\u00020\u00062\u0006\u0010\u0012\u001a\u00020\u00062\u0006\u0010\u0013\u001a\u00020\u00062\u0008\u0008\u0002\u0010\u0014\u001a\u00020\u00152\u0008\u0008\u0002\u0010\u0016\u001a\u00020\u0015R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0086T\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u0007\u001a\n \t*\u0004\u0018\u00010\u00080\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R#\u0010\n\u001a\n \t*\u0004\u0018\u00010\u00080\u00088BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\r\u0010\u000e\u001a\u0004\u0008\u000b\u0010\u000c\u00a8\u0006\u0019"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;",
        "",
        "()V",
        "MAX_RESPONSE_CHARS",
        "",
        "PATH",
        "",
        "client",
        "Lokhttp3/OkHttpClient;",
        "kotlin.jvm.PlatformType",
        "privateClient",
        "getPrivateClient",
        "()Lokhttp3/OkHttpClient;",
        "privateClient$delegate",
        "Lkotlin/Lazy;",
        "fetch",
        "Lcom/rokid/security/sdk/ability/net/OwnerProfile;",
        "endpoint",
        "token",
        "companyId",
        "privateDeployment",
        "",
        "deferLocalTokenInvalidation",
        "fetchResult",
        "Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;",
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;

.field private static final MAX_RESPONSE_CHARS:I = 0x8000

.field public static final PATH:Ljava/lang/String; = "ar/iam/user/owner"

.field private static final client:Lokhttp3/OkHttpClient;

.field private static final privateClient$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;

    .line 21
    nop

    .line 14
    new-instance v0, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v0}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 15
    const-wide/16 v1, 0xa

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, v2, v3}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 16
    const-wide/16 v1, 0xf

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, v2, v3}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 17
    const-wide/16 v1, 0x14

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, v2, v3}, Lokhttp3/OkHttpClient$Builder;->callTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 18
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lokhttp3/OkHttpClient$Builder;->followRedirects(Z)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 19
    invoke-virtual {v0, v1}, Lokhttp3/OkHttpClient$Builder;->followSslRedirects(Z)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 20
    sget-object v1, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    check-cast v1, Lokhttp3/Interceptor;

    invoke-virtual {v0, v1}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 21
    invoke-virtual {v0}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->client:Lokhttp3/OkHttpClient;

    .line 24
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileClient$privateClient$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->privateClient$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getClient$p()Lokhttp3/OkHttpClient;
    .locals 1

    .line 11
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->client:Lokhttp3/OkHttpClient;

    return-object v0
.end method

.method public static synthetic fetch$default(Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZILjava/lang/Object;)Lcom/rokid/security/sdk/ability/net/OwnerProfile;
    .locals 7

    .line 36
    and-int/lit8 p7, p6, 0x8

    const/4 v0, 0x0

    if-eqz p7, :cond_0

    .line 40
    move v5, v0

    goto :goto_0

    .line 36
    :cond_0
    move v5, p4

    :goto_0
    and-int/lit8 p4, p6, 0x10

    if-eqz p4, :cond_1

    .line 41
    move v6, v0

    goto :goto_1

    .line 36
    :cond_1
    move v6, p5

    :goto_1
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    invoke-virtual/range {v1 .. v6}, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->fetch(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic fetchResult$default(Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZILjava/lang/Object;)Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;
    .locals 7

    .line 60
    and-int/lit8 p7, p6, 0x8

    const/4 v0, 0x0

    if-eqz p7, :cond_0

    .line 64
    move v5, v0

    goto :goto_0

    .line 60
    :cond_0
    move v5, p4

    :goto_0
    and-int/lit8 p4, p6, 0x10

    if-eqz p4, :cond_1

    .line 65
    move v6, v0

    goto :goto_1

    .line 60
    :cond_1
    move v6, p5

    :goto_1
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    invoke-virtual/range {v1 .. v6}, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->fetchResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    move-result-object p0

    return-object p0
.end method

.method private final getPrivateClient()Lokhttp3/OkHttpClient;
    .locals 1

    .line 24
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->privateClient$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lokhttp3/OkHttpClient;

    return-object v0
.end method


# virtual methods
.method public final fetch(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/rokid/security/sdk/ability/net/OwnerProfile;
    .locals 2
    .param p1, "endpoint"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;
    .param p3, "companyId"    # Ljava/lang/String;
    .param p4, "privateDeployment"    # Z
    .param p5, "deferLocalTokenInvalidation"    # Z

    const-string v0, "endpoint"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "token"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "companyId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    nop

    .line 44
    nop

    .line 45
    nop

    .line 46
    nop

    .line 47
    nop

    .line 48
    nop

    .line 43
    invoke-virtual/range {p0 .. p5}, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->fetchResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    move-result-object v0

    .line 42
    .local v0, "result":Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;
    nop

    .line 51
    instance-of v1, v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;

    if-eqz v1, :cond_0

    move-object v1, v0

    check-cast v1, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;->getProfile()Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    move-result-object v1

    goto :goto_1

    .line 53
    :cond_0
    nop

    .line 52
    sget-object v1, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$TerminalCredentialFailure;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$TerminalCredentialFailure;

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v1, 0x1

    goto :goto_0

    .line 53
    :cond_1
    sget-object v1, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    :goto_0
    if-eqz v1, :cond_2

    const/4 v1, 0x0

    .line 54
    .end local v0    # "result":Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;
    :goto_1
    return-object v1

    .line 53
    .restart local v0    # "result":Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;
    :cond_2
    new-instance v1, Lkotlin/NoWhenBranchMatchedException;

    invoke-direct {v1}, Lkotlin/NoWhenBranchMatchedException;-><init>()V

    throw v1
.end method

.method public final fetchResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;
    .locals 19
    .param p1, "endpoint"    # Ljava/lang/String;
    .param p2, "token"    # Ljava/lang/String;
    .param p3, "companyId"    # Ljava/lang/String;
    .param p4, "privateDeployment"    # Z
    .param p5, "deferLocalTokenInvalidation"    # Z

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    const-string v0, "endpoint"

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "token"

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "companyId"

    invoke-static {v3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 67
    const/4 v5, 0x0

    const/4 v6, 0x0

    if-nez p4, :cond_1

    const-string v0, "https://"

    const/4 v7, 0x2

    invoke-static {v1, v0, v5, v7, v6}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    move v0, v5

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    if-eqz v0, :cond_19

    .line 68
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->ensureBusinessHeaders()V

    .line 69
    new-instance v0, Lokhttp3/Request$Builder;

    invoke-direct {v0}, Lokhttp3/Request$Builder;-><init>()V

    invoke-virtual {v0, v1}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v7

    .line 70
    .local v7, "request":Lokhttp3/Request$Builder;
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v0

    check-cast v0, Ljava/util/Map;

    .local v0, "$this$forEach$iv":Ljava/util/Map;
    const/4 v8, 0x0

    .line 128
    .local v8, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_2
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_2

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/util/Map$Entry;

    .local v10, "element$iv":Ljava/util/Map$Entry;
    const/4 v11, 0x0

    .line 70
    .local v11, "$i$a$-forEach-OwnerProfileClient$fetchResult$1":I
    invoke-interface {v10}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    .local v12, "key":Ljava/lang/String;
    invoke-interface {v10}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    .local v13, "value":Ljava/lang/String;
    invoke-virtual {v7, v12, v13}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 128
    .end local v11    # "$i$a$-forEach-OwnerProfileClient$fetchResult$1":I
    .end local v12    # "key":Ljava/lang/String;
    .end local v13    # "value":Ljava/lang/String;
    nop

    .end local v10    # "element$iv":Ljava/util/Map$Entry;
    goto :goto_2

    .line 129
    :cond_2
    nop

    .line 71
    .end local v0    # "$this$forEach$iv":Ljava/util/Map;
    .end local v8    # "$i$f$forEach":I
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Bearer "

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v2, v8}, Lkotlin/text/StringsKt;->removePrefix(Ljava/lang/String;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v8, "x-user-authorization"

    invoke-virtual {v7, v8, v0}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v0

    .line 72
    const-string v8, "X-Company-Id"

    invoke-virtual {v0, v8, v3}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 73
    if-eqz p5, :cond_3

    .line 74
    const-string v0, "X-Rokid-Defer-Local-Token-Invalidation"

    const-string v8, "1"

    invoke-virtual {v7, v0, v8}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 76
    :cond_3
    if-eqz p4, :cond_4

    invoke-direct/range {p0 .. p0}, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->getPrivateClient()Lokhttp3/OkHttpClient;

    move-result-object v0

    goto :goto_3

    :cond_4
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->client:Lokhttp3/OkHttpClient;

    :goto_3
    invoke-virtual {v7}, Lokhttp3/Request$Builder;->get()Lokhttp3/Request$Builder;

    move-result-object v8

    invoke-virtual {v8}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v8

    invoke-virtual {v0, v8}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v0

    invoke-interface {v0}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object v0

    move-object v8, v0

    check-cast v8, Ljava/io/Closeable;

    :try_start_0
    move-object v0, v8

    check-cast v0, Lokhttp3/Response;

    move-object v9, v0

    .local v9, "response":Lokhttp3/Response;
    const/4 v10, 0x0

    .line 77
    .local v10, "$i$a$-use-OwnerProfileClient$fetchResult$2":I
    invoke-virtual {v9}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v0

    if-nez v0, :cond_5

    sget-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;

    check-cast v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    goto/16 :goto_c

    :cond_5
    const-string v11, "response.body() ?: retur\u2026leFetchResult.Unavailable"

    invoke-static {v0, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v11, v0

    .line 78
    .local v11, "body":Lokhttp3/ResponseBody;
    invoke-virtual {v11}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v12

    const-wide/32 v14, 0x8000

    cmp-long v0, v12, v14

    if-lez v0, :cond_6

    .line 79
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;

    check-cast v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    goto/16 :goto_c

    .line 81
    :cond_6
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move-object v12, v0

    .line 82
    .local v12, "text":Ljava/lang/StringBuilder;
    const/16 v0, 0x400

    new-array v0, v0, [C

    move-object v13, v0

    .line 83
    .local v13, "buffer":[C
    invoke-virtual {v11}, Lokhttp3/ResponseBody;->charStream()Ljava/io/Reader;

    move-result-object v0

    move-object v14, v0

    check-cast v14, Ljava/io/Closeable;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    :try_start_1
    move-object v0, v14

    check-cast v0, Ljava/io/Reader;

    .local v0, "reader":Ljava/io/Reader;
    const/4 v15, 0x0

    .line 84
    .local v15, "$i$a$-use-OwnerProfileClient$fetchResult$2$1":I
    :goto_4
    nop

    .line 85
    invoke-virtual {v0, v13}, Ljava/io/Reader;->read([C)I

    move-result v16

    move/from16 v17, v16

    .line 86
    .local v17, "count":I
    move/from16 v4, v17

    .end local v17    # "count":I
    .local v4, "count":I
    if-ltz v4, :cond_8

    .line 87
    invoke-virtual {v12}, Ljava/lang/StringBuilder;->length()I

    move-result v17

    add-int v5, v17, v4

    const v6, 0x8000

    if-le v5, v6, :cond_7

    .line 88
    sget-object v5, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;

    check-cast v5, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .end local v0    # "reader":Ljava/io/Reader;
    .end local v4    # "count":I
    .end local v15    # "$i$a$-use-OwnerProfileClient$fetchResult$2$1":I
    const/4 v4, 0x0

    :try_start_2
    invoke-static {v14, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    move-object v0, v5

    goto/16 :goto_c

    .line 90
    .restart local v0    # "reader":Ljava/io/Reader;
    .restart local v4    # "count":I
    .restart local v15    # "$i$a$-use-OwnerProfileClient$fetchResult$2$1":I
    :cond_7
    const/4 v5, 0x0

    :try_start_3
    invoke-virtual {v12, v13, v5, v4}, Ljava/lang/StringBuilder;->append([CII)Ljava/lang/StringBuilder;

    const/4 v6, 0x0

    goto :goto_4

    .line 92
    .end local v4    # "count":I
    :cond_8
    nop

    .end local v0    # "reader":Ljava/io/Reader;
    .end local v15    # "$i$a$-use-OwnerProfileClient$fetchResult$2$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 83
    const/4 v4, 0x0

    :try_start_4
    invoke-static {v14, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 93
    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v4, "text.toString()"

    invoke-static {v0, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v0

    .line 94
    .local v4, "responseText":Ljava/lang/String;
    sget-object v0, Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;->INSTANCE:Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;

    invoke-virtual {v0, v4}, Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;->parse(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    .line 95
    if-nez v0, :cond_a

    :cond_9
    goto :goto_5

    :cond_a
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const v6, 0xc389

    if-ne v0, v6, :cond_9

    .line 97
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$TerminalCredentialFailure;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$TerminalCredentialFailure;

    check-cast v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    goto/16 :goto_c

    .line 99
    :goto_5
    invoke-virtual {v9}, Lokhttp3/Response;->isSuccessful()Z

    move-result v0

    if-nez v0, :cond_b

    sget-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;

    check-cast v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    goto/16 :goto_c

    .line 100
    :cond_b
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    :try_start_5
    sget-object v6, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    .line 130
    .local v0, "$this$fetchResult_u24lambda_u245_u24lambda_u242":Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;
    const/4 v6, 0x0

    .line 100
    .local v6, "$i$a$-runCatching-OwnerProfileClient$fetchResult$2$root$1":I
    new-instance v14, Lcom/google/gson/JsonParser;

    invoke-direct {v14}, Lcom/google/gson/JsonParser;-><init>()V

    invoke-virtual {v14, v4}, Lcom/google/gson/JsonParser;->parse(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v14

    invoke-virtual {v14}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v14

    .end local v0    # "$this$fetchResult_u24lambda_u245_u24lambda_u242":Lcom/rokid/security/sdk/ability/net/OwnerProfileClient;
    .end local v6    # "$i$a$-runCatching-OwnerProfileClient$fetchResult$2$root$1":I
    invoke-static {v14}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_6

    :catchall_0
    move-exception v0

    :try_start_6
    sget-object v6, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    :goto_6
    invoke-static {v0}, Lkotlin/Result;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_c

    const/4 v0, 0x0

    :cond_c
    check-cast v0, Lcom/google/gson/JsonObject;

    if-nez v0, :cond_d

    .line 101
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;

    check-cast v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    goto/16 :goto_c

    .line 102
    .local v0, "root":Lcom/google/gson/JsonObject;
    :cond_d
    const-string v6, "code"

    invoke-virtual {v0, v6}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v6

    if-eqz v6, :cond_e

    invoke-virtual {v6}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v6

    if-nez v6, :cond_e

    const/4 v5, 0x1

    :cond_e
    if-nez v5, :cond_f

    .line 103
    sget-object v5, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;

    check-cast v5, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    move-object v0, v5

    goto/16 :goto_c

    .line 105
    :cond_f
    const-string v5, "data"

    invoke-virtual {v0, v5}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v5

    if-nez v5, :cond_10

    .line 106
    sget-object v5, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;

    check-cast v5, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    move-object v0, v5

    goto/16 :goto_c

    .line 107
    .local v5, "data":Lcom/google/gson/JsonObject;
    :cond_10
    const-string/jumbo v6, "uid"

    invoke-virtual {v5, v6}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v6

    if-eqz v6, :cond_12

    const-string v14, "get(\"uid\")"

    invoke-static {v6, v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v14, v6

    .line 130
    .local v14, "it":Lcom/google/gson/JsonElement;
    const/4 v15, 0x0

    .line 107
    .local v15, "$i$a$-takeUnless-OwnerProfileClient$fetchResult$2$uid$1":I
    invoke-virtual {v14}, Lcom/google/gson/JsonElement;->isJsonNull()Z

    move-result v16

    .end local v14    # "it":Lcom/google/gson/JsonElement;
    .end local v15    # "$i$a$-takeUnless-OwnerProfileClient$fetchResult$2$uid$1":I
    if-nez v16, :cond_11

    goto :goto_7

    :cond_11
    const/4 v6, 0x0

    :goto_7
    if-eqz v6, :cond_12

    invoke-virtual {v6}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v6

    goto :goto_8

    :cond_12
    const/4 v6, 0x0

    :goto_8
    if-nez v6, :cond_13

    .line 108
    sget-object v6, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;

    check-cast v6, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    move-object v0, v6

    goto :goto_c

    .line 109
    .local v6, "uid":Ljava/lang/String;
    :cond_13
    const-string v14, "fullName"

    invoke-virtual {v5, v14}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v14

    if-eqz v14, :cond_15

    const-string v15, "get(\"fullName\")"

    invoke-static {v14, v15}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v15, v14

    .line 130
    .local v15, "it":Lcom/google/gson/JsonElement;
    const/16 v16, 0x0

    .line 109
    .local v16, "$i$a$-takeUnless-OwnerProfileClient$fetchResult$2$name$1":I
    invoke-virtual {v15}, Lcom/google/gson/JsonElement;->isJsonNull()Z

    move-result v18

    .end local v15    # "it":Lcom/google/gson/JsonElement;
    .end local v16    # "$i$a$-takeUnless-OwnerProfileClient$fetchResult$2$name$1":I
    if-nez v18, :cond_14

    goto :goto_9

    :cond_14
    const/4 v14, 0x0

    :goto_9
    if-eqz v14, :cond_15

    invoke-virtual {v14}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v14

    goto :goto_a

    :cond_15
    const/4 v14, 0x0

    :goto_a
    if-nez v14, :cond_16

    .line 110
    sget-object v14, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;

    check-cast v14, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    move-object v0, v14

    goto :goto_c

    .line 111
    .local v14, "name":Ljava/lang/String;
    :cond_16
    move-object v15, v6

    check-cast v15, Ljava/lang/CharSequence;

    invoke-static {v15}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v15

    if-nez v15, :cond_18

    invoke-virtual {v14}, Ljava/lang/String;->length()I

    move-result v15

    move-object/from16 v16, v0

    .end local v0    # "root":Lcom/google/gson/JsonObject;
    .local v16, "root":Lcom/google/gson/JsonObject;
    const/16 v0, 0x80

    if-le v15, v0, :cond_17

    goto :goto_b

    .line 114
    :cond_17
    new-instance v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;

    new-instance v15, Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    invoke-direct {v15, v6, v14}, Lcom/rokid/security/sdk/ability/net/OwnerProfile;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {v0, v15}, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;-><init>(Lcom/rokid/security/sdk/ability/net/OwnerProfile;)V

    check-cast v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;

    goto :goto_c

    .line 111
    .end local v16    # "root":Lcom/google/gson/JsonObject;
    .restart local v0    # "root":Lcom/google/gson/JsonObject;
    :cond_18
    move-object/from16 v16, v0

    .line 112
    .end local v0    # "root":Lcom/google/gson/JsonObject;
    .restart local v16    # "root":Lcom/google/gson/JsonObject;
    :goto_b
    sget-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Unavailable;

    check-cast v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 76
    .end local v4    # "responseText":Ljava/lang/String;
    .end local v5    # "data":Lcom/google/gson/JsonObject;
    .end local v6    # "uid":Ljava/lang/String;
    .end local v9    # "response":Lokhttp3/Response;
    .end local v10    # "$i$a$-use-OwnerProfileClient$fetchResult$2":I
    .end local v11    # "body":Lokhttp3/ResponseBody;
    .end local v12    # "text":Ljava/lang/StringBuilder;
    .end local v13    # "buffer":[C
    .end local v14    # "name":Ljava/lang/String;
    .end local v16    # "root":Lcom/google/gson/JsonObject;
    :goto_c
    const/4 v4, 0x0

    invoke-static {v8, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    return-object v0

    .line 83
    .restart local v9    # "response":Lokhttp3/Response;
    .restart local v10    # "$i$a$-use-OwnerProfileClient$fetchResult$2":I
    .restart local v11    # "body":Lokhttp3/ResponseBody;
    .restart local v12    # "text":Ljava/lang/StringBuilder;
    .restart local v13    # "buffer":[C
    :catchall_1
    move-exception v0

    move-object v4, v0

    .end local v7    # "request":Lokhttp3/Request$Builder;
    .end local v9    # "response":Lokhttp3/Response;
    .end local v10    # "$i$a$-use-OwnerProfileClient$fetchResult$2":I
    .end local v11    # "body":Lokhttp3/ResponseBody;
    .end local v12    # "text":Ljava/lang/StringBuilder;
    .end local v13    # "buffer":[C
    .end local p1    # "endpoint":Ljava/lang/String;
    .end local p2    # "token":Ljava/lang/String;
    .end local p3    # "companyId":Ljava/lang/String;
    .end local p4    # "privateDeployment":Z
    .end local p5    # "deferLocalTokenInvalidation":Z
    :try_start_7
    throw v4
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .restart local v7    # "request":Lokhttp3/Request$Builder;
    .restart local v9    # "response":Lokhttp3/Response;
    .restart local v10    # "$i$a$-use-OwnerProfileClient$fetchResult$2":I
    .restart local v11    # "body":Lokhttp3/ResponseBody;
    .restart local v12    # "text":Ljava/lang/StringBuilder;
    .restart local v13    # "buffer":[C
    .restart local p1    # "endpoint":Ljava/lang/String;
    .restart local p2    # "token":Ljava/lang/String;
    .restart local p3    # "companyId":Ljava/lang/String;
    .restart local p4    # "privateDeployment":Z
    .restart local p5    # "deferLocalTokenInvalidation":Z
    :catchall_2
    move-exception v0

    move-object v5, v0

    :try_start_8
    invoke-static {v14, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v7    # "request":Lokhttp3/Request$Builder;
    .end local p1    # "endpoint":Ljava/lang/String;
    .end local p2    # "token":Ljava/lang/String;
    .end local p3    # "companyId":Ljava/lang/String;
    .end local p4    # "privateDeployment":Z
    .end local p5    # "deferLocalTokenInvalidation":Z
    throw v5
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 76
    .end local v9    # "response":Lokhttp3/Response;
    .end local v10    # "$i$a$-use-OwnerProfileClient$fetchResult$2":I
    .end local v11    # "body":Lokhttp3/ResponseBody;
    .end local v12    # "text":Ljava/lang/StringBuilder;
    .end local v13    # "buffer":[C
    .restart local v7    # "request":Lokhttp3/Request$Builder;
    .restart local p1    # "endpoint":Ljava/lang/String;
    .restart local p2    # "token":Ljava/lang/String;
    .restart local p3    # "companyId":Ljava/lang/String;
    .restart local p4    # "privateDeployment":Z
    .restart local p5    # "deferLocalTokenInvalidation":Z
    :catchall_3
    move-exception v0

    move-object v4, v0

    .end local v7    # "request":Lokhttp3/Request$Builder;
    .end local p1    # "endpoint":Ljava/lang/String;
    .end local p2    # "token":Ljava/lang/String;
    .end local p3    # "companyId":Ljava/lang/String;
    .end local p4    # "privateDeployment":Z
    .end local p5    # "deferLocalTokenInvalidation":Z
    :try_start_9
    throw v4
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_4

    .restart local v7    # "request":Lokhttp3/Request$Builder;
    .restart local p1    # "endpoint":Ljava/lang/String;
    .restart local p2    # "token":Ljava/lang/String;
    .restart local p3    # "companyId":Ljava/lang/String;
    .restart local p4    # "privateDeployment":Z
    .restart local p5    # "deferLocalTokenInvalidation":Z
    :catchall_4
    move-exception v0

    move-object v5, v0

    invoke-static {v8, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v5

    .line 67
    .end local v7    # "request":Lokhttp3/Request$Builder;
    :cond_19
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v4, "Failed requirement."

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v0, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
