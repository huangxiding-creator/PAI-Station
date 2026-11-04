.class public final Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;
.super Ljava/lang/Object;
.source "PhoneEnvResolver.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nPhoneEnvResolver.kt\nKotlin\n*S Kotlin\n*F\n+ 1 PhoneEnvResolver.kt\ncom/rokid/security/phone/sdk/server/common/PhoneEnvResolver\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,50:1\n1#2:51\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\"\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u001a\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u00042\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u0007H\u0002J\u0008\u0010\u0008\u001a\u00020\u0004H\u0002J\u0008\u0010\t\u001a\u0004\u0018\u00010\n\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;",
        "",
        "()V",
        "buildEndpoint",
        "",
        "host",
        "includePrefix",
        "",
        "resolveCustomHost",
        "snapshot",
        "Lcom/rokid/security/sdk/base/common/outside/EnvInfo;",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final buildEndpoint(Ljava/lang/String;Z)Ljava/lang/String;
    .locals 6
    .param p1, "host"    # Ljava/lang/String;
    .param p2, "includePrefix"    # Z

    .line 41
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    new-array v2, v1, [C

    const/4 v3, 0x0

    const/16 v4, 0x2f

    aput-char v4, v2, v3

    invoke-static {v0, v2}, Lkotlin/text/StringsKt;->trim(Ljava/lang/String;[C)Ljava/lang/String;

    move-result-object v0

    .line 42
    .local v0, "normalizedHost":Ljava/lang/String;
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    const-string v5, ""

    if-eqz v2, :cond_0

    .line 43
    return-object v5

    .line 45
    :cond_0
    if-eqz p2, :cond_1

    sget-object v2, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getMethodProfix()Ljava/lang/String;

    move-result-object v2

    new-array v1, v1, [C

    aput-char v4, v1, v3

    invoke-static {v2, v1}, Lkotlin/text/StringsKt;->trim(Ljava/lang/String;[C)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_1
    move-object v1, v5

    .line 46
    .local v1, "prefix":Ljava/lang/String;
    :goto_0
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    goto :goto_1

    :cond_2
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    :goto_1
    move-object v2, v5

    .line 47
    .local v2, "suffix":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHostProtocol()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "://"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method static synthetic buildEndpoint$default(Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 40
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/4 p2, 0x0

    :cond_0
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;->buildEndpoint(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private final resolveCustomHost()Ljava/lang/String;
    .locals 4

    .line 27
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getEnvType()Ljava/lang/String;

    move-result-object v0

    const-string v1, "custom"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    const-string v1, ""

    if-nez v0, :cond_0

    .line 28
    return-object v1

    .line 30
    :cond_0
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getParams()Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;->getCustomHost()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_2

    move-object v0, v1

    .line 31
    .local v0, "customHost":Ljava/lang/String;
    :cond_2
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    const/4 v3, 0x1

    xor-int/2addr v2, v3

    if-eqz v2, :cond_3

    .line 32
    return-object v0

    .line 34
    :cond_3
    sget-object v2, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHost()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    xor-int/2addr v2, v3

    if-eqz v2, :cond_4

    .line 35
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHost()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1, v3}, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;->buildEndpoint(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 37
    :cond_4
    return-object v1
.end method


# virtual methods
.method public final snapshot()Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    .locals 9

    .line 16
    new-instance v6, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;

    .line 17
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getEnvType()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, ""

    :cond_0
    move-object v1, v0

    .line 18
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;->resolveCustomHost()Ljava/lang/String;

    move-result-object v2

    .line 19
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHost()Ljava/lang/String;

    move-result-object v0

    const/4 v3, 0x1

    invoke-direct {p0, v0, v3}, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;->buildEndpoint(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v3

    .line 20
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getH5Host()Ljava/lang/String;

    move-result-object v0

    const/4 v4, 0x0

    const/4 v5, 0x2

    const/4 v7, 0x0

    invoke-static {p0, v0, v4, v5, v7}, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;->buildEndpoint$default(Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    .line 21
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getInspectH5host()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, v4, v5, v7}, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;->buildEndpoint$default(Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    .line 16
    move-object v0, v6

    move-object v4, v8

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 22
    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;->normalized()Lcom/rokid/security/sdk/base/common/outside/EnvInfo;

    move-result-object v0

    .line 16
    nop

    .line 23
    .local v0, "envInfo":Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    move-object v1, v0

    .line 51
    .local v1, "it":Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    const/4 v2, 0x0

    .line 23
    .local v2, "$i$a$-takeIf-PhoneEnvResolver$snapshot$1":I
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;->hasContent()Z

    move-result v1

    .end local v1    # "it":Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    .end local v2    # "$i$a$-takeIf-PhoneEnvResolver$snapshot$1":I
    if-eqz v1, :cond_1

    move-object v7, v0

    :cond_1
    return-object v7
.end method
