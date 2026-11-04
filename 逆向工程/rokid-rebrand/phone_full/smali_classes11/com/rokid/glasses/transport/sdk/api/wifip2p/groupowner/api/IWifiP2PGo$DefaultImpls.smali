.class public final Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo$DefaultImpls;
.super Ljava/lang/Object;
.source "IWifiP2PGo.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo;
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
.method public static synthetic connectDevice$default(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo;Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 27
    if-nez p4, :cond_1

    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/4 p2, 0x0

    :cond_0
    invoke-interface {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo;->connectDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V

    return-void

    :cond_1
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: connectDevice"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static synthetic removeGroup$default(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 21
    if-nez p3, :cond_1

    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-interface {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo;->removeGroup(Lkotlin/jvm/functions/Function1;)V

    return-void

    :cond_1
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: removeGroup"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static synthetic startDiscoverPeers$default(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 23
    if-nez p3, :cond_1

    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-interface {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo;->startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V

    return-void

    :cond_1
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: startDiscoverPeers"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static synthetic stopPeerDiscovery$default(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 25
    if-nez p3, :cond_1

    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-interface {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo;->stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V

    return-void

    :cond_1
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: stopPeerDiscovery"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
