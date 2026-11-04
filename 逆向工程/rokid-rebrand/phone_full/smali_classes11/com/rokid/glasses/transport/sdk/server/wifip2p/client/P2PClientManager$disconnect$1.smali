.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$disconnect$1;
.super Ljava/lang/Object;
.source "P2PClientManager.kt"

# interfaces
.implements Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->disconnect()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0019\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0006\u001a\u00020\u0003H\u0016\u00a8\u0006\u0007"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$disconnect$1",
        "Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;",
        "onFailure",
        "",
        "reasonCode",
        "",
        "onSuccess",
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

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$disconnect$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 362
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(I)V
    .locals 3
    .param p1, "reasonCode"    # I

    .line 364
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$disconnect$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "cancelConnect onFailure:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 365
    return-void
.end method

.method public onSuccess()V
    .locals 2

    .line 369
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$disconnect$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "cancelConnect onSuccess"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 370
    return-void
.end method
