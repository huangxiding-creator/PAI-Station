.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;
.super Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;
.source "WifiP2PClientServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\\\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0008\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u000cH\u0016J>\u0010\r\u001a\u00020\n2\u0006\u0010\u000e\u001a\u00020\u000f2)\u0010\u0010\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00130\u0012\u00a2\u0006\u000c\u0008\u0014\u0012\u0008\u0008\u0015\u0012\u0004\u0008\u0008(\u0016\u0012\u0004\u0012\u00020\n\u0018\u00010\u0011H\u0016\u00f8\u0001\u0000J\u0008\u0010\u0017\u001a\u00020\nH\u0016J-\u0010\u0018\u001a\u00020\n2#\u0010\u0019\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010\u001a\u00a2\u0006\u000c\u0008\u0014\u0012\u0008\u0008\u0015\u0012\u0004\u0008\u0008(\u001b\u0012\u0004\u0012\u00020\n0\u0011H\u0016J\u0006\u0010\u001c\u001a\u00020\nJ6\u0010\u001d\u001a\u00020\n2)\u0010\u0010\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00130\u0012\u00a2\u0006\u000c\u0008\u0014\u0012\u0008\u0008\u0015\u0012\u0004\u0008\u0008(\u0016\u0012\u0004\u0012\u00020\n\u0018\u00010\u0011H\u0016\u00f8\u0001\u0000J+\u0010\u001e\u001a\u00020\n2!\u0010\u0019\u001a\u001d\u0012\u0013\u0012\u00110\u0013\u00a2\u0006\u000c\u0008\u0014\u0012\u0008\u0008\u0015\u0012\u0004\u0008\u0008(\u001e\u0012\u0004\u0012\u00020\n0\u0011H\u0016J\u0006\u0010\u001f\u001a\u00020\nJ\u0010\u0010 \u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u000cH\u0016J-\u0010!\u001a\u00020\n2#\u0010\u0019\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010\"\u00a2\u0006\u000c\u0008\u0014\u0012\u0008\u0008\u0015\u0012\u0004\u0008\u0008(#\u0012\u0004\u0012\u00020\n0\u0011H\u0016J\u0010\u0010$\u001a\u00020\n2\u0006\u0010%\u001a\u00020&H\u0016J \u0010\'\u001a\u00020\n2\u0006\u0010(\u001a\u00020)2\u0006\u0010*\u001a\u00020&2\u0006\u0010+\u001a\u00020)H\u0016J\u0010\u0010,\u001a\u00020\n2\u0006\u0010-\u001a\u00020)H\u0016J\u0010\u0010.\u001a\u00020\n2\u0006\u0010%\u001a\u00020&H\u0016J6\u0010/\u001a\u00020\n2)\u0010\u0010\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00130\u0012\u00a2\u0006\u000c\u0008\u0014\u0012\u0008\u0008\u0015\u0012\u0004\u0008\u0008(\u0016\u0012\u0004\u0012\u00020\n\u0018\u00010\u0011H\u0016\u00f8\u0001\u0000J6\u00100\u001a\u00020\n2)\u0010\u0010\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00130\u0012\u00a2\u0006\u000c\u0008\u0014\u0012\u0008\u0008\u0015\u0012\u0004\u0008\u0008(\u0016\u0012\u0004\u0012\u00020\n\u0018\u00010\u0011H\u0016\u00f8\u0001\u0000R\u001b\u0010\u0003\u001a\u00020\u00048BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0007\u0010\u0008\u001a\u0004\u0008\u0005\u0010\u0006\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u00061"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;",
        "()V",
        "mWifiP2PManager",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;",
        "getMWifiP2PManager",
        "()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;",
        "mWifiP2PManager$delegate",
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
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult;",
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
        "sendStreamData",
        "tag",
        "",
        "bytes",
        "clientId",
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
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;

.field private static final mWifiP2PManager$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;

    .line 11
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl$mWifiP2PManager$2;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl$mWifiP2PManager$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->mWifiP2PManager$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;-><init>()V

    return-void
.end method

.method private final getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;
    .locals 1

    .line 11
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->mWifiP2PManager$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    return-object v0
.end method


# virtual methods
.method public addWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 63
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->addWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V

    .line 64
    return-void
.end method

.method public connectDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "device"    # Landroid/net/wifi/p2p/WifiP2pDevice;
    .param p2, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/net/wifi/p2p/WifiP2pDevice;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->connectDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V

    .line 44
    return-void
.end method

.method public disconnect()V
    .locals 1

    .line 76
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->disconnect()V

    .line 77
    return-void
.end method

.method public getGroupInfo(Lkotlin/jvm/functions/Function1;)V
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

    .line 36
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getGroupInfo(Lkotlin/jvm/functions/Function1;)V

    .line 37
    return-void
.end method

.method public final init()V
    .locals 1

    .line 16
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->init()V

    .line 17
    return-void
.end method

.method public initialize(Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 20
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->initialize(Lkotlin/jvm/functions/Function1;)V

    .line 21
    return-void
.end method

.method public isConnect(Lkotlin/jvm/functions/Function1;)V
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

    .line 71
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->isConnect(Lkotlin/jvm/functions/Function1;)V

    .line 72
    return-void
.end method

.method public final release()V
    .locals 1

    .line 80
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->release()V

    .line 81
    return-void
.end method

.method public removeWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 67
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->removeWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V

    .line 68
    return-void
.end method

.method public requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V
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

    .line 32
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V

    .line 33
    return-void
.end method

.method public sendAudioStreamData([B)V
    .locals 1
    .param p1, "streamData"    # [B

    const-string v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->sendAudioStreamData([B)V

    .line 52
    return-void
.end method

.method public sendStreamData(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "bytes"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "bytes"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 59
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->sendStreamData(Ljava/lang/String;[BLjava/lang/String;)V

    .line 60
    return-void
.end method

.method public sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 47
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->sendTextMessage(Ljava/lang/String;)V

    .line 48
    return-void
.end method

.method public sendVideoStreamData([B)V
    .locals 1
    .param p1, "streamData"    # [B

    const-string v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 55
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->sendVideoStreamData([B)V

    .line 56
    return-void
.end method

.method public startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 24
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V

    .line 25
    return-void
.end method

.method public stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 28
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/WifiP2PClientServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V

    .line 29
    return-void
.end method
