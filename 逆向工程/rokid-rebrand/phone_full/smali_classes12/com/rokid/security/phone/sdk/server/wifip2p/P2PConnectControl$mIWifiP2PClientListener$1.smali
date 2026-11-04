.class public final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;
.super Ljava/lang/Object;
.source "P2PConnectControl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000#\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0016\u0010\u0002\u001a\u00020\u00032\u000c\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u0005H\u0016J\u0010\u0010\u0007\u001a\u00020\u00032\u0006\u0010\u0008\u001a\u00020\tH\u0016\u00a8\u0006\n"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1",
        "Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;",
        "onPeersAvailable",
        "",
        "devices",
        "",
        "Landroid/net/wifi/p2p/WifiP2pDevice;",
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


# instance fields
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;


# direct methods
.method public static synthetic $r8$lambda$bcN_eXqmTc5qASlNNvqIB5NMhs8(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->onWifiP2pEnabled$lambda$0(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V

    return-void
.end method

.method constructor <init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 121
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static final onWifiP2pEnabled$lambda$0(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function2;
    .param p1, "p0"    # Ljava/lang/Object;
    .param p2, "p1"    # Ljava/lang/Object;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 125
    invoke-interface {p0, p1, p2}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public onConnectionInfoAvailable(Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 0
    .param p1, "wifiP2pInfo"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 121
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener$DefaultImpls;->onConnectionInfoAvailable(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;Landroid/net/wifi/p2p/WifiP2pInfo;)V

    return-void
.end method

.method public onPeersAvailable(Ljava/util/List;)V
    .locals 10
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

    .line 145
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getFindDevice$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$isNeedAutoConnect$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 147
    move-object v0, p1

    check-cast v0, Ljava/lang/Iterable;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    if-eqz v2, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    move-object v5, v2

    check-cast v5, Landroid/net/wifi/p2p/WifiP2pDevice;

    .local v5, "it":Landroid/net/wifi/p2p/WifiP2pDevice;
    const/4 v6, 0x0

    .line 148
    .local v6, "$i$a$-find-P2PConnectControl$mIWifiP2PClientListener$1$onPeersAvailable$device$1":I
    iget-object v7, v5, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceName:Ljava/lang/String;

    const-string v8, "it.deviceName"

    invoke-static {v7, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v7, Ljava/lang/CharSequence;

    const-string v8, "Glass3_"

    check-cast v8, Ljava/lang/CharSequence;

    const/4 v9, 0x2

    invoke-static {v7, v8, v3, v9, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    .line 149
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "onPeersAvailable: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, v5, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceName:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 151
    :cond_1
    iget-object v7, v5, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceName:Ljava/lang/String;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getMStartConnectP2PExtra$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    move-result-object v8

    if-eqz v8, :cond_2

    invoke-virtual {v8}, Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;->getGlass3DeviceName()Ljava/lang/String;

    move-result-object v4

    :cond_2
    invoke-static {v7, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    .line 147
    .end local v5    # "it":Landroid/net/wifi/p2p/WifiP2pDevice;
    .end local v6    # "$i$a$-find-P2PConnectControl$mIWifiP2PClientListener$1$onPeersAvailable$device$1":I
    if-eqz v4, :cond_0

    move-object v4, v2

    :cond_3
    move-object v0, v4

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pDevice;

    .line 153
    .local v0, "device":Landroid/net/wifi/p2p/WifiP2pDevice;
    if-eqz v0, :cond_4

    .line 154
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onPeersAvailable:  connectDevice  device = "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, v0, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceName:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 155
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    const/4 v2, 0x1

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$setFindDevice$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Z)V

    .line 156
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$setNeedAutoConnect$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Z)V

    .line 157
    sget-object v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    new-instance v2, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onPeersAvailable$1;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-direct {v2, v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onPeersAvailable$1;-><init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    check-cast v2, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v1, v0, v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->connectDevice(Landroid/net/wifi/p2p/WifiP2pDevice;Lkotlin/jvm/functions/Function1;)V

    .line 166
    .end local v0    # "device":Landroid/net/wifi/p2p/WifiP2pDevice;
    :cond_4
    return-void
.end method

.method public onSelfDeviceAvailable(Landroid/net/wifi/p2p/WifiP2pDevice;)V
    .locals 0
    .param p1, "device"    # Landroid/net/wifi/p2p/WifiP2pDevice;

    .line 121
    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener$DefaultImpls;->onSelfDeviceAvailable(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;Landroid/net/wifi/p2p/WifiP2pDevice;)V

    return-void
.end method

.method public onWifiP2pEnabled(Z)V
    .locals 12
    .param p1, "enabled"    # Z

    .line 123
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getFindDevice$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$isNeedAutoConnect$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getMRequestId$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/4 v1, 0x0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    if-eqz v0, :cond_2

    .line 125
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getConnectP2pActions$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v0

    new-instance v2, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onWifiP2pEnabled$1;

    invoke-direct {v2, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onWifiP2pEnabled$1;-><init>(Z)V

    check-cast v2, Lkotlin/jvm/functions/Function2;

    new-instance v3, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$$ExternalSyntheticLambda0;

    invoke-direct {v3, v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function2;)V

    invoke-virtual {v0, v3}, Ljava/util/concurrent/ConcurrentHashMap;->forEach(Ljava/util/function/BiConsumer;)V

    .line 131
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getConnectP2pActions$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentHashMap;->clear()V

    .line 133
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onWifiP2pEnabled:  enabled = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " , mResponseId = "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getMRequestId$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 134
    if-eqz p1, :cond_1

    .line 135
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getMRequestId$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v7

    const/16 v10, 0xc

    const/4 v11, 0x0

    const/4 v6, 0x1

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-static/range {v5 .. v11}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->sendConnectP2pResponseMsg$default(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;ZLjava/lang/String;Ljava/lang/String;IILjava/lang/Object;)V

    goto :goto_1

    .line 137
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getMRequestId$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 138
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getMRequestId$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "connectDevice device fail"

    const/4 v4, -0x4

    invoke-static {v0, v1, v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$sendConnectP2pResponseMsg(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;ZLjava/lang/String;Ljava/lang/String;I)V

    .line 140
    :goto_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$processNextRequest(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    .line 142
    :cond_2
    return-void
.end method
