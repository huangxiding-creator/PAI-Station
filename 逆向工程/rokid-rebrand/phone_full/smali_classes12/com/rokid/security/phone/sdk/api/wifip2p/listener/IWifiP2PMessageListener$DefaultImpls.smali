.class public final Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener$DefaultImpls;
.super Ljava/lang/Object;
.source "IWifiP2PMessageListener.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DefaultImpls"
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static onAudioStream(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    return-void
.end method

.method public static onNv21Data(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;[BII)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    return-void
.end method

.method public static onP2PTextMessage(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 14
    return-void
.end method

.method public static onVideoH264Stream(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    return-void
.end method
