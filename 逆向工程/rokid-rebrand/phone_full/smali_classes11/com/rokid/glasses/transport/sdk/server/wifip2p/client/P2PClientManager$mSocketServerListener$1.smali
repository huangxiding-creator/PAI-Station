.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;
.super Ljava/lang/Object;
.source "P2PClientManager.kt"

# interfaces
.implements Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nP2PClientManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PClientManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,683:1\n1855#2,2:684\n1855#2,2:686\n1855#2,2:688\n*S KotlinDebug\n*F\n+ 1 P2PClientManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1\n*L\n589#1:684,2\n597#1:686,2\n611#1:688,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\'\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016J\u0014\u0010\u0004\u001a\u00020\u00032\n\u0010\u0005\u001a\u00060\u0006j\u0002`\u0007H\u0016J\u0010\u0010\u0008\u001a\u00020\u00032\u0006\u0010\t\u001a\u00020\nH\u0016J\u0008\u0010\u000b\u001a\u00020\u0003H\u0016J\u0008\u0010\u000c\u001a\u00020\u0003H\u0016\u00a8\u0006\r"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;",
        "onClose",
        "",
        "onError",
        "e",
        "Ljava/lang/Exception;",
        "Lkotlin/Exception;",
        "onMessage",
        "buffer",
        "Ljava/nio/ByteBuffer;",
        "onOpen",
        "onStart",
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

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 581
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClose()V
    .locals 7

    .line 595
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "onClose "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 596
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$isConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 597
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 686
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

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    const/4 v6, 0x0

    .line 598
    .local v6, "$i$a$-forEach-P2PClientManager$mSocketServerListener$1$onClose$1":I
    invoke-interface {v5, v4}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;->onWifiP2pEnabled(Z)V

    .line 599
    nop

    .line 686
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    .end local v6    # "$i$a$-forEach-P2PClientManager$mSocketServerListener$1$onClose$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 687
    :cond_0
    nop

    .line 600
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$setConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Z)V

    .line 602
    :cond_1
    return-void
.end method

.method public onError(Ljava/lang/Exception;)V
    .locals 7
    .param p1, "e"    # Ljava/lang/Exception;

    const-string v0, "e"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 609
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "onError "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 610
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$isConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 611
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 688
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

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    const/4 v6, 0x0

    .line 612
    .local v6, "$i$a$-forEach-P2PClientManager$mSocketServerListener$1$onError$1":I
    invoke-interface {v5, v4}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;->onWifiP2pEnabled(Z)V

    .line 613
    nop

    .line 688
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    .end local v6    # "$i$a$-forEach-P2PClientManager$mSocketServerListener$1$onError$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 689
    :cond_0
    nop

    .line 614
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$setConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Z)V

    .line 616
    :cond_1
    return-void
.end method

.method public onMessage(Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 605
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$parseData(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Ljava/nio/ByteBuffer;)V

    .line 606
    return-void
.end method

.method public onOpen()V
    .locals 7

    .line 587
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " onOpen socket\u8fde\u63a5\u6210\u529f"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 588
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$setConnected$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Z)V

    .line 589
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$mSocketServerListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMWifiP2PListeners$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 684
    .local v2, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    const/4 v6, 0x0

    .line 590
    .local v6, "$i$a$-forEach-P2PClientManager$mSocketServerListener$1$onOpen$1":I
    invoke-interface {v5, v1}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;->onWifiP2pEnabled(Z)V

    .line 591
    nop

    .line 684
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;
    .end local v6    # "$i$a$-forEach-P2PClientManager$mSocketServerListener$1$onOpen$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 685
    :cond_0
    nop

    .line 592
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    return-void
.end method

.method public onStart()V
    .locals 0

    .line 584
    return-void
.end method
