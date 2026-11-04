.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;
.super Landroid/content/BroadcastReceiver;
.source "P2PGOManager.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->registerReceiver()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nP2PGOManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PGOManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,771:1\n1855#2,2:772\n1855#2,2:774\n1855#2,2:776\n1855#2,2:778\n*S KotlinDebug\n*F\n+ 1 P2PGOManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1\n*L\n122#1:772,2\n237#1:774,2\n135#1:776,2\n138#1:778,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001d\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0017\u00a8\u0006\u0008"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1",
        "Landroid/content/BroadcastReceiver;",
        "onReceive",
        "",
        "context",
        "Landroid/content/Context;",
        "intent",
        "Landroid/content/Intent;",
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
.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;


# direct methods
.method public static synthetic $r8$lambda$D37YkYuy2NOEtT2O7h4BzLhNIVc(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Landroid/net/wifi/p2p/WifiP2pDeviceList;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->onReceive$lambda$3(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Landroid/net/wifi/p2p/WifiP2pDeviceList;)V

    return-void
.end method

.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    .line 110
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method private static final onReceive$lambda$3(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Landroid/net/wifi/p2p/WifiP2pDeviceList;)V
    .locals 11
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;
    .param p1, "peers"    # Landroid/net/wifi/p2p/WifiP2pDeviceList;

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 133
    invoke-virtual {p1}, Landroid/net/wifi/p2p/WifiP2pDeviceList;->getDeviceList()Ljava/util/Collection;

    move-result-object v0

    const-string v1, "peers.deviceList"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Ljava/lang/Iterable;

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->toList(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v0

    .line 134
    .local v0, "list":Ljava/util/List;
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " onPeersAvailable: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 135
    move-object v1, v0

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 776
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .local v5, "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Landroid/net/wifi/p2p/WifiP2pDevice;

    .local v6, "it":Landroid/net/wifi/p2p/WifiP2pDevice;
    const/4 v7, 0x0

    .line 136
    .local v7, "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$2$1":I
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, v6, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceName:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "  "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget v10, v6, Landroid/net/wifi/p2p/WifiP2pDevice;->status:I

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 137
    nop

    .line 776
    .end local v6    # "it":Landroid/net/wifi/p2p/WifiP2pDevice;
    .end local v7    # "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$2$1":I
    nop

    .end local v5    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 777
    :cond_0
    nop

    .line 138
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/util/Set;

    move-result-object v1

    check-cast v1, Ljava/lang/Iterable;

    .restart local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 778
    .restart local v2    # "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/4 v6, 0x0

    .line 139
    .local v6, "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$2$2":I
    invoke-interface {v5, v0}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onPeersAvailable(Ljava/util/List;)V

    .line 140
    nop

    .line 778
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v6    # "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$2$2":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 779
    :cond_1
    nop

    .line 141
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "intent"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 114
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_7

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    goto/16 :goto_3

    :sswitch_0
    const-string v1, "android.net.wifi.p2p.STATE_CHANGED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto/16 :goto_3

    .line 116
    :cond_0
    nop

    .line 117
    nop

    .line 118
    nop

    .line 116
    const-string v0, "wifi_p2p_state"

    const/4 v1, -0x1

    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    .line 119
    nop

    .line 116
    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    .line 120
    .local v0, "enabled":Z
    :goto_0
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " P2PBroadcastReceiver  WIFI_P2P_STATE_CHANGED_ACTION\uff1a "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "  --- wifip2p \u529f\u80fd\u662f\u5426\u53ef\u7528(\u5f00\u542f/\u5173\u95ed)"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 121
    if-nez v0, :cond_7

    .line 122
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/util/Set;

    move-result-object v1

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 772
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/4 v6, 0x0

    .line 123
    .local v6, "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$1":I
    invoke-interface {v5, v0}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onWifiP2pEnabled(Z)V

    .line 124
    nop

    .line 772
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v6    # "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 773
    :cond_2
    nop

    .end local v0    # "enabled":Z
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    goto/16 :goto_3

    .line 114
    :sswitch_1
    const-string v1, "android.net.wifi.p2p.PEERS_CHANGED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    goto/16 :goto_3

    .line 130
    :cond_3
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " P2PBroadcastReceiver  WIFI_P2P_PEERS_CHANGED_ACTION --- \u9644\u8fd1\u7684P2P \u8bbe\u5907\u5217\u8868\u53d8\u5316"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 131
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getWifiP2pChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v0

    if-eqz v0, :cond_7

    .line 132
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getWifiP2pManager(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getWifiP2pChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$$ExternalSyntheticLambda0;

    invoke-direct {v3, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)V

    invoke-virtual {v0, v1, v3}, Landroid/net/wifi/p2p/WifiP2pManager;->requestPeers(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$PeerListListener;)V

    goto/16 :goto_3

    .line 114
    :sswitch_2
    const-string v1, "android.net.wifi.p2p.THIS_DEVICE_CHANGED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    goto/16 :goto_3

    .line 234
    :cond_4
    const-string v0, "wifiP2pDevice"

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pDevice;

    .line 233
    nop

    .line 235
    .local v0, "wifiP2pDevice":Landroid/net/wifi/p2p/WifiP2pDevice;
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " P2PBroadcastReceiver WIFI_P2P_THIS_DEVICE_CHANGED_ACTION --- \u672c\u8bbe\u5907\u4fe1\u606f\u7684\u53d8\u5316  \uff1a "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x20

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 236
    if-eqz v0, :cond_7

    .line 237
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/util/Set;

    move-result-object v1

    check-cast v1, Ljava/lang/Iterable;

    .restart local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 774
    .restart local v2    # "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .restart local v4    # "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .restart local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/4 v6, 0x0

    .line 238
    .local v6, "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$4":I
    invoke-interface {v5, v0}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onSelfDeviceAvailable(Landroid/net/wifi/p2p/WifiP2pDevice;)V

    .line 239
    nop

    .line 774
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v6    # "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$4":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 775
    :cond_5
    goto :goto_3

    .line 114
    .end local v0    # "wifiP2pDevice":Landroid/net/wifi/p2p/WifiP2pDevice;
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    :sswitch_3
    const-string v1, "android.net.wifi.p2p.CONNECTION_STATE_CHANGE"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6

    goto :goto_3

    .line 146
    :cond_6
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " P2PBroadcastReceiver  WIFI_P2P_CONNECTION_CHANGED_ACTION --- wifip2p \u8fde\u63a5\u72b6\u6001\u7684\u53d8\u5316 "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 147
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    new-instance v1, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-direct {v1, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->getClientList(Lkotlin/jvm/functions/Function1;)V

    .line 243
    :cond_7
    :goto_3
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        -0x69a8390a -> :sswitch_3
        -0x5d62fb1d -> :sswitch_2
        -0x532207c3 -> :sswitch_1
        0x6511c17d -> :sswitch_0
    .end sparse-switch
.end method
