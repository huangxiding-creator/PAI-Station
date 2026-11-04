.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;
.super Ljava/lang/Object;
.source "SocketClientChannel.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000<\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0018\u00002\u00020\u0001:\u0001\u0017B\u0005\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\u0005\u001a\u00020\u0004J\u0006\u0010\u0010\u001a\u00020\u0007J\u0006\u0010\u0006\u001a\u00020\u0007J\u0006\u0010\u0011\u001a\u00020\u000fJ\u000e\u0010\u0012\u001a\u00020\u000f2\u0006\u0010\u0013\u001a\u00020\u0014J\u000e\u0010\u0015\u001a\u00020\u000f2\u0006\u0010\u0016\u001a\u00020\tR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0008\u001a\u0004\u0018\u00010\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\n\u001a\u0008\u0018\u00010\u000bR\u00020\u0000X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0018"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;",
        "",
        "()V",
        "TAG",
        "",
        "ipAddress",
        "isConnecting",
        "",
        "mListener",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;",
        "mWebSocketClient",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;",
        "port",
        "",
        "connectWebsocketClient",
        "",
        "isConnected",
        "release",
        "sendData",
        "data",
        "Ljava/nio/ByteBuffer;",
        "setSocketServerListener",
        "listener",
        "MyWebSocketClient",
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
.field private final TAG:Ljava/lang/String;

.field private final ipAddress:Ljava/lang/String;

.field private volatile isConnecting:Z

.field private mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

.field private mWebSocketClient:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;

.field private final port:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    const-string v0, "SocketClientChannel "

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->TAG:Ljava/lang/String;

    .line 17
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->getPort()I

    move-result v0

    iput v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->port:I

    .line 15
    return-void
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;

    .line 15
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$setConnecting$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;
    .param p1, "<set-?>"    # Z

    .line 15
    iput-boolean p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->isConnecting:Z

    return-void
.end method


# virtual methods
.method public final connectWebsocketClient(Ljava/lang/String;)V
    .locals 4
    .param p1, "ipAddress"    # Ljava/lang/String;

    const-string v0, "ipAddress"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    nop

    .line 26
    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/net/URI;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ws://"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x3a

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->port:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/net/URI;-><init>(Ljava/lang/String;)V

    .line 27
    .local v1, "url":Ljava/net/URI;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "connectWebsocketClient url = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-array v3, v0, [Ljava/lang/Object;

    invoke-static {v2, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 28
    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->isConnecting:Z

    .line 29
    new-instance v2, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;

    invoke-direct {v2, p0, v1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;Ljava/net/URI;)V

    iput-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->mWebSocketClient:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;

    .line 30
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->mWebSocketClient:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;

    if-eqz v2, :cond_0

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    invoke-virtual {v2, v3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->setSocketServerListener(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;)V

    .line 32
    :cond_0
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->mWebSocketClient:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->connect()V
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 33
    .end local v1    # "url":Ljava/net/URI;
    :catch_0
    move-exception v1

    .line 34
    .local v1, "e":Ljava/net/URISyntaxException;
    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->isConnecting:Z

    .line 35
    invoke-virtual {v1}, Ljava/net/URISyntaxException;->printStackTrace()V

    .line 37
    .end local v1    # "e":Ljava/net/URISyntaxException;
    :cond_1
    :goto_0
    return-void
.end method

.method public final isConnected()Z
    .locals 1

    .line 52
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->mWebSocketClient:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->isOpen()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final isConnecting()Z
    .locals 1

    .line 56
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->isConnecting:Z

    return v0
.end method

.method public final release()V
    .locals 1

    .line 61
    nop

    .line 62
    :try_start_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->mWebSocketClient:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 63
    :catch_0
    move-exception v0

    .line 64
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 66
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    return-void
.end method

.method public final sendData(Ljava/nio/ByteBuffer;)V
    .locals 2
    .param p1, "data"    # Ljava/nio/ByteBuffer;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 44
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->mWebSocketClient:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->mWebSocketClient:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->isOpen()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 45
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->mWebSocketClient:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;

    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel$MyWebSocketClient;->send(Ljava/nio/ByteBuffer;)V

    goto :goto_0

    .line 47
    :cond_0
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " mWebSocketClient \u5f02\u5e38 "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 49
    :cond_1
    :goto_0
    return-void
.end method

.method public final setSocketServerListener(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 40
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/SocketClientChannel;->mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    .line 41
    return-void
.end method
