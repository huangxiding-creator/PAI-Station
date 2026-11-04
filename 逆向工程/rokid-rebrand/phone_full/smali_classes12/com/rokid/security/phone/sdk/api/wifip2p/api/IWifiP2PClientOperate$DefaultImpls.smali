.class public final Lcom/rokid/security/phone/sdk/api/wifip2p/api/IWifiP2PClientOperate$DefaultImpls;
.super Ljava/lang/Object;
.source "IWifiP2PClientOperate.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/wifip2p/api/IWifiP2PClientOperate;
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
.method public static synthetic initialize$default(Lcom/rokid/security/phone/sdk/api/wifip2p/api/IWifiP2PClientOperate;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 17
    if-nez p3, :cond_1

    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-interface {p0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/api/IWifiP2PClientOperate;->initialize(Lkotlin/jvm/functions/Function1;)V

    return-void

    :cond_1
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: initialize"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static synthetic startDiscoverPeers$default(Lcom/rokid/security/phone/sdk/api/wifip2p/api/IWifiP2PClientOperate;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 39
    if-nez p3, :cond_1

    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-interface {p0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/api/IWifiP2PClientOperate;->startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V

    return-void

    :cond_1
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: startDiscoverPeers"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static synthetic stopPeerDiscovery$default(Lcom/rokid/security/phone/sdk/api/wifip2p/api/IWifiP2PClientOperate;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 44
    if-nez p3, :cond_1

    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-interface {p0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/api/IWifiP2PClientOperate;->stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V

    return-void

    :cond_1
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: stopPeerDiscovery"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
