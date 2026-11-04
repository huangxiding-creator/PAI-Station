.class public interface abstract Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;
.super Ljava/lang/Object;
.source "ICollectProvider.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0008f\u0018\u00002\u00020\u0001J&\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u000c\u0010\u0008\u001a\u0008\u0012\u0004\u0012\u00020\u00050\tH&J&\u0010\n\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u000b2\u000c\u0010\u0008\u001a\u0008\u0012\u0004\u0012\u00020\u00050\tH&\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/collect/api/ICollectProvider;",
        "",
        "onFaceCollectInfo",
        "",
        "imageBase64",
        "",
        "info",
        "Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;",
        "callback",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "onLprCollectInfo",
        "Lcom/rokid/security/sdk/base/common/outside/LprCollectInfo;",
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
.method public abstract onFaceCollectInfo(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/rokid/security/sdk/base/common/outside/FaceCollectInfo;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract onLprCollectInfo(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/LprCollectInfo;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/rokid/security/sdk/base/common/outside/LprCollectInfo;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation
.end method
