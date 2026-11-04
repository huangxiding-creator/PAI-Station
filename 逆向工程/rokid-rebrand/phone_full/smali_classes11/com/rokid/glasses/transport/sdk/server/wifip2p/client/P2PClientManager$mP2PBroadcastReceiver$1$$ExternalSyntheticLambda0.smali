.class public final synthetic Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/net/wifi/p2p/WifiP2pManager$PeerListListener;


# instance fields
.field public final synthetic f$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;


# direct methods
.method public synthetic constructor <init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    return-void
.end method


# virtual methods
.method public final onPeersAvailable(Landroid/net/wifi/p2p/WifiP2pDeviceList;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mP2PBroadcastReceiver$1;->$r8$lambda$3CEsb08m3AOJ25IyujXCKy7nFXk(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Landroid/net/wifi/p2p/WifiP2pDeviceList;)V

    return-void
.end method
