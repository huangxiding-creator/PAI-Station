.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;
.super Ljava/lang/Object;
.source "SocketServerChannel.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nSocketServerChannel.kt\nKotlin\n*S Kotlin\n*F\n+ 1 SocketServerChannel.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,193:1\n1#2:194\n1855#3,2:195\n*S KotlinDebug\n*F\n+ 1 SocketServerChannel.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel\n*L\n168#1:195,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000H\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\t\n\u0002\u0008\u0002\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u000f\u001a\u00020\u0010J\u000e\u0010\u0011\u001a\u00020\u00102\u0006\u0010\u0012\u001a\u00020\u0004J\u0006\u0010\u0013\u001a\u00020\u0006J\u0006\u0010\u0014\u001a\u00020\u0006J\u0006\u0010\u0015\u001a\u00020\u0006J\u000e\u0010\u0016\u001a\u00020\u00102\u0006\u0010\u0017\u001a\u00020\u0018J\u000e\u0010\u0019\u001a\u00020\u00102\u0006\u0010\u001a\u001a\u00020\u0008J\u001b\u0010\u001b\u001a\u00020\u00062\u0008\u0008\u0002\u0010\u001c\u001a\u00020\u001dH\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u001eR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\r\u001a\u0004\u0018\u00010\u000eX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u001f"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;",
        "",
        "()V",
        "TAG",
        "",
        "isServerStarted",
        "",
        "mListener",
        "Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;",
        "mWebSocket",
        "Lorg/java_websocket/WebSocket;",
        "port",
        "",
        "webSocketServer",
        "Lorg/java_websocket/server/WebSocketServer;",
        "close",
        "",
        "initWebsocketServer",
        "ipAddress",
        "isConnected",
        "isPortAvailable",
        "isServerRunning",
        "sendData",
        "data",
        "Ljava/nio/ByteBuffer;",
        "setSocketServerListener",
        "listener",
        "waitForPortToBeFree",
        "timeoutMs",
        "",
        "(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;",
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

.field private isServerStarted:Z

.field private mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

.field private mWebSocket:Lorg/java_websocket/WebSocket;

.field private final port:I

.field private webSocketServer:Lorg/java_websocket/server/WebSocketServer;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    const-string v0, "SocketServerChannel "

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->TAG:Ljava/lang/String;

    .line 22
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/engine/EngineServiceImpl;->getPort()I

    move-result v0

    iput v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->port:I

    .line 18
    return-void
.end method

.method public static final synthetic access$getMListener$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    .line 18
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    return-object v0
.end method

.method public static final synthetic access$getMWebSocket$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Lorg/java_websocket/WebSocket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    .line 18
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->mWebSocket:Lorg/java_websocket/WebSocket;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    .line 18
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$setMWebSocket$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;Lorg/java_websocket/WebSocket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;
    .param p1, "<set-?>"    # Lorg/java_websocket/WebSocket;

    .line 18
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->mWebSocket:Lorg/java_websocket/WebSocket;

    return-void
.end method

.method public static final synthetic access$setServerStarted$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;
    .param p1, "<set-?>"    # Z

    .line 18
    iput-boolean p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->isServerStarted:Z

    return-void
.end method

.method public static final synthetic access$waitForPortToBeFree(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;JLkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;
    .param p1, "timeoutMs"    # J
    .param p3, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 18
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->waitForPortToBeFree(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method private final waitForPortToBeFree(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/lang/Boolean;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;

    if-eqz v0, :cond_0

    move-object v0, p3

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;

    iget v1, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->label:I

    sub-int/2addr p3, v2

    iput p3, v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;

    invoke-direct {v0, p0, p3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p3, v0

    .local p3, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v0, p3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->result:Ljava/lang/Object;

    .local v0, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 147
    iget v2, p3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->label:I

    packed-switch v2, :pswitch_data_0

    .end local v0    # "$result":Ljava/lang/Object;
    .end local p3    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .restart local v0    # "$result":Ljava/lang/Object;
    .restart local p3    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    iget-wide p1, p3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->J$1:J

    .local p1, "startTime":J
    iget-wide v2, p3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->J$0:J

    .local v2, "timeoutMs":J
    iget-object v4, p3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->L$0:Ljava/lang/Object;

    check-cast v4, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;

    .local v4, "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_2

    .end local v2    # "timeoutMs":J
    .end local v4    # "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;
    .end local p1    # "startTime":J
    :pswitch_1
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v2, p0

    .line 148
    .local v2, "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;
    .local p1, "timeoutMs":J
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    move-wide v7, v3

    move-object v4, v2

    move-wide v2, p1

    move-wide p1, v7

    .line 149
    .local v2, "timeoutMs":J
    .restart local v4    # "this":Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;
    .local p1, "startTime":J
    :goto_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    sub-long/2addr v5, p1

    cmp-long v5, v5, v2

    if-gez v5, :cond_3

    .line 150
    invoke-virtual {v4}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->isPortAvailable()Z

    move-result v5

    const/4 v6, 0x1

    if-eqz v5, :cond_1

    invoke-static {v6}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v1

    return-object v1

    .line 151
    :cond_1
    iput-object v4, p3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->L$0:Ljava/lang/Object;

    iput-wide v2, p3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->J$0:J

    iput-wide p1, p3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->J$1:J

    iput v6, p3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$waitForPortToBeFree$1;->label:I

    const-wide/16 v5, 0x64

    invoke-static {v5, v6, p3}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v5

    if-ne v5, v1, :cond_2

    .line 147
    return-object v1

    .line 151
    :cond_2
    :goto_2
    goto :goto_1

    .line 153
    :cond_3
    const/4 v1, 0x0

    invoke-static {v1}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v1

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic waitForPortToBeFree$default(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;JLkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 147
    and-int/lit8 p4, p4, 0x1

    if-eqz p4, :cond_0

    const-wide/16 p1, 0xbb8

    :cond_0
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->waitForPortToBeFree(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final close()V
    .locals 1

    .line 157
    nop

    .line 158
    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->isServerStarted:Z

    .line 159
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->webSocketServer:Lorg/java_websocket/server/WebSocketServer;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lorg/java_websocket/server/WebSocketServer;->stop()V

    .line 160
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->webSocketServer:Lorg/java_websocket/server/WebSocketServer;

    .line 161
    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->mWebSocket:Lorg/java_websocket/WebSocket;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 162
    :catch_0
    move-exception v0

    .line 163
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 165
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public final initWebsocketServer(Ljava/lang/String;)V
    .locals 6
    .param p1, "ipAddress"    # Ljava/lang/String;

    const-string v0, "ipAddress"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-nez v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    move v0, v2

    :goto_0
    const-string v3, " port = "

    if-eqz v0, :cond_1

    .line 29
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " initWebsocketServer: ipAddress = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->port:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 30
    return-void

    .line 32
    :cond_1
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "initWebsocketServer: ipAddress = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->port:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 33
    new-instance v0, Ljava/net/InetSocketAddress;

    iget v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->port:I

    invoke-direct {v0, p1, v3}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;

    invoke-direct {v3, p0, v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel$initWebsocketServer$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;Ljava/net/InetSocketAddress;)V

    check-cast v3, Lorg/java_websocket/server/WebSocketServer;

    iput-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->webSocketServer:Lorg/java_websocket/server/WebSocketServer;

    .line 115
    nop

    .line 116
    :try_start_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->webSocketServer:Lorg/java_websocket/server/WebSocketServer;

    if-nez v0, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {v0, v1}, Lorg/java_websocket/server/WebSocketServer;->setReuseAddr(Z)V

    .line 119
    :goto_1
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->webSocketServer:Lorg/java_websocket/server/WebSocketServer;

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Lorg/java_websocket/server/WebSocketServer;->start()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 120
    :catch_0
    move-exception v0

    .line 121
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 122
    iput-boolean v2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->isServerStarted:Z

    .line 125
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_3
    :goto_2
    return-void
.end method

.method public final isConnected()Z
    .locals 7

    .line 168
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->webSocketServer:Lorg/java_websocket/server/WebSocketServer;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lorg/java_websocket/server/WebSocketServer;->getConnections()Ljava/util/Collection;

    move-result-object v0

    if-eqz v0, :cond_2

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 195
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lorg/java_websocket/WebSocket;

    .local v4, "it":Lorg/java_websocket/WebSocket;
    const/4 v5, 0x0

    .line 169
    .local v5, "$i$a$-forEach-SocketServerChannel$isConnected$1":I
    invoke-interface {v4}, Lorg/java_websocket/WebSocket;->isOpen()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 170
    const/4 v2, 0x1

    return v2

    .line 172
    :cond_0
    nop

    .line 195
    .end local v4    # "it":Lorg/java_websocket/WebSocket;
    .end local v5    # "$i$a$-forEach-SocketServerChannel$isConnected$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 196
    :cond_1
    nop

    .line 173
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method public final isPortAvailable()Z
    .locals 3

    .line 140
    nop

    .line 141
    :try_start_0
    new-instance v0, Ljava/net/ServerSocket;

    iget v1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->port:I

    invoke-direct {v0, v1}, Ljava/net/ServerSocket;-><init>(I)V

    check-cast v0, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v1, v0

    check-cast v1, Ljava/net/ServerSocket;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 194
    .local v1, "it":Ljava/net/ServerSocket;
    const/4 v2, 0x0

    .line 141
    .local v2, "$i$a$-use-SocketServerChannel$isPortAvailable$1":I
    nop

    .end local v1    # "it":Ljava/net/ServerSocket;
    .end local v2    # "$i$a$-use-SocketServerChannel$isPortAvailable$1":I
    const/4 v1, 0x0

    :try_start_2
    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    const/4 v0, 0x1

    goto :goto_0

    :catchall_0
    move-exception v1

    :try_start_3
    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :catchall_1
    move-exception v2

    :try_start_4
    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v2
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    .line 142
    :catch_0
    move-exception v0

    .line 143
    .local v0, "e":Ljava/io/IOException;
    const/4 v1, 0x0

    move v0, v1

    .line 140
    .end local v0    # "e":Ljava/io/IOException;
    :goto_0
    return v0
.end method

.method public final isServerRunning()Z
    .locals 1

    .line 178
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->isServerStarted:Z

    if-eqz v0, :cond_0

    .line 179
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->isPortAvailable()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 178
    :goto_0
    return v0
.end method

.method public final sendData(Ljava/nio/ByteBuffer;)V
    .locals 2
    .param p1, "data"    # Ljava/nio/ByteBuffer;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 132
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->mWebSocket:Lorg/java_websocket/WebSocket;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->mWebSocket:Lorg/java_websocket/WebSocket;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-interface {v0}, Lorg/java_websocket/WebSocket;->isOpen()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 133
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->mWebSocket:Lorg/java_websocket/WebSocket;

    if-eqz v0, :cond_1

    invoke-interface {v0, p1}, Lorg/java_websocket/WebSocket;->send(Ljava/nio/ByteBuffer;)V

    goto :goto_0

    .line 135
    :cond_0
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, " mWebSocket \u5f02\u5e38 "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 137
    :cond_1
    :goto_0
    return-void
.end method

.method public final setSocketServerListener(Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 128
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/SocketServerChannel;->mListener:Lcom/rokid/glasses/transport/sdk/server/wifip2p/groupowner/ISocketServerListener;

    .line 129
    return-void
.end method
