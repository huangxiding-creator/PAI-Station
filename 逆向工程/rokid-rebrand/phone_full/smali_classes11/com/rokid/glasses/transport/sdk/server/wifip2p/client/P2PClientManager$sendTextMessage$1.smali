.class final Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$sendTextMessage$1;
.super Lkotlin/jvm/internal/Lambda;
.source "P2PClientManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->sendTextMessage(Ljava/lang/String;)V
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
.field final synthetic $message:Ljava/lang/String;

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;


# direct methods
.method constructor <init>(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$sendTextMessage$1;->$message:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$sendTextMessage$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 403
    move-object v0, p1

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pInfo;

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$sendTextMessage$1;->invoke(Landroid/net/wifi/p2p/WifiP2pInfo;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 4
    .param p1, "it"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 404
    if-eqz p1, :cond_0

    iget-boolean v0, p1, Landroid/net/wifi/p2p/WifiP2pInfo;->groupFormed:Z

    if-eqz v0, :cond_0

    .line 405
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$sendTextMessage$1;->$message:Ljava/lang/String;

    sget-object v1, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    const-string v1, "this as java.lang.String).getBytes(charset)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 406
    .local v0, "textBytes":[B
    array-length v1, v0

    add-int/lit8 v1, v1, 0x1

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 407
    .local v1, "buffer":Ljava/nio/ByteBuffer;
    sget-object v2, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->TEXT_MESSAGE:Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/bean/DataType;->getValue()B

    move-result v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    .line 408
    invoke-virtual {v1, v0}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 409
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 410
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$sendTextMessage$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getMSocketChannel$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    move-result-object v2

    const-string v3, "buffer"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->sendData(Ljava/nio/ByteBuffer;)V

    .end local v0    # "textBytes":[B
    .end local v1    # "buffer":Ljava/nio/ByteBuffer;
    goto :goto_0

    .line 412
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$sendTextMessage$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "WIFI Direct \u7fa4\u7ec4\u4e2d\u6ca1\u6709\u8bbe\u5907"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 414
    :goto_0
    return-void
.end method
