.class public final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;
.super Ljava/lang/Object;
.source "P2PClientServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nP2PClientServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PClientServiceImpl.kt\ncom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,303:1\n1855#2,2:304\n1855#2,2:306\n1855#2,2:308\n1855#2,2:310\n*S KotlinDebug\n*F\n+ 1 P2PClientServiceImpl.kt\ncom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1\n*L\n44#1:304,2\n58#1:306,2\n64#1:308,2\n70#1:310,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000I\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H\u0016J \u0010\t\u001a\u00020\u00032\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\rH\u0016J\u0016\u0010\u000f\u001a\u00020\u00032\u000c\u0010\u0010\u001a\u0008\u0012\u0004\u0012\u00020\u00120\u0011H\u0016J\u0010\u0010\u0013\u001a\u00020\u00032\u0006\u0010\u0014\u001a\u00020\u0012H\u0016J\u0010\u0010\u0015\u001a\u00020\u00032\u0006\u0010\u0016\u001a\u00020\u0017H\u0016J\u0010\u0010\u0018\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0017J\u0010\u0010\u0019\u001a\u00020\u00032\u0006\u0010\u001a\u001a\u00020\u001bH\u0016\u00a8\u0006\u001c"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1",
        "Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;",
        "onAudioStream",
        "",
        "buffer",
        "Ljava/nio/ByteBuffer;",
        "onConnectionInfoAvailable",
        "wifiP2pInfo",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
        "onNv21Data",
        "data",
        "",
        "width",
        "",
        "height",
        "onPeersAvailable",
        "devices",
        "",
        "Landroid/net/wifi/p2p/WifiP2pDevice;",
        "onSelfDeviceAvailable",
        "device",
        "onTextMessage",
        "msg",
        "",
        "onVideoH264Stream",
        "onWifiP2pEnabled",
        "enabled",
        "",
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


# direct methods
.method constructor <init>()V
    .locals 0

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioStream(Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 134
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMWifiP2PMessageListener$p()Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;->onAudioStream(Ljava/nio/ByteBuffer;)V

    .line 135
    :cond_0
    return-void
.end method

.method public onConnectionInfoAvailable(Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 6
    .param p1, "wifiP2pInfo"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    const-string/jumbo v0, "wifiP2pInfo"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 57
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    const-string v1, "onConnectionInfoAvailable"

    invoke-static {v0, v1, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$logConnectedP2pFrequency(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;Ljava/lang/String;Landroid/net/wifi/p2p/WifiP2pInfo;)V

    .line 58
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMWifiP2PClientListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 306
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

    check-cast v4, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    const/4 v5, 0x0

    .line 59
    .local v5, "$i$a$-forEach-P2PClientServiceImpl$mIWifiP2PListener$1$onConnectionInfoAvailable$1":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;->onConnectionInfoAvailable(Landroid/net/wifi/p2p/WifiP2pInfo;)V

    .line 60
    nop

    .line 306
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    .end local v5    # "$i$a$-forEach-P2PClientServiceImpl$mIWifiP2PListener$1$onConnectionInfoAvailable$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 307
    :cond_0
    nop

    .line 61
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onNv21Data([BII)V
    .locals 1
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 139
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMWifiP2PMessageListener$p()Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;->onNv21Data([BII)V

    .line 140
    :cond_0
    return-void
.end method

.method public onPeersAvailable(Ljava/util/List;)V
    .locals 6
    .param p1, "devices"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "+",
            "Landroid/net/wifi/p2p/WifiP2pDevice;",
            ">;)V"
        }
    .end annotation

    const-string v0, "devices"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 70
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMWifiP2PClientListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 310
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

    check-cast v4, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    const/4 v5, 0x0

    .line 71
    .local v5, "$i$a$-forEach-P2PClientServiceImpl$mIWifiP2PListener$1$onPeersAvailable$1":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;->onPeersAvailable(Ljava/util/List;)V

    .line 72
    nop

    .line 310
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    .end local v5    # "$i$a$-forEach-P2PClientServiceImpl$mIWifiP2PListener$1$onPeersAvailable$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 311
    :cond_0
    nop

    .line 73
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onSelfDeviceAvailable(Landroid/net/wifi/p2p/WifiP2pDevice;)V
    .locals 6
    .param p1, "device"    # Landroid/net/wifi/p2p/WifiP2pDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 64
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMWifiP2PClientListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 308
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

    check-cast v4, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    const/4 v5, 0x0

    .line 65
    .local v5, "$i$a$-forEach-P2PClientServiceImpl$mIWifiP2PListener$1$onSelfDeviceAvailable$1":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;->onSelfDeviceAvailable(Landroid/net/wifi/p2p/WifiP2pDevice;)V

    .line 66
    nop

    .line 308
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    .end local v5    # "$i$a$-forEach-P2PClientServiceImpl$mIWifiP2PListener$1$onSelfDeviceAvailable$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 309
    :cond_0
    nop

    .line 67
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onStreamReceived(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 0
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    .line 40
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener$DefaultImpls;->onStreamReceived(Lcom/rokid/security/phone/sdk/server/wifip2p/listener/WifiP2PWrapperListener;Ljava/lang/String;[BLjava/lang/String;)V

    return-void
.end method

.method public onTextMessage(Ljava/lang/String;)V
    .locals 8
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 76
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMWifiP2PMessageListener$p()Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;->onP2PTextMessage(Ljava/lang/String;)V

    .line 79
    :cond_0
    nop

    .line 80
    :try_start_0
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "VIDEO_STREAM_RESOLUTION_CHANGE"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v2, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 81
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 82
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v1, "type"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "VIDEO_STREAM_RESOLUTION_CHANGE"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 83
    const-string v1, "extra"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 84
    .local v1, "extraJson":Ljava/lang/String;
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    if-eqz v2, :cond_1

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_2

    :cond_1
    const/4 v4, 0x1

    :cond_2
    if-nez v4, :cond_4

    .line 85
    new-instance v2, Lcom/google/gson/Gson;

    invoke-direct {v2}, Lcom/google/gson/Gson;-><init>()V

    const-class v3, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;

    invoke-virtual {v2, v1, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;

    .line 86
    .local v2, "resolutionChange":Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;
    const-string v3, "WifiP2PClientService"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Received resolution change: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->getWidth()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const/16 v5, 0x78

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->getHeight()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const/16 v5, 0x40

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->getFps()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "fps"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 88
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getH264DecoderLock$p()Ljava/lang/Object;

    move-result-object v3

    monitor-enter v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v4, 0x0

    .line 89
    .local v4, "$i$a$-synchronized-P2PClientServiceImpl$mIWifiP2PListener$1$onTextMessage$1":I
    :try_start_1
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getAutoDecodeH264ToNv21$p()Z

    move-result v5

    if-eqz v5, :cond_3

    sget-object v5, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 91
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMH264StreamDecoder$p()Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    move-result-object v5

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->release()V

    .line 93
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMH264StreamDecoder$p()Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    move-result-object v5

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->getWidth()I

    move-result v6

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->getHeight()I

    move-result v7

    invoke-virtual {v5, v6, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->setExpectedSize(II)V

    .line 95
    sget-object v5, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$ensureH264DecoderLocked(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;)V

    .line 97
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMH264StreamDecoder$p()Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    move-result-object v5

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->isCodecRunning()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 98
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMH264StreamDecoder$p()Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    move-result-object v5

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->start()V

    .line 101
    :cond_3
    nop

    .end local v4    # "$i$a$-synchronized-P2PClientServiceImpl$mIWifiP2PListener$1$onTextMessage$1":I
    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 88
    :try_start_2
    monitor-exit v3

    goto :goto_0

    :catchall_0
    move-exception v4

    monitor-exit v3

    .end local p1    # "msg":Ljava/lang/String;
    throw v4
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 105
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "extraJson":Ljava/lang/String;
    .end local v2    # "resolutionChange":Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;
    .restart local p1    # "msg":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 106
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "WifiP2PClientService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to parse resolution change message: "

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

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 108
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_4
    :goto_0
    return-void
.end method

.method public onVideoH264Stream(Ljava/nio/ByteBuffer;)V
    .locals 4
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 112
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMWifiP2PMessageListener$p()Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;->onVideoH264Stream(Ljava/nio/ByteBuffer;)V

    .line 115
    :cond_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getAutoDecodeH264ToNv21$p()Z

    move-result v0

    if-nez v0, :cond_1

    .line 116
    return-void

    .line 118
    :cond_1
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    .line 119
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    new-array v0, v0, [B

    .line 120
    .local v0, "bytes":[B
    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 121
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getH264DecoderLock$p()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1

    const/4 v2, 0x0

    .line 122
    .local v2, "$i$a$-synchronized-P2PClientServiceImpl$mIWifiP2PListener$1$onVideoH264Stream$1":I
    :try_start_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getAutoDecodeH264ToNv21$p()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 123
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMH264StreamDecoder$p()Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    move-result-object v3

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->isCodecRunning()Z

    move-result v3

    if-nez v3, :cond_2

    .line 124
    sget-object v3, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$ensureH264DecoderLocked(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;)V

    .line 125
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMH264StreamDecoder$p()Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    move-result-object v3

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->start()V

    goto :goto_0

    .line 127
    :cond_2
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMH264StreamDecoder$p()Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    move-result-object v3

    invoke-virtual {v3, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decoderH264StreamData([B)V

    .line 130
    :cond_3
    :goto_0
    nop

    .end local v2    # "$i$a$-synchronized-P2PClientServiceImpl$mIWifiP2PListener$1$onVideoH264Stream$1":I
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 121
    monitor-exit v1

    .line 131
    return-void

    .line 121
    :catchall_0
    move-exception v2

    monitor-exit v1

    throw v2
.end method

.method public onWifiP2pEnabled(Z)V
    .locals 6
    .param p1, "enabled"    # Z

    .line 43
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->setConnect(Z)V

    .line 44
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMWifiP2PClientListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 304
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

    check-cast v4, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    const/4 v5, 0x0

    .line 45
    .local v5, "$i$a$-forEach-P2PClientServiceImpl$mIWifiP2PListener$1$onWifiP2pEnabled$1":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;->onWifiP2pEnabled(Z)V

    .line 46
    nop

    .line 304
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    .end local v5    # "$i$a$-forEach-P2PClientServiceImpl$mIWifiP2PListener$1$onWifiP2pEnabled$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 305
    :cond_0
    nop

    .line 47
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getH264DecoderLock$p()Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    const/4 v1, 0x0

    .line 48
    .local v1, "$i$a$-synchronized-P2PClientServiceImpl$mIWifiP2PListener$1$onWifiP2pEnabled$2":I
    if-eqz p1, :cond_1

    :try_start_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getAutoDecodeH264ToNv21$p()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 49
    sget-object v2, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$ensureH264DecoderLocked(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;)V

    goto :goto_1

    .line 51
    :cond_1
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMH264StreamDecoder$p()Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;

    move-result-object v2

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->release()V

    .line 53
    :goto_1
    nop

    .end local v1    # "$i$a$-synchronized-P2PClientServiceImpl$mIWifiP2PListener$1$onWifiP2pEnabled$2":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 47
    monitor-exit v0

    .line 54
    return-void

    .line 47
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method
