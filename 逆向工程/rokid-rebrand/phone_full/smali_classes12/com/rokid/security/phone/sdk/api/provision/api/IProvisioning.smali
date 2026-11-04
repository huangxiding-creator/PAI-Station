.class public interface abstract Lcom/rokid/security/phone/sdk/api/provision/api/IProvisioning;
.super Ljava/lang/Object;
.source "IProvisioning.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\u0008f\u0018\u00002\u00020\u0001J\u0012\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H&J\u0014\u0010\u0006\u001a\u0004\u0018\u00010\u00052\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0008H&J\n\u0010\t\u001a\u0004\u0018\u00010\u0005H&J\u0008\u0010\n\u001a\u00020\u000bH&\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/provision/api/IProvisioning;",
        "",
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
        "sdk-api_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# virtual methods
.method public abstract applyEnv(Lcom/rokid/security/sdk/base/common/outside/EnvInfo;)Z
.end method

.method public abstract applyTokenResp(Lcom/rokid/security/sdk/base/common/outside/TokenResp;)Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
.end method

.method public abstract getEnv()Lcom/rokid/security/sdk/base/common/outside/EnvInfo;
.end method

.method public abstract syncEnvironmentToGlass()V
.end method
