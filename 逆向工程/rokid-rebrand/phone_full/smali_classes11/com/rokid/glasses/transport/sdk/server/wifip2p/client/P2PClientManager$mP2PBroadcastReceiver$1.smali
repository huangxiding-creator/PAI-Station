.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;
.super Landroid/content/BroadcastReceiver;
.source "P2PClientManager.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nP2PClientManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PClientManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,683:1\n1855#2,2:684\n1855#2,2:686\n*S KotlinDebug\n*F\n+ 1 P2PClientManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1\n*L\n152#1:684,2\n93#1:686,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001d\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0017\u00a8\u0006\u0008"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1",
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
.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;


# direct methods
.method public static synthetic $r8$lambda$3CEsb08m3AOJ25IyujXCKy7nFXk(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pDeviceList;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->onReceive$lambda$1(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pDeviceList;)V

    return-void
.end method

.method public static synthetic $r8$lambda$7K6_ZddBQEKzdF2jxucm6_TKNuM(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pGroup;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->onReceive$lambda$2(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pGroup;)V

    return-void
.end method

.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 59
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method private static final onReceive$lambda$1(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pDeviceList;)V
    .locals 8
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;
    .param p1, "peers"    # Landroid/net/wifi/p2p/WifiP2pDeviceList;

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 92
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " peers:  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Landroid/net/wifi/p2p/WifiP2pDeviceList;->getDeviceList()Ljava/util/Collection;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Collection;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 93
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/util/Set;

    move-result-object v0

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

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    const/4 v5, 0x0

    .line 94
    .local v5, "$i$a$-forEach-P2PClientManager$mP2PBroadcastReceiver$1$onReceive$2$1":I
    invoke-virtual {p1}, Landroid/net/wifi/p2p/WifiP2pDeviceList;->getDeviceList()Ljava/util/Collection;

    move-result-object v6

    const-string v7, "peers.deviceList"

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v6, Ljava/lang/Iterable;

    invoke-static {v6}, Lkotlin/collections/CollectionsKt;->toList(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v6

    invoke-interface {v4, v6}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;->onPeersAvailable(Ljava/util/List;)V

    .line 95
    nop

    .line 686
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    .end local v5    # "$i$a$-forEach-P2PClientManager$mP2PBroadcastReceiver$1$onReceive$2$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 687
    :cond_0
    nop

    .line 96
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method private static final onReceive$lambda$2(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pGroup;)V
    .locals 3
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;
    .param p1, "group"    # Landroid/net/wifi/p2p/WifiP2pGroup;

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 105
    if-eqz p1, :cond_1

    .line 107
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMGroupOwner$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMGroupOwner$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v0

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    iget-object v0, v0, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/net/wifi/p2p/WifiP2pGroup;->getOwner()Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v1

    iget-object v1, v1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 109
    :cond_0
    invoke-virtual {p1}, Landroid/net/wifi/p2p/WifiP2pGroup;->getOwner()Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$setMGroupOwner$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pDevice;)V

    .line 110
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "  onGroupInfoAvailable:  \u7ec4\u6240\u6709\u8005: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 111
    invoke-virtual {p1}, Landroid/net/wifi/p2p/WifiP2pGroup;->getClientList()Ljava/util/Collection;

    move-result-object v0

    const-string v1, "group.clientList"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    goto :goto_0

    .line 114
    :cond_1
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "onGroupInfoAvailable: group = null \u5f53\u524d\u8bbe\u5907\u672a\u52a0\u5165\u7fa4\u7ec4"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 116
    :goto_0
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 9
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "intent"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 62
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_a

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    goto/16 :goto_2

    :sswitch_0
    const-string v1, "android.net.wifi.p2p.STATE_CHANGED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto/16 :goto_2

    .line 64
    :cond_0
    nop

    .line 65
    nop

    .line 66
    nop

    .line 64
    const-string v0, "wifi_p2p_state"

    const/4 v1, -0x1

    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    .line 67
    nop

    .line 64
    const/4 v1, 0x1

    const/4 v2, 0x2

    if-ne v0, v2, :cond_1

    move v0, v1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    .line 68
    .local v0, "enabled":Z
    :goto_0
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "P2PBroadcastReceiver  WIFI_P2P_STATE_CHANGED_ACTION\uff1a "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "  --- wifip2p \u529f\u80fd\u662f\u5426\u53ef\u7528(\u5f00\u542f/\u5173\u95ed)"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 69
    const/4 v2, 0x0

    if-nez v0, :cond_3

    .line 70
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getStateCheckJob$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lkotlinx/coroutines/Job;

    move-result-object v3

    if-eqz v3, :cond_2

    invoke-static {v3, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 71
    :cond_2
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/utils/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v3

    new-instance v4, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$1;

    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-direct {v4, v5, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/coroutines/Continuation;)V

    move-object v6, v4

    check-cast v6, Lkotlin/jvm/functions/Function2;

    const/4 v7, 0x3

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v3 .. v8}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$setStateCheckJob$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlinx/coroutines/Job;)V

    goto/16 :goto_2

    .line 83
    :cond_3
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getStateCheckJob$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lkotlinx/coroutines/Job;

    move-result-object v3

    if-eqz v3, :cond_4

    invoke-static {v3, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 84
    :cond_4
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$setStateCheckJob$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlinx/coroutines/Job;)V

    .line 85
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "WiFi P2P\u5df2\u6062\u590d\u5f00\u542f\uff0c\u53d6\u6d88\u5ef6\u65f6\u5173\u95ed\u4efb\u52a1"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v0    # "enabled":Z
    goto/16 :goto_2

    .line 62
    :sswitch_1
    const-string v1, "android.net.wifi.p2p.PEERS_CHANGED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    goto/16 :goto_2

    .line 90
    :cond_5
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "P2PBroadcastReceiver  WIFI_P2P_PEERS_CHANGED_ACTION --- \u9644\u8fd1\u7684P2P \u8bbe\u5907\u5217\u8868\u53d8\u5316"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 91
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getWifiP2pManager(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getWifiP2pChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$$ExternalSyntheticLambda0;

    invoke-direct {v3, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V

    invoke-virtual {v0, v1, v3}, Landroid/net/wifi/p2p/WifiP2pManager;->requestPeers(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$PeerListListener;)V

    goto/16 :goto_2

    .line 62
    :sswitch_2
    const-string v1, "android.net.wifi.p2p.THIS_DEVICE_CHANGED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6

    goto/16 :goto_2

    .line 148
    :cond_6
    const-string v0, "wifiP2pDevice"

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pDevice;

    .line 147
    nop

    .line 149
    .local v0, "wifiP2pDevice":Landroid/net/wifi/p2p/WifiP2pDevice;
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "WIFI_P2P_THIS_DEVICE_CHANGED_ACTION  --- \u672c\u8bbe\u5907\u4fe1\u606f\u7684\u53d8\u5316\uff1a "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 150
    if-eqz v0, :cond_a

    .line 152
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/util/Set;

    move-result-object v1

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 684
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_7

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    const/4 v6, 0x0

    .line 153
    .local v6, "$i$a$-forEach-P2PClientManager$mP2PBroadcastReceiver$1$onReceive$5":I
    invoke-interface {v5, v0}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;->onSelfDeviceAvailable(Landroid/net/wifi/p2p/WifiP2pDevice;)V

    .line 154
    nop

    .line 684
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    .end local v6    # "$i$a$-forEach-P2PClientManager$mP2PBroadcastReceiver$1$onReceive$5":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 685
    :cond_7
    goto :goto_2

    .line 62
    .end local v0    # "wifiP2pDevice":Landroid/net/wifi/p2p/WifiP2pDevice;
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    :sswitch_3
    const-string v1, "android.net.wifi.p2p.CONNECTION_STATE_CHANGE"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    goto :goto_2

    .line 100
    :cond_8
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "P2PBroadcastReceiver  WIFI_P2P_CONNECTION_CHANGED_ACTION --- wifip2p \u8fde\u63a5\u72b6\u6001\u7684\u53d8\u5316"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 102
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getWifiP2pChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v0

    if-nez v0, :cond_9

    return-void

    .line 104
    :cond_9
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getWifiP2pManager(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getWifiP2pChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$$ExternalSyntheticLambda1;

    invoke-direct {v3, v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V

    invoke-virtual {v0, v1, v3}, Landroid/net/wifi/p2p/WifiP2pManager;->requestGroupInfo(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$GroupInfoListener;)V

    .line 118
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getWifiP2pManager(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getWifiP2pChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v1

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-direct {v2, v3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$onReceive$4;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V

    check-cast v2, Landroid/net/wifi/p2p/WifiP2pManager$ConnectionInfoListener;

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->requestConnectionInfo(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ConnectionInfoListener;)V

    .line 158
    :cond_a
    :goto_2
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
