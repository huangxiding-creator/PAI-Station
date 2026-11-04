.class final Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1;
.super Lkotlin/jvm/internal/Lambda;
.source "P2PClientManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->removeGroup(Lkotlin/jvm/functions/Function1;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Landroid/net/wifi/p2p/WifiP2pGroup;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u00012\u0008\u0010\u0002\u001a\u0004\u0018\u00010\u0003H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "",
        "group",
        "Landroid/net/wifi/p2p/WifiP2pGroup;",
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
.field final synthetic $onResult:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1;->$onResult:Lkotlin/jvm/functions/Function1;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 228
    move-object v0, p1

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pGroup;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1;->invoke(Landroid/net/wifi/p2p/WifiP2pGroup;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Landroid/net/wifi/p2p/WifiP2pGroup;)V
    .locals 5
    .param p1, "group"    # Landroid/net/wifi/p2p/WifiP2pGroup;

    .line 229
    if-eqz p1, :cond_0

    .line 230
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getWifiP2pManager(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pManager;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getWifiP2pChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Landroid/net/wifi/p2p/WifiP2pManager$Channel;

    move-result-object v1

    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1$1;

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1;->$onResult:Lkotlin/jvm/functions/Function1;

    invoke-direct {v2, v3, v4}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$removeGroup$1$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;)V

    check-cast v2, Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;

    invoke-virtual {v0, v1, v2}, Landroid/net/wifi/p2p/WifiP2pManager;->removeGroup(Landroid/net/wifi/p2p/WifiP2pManager$Channel;Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;)V

    .line 248
    :cond_0
    return-void
.end method
