.class public final Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener$DefaultImpls;
.super Ljava/lang/Object;
.source "WifiP2PWrapperListener.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;
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
.method public static onAudioStream(Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    move-object v0, p0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener$DefaultImpls;->onAudioStream(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;Ljava/nio/ByteBuffer;)V

    .line 10
    return-void
.end method

.method public static onConnectionInfoAvailable(Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;
    .param p1, "wifiP2pInfo"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    const-string/jumbo v0, "wifiP2pInfo"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    move-object v0, p0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener$DefaultImpls;->onConnectionInfoAvailable(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;Landroid/net/wifi/p2p/WifiP2pInfo;)V

    .line 10
    return-void
.end method

.method public static onNv21Data(Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;[BII)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    return-void
.end method

.method public static onPeersAvailable(Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;Ljava/util/List;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;
    .param p1, "devices"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;",
            "Ljava/util/List<",
            "+",
            "Landroid/net/wifi/p2p/WifiP2pDevice;",
            ">;)V"
        }
    .end annotation

    const-string v0, "devices"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    move-object v0, p0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener$DefaultImpls;->onPeersAvailable(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;Ljava/util/List;)V

    .line 10
    return-void
.end method

.method public static onSelfDeviceAvailable(Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;Landroid/net/wifi/p2p/WifiP2pDevice;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;
    .param p1, "device"    # Landroid/net/wifi/p2p/WifiP2pDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    move-object v0, p0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener$DefaultImpls;->onSelfDeviceAvailable(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;Landroid/net/wifi/p2p/WifiP2pDevice;)V

    .line 10
    return-void
.end method

.method public static onStreamReceived(Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;Ljava/lang/String;[BLjava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    move-object v0, p0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    invoke-static {v0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener$DefaultImpls;->onStreamReceived(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;Ljava/lang/String;[BLjava/lang/String;)V

    .line 10
    return-void
.end method

.method public static onTextMessage(Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;Ljava/lang/String;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    move-object v0, p0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener$DefaultImpls;->onTextMessage(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;Ljava/lang/String;)V

    .line 10
    return-void
.end method

.method public static onVideoH264Stream(Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 8
    move-object v0, p0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener$DefaultImpls;->onVideoH264Stream(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;Ljava/nio/ByteBuffer;)V

    .line 10
    return-void
.end method

.method public static onWifiP2pEnabled(Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;Z)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;
    .param p1, "enabled"    # Z

    .line 8
    move-object v0, p0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener$DefaultImpls;->onWifiP2pEnabled(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;Z)V

    .line 10
    return-void
.end method
