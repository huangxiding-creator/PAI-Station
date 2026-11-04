.class final Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;
.super Lkotlin/jvm/internal/Lambda;
.source "P2PGOManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1;->onReceive(Landroid/content/Context;Landroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Ljava/util/List<",
        "+",
        "Landroid/net/wifi/p2p/WifiP2pDevice;",
        ">;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nP2PGOManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PGOManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,771:1\n1855#2,2:772\n*S KotlinDebug\n*F\n+ 1 P2PGOManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3\n*L\n153#1:772,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u00012\u000c\u0010\u0002\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0003H\n\u00a2\u0006\u0002\u0008\u0005"
    }
    d2 = {
        "<anonymous>",
        "",
        "it",
        "",
        "Landroid/net/wifi/p2p/WifiP2pDevice;",
        "invoke"
    }
    k = 0x3
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
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 147
    move-object v0, p1

    check-cast v0, Ljava/util/List;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;->invoke(Ljava/util/List;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Ljava/util/List;)V
    .locals 7
    .param p1, "it"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "+",
            "Landroid/net/wifi/p2p/WifiP2pDevice;",
            ">;)V"
        }
    .end annotation

    const-string v0, "it"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 148
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "WIFI_P2P_CONNECTION_CHANGED_ACTION -- getClientList size = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 149
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    .line 150
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$isConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 151
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " WIFI_P2P_CONNECTION_CHANGED_ACTION -- getClientList size = 0, onWifiP2pEnabled = false"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 153
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 772
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

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    const/4 v6, 0x0

    .line 154
    .local v6, "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$3$1":I
    invoke-interface {v5, v4}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onWifiP2pEnabled(Z)V

    .line 155
    nop

    .line 772
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v6    # "$i$a$-forEach-P2PGOManager$registerReceiver$1$onReceive$3$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 773
    :cond_0
    nop

    .line 156
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$setConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Z)V

    .line 157
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMSocketServerChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->close()V

    .line 161
    :cond_1
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/utils/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    const/4 v3, 0x0

    invoke-direct {v0, v2, v3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$registerReceiver$1$onReceive$3$2;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v2, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 229
    return-void
.end method
