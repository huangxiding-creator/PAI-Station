.class final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;
.super Lkotlin/jvm/internal/Lambda;
.source "P2PConnectControl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->connectP2p(Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Ljava/lang/Boolean;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u0003H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "",
        "it",
        "",
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
.field final synthetic $extra:Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

.field final synthetic $requestId:Ljava/lang/String;

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;Ljava/lang/String;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;->$extra:Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;->$requestId:Ljava/lang/String;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 241
    move-object v0, p1

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;->invoke(Z)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Z)V
    .locals 5
    .param p1, "it"    # Z

    .line 242
    if-eqz p1, :cond_0

    .line 243
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;->$extra:Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;->$requestId:Ljava/lang/String;

    invoke-direct {v1, v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;-><init>(Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Ljava/lang/String;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->getGroupInfo(Lkotlin/jvm/functions/Function1;)V

    goto :goto_0

    .line 254
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "connectP2p: isConnect = false"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 255
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$startConnectP2p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    .line 257
    :goto_0
    return-void
.end method
