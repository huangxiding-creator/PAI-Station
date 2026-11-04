.class final Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startReceiveFile$1$1;
.super Lkotlin/jvm/internal/Lambda;
.source "FileOperater.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startReceiveFile$1;->invoke(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
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
        "it",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
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
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startReceiveFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 272
    move-object v0, p1

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pInfo;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startReceiveFile$1$1;->invoke(Landroid/net/wifi/p2p/WifiP2pInfo;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 4
    .param p1, "it"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 273
    if-nez p1, :cond_0

    .line 274
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startReceiveFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " startReceiveFile:  requestConnectionInfo is null"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 275
    return-void

    .line 277
    :cond_0
    iget-object v0, p1, Landroid/net/wifi/p2p/WifiP2pInfo;->groupOwnerAddress:Ljava/net/InetAddress;

    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v0

    .line 278
    .local v0, "hostAddress":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    if-eqz v1, :cond_2

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v1, 0x1

    :goto_1
    if-eqz v1, :cond_3

    .line 279
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startReceiveFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " startReceiveFile:  hostAddress = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_2

    .line 281
    :cond_3
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startReceiveFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiver(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;

    move-result-object v1

    const-string v2, "hostAddress"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startReceiveFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;

    invoke-virtual {v1, v0, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiver;->startReceiving(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;)V

    .line 284
    .end local v0    # "hostAddress":Ljava/lang/String;
    :goto_2
    return-void
.end method
