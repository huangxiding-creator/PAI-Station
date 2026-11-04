.class public final Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener$DefaultImpls;
.super Ljava/lang/Object;
.source "IWifiP2PClientListener.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
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
.method public static onConnectionInfoAvailable(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    .param p1, "wifiP2pInfo"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    const-string/jumbo v0, "wifiP2pInfo"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    return-void
.end method

.method public static onPeersAvailable(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;Ljava/util/List;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    .param p1, "devices"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;",
            "Ljava/util/List<",
            "+",
            "Landroid/net/wifi/p2p/WifiP2pDevice;",
            ">;)V"
        }
    .end annotation

    const-string v0, "devices"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 31
    return-void
.end method

.method public static onSelfDeviceAvailable(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;Landroid/net/wifi/p2p/WifiP2pDevice;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    .param p1, "device"    # Landroid/net/wifi/p2p/WifiP2pDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    return-void
.end method

.method public static onWifiP2pEnabled(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    .param p1, "enabled"    # Z

    .line 15
    return-void
.end method
