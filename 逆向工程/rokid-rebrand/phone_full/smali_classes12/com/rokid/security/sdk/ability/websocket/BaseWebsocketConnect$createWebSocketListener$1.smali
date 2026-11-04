.class public final Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;
.super Lokhttp3/WebSocketListener;
.source "BaseWebsocketConnect.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->createWebSocketListener(J)Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBaseWebsocketConnect.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BaseWebsocketConnect.kt\ncom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,419:1\n1#2:420\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000;\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0010\u0003\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J \u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\tH\u0016J \u0010\n\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\tH\u0016J\"\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u000c\u001a\u00020\r2\u0008\u0010\u000e\u001a\u0004\u0018\u00010\u000fH\u0016J\u0018\u0010\u0010\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0011\u001a\u00020\tH\u0016J\u0018\u0010\u0010\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0012\u001a\u00020\u0013H\u0016J\u0018\u0010\u0014\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u000e\u001a\u00020\u000fH\u0016\u00a8\u0006\u0015"
    }
    d2 = {
        "com/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1",
        "Lokhttp3/WebSocketListener;",
        "onClosed",
        "",
        "webSocket",
        "Lokhttp3/WebSocket;",
        "code",
        "",
        "reason",
        "",
        "onClosing",
        "onFailure",
        "t",
        "",
        "response",
        "Lokhttp3/Response;",
        "onMessage",
        "text",
        "bytes",
        "Lokio/ByteString;",
        "onOpen",
        "sdk-common-ability_release"
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
.field final synthetic $generation:J

.field final synthetic this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;J)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    .param p2, "$generation"    # J

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    iput-wide p2, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->$generation:J

    .line 216
    invoke-direct {p0}, Lokhttp3/WebSocketListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed(Lokhttp3/WebSocket;ILjava/lang/String;)V
    .locals 3
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "code"    # I
    .param p3, "reason"    # Ljava/lang/String;

    const-string/jumbo v0, "webSocket"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "reason"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 218
    invoke-super {p0, p1, p2, p3}, Lokhttp3/WebSocketListener;->onClosed(Lokhttp3/WebSocket;ILjava/lang/String;)V

    .line 219
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    iget-wide v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->$generation:J

    invoke-static {v0, p1, v1, v2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isCurrentConnection(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/WebSocket;J)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 220
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$setMWebSocket$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/WebSocket;)V

    .line 221
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getTAG$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "WebSocket\u5df2\u5173\u95ed - "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 222
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isConnected$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 223
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isClosed$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_1

    .line 224
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getTAG$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u9700\u8981\u91cd\u8fde -"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 226
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getServerUrl()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .line 420
    .local v0, "it":Ljava/lang/String;
    const/4 v2, 0x0

    .line 226
    .local v2, "$i$a$-let-BaseWebsocketConnect$createWebSocketListener$1$onClosed$1":I
    invoke-static {v1, v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$doReconnect(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Ljava/lang/String;)V

    .end local v0    # "it":Ljava/lang/String;
    .end local v2    # "$i$a$-let-BaseWebsocketConnect$createWebSocketListener$1$onClosed$1":I
    goto :goto_0

    .line 228
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getWebSocketCallback$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-interface {v0}, Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;->onClosed()V

    .line 230
    :cond_2
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-virtual {v0, p2, p3}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->onClosed(ILjava/lang/String;)V

    .line 231
    return-void
.end method

.method public onClosing(Lokhttp3/WebSocket;ILjava/lang/String;)V
    .locals 3
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "code"    # I
    .param p3, "reason"    # Ljava/lang/String;

    const-string/jumbo v0, "webSocket"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "reason"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 234
    invoke-super {p0, p1, p2, p3}, Lokhttp3/WebSocketListener;->onClosing(Lokhttp3/WebSocket;ILjava/lang/String;)V

    .line 235
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    iget-wide v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->$generation:J

    invoke-static {v0, p1, v1, v2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isCurrentConnection(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/WebSocket;J)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 236
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getTAG$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "WebSocket\u6b63\u5728\u5173\u95ed code:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " reasonChars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 237
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getWebSocketCallback$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;->onClosing()V

    .line 238
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-virtual {v0, p2, p3}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->onClosing(ILjava/lang/String;)V

    .line 239
    return-void
.end method

.method public onFailure(Lokhttp3/WebSocket;Ljava/lang/Throwable;Lokhttp3/Response;)V
    .locals 3
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "t"    # Ljava/lang/Throwable;
    .param p3, "response"    # Lokhttp3/Response;

    const-string/jumbo v0, "webSocket"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "t"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 242
    invoke-super {p0, p1, p2, p3}, Lokhttp3/WebSocketListener;->onFailure(Lokhttp3/WebSocket;Ljava/lang/Throwable;Lokhttp3/Response;)V

    .line 243
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    iget-wide v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->$generation:J

    invoke-static {v0, p1, v1, v2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isCurrentConnection(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/WebSocket;J)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 244
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$setMWebSocket$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/WebSocket;)V

    .line 245
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getTAG$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "WebSocket\u8fde\u63a5\u5931\u8d25 type="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " code="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz p3, :cond_1

    invoke-virtual {p3}, Lokhttp3/Response;->code()I

    move-result v2

    goto :goto_0

    :cond_1
    const/4 v2, -0x1

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 246
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    const-string v1, "Ended"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->setMEventStatus(Ljava/lang/String;)V

    .line 247
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isConnected$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 248
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isClosed$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_2

    .line 250
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->getServerUrl()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .line 420
    .local v0, "it":Ljava/lang/String;
    const/4 v2, 0x0

    .line 250
    .local v2, "$i$a$-let-BaseWebsocketConnect$createWebSocketListener$1$onFailure$1":I
    invoke-static {v1, v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$doReconnect(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Ljava/lang/String;)V

    .end local v0    # "it":Ljava/lang/String;
    .end local v2    # "$i$a$-let-BaseWebsocketConnect$createWebSocketListener$1$onFailure$1":I
    goto :goto_1

    .line 252
    :cond_2
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getWebSocketCallback$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-interface {v0}, Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;->onFailure()V

    .line 254
    :cond_3
    :goto_1
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-virtual {v0, p2, p3}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->onFailure(Ljava/lang/Throwable;Lokhttp3/Response;)V

    .line 256
    return-void
.end method

.method public onMessage(Lokhttp3/WebSocket;Ljava/lang/String;)V
    .locals 3
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "text"    # Ljava/lang/String;

    const-string/jumbo v0, "webSocket"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "text"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 259
    invoke-super {p0, p1, p2}, Lokhttp3/WebSocketListener;->onMessage(Lokhttp3/WebSocket;Ljava/lang/String;)V

    .line 260
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    iget-wide v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->$generation:J

    invoke-static {v0, p1, v1, v2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isCurrentConnection(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/WebSocket;J)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 261
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getTAG$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "WebSocket message received textChars="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 262
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getWebSocketCallback$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {v0, p2}, Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;->onMessage(Ljava/lang/String;)V

    .line 264
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->onMessage(Ljava/lang/String;)V

    .line 266
    return-void
.end method

.method public onMessage(Lokhttp3/WebSocket;Lokio/ByteString;)V
    .locals 3
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "bytes"    # Lokio/ByteString;

    const-string/jumbo v0, "webSocket"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "bytes"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 269
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    iget-wide v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->$generation:J

    invoke-static {v0, p1, v1, v2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isCurrentConnection(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/WebSocket;J)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 270
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->onMessage(Lokio/ByteString;)V

    .line 271
    return-void
.end method

.method public onOpen(Lokhttp3/WebSocket;Lokhttp3/Response;)V
    .locals 4
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "response"    # Lokhttp3/Response;

    const-string/jumbo v0, "webSocket"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "response"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 275
    invoke-super {p0, p1, p2}, Lokhttp3/WebSocketListener;->onOpen(Lokhttp3/WebSocket;Lokhttp3/Response;)V

    .line 276
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isClosed$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_2

    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->$generation:J

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getConnectionGeneration$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/util/concurrent/atomic/AtomicLong;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    goto :goto_0

    .line 280
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getTAG$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "WebSocket\u8fde\u63a5\u6210\u529f - "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 281
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0, p1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$setMWebSocket$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/WebSocket;)V

    .line 282
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$isConnected$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 283
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getReconnectBackoff$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->reset()V

    .line 284
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->access$getWebSocketCallback$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;->onOpen()V

    .line 285
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;->this$0:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->onOpen(Lokhttp3/Response;)V

    .line 286
    return-void

    .line 277
    :cond_2
    :goto_0
    invoke-interface {p1}, Lokhttp3/WebSocket;->cancel()V

    .line 278
    return-void
.end method
