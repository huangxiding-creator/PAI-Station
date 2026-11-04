.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;
.super Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/AbsWifiP2PGoService;
.source "WifiP2PGoServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000j\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010 \n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0012\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eH\u0016J>\u0010\u000f\u001a\u00020\u000c2\u0006\u0010\u0010\u001a\u00020\u00112)\u0010\u0012\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00150\u0014\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u0018\u0012\u0004\u0012\u00020\u000c\u0018\u00010\u0013H\u0016\u00f8\u0001\u0000J%\u0010\u0019\u001a\u00020\u000c2\u0018\u0010\u0012\u001a\u0014\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00150\u0014\u0012\u0004\u0012\u00020\u000c0\u0013H\u0016\u00f8\u0001\u0000J1\u0010\u001a\u001a\u00020\u000c2\'\u0010\u001b\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00110\u001c\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u001d\u0012\u0004\u0012\u00020\u000c0\u0013H\u0016J-\u0010\u001e\u001a\u00020\u000c2#\u0010\u001b\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010\u001f\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008( \u0012\u0004\u0012\u00020\u000c0\u0013H\u0016J\u0006\u0010!\u001a\u00020\u000cJ+\u0010\"\u001a\u00020\u000c2!\u0010\u001b\u001a\u001d\u0012\u0013\u0012\u00110\u0015\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\"\u0012\u0004\u0012\u00020\u000c0\u0013H\u0016J\u0008\u0010#\u001a\u00020\u0015H\u0016J\u0006\u0010$\u001a\u00020\u000cJ6\u0010%\u001a\u00020\u000c2)\u0010\u0012\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00150\u0014\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u0018\u0012\u0004\u0012\u00020\u000c\u0018\u00010\u0013H\u0016\u00f8\u0001\u0000J\u0010\u0010&\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eH\u0016J-\u0010\'\u001a\u00020\u000c2#\u0010\u001b\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010(\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008()\u0012\u0004\u0012\u00020\u000c0\u0013H\u0016J\u0010\u0010*\u001a\u00020\u000c2\u0006\u0010+\u001a\u00020,H\u0016J \u0010-\u001a\u00020\u000c2\u0006\u0010.\u001a\u00020\u00042\u0006\u0010/\u001a\u00020,2\u0006\u00100\u001a\u00020\u0004H\u0016J\u0010\u00101\u001a\u00020\u000c2\u0006\u00102\u001a\u00020\u0004H\u0016J\u0010\u00103\u001a\u00020\u000c2\u0006\u0010+\u001a\u000204H\u0016J\u0010\u00103\u001a\u00020\u000c2\u0006\u0010+\u001a\u00020,H\u0016J6\u00105\u001a\u00020\u000c2)\u0010\u0012\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00150\u0014\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u0018\u0012\u0004\u0012\u00020\u000c\u0018\u00010\u0013H\u0016\u00f8\u0001\u0000J6\u00106\u001a\u00020\u000c2)\u0010\u0012\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00150\u0014\u00a2\u0006\u000c\u0008\u0016\u0012\u0008\u0008\u0017\u0012\u0004\u0008\u0008(\u0018\u0012\u0004\u0012\u00020\u000c\u0018\u00010\u0013H\u0016\u00f8\u0001\u0000R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0005\u001a\u00020\u00068BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\t\u0010\n\u001a\u0004\u0008\u0007\u0010\u0008\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u00067"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/AbsWifiP2PGoService;",
        "()V",
        "TAG",
        "",
        "mWifiP2PManager",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;",
        "getMWifiP2PManager",
        "()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;",
        "mWifiP2PManager$delegate",
        "Lkotlin/Lazy;",
        "addWifiP2PListener",
        "",
        "listener",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;",
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
        "createGroup",
        "getClientList",
        "action",
        "",
        "list",
        "getGroupInfo",
        "Landroid/net/wifi/p2p/WifiP2pGroup;",
        "group",
        "init",
        "isConnect",
        "isWebsocketServerRunning",
        "release",
        "removeGroup",
        "removeWifiP2PListener",
        "requestConnectionInfo",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
        "info",
        "sendAudioStreamData",
        "streamData",
        "",
        "sendStreamData",
        "tag",
        "bytes",
        "clientId",
        "sendTextMessage",
        "message",
        "sendVideoStreamData",
        "Ljava/nio/ByteBuffer;",
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
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;

.field private static final TAG:Ljava/lang/String; = "WifiP2PGoServiceImpl"

.field private static final mWifiP2PManager$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;

    .line 18
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl$mWifiP2PManager$2;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl$mWifiP2PManager$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->mWifiP2PManager$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/AbsWifiP2PGoService;-><init>()V

    return-void
.end method

.method private final getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;
    .locals 1

    .line 18
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->mWifiP2PManager$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    return-object v0
.end method


# virtual methods
.method public addWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 83
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->addWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;)V

    .line 84
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

    .line 47
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->connectToDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V

    .line 48
    return-void
.end method

.method public createGroup(Lkotlin/jvm/functions/Function1;)V
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

    const-string v0, "onResult"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 27
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->createGroup(Lkotlin/jvm/functions/Function1;)V

    .line 28
    return-void
.end method

.method public getClientList(Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "action"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/util/List<",
            "+",
            "Landroid/net/wifi/p2p/WifiP2pDevice;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "action"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 59
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getClientList(Lkotlin/jvm/functions/Function1;)V

    .line 60
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

    .line 51
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getGroupInfo(Lkotlin/jvm/functions/Function1;)V

    .line 52
    return-void
.end method

.method public final init()V
    .locals 1

    .line 23
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->init()V

    .line 24
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

    .line 91
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnect(Lkotlin/jvm/functions/Function1;)V

    .line 92
    return-void
.end method

.method public isWebsocketServerRunning()Z
    .locals 1

    .line 95
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isWebsocketServerRunning()Z

    move-result v0

    return v0
.end method

.method public final release()V
    .locals 2

    .line 99
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->release()V

    .line 100
    const-string v0, " release: "

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "WifiP2PGoServiceImpl"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 101
    return-void
.end method

.method public removeGroup(Lkotlin/jvm/functions/Function1;)V
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

    .line 31
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->removeGroup(Lkotlin/jvm/functions/Function1;)V

    .line 32
    return-void
.end method

.method public removeWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 87
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->removeWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;)V

    .line 88
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

    .line 55
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V

    .line 56
    return-void
.end method

.method public sendAudioStreamData([B)V
    .locals 1
    .param p1, "streamData"    # [B

    const-string v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 67
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->sendAudioStreamData([B)V

    .line 68
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

    .line 79
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->sendStreamData(Ljava/lang/String;[BLjava/lang/String;)V

    .line 80
    return-void
.end method

.method public sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 63
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->sendTextMessage(Ljava/lang/String;)V

    .line 64
    return-void
.end method

.method public sendVideoStreamData(Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p1, "streamData"    # Ljava/nio/ByteBuffer;

    const-string v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 75
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->sendVideoStreamData(Ljava/nio/ByteBuffer;)V

    .line 76
    return-void
.end method

.method public sendVideoStreamData([B)V
    .locals 1
    .param p1, "streamData"    # [B

    const-string v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 71
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->sendVideoStreamData([B)V

    .line 72
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

    .line 35
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V

    .line 36
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

    .line 39
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/WifiP2PGoServiceImpl;->getMWifiP2PManager()Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V

    .line 40
    return-void
.end method
