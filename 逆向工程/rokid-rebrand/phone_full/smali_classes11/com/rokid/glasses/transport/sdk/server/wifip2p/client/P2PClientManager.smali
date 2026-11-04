.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;
.super Ljava/lang/Object;
.source "P2PClientManager.kt"

# interfaces
.implements Landroid/net/wifi/p2p/WifiP2pManager$ChannelListener;


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nP2PClientManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PClientManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager\n+ 2 IResult.kt\ncom/rokid/glasses/transport/sdk/api/callback/IResult$Companion\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,683:1\n84#2:684\n93#2:685\n1855#3,2:686\n1855#3,2:688\n1855#3,2:690\n1855#3,2:692\n1855#3,2:694\n*S KotlinDebug\n*F\n+ 1 P2PClientManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager\n*L\n173#1:684\n485#1:685\n530#1:686,2\n627#1:688,2\n638#1:690,2\n648#1:692,2\n672#1:694,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u00b4\u0001\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010#\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\t\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0008\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u000b*\u0002\u0015\u001a\u0008\u0000\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010+\u001a\u00020,2\u0006\u0010-\u001a\u00020\u001eJ6\u0010.\u001a\u00020\u00082)\u0010/\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000801\u00a2\u0006\u000c\u00082\u0012\u0008\u00083\u0012\u0004\u0008\u0008(4\u0012\u0004\u0012\u00020,\u0018\u000100H\u0002\u00f8\u0001\u0000J8\u00105\u001a\u00020\u00082+\u0008\u0002\u0010/\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000801\u00a2\u0006\u000c\u00082\u0012\u0008\u00083\u0012\u0004\u0008\u0008(4\u0012\u0004\u0012\u00020,\u0018\u000100H\u0002\u00f8\u0001\u0000J@\u00106\u001a\u00020,2\u0006\u00107\u001a\u00020\u00132+\u0008\u0002\u0010/\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000801\u00a2\u0006\u000c\u00082\u0012\u0008\u00083\u0012\u0004\u0008\u0008(4\u0012\u0004\u0012\u00020,\u0018\u000100H\u0007\u00f8\u0001\u0000J8\u00108\u001a\u00020,2+\u0008\u0002\u0010/\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000801\u00a2\u0006\u000c\u00082\u0012\u0008\u00083\u0012\u0004\u0008\u0008(4\u0012\u0004\u0012\u00020,\u0018\u000100H\u0003\u00f8\u0001\u0000J\u0006\u00109\u001a\u00020,J-\u0010:\u001a\u00020,2#\u0010;\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010<\u00a2\u0006\u000c\u00082\u0012\u0008\u00083\u0012\u0004\u0008\u0008(=\u0012\u0004\u0012\u00020,00H\u0007J6\u0010>\u001a\u0008\u0012\u0004\u0012\u0002H?01\"\u0004\u0008\u0000\u0010?2\u0006\u0010@\u001a\u00020\u00042\u0008\u0010A\u001a\u0004\u0018\u00010BH\u0002\u00f8\u0001\u0001\u00f8\u0001\u0002\u00f8\u0001\u0000\u00a2\u0006\u0004\u0008C\u0010DJ\u0008\u0010E\u001a\u00020FH\u0002J\u0006\u0010G\u001a\u00020,J4\u0010H\u001a\u00020,2)\u0010/\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000801\u00a2\u0006\u000c\u00082\u0012\u0008\u00083\u0012\u0004\u0008\u0008(4\u0012\u0004\u0012\u00020,\u0018\u000100\u00f8\u0001\u0000J)\u0010I\u001a\u00020,2!\u0010;\u001a\u001d\u0012\u0013\u0012\u00110\u0008\u00a2\u0006\u000c\u00082\u0012\u0008\u00083\u0012\u0004\u0008\u0008(I\u0012\u0004\u0012\u00020,00J\u0008\u0010J\u001a\u00020,H\u0016J\u0010\u0010K\u001a\u00020,2\u0006\u0010L\u001a\u00020MH\u0002J\u0008\u0010!\u001a\u00020,H\u0002J\u0006\u0010N\u001a\u00020,J\u0008\u0010O\u001a\u00020,H\u0002J8\u0010P\u001a\u00020,2+\u0008\u0002\u0010/\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000801\u00a2\u0006\u000c\u00082\u0012\u0008\u00083\u0012\u0004\u0008\u0008(4\u0012\u0004\u0012\u00020,\u0018\u000100H\u0007\u00f8\u0001\u0000J\u000e\u0010Q\u001a\u00020,2\u0006\u0010-\u001a\u00020\u001eJ+\u0010R\u001a\u00020,2#\u0010;\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010 \u00a2\u0006\u000c\u00082\u0012\u0008\u00083\u0012\u0004\u0008\u0008(S\u0012\u0004\u0012\u00020,00J\u000e\u0010T\u001a\u00020,2\u0006\u0010U\u001a\u00020VJ\u000e\u0010W\u001a\u00020,2\u0006\u0010X\u001a\u00020YJ\u001e\u0010Z\u001a\u00020,2\u0006\u0010[\u001a\u00020\u00042\u0006\u0010\\\u001a\u00020V2\u0006\u0010]\u001a\u00020\u0004J\u000e\u0010^\u001a\u00020,2\u0006\u0010_\u001a\u00020\u0004J\u000e\u0010`\u001a\u00020,2\u0006\u0010U\u001a\u00020VJ8\u0010a\u001a\u00020,2+\u0008\u0002\u0010/\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000801\u00a2\u0006\u000c\u00082\u0012\u0008\u00083\u0012\u0004\u0008\u0008(4\u0012\u0004\u0012\u00020,\u0018\u000100H\u0007\u00f8\u0001\u0000J6\u0010b\u001a\u00020,2+\u0008\u0002\u0010/\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000801\u00a2\u0006\u000c\u00082\u0012\u0008\u00083\u0012\u0004\u0008\u0008(4\u0012\u0004\u0012\u00020,\u0018\u000100\u00f8\u0001\u0000J\u0008\u0010c\u001a\u00020,H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u000c\u001a\u00020\r8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0010\u0010\u0011\u001a\u0004\u0008\u000e\u0010\u000fR\u0010\u0010\u0012\u001a\u0004\u0018\u00010\u0013X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0014\u001a\u00020\u0015X\u0082\u000e\u00a2\u0006\u0004\n\u0002\u0010\u0016R\u000e\u0010\u0017\u001a\u00020\u0018X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0019\u001a\u00020\u001aX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u001bR\u0014\u0010\u001c\u001a\u0008\u0012\u0004\u0012\u00020\u001e0\u001dX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u001f\u001a\u0004\u0018\u00010 X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010!\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\"\u001a\u0004\u0018\u00010#X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010$\u001a\u0004\u0018\u00010%X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001b\u0010&\u001a\u00020\'8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008*\u0010\u0011\u001a\u0004\u0008(\u0010)\u0082\u0002\u000f\n\u0002\u0008\u0019\n\u0002\u0008!\n\u0005\u0008\u00a1\u001e0\u0001\u00a8\u0006d"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;",
        "Landroid/net/wifi/p2p/WifiP2pManager$ChannelListener;",
        "()V",
        "TAG",
        "",
        "WIFI_P2P_DELAY_MS",
        "",
        "isConnected",
        "",
        "lastTime",
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
        "com/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;",
        "mSocketChannel",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;",
        "mSocketServerListener",
        "com/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;",
        "mWifiP2PListeners",
        "",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;",
        "mWifiP2pInfo",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
        "registerReceiver",
        "stateCheckJob",
        "Lkotlinx/coroutines/Job;",
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
        "connectDevice",
        "device",
        "createGroup",
        "disconnect",
        "getGroupInfo",
        "action",
        "Landroid/net/wifi/p2p/WifiP2pGroup;",
        "group",
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
        "initialize",
        "isConnect",
        "onChannelDisconnected",
        "parseData",
        "buffer",
        "Ljava/nio/ByteBuffer;",
        "release",
        "releaseChannel",
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
        "unRegisterReceiver",
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

.field private final WIFI_P2P_DELAY_MS:J

.field private volatile isConnected:Z

.field private lastTime:J

.field private mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

.field private final mContex$delegate:Lkotlin/Lazy;

.field private mGroupOwner:Landroid/net/wifi/p2p/WifiP2pDevice;

.field private mP2PBroadcastReceiver:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;

.field private mSocketChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

.field private final mSocketServerListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;

.field private final mWifiP2PListeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;",
            ">;"
        }
    .end annotation
.end field

.field private mWifiP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;

.field private registerReceiver:Z

.field private stateCheckJob:Lkotlinx/coroutines/Job;

.field private wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

.field private final wifiP2pManager$delegate:Lkotlin/Lazy;


# direct methods
.method public static synthetic $r8$lambda$FCsLk7s-FDfWbI9S2YtMnc371bw(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->requestConnectionInfo$lambda$1(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pInfo;)V

    return-void
.end method

.method public static synthetic $r8$lambda$b-_64OXxJHAaHpOZX9LC8hbDE50(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pGroup;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getGroupInfo$lambda$0(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pGroup;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    const-string v0, "P2PClientManager "

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    .line 39
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2PListeners:Ljava/util/Set;

    .line 40
    const-wide/16 v0, 0x1388

    iput-wide v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->WIFI_P2P_DELAY_MS:J

    .line 43
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$wifiP2pManager$2;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$wifiP2pManager$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pManager$delegate:Lkotlin/Lazy;

    .line 47
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mContex$2;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mContex$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mContex$delegate:Lkotlin/Lazy;

    .line 52
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;-><init>()V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mSocketChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    .line 54
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;-><init>()V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    .line 59
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mP2PBroadcastReceiver:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;

    .line 581
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mSocketServerListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;

    .line 36
    return-void
.end method

.method public static final synthetic access$getIFailResult-Guu2Vc4(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "e"    # Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    .line 36
    invoke-direct {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getIFailResult-Guu2Vc4(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getMGroupOwner$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pDevice;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 36
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mGroupOwner:Landroid/net/wifi/p2p/WifiP2pDevice;

    return-object v0
.end method

.method public static final synthetic access$getMSocketChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 36
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mSocketChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    return-object v0
.end method

.method public static final synthetic access$getMSocketServerListener$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 36
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mSocketServerListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;

    return-object v0
.end method

.method public static final synthetic access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/util/Set;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 36
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2PListeners:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getStateCheckJob$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lkotlinx/coroutines/Job;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 36
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->stateCheckJob:Lkotlinx/coroutines/Job;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 36
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getWIFI_P2P_DELAY_MS$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)J
    .locals 2
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 36
    iget-wide v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->WIFI_P2P_DELAY_MS:J

    return-wide v0
.end method

.method public static final synthetic access$getWifiP2pChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 36
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    return-object v0
.end method

.method public static final synthetic access$getWifiP2pManager(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pManager;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 36
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$isConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 36
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->isConnected:Z

    return v0
.end method

.method public static final synthetic access$parseData(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 36
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->parseData(Ljava/nio/ByteBuffer;)V

    return-void
.end method

.method public static final synthetic access$releaseChannel(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 36
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->releaseChannel()V

    return-void
.end method

.method public static final synthetic access$setConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;
    .param p1, "<set-?>"    # Z

    .line 36
    iput-boolean p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->isConnected:Z

    return-void
.end method

.method public static final synthetic access$setMGroupOwner$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pDevice;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;
    .param p1, "<set-?>"    # Landroid/net/wifi/p2p/WifiP2pDevice;

    .line 36
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mGroupOwner:Landroid/net/wifi/p2p/WifiP2pDevice;

    return-void
.end method

.method public static final synthetic access$setMWifiP2pInfo$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;
    .param p1, "<set-?>"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 36
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;

    return-void
.end method

.method public static final synthetic access$setStateCheckJob$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlinx/coroutines/Job;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;
    .param p1, "<set-?>"    # Lkotlinx/coroutines/Job;

    .line 36
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->stateCheckJob:Lkotlinx/coroutines/Job;

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

    .line 540
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;->isWifiSupported()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_1

    .line 541
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v2, " Not Supported Wifi"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 542
    if-eqz p1, :cond_0

    .line 543
    nop

    .line 544
    nop

    .line 545
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    const/4 v7, 0x4

    const/4 v8, 0x0

    const/4 v4, -0x1

    const-string v5, "Not Supported Wifi"

    const/4 v6, 0x0

    move-object v3, v0

    invoke-direct/range {v3 .. v8}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 543
    const-string v2, "Not Supported Wifi"

    invoke-direct {p0, v2, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getIFailResult-Guu2Vc4(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v0

    .line 542
    invoke-interface {p1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 548
    :cond_0
    return v1

    .line 551
    :cond_1
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/utils/AppUtils;->isWifiEnabled()Z

    move-result v0

    if-nez v0, :cond_3

    .line 552
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v2, "Wifi \u672a\u5f00\u542f"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 553
    if-eqz p1, :cond_2

    .line 554
    nop

    .line 555
    nop

    .line 556
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    const/4 v8, 0x4

    const/4 v9, 0x0

    const/4 v5, -0x1

    const-string v6, "Wifi \u672a\u5f00\u542f"

    const/4 v7, 0x0

    move-object v4, v0

    invoke-direct/range {v4 .. v9}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 554
    invoke-direct {p0, v2, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getIFailResult-Guu2Vc4(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v0

    .line 553
    invoke-interface {p1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 559
    :cond_2
    return v1

    .line 562
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

    .line 566
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->check(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 567
    return v1

    .line 568
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    if-nez v0, :cond_2

    .line 569
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v2, " wifiP2pChannel == null"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 570
    if-eqz p1, :cond_1

    .line 571
    nop

    .line 572
    nop

    .line 573
    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    const/4 v7, 0x4

    const/4 v8, 0x0

    const/4 v4, -0x1

    const-string v5, "wifiP2pChannel \u672a\u521d\u59cb\u5316"

    const/4 v6, 0x0

    move-object v3, v0

    invoke-direct/range {v3 .. v8}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 571
    const-string v2, "wifiP2pChannel \u672a\u521d\u59cb\u5316"

    invoke-direct {p0, v2, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getIFailResult-Guu2Vc4(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v0

    .line 570
    invoke-interface {p1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 576
    :cond_1
    return v1

    .line 578
    :cond_2
    const/4 v0, 0x1

    return v0
.end method

.method static synthetic checkChannel$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Z
    .locals 0

    .line 565
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result p0

    return p0
.end method

.method public static synthetic connectDevice$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 302
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    .line 304
    const/4 p2, 0x0

    .line 302
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->connectDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method private final createGroup(Lkotlin/jvm/functions/Function1;)V
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

    .line 200
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 201
    return-void

    .line 203
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1;

    invoke-direct {v2, p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v2, Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->createGroup(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 221
    return-void
.end method

.method static synthetic createGroup$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 199
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->createGroup(Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method private static final getGroupInfo$lambda$0(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pGroup;)V
    .locals 1
    .param p0, "$action"    # Lkotlin/jvm/functions/Function1;
    .param p1, "group"    # Landroid/net/wifi/p2p/WifiP2pGroup;

    const-string v0, "$action"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 342
    invoke-interface {p0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 343
    return-void
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

    .line 483
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

    .line 482
    nop

    .line 484
    .local v0, "erroeMsg":Ljava/lang/String;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 485
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

    .line 685
    .local v3, "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResultKt;->createFailure(Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 485
    .end local v1    # "exception$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IException;
    .end local v2    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v3    # "$i$f$failure":I
    return-object v1
.end method

.method private final getIntentFilter()Landroid/content/IntentFilter;
    .locals 2

    .line 190
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 191
    .local v0, "intentFilter":Landroid/content/IntentFilter;
    const-string v1, "android.net.wifi.p2p.STATE_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 192
    const-string v1, "android.net.wifi.p2p.PEERS_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 193
    const-string v1, "android.net.wifi.p2p.CONNECTION_STATE_CHANGE"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 194
    const-string v1, "android.net.wifi.p2p.THIS_DEVICE_CHANGED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 195
    return-object v0
.end method

.method private final getMContex()Landroid/content/Context;
    .locals 2

    .line 47
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mContex$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    const-string v1, "<get-mContex>(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/content/Context;

    return-object v0
.end method

.method private final getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;
    .locals 1

    .line 43
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pManager$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pManager;

    return-object v0
.end method

.method private final parseData(Ljava/nio/ByteBuffer;)V
    .locals 21
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    .line 620
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->get()B

    move-result v2

    .line 621
    .local v2, "dataType":B
    nop

    .line 622
    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->TEXT_MESSAGE:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v3

    if-ne v2, v3, :cond_1

    .line 623
    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v3

    new-array v3, v3, [B

    .line 624
    .local v3, "data":[B
    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 625
    new-instance v4, Ljava/lang/String;

    sget-object v5, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v4, v3, v5}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 626
    .local v4, "text":Ljava/lang/String;
    iget-object v5, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

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

    .line 627
    iget-object v5, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2PListeners:Ljava/util/Set;

    check-cast v5, Ljava/lang/Iterable;

    .local v5, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v6, 0x0

    .line 688
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

    check-cast v9, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    .local v9, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    const/4 v10, 0x0

    .line 628
    .local v10, "$i$a$-forEach-P2PClientManager$parseData$1":I
    invoke-interface {v9, v4}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;->onTextMessage(Ljava/lang/String;)V

    .line 629
    nop

    .line 688
    .end local v9    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    .end local v10    # "$i$a$-forEach-P2PClientManager$parseData$1":I
    nop

    .end local v8    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 689
    :cond_0
    move/from16 v19, v2

    .end local v3    # "data":[B
    .end local v4    # "text":Ljava/lang/String;
    .end local v5    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v6    # "$i$f$forEach":I
    goto/16 :goto_4

    .line 632
    :cond_1
    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->FILE_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v3

    const-string v4, " bytes"

    if-ne v2, v3, :cond_2

    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

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

    .line 633
    :cond_2
    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->AUDIO_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v3

    if-ne v2, v3, :cond_4

    .line 634
    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

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

    .line 635
    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v4

    invoke-virtual {v3, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v3

    .line 636
    .local v3, "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    .line 637
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 638
    iget-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2PListeners:Ljava/util/Set;

    check-cast v4, Ljava/lang/Iterable;

    .local v4, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 690
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

    check-cast v8, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    .local v8, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    const/4 v9, 0x0

    .line 639
    .local v9, "$i$a$-forEach-P2PClientManager$parseData$2":I
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v10

    invoke-interface {v8, v10}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;->onAudioStream(Ljava/nio/ByteBuffer;)V

    .line 640
    nop

    .line 690
    .end local v8    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    .end local v9    # "$i$a$-forEach-P2PClientManager$parseData$2":I
    nop

    .end local v7    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 691
    :cond_3
    nop

    .line 641
    .end local v4    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v5    # "$i$f$forEach":I
    iget-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v4, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V

    move/from16 v19, v2

    .end local v3    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    goto/16 :goto_4

    .line 643
    :cond_4
    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->VIDEO_H264_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v3

    if-ne v2, v3, :cond_6

    .line 644
    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

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

    .line 645
    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v4

    invoke-virtual {v3, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v3

    .line 646
    .restart local v3    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->put(Ljava/nio/ByteBuffer;)Ljava/nio/ByteBuffer;

    .line 647
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 648
    iget-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2PListeners:Ljava/util/Set;

    check-cast v4, Ljava/lang/Iterable;

    .restart local v4    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 692
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

    check-cast v8, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    .restart local v8    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    const/4 v9, 0x0

    .line 649
    .local v9, "$i$a$-forEach-P2PClientManager$parseData$3":I
    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v10

    invoke-interface {v8, v10}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;->onVideoH264Stream(Ljava/nio/ByteBuffer;)V

    .line 650
    nop

    .line 692
    .end local v8    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    .end local v9    # "$i$a$-forEach-P2PClientManager$parseData$3":I
    nop

    .end local v7    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 693
    :cond_5
    nop

    .line 651
    .end local v4    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v5    # "$i$f$forEach":I
    iget-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v4, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V

    move/from16 v19, v2

    .end local v3    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    goto/16 :goto_4

    .line 654
    :cond_6
    sget-object v3, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->STREAM_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v3

    if-ne v2, v3, :cond_9

    .line 655
    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v3

    new-array v3, v3, [B

    .line 656
    .local v3, "data":[B
    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 657
    const/4 v4, 0x0

    .line 658
    .local v4, "offset":I
    sget-object v5, Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;

    invoke-virtual {v5, v3, v4}, Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;->findEndMarkerIndex([BI)I

    move-result v5

    .line 659
    .local v5, "endMarkerIndex":I
    sub-int v6, v5, v4

    .local v6, "metadataLength":I
    new-instance v7, Ljava/lang/String;

    .line 660
    sget-object v8, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v7, v3, v4, v6, v8}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    .line 661
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

    .line 663
    .local v8, "parts":Ljava/util/List;
    const-string v9, "\\u2063\\u2064\\u2065"

    sget-object v10, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v9, v10}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v9

    const-string v10, "this as java.lang.String).getBytes(charset)"

    invoke-static {v9, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    array-length v9, v9

    add-int/2addr v9, v5

    .line 664
    .local v9, "streamDataOffset":I
    array-length v10, v3

    sub-int/2addr v10, v9

    .line 665
    .local v10, "streamDataLength":I
    new-array v11, v10, [B

    .line 666
    .local v11, "streamData":[B
    invoke-static {v3, v9, v11, v15, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 668
    invoke-interface {v8}, Ljava/util/List;->size()I

    move-result v12

    const/4 v13, 0x2

    if-ne v12, v13, :cond_8

    .line 669
    const/4 v12, 0x0

    .local v12, "tag":Ljava/lang/Object;
    invoke-interface {v8, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    .line 670
    const/4 v13, 0x0

    .local v13, "clientId":Ljava/lang/Object;
    invoke-interface {v8, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    .line 671
    iget-object v14, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

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

    .line 672
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2PListeners:Ljava/util/Set;

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v14, 0x0

    .line 694
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

    check-cast v1, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    .local v1, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    const/16 v18, 0x0

    .line 673
    .local v18, "$i$a$-forEach-P2PClientManager$parseData$4":I
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

    invoke-interface {v1, v2, v11, v3}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;->onStreamReceived(Ljava/lang/String;[BLjava/lang/String;)V

    .line 674
    nop

    .line 694
    .end local v1    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    .end local v18    # "$i$a$-forEach-P2PClientManager$parseData$4":I
    move-object/from16 v1, v17

    move/from16 v2, v19

    move-object/from16 v3, v20

    .end local v16    # "element$iv":Ljava/lang/Object;
    goto :goto_3

    .line 695
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

    .line 676
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
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

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

    .line 680
    .end local v19    # "dataType":B
    .restart local v2    # "dataType":B
    :cond_9
    move/from16 v19, v2

    .end local v2    # "dataType":B
    .restart local v19    # "dataType":B
    iget-object v1, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v2, " Unknown data"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 682
    :goto_4
    return-void
.end method

.method private final registerReceiver()V
    .locals 3

    .line 178
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getMContex()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mP2PBroadcastReceiver:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;

    check-cast v1, Landroid/content/BroadcastReceiver;

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getIntentFilter()Landroid/content/IntentFilter;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 179
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->registerReceiver:Z

    .line 180
    return-void
.end method

.method private final releaseChannel()V
    .locals 2

    .line 499
    nop

    .line 500
    const/4 v0, 0x0

    :try_start_0
    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 501
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mSocketChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->release()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 502
    :catch_0
    move-exception v0

    .line 503
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 505
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, "releaseChannel: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 506
    return-void
.end method

.method public static synthetic removeGroup$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 224
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->removeGroup(Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method private static final requestConnectionInfo$lambda$1(Lkotlin/jvm/functions/Function1;Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 1
    .param p0, "$action"    # Lkotlin/jvm/functions/Function1;
    .param p1, "it"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    const-string v0, "$action"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 354
    invoke-interface {p0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 355
    return-void
.end method

.method public static synthetic startDiscoverPeers$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 252
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method public static synthetic stopPeerDiscovery$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 277
    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method private final unRegisterReceiver()V
    .locals 2

    .line 183
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->registerReceiver:Z

    if-eqz v0, :cond_0

    .line 184
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getMContex()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mP2PBroadcastReceiver:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;

    check-cast v1, Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 185
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->registerReceiver:Z

    .line 187
    :cond_0
    return-void
.end method


# virtual methods
.method public final addWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 489
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2PListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 490
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2PListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 492
    :cond_0
    return-void
.end method

.method public final connectDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V
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

    .line 306
    const/4 v0, 0x0

    new-array v1, v0, [Ljava/lang/Object;

    const-string v2, " connectToDevice"

    invoke-static {v2, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 307
    invoke-direct {p0, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 308
    return-void

    .line 310
    :cond_0
    new-instance v1, Landroid/net/wifi/p2p/WifiP2pConfig;

    invoke-direct {v1}, Landroid/net/wifi/p2p/WifiP2pConfig;-><init>()V

    .line 311
    .local v1, "config":Landroid/net/wifi/p2p/WifiP2pConfig;
    iget-object v2, p1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    iput-object v2, v1, Landroid/net/wifi/p2p/WifiP2pConfig;->deviceAddress:Ljava/lang/String;

    .line 312
    iget-object v2, v1, Landroid/net/wifi/p2p/WifiP2pConfig;->wps:Landroid/net/wifi/WpsInfo;

    iput v0, v2, Landroid/net/wifi/WpsInfo;->setup:I

    .line 314
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$connectDevice$1;

    invoke-direct {v3, p0, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$connectDevice$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v3, Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;

    invoke-virtual {v0, v2, v1, v3}, Landroid/net/wifi/p2p/WifiP2pManager;->connect(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pConfig;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 331
    return-void
.end method

.method public final disconnect()V
    .locals 3

    .line 359
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-static {p0, v0, v1, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->checkChannel$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 360
    return-void

    .line 362
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$disconnect$1;

    invoke-direct {v2, p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$disconnect$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V

    check-cast v2, Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->cancelConnect(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 373
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$disconnect$2;

    invoke-direct {v2, p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$disconnect$2;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V

    check-cast v2, Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->removeGroup(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 383
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

    .line 335
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, " getGroupInfo: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 336
    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-static {p0, v1, v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->checkChannel$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 337
    invoke-interface {p1, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 338
    return-void

    .line 341
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$$ExternalSyntheticLambda0;

    invoke-direct {v2, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function1;)V

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->requestGroupInfo(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$GroupInfoListener;)V

    .line 344
    return-void
.end method

.method public final init()V
    .locals 0

    .line 162
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->registerReceiver()V

    .line 163
    return-void
.end method

.method public final initialize(Lkotlin/jvm/functions/Function1;)V
    .locals 4
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

    .line 166
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->check(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 167
    return-void

    .line 169
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getMContex()Landroid/content/Context;

    move-result-object v1

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    move-object v3, p0

    check-cast v3, Landroid/net/wifi/p2p/WifiP2pManager$ChannelListener;

    invoke-virtual {v0, v1, v2, v3}, Landroid/net/wifi/p2p/WifiP2pManager;->initialize(Landroid/content/Context;Landroid/os/Looper;Landroid/net/wifi/p2p/WifiP2pManager$ChannelListener;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    .line 170
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 171
    return-void

    .line 173
    :cond_1
    if-eqz p1, :cond_2

    sget-object v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    .local v0, "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    .local v1, "value$iv":Ljava/lang/Object;
    const/4 v2, 0x0

    .line 684
    .local v2, "$i$f$success":I
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v1    # "value$iv":Ljava/lang/Object;
    .end local v2    # "$i$f$success":I
    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v0

    .line 173
    invoke-interface {p1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 174
    :cond_2
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

    .line 387
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mSocketChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->isConnected()Z

    move-result v0

    if-nez v0, :cond_0

    .line 388
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, "isConnect --- Socket \u901a\u9053\u672a\u5efa\u7acb"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 389
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-interface {p1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 390
    return-void

    .line 393
    :cond_0
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$isConnect$1;

    invoke-direct {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$isConnect$1;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V

    .line 400
    return-void
.end method

.method public onChannelDisconnected()V
    .locals 7

    .line 526
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, " onChannelDisconnected:"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 528
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    .line 529
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->isConnected:Z

    if-eqz v0, :cond_1

    .line 530
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2PListeners:Ljava/util/Set;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 686
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    const/4 v4, 0x0

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v5, v3

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    const/4 v6, 0x0

    .line 531
    .local v6, "$i$a$-forEach-P2PClientManager$onChannelDisconnected$1":I
    invoke-interface {v5, v4}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;->onWifiP2pEnabled(Z)V

    .line 532
    nop

    .line 686
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    .end local v6    # "$i$a$-forEach-P2PClientManager$onChannelDisconnected$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 687
    :cond_0
    nop

    .line 533
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iput-boolean v4, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->isConnected:Z

    .line 535
    :cond_1
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->releaseChannel()V

    .line 537
    return-void
.end method

.method public final release()V
    .locals 3

    .line 509
    nop

    .line 510
    :try_start_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->stateCheckJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 511
    :cond_0
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->stateCheckJob:Lkotlinx/coroutines/Job;

    .line 512
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->unRegisterReceiver()V

    .line 513
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 514
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mSocketChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->release()V

    .line 515
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2PListeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 516
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->release()V

    .line 517
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->isConnected:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 518
    :catch_0
    move-exception v0

    .line 519
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 521
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, " release"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 522
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

    .line 225
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, " removeGroup"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 226
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 227
    return-void

    .line 228
    :cond_0
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1;

    invoke-direct {v0, p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getGroupInfo(Lkotlin/jvm/functions/Function1;)V

    .line 249
    return-void
.end method

.method public final removeWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 495
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mWifiP2PListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 496
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

    .line 347
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, " requestConnectionInfo: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 348
    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-static {p0, v1, v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->checkChannel$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 349
    invoke-interface {p1, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 350
    return-void

    .line 353
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$$ExternalSyntheticLambda1;

    invoke-direct {v2, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$$ExternalSyntheticLambda1;-><init>(Lkotlin/jvm/functions/Function1;)V

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->requestConnectionInfo(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ConnectionInfoListener;)V

    .line 356
    return-void
.end method

.method public final sendAudioStreamData([B)V
    .locals 3
    .param p1, "streamData"    # [B

    const-string v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 443
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->isConnected:Z

    if-eqz v0, :cond_0

    .line 444
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    array-length v1, p1

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v0

    .line 445
    .local v0, "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->AUDIO_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 446
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 447
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 448
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mSocketChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->sendData(Ljava/nio/ByteBuffer;)V

    .line 449
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V

    .end local v0    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    goto :goto_0

    .line 451
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, "WiFi P2P not connected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 459
    :goto_0
    return-void
.end method

.method public final sendFile(Ljava/io/File;)V
    .locals 1
    .param p1, "file"    # Ljava/io/File;

    const-string v0, "file"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 427
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

    .line 465
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->isConnected:Z

    if-eqz v0, :cond_0

    .line 466
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

    .line 467
    .local v0, "metaData":[B
    array-length v1, v0

    array-length v2, p2

    add-int/2addr v1, v2

    add-int/lit8 v1, v1, 0x1

    .line 468
    .local v1, "size":I
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v2, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v2

    .line 469
    .local v2, "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    sget-object v4, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->STREAM_DATA:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v4}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 470
    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 471
    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 472
    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 473
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mSocketChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->sendData(Ljava/nio/ByteBuffer;)V

    .line 474
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v3, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V

    .end local v0    # "metaData":[B
    .end local v1    # "size":I
    .end local v2    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    goto :goto_0

    .line 476
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, "WiFi P2P not connected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 478
    :goto_0
    return-void
.end method

.method public final sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 403
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$sendTextMessage$1;

    invoke-direct {v0, p1, p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$sendTextMessage$1;-><init>(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V

    .line 416
    return-void
.end method

.method public final sendVideoStreamData([B)V
    .locals 3
    .param p1, "streamData"    # [B

    const-string v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 430
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->isConnected:Z

    if-eqz v0, :cond_0

    .line 431
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    array-length v1, p1

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v0

    .line 432
    .local v0, "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->VIDEO_H264_STREAM:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 433
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 434
    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 435
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mSocketChannel:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->sendData(Ljava/nio/ByteBuffer;)V

    .line 436
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->mBufferHelper:Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;

    invoke-virtual {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V

    .end local v0    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    goto :goto_0

    .line 438
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, "WiFi P2P not connected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 440
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

    .line 253
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, " startDiscoverPeers"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 254
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 255
    return-void

    .line 257
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$startDiscoverPeers$1;

    invoke-direct {v2, p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$startDiscoverPeers$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v2, Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->discoverPeers(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 275
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

    .line 278
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->TAG:Ljava/lang/String;

    const-string v1, " stopPeerDiscovery"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 279
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->checkChannel(Lkotlin/jvm/functions/Function1;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 280
    return-void

    .line 282
    :cond_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->getWifiP2pManager()Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->wifiP2pChannel:Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$stopPeerDiscovery$1;

    invoke-direct {v2, p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$stopPeerDiscovery$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v2, Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->stopPeerDiscovery(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 299
    return-void
.end method
