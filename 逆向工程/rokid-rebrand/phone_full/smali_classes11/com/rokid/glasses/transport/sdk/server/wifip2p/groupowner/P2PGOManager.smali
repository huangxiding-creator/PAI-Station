.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;
.super Ljava/lang/Object;
.source "P2PGOManager.kt"

# interfaces
.implements Landroid/net/wifi/p2p/WifiP2pManager$ChannelListener;


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nP2PGOManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PGOManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager\n+ 2 CancellableContinuation.kt\nkotlinx/coroutines/CancellableContinuationKt\n+ 3 IResult.kt\ncom/rokid/glasses/transport/sdk/api/callback/IResult$Companion\n+ 4 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,771:1\n314#2,11:772\n93#3:783\n1855#4,2:784\n1855#4,2:786\n1855#4,2:788\n1855#4,2:790\n1855#4,2:792\n1855#4,2:794\n*S KotlinDebug\n*F\n+ 1 P2PGOManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager\n*L\n412#1:772,11\n574#1:783\n611#1:784,2\n616#1:786,2\n716#1:788,2\n727#1:790,2\n737#1:792,2\n760#1:794,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u00b5\u0001\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010#\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\t\n\u0002\u0010 \n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\t\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u000b*\u0001\u0017\u0008\u0000\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\'\u001a\u00020(2\u0006\u0010)\u001a\u00020\u001bJ6\u0010*\u001a\u00020\u00062)\u0010+\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060-\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(0\u0012\u0004\u0012\u00020(\u0018\u00010,H\u0002\u00f8\u0001\u0000J8\u00101\u001a\u00020\u00062+\u0008\u0002\u0010+\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060-\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(0\u0012\u0004\u0012\u00020(\u0018\u00010,H\u0002\u00f8\u0001\u0000J@\u00102\u001a\u00020(2\u0006\u00103\u001a\u00020\u00112+\u0008\u0002\u0010+\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060-\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(0\u0012\u0004\u0012\u00020(\u0018\u00010,H\u0007\u00f8\u0001\u0000J2\u00104\u001a\u00020(2\'\u0010+\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060-\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(0\u0012\u0004\u0012\u00020(0,\u00f8\u0001\u0000J8\u00105\u001a\u00020(2+\u0008\u0002\u0010+\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060-\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(0\u0012\u0004\u0012\u00020(\u0018\u00010,H\u0003\u00f8\u0001\u0000J/\u00106\u001a\u00020(2\'\u00107\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u001108\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(9\u0012\u0004\u0012\u00020(0,J-\u0010:\u001a\u00020(2#\u00107\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010;\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(<\u0012\u0004\u0012\u00020(0,H\u0007J\u0013\u0010=\u001a\u0004\u0018\u00010;H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010>J6\u0010?\u001a\u0008\u0012\u0004\u0012\u0002H@0-\"\u0004\u0008\u0000\u0010@2\u0006\u0010A\u001a\u00020\u00042\u0008\u0010B\u001a\u0004\u0018\u00010CH\u0002\u00f8\u0001\u0001\u00f8\u0001\u0002\u00f8\u0001\u0000\u00a2\u0006\u0004\u0008D\u0010EJ\u0008\u0010F\u001a\u00020GH\u0002J\u0006\u0010H\u001a\u00020(J)\u0010I\u001a\u00020(2!\u00107\u001a\u001d\u0012\u0013\u0012\u00110\u0006\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(I\u0012\u0004\u0012\u00020(0,J\u0006\u0010J\u001a\u00020\u0006J\u0008\u0010K\u001a\u00020(H\u0016J\u0010\u0010L\u001a\u00020(2\u0006\u0010M\u001a\u00020NH\u0002J\u0008\u0010O\u001a\u00020(H\u0002J\u0006\u0010P\u001a\u00020(J\u0006\u0010Q\u001a\u00020(J8\u0010R\u001a\u00020(2+\u0008\u0002\u0010+\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060-\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(0\u0012\u0004\u0012\u00020(\u0018\u00010,H\u0007\u00f8\u0001\u0000J\u000e\u0010S\u001a\u00020(2\u0006\u0010)\u001a\u00020\u001bJ+\u0010T\u001a\u00020(2#\u00107\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010\u001d\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(U\u0012\u0004\u0012\u00020(0,J\u000e\u0010V\u001a\u00020(2\u0006\u0010W\u001a\u00020XJ\u000e\u0010Y\u001a\u00020(2\u0006\u0010Z\u001a\u00020[J\u001e\u0010\\\u001a\u00020(2\u0006\u0010]\u001a\u00020\u00042\u0006\u0010^\u001a\u00020X2\u0006\u0010_\u001a\u00020\u0004J\u000e\u0010`\u001a\u00020(2\u0006\u0010a\u001a\u00020\u0004J\u000e\u0010b\u001a\u00020(2\u0006\u0010M\u001a\u00020NJ\u000e\u0010b\u001a\u00020(2\u0006\u0010W\u001a\u00020XJ8\u0010c\u001a\u00020(2+\u0008\u0002\u0010+\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060-\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(0\u0012\u0004\u0012\u00020(\u0018\u00010,H\u0007\u00f8\u0001\u0000J6\u0010d\u001a\u00020(2+\u0008\u0002\u0010+\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060-\u00a2\u0006\u000c\u0008.\u0012\u0008\u0008/\u0012\u0004\u0008\u0008(0\u0012\u0004\u0012\u00020(\u0018\u00010,\u00f8\u0001\u0000J\u0008\u0010e\u001a\u00020(H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001b\u0010\n\u001a\u00020\u000b8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000e\u0010\u000f\u001a\u0004\u0008\u000c\u0010\rR\u0010\u0010\u0010\u001a\u0004\u0018\u00010\u0011X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0012\u001a\u0004\u0018\u00010\u0013X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0014\u001a\u00020\u0015X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0016\u001a\u00020\u0017X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0018R\u0014\u0010\u0019\u001a\u0008\u0012\u0004\u0012\u00020\u001b0\u001aX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u001c\u001a\u0004\u0018\u00010\u001dX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001e\u001a\u00020\u001fX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010 \u001a\u0004\u0018\u00010!X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001b\u0010\"\u001a\u00020#8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008&\u0010\u000f\u001a\u0004\u0008$\u0010%\u0082\u0002\u000f\n\u0002\u0008\u0019\n\u0002\u0008!\n\u0005\u0008\u00a1\u001e0\u0001\u00a8\u0006f"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;",
        "Landroid/net/wifi/p2p/WifiP2pManager$ChannelListener;",
        "()V",
        "TAG",
        "",
        "isConnected",
        "",
        "isRegisterReceiver",
        "mBufferHelper",
        "Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;",
        "mContex",
        "Landroid/content/Context;",
        "getMContex",
        "()Landroid/content/Context;",
        "mContex$delegate",
        "Lkotlin/Lazy;",
        "mGroupOwner",
        "Landroid/net/wifi/p2p/WifiP2pDevice;",
        "mP2PBroadcastReceiver",
        "Landroid/content/BroadcastReceiver;",
        "mSocketServerChannel",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;",
        "mSocketServerListener",
        "com/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$mSocketServerListener$1",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$mSocketServerListener$1;",
        "mWifiP2PListeners",
        "",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;",
        "mWifiP2pInfo",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
        "mutex",
        "Lkotlinx/coroutines/sync/Mutex;",
        "wifiP2pChannel",
        "Landroid/net/wifi/p2p/WifiP2pManager$Channel;",
        "wifiP2pManager",
        "Landroid/net/wifi/p2p/WifiP2pManager;",
        "getWifiP2pManager",
        "()Landroid/net/wifi/p2p/WifiP2pManager;",
        "wifiP2pManager$delegate",
        "addWifiP2PListener",
        "",
        "listener",
        "check",
        "onResult",
        "Lkotlin/Function1;",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult;",
        "Lkotlin/ParameterName;",
        "name",
        "result",
        "checkChannel",
        "connectToDevice",
        "device",
        "createGroup",
        "createWifiP2PGroup",
        "getClientList",
        "action",
        "",
        "list",
        "getGroupInfo",
        "Landroid/net/wifi/p2p/WifiP2pGroup;",
        "group",
        "getGroupInfoSuspend",
        "(Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "getIFailResult",
        "T",
        "msg",
        "e",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
        "getIFailResult-Guu2Vc4",
        "(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;",
        "getIntentFilter",
        "Landroid/content/IntentFilter;",
        "init",
        "isConnect",
        "isWebsocketServerRunning",
        "onChannelDisconnected",
        "parseData",
        "buffer",
        "Ljava/nio/ByteBuffer;",
        "registerReceiver",
        "release",
        "releaseGroup",
        "removeGroup",
        "removeWifiP2PListener",
        "requestConnectionInfo",
        "info",
        "sendAudioStreamData",
        "streamData",
        "",
        "sendFile",
        "file",
        "Ljava/io/File;",
        "sendStreamData",
        "tag",
        "bytes",
        "clientId",
        "sendTextMessage",
        "message",
        "sendVideoStreamData",
        "startDiscoverPeers",
        "stopPeerDiscovery",
        "unregisterReceiver",
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


# instance fields
.field private final TAG:Ljava/lang/String;

.field private volatile isConnected:Z

.field private isRegisterReceiver:Z

.field private mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

.field private final mContex$delegate:Lkotlin/Lazy;

.field private mGroupOwner:Landroid/net/wifi/p2p/WifiP2pDevice;

.field private mP2PBroadcastReceiver:Landroid/content/BroadcastReceiver;

.field private mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

.field private final mSocketServerListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$mSocketServerListener$1;

.field private final mWifiP2PListeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;",
            ">;"
        }
    .end annotation
.end field

.field private mWifiP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;

.field private final mutex:Lkotlinx/coroutines/sync/Mutex;

.field private wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

.field private final wifiP2pManager$delegate:Lkotlin/Lazy;


# direct methods
.method public static synthetic $r8$lambda$5HWXqa84jweiOakht8nNgvcf-qA(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->requestConnectionInfo$lambda$2(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pInfo;)V

    return-void
.end method

.method public static synthetic $r8$lambda$T99y-IhL4994W8r1YizSCtcQ_vw(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pGroup;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getGroupInfo$lambda$0(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pGroup;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    const-string v0, "P2PGOManager "

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    .line 44
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    .line 45
    const/4 v0, 0x1

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {v2, v0, v1}, Lkotlinx/coroutines/sync/MutexKt;->Mutex$default(ZILjava/lang/Object;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mutex:Lkotlinx/coroutines/sync/Mutex;

    .line 47
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$wifiP2pManager$2;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$wifiP2pManager$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pManager$delegate:Lkotlin/Lazy;

    .line 51
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$mContex$2;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$mContex$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mContex$delegate:Lkotlin/Lazy;

    .line 56
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;-><init>()V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    .line 60
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;-><init>()V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    .line 667
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$mSocketServerListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$mSocketServerListener$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$mSocketServerListener$1;

    .line 41
    return-void
.end method

.method public static final synthetic access$createWifiP2PGroup(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;
    .param p1, "onResult"    # Lkotlin/jvm/functions/Function1;

    .line 41
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->createWifiP2PGroup(Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method public static final synthetic access$getGroupInfoSuspend(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;
    .param p1, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 41
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getGroupInfoSuspend(Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getIFailResult-Guu2Vc4(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "e"    # Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    .line 41
    invoke-direct {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getIFailResult-Guu2Vc4(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getMSocketServerChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    .line 41
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    return-object v0
.end method

.method public static final synthetic access$getMSocketServerListener$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$mSocketServerListener$1;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    .line 41
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$mSocketServerListener$1;

    return-object v0
.end method

.method public static final synthetic access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/util/Set;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    .line 41
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getMutex$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lkotlinx/coroutines/sync/Mutex;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    .line 41
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mutex:Lkotlinx/coroutines/sync/Mutex;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    .line 41
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getWifiP2pChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    .line 41
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    return-object v0
.end method

.method public static final synthetic access$getWifiP2pManager(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Landroid/net/wifi/p2p/WifiP2pManager;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    .line 41
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$isConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    .line 41
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnected:Z

    return v0
.end method

.method public static final synthetic access$parseData(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 41
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->parseData(Ljava/nio/ByteBuffer;)V

    return-void
.end method

.method public static final synthetic access$setConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;
    .param p1, "<set-?>"    # Z

    .line 41
    iput-boolean p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnected:Z

    return-void
.end method

.method public static final synthetic access$setMGroupOwner$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Landroid/net/wifi/p2p/WifiP2pDevice;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;
    .param p1, "<set-?>"    # Landroid/net/wifi/p2p/WifiP2pDevice;

    .line 41
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mGroupOwner:Landroid/net/wifi/p2p/WifiP2pDevice;

    return-void
.end method

.method private final check(Lkotlin/jvm/functions/Function1;)Z
    .locals 10
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
            ">;)Z"
        }
    .end annotation

    .line 626
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;->isWifiSupported()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_1

    .line 627
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v2, " Not Supported Wifi"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 628
    if-eqz p1, :cond_0

    .line 629
    nop

    .line 630
    nop

    .line 631
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    const/4 v7, 0x4

    const/4 v8, 0x0

    const/4 v4, -0x1

    const-string v5, "Not Supported Wifi"

    const/4 v6, 0x0

    move-object v3, v0

    invoke-direct/range {v3 .. v8}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 629
    const-string v2, "Not Supported Wifi"

    invoke-direct {p0, v2, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getIFailResult-Guu2Vc4(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v0

    .line 628
    invoke-interface {p1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 634
    :cond_0
    return v1

    .line 637
    :cond_1
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;->isWifiEnabled()Z

    move-result v0

    if-nez v0, :cond_3

    .line 638
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v2, "Wifi \u672a\u5f00\u542f"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 639
    if-eqz p1, :cond_2

    .line 640
    nop

    .line 641
    nop

    .line 642
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    const/4 v8, 0x4

    const/4 v9, 0x0

    const/4 v5, -0x1

    const-string v6, "Wifi \u672a\u5f00\u542f"

    const/4 v7, 0x0

    move-object v4, v0

    invoke-direct/range {v4 .. v9}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 640
    invoke-direct {p0, v2, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getIFailResult-Guu2Vc4(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v0

    .line 639
    invoke-interface {p1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 645
    :cond_2
    return v1

    .line 648
    :cond_3
    const/4 v0, 0x1

    return v0
.end method

.method private final checkChannel(Lkotlin/jvm/functions/Function1;)Z
    .locals 9
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
            ">;)Z"
        }
    .end annotation

    .line 652
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->check(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 653
    return v1

    .line 654
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    if-nez v0, :cond_2

    .line 655
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v2, " wifiP2pChannel == null"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 656
    if-eqz p1, :cond_1

    .line 657
    nop

    .line 658
    nop

    .line 659
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    const/4 v7, 0x4

    const/4 v8, 0x0

    const/4 v4, -0x1

    const-string v5, "wifiP2pChannel \u672a\u521d\u59cb\u5316"

    const/4 v6, 0x0

    move-object v3, v0

    invoke-direct/range {v3 .. v8}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 657
    const-string v2, "wifiP2pChannel \u672a\u521d\u59cb\u5316"

    invoke-direct {p0, v2, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getIFailResult-Guu2Vc4(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v0

    .line 656
    invoke-interface {p1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 662
    :cond_1
    return v1

    .line 664
    :cond_2
    const/4 v0, 0x1

    return v0
.end method

.method static synthetic checkChannel$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Z
    .locals 0

    .line 651
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result p0

    return p0
.end method

.method public static synthetic connectToDevice$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 368
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    .line 370
    const/4 p2, 0x0

    .line 368
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->connectToDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method private final createWifiP2PGroup(Lkotlin/jvm/functions/Function1;)V
    .locals 3
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

    .line 261
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 262
    return-void

    .line 264
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$createWifiP2PGroup$1;

    invoke-direct {v2, p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$createWifiP2PGroup$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v2, Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->createGroup(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 282
    return-void
.end method

.method static synthetic createWifiP2PGroup$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 260
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->createWifiP2PGroup(Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method private static final getGroupInfo$lambda$0(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pGroup;)V
    .locals 1
    .param p0, "$action"    # Lkotlin/jvm/functions/Function1;
    .param p1, "group"    # Landroid/net/wifi/p2p/WifiP2pGroup;

    const-string v0, "$action"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 408
    invoke-interface {p0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 409
    return-void
.end method

.method private final getGroupInfoSuspend(Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 7
    .param p1, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Landroid/net/wifi/p2p/WifiP2pGroup;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 412
    const/4 v0, 0x0

    .line 772
    .local v0, "$i$f$suspendCancellableCoroutine":I
    move-object v1, p1

    .local v1, "uCont$iv":Lkotlin/coroutines/Continuation;
    const/4 v2, 0x0

    .line 773
    .local v2, "$i$a$-suspendCoroutineUninterceptedOrReturn-CancellableContinuationKt$suspendCancellableCoroutine$2$iv":I
    new-instance v3, Lkotlinx/coroutines/CancellableContinuationImpl;

    invoke-static {v1}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->intercepted(Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v4

    const/4 v5, 0x1

    invoke-direct {v3, v4, v5}, Lkotlinx/coroutines/CancellableContinuationImpl;-><init>(Lkotlin/coroutines/Continuation;I)V

    .line 779
    .local v3, "cancellable$iv":Lkotlinx/coroutines/CancellableContinuationImpl;
    invoke-virtual {v3}, Lkotlinx/coroutines/CancellableContinuationImpl;->initCancellability()V

    .line 780
    move-object v4, v3

    check-cast v4, Lkotlinx/coroutines/CancellableContinuation;

    .local v4, "continuation":Lkotlinx/coroutines/CancellableContinuation;
    const/4 v5, 0x0

    .line 413
    .local v5, "$i$a$-suspendCancellableCoroutine-P2PGOManager$getGroupInfoSuspend$2":I
    new-instance v6, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$getGroupInfoSuspend$2$1;

    invoke-direct {v6, v4}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$getGroupInfoSuspend$2$1;-><init>(Lkotlinx/coroutines/CancellableContinuation;)V

    check-cast v6, Lkotlin/jvm/functions/Function1;

    invoke-virtual {p0, v6}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getGroupInfo(Lkotlin/jvm/functions/Function1;)V

    .line 416
    nop

    .line 780
    .end local v4    # "continuation":Lkotlinx/coroutines/CancellableContinuation;
    .end local v5    # "$i$a$-suspendCancellableCoroutine-P2PGOManager$getGroupInfoSuspend$2":I
    nop

    .line 781
    invoke-virtual {v3}, Lkotlinx/coroutines/CancellableContinuationImpl;->getResult()Ljava/lang/Object;

    move-result-object v1

    .line 772
    .end local v1    # "uCont$iv":Lkotlin/coroutines/Continuation;
    .end local v2    # "$i$a$-suspendCoroutineUninterceptedOrReturn-CancellableContinuationKt$suspendCancellableCoroutine$2$iv":I
    .end local v3    # "cancellable$iv":Lkotlinx/coroutines/CancellableContinuationImpl;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v2

    if-ne v1, v2, :cond_0

    invoke-static {p1}, Lkotlin/coroutines/jvm/internal/DebugProbesKt;->probeCoroutineSuspended(Lkotlin/coroutines/Continuation;)V

    .line 782
    :cond_0
    nop

    .line 416
    .end local v0    # "$i$f$suspendCancellableCoroutine":I
    return-object v1
.end method

.method private final getIFailResult-Guu2Vc4(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;
    .locals 9
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "e"    # Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/String;",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IException;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 572
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz p2, :cond_0

    invoke-virtual {p2}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;->getCode()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    goto :goto_0

    :cond_0
    move-object v2, v1

    :goto_0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ", "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    if-eqz p2, :cond_1

    invoke-virtual {p2}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;->getMessage()Ljava/lang/String;

    move-result-object v1

    :cond_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 571
    nop

    .line 573
    .local v0, "erroeMsg":Ljava/lang/String;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 574
    sget-object v7, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    new-instance v8, Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    if-eqz p2, :cond_2

    invoke-virtual {p2}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;->getCode()I

    move-result v1

    goto :goto_1

    :cond_2
    const/4 v1, -0x1

    :goto_1
    move v2, v1

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v4, 0x0

    move-object v1, v8

    move-object v3, v0

    invoke-direct/range {v1 .. v6}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v1, "exception$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    move-object v2, v7

    .local v2, "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    const/4 v3, 0x0

    .line 783
    .local v3, "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt;->createFailure(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 574
    .end local v1    # "exception$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .end local v2    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v3    # "$i$f$failure":I
    return-object v1
.end method

.method private final getIntentFilter()Landroid/content/IntentFilter;
    .locals 2

    .line 251
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 252
    .local v0, "intentFilter":Landroid/content/IntentFilter;
    const-string v1, "android.net.wifi.p2p.STATE_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 253
    const-string v1, "android.net.wifi.p2p.PEERS_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 254
    const-string v1, "android.net.wifi.p2p.CONNECTION_STATE_CHANGE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 255
    const-string v1, "android.net.wifi.p2p.THIS_DEVICE_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 256
    return-object v0
.end method

.method private final getMContex()Landroid/content/Context;
    .locals 2

    .line 51
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mContex$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    const-string v1, "<get-mContex>(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/content/Context;

    return-object v0
.end method

.method private final getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;
    .locals 1

    .line 47
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pManager$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pManager;

    return-object v0
.end method

.method private final parseData(Ljava/nio/ByteBuffer;)V
    .locals 21
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 709
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->get()B

    move-result v2

    .line 710
    .local v2, "dataType":B
    nop

    .line 711
    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->TEXT_MESSAGE:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v3

    if-ne v2, v3, :cond_1

    .line 712
    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v3

    new-array v3, v3, [B

    .line 713
    .local v3, "data":[B
    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 714
    new-instance v4, Ljava/lang/String;

    sget-object v5, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v4, v3, v5}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 715
    .local v4, "text":Ljava/lang/String;
    iget-object v5, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, " Received text message: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 716
    iget-object v5, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    check-cast v5, Ljava/lang/Iterable;

    .local v5, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v6, 0x0

    .line 788
    .local v6, "$i$f$forEach":I
    invoke-interface {v5}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_0

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    .local v8, "element$iv":Ljava/lang/Object;
    move-object v9, v8

    check-cast v9, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .local v9, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/4 v10, 0x0

    .line 717
    .local v10, "$i$a$-forEach-P2PGOManager$parseData$1":I
    invoke-interface {v9, v4}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onTextMessage(Ljava/lang/String;)V

    .line 718
    nop

    .line 788
    .end local v9    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v10    # "$i$a$-forEach-P2PGOManager$parseData$1":I
    nop

    .end local v8    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 789
    :cond_0
    move/from16 v19, v2

    .end local v3    # "data":[B
    .end local v4    # "text":Ljava/lang/String;
    .end local v5    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v6    # "$i$f$forEach":I
    goto/16 :goto_4

    .line 721
    :cond_1
    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->FILE_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v3

    const-string v4, " bytes"

    if-ne v2, v3, :cond_2

    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " Received file data: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    move/from16 v19, v2

    goto/16 :goto_4

    .line 722
    :cond_2
    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->AUDIO_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v3

    if-ne v2, v3, :cond_4

    .line 723
    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " Received audio stream data: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 724
    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v4

    invoke-virtual {v3, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v3

    .line 725
    .local v3, "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    .line 726
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 727
    iget-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    check-cast v4, Ljava/lang/Iterable;

    .local v4, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 790
    .local v5, "$i$f$forEach":I
    invoke-interface {v4}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_1
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    .local v7, "element$iv":Ljava/lang/Object;
    move-object v8, v7

    check-cast v8, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .local v8, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/4 v9, 0x0

    .line 728
    .local v9, "$i$a$-forEach-P2PGOManager$parseData$2":I
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v10

    invoke-interface {v8, v10}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onAudioStream(Ljava/nio/ByteBuffer;)V

    .line 729
    nop

    .line 790
    .end local v8    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v9    # "$i$a$-forEach-P2PGOManager$parseData$2":I
    nop

    .end local v7    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 791
    :cond_3
    nop

    .line 730
    .end local v4    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v5    # "$i$f$forEach":I
    iget-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v4, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V

    move/from16 v19, v2

    .end local v3    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    goto/16 :goto_4

    .line 732
    :cond_4
    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->VIDEO_H264_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v3

    if-ne v2, v3, :cond_6

    .line 733
    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " Received video stream data: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "bytes"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 734
    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v4

    invoke-virtual {v3, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v3

    .line 735
    .restart local v3    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    .line 736
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 737
    iget-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    check-cast v4, Ljava/lang/Iterable;

    .restart local v4    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 792
    .restart local v5    # "$i$f$forEach":I
    invoke-interface {v4}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_2
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_5

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    .restart local v7    # "element$iv":Ljava/lang/Object;
    move-object v8, v7

    check-cast v8, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .restart local v8    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/4 v9, 0x0

    .line 738
    .local v9, "$i$a$-forEach-P2PGOManager$parseData$3":I
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v10

    invoke-interface {v8, v10}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onVideoH264Stream(Ljava/nio/ByteBuffer;)V

    .line 739
    nop

    .line 792
    .end local v8    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v9    # "$i$a$-forEach-P2PGOManager$parseData$3":I
    nop

    .end local v7    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 793
    :cond_5
    nop

    .line 740
    .end local v4    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v5    # "$i$f$forEach":I
    iget-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v4, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V

    move/from16 v19, v2

    .end local v3    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    goto/16 :goto_4

    .line 742
    :cond_6
    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->STREAM_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v3

    if-ne v2, v3, :cond_9

    .line 743
    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v3

    new-array v3, v3, [B

    .line 744
    .local v3, "data":[B
    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 745
    const/4 v4, 0x0

    .line 746
    .local v4, "offset":I
    sget-object v5, Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;

    invoke-virtual {v5, v3, v4}, Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;->findEndMarkerIndex([BI)I

    move-result v5

    .line 747
    .local v5, "endMarkerIndex":I
    sub-int v6, v5, v4

    .local v6, "metadataLength":I
    new-instance v7, Ljava/lang/String;

    .line 748
    sget-object v8, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v7, v3, v4, v6, v8}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    .line 749
    .local v7, "metadata":Ljava/lang/String;
    move-object v8, v7

    check-cast v8, Ljava/lang/CharSequence;

    const/4 v14, 0x1

    new-array v9, v14, [Ljava/lang/String;

    const-string v10, "|"

    const/4 v15, 0x0

    aput-object v10, v9, v15

    const/4 v12, 0x6

    const/4 v13, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-static/range {v8 .. v13}, Lkotlin/text/StringsKt;->split$default(Ljava/lang/CharSequence;[Ljava/lang/String;ZIILjava/lang/Object;)Ljava/util/List;

    move-result-object v8

    .line 751
    .local v8, "parts":Ljava/util/List;
    const-string v9, "\\u2063\\u2064\\u2065"

    sget-object v10, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v9, v10}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v9

    const-string v10, "this as java.lang.String).getBytes(charset)"

    invoke-static {v9, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    array-length v9, v9

    add-int/2addr v9, v5

    .line 752
    .local v9, "streamDataOffset":I
    array-length v10, v3

    sub-int/2addr v10, v9

    .line 753
    .local v10, "streamDataLength":I
    new-array v11, v10, [B

    .line 754
    .local v11, "streamData":[B
    invoke-static {v3, v9, v11, v15, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 756
    invoke-interface {v8}, Ljava/util/List;->size()I

    move-result v12

    const/4 v13, 0x2

    if-ne v12, v13, :cond_8

    .line 757
    const/4 v12, 0x0

    .local v12, "tag":Ljava/lang/Object;
    invoke-interface {v8, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    .line 758
    const/4 v13, 0x0

    .local v13, "clientId":Ljava/lang/Object;
    invoke-interface {v8, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    .line 759
    iget-object v14, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Received stream data: tag = "

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object v15, v12

    check-cast v15, Ljava/lang/String;

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v15, ", clientId = "

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object v15, v13

    check-cast v15, Ljava/lang/String;

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v15, ", data size = "

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v15, v11

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v14, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 760
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v14, 0x0

    .line 794
    .local v14, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v15

    :goto_3
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    if-eqz v16, :cond_7

    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v16

    move-object/from16 v17, v1

    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .local v16, "element$iv":Ljava/lang/Object;
    .local v17, "$this$forEach$iv":Ljava/lang/Iterable;
    move-object/from16 v1, v16

    check-cast v1, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .local v1, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/16 v18, 0x0

    .line 761
    .local v18, "$i$a$-forEach-P2PGOManager$parseData$4":I
    move/from16 v19, v2

    .end local v2    # "dataType":B
    .local v19, "dataType":B
    move-object v2, v12

    check-cast v2, Ljava/lang/String;

    move-object/from16 v20, v3

    .end local v3    # "data":[B
    .local v20, "data":[B
    move-object v3, v13

    check-cast v3, Ljava/lang/String;

    invoke-interface {v1, v2, v11, v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onStreamReceived(Ljava/lang/String;[BLjava/lang/String;)V

    .line 762
    nop

    .line 794
    .end local v1    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v18    # "$i$a$-forEach-P2PGOManager$parseData$4":I
    move-object/from16 v1, v17

    move/from16 v2, v19

    move-object/from16 v3, v20

    .end local v16    # "element$iv":Ljava/lang/Object;
    goto :goto_3

    .line 795
    .end local v17    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v19    # "dataType":B
    .end local v20    # "data":[B
    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    .restart local v2    # "dataType":B
    .restart local v3    # "data":[B
    :cond_7
    move-object/from16 v17, v1

    move/from16 v19, v2

    move-object/from16 v20, v3

    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "dataType":B
    .end local v3    # "data":[B
    .end local v12    # "tag":Ljava/lang/Object;
    .end local v13    # "clientId":Ljava/lang/Object;
    .end local v14    # "$i$f$forEach":I
    .restart local v19    # "dataType":B
    .restart local v20    # "data":[B
    goto :goto_4

    .line 764
    .end local v19    # "dataType":B
    .end local v20    # "data":[B
    .restart local v2    # "dataType":B
    .restart local v3    # "data":[B
    :cond_8
    move/from16 v19, v2

    move-object/from16 v20, v3

    .end local v2    # "dataType":B
    .end local v3    # "data":[B
    .restart local v19    # "dataType":B
    .restart local v20    # "data":[B
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Received stream data \u5143\u6570\u636e\u683c\u5f0f\u9519\u8bef\uff0c\u8df3\u8fc7: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v4    # "offset":I
    .end local v5    # "endMarkerIndex":I
    .end local v6    # "metadataLength":I
    .end local v7    # "metadata":Ljava/lang/String;
    .end local v8    # "parts":Ljava/util/List;
    .end local v9    # "streamDataOffset":I
    .end local v10    # "streamDataLength":I
    .end local v11    # "streamData":[B
    .end local v20    # "data":[B
    goto :goto_4

    .line 767
    .end local v19    # "dataType":B
    .restart local v2    # "dataType":B
    :cond_9
    move/from16 v19, v2

    .end local v2    # "dataType":B
    .restart local v19    # "dataType":B
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v2, " Unknown data"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 769
    :goto_4
    return-void
.end method

.method private final registerReceiver()V
    .locals 3

    .line 110
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)V

    check-cast v0, Landroid/content/BroadcastReceiver;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mP2PBroadcastReceiver:Landroid/content/BroadcastReceiver;

    .line 245
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getMContex()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mP2PBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getIntentFilter()Landroid/content/IntentFilter;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 246
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isRegisterReceiver:Z

    .line 248
    return-void
.end method

.method public static synthetic removeGroup$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 286
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->removeGroup(Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method private static final requestConnectionInfo$lambda$2(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 1
    .param p0, "$action"    # Lkotlin/jvm/functions/Function1;
    .param p1, "it"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    const-string v0, "$action"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 424
    invoke-interface {p0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 425
    return-void
.end method

.method public static synthetic startDiscoverPeers$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 318
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method public static synthetic stopPeerDiscovery$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 343
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method private final unregisterReceiver()V
    .locals 2

    .line 103
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isRegisterReceiver:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mP2PBroadcastReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_0

    .line 104
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getMContex()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mP2PBroadcastReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 105
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isRegisterReceiver:Z

    .line 107
    :cond_0
    return-void
.end method


# virtual methods
.method public final addWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 578
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 579
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 581
    :cond_0
    return-void
.end method

.method public final connectToDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V
    .locals 4
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

    .line 372
    const/4 v0, 0x0

    new-array v1, v0, [Ljava/lang/Object;

    const-string v2, " connectToDevice"

    invoke-static {v2, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 373
    invoke-direct {p0, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 374
    return-void

    .line 376
    :cond_0
    new-instance v1, Landroid/net/wifi/p2p/WifiP2pConfig;

    invoke-direct {v1}, Landroid/net/wifi/p2p/WifiP2pConfig;-><init>()V

    .line 377
    .local v1, "config":Landroid/net/wifi/p2p/WifiP2pConfig;
    iget-object v2, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    iput-object v2, v1, Landroid/net/wifi/p2p/WifiP2pConfig;->deviceAddress:Ljava/lang/String;

    .line 378
    iget-object v2, v1, Landroid/net/wifi/p2p/WifiP2pConfig;->wps:Landroid/net/wifi/WpsInfo;

    iput v0, v2, Landroid/net/wifi/WpsInfo;->setup:I

    .line 379
    const/16 v0, 0xf

    iput v0, v1, Landroid/net/wifi/p2p/WifiP2pConfig;->groupOwnerIntent:I

    .line 381
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$connectToDevice$1;

    invoke-direct {v3, p0, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$connectToDevice$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v3, Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;

    invoke-virtual {v0, v2, v1, v3}, Landroid/net/wifi/p2p/WifiP2pManager;->connect(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pConfig;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 398
    return-void
.end method

.method public final createGroup(Lkotlin/jvm/functions/Function1;)V
    .locals 9
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

    .line 71
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v1, " createGroup"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 72
    nop

    .line 73
    :try_start_0
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->check(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 74
    return-void

    .line 75
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/net/wifi/p2p/WifiP2pManager$Channel;->close()V

    .line 76
    :cond_1
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getMContex()Landroid/content/Context;

    move-result-object v1

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    move-object v3, p0

    check-cast v3, Landroid/net/wifi/p2p/WifiP2pManager$ChannelListener;

    invoke-virtual {v0, v1, v2, v3}, Landroid/net/wifi/p2p/WifiP2pManager;->initialize(Landroid/content/Context;Landroid/os/Looper;Landroid/net/wifi/p2p/WifiP2pManager$ChannelListener;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    .line 77
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 78
    return-void

    .line 80
    :cond_2
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$createGroup$1;

    invoke-direct {v0, p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$createGroup$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getGroupInfo(Lkotlin/jvm/functions/Function1;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 92
    :catch_0
    move-exception v0

    .line 93
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 94
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "createGroup: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 95
    nop

    .line 96
    nop

    .line 97
    new-instance v1, Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    const/4 v7, 0x4

    const/4 v8, 0x0

    const/4 v4, -0x1

    const/4 v6, 0x0

    move-object v3, v1

    invoke-direct/range {v3 .. v8}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 95
    const-string v2, "\u6267\u884ccreateGroup \u51fa\u73b0\u5f02\u5e38"

    invoke-direct {p0, v2, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getIFailResult-Guu2Vc4(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v1

    invoke-interface {p1, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 100
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public final getClientList(Lkotlin/jvm/functions/Function1;)V
    .locals 2
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

    .line 465
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-static {p0, v0, v1, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->checkChannel$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 466
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 467
    return-void

    .line 470
    :cond_0
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$getClientList$1;

    invoke-direct {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$getClientList$1;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getGroupInfo(Lkotlin/jvm/functions/Function1;)V

    .line 477
    return-void
.end method

.method public final getGroupInfo(Lkotlin/jvm/functions/Function1;)V
    .locals 3
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

    .line 402
    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-static {p0, v1, v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->checkChannel$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 403
    invoke-interface {p1, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 404
    return-void

    .line 407
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$$ExternalSyntheticLambda1;

    invoke-direct {v2, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$$ExternalSyntheticLambda1;-><init>(Lkotlin/jvm/functions/Function1;)V

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->requestGroupInfo(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$GroupInfoListener;)V

    .line 410
    return-void
.end method

.method public final init()V
    .locals 0

    .line 66
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->registerReceiver()V

    .line 67
    return-void
.end method

.method public final isConnect(Lkotlin/jvm/functions/Function1;)V
    .locals 2
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

    .line 429
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->isConnected()Z

    move-result v0

    if-nez v0, :cond_0

    .line 430
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v1, " isConnect --- Socket \u901a\u9053\u672a\u5efa\u7acb"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 431
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-interface {p1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 432
    return-void

    .line 435
    :cond_0
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1;

    invoke-direct {v0, p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V

    .line 457
    return-void
.end method

.method public final isWebsocketServerRunning()Z
    .locals 1

    .line 460
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->isServerRunning()Z

    move-result v0

    return v0
.end method

.method public onChannelDisconnected()V
    .locals 7

    .line 609
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v1, " onChannelDisconnected:"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 611
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 784
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/4 v5, 0x0

    .line 612
    .local v5, "$i$a$-forEach-P2PGOManager$onChannelDisconnected$1":I
    invoke-interface {v4}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onChannelDisconnected()V

    .line 613
    nop

    .line 784
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v5    # "$i$a$-forEach-P2PGOManager$onChannelDisconnected$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 785
    :cond_0
    nop

    .line 615
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnected:Z

    if-eqz v0, :cond_2

    .line 616
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 786
    .restart local v1    # "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    const/4 v4, 0x0

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .restart local v3    # "element$iv":Ljava/lang/Object;
    move-object v5, v3

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/4 v6, 0x0

    .line 617
    .local v6, "$i$a$-forEach-P2PGOManager$onChannelDisconnected$2":I
    invoke-interface {v5, v4}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onWifiP2pEnabled(Z)V

    .line 618
    nop

    .line 786
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v6    # "$i$a$-forEach-P2PGOManager$onChannelDisconnected$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 787
    :cond_1
    nop

    .line 619
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iput-boolean v4, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnected:Z

    .line 623
    :cond_2
    return-void
.end method

.method public final release()V
    .locals 2

    .line 594
    nop

    .line 595
    const/4 v0, 0x1

    const/4 v1, 0x0

    :try_start_0
    invoke-static {p0, v1, v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->removeGroup$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V

    .line 596
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->unregisterReceiver()V

    .line 597
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 598
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->close()V

    .line 599
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 600
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->release()V

    .line 601
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnected:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 602
    :catch_0
    move-exception v0

    .line 603
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 605
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public final releaseGroup()V
    .locals 1

    .line 588
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 589
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->close()V

    .line 590
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnected:Z

    .line 591
    return-void
.end method

.method public final removeGroup(Lkotlin/jvm/functions/Function1;)V
    .locals 2
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

    .line 287
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v1, " removeGroup"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 288
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 289
    return-void

    .line 290
    :cond_0
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$removeGroup$1;

    invoke-direct {v0, p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$removeGroup$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getGroupInfo(Lkotlin/jvm/functions/Function1;)V

    .line 315
    return-void
.end method

.method public final removeWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 584
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mWifiP2PListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 585
    return-void
.end method

.method public final requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V
    .locals 3
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

    .line 419
    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-static {p0, v1, v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->checkChannel$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 420
    invoke-interface {p1, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 421
    return-void

    .line 423
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$$ExternalSyntheticLambda0;

    invoke-direct {v2, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function1;)V

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->requestConnectionInfo(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ConnectionInfoListener;)V

    .line 426
    return-void
.end method

.method public final sendAudioStreamData([B)V
    .locals 3
    .param p1, "streamData"    # [B

    const-string v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 531
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnected:Z

    if-eqz v0, :cond_0

    .line 532
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    array-length v1, p1

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v0

    .line 533
    .local v0, "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->AUDIO_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 534
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 535
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 536
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->sendData(Ljava/nio/ByteBuffer;)V

    .line 537
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V

    .end local v0    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    goto :goto_0

    .line 539
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v1, "WiFi P2P not connected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 547
    :goto_0
    return-void
.end method

.method public final sendFile(Ljava/io/File;)V
    .locals 1
    .param p1, "file"    # Ljava/io/File;

    const-string v0, "file"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 502
    return-void
.end method

.method public final sendStreamData(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 5
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "bytes"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "bytes"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 553
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnected:Z

    if-eqz v0, :cond_0

    .line 554
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7c

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\\u2063\\u2064\\u2065"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    const-string v1, "this as java.lang.String).getBytes(charset)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 555
    .local v0, "metaData":[B
    array-length v1, v0

    array-length v2, p2

    add-int/2addr v1, v2

    add-int/lit8 v1, v1, 0x1

    .line 556
    .local v1, "size":I
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v2, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v2

    .line 557
    .local v2, "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    sget-object v4, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->STREAM_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v4}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 558
    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 559
    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 560
    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 561
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->sendData(Ljava/nio/ByteBuffer;)V

    .line 562
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v3, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V

    .end local v0    # "metaData":[B
    .end local v1    # "size":I
    .end local v2    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    goto :goto_0

    .line 564
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v1, "WiFi P2P not connected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 566
    :goto_0
    return-void
.end method

.method public final sendTextMessage(Ljava/lang/String;)V
    .locals 4
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 481
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnected:Z

    if-eqz v0, :cond_0

    .line 482
    sget-object v0, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    const-string v1, "this as java.lang.String).getBytes(charset)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 483
    .local v0, "textBytes":[B
    array-length v1, v0

    add-int/lit8 v1, v1, 0x1

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 484
    .local v1, "buffer":Ljava/nio/ByteBuffer;
    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->TEXT_MESSAGE:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 485
    invoke-virtual {v1, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 486
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 487
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    const-string v3, "buffer"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->sendData(Ljava/nio/ByteBuffer;)V

    .end local v0    # "textBytes":[B
    .end local v1    # "buffer":Ljava/nio/ByteBuffer;
    goto :goto_0

    .line 489
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v1, "WiFi P2P not connected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 491
    :goto_0
    return-void
.end method

.method public final sendVideoStreamData(Ljava/nio/ByteBuffer;)V
    .locals 3
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 518
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnected:Z

    if-nez v0, :cond_0

    return-void

    .line 520
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v0

    .line 521
    .local v0, "out":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->VIDEO_H264_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 522
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    .line 523
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 525
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->sendData(Ljava/nio/ByteBuffer;)V

    .line 526
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V

    .line 527
    return-void
.end method

.method public final sendVideoStreamData([B)V
    .locals 3
    .param p1, "streamData"    # [B

    const-string v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 505
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->isConnected:Z

    if-eqz v0, :cond_0

    .line 506
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    array-length v1, p1

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v0

    .line 507
    .local v0, "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->VIDEO_H264_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 508
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 509
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 510
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mSocketServerChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->sendData(Ljava/nio/ByteBuffer;)V

    .line 511
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V

    .end local v0    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    goto :goto_0

    .line 513
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->TAG:Ljava/lang/String;

    const-string v1, "WiFi P2P not connected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 515
    :goto_0
    return-void
.end method

.method public final startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V
    .locals 3
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

    .line 319
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " startDiscoverPeers"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 320
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 321
    return-void

    .line 323
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$startDiscoverPeers$1;

    invoke-direct {v2, p1, p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$startDiscoverPeers$1;-><init>(Lkotlin/jvm/functions/Function1;Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)V

    check-cast v2, Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->discoverPeers(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 341
    return-void
.end method

.method public final stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V
    .locals 3
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

    .line 344
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " stopPeerDiscovery"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 345
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 346
    return-void

    .line 348
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$stopPeerDiscovery$1;

    invoke-direct {v2, p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$stopPeerDiscovery$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v2, Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->stopPeerDiscovery(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 365
    return-void
.end method
