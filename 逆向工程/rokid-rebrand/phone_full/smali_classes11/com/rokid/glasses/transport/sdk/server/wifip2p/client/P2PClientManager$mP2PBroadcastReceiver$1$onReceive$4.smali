.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;
.super Ljava/lang/Object;
.source "P2PClientManager.kt"

# interfaces
.implements Landroid/net/wifi/p2p/WifiP2pManager$ConnectionInfoListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->onReceive(Landroid/content/Context;Landroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nP2PClientManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PClientManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,683:1\n1855#2,2:684\n*S KotlinDebug\n*F\n+ 1 P2PClientManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4\n*L\n126#1:684,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0017\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0012\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H\u0016\u00a8\u0006\u0006"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4",
        "Landroid/net/wifi/p2p/WifiP2pManager$ConnectionInfoListener;",
        "onConnectionInfoAvailable",
        "",
        "wifiP2pInfo",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
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
.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 118
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConnectionInfoAvailable(Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 6
    .param p1, "wifiP2pInfo"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 120
    if-eqz p1, :cond_2

    .line 121
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " onConnectionInfoAvailable "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 122
    iget-boolean v0, p1, Landroid/net/wifi/p2p/WifiP2pInfo;->groupFormed:Z

    if-eqz v0, :cond_1

    .line 123
    iget-boolean v0, p1, Landroid/net/wifi/p2p/WifiP2pInfo;->isGroupOwner:Z

    if-nez v0, :cond_2

    .line 124
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " \u5f53\u524d\u8bbe\u5907\u662f\u5ba2\u6237\u7aef "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 125
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$setMWifiP2pInfo$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pInfo;)V

    .line 126
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 684
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

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    .local v4, "it2":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    const/4 v5, 0x0

    .line 127
    .local v5, "$i$a$-forEach-P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4$onConnectionInfoAvailable$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;->onConnectionInfoAvailable(Landroid/net/wifi/p2p/WifiP2pInfo;)V

    .line 128
    nop

    .line 684
    .end local v4    # "it2":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    .end local v5    # "$i$a$-forEach-P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4$onConnectionInfoAvailable$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 685
    :cond_0
    nop

    .line 129
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMSocketChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->isConnected()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMSocketChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->isConnecting()Z

    move-result v0

    if-nez v0, :cond_2

    .line 130
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMSocketChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->release()V

    .line 131
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMSocketChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMSocketServerListener$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;

    move-result-object v1

    check-cast v1, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->setSocketServerListener(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;)V

    .line 132
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMSocketChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    move-result-object v0

    iget-object v1, p1, Landroid/net/wifi/p2p/WifiP2pInfo;->groupOwnerAddress:Ljava/net/InetAddress;

    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    const-string v2, "wifiP2pInfo.groupOwnerAddress.hostAddress"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->connectWebsocketClient(Ljava/lang/String;)V

    goto :goto_1

    .line 137
    :cond_1
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " Wi-Fi P2P \u7ec4\u672a\u5f62\u6210"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 141
    :cond_2
    :goto_1
    return-void
.end method
