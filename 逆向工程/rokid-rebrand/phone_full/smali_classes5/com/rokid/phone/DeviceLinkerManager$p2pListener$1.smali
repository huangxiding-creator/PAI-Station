.class public final Lcom/rokid/phone/DeviceLinkerManager$p2pListener$1;
.super Ljava/lang/Object;
.source "DeviceLinkerManager.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/phone/DeviceLinkerManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0017\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016\u00a8\u0006\u0006"
    }
    d2 = {
        "com/rokid/phone/DeviceLinkerManager$p2pListener$1",
        "Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;",
        "onWifiP2pEnabled",
        "",
        "enabled",
        "",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 90
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConnectionInfoAvailable(Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 0
    .param p1, "wifiP2pInfo"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 90
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener$DefaultImpls;->onConnectionInfoAvailable(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;Landroid/net/wifi/p2p/WifiP2pInfo;)V

    return-void
.end method

.method public onPeersAvailable(Ljava/util/List;)V
    .locals 0
    .param p1, "devices"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "+",
            "Landroid/net/wifi/p2p/WifiP2pDevice;",
            ">;)V"
        }
    .end annotation

    .line 90
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener$DefaultImpls;->onPeersAvailable(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;Ljava/util/List;)V

    return-void
.end method

.method public onSelfDeviceAvailable(Landroid/net/wifi/p2p/WifiP2pDevice;)V
    .locals 0
    .param p1, "device"    # Landroid/net/wifi/p2p/WifiP2pDevice;

    .line 90
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener$DefaultImpls;->onSelfDeviceAvailable(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;Landroid/net/wifi/p2p/WifiP2pDevice;)V

    return-void
.end method

.method public onWifiP2pEnabled(Z)V
    .locals 1
    .param p1, "enabled"    # Z

    .line 92
    sget-object v0, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    invoke-virtual {v0, p1}, Lcom/rokid/phone/data/GlobalData;->setP2pConnectState(Z)V

    .line 93
    return-void
.end method
