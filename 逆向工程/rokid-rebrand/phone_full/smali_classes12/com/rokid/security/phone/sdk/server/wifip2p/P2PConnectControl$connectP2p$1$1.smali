.class final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;
.super Lkotlin/jvm/internal/Lambda;
.source "P2PConnectControl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;->invoke(Z)V
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
        "it1",
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
.field final synthetic $extra:Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

.field final synthetic $requestId:Ljava/lang/String;

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Ljava/lang/String;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->$extra:Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->$requestId:Ljava/lang/String;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 243
    move-object v0, p1

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pGroup;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->invoke(Landroid/net/wifi/p2p/WifiP2pGroup;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Landroid/net/wifi/p2p/WifiP2pGroup;)V
    .locals 9
    .param p1, "it1"    # Landroid/net/wifi/p2p/WifiP2pGroup;

    .line 244
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/net/wifi/p2p/WifiP2pGroup;->getOwner()Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v1

    iget-object v1, v1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceName:Ljava/lang/String;

    const-string v2, "it1.owner.deviceName"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v1, Ljava/lang/CharSequence;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->$extra:Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;->getGlass3DeviceName()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x0

    const/4 v4, 0x2

    invoke-static {v1, v2, v3, v4, v0}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 245
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "p2p already connected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 246
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->$requestId:Ljava/lang/String;

    const/16 v7, 0xc

    const/4 v8, 0x0

    const/4 v3, 0x1

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v2 .. v8}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->sendConnectP2pResponseMsg$default(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;ZLjava/lang/String;Ljava/lang/String;IILjava/lang/Object;)V

    .line 247
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$processNextRequest(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    goto :goto_0

    .line 249
    :cond_0
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "connectP2p: GroupInfo =  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", deviceName = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Landroid/net/wifi/p2p/WifiP2pGroup;->getOwner()Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v3

    if-eqz v3, :cond_1

    iget-object v0, v3, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceName:Ljava/lang/String;

    :cond_1
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ", glass3DeviceName = "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->$extra:Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ".glass3DeviceName"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 250
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$startConnectP2p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    .line 252
    :goto_0
    return-void
.end method
