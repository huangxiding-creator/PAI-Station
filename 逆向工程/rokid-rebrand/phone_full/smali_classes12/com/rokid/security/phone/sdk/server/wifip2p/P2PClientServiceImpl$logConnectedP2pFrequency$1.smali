.class final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$logConnectedP2pFrequency$1;
.super Lkotlin/jvm/internal/Lambda;
.source "P2PClientServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->logConnectedP2pFrequency(Ljava/lang/String;Landroid/net/wifi/p2p/WifiP2pInfo;)V
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
.field final synthetic $source:Ljava/lang/String;

.field final synthetic $wifiP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;


# direct methods
.method constructor <init>(Landroid/net/wifi/p2p/WifiP2pInfo;Ljava/lang/String;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$logConnectedP2pFrequency$1;->$wifiP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$logConnectedP2pFrequency$1;->$source:Ljava/lang/String;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 220
    move-object v0, p1

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pGroup;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$logConnectedP2pFrequency$1;->invoke(Landroid/net/wifi/p2p/WifiP2pGroup;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Landroid/net/wifi/p2p/WifiP2pGroup;)V
    .locals 7
    .param p1, "group"    # Landroid/net/wifi/p2p/WifiP2pGroup;

    .line 223
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    const/4 v2, -0x1

    if-lt v0, v1, :cond_0

    .line 224
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Landroid/net/wifi/p2p/WifiP2pGroup;->getFrequency()I

    move-result v2

    goto :goto_0

    .line 226
    :cond_0
    nop

    .line 223
    :cond_1
    :goto_0
    move v0, v2

    .line 228
    .local v0, "frequency":I
    sget-object v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$resolveWifiBandLabel(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;I)Ljava/lang/String;

    move-result-object v1

    .line 229
    .local v1, "bandLabel":Ljava/lang/String;
    const/4 v2, 0x0

    if-eqz p1, :cond_2

    invoke-virtual {p1}, Landroid/net/wifi/p2p/WifiP2pGroup;->getNetworkName()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_2
    move-object v3, v2

    :goto_1
    const-string v4, ""

    if-nez v3, :cond_3

    move-object v3, v4

    .line 230
    .local v3, "groupName":Ljava/lang/String;
    :cond_3
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$logConnectedP2pFrequency$1;->$wifiP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;

    iget-boolean v5, v5, Landroid/net/wifi/p2p/WifiP2pInfo;->isGroupOwner:Z

    .line 231
    .local v5, "isGroupOwner":Z
    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$logConnectedP2pFrequency$1;->$wifiP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;

    iget-object v6, v6, Landroid/net/wifi/p2p/WifiP2pInfo;->groupOwnerAddress:Ljava/net/InetAddress;

    if-eqz v6, :cond_4

    invoke-virtual {v6}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v2

    :cond_4
    if-nez v2, :cond_5

    goto :goto_2

    :cond_5
    move-object v4, v2

    :goto_2
    move-object v2, v4

    .line 233
    .local v2, "ownerAddress":Ljava/lang/String;
    nop

    .line 234
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "P2P connected source="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$logConnectedP2pFrequency$1;->$source:Ljava/lang/String;

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " isGroupOwner="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " ownerAddress="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, " frequency="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 235
    nop

    .line 234
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 235
    nop

    .line 234
    const-string v6, " band="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 235
    nop

    .line 234
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 235
    nop

    .line 234
    const-string v6, " groupName="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 235
    nop

    .line 234
    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    .line 232
    const-string v6, "WifiP2PClientService"

    invoke-static {v6, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 237
    return-void
.end method
