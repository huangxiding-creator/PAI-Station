.class public final Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;
.super Ljava/lang/Object;
.source "BusinessEndpointProbe.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;,
        Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBusinessEndpointProbe.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BusinessEndpointProbe.kt\ncom/rokid/security/sdk/ability/net/BusinessEndpointProbe\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,108:1\n1#2:109\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00000\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u0002\u0010\u0011B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0011\u0010\u000b\u001a\u00020\u000cH\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\rJ\n\u0010\u000e\u001a\u0004\u0018\u00010\u000fH\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;",
        "",
        "()V",
        "CONNECT_TIMEOUT_MS",
        "",
        "REACHABLE_CACHE_MS",
        "",
        "TAG",
        "",
        "lastReachableElapsed",
        "lastReachableKey",
        "check",
        "Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;",
        "(Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "parseEndpoint",
        "Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;",
        "Endpoint",
        "Result",
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
.field private static final CONNECT_TIMEOUT_MS:I = 0x7d0

.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;

.field private static final REACHABLE_CACHE_MS:J = 0x3a98L

.field private static final TAG:Ljava/lang/String; = "BusinessEndpointProbe"

.field private static volatile lastReachableElapsed:J

.field private static volatile lastReachableKey:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->INSTANCE:Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;

    .line 35
    const-string v0, ""

    sput-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->lastReachableKey:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getLastReachableElapsed$p()J
    .locals 2

    .line 20
    sget-wide v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->lastReachableElapsed:J

    return-wide v0
.end method

.method public static final synthetic access$getLastReachableKey$p()Ljava/lang/String;
    .locals 1

    .line 20
    sget-object v0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->lastReachableKey:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$parseEndpoint(Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;)Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;

    .line 20
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->parseEndpoint()Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$setLastReachableElapsed$p(J)V
    .locals 0
    .param p0, "<set-?>"    # J

    .line 20
    sput-wide p0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->lastReachableElapsed:J

    return-void
.end method

.method public static final synthetic access$setLastReachableKey$p(Ljava/lang/String;)V
    .locals 0
    .param p0, "<set-?>"    # Ljava/lang/String;

    .line 20
    sput-object p0, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe;->lastReachableKey:Ljava/lang/String;

    return-void
.end method

.method private final parseEndpoint()Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;
    .locals 9

    .line 89
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHost()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    .line 109
    .local v1, "it":Ljava/lang/String;
    const/4 v2, 0x0

    .line 89
    .local v2, "$i$a$-takeIf-BusinessEndpointProbe$parseEndpoint$rawHost$1":I
    move-object v3, v1

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v3}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v3

    const/4 v4, 0x1

    xor-int/2addr v3, v4

    .end local v1    # "it":Ljava/lang/String;
    .end local v2    # "$i$a$-takeIf-BusinessEndpointProbe$parseEndpoint$rawHost$1":I
    const/4 v1, 0x0

    if-eqz v3, :cond_0

    goto :goto_0

    :cond_0
    move-object v0, v1

    :goto_0
    if-nez v0, :cond_1

    return-object v1

    .line 90
    .local v0, "rawHost":Ljava/lang/String;
    :cond_1
    sget-object v2, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHostProtocol()Ljava/lang/String;

    move-result-object v2

    move-object v3, v2

    .line 109
    .local v3, "it":Ljava/lang/String;
    const/4 v5, 0x0

    .line 90
    .local v5, "$i$a$-takeIf-BusinessEndpointProbe$parseEndpoint$protocol$1":I
    move-object v6, v3

    check-cast v6, Ljava/lang/CharSequence;

    invoke-static {v6}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v6

    xor-int/2addr v6, v4

    .end local v3    # "it":Ljava/lang/String;
    .end local v5    # "$i$a$-takeIf-BusinessEndpointProbe$parseEndpoint$protocol$1":I
    if-eqz v6, :cond_2

    goto :goto_1

    :cond_2
    move-object v2, v1

    :goto_1
    if-nez v2, :cond_3

    const-string v2, "https"

    .line 91
    .local v2, "protocol":Ljava/lang/String;
    :cond_3
    nop

    .line 92
    :try_start_0
    new-instance v3, Ljava/net/URI;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "://"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v5}, Ljava/net/URI;-><init>(Ljava/lang/String;)V

    .line 93
    .local v3, "uri":Ljava/net/URI;
    invoke-virtual {v3}, Ljava/net/URI;->getHost()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_8

    move-object v6, v5

    .line 109
    .local v6, "it":Ljava/lang/String;
    const/4 v7, 0x0

    .line 93
    .local v7, "$i$a$-takeIf-BusinessEndpointProbe$parseEndpoint$host$1":I
    move-object v8, v6

    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v8}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v8

    xor-int/2addr v8, v4

    .end local v6    # "it":Ljava/lang/String;
    .end local v7    # "$i$a$-takeIf-BusinessEndpointProbe$parseEndpoint$host$1":I
    if-eqz v8, :cond_4

    goto :goto_2

    :cond_4
    move-object v5, v1

    :goto_2
    if-nez v5, :cond_5

    goto :goto_4

    .line 94
    .local v5, "host":Ljava/lang/String;
    :cond_5
    nop

    .line 95
    invoke-virtual {v3}, Ljava/net/URI;->getPort()I

    move-result v6

    if-lez v6, :cond_6

    invoke-virtual {v3}, Ljava/net/URI;->getPort()I

    move-result v4

    goto :goto_3

    .line 96
    :cond_6
    const-string v6, "http"

    invoke-static {v2, v6, v4}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v4

    if-eqz v4, :cond_7

    const/16 v4, 0x50

    goto :goto_3

    .line 97
    :cond_7
    const/16 v4, 0x1bb

    .line 94
    :goto_3
    nop

    .line 99
    .local v4, "port":I
    new-instance v6, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;

    invoke-direct {v6, v5, v4}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Endpoint;-><init>(Ljava/lang/String;I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v1, v6

    .end local v3    # "uri":Ljava/net/URI;
    .end local v4    # "port":I
    .end local v5    # "host":Ljava/lang/String;
    goto :goto_5

    .line 93
    .restart local v3    # "uri":Ljava/net/URI;
    :cond_8
    :goto_4
    return-object v1

    .line 100
    .end local v3    # "uri":Ljava/net/URI;
    :catchall_0
    move-exception v3

    .line 101
    .local v3, "t":Ljava/lang/Throwable;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "invalid endpoint protocol="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " host="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " error="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    const-string v5, "BusinessEndpointProbe"

    invoke-static {v5, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 102
    nop

    .line 91
    .end local v3    # "t":Ljava/lang/Throwable;
    :goto_5
    return-object v1
.end method


# virtual methods
.method public final check(Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 3
    .param p1, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$Result;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 40
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v1, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lcom/rokid/security/sdk/ability/net/BusinessEndpointProbe$check$2;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast v1, Lkotlin/jvm/functions/Function2;

    invoke-static {v0, v1, p1}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    .line 86
    return-object v0
.end method
