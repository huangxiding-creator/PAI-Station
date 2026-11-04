.class public interface abstract Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;
.super Ljava/lang/Object;
.source "IClassicBTMessageListener.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001e\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0006\u0008f\u0018\u00002\u00020\u0001J \u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\u0005H\u0016J\u0010\u0010\t\u001a\u00020\u00032\u0006\u0010\n\u001a\u00020\u0007H\u0016J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u000c\u001a\u00020\u0005H\u0016\u00a8\u0006\r"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;",
        "",
        "onBTStreamDataReceived",
        "",
        "tag",
        "",
        "data",
        "",
        "clientId",
        "onClassicBTAudioStream",
        "buffer",
        "onClassicBTTextMessage",
        "msg",
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
.method public abstract onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V
.end method

.method public abstract onClassicBTAudioStream([B)V
.end method

.method public abstract onClassicBTTextMessage(Ljava/lang/String;)V
.end method
