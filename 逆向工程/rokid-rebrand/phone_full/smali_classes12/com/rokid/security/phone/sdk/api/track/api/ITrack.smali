.class public interface abstract Lcom/rokid/security/phone/sdk/api/track/api/ITrack;
.super Ljava/lang/Object;
.source "ITrack.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0008\u0010\u0006\u001a\u00020\u0003H&J\u0008\u0010\u0007\u001a\u00020\u0003H&J\u0010\u0010\u0008\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&\u00a8\u0006\t"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/track/api/ITrack;",
        "",
        "addTrackListener",
        "",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;",
        "init",
        "release",
        "removeTrackListener",
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
.method public abstract addTrackListener(Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;)V
.end method

.method public abstract init()V
.end method

.method public abstract release()V
.end method

.method public abstract removeTrackListener(Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;)V
.end method
