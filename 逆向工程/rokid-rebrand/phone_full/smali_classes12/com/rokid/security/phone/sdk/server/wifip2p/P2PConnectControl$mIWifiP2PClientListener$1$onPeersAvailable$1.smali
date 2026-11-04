.class final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onPeersAvailable$1;
.super Lkotlin/jvm/internal/Lambda;
.source "P2PConnectControl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->onPeersAvailable(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
        "+",
        "Ljava/lang/Boolean;",
        ">;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u00012\u000c\u0010\u0002\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0003H\n\u00a2\u0006\u0004\u0008\u0005\u0010\u0006"
    }
    d2 = {
        "<anonymous>",
        "",
        "it1",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "",
        "invoke-JoRRYb0",
        "(Ljava/lang/Object;)V"
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
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onPeersAvailable$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 157
    move-object v0, p1

    check-cast v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onPeersAvailable$1;->invoke-JoRRYb0(Ljava/lang/Object;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke-JoRRYb0(Ljava/lang/Object;)V
    .locals 5
    .param p1, "it1"    # Ljava/lang/Object;

    .line 158
    invoke-static {p1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 159
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onPeersAvailable$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "connectDevice device fail"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 160
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onPeersAvailable$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onPeersAvailable$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getMRequestId$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, -0x3

    const/4 v4, 0x0

    invoke-static {v0, v4, v2, v1, v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$sendConnectP2pResponseMsg(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;ZLjava/lang/String;Ljava/lang/String;I)V

    .line 161
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onPeersAvailable$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$processNextRequest(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    .line 163
    :cond_0
    return-void
.end method
