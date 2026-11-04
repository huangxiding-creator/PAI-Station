.class public interface abstract Lcom/rokid/security/phone/sdk/api/engine/api/IMobileEngine;
.super Ljava/lang/Object;
.source "IMobileEngine.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00002\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\u0008f\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H&J<\u0010\u0004\u001a\u00020\u00032\u0006\u0010\u0005\u001a\u00020\u00062\'\u0010\u0007\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\n0\t\u00a2\u0006\u000c\u0008\u000b\u0012\u0008\u0008\u000c\u0012\u0004\u0008\u0008(\r\u0012\u0004\u0012\u00020\u00030\u0008H&\u00f8\u0001\u0000J\u0008\u0010\u000e\u001a\u00020\nH&J\u0010\u0010\u000f\u001a\u00020\u00032\u0006\u0010\u0010\u001a\u00020\u0011H&\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/engine/api/IMobileEngine;",
        "",
        "destroy",
        "",
        "initSDK",
        "params",
        "Lcom/rokid/security/phone/sdk/base/data/EngineParam;",
        "onResult",
        "Lkotlin/Function1;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "",
        "Lkotlin/ParameterName;",
        "name",
        "result",
        "isInit",
        "setUserInfo",
        "user",
        "Lcom/rokid/security/sdk/base/common/outside/UserInfo;",
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
.method public abstract destroy()V
.end method

.method public abstract initSDK(Lcom/rokid/security/phone/sdk/base/data/EngineParam;Lkotlin/jvm/functions/Function1;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/base/data/EngineParam;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract isInit()Z
.end method

.method public abstract setUserInfo(Lcom/rokid/security/sdk/base/common/outside/UserInfo;)V
.end method
