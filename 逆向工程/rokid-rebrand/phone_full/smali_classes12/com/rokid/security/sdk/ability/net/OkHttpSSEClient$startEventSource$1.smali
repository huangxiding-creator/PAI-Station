.class public final Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;
.super Lokhttp3/sse/EventSourceListener;
.source "OkHttpSSEClient.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->startEventSource(Lokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;JII)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000/\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0010\u0003\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J,\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u00082\u0008\u0010\t\u001a\u0004\u0018\u00010\u00082\u0006\u0010\n\u001a\u00020\u0008H\u0016J$\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0008\u0010\u000c\u001a\u0004\u0018\u00010\r2\u0008\u0010\u000e\u001a\u0004\u0018\u00010\u000fH\u0016J\u0018\u0010\u0010\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u000e\u001a\u00020\u000fH\u0016\u00a8\u0006\u0011"
    }
    d2 = {
        "com/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1",
        "Lokhttp3/sse/EventSourceListener;",
        "onClosed",
        "",
        "eventSource",
        "Lokhttp3/sse/EventSource;",
        "onEvent",
        "id",
        "",
        "type",
        "data",
        "onFailure",
        "t",
        "",
        "response",
        "Lokhttp3/Response;",
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
.field final synthetic $connectionOpened:Lkotlin/jvm/internal/Ref$BooleanRef;

.field final synthetic $listener:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

.field final synthetic $maxTransientRetries:I

.field final synthetic $request:Lokhttp3/Request;

.field final synthetic $requestId:J

.field final synthetic $retryCount:I

.field final synthetic this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;Lkotlin/jvm/internal/Ref$BooleanRef;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;JIILokhttp3/Request;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;
    .param p2, "$connectionOpened"    # Lkotlin/jvm/internal/Ref$BooleanRef;
    .param p3, "$listener"    # Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;
    .param p4, "$requestId"    # J
    .param p6, "$retryCount"    # I
    .param p7, "$maxTransientRetries"    # I
    .param p8, "$request"    # Lokhttp3/Request;

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$connectionOpened:Lkotlin/jvm/internal/Ref$BooleanRef;

    iput-object p3, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$listener:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    iput-wide p4, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$requestId:J

    iput p6, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$retryCount:I

    iput p7, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$maxTransientRetries:I

    iput-object p8, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$request:Lokhttp3/Request;

    .line 174
    invoke-direct {p0}, Lokhttp3/sse/EventSourceListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed(Lokhttp3/sse/EventSource;)V
    .locals 2
    .param p1, "eventSource"    # Lokhttp3/sse/EventSource;

    const-string v0, "eventSource"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 262
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$isClosed$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 263
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$getTAG$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u8fde\u63a5\u5df2\u5173\u95ed\uff0c\u5ffd\u7565onClosed\u56de\u8c03"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 264
    return-void

    .line 266
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$getTAG$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "SSE\u8fde\u63a5\u5df2\u5173\u95ed"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 267
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$listener:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    invoke-interface {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;->onClosed()V

    .line 268
    return-void
.end method

.method public onEvent(Lokhttp3/sse/EventSource;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "eventSource"    # Lokhttp3/sse/EventSource;
    .param p2, "id"    # Ljava/lang/String;
    .param p3, "type"    # Ljava/lang/String;
    .param p4, "data"    # Ljava/lang/String;

    const-string v0, "eventSource"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 195
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$isClosed$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 196
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$getTAG$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u8fde\u63a5\u5df2\u5173\u95ed\uff0c\u5ffd\u7565\u4e8b\u4ef6\u6570\u636e: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x14

    invoke-static {p4, v2}, Lkotlin/text/StringsKt;->take(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "..."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 197
    return-void

    .line 199
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$getTAG$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u6536\u5230SSE\u4e8b\u4ef6\uff0c\u6570\u636e\u957f\u5ea6: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p4}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 200
    const-string v0, "[DONE]"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 201
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$listener:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    invoke-interface {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;->onComplete()V

    .line 202
    return-void

    .line 204
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$listener:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    invoke-interface {v0, p4}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;->onMessage(Ljava/lang/String;)V

    .line 205
    return-void
.end method

.method public onFailure(Lokhttp3/sse/EventSource;Ljava/lang/Throwable;Lokhttp3/Response;)V
    .locals 10
    .param p1, "eventSource"    # Lokhttp3/sse/EventSource;
    .param p2, "t"    # Ljava/lang/Throwable;
    .param p3, "response"    # Lokhttp3/Response;

    const-string v0, "eventSource"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 213
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$isClosed$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 214
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$getTAG$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u8fde\u63a5\u5df2\u5173\u95ed\uff0c\u5ffd\u7565\u5931\u8d25\u56de\u8c03"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 215
    return-void

    .line 217
    :cond_0
    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$requestId:J

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v2}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$getRequestSequence$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/util/concurrent/atomic/AtomicLong;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-eqz v0, :cond_1

    .line 218
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$getTAG$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u8bf7\u6c42\u5df2\u5931\u6548\uff0c\u5ffd\u7565\u5931\u8d25\u56de\u8c03 requestId="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v2, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$requestId:J

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 219
    return-void

    .line 221
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$connectionOpened:Lkotlin/jvm/internal/Ref$BooleanRef;

    iget-boolean v0, v0, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    if-nez v0, :cond_2

    .line 222
    iget v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$retryCount:I

    iget v1, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$maxTransientRetries:I

    if-ge v0, v1, :cond_2

    .line 223
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0, p2, p3}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$isTransientNetworkFailure(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;Ljava/lang/Throwable;Lokhttp3/Response;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 225
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$request:Lokhttp3/Request;

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$listener:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    iget-wide v4, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$requestId:J

    iget v6, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$retryCount:I

    iget v7, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$maxTransientRetries:I

    move-object v8, p2

    move-object v9, p3

    invoke-static/range {v1 .. v9}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$scheduleRetry(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;Lokhttp3/Request;Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;JIILjava/lang/Throwable;Lokhttp3/Response;)V

    .line 226
    return-void

    .line 229
    :cond_2
    instance-of v0, p2, Ljava/io/IOException;

    if-eqz v0, :cond_3

    move-object v0, p2

    check-cast v0, Ljava/io/IOException;

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Canceled"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 230
    const-string/jumbo v0, "\u8fde\u63a5\u5df2\u53d6\u6d88\uff08\u4e3b\u52a8\u5173\u95ed\uff09"

    goto/16 :goto_5

    .line 232
    :cond_3
    const/4 v0, 0x0

    if-eqz p3, :cond_4

    invoke-virtual {p3}, Lokhttp3/Response;->code()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    goto :goto_0

    :cond_4
    move-object v1, v0

    .line 233
    .local v1, "responseCode":Ljava/lang/Integer;
    :goto_0
    if-eqz p3, :cond_5

    invoke-virtual {p3}, Lokhttp3/Response;->message()Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    :cond_5
    move-object v2, v0

    :goto_1
    const-string v3, ""

    if-nez v2, :cond_6

    move-object v2, v3

    .line 234
    .local v2, "responseMessage":Ljava/lang/String;
    :cond_6
    if-eqz p3, :cond_7

    invoke-virtual {p3}, Lokhttp3/Response;->request()Lokhttp3/Request;

    move-result-object v4

    if-eqz v4, :cond_7

    invoke-virtual {v4}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v4

    if-eqz v4, :cond_7

    invoke-virtual {v4}, Lokhttp3/HttpUrl;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_2

    :cond_7
    move-object v4, v0

    :goto_2
    if-nez v4, :cond_8

    move-object v4, v3

    .line 235
    .local v4, "responseUrl":Ljava/lang/String;
    :cond_8
    nop

    .line 236
    if-eqz p3, :cond_9

    const-wide/16 v5, 0x1000

    :try_start_0
    invoke-virtual {p3, v5, v6}, Lokhttp3/Response;->peekBody(J)Lokhttp3/ResponseBody;

    move-result-object v5

    if-eqz v5, :cond_9

    invoke-virtual {v5}, Lokhttp3/ResponseBody;->string()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    .line 237
    :catch_0
    move-exception v0

    .line 238
    .local v0, "peekError":Ljava/lang/Exception;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "peekBodyFailed:"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_4

    .line 236
    .end local v0    # "peekError":Ljava/lang/Exception;
    :cond_9
    :goto_3
    if-nez v0, :cond_a

    goto :goto_4

    :cond_a
    move-object v3, v0

    .line 235
    :goto_4
    move-object v0, v3

    .line 240
    .local v0, "responseBody":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move-object v5, v3

    .local v5, "$this$onFailure_u24lambda_u240":Ljava/lang/StringBuilder;
    const/4 v6, 0x0

    .line 241
    .local v6, "$i$a$-buildString-OkHttpSSEClient$startEventSource$1$onFailure$errorMsg$1":I
    if-eqz p2, :cond_b

    invoke-virtual {p2}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v7

    if-nez v7, :cond_c

    :cond_b
    const-string/jumbo v7, "\u8fde\u63a5\u5931\u8d25"

    :cond_c
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 242
    if-eqz v1, :cond_d

    .line 243
    const-string/jumbo v7, "\uff0c\u54cd\u5e94\u7801\uff1a"

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 245
    :cond_d
    move-object v7, v2

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v7}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v7

    xor-int/lit8 v7, v7, 0x1

    if-eqz v7, :cond_e

    .line 246
    const-string/jumbo v7, "\uff0c\u54cd\u5e94\u4fe1\u606f\uff1a"

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 248
    :cond_e
    move-object v7, v4

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v7}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v7

    xor-int/lit8 v7, v7, 0x1

    if-eqz v7, :cond_f

    .line 249
    const-string/jumbo v7, "\uff0cURL\uff1a"

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 251
    :cond_f
    move-object v7, v0

    check-cast v7, Ljava/lang/CharSequence;

    invoke-static {v7}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v7

    xor-int/lit8 v7, v7, 0x1

    if-eqz v7, :cond_10

    .line 252
    const-string/jumbo v7, "\uff0c\u54cd\u5e94\u4f53\uff1a"

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 254
    :cond_10
    nop

    .line 240
    .end local v5    # "$this$onFailure_u24lambda_u240":Ljava/lang/StringBuilder;
    .end local v6    # "$i$a$-buildString-OkHttpSSEClient$startEventSource$1$onFailure$errorMsg$1":I
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v5, "StringBuilder().apply(builderAction).toString()"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v0, v3

    .line 229
    .end local v0    # "responseBody":Ljava/lang/String;
    .end local v1    # "responseCode":Ljava/lang/Integer;
    .end local v2    # "responseMessage":Ljava/lang/String;
    .end local v4    # "responseUrl":Ljava/lang/String;
    :goto_5
    nop

    .line 256
    .local v0, "errorMsg":Ljava/lang/String;
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v1}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$getTAG$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SSE\u8fde\u63a5\u5931\u8d25: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2, p2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 257
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$listener:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    new-instance v2, Ljava/lang/Throwable;

    invoke-direct {v2, v0}, Ljava/lang/Throwable;-><init>(Ljava/lang/String;)V

    invoke-interface {v1, v2}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;->onError(Ljava/lang/Throwable;)V

    .line 258
    return-void
.end method

.method public onOpen(Lokhttp3/sse/EventSource;Lokhttp3/Response;)V
    .locals 3
    .param p1, "eventSource"    # Lokhttp3/sse/EventSource;
    .param p2, "response"    # Lokhttp3/Response;

    const-string v0, "eventSource"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "response"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 178
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$isClosed$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 179
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$getTAG$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u8fde\u63a5\u5df2\u5173\u95ed\uff0c\u5ffd\u7565onOpen\u56de\u8c03"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 180
    invoke-interface {p1}, Lokhttp3/sse/EventSource;->cancel()V

    .line 181
    return-void

    .line 183
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$connectionOpened:Lkotlin/jvm/internal/Ref$BooleanRef;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lkotlin/jvm/internal/Ref$BooleanRef;->element:Z

    .line 184
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->this$0:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;->access$getTAG$p(Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SSE\u8fde\u63a5\u5df2\u6253\u5f00\uff0c\u54cd\u5e94\u7801: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Lokhttp3/Response;->code()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 185
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$startEventSource$1;->$listener:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;

    invoke-interface {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;->onConnected()V

    .line 186
    return-void
.end method
