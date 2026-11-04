.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;
.super Lorg/java_websocket/server/WebSocketServer;
.source "SocketServerChannel.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->initWebsocketServer(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000O\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J(\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000bH\u0016J\u001e\u0010\u000c\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\n\u0010\r\u001a\u00060\u000ej\u0002`\u000fH\u0016J\u0018\u0010\u0010\u001a\u00020\u00032\u0006\u0010\u0011\u001a\u00020\u00052\u0006\u0010\u0012\u001a\u00020\u0013H\u0016J\u0018\u0010\u0010\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0014\u001a\u00020\tH\u0016J\u0018\u0010\u0015\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0016\u001a\u00020\u0017H\u0016J\u0008\u0010\u0018\u001a\u00020\u0003H\u0016J\u0018\u0010\u0019\u001a\u00020\u00032\u0006\u0010\u0011\u001a\u00020\u00052\u0006\u0010\u001a\u001a\u00020\u001bH\u0016J\u0018\u0010\u001c\u001a\u00020\u00032\u0006\u0010\u0011\u001a\u00020\u00052\u0006\u0010\u001a\u001a\u00020\u001bH\u0016\u00a8\u0006\u001d"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1",
        "Lorg/java_websocket/server/WebSocketServer;",
        "onClose",
        "",
        "webSocket",
        "Lorg/java_websocket/WebSocket;",
        "code",
        "",
        "reason",
        "",
        "remote",
        "",
        "onError",
        "e",
        "Ljava/lang/Exception;",
        "Lkotlin/Exception;",
        "onMessage",
        "conn",
        "bytes",
        "Ljava/nio/ByteBuffer;",
        "s",
        "onOpen",
        "clientHandshake",
        "Lorg/java_websocket/handshake/ClientHandshake;",
        "onStart",
        "onWebsocketPing",
        "f",
        "Lorg/java_websocket/framing/Framedata;",
        "onWebsocketPong",
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
.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;Ljava/net/InetSocketAddress;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;
    .param p2, "$super_call_param$1"    # Ljava/net/InetSocketAddress;

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    .line 33
    invoke-direct {p0, p2}, Lorg/java_websocket/server/WebSocketServer;-><init>(Ljava/net/InetSocketAddress;)V

    return-void
.end method


# virtual methods
.method public onClose(Lorg/java_websocket/WebSocket;ILjava/lang/String;Z)V
    .locals 5
    .param p1, "webSocket"    # Lorg/java_websocket/WebSocket;
    .param p2, "code"    # I
    .param p3, "reason"    # Ljava/lang/String;
    .param p4, "remote"    # Z

    const-string v0, "webSocket"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "reason"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 69
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getMWebSocket$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Lorg/java_websocket/WebSocket;

    move-result-object v0

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    const-string v1, ", remote = "

    const-string v2, ", reason = "

    if-eqz v0, :cond_0

    .line 70
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Ljava/lang/String;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "is mWebSocket = true --- onClose: \u5173\u95ed socket  code = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 71
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$setMWebSocket$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;Lorg/java_websocket/WebSocket;)V

    .line 72
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getMListener$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;->onClose()V

    goto :goto_0

    .line 74
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Ljava/lang/String;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " is mWebSocket = false --- onClose: \u5173\u95ed socket  code = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 76
    :cond_1
    :goto_0
    return-void
.end method

.method public onError(Lorg/java_websocket/WebSocket;Ljava/lang/Exception;)V
    .locals 3
    .param p1, "webSocket"    # Lorg/java_websocket/WebSocket;
    .param p2, "e"    # Ljava/lang/Exception;

    const-string v0, "e"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 101
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " onError:  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 102
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getMListener$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;->onError(Ljava/lang/Exception;)V

    .line 103
    :cond_0
    return-void
.end method

.method public onMessage(Lorg/java_websocket/WebSocket;Ljava/lang/String;)V
    .locals 2
    .param p1, "webSocket"    # Lorg/java_websocket/WebSocket;
    .param p2, "s"    # Ljava/lang/String;

    const-string v0, "webSocket"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "s"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 82
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " onMessage: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 83
    return-void
.end method

.method public onMessage(Lorg/java_websocket/WebSocket;Ljava/nio/ByteBuffer;)V
    .locals 3
    .param p1, "conn"    # Lorg/java_websocket/WebSocket;
    .param p2, "bytes"    # Ljava/nio/ByteBuffer;

    const-string v0, "conn"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "bytes"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 90
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u6d88\u606f\u957f\u5ea6  : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 91
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getMListener$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;->onMessage(Ljava/nio/ByteBuffer;)V

    .line 94
    :cond_0
    return-void
.end method

.method public onOpen(Lorg/java_websocket/WebSocket;Lorg/java_websocket/handshake/ClientHandshake;)V
    .locals 2
    .param p1, "webSocket"    # Lorg/java_websocket/WebSocket;
    .param p2, "clientHandshake"    # Lorg/java_websocket/handshake/ClientHandshake;

    const-string v0, "webSocket"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientHandshake"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 57
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " onOpen: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 58
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$setMWebSocket$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;Lorg/java_websocket/WebSocket;)V

    .line 59
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getMListener$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;->onOpen()V

    .line 60
    :cond_0
    return-void
.end method

.method public onStart()V
    .locals 2

    .line 109
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "WebSocket server started successfully"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 110
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getMListener$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;->onStart()V

    .line 111
    :cond_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$setServerStarted$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;Z)V

    .line 112
    return-void
.end method

.method public onWebsocketPing(Lorg/java_websocket/WebSocket;Lorg/java_websocket/framing/Framedata;)V
    .locals 3
    .param p1, "conn"    # Lorg/java_websocket/WebSocket;
    .param p2, "f"    # Lorg/java_websocket/framing/Framedata;

    const-string v0, "conn"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "f"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 40
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Received Ping from "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-interface {p1}, Lorg/java_websocket/WebSocket;->getRemoteSocketAddress()Ljava/net/InetSocketAddress;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 41
    invoke-super {p0, p1, p2}, Lorg/java_websocket/server/WebSocketServer;->onWebsocketPing(Lorg/java_websocket/WebSocket;Lorg/java_websocket/framing/Framedata;)V

    .line 42
    return-void
.end method

.method public onWebsocketPong(Lorg/java_websocket/WebSocket;Lorg/java_websocket/framing/Framedata;)V
    .locals 3
    .param p1, "conn"    # Lorg/java_websocket/WebSocket;
    .param p2, "f"    # Lorg/java_websocket/framing/Framedata;

    const-string v0, "conn"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "f"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 49
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Pong from "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-interface {p1}, Lorg/java_websocket/WebSocket;->getRemoteSocketAddress()Ljava/net/InetSocketAddress;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 50
    invoke-super {p0, p1, p2}, Lorg/java_websocket/server/WebSocketServer;->onWebsocketPong(Lorg/java_websocket/WebSocket;Lorg/java_websocket/framing/Framedata;)V

    .line 51
    return-void
.end method
