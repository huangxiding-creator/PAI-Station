.class public interface abstract Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;
.super Ljava/lang/Object;
.source "IRecProvider.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\u0008f\u0018\u00002\u00020\u0001J\u001e\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u000c\u0010\u0006\u001a\u0008\u0012\u0004\u0012\u00020\u00080\u0007H&\u00a8\u0006\t"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;",
        "",
        "recognizeFace",
        "",
        "param",
        "Lcom/rokid/security/phone/sdk/api/recog/online/bean/RecogFaceParam;",
        "callback",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;",
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
.method public abstract recognizeFace(Lcom/rokid/security/phone/sdk/api/recog/online/bean/RecogFaceParam;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/api/recog/online/bean/RecogFaceParam;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;",
            ">;)V"
        }
    .end annotation
.end method
