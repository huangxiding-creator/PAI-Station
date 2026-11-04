.class public interface abstract Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;
.super Ljava/lang/Object;
.source "IWifiP2PMessageListener.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0002\u0008\u0002\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J \u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\nH\u0016J\u0010\u0010\u000c\u001a\u00020\u00032\u0006\u0010\r\u001a\u00020\u000eH\u0016J\u0010\u0010\u000f\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;",
        "",
        "onAudioStream",
        "",
        "buffer",
        "Ljava/nio/ByteBuffer;",
        "onNv21Data",
        "data",
        "",
        "width",
        "",
        "height",
        "onP2PTextMessage",
        "msg",
        "",
        "onVideoH264Stream",
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
.method public abstract onAudioStream(Ljava/nio/ByteBuffer;)V
.end method

.method public abstract onNv21Data([BII)V
.end method

.method public abstract onP2PTextMessage(Ljava/lang/String;)V
.end method

.method public abstract onVideoH264Stream(Ljava/nio/ByteBuffer;)V
.end method
