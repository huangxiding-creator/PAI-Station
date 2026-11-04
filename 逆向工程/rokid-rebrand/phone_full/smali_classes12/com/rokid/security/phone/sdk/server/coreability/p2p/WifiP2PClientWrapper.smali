.class public final Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;
.super Ljava/lang/Object;
.source "WifiP2PClientWrapper.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000Z\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0012\n\u0002\u0008\u0006\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eJ:\u0010\u000f\u001a\u00020\u000c2\u0006\u0010\u0010\u001a\u00020\u00112\'\u0010\u0012\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00150\u0014\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u0018\u0012\u0004\u0012\u00020\u000c0\u0013\u00f8\u0001\u0000J\u0006\u0010\u0019\u001a\u00020\u000cJ+\u0010\u001a\u001a\u00020\u000c2#\u0010\u001b\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010\u001c\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u001d\u0012\u0004\u0012\u00020\u000c0\u0013J2\u0010\u001e\u001a\u00020\u000c2\'\u0010\u0012\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00150\u0014\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u0018\u0012\u0004\u0012\u00020\u000c0\u0013\u00f8\u0001\u0000J6\u0010\u001f\u001a\u00020\u000c2+\u0008\u0002\u0010\u0012\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00150\u0014\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u0018\u0012\u0004\u0012\u00020\u000c\u0018\u00010\u0013\u00f8\u0001\u0000J)\u0010 \u001a\u00020\u000c2!\u0010\u001b\u001a\u001d\u0012\u0013\u0012\u00110\u0015\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008( \u0012\u0004\u0012\u00020\u000c0\u0013J\u0006\u0010!\u001a\u00020\u000cJ\u000e\u0010\"\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eJ+\u0010#\u001a\u00020\u000c2#\u0010\u001b\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010$\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(%\u0012\u0004\u0012\u00020\u000c0\u0013J\u000e\u0010&\u001a\u00020\u000c2\u0006\u0010\'\u001a\u00020(J\u000e\u0010)\u001a\u00020\u000c2\u0006\u0010*\u001a\u00020\u0004J\u000e\u0010+\u001a\u00020\u000c2\u0006\u0010\'\u001a\u00020(J4\u0010,\u001a\u00020\u000c2)\u0010\u0012\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00150\u0014\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u0018\u0012\u0004\u0012\u00020\u000c\u0018\u00010\u0013\u00f8\u0001\u0000J4\u0010-\u001a\u00020\u000c2)\u0010\u0012\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00150\u0014\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u0018\u0012\u0004\u0012\u00020\u000c\u0018\u00010\u0013\u00f8\u0001\u0000R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u001d\u0010\u0005\u001a\u0004\u0018\u00010\u00068FX\u0086\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\t\u0010\n\u001a\u0004\u0008\u0007\u0010\u0008\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006."
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;",
        "",
        "()V",
        "TAG",
        "",
        "mAbsWifiP2PClientService",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;",
        "getMAbsWifiP2PClientService",
        "()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;",
        "mAbsWifiP2PClientService$delegate",
        "Lkotlin/Lazy;",
        "addWifiP2PListener",
        "",
        "listener",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;",
        "connectDevice",
        "device",
        "Landroid/net/wifi/p2p/WifiP2pDevice;",
        "onResult",
        "Lkotlin/Function1;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "",
        "Lkotlin/ParameterName;",
        "name",
        "result",
        "disconnect",
        "getGroupInfo",
        "action",
        "Landroid/net/wifi/p2p/WifiP2pGroup;",
        "group",
        "init",
        "initialize",
        "isConnect",
        "release",
        "removeWifiP2PListener",
        "requestConnectionInfo",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
        "info",
        "sendAudioStreamData",
        "streamData",
        "",
        "sendTextMessage",
        "message",
        "sendVideoStreamData",
        "startDiscoverPeers",
        "stopPeerDiscovery",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

.field private static final TAG:Ljava/lang/String; = "WifiP2PClientWapper"

.field private static final mAbsWifiP2PClientService$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    .line 19
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$mAbsWifiP2PClientService$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$mAbsWifiP2PClientService$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->mAbsWifiP2PClientService$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static synthetic initialize$default(Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 34
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->initialize(Lkotlin/jvm/functions/Function1;)V

    return-void
.end method


# virtual methods
.method public final addWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 47
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->addWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V

    .line 48
    :cond_0
    return-void
.end method

.method public final connectDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V
    .locals 2
    .param p1, "device"    # Landroid/net/wifi/p2p/WifiP2pDevice;
    .param p2, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/net/wifi/p2p/WifiP2pDevice;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onResult"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 55
    new-instance v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$connectDevice$onResult2$1;

    invoke-direct {v0, p2}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$connectDevice$onResult2$1;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    .line 63
    .local v0, "onResult2":Lkotlin/jvm/functions/Function1;
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v1, p1, v0}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->connectDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V

    .line 64
    :cond_0
    return-void
.end method

.method public final disconnect()V
    .locals 1

    .line 67
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->disconnect()V

    .line 68
    :cond_0
    return-void
.end method

.method public final getGroupInfo(Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "action"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Landroid/net/wifi/p2p/WifiP2pGroup;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "action"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 99
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->getGroupInfo(Lkotlin/jvm/functions/Function1;)V

    .line 100
    :cond_0
    return-void
.end method

.method public final getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;
    .locals 1

    .line 19
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->mAbsWifiP2PClientService$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    return-object v0
.end method

.method public final init(Lkotlin/jvm/functions/Function1;)V
    .locals 4
    .param p1, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "onResult"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getServerId()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getP2pWebSocketServerPort()I

    move-result v1

    new-instance v2, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$init$1;

    invoke-direct {v2, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$init$1;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast v2, Lkotlin/jvm/functions/Function1;

    const/4 v3, 0x0

    invoke-static {v3, v0, v1, v2}, Lcom/rokid/glasses/transport/sdk/api/TransportSDK;->initSDK(ZLjava/lang/String;ILkotlin/jvm/functions/Function1;)V

    .line 32
    return-void
.end method

.method public final initialize(Lkotlin/jvm/functions/Function1;)V
    .locals 2
    .param p1, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 35
    new-instance v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$initialize$onResult2$1;

    invoke-direct {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$initialize$onResult2$1;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    .line 43
    .local v0, "onResult2":Lkotlin/jvm/functions/Function1;
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->initialize(Lkotlin/jvm/functions/Function1;)V

    .line 44
    :cond_0
    return-void
.end method

.method public final isConnect(Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "action"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "action"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 103
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->isConnect(Lkotlin/jvm/functions/Function1;)V

    .line 104
    :cond_0
    return-void
.end method

.method public final release()V
    .locals 0

    .line 119
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/api/TransportSDK;->destroy()V

    .line 120
    return-void
.end method

.method public final removeWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->removeWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V

    .line 52
    :cond_0
    return-void
.end method

.method public final requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "action"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Landroid/net/wifi/p2p/WifiP2pInfo;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "action"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 95
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V

    .line 96
    :cond_0
    return-void
.end method

.method public final sendAudioStreamData([B)V
    .locals 1
    .param p1, "streamData"    # [B

    const-string/jumbo v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 111
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->sendAudioStreamData([B)V

    .line 112
    :cond_0
    return-void
.end method

.method public final sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 107
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->sendTextMessage(Ljava/lang/String;)V

    .line 108
    :cond_0
    return-void
.end method

.method public final sendVideoStreamData([B)V
    .locals 1
    .param p1, "streamData"    # [B

    const-string/jumbo v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 115
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->sendVideoStreamData([B)V

    .line 116
    :cond_0
    return-void
.end method

.method public final startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V
    .locals 2
    .param p1, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 71
    new-instance v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$startDiscoverPeers$onResult2$1;

    invoke-direct {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$startDiscoverPeers$onResult2$1;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    .line 79
    .local v0, "onResult2":Lkotlin/jvm/functions/Function1;
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V

    .line 80
    :cond_0
    return-void
.end method

.method public final stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V
    .locals 2
    .param p1, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 83
    new-instance v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$stopPeerDiscovery$onResult2$1;

    invoke-direct {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$stopPeerDiscovery$onResult2$1;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    .line 91
    .local v0, "onResult2":Lkotlin/jvm/functions/Function1;
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getMAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;->stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V

    .line 92
    :cond_0
    return-void
.end method
