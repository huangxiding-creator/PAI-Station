.class public final Lcom/rokid/security/sdk/ability/net/TokenRespEnvironment;
.super Ljava/lang/Object;
.source "TokenRespEnvironment.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nTokenRespEnvironment.kt\nKotlin\n*S Kotlin\n*F\n+ 1 TokenRespEnvironment.kt\ncom/rokid/security/sdk/ability/net/TokenRespEnvironment\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,28:1\n1#2:29\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u0006\u00a8\u0006\u0007"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/TokenRespEnvironment;",
        "",
        "()V",
        "apply",
        "",
        "tokenResp",
        "Lcom/rokid/security/sdk/base/common/outside/TokenResp;",
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/net/TokenRespEnvironment;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/net/TokenRespEnvironment;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/TokenRespEnvironment;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/net/TokenRespEnvironment;->INSTANCE:Lcom/rokid/security/sdk/ability/net/TokenRespEnvironment;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final apply(Lcom/rokid/security/sdk/base/common/outside/TokenResp;)Z
    .locals 12
    .param p1, "tokenResp"    # Lcom/rokid/security/sdk/base/common/outside/TokenResp;

    const-string/jumbo v0, "tokenResp"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/outside/TokenResp;->getEnvInfo()Lcom/rokid/security/sdk/base/common/outside/EnvInfo;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    move-object v2, v0

    .line 29
    .local v2, "it":Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    const/4 v3, 0x0

    .line 16
    .local v3, "$i$a$-takeIf-TokenRespEnvironment$apply$fromEnvInfo$1":I
    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;->hasContent()Z

    move-result v2

    .end local v2    # "it":Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    .end local v3    # "$i$a$-takeIf-TokenRespEnvironment$apply$fromEnvInfo$1":I
    if-eqz v2, :cond_0

    goto :goto_0

    :cond_0
    move-object v0, v1

    :goto_0
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;->normalized()Lcom/rokid/security/sdk/base/common/outside/EnvInfo;

    move-result-object v1

    :cond_1
    move-object v0, v1

    .line 17
    .local v0, "fromEnvInfo":Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    if-eqz v0, :cond_2

    .line 18
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1, v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->applyEnv(Lcom/rokid/security/sdk/base/common/outside/EnvInfo;)Z

    move-result v1

    return v1

    .line 20
    :cond_2
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/outside/TokenResp;->getEnvType()Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .line 21
    .local v1, "raw":Ljava/lang/String;
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    const/4 v10, 0x1

    const/4 v3, 0x0

    if-nez v2, :cond_3

    move v2, v10

    goto :goto_1

    :cond_3
    move v2, v3

    :goto_1
    if-eqz v2, :cond_4

    return v3

    .line 22
    :cond_4
    new-instance v11, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;

    const/16 v8, 0x1e

    const/4 v9, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v2, v11

    move-object v3, v1

    invoke-direct/range {v2 .. v9}, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    invoke-virtual {v11}, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;->normalized()Lcom/rokid/security/sdk/base/common/outside/EnvInfo;

    move-result-object v2

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;->getEnvType()Ljava/lang/String;

    move-result-object v2

    .line 23
    .local v2, "key":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    move-object v4, v2

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 29
    const/4 v4, 0x0

    .line 23
    .local v4, "$i$a$-ifBlank-TokenRespEnvironment$apply$1":I
    move-object v4, v1

    .end local v4    # "$i$a$-ifBlank-TokenRespEnvironment$apply$1":I
    :cond_5
    check-cast v4, Ljava/lang/String;

    invoke-virtual {v3, v4}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->setEnv(Ljava/lang/String;)V

    .line 24
    sget-object v3, Lcom/rokid/security/sdk/ability/net/ApiProvider;->INSTANCE:Lcom/rokid/security/sdk/ability/net/ApiProvider;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/net/ApiProvider;->refreshApi()V

    .line 25
    sget-object v3, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHost()Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v3}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v3

    xor-int/2addr v3, v10

    return v3
.end method
