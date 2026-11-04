.class public interface abstract Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
.super Ljava/lang/Object;
.source "IWifiP2PClientListener.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000b\n\u0000\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0016\u0010\u0006\u001a\u00020\u00032\u000c\u0010\u0007\u001a\u0008\u0012\u0004\u0012\u00020\t0\u0008H\u0016J\u0010\u0010\n\u001a\u00020\u00032\u0006\u0010\u000b\u001a\u00020\tH\u0016J\u0010\u0010\u000c\u001a\u00020\u00032\u0006\u0010\r\u001a\u00020\u000eH\u0016\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;",
        "",
        "onConnectionInfoAvailable",
        "",
        "wifiP2pInfo",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
        "onPeersAvailable",
        "devices",
        "",
        "Landroid/net/wifi/p2p/WifiP2pDevice;",
        "onSelfDeviceAvailable",
        "device",
        "onWifiP2pEnabled",
        "enabled",
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
.method public abstract onConnectionInfoAvailable(Landroid/net/wifi/p2p/WifiP2pInfo;)V
.end method

.method public abstract onPeersAvailable(Ljava/util/List;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "+",
            "Landroid/net/wifi/p2p/WifiP2pDevice;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract onSelfDeviceAvailable(Landroid/net/wifi/p2p/WifiP2pDevice;)V
.end method

.method public abstract onWifiP2pEnabled(Z)V
.end method
