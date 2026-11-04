.class public final Lcom/rokid/security/phone/sdk/server/provision/ProvisionServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/provision/api/AbsProvisionService;
.source "ProvisionServiceImpl.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nProvisionServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ProvisionServiceImpl.kt\ncom/rokid/security/phone/sdk/server/provision/ProvisionServiceImpl\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,40:1\n1#2:41\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0012\u0010\u0003\u001a\u00020\u00042\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u0006H\u0016J\u0014\u0010\u0007\u001a\u0004\u0018\u00010\u00062\u0008\u0010\u0008\u001a\u0004\u0018\u00010\tH\u0016J\n\u0010\n\u001a\u0004\u0018\u00010\u0006H\u0016J\u0008\u0010\u000b\u001a\u00020\u000cH\u0016\u00a8\u0006\r"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/provision/ProvisionServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/provision/api/AbsProvisionService;",
        "()V",
        "applyEnv",
        "",
        "envInfo",
        "Lcom/rokid/security/sdk/base/common/outside/EnvInfo;",
        "applyTokenResp",
        "tokenResp",
        "Lcom/rokid/security/sdk/base/common/outside/TokenResp;",
        "getEnv",
        "syncEnvironmentToGlass",
        "",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/provision/ProvisionServiceImpl;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/provision/ProvisionServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/provision/ProvisionServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/provision/ProvisionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/provision/ProvisionServiceImpl;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/provision/api/AbsProvisionService;-><init>()V

    return-void
.end method


# virtual methods
.method public applyEnv(Lcom/rokid/security/sdk/base/common/outside/EnvInfo;)Z
    .locals 1
    .param p1, "envInfo"    # Lcom/rokid/security/sdk/base/common/outside/EnvInfo;

    .line 24
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->applyEnv(Lcom/rokid/security/sdk/base/common/outside/EnvInfo;)Z

    move-result v0

    return v0
.end method

.method public applyTokenResp(Lcom/rokid/security/sdk/base/common/outside/TokenResp;)Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    .locals 4
    .param p1, "tokenResp"    # Lcom/rokid/security/sdk/base/common/outside/TokenResp;

    .line 28
    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    .line 29
    :cond_0
    sget-object v1, Lcom/rokid/security/sdk/ability/net/TokenRespEnvironment;->INSTANCE:Lcom/rokid/security/sdk/ability/net/TokenRespEnvironment;

    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/ability/net/TokenRespEnvironment;->apply(Lcom/rokid/security/sdk/base/common/outside/TokenResp;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 30
    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->snapshotEnv()Lcom/rokid/security/sdk/base/common/outside/EnvInfo;

    move-result-object v1

    move-object v2, v1

    .line 41
    .local v2, "it":Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    const/4 v3, 0x0

    .line 30
    .local v3, "$i$a$-takeIf-ProvisionServiceImpl$applyTokenResp$1":I
    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/outside/EnvInfo;->hasContent()Z

    move-result v2

    .end local v2    # "it":Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    .end local v3    # "$i$a$-takeIf-ProvisionServiceImpl$applyTokenResp$1":I
    if-eqz v2, :cond_2

    move-object v0, v1

    goto :goto_0

    .line 32
    :cond_1
    nop

    .line 29
    :cond_2
    :goto_0
    return-object v0
.end method

.method public getEnv()Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
    .locals 1

    .line 20
    sget-object v0, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/common/PhoneEnvResolver;->snapshot()Lcom/rokid/security/sdk/base/common/outside/EnvInfo;

    move-result-object v0

    return-object v0
.end method

.method public syncEnvironmentToGlass()V
    .locals 1

    .line 37
    sget-object v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->sendAppInfo()V

    .line 38
    return-void
.end method
