.class public interface abstract Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;
.super Ljava/lang/Object;
.source "ITrackListener.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\u0008f\u0018\u00002\u00020\u0001J\u0016\u0010\u0002\u001a\u00020\u00032\u000c\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u0005H&J\u0010\u0010\u0007\u001a\u00020\u00032\u0006\u0010\u0008\u001a\u00020\tH&J\u0010\u0010\n\u001a\u00020\u00032\u0006\u0010\u000b\u001a\u00020\u000cH&\u00a8\u0006\r"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;",
        "",
        "onFaceTrack",
        "",
        "faceModels",
        "",
        "Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;",
        "onLPRTrack",
        "lprModel",
        "Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;",
        "onModeChange",
        "mode",
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
.method public abstract onFaceTrack(Ljava/util/List;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract onLPRTrack(Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;)V
.end method

.method public abstract onModeChange(I)V
.end method
