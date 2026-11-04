.class public final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/wifip2p/api/AbsP2PClientService;
.source "P2PClientServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0093\u0001\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0000\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010#\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0014*\u0001\u0012\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u001b\u001a\u00020\u001c2\u0006\u0010\u001d\u001a\u00020\u0018H\u0016J<\u0010\u001e\u001a\u00020\u001c2\u0006\u0010\u001f\u001a\u00020 2\'\u0010!\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060#\u00a2\u0006\u000c\u0008$\u0012\u0008\u0008%\u0012\u0004\u0008\u0008(&\u0012\u0004\u0012\u00020\u001c0\"H\u0016\u00f8\u0001\u0000J\u0008\u0010\'\u001a\u00020\u001cH\u0016J\u0008\u0010(\u001a\u00020\u001cH\u0002J-\u0010)\u001a\u00020\u001c2#\u0010*\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010+\u00a2\u0006\u000c\u0008$\u0012\u0008\u0008%\u0012\u0004\u0008\u0008(,\u0012\u0004\u0012\u00020\u001c0\"H\u0016J\u0008\u0010-\u001a\u00020.H\u0016J\u0008\u0010/\u001a\u000200H\u0016J\u0006\u00101\u001a\u00020\u0015J2\u00102\u001a\u00020\u001c2\'\u0010!\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060#\u00a2\u0006\u000c\u0008$\u0012\u0008\u0008%\u0012\u0004\u0008\u0008(&\u0012\u0004\u0012\u00020\u001c0\"\u00f8\u0001\u0000J6\u00103\u001a\u00020\u001c2)\u0010!\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060#\u00a2\u0006\u000c\u0008$\u0012\u0008\u0008%\u0012\u0004\u0008\u0008(&\u0012\u0004\u0012\u00020\u001c\u0018\u00010\"H\u0016\u00f8\u0001\u0000J\u0008\u00104\u001a\u00020\u0006H\u0016J+\u0010\t\u001a\u00020\u001c2!\u0010*\u001a\u001d\u0012\u0013\u0012\u00110\u0006\u00a2\u0006\u000c\u0008$\u0012\u0008\u0008%\u0012\u0004\u0008\u0008(\t\u0012\u0004\u0012\u00020\u001c0\"H\u0016J\u0018\u00105\u001a\u00020\u001c2\u0006\u00106\u001a\u00020\u00042\u0006\u00107\u001a\u000208H\u0002J \u00109\u001a\u00020\u001c2\u0006\u0010:\u001a\u00020;2\u0006\u0010<\u001a\u00020=2\u0006\u0010>\u001a\u00020=H\u0002J\u0006\u0010?\u001a\u00020\u001cJ\u0010\u0010@\u001a\u00020\u001c2\u0006\u0010\u001d\u001a\u00020\u0018H\u0016J-\u0010A\u001a\u00020\u001c2#\u0010*\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u000108\u00a2\u0006\u000c\u0008$\u0012\u0008\u0008%\u0012\u0004\u0008\u0008(B\u0012\u0004\u0012\u00020\u001c0\"H\u0016J\u0010\u0010C\u001a\u00020\u00042\u0006\u0010D\u001a\u00020=H\u0002J\u000e\u0010E\u001a\u00020\u001c2\u0006\u0010F\u001a\u00020;J+\u0010G\u001a\u00020\u001c2!\u0010*\u001a\u001d\u0012\u0013\u0012\u00110\u0006\u00a2\u0006\u000c\u0008$\u0012\u0008\u0008%\u0012\u0004\u0008\u0008(H\u0012\u0004\u0012\u00020\u001c0\"H\u0016J\u000e\u0010I\u001a\u00020\u001c2\u0006\u0010J\u001a\u00020\u0004J\u000e\u0010K\u001a\u00020\u001c2\u0006\u0010F\u001a\u00020;J\u0010\u0010L\u001a\u00020\u001c2\u0006\u0010M\u001a\u00020\u0006H\u0016J\u0010\u0010N\u001a\u00020\u001c2\u0008\u0010\u001d\u001a\u0004\u0018\u00010\u001aJ6\u0010O\u001a\u00020\u001c2)\u0010!\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060#\u00a2\u0006\u000c\u0008$\u0012\u0008\u0008%\u0012\u0004\u0008\u0008(&\u0012\u0004\u0012\u00020\u001c\u0018\u00010\"H\u0016\u00f8\u0001\u0000J6\u0010P\u001a\u00020\u001c2)\u0010!\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00060#\u00a2\u0006\u000c\u0008$\u0012\u0008\u0008%\u0012\u0004\u0008\u0008(&\u0012\u0004\u0012\u00020\u001c\u0018\u00010\"H\u0016\u00f8\u0001\u0000R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\t\u001a\u00020\u0006X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\t\u0010\n\"\u0004\u0008\u000b\u0010\u000cR\u000e\u0010\r\u001a\u00020\u000eX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000f\u001a\u00020\u0010X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0011\u001a\u00020\u0012X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0013R\u000e\u0010\u0014\u001a\u00020\u0015X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0016\u001a\u0008\u0012\u0004\u0012\u00020\u00180\u0017X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0019\u001a\u0004\u0018\u00010\u001aX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006Q"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/wifip2p/api/AbsP2PClientService;",
        "()V",
        "TAG",
        "",
        "autoDecodeH264ToNv21",
        "",
        "h264DecoderLock",
        "",
        "isConnect",
        "()Z",
        "setConnect",
        "(Z)V",
        "mARMixControl",
        "Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;",
        "mH264StreamDecoder",
        "Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;",
        "mIWifiP2PListener",
        "com/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1",
        "Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;",
        "mP2PConnectControl",
        "Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;",
        "mWifiP2PClientListeners",
        "",
        "Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;",
        "mWifiP2PMessageListener",
        "Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;",
        "addWifiP2PClientListener",
        "",
        "listener",
        "connectDevice",
        "device",
        "Landroid/net/wifi/p2p/WifiP2pDevice;",
        "onResult",
        "Lkotlin/Function1;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "Lkotlin/ParameterName;",
        "name",
        "result",
        "disconnect",
        "ensureH264DecoderLocked",
        "getGroupInfo",
        "action",
        "Landroid/net/wifi/p2p/WifiP2pGroup;",
        "group",
        "getIARMixControl",
        "Lcom/rokid/security/phone/sdk/api/wifip2p/api/IARMixControl;",
        "getIP2PConnectControl",
        "Lcom/rokid/security/phone/sdk/api/wifip2p/api/IP2PConnectControl;",
        "getP2PConnectControl",
        "init",
        "initialize",
        "isAutoDecodeH264ToNv21Enabled",
        "logConnectedP2pFrequency",
        "source",
        "wifiP2pInfo",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
        "onNv21Data",
        "data",
        "",
        "width",
        "",
        "height",
        "release",
        "removeWifiP2PClientListener",
        "requestConnectionInfo",
        "info",
        "resolveWifiBandLabel",
        "frequency",
        "sendAudioStreamData",
        "streamData",
        "sendConnectP2pRequest",
        "isSuccess",
        "sendTextMessage",
        "message",
        "sendVideoStreamData",
        "setAutoDecodeH264ToNv21",
        "enable",
        "setWifiP2PMessageListener",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

.field private static final TAG:Ljava/lang/String; = "WifiP2PClientService"

.field private static volatile autoDecodeH264ToNv21:Z

.field private static final h264DecoderLock:Ljava/lang/Object;

.field private static volatile isConnect:Z

.field private static mARMixControl:Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;

.field private static mH264StreamDecoder:Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

.field private static final mIWifiP2PListener:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;

.field private static mP2PConnectControl:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

.field private static final mWifiP2PClientListeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;",
            ">;"
        }
    .end annotation
.end field

.field private static mWifiP2PMessageListener:Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    .line 27
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mWifiP2PClientListeners:Ljava/util/Set;

    .line 29
    new-instance v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mH264StreamDecoder:Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    .line 30
    new-instance v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mP2PConnectControl:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 31
    new-instance v0, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mARMixControl:Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;

    .line 32
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->h264DecoderLock:Ljava/lang/Object;

    .line 35
    const/4 v0, 0x1

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->autoDecodeH264ToNv21:Z

    .line 40
    new-instance v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mIWifiP2PListener:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/wifip2p/api/AbsP2PClientService;-><init>()V

    return-void
.end method

.method public static final synthetic access$ensureH264DecoderLocked(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    .line 25
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->ensureH264DecoderLocked()V

    return-void
.end method

.method public static final synthetic access$getAutoDecodeH264ToNv21$p()Z
    .locals 1

    .line 25
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->autoDecodeH264ToNv21:Z

    return v0
.end method

.method public static final synthetic access$getH264DecoderLock$p()Ljava/lang/Object;
    .locals 1

    .line 25
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->h264DecoderLock:Ljava/lang/Object;

    return-object v0
.end method

.method public static final synthetic access$getMH264StreamDecoder$p()Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;
    .locals 1

    .line 25
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mH264StreamDecoder:Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    return-object v0
.end method

.method public static final synthetic access$getMIWifiP2PListener$p()Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;
    .locals 1

    .line 25
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mIWifiP2PListener:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;

    return-object v0
.end method

.method public static final synthetic access$getMWifiP2PClientListeners$p()Ljava/util/Set;
    .locals 1

    .line 25
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mWifiP2PClientListeners:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getMWifiP2PMessageListener$p()Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;
    .locals 1

    .line 25
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mWifiP2PMessageListener:Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    return-object v0
.end method

.method public static final synthetic access$logConnectedP2pFrequency(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;Ljava/lang/String;Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;
    .param p1, "source"    # Ljava/lang/String;
    .param p2, "wifiP2pInfo"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 25
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->logConnectedP2pFrequency(Ljava/lang/String;Landroid/net/wifi/p2p/WifiP2pInfo;)V

    return-void
.end method

.method public static final synthetic access$onNv21Data(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;[BII)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    .line 25
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->onNv21Data([BII)V

    return-void
.end method

.method public static final synthetic access$resolveWifiBandLabel(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;I)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;
    .param p1, "frequency"    # I

    .line 25
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->resolveWifiBandLabel(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private final ensureH264DecoderLocked()V
    .locals 2

    .line 286
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mH264StreamDecoder:Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->initDecoder()V

    .line 287
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mH264StreamDecoder:Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$ensureH264DecoderLocked$1;

    invoke-direct {v1, p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$ensureH264DecoderLocked$1;-><init>(Ljava/lang/Object;)V

    check-cast v1, Lkotlin/jvm/functions/Function3;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->setNv21DataCallback(Lkotlin/jvm/functions/Function3;)V

    .line 288
    return-void
.end method

.method private final logConnectedP2pFrequency(Ljava/lang/String;Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 2
    .param p1, "source"    # Ljava/lang/String;
    .param p2, "wifiP2pInfo"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 220
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$logConnectedP2pFrequency$1;

    invoke-direct {v1, p2, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$logConnectedP2pFrequency$1;-><init>(Landroid/net/wifi/p2p/WifiP2pInfo;Ljava/lang/String;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getGroupInfo(Lkotlin/jvm/functions/Function1;)V

    .line 238
    return-void
.end method

.method private final onNv21Data([BII)V
    .locals 1
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    .line 282
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mIWifiP2PListener:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;->onNv21Data([BII)V

    .line 283
    return-void
.end method

.method private final resolveWifiBandLabel(I)Ljava/lang/String;
    .locals 3
    .param p1, "frequency"    # I

    .line 241
    nop

    .line 242
    const/16 v0, 0x960

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-gt v0, p1, :cond_0

    const/16 v0, 0x9c5

    if-ge p1, v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    move v0, v2

    :goto_0
    if-eqz v0, :cond_1

    const-string v0, "2.4G"

    goto :goto_3

    .line 243
    :cond_1
    const/16 v0, 0x1324

    if-gt v0, p1, :cond_2

    const/16 v0, 0x170d

    if-ge p1, v0, :cond_2

    move v0, v1

    goto :goto_1

    :cond_2
    move v0, v2

    :goto_1
    if-eqz v0, :cond_3

    const-string v0, "5G"

    goto :goto_3

    .line 244
    :cond_3
    const/16 v0, 0x1725

    if-gt v0, p1, :cond_4

    const/16 v0, 0x1bd6

    if-ge p1, v0, :cond_4

    goto :goto_2

    :cond_4
    move v1, v2

    :goto_2
    if-eqz v1, :cond_5

    const-string v0, "6G"

    goto :goto_3

    .line 245
    :cond_5
    if-lez p1, :cond_6

    const-string/jumbo v0, "unknown"

    goto :goto_3

    .line 246
    :cond_6
    const-string/jumbo v0, "unavailable"

    .line 241
    :goto_3
    return-object v0
.end method


# virtual methods
.method public addWifiP2PClientListener(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 156
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mWifiP2PClientListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 157
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mWifiP2PClientListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 159
    :cond_0
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

    .line 173
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0, p1, p2}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->connectDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V

    .line 174
    return-void
.end method

.method public disconnect()V
    .locals 1

    .line 181
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->disconnect()V

    .line 182
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

    .line 196
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->getGroupInfo(Lkotlin/jvm/functions/Function1;)V

    .line 197
    return-void
.end method

.method public getIARMixControl()Lcom/rokid/security/phone/sdk/api/wifip2p/api/IARMixControl;
    .locals 1

    .line 255
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mARMixControl:Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;

    check-cast v0, Lcom/rokid/security/phone/sdk/api/wifip2p/api/IARMixControl;

    return-object v0
.end method

.method public getIP2PConnectControl()Lcom/rokid/security/phone/sdk/api/wifip2p/api/IP2PConnectControl;
    .locals 1

    .line 251
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mP2PConnectControl:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    check-cast v0, Lcom/rokid/security/phone/sdk/api/wifip2p/api/IP2PConnectControl;

    return-object v0
.end method

.method public final getP2PConnectControl()Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;
    .locals 1

    .line 262
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mP2PConnectControl:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    return-object v0
.end method

.method public final init(Lkotlin/jvm/functions/Function1;)V
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

    const-string v0, "onResult"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 144
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$init$1;

    invoke-direct {v1, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$init$1;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->init(Lkotlin/jvm/functions/Function1;)V

    .line 149
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mP2PConnectControl:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->init()V

    .line 150
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mARMixControl:Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->init()V

    .line 151
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
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 166
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->initialize(Lkotlin/jvm/functions/Function1;)V

    .line 167
    return-void
.end method

.method public isAutoDecodeH264ToNv21Enabled()Z
    .locals 1

    .line 216
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->autoDecodeH264ToNv21:Z

    return v0
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

    .line 201
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->isConnect(Lkotlin/jvm/functions/Function1;)V

    .line 202
    return-void
.end method

.method public final isConnect()Z
    .locals 1

    .line 38
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect:Z

    return v0
.end method

.method public final release()V
    .locals 3

    .line 291
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mIWifiP2PListener:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;

    check-cast v1, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->removeWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V

    .line 292
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mWifiP2PClientListeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 293
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->release()V

    .line 294
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mP2PConnectControl:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->release()V

    .line 295
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mARMixControl:Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/ARMixControl;->release()V

    .line 296
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->h264DecoderLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 297
    .local v1, "$i$a$-synchronized-P2PClientServiceImpl$release$1":I
    :try_start_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mH264StreamDecoder:Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->release()V

    .line 298
    nop

    .end local v1    # "$i$a$-synchronized-P2PClientServiceImpl$release$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 296
    monitor-exit v0

    .line 299
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect:Z

    .line 300
    return-void

    .line 296
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public removeWifiP2PClientListener(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 162
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mWifiP2PClientListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 163
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

    .line 192
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V

    .line 193
    return-void
.end method

.method public final sendAudioStreamData([B)V
    .locals 1
    .param p1, "streamData"    # [B

    const-string/jumbo v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 274
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->sendAudioStreamData([B)V

    .line 275
    return-void
.end method

.method public sendConnectP2pRequest(Lkotlin/jvm/functions/Function1;)V
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

    .line 177
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mP2PConnectControl:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->sendConnectP2pRequest(Lkotlin/jvm/functions/Function1;)V

    .line 178
    return-void
.end method

.method public final sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 270
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->sendTextMessage(Ljava/lang/String;)V

    .line 271
    return-void
.end method

.method public final sendVideoStreamData([B)V
    .locals 1
    .param p1, "streamData"    # [B

    const-string/jumbo v0, "streamData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 278
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->sendVideoStreamData([B)V

    .line 279
    return-void
.end method

.method public setAutoDecodeH264ToNv21(Z)V
    .locals 3
    .param p1, "enable"    # Z

    .line 205
    sput-boolean p1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->autoDecodeH264ToNv21:Z

    .line 206
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->h264DecoderLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 207
    .local v1, "$i$a$-synchronized-P2PClientServiceImpl$setAutoDecodeH264ToNv21$1":I
    if-eqz p1, :cond_0

    :try_start_0
    sget-boolean v2, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect:Z

    if-eqz v2, :cond_0

    .line 208
    sget-object v2, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-direct {v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->ensureH264DecoderLocked()V

    goto :goto_0

    .line 209
    :cond_0
    if-nez p1, :cond_1

    .line 210
    sget-object v2, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mH264StreamDecoder:Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->release()V

    .line 212
    :cond_1
    :goto_0
    nop

    .end local v1    # "$i$a$-synchronized-P2PClientServiceImpl$setAutoDecodeH264ToNv21$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 206
    monitor-exit v0

    .line 213
    return-void

    .line 206
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public final setConnect(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 38
    sput-boolean p1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect:Z

    return-void
.end method

.method public final setWifiP2PMessageListener(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    .line 266
    sput-object p1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->mWifiP2PMessageListener:Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    .line 267
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
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 185
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V

    .line 186
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
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 188
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V

    .line 189
    return-void
.end method
