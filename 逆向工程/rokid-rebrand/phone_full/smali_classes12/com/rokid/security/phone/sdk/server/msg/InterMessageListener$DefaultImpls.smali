.class public final Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener$DefaultImpls;
.super Ljava/lang/Object;
.source "InterMessageListener.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
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
.method public static onAudioStream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener$DefaultImpls;->onAudioStream(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;Ljava/nio/ByteBuffer;)V

    .line 11
    return-void
.end method

.method public static onBTStreamDataReceived(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;[BLjava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;

    invoke-static {v0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener$DefaultImpls;->onBTStreamDataReceived(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;Ljava/lang/String;[BLjava/lang/String;)V

    .line 11
    return-void
.end method

.method public static onBleTextMessage(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener$DefaultImpls;->onBleTextMessage(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IBleMessageListener;Ljava/lang/String;)V

    .line 11
    return-void
.end method

.method public static onClassicBTAudioStream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;[B)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    .param p1, "buffer"    # [B

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener$DefaultImpls;->onClassicBTAudioStream(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;[B)V

    .line 11
    return-void
.end method

.method public static onClassicBTTextMessage(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener$DefaultImpls;->onClassicBTTextMessage(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;Ljava/lang/String;)V

    .line 11
    return-void
.end method

.method public static onNv21Data(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;[BII)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    invoke-static {v0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener$DefaultImpls;->onNv21Data(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;[BII)V

    .line 11
    return-void
.end method

.method public static onP2PTextMessage(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener$DefaultImpls;->onP2PTextMessage(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;Ljava/lang/String;)V

    .line 11
    return-void
.end method

.method public static onVideoH264Stream(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    invoke-static {v0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener$DefaultImpls;->onVideoH264Stream(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;Ljava/nio/ByteBuffer;)V

    .line 11
    return-void
.end method
