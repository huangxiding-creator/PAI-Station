.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;
.super Lorg/java_websocket/client/WebSocketClient;
.source "SocketClientChannel.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x11
    name = "MyWebSocketClient"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\\\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0008\u0086\u0004\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J \u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eH\u0016J\u0014\u0010\u000f\u001a\u00020\u00082\n\u0010\u0010\u001a\u00060\u0011j\u0002`\u0012H\u0016J\u0010\u0010\u0013\u001a\u00020\u00082\u0006\u0010\u0014\u001a\u00020\u0015H\u0016J\u0010\u0010\u0013\u001a\u00020\u00082\u0006\u0010\u0016\u001a\u00020\u000cH\u0016J\u0010\u0010\u0017\u001a\u00020\u00082\u0006\u0010\u0018\u001a\u00020\u0019H\u0016J\u0018\u0010\u001a\u001a\u00020\u00082\u0006\u0010\u001b\u001a\u00020\u001c2\u0006\u0010\u001d\u001a\u00020\u001eH\u0016J\u0018\u0010\u001f\u001a\u00020\u00082\u0006\u0010\u001b\u001a\u00020\u001c2\u0006\u0010\u001d\u001a\u00020\u001eH\u0016J\u0010\u0010 \u001a\u00020\u00082\u0008\u0010!\u001a\u0004\u0018\u00010\u0006R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\""
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;",
        "Lorg/java_websocket/client/WebSocketClient;",
        "serverURI",
        "Ljava/net/URI;",
        "(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;Ljava/net/URI;)V",
        "mListener",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;",
        "onClose",
        "",
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
        "buffer",
        "Ljava/nio/ByteBuffer;",
        "s",
        "onOpen",
        "serverHandshake",
        "Lorg/java_websocket/handshake/ServerHandshake;",
        "onWebsocketPing",
        "conn",
        "Lorg/java_websocket/WebSocket;",
        "f",
        "Lorg/java_websocket/framing/Framedata;",
        "onWebsocketPong",
        "setSocketServerListener",
        "listener",
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
.field private mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;


# direct methods
.method public constructor <init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;Ljava/net/URI;)V
    .locals 1
    .param p1, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;
    .param p2, "serverURI"    # Ljava/net/URI;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/net/URI;",
            ")V"
        }
    .end annotation

    const-string v0, "serverURI"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 68
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-direct {p0, p2}, Lorg/java_websocket/client/WebSocketClient;-><init>(Ljava/net/URI;)V

    return-void
.end method


# virtual methods
.method public onClose(ILjava/lang/String;Z)V
    .locals 3
    .param p1, "code"    # I
    .param p2, "reason"    # Ljava/lang/String;
    .param p3, "remote"    # Z

    const-string v0, "reason"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 117
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " onClose: code = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", reason = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", remote = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 118
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->access$setConnecting$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;Z)V

    .line 119
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;->onClose()V

    .line 120
    :cond_0
    return-void
.end method

.method public onError(Ljava/lang/Exception;)V
    .locals 3
    .param p1, "e"    # Ljava/lang/Exception;

    const-string v0, "e"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 131
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " onError: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 132
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->access$setConnecting$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;Z)V

    .line 133
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;->onError(Ljava/lang/Exception;)V

    .line 134
    :cond_0
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 2
    .param p1, "s"    # Ljava/lang/String;

    const-string v0, "s"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 104
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " onMessage:  "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 106
    return-void
.end method

.method public onMessage(Ljava/nio/ByteBuffer;)V
    .locals 2
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 109
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " onMessage: "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 110
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;->onMessage(Ljava/nio/ByteBuffer;)V

    .line 111
    :cond_0
    return-void
.end method

.method public onOpen(Lorg/java_websocket/handshake/ServerHandshake;)V
    .locals 3
    .param p1, "serverHandshake"    # Lorg/java_websocket/handshake/ServerHandshake;

    const-string v0, "serverHandshake"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 98
    const/4 v0, 0x0

    new-array v1, v0, [Ljava/lang/Object;

    const-string v2, " \u6253\u5f00 socket  onOpen: "

    invoke-static {v2, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 99
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->access$setConnecting$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;Z)V

    .line 100
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;->onOpen()V

    .line 101
    :cond_0
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

    .line 81
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;)Ljava/lang/String;

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

    .line 82
    invoke-super {p0, p1, p2}, Lorg/java_websocket/client/WebSocketClient;->onWebsocketPing(Lorg/java_websocket/WebSocket;Lorg/java_websocket/framing/Framedata;)V

    .line 83
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

    .line 90
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;)Ljava/lang/String;

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

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 91
    invoke-super {p0, p1, p2}, Lorg/java_websocket/client/WebSocketClient;->onWebsocketPong(Lorg/java_websocket/WebSocket;Lorg/java_websocket/framing/Framedata;)V

    .line 92
    return-void
.end method

.method public final setSocketServerListener(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    .line 73
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    .line 74
    return-void
.end method
