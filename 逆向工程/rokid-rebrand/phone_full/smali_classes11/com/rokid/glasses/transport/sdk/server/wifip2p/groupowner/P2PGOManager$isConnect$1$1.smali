.class final Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1;
.super Lkotlin/jvm/internal/Lambda;
.source "P2PGOManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1;->invoke(Landroid/net/wifi/p2p/WifiP2pInfo;)V
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
    value = "SMAP\nP2PGOManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PGOManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,771:1\n1855#2,2:772\n*S KotlinDebug\n*F\n+ 1 P2PGOManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1\n*L\n443#1:772,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u00012\u000c\u0010\u0002\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0003H\n\u00a2\u0006\u0002\u0008\u0005"
    }
    d2 = {
        "<anonymous>",
        "",
        "list",
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
.field final synthetic $action:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;


# direct methods
.method constructor <init>(Lkotlin/jvm/functions/Function1;Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;",
            "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1;->$action:Lkotlin/jvm/functions/Function1;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 437
    move-object v0, p1

    check-cast v0, Ljava/util/List;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1;->invoke(Ljava/util/List;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Ljava/util/List;)V
    .locals 7
    .param p1, "list"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "+",
            "Landroid/net/wifi/p2p/WifiP2pDevice;",
            ">;)V"
        }
    .end annotation

    const-string v0, "list"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 438
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 439
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1;->$action:Lkotlin/jvm/functions/Function1;

    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 441
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$isConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    .line 442
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "getClientList == 0 onWifiP2pEnabled = false"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 443
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 772
    .local v2, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
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

    .line 444
    .local v6, "$i$a$-forEach-P2PGOManager$isConnect$1$1$1":I
    invoke-interface {v5, v1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;->onWifiP2pEnabled(Z)V

    .line 445
    nop

    .line 772
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PGoListener;
    .end local v6    # "$i$a$-forEach-P2PGOManager$isConnect$1$1$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 773
    :cond_1
    nop

    .line 446
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$getMSocketServerChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->close()V

    .line 447
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;->access$setConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager;Z)V

    .line 450
    :cond_2
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/P2PGOManager$isConnect$1$1;->$action:Lkotlin/jvm/functions/Function1;

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 452
    :goto_1
    return-void
.end method
