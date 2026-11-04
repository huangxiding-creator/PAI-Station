.class public interface abstract Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo;
.super Ljava/lang/Object;
.source "IWifiP2PGo.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000b\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010 \n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J@\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u00082+\u0008\u0002\u0010\t\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000c0\u000b\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u000f\u0012\u0004\u0012\u00020\u0003\u0018\u00010\nH&\u00f8\u0001\u0000J4\u0010\u0010\u001a\u00020\u00032\'\u0010\t\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000c0\u000b\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u000f\u0012\u0004\u0012\u00020\u00030\nH&\u00f8\u0001\u0000J1\u0010\u0011\u001a\u00020\u00032\'\u0010\u0012\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00080\u0013\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u0014\u0012\u0004\u0012\u00020\u00030\nH&J-\u0010\u0015\u001a\u00020\u00032#\u0010\u0012\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010\u0016\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u0017\u0012\u0004\u0012\u00020\u00030\nH&J+\u0010\u0018\u001a\u00020\u00032!\u0010\u0012\u001a\u001d\u0012\u0013\u0012\u00110\u000c\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u0018\u0012\u0004\u0012\u00020\u00030\nH&J\u0008\u0010\u0019\u001a\u00020\u000cH&J8\u0010\u001a\u001a\u00020\u00032+\u0008\u0002\u0010\t\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000c0\u000b\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u000f\u0012\u0004\u0012\u00020\u0003\u0018\u00010\nH&\u00f8\u0001\u0000J\u0010\u0010\u001b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J-\u0010\u001c\u001a\u00020\u00032#\u0010\u0012\u001a\u001f\u0012\u0015\u0012\u0013\u0018\u00010\u001d\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u001e\u0012\u0004\u0012\u00020\u00030\nH&J\u0010\u0010\u001f\u001a\u00020\u00032\u0006\u0010 \u001a\u00020!H&J \u0010\"\u001a\u00020\u00032\u0006\u0010#\u001a\u00020$2\u0006\u0010%\u001a\u00020!2\u0006\u0010&\u001a\u00020$H&J\u0010\u0010\'\u001a\u00020\u00032\u0006\u0010(\u001a\u00020$H&J\u0010\u0010)\u001a\u00020\u00032\u0006\u0010 \u001a\u00020*H&J\u0010\u0010)\u001a\u00020\u00032\u0006\u0010 \u001a\u00020!H&J8\u0010+\u001a\u00020\u00032+\u0008\u0002\u0010\t\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000c0\u000b\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u000f\u0012\u0004\u0012\u00020\u0003\u0018\u00010\nH&\u00f8\u0001\u0000J8\u0010,\u001a\u00020\u00032+\u0008\u0002\u0010\t\u001a%\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u000c0\u000b\u00a2\u0006\u000c\u0008\r\u0012\u0008\u0008\u000e\u0012\u0004\u0008\u0008(\u000f\u0012\u0004\u0012\u00020\u0003\u0018\u00010\nH&\u00f8\u0001\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006-"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/IWifiP2PGo;",
        "",
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
        "isConnect",
        "isWebsocketServerRunning",
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
        "",
        "bytes",
        "clientId",
        "sendTextMessage",
        "message",
        "sendVideoStreamData",
        "Ljava/nio/ByteBuffer;",
        "startDiscoverPeers",
        "stopPeerDiscovery",
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
.method public abstract addWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;)V
.end method

.method public abstract connectDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V
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
.end method

.method public abstract createGroup(Lkotlin/jvm/functions/Function1;)V
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
.end method

.method public abstract getClientList(Lkotlin/jvm/functions/Function1;)V
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
.end method

.method public abstract getGroupInfo(Lkotlin/jvm/functions/Function1;)V
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
.end method

.method public abstract isConnect(Lkotlin/jvm/functions/Function1;)V
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
.end method

.method public abstract isWebsocketServerRunning()Z
.end method

.method public abstract removeGroup(Lkotlin/jvm/functions/Function1;)V
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
.end method

.method public abstract removeWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;)V
.end method

.method public abstract requestConnectionInfo(Lkotlin/jvm/functions/Function1;)V
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
.end method

.method public abstract sendAudioStreamData([B)V
.end method

.method public abstract sendStreamData(Ljava/lang/String;[BLjava/lang/String;)V
.end method

.method public abstract sendTextMessage(Ljava/lang/String;)V
.end method

.method public abstract sendVideoStreamData(Ljava/nio/ByteBuffer;)V
.end method

.method public abstract sendVideoStreamData([B)V
.end method

.method public abstract startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V
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
.end method

.method public abstract stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V
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
.end method
