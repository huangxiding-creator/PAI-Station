.class public Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
.super Ljava/lang/Object;
.source "BaseWebsocketConnect.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBaseWebsocketConnect.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BaseWebsocketConnect.kt\ncom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect\n+ 2 Mutex.kt\nkotlinx/coroutines/sync/MutexKt\n+ 3 _Maps.kt\nkotlin/collections/MapsKt___MapsKt\n*L\n1#1,419:1\n120#2,10:420\n215#3,2:430\n*S KotlinDebug\n*F\n+ 1 BaseWebsocketConnect.kt\ncom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect\n*L\n376#1:420,10\n386#1:430,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u009d\u0001\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0010%\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0002\u0008\u000b\n\u0002\u0010\u0008\n\u0002\u0008\u0004\n\u0002\u0010\u0003\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0008*\u00018\u0008\u0016\u0018\u0000 \\2\u00020\u0001:\u0001\\B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0010\u00100\u001a\u00020\u00042\u0006\u00101\u001a\u00020\u0004H\u0002J\u0008\u00102\u001a\u000203H\u0002J\u000e\u00104\u001a\u0002032\u0006\u0010\u0007\u001a\u00020\u0008J\u0008\u00105\u001a\u00020\u0006H\u0002J\u0008\u00106\u001a\u00020\u0006H\u0002J\u0015\u00107\u001a\u0002082\u0006\u00109\u001a\u00020:H\u0002\u00a2\u0006\u0002\u0010;J\u0006\u0010<\u001a\u000203J\u0019\u0010=\u001a\u0002032\u0006\u0010>\u001a\u00020\u0004H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010?J\u0010\u0010@\u001a\u0002032\u0006\u0010>\u001a\u00020\u0004H\u0002J\u0006\u0010A\u001a\u00020\u0004J\u0018\u0010B\u001a\u00020-2\u0006\u0010C\u001a\u00020$2\u0006\u00109\u001a\u00020:H\u0002J\u0018\u0010D\u001a\u0002032\u0006\u0010E\u001a\u00020F2\u0006\u0010G\u001a\u00020\u0004H\u0016J\u0018\u0010H\u001a\u0002032\u0006\u0010E\u001a\u00020F2\u0006\u0010G\u001a\u00020\u0004H\u0016J\u001a\u0010I\u001a\u0002032\u0006\u0010J\u001a\u00020K2\u0008\u0010L\u001a\u0004\u0018\u00010MH\u0016J\u0010\u0010N\u001a\u0002032\u0006\u0010O\u001a\u00020\u0004H\u0016J\u0010\u0010N\u001a\u0002032\u0006\u0010P\u001a\u00020QH\u0016J\u0010\u0010R\u001a\u0002032\u0006\u0010L\u001a\u00020MH\u0016J\u0010\u0010S\u001a\u0002032\u0006\u0010T\u001a\u00020UH\u0002J\u000e\u0010V\u001a\u00020-2\u0006\u0010W\u001a\u00020\u0004J\u000e\u0010V\u001a\u00020-2\u0006\u0010P\u001a\u00020QJ\u000e\u0010X\u001a\u0002032\u0006\u0010Y\u001a\u00020-J\u000e\u0010Z\u001a\u0002032\u0006\u0010[\u001a\u00020/R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001c\u0010\u0007\u001a\u0004\u0018\u00010\u0008X\u0084\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\t\u0010\n\"\u0004\u0008\u000b\u0010\u000cR\u001a\u0010\r\u001a\u00020\u000eX\u0084\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000f\u0010\u0010\"\u0004\u0008\u0011\u0010\u0012R\u000e\u0010\u0013\u001a\u00020\u0014X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0015\u001a\u00020\u0016X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0017\u001a\u00020\u0016X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0018\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0019\u0010\u001a\"\u0004\u0008\u001b\u0010\u001cR&\u0010\u001d\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00040\u001eX\u0084\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001f\u0010 \"\u0004\u0008!\u0010\"R\u0010\u0010#\u001a\u0004\u0018\u00010$X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010%\u001a\u00020\u000eX\u0084\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008&\u0010\u0010\"\u0004\u0008\'\u0010\u0012R\u0010\u0010(\u001a\u0004\u0018\u00010)X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010*\u001a\u00020+X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010,\u001a\u00020-X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010.\u001a\u0004\u0018\u00010/X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006]"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;",
        "",
        "()V",
        "TAG",
        "",
        "client",
        "Lokhttp3/OkHttpClient;",
        "config",
        "Lcom/rokid/security/sdk/ability/bean/BaseConfig;",
        "getConfig",
        "()Lcom/rokid/security/sdk/ability/bean/BaseConfig;",
        "setConfig",
        "(Lcom/rokid/security/sdk/ability/bean/BaseConfig;)V",
        "connectMutex",
        "Lkotlinx/coroutines/sync/Mutex;",
        "getConnectMutex",
        "()Lkotlinx/coroutines/sync/Mutex;",
        "setConnectMutex",
        "(Lkotlinx/coroutines/sync/Mutex;)V",
        "connectionGeneration",
        "Ljava/util/concurrent/atomic/AtomicLong;",
        "isClosed",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "isConnected",
        "mEventStatus",
        "getMEventStatus",
        "()Ljava/lang/String;",
        "setMEventStatus",
        "(Ljava/lang/String;)V",
        "mHeaderMap",
        "",
        "getMHeaderMap",
        "()Ljava/util/Map;",
        "setMHeaderMap",
        "(Ljava/util/Map;)V",
        "mWebSocket",
        "Lokhttp3/WebSocket;",
        "reConnectMutex",
        "getReConnectMutex",
        "setReConnectMutex",
        "recJob",
        "Lkotlinx/coroutines/Job;",
        "reconnectBackoff",
        "Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;",
        "shouldTrustAllCerts",
        "",
        "webSocketCallback",
        "Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;",
        "buildPrefixedWebSocketUrl",
        "baseUrl",
        "cleanupWebSocket",
        "",
        "connect",
        "createDefaultClient",
        "createTrustAllClient",
        "createWebSocketListener",
        "com/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1",
        "generation",
        "",
        "(J)Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;",
        "destroy",
        "doConnect",
        "url",
        "(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "doReconnect",
        "generateId",
        "isCurrentConnection",
        "webSocket",
        "onClosed",
        "code",
        "",
        "reason",
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
        "openWebSocket",
        "request",
        "Lokhttp3/Request;",
        "sendMessage",
        "msg",
        "setTrustAllCerts",
        "trustAll",
        "setWebSocketCallback",
        "callback",
        "Companion",
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


# static fields
.field public static final Companion:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$Companion;

.field public static final ERROR_BUSY_EVENT:I = -0x2713

.field public static final ERROR_SERVER_FAILED:I = -0x2714

.field public static final ERROR_UNKNOWN:I = -0x2711

.field public static final ERROR_UNKNOWN_EVENT:I = -0x2712


# instance fields
.field private final TAG:Ljava/lang/String;

.field private client:Lokhttp3/OkHttpClient;

.field private config:Lcom/rokid/security/sdk/ability/bean/BaseConfig;

.field private connectMutex:Lkotlinx/coroutines/sync/Mutex;

.field private final connectionGeneration:Ljava/util/concurrent/atomic/AtomicLong;

.field private final isClosed:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private final isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private volatile mEventStatus:Ljava/lang/String;

.field private mHeaderMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private volatile mWebSocket:Lokhttp3/WebSocket;

.field private reConnectMutex:Lkotlinx/coroutines/sync/Mutex;

.field private recJob:Lkotlinx/coroutines/Job;

.field private final reconnectBackoff:Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;

.field private shouldTrustAllCerts:Z

.field private webSocketCallback:Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;


# direct methods
.method public static synthetic $r8$lambda$bER0aKpbtHWtEPzfzoxmh8npj88(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->createTrustAllClient$lambda$0(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z

    move-result p0

    return p0
.end method

.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->Companion:Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 10

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    const-string v0, "BaseWebsocketConnect::"

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    .line 39
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 40
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isClosed:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 43
    new-instance v0, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;

    const/4 v8, 0x7

    const/4 v9, 0x0

    const-wide/16 v3, 0x0

    const-wide/16 v5, 0x0

    const/4 v7, 0x0

    move-object v2, v0

    invoke-direct/range {v2 .. v9}, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;-><init>(JJLkotlin/jvm/functions/Function1;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->reconnectBackoff:Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;

    .line 44
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v2, 0x0

    invoke-direct {v0, v2, v3}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->connectionGeneration:Ljava/util/concurrent/atomic/AtomicLong;

    .line 47
    const/4 v0, 0x1

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Lkotlinx/coroutines/sync/MutexKt;->Mutex$default(ZILjava/lang/Object;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v3

    iput-object v3, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->connectMutex:Lkotlinx/coroutines/sync/Mutex;

    .line 48
    invoke-static {v1, v0, v2}, Lkotlinx/coroutines/sync/MutexKt;->Mutex$default(ZILjava/lang/Object;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v1

    iput-object v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->reConnectMutex:Lkotlinx/coroutines/sync/Mutex;

    .line 52
    const-string v1, "Ended"

    iput-object v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mEventStatus:Ljava/lang/String;

    .line 55
    iput-boolean v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->shouldTrustAllCerts:Z

    .line 57
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mHeaderMap:Ljava/util/Map;

    .line 60
    nop

    .line 62
    iget-boolean v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->shouldTrustAllCerts:Z

    if-eqz v0, :cond_0

    .line 63
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->createTrustAllClient()Lokhttp3/OkHttpClient;

    move-result-object v0

    goto :goto_0

    .line 65
    :cond_0
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->createDefaultClient()Lokhttp3/OkHttpClient;

    move-result-object v0

    .line 62
    :goto_0
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->client:Lokhttp3/OkHttpClient;

    .line 67
    nop

    .line 35
    return-void
.end method

.method public static final synthetic access$buildPrefixedWebSocketUrl(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    .param p1, "baseUrl"    # Ljava/lang/String;

    .line 35
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->buildPrefixedWebSocketUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$cleanupWebSocket(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .line 35
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->cleanupWebSocket()V

    return-void
.end method

.method public static final synthetic access$doConnect(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 35
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->doConnect(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$doReconnect(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    .param p1, "url"    # Ljava/lang/String;

    .line 35
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->doReconnect(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$getConnectionGeneration$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/util/concurrent/atomic/AtomicLong;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->connectionGeneration:Ljava/util/concurrent/atomic/AtomicLong;

    return-object v0
.end method

.method public static final synthetic access$getRecJob$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Lkotlinx/coroutines/Job;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->recJob:Lkotlinx/coroutines/Job;

    return-object v0
.end method

.method public static final synthetic access$getReconnectBackoff$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->reconnectBackoff:Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getWebSocketCallback$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->webSocketCallback:Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    return-object v0
.end method

.method public static final synthetic access$isClosed$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isClosed:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public static final synthetic access$isConnected$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .line 35
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public static final synthetic access$isCurrentConnection(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/WebSocket;J)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "generation"    # J

    .line 35
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isCurrentConnection(Lokhttp3/WebSocket;J)Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$openWebSocket(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/Request;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    .param p1, "request"    # Lokhttp3/Request;

    .line 35
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->openWebSocket(Lokhttp3/Request;)V

    return-void
.end method

.method public static final synthetic access$setMWebSocket$p(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lokhttp3/WebSocket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    .param p1, "<set-?>"    # Lokhttp3/WebSocket;

    .line 35
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mWebSocket:Lokhttp3/WebSocket;

    return-void
.end method

.method private final buildPrefixedWebSocketUrl(Ljava/lang/String;)Ljava/lang/String;
    .locals 13
    .param p1, "baseUrl"    # Ljava/lang/String;

    .line 144
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getMethodProfix()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    new-array v2, v1, [C

    const/4 v3, 0x0

    const/16 v4, 0x2f

    aput-char v4, v2, v3

    invoke-static {v0, v2}, Lkotlin/text/StringsKt;->trim(Ljava/lang/String;[C)Ljava/lang/String;

    move-result-object v0

    .line 145
    .local v0, "prefix":Ljava/lang/String;
    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_0

    move v2, v1

    goto :goto_0

    :cond_0
    move v2, v3

    :goto_0
    if-eqz v2, :cond_1

    return-object p1

    .line 147
    :cond_1
    nop

    .line 148
    :try_start_0
    new-instance v2, Ljava/net/URI;

    invoke-direct {v2, p1}, Ljava/net/URI;-><init>(Ljava/lang/String;)V

    .line 149
    .local v2, "uri":Ljava/net/URI;
    invoke-virtual {v2}, Ljava/net/URI;->getScheme()Ljava/lang/String;

    move-result-object v5

    if-nez v5, :cond_2

    const-string/jumbo v5, "ws"

    .line 150
    .local v5, "scheme":Ljava/lang/String;
    :cond_2
    invoke-virtual {v2}, Ljava/net/URI;->getHost()Ljava/lang/String;

    move-result-object v6

    if-nez v6, :cond_3

    return-object p1

    .line 151
    .local v6, "host":Ljava/lang/String;
    :cond_3
    invoke-virtual {v2}, Ljava/net/URI;->getPort()I

    move-result v7
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v8, -0x1

    const-string v9, ""

    if-eq v7, v8, :cond_4

    :try_start_1
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const/16 v8, 0x3a

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v2}, Ljava/net/URI;->getPort()I

    move-result v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    goto :goto_1

    :cond_4
    move-object v7, v9

    .line 152
    .local v7, "port":Ljava/lang/String;
    :goto_1
    invoke-virtual {v2}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v8

    if-nez v8, :cond_5

    move-object v8, v9

    .line 153
    .local v8, "path":Ljava/lang/String;
    :cond_5
    new-array v10, v1, [C

    aput-char v4, v10, v3

    invoke-static {v8, v10}, Lkotlin/text/StringsKt;->trimStart(Ljava/lang/String;[C)Ljava/lang/String;

    move-result-object v10

    .line 156
    .local v10, "cleanPath":Ljava/lang/String;
    const/4 v11, 0x2

    const/4 v12, 0x0

    invoke-static {v10, v0, v3, v11, v12}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_6

    .line 157
    return-object p1

    .line 160
    :cond_6
    move-object v11, v10

    check-cast v11, Ljava/lang/CharSequence;

    invoke-interface {v11}, Ljava/lang/CharSequence;->length()I

    move-result v11

    if-nez v11, :cond_7

    goto :goto_2

    :cond_7
    move v1, v3

    :goto_2
    if-eqz v1, :cond_8

    .line 161
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_3

    .line 163
    :cond_8
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 160
    :goto_3
    nop

    .line 166
    .local v1, "newPath":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/net/URI;->getQuery()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_9

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const/16 v4, 0x3f

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v2}, Ljava/net/URI;->getQuery()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    :cond_9
    move-object v3, v9

    .line 167
    .local v3, "query":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v9, "://"

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .end local v1    # "newPath":Ljava/lang/String;
    .end local v2    # "uri":Ljava/net/URI;
    .end local v3    # "query":Ljava/lang/String;
    .end local v5    # "scheme":Ljava/lang/String;
    .end local v6    # "host":Ljava/lang/String;
    .end local v7    # "port":Ljava/lang/String;
    .end local v8    # "path":Ljava/lang/String;
    .end local v10    # "cleanPath":Ljava/lang/String;
    goto :goto_4

    .line 168
    :catch_0
    move-exception v1

    .line 169
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "buildPrefixedWebSocketUrl failed type="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "BaseWebsocketConnect"

    invoke-static {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 170
    move-object v4, p1

    .line 147
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_4
    return-object v4
.end method

.method private final cleanupWebSocket()V
    .locals 5

    .line 406
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    const-string v1, "cleanupWebSocket"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 407
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->connectionGeneration:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    .line 408
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mWebSocket:Lokhttp3/WebSocket;

    .line 409
    .local v0, "webSocket":Lokhttp3/WebSocket;
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mWebSocket:Lokhttp3/WebSocket;

    .line 410
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 411
    nop

    .line 412
    if-eqz v0, :cond_0

    :try_start_0
    invoke-interface {v0}, Lokhttp3/WebSocket;->cancel()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 413
    :catch_0
    move-exception v1

    .line 414
    .local v1, "e":Ljava/lang/Exception;
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u6e05\u7406WebSocket\u5f02\u5e38 type="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 416
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    return-void
.end method

.method private final createDefaultClient()Lokhttp3/OkHttpClient;
    .locals 4

    .line 118
    new-instance v0, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v0}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 119
    sget-object v1, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    check-cast v1, Lokhttp3/Interceptor;

    invoke-virtual {v0, v1}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 120
    const-wide/16 v1, 0x5

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, v2, v3}, Lokhttp3/OkHttpClient$Builder;->pingInterval(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 121
    const-wide/16 v1, 0x0

    sget-object v3, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, v2, v3}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 122
    invoke-virtual {v0}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    const-string v1, "Builder()\n            .a\u2026NDS)\n            .build()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 118
    return-object v0
.end method

.method private final createTrustAllClient()Lokhttp3/OkHttpClient;
    .locals 7

    .line 84
    nop

    .line 86
    const/4 v0, 0x1

    :try_start_0
    new-array v0, v0, [Ljavax/net/ssl/TrustManager;

    new-instance v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createTrustAllClient$trustAllCerts$1;

    invoke-direct {v1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createTrustAllClient$trustAllCerts$1;-><init>()V

    const/4 v2, 0x0

    aput-object v1, v0, v2

    .line 93
    .local v0, "trustAllCerts":[Ljavax/net/ssl/TrustManager;
    const-string v1, "TLS"

    invoke-static {v1}, Ljavax/net/ssl/SSLContext;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/SSLContext;

    move-result-object v1

    .line 94
    .local v1, "sslContext":Ljavax/net/ssl/SSLContext;
    new-instance v3, Ljava/security/SecureRandom;

    invoke-direct {v3}, Ljava/security/SecureRandom;-><init>()V

    const/4 v4, 0x0

    invoke-virtual {v1, v4, v0, v3}, Ljavax/net/ssl/SSLContext;->init([Ljavax/net/ssl/KeyManager;[Ljavax/net/ssl/TrustManager;Ljava/security/SecureRandom;)V

    .line 97
    invoke-virtual {v1}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v3

    .line 100
    .local v3, "sslSocketFactory":Ljavax/net/ssl/SSLSocketFactory;
    new-instance v4, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v4}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    .line 101
    aget-object v2, v0, v2

    const-string v5, "null cannot be cast to non-null type javax.net.ssl.X509TrustManager"

    invoke-static {v2, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v2, Ljavax/net/ssl/X509TrustManager;

    invoke-virtual {v4, v3, v2}, Lokhttp3/OkHttpClient$Builder;->sslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;Ljavax/net/ssl/X509TrustManager;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    new-instance v4, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$$ExternalSyntheticLambda0;

    invoke-direct {v4}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$$ExternalSyntheticLambda0;-><init>()V

    .line 102
    invoke-virtual {v2, v4}, Lokhttp3/OkHttpClient$Builder;->hostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 103
    sget-object v4, Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UserTokenFailureInterceptor;

    check-cast v4, Lokhttp3/Interceptor;

    invoke-virtual {v2, v4}, Lokhttp3/OkHttpClient$Builder;->addInterceptor(Lokhttp3/Interceptor;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 104
    sget-object v4, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v5, 0xf

    invoke-virtual {v2, v5, v6, v4}, Lokhttp3/OkHttpClient$Builder;->pingInterval(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 105
    sget-object v4, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v5, 0x0

    invoke-virtual {v2, v5, v6, v4}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v2

    .line 106
    invoke-virtual {v2}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v2

    .line 101
    const-string v4, "Builder()\n              \u2026\n                .build()"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 100
    return-object v2

    .line 107
    .end local v0    # "trustAllCerts":[Ljavax/net/ssl/TrustManager;
    .end local v1    # "sslContext":Ljavax/net/ssl/SSLContext;
    .end local v3    # "sslSocketFactory":Ljavax/net/ssl/SSLSocketFactory;
    :catch_0
    move-exception v0

    .line 108
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u521b\u5efa WebSocket \u5ba2\u6237\u7aef\u5931\u8d25 type="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 110
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->createDefaultClient()Lokhttp3/OkHttpClient;

    move-result-object v1

    return-object v1
.end method

.method private static final createTrustAllClient$lambda$0(Ljava/lang/String;Ljavax/net/ssl/SSLSession;)Z
    .locals 0

    .line 102
    const/4 p0, 0x1

    return p0
.end method

.method private final createWebSocketListener(J)Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;
    .locals 1
    .param p1, "generation"    # J

    .line 216
    new-instance v0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;

    invoke-direct {v0, p0, p1, p2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;-><init>(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;J)V

    .line 289
    return-object v0
.end method

.method private final doConnect(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 19
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    move-object/from16 v0, p2

    instance-of v1, v0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;

    if-eqz v1, :cond_0

    move-object v1, v0

    check-cast v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;

    iget v2, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->label:I

    const/high16 v3, -0x80000000

    and-int/2addr v2, v3

    if-eqz v2, :cond_0

    iget v0, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->label:I

    sub-int/2addr v0, v3

    iput v0, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->label:I

    move-object v0, v1

    move-object/from16 v2, p0

    goto :goto_0

    :cond_0
    new-instance v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;

    move-object/from16 v2, p0

    invoke-direct {v1, v2, v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;-><init>(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lkotlin/coroutines/Continuation;)V

    move-object v0, v1

    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    :goto_0
    iget-object v3, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->result:Ljava/lang/Object;

    .local v3, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 373
    iget v4, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->label:I

    const/4 v5, 0x0

    const/4 v6, 0x1

    packed-switch v4, :pswitch_data_0

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v3    # "$result":Ljava/lang/Object;
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v3    # "$result":Ljava/lang/Object;
    :pswitch_0
    const/4 v4, 0x0

    .local v4, "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    const/4 v6, 0x0

    .local v6, "$i$f$withLock":I
    iget-object v0, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$3:Ljava/lang/Object;

    check-cast v0, Lokhttp3/Request;

    .local v0, "request":Lokhttp3/Request;
    iget-object v7, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$2:Ljava/lang/Object;

    check-cast v7, Lkotlinx/coroutines/sync/Mutex;

    iget-object v8, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$1:Ljava/lang/Object;

    check-cast v8, Ljava/lang/String;

    .local v8, "url":Ljava/lang/String;
    iget-object v9, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$0:Ljava/lang/Object;

    check-cast v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .local v9, "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    :try_start_0
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_4

    .line 429
    .end local v0    # "request":Lokhttp3/Request;
    .end local v4    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    .end local v8    # "url":Ljava/lang/String;
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    :catchall_0
    move-exception v0

    move-object v4, v5

    .local v4, "owner$iv":Ljava/lang/Object;
    move-object v5, v7

    .local v5, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    goto/16 :goto_a

    .line 395
    .end local v5    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .local v4, "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    .restart local v8    # "url":Ljava/lang/String;
    .restart local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    :catch_0
    move-exception v0

    .local v5, "owner$iv":Ljava/lang/Object;
    move v10, v4

    move-object v4, v5

    move-object v5, v7

    .local v7, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    goto/16 :goto_8

    .line 373
    .end local v4    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    .end local v5    # "owner$iv":Ljava/lang/Object;
    .end local v6    # "$i$f$withLock":I
    .end local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .end local v8    # "url":Ljava/lang/String;
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    :pswitch_1
    const/4 v4, 0x0

    .local v4, "$i$f$withLock":I
    iget-object v7, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$2:Ljava/lang/Object;

    check-cast v7, Lkotlinx/coroutines/sync/Mutex;

    iget-object v8, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$1:Ljava/lang/Object;

    check-cast v8, Ljava/lang/String;

    .restart local v8    # "url":Ljava/lang/String;
    iget-object v9, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$0:Ljava/lang/Object;

    check-cast v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;

    .restart local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_1

    .end local v4    # "$i$f$withLock":I
    .end local v8    # "url":Ljava/lang/String;
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    :pswitch_2
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v4, p0

    .local v4, "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    move-object/from16 v5, p1

    .line 375
    .local v5, "url":Ljava/lang/String;
    iget-object v7, v4, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "doConnect isConnected="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, v4, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v9}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " isClosed="

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, v4, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isClosed:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v9}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 376
    iget-object v7, v4, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->reConnectMutex:Lkotlinx/coroutines/sync/Mutex;

    .line 420
    .restart local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    const/4 v8, 0x0

    .local v8, "owner$iv":Ljava/lang/Object;
    const/4 v9, 0x0

    .line 421
    .local v9, "$i$f$withLock":I
    nop

    .line 425
    iput-object v4, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$0:Ljava/lang/Object;

    iput-object v5, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$1:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$2:Ljava/lang/Object;

    iput v6, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->label:I

    invoke-interface {v7, v8, v1}, Lkotlinx/coroutines/sync/Mutex;->lock(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v10

    if-ne v10, v0, :cond_1

    .line 373
    return-object v0

    .line 425
    :cond_1
    move/from16 v17, v9

    move-object v9, v4

    move/from16 v4, v17

    move-object/from16 v18, v8

    move-object v8, v5

    move-object/from16 v5, v18

    .line 426
    .end local v5    # "url":Ljava/lang/String;
    .end local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .local v4, "$i$f$withLock":I
    .local v8, "url":Ljava/lang/String;
    .local v9, "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    :goto_1
    nop

    .line 427
    const/4 v10, 0x0

    .line 377
    .local v10, "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    nop

    .line 378
    :try_start_1
    iget-object v11, v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v11}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v11

    if-nez v11, :cond_8

    iget-object v11, v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isClosed:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v11}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v11
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    if-eqz v11, :cond_2

    goto/16 :goto_7

    .line 381
    .local v5, "owner$iv":Ljava/lang/Object;
    .restart local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :cond_2
    :try_start_2
    invoke-direct {v9, v8}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->buildPrefixedWebSocketUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 382
    .local v11, "serverUrl":Ljava/lang/String;
    iget-object v12, v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "WebSocket reconnect endpointConfigured="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object v14, v11

    check-cast v14, Ljava/lang/CharSequence;

    invoke-static {v14}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v14

    if-nez v14, :cond_3

    goto :goto_2

    :cond_3
    const/4 v6, 0x0

    :goto_2
    invoke-virtual {v13, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v12, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 383
    new-instance v6, Lokhttp3/Request$Builder;

    invoke-direct {v6}, Lokhttp3/Request$Builder;-><init>()V

    .line 384
    invoke-virtual {v6, v11}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v6

    .line 383
    .end local v11    # "serverUrl":Ljava/lang/String;
    nop

    .line 386
    .local v6, "requestBuilder":Lokhttp3/Request$Builder;
    iget-object v11, v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mHeaderMap:Ljava/util/Map;

    .local v11, "$this$forEach$iv":Ljava/util/Map;
    const/4 v12, 0x0

    .line 430
    .local v12, "$i$f$forEach":I
    invoke-interface {v11}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v13

    invoke-interface {v13}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v13

    .end local v11    # "$this$forEach$iv":Ljava/util/Map;
    :goto_3
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_4

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/util/Map$Entry;

    .local v11, "element$iv":Ljava/util/Map$Entry;
    const/4 v14, 0x0

    .line 386
    .local v14, "$i$a$-forEach-BaseWebsocketConnect$doConnect$2$1":I
    invoke-interface {v11}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/String;

    .local v15, "key":Ljava/lang/String;
    invoke-interface {v11}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Ljava/lang/String;

    move-object/from16 p1, v16

    .line 387
    .local p1, "value":Ljava/lang/String;
    move-object/from16 v2, p1

    .end local p1    # "value":Ljava/lang/String;
    .local v2, "value":Ljava/lang/String;
    invoke-virtual {v6, v15, v2}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 388
    nop

    .line 430
    .end local v2    # "value":Ljava/lang/String;
    .end local v11    # "element$iv":Ljava/util/Map$Entry;
    .end local v14    # "$i$a$-forEach-BaseWebsocketConnect$doConnect$2$1":I
    .end local v15    # "key":Ljava/lang/String;
    move-object/from16 v2, p0

    goto :goto_3

    .line 431
    :cond_4
    nop

    .line 389
    .end local v12    # "$i$f$forEach":I
    iget-object v2, v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "WebSocket reconnect headers added count="

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mHeaderMap:Ljava/util/Map;

    invoke-interface {v12}, Ljava/util/Map;->size()I

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v11

    invoke-static {v2, v11}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 390
    invoke-virtual {v6}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v2

    .line 392
    .end local v6    # "requestBuilder":Lokhttp3/Request$Builder;
    .local v2, "request":Lokhttp3/Request;
    iput-object v9, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$0:Ljava/lang/Object;

    iput-object v8, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$1:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$2:Ljava/lang/Object;

    iput-object v2, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->L$3:Ljava/lang/Object;

    const/4 v6, 0x2

    iput v6, v1, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doConnect$1;->label:I

    const-wide/16 v11, 0x12c

    invoke-static {v11, v12, v1}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v6
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    if-ne v6, v0, :cond_5

    .line 373
    return-object v0

    .line 392
    :cond_5
    move-object v0, v2

    move v6, v4

    move v4, v10

    .line 393
    .end local v2    # "request":Lokhttp3/Request;
    .end local v5    # "owner$iv":Ljava/lang/Object;
    .end local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .end local v10    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    .restart local v0    # "request":Lokhttp3/Request;
    .local v4, "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    .local v6, "$i$f$withLock":I
    :goto_4
    :try_start_3
    iget-object v2, v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isClosed:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v2

    if-nez v2, :cond_7

    iget-object v2, v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v2
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-eqz v2, :cond_6

    goto :goto_5

    :cond_6
    move-object v2, v5

    .local v2, "owner$iv":Ljava/lang/Object;
    move-object v5, v7

    .line 394
    .local v5, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :try_start_4
    const-string v7, "request"

    invoke-static {v0, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v9, v0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->openWebSocket(Lokhttp3/Request;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .end local v0    # "request":Lokhttp3/Request;
    .end local v8    # "url":Ljava/lang/String;
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    goto/16 :goto_9

    .line 429
    .end local v4    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    :catchall_1
    move-exception v0

    move-object v4, v2

    goto/16 :goto_a

    .line 395
    .restart local v4    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    .restart local v8    # "url":Ljava/lang/String;
    .restart local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    :catch_1
    move-exception v0

    move v10, v4

    move-object v4, v2

    goto :goto_8

    .line 393
    .end local v2    # "owner$iv":Ljava/lang/Object;
    .end local v5    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :cond_7
    :goto_5
    :try_start_5
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 429
    .end local v4    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    .end local v6    # "$i$f$withLock":I
    .end local v8    # "url":Ljava/lang/String;
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    :goto_6
    invoke-interface {v7, v5}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    return-object v0

    .line 395
    .restart local v4    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    .restart local v6    # "$i$f$withLock":I
    .restart local v8    # "url":Ljava/lang/String;
    .restart local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    :catch_2
    move-exception v0

    move-object v2, v5

    .restart local v2    # "owner$iv":Ljava/lang/Object;
    move-object v5, v7

    move v10, v4

    move-object v4, v2

    .restart local v5    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    goto :goto_8

    .line 429
    .end local v2    # "owner$iv":Ljava/lang/Object;
    .end local v6    # "$i$f$withLock":I
    .end local v8    # "url":Ljava/lang/String;
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    .local v4, "$i$f$withLock":I
    .local v5, "owner$iv":Ljava/lang/Object;
    .restart local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :catchall_2
    move-exception v0

    move v6, v4

    move-object v4, v5

    move-object v5, v7

    goto :goto_a

    .line 395
    .restart local v8    # "url":Ljava/lang/String;
    .restart local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    .restart local v10    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    :catch_3
    move-exception v0

    move v6, v4

    move-object v4, v5

    move-object v5, v7

    goto :goto_8

    .line 379
    .end local v5    # "owner$iv":Ljava/lang/Object;
    .end local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :cond_8
    :goto_7
    :try_start_6
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_4
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .end local v4    # "$i$f$withLock":I
    .end local v8    # "url":Ljava/lang/String;
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    .end local v10    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    goto :goto_6

    .line 429
    .restart local v4    # "$i$f$withLock":I
    :catchall_3
    move-exception v0

    move-object v2, v5

    .restart local v2    # "owner$iv":Ljava/lang/Object;
    move-object v5, v7

    move v6, v4

    move-object v4, v2

    .local v5, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    goto :goto_a

    .line 395
    .end local v2    # "owner$iv":Ljava/lang/Object;
    .end local v5    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .restart local v8    # "url":Ljava/lang/String;
    .restart local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    .restart local v10    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    :catch_4
    move-exception v0

    move-object v2, v5

    .restart local v2    # "owner$iv":Ljava/lang/Object;
    move-object v5, v7

    move v6, v4

    move-object v4, v2

    .line 396
    .end local v2    # "owner$iv":Ljava/lang/Object;
    .local v0, "e":Ljava/lang/Exception;
    .local v4, "owner$iv":Ljava/lang/Object;
    .restart local v5    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .restart local v6    # "$i$f$withLock":I
    :goto_8
    :try_start_7
    iget-object v2, v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "doConnect failed type="

    invoke-virtual {v7, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v7, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v2, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 397
    iget-object v2, v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isClosed:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v2

    if-nez v2, :cond_9

    invoke-direct {v9, v8}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->doReconnect(Ljava/lang/String;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_4

    .line 399
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v8    # "url":Ljava/lang/String;
    .end local v9    # "this":Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;
    :cond_9
    move-object v2, v4

    move v4, v10

    .end local v10    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    .restart local v2    # "owner$iv":Ljava/lang/Object;
    .local v4, "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    :goto_9
    nop

    .end local v4    # "$i$a$-withLock$default-BaseWebsocketConnect$doConnect$2":I
    :try_start_8
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    .line 427
    nop

    .line 429
    invoke-interface {v5, v2}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    .line 427
    .end local v2    # "owner$iv":Ljava/lang/Object;
    .end local v5    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    nop

    .line 429
    .end local v6    # "$i$f$withLock":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 400
    return-object v0

    .line 429
    .local v4, "owner$iv":Ljava/lang/Object;
    .restart local v5    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .restart local v6    # "$i$f$withLock":I
    :catchall_4
    move-exception v0

    :goto_a
    invoke-interface {v5, v4}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    throw v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final doReconnect(Ljava/lang/String;)V
    .locals 10
    .param p1, "url"    # Ljava/lang/String;

    .line 357
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u91cd\u8fde\u68c0\u67e5\uff1aisConnected="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " - isClosed="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isClosed:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 358
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isClosed:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 361
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->recJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_1

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 362
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->webSocketCallback:Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    if-eqz v0, :cond_2

    invoke-interface {v0}, Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;->onReconnecting()V

    .line 363
    :cond_2
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->reconnectBackoff:Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->nextDelayMs()J

    move-result-wide v7

    .line 364
    .local v7, "reconnectDelayMs":J
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    new-instance v9, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doReconnect$1;

    const/4 v6, 0x0

    move-object v1, v9

    move-object v2, p0

    move-wide v3, v7

    move-object v5, p1

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$doReconnect$1;-><init>(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;JLjava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v3, v9

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->recJob:Lkotlinx/coroutines/Job;

    .line 371
    return-void

    .line 359
    .end local v7    # "reconnectDelayMs":J
    :cond_3
    :goto_0
    return-void
.end method

.method private final isCurrentConnection(Lokhttp3/WebSocket;J)Z
    .locals 2
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "generation"    # J

    .line 297
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->connectionGeneration:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v0

    cmp-long v0, p2, v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mWebSocket:Lokhttp3/WebSocket;

    if-ne v0, p1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private final openWebSocket(Lokhttp3/Request;)V
    .locals 4
    .param p1, "request"    # Lokhttp3/Request;

    .line 292
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->connectionGeneration:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v0

    .line 293
    .local v0, "generation":J
    iget-object v2, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->client:Lokhttp3/OkHttpClient;

    invoke-direct {p0, v0, v1}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->createWebSocketListener(J)Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$createWebSocketListener$1;

    move-result-object v3

    check-cast v3, Lokhttp3/WebSocketListener;

    invoke-virtual {v2, p1, v3}, Lokhttp3/OkHttpClient;->newWebSocket(Lokhttp3/Request;Lokhttp3/WebSocketListener;)Lokhttp3/WebSocket;

    move-result-object v2

    iput-object v2, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mWebSocket:Lokhttp3/WebSocket;

    .line 294
    return-void
.end method


# virtual methods
.method public final connect(Lcom/rokid/security/sdk/ability/bean/BaseConfig;)V
    .locals 7
    .param p1, "config"    # Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    const-string v0, "config"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 175
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isClosed:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 176
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->reconnectBackoff:Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/websocket/ReconnectBackoff;->reset()V

    .line 177
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, p1, v2}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect$connect$1;-><init>(Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;Lcom/rokid/security/sdk/ability/bean/BaseConfig;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 204
    return-void
.end method

.method public final destroy()V
    .locals 3

    .line 325
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isClosed:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 326
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->recJob:Lkotlinx/coroutines/Job;

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 327
    :cond_0
    iput-object v2, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->recJob:Lkotlinx/coroutines/Job;

    .line 329
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->cleanupWebSocket()V

    .line 330
    iput-object v2, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->webSocketCallback:Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    .line 331
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->client:Lokhttp3/OkHttpClient;

    invoke-virtual {v0}, Lokhttp3/OkHttpClient;->dispatcher()Lokhttp3/Dispatcher;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/Dispatcher;->executorService()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    .line 332
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->client:Lokhttp3/OkHttpClient;

    invoke-virtual {v0}, Lokhttp3/OkHttpClient;->connectionPool()Lokhttp3/ConnectionPool;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/ConnectionPool;->evictAll()V

    .line 333
    return-void
.end method

.method public final generateId()Ljava/lang/String;
    .locals 2

    .line 351
    invoke-static {}, Lcom/rokid/utils/UUIDUtils;->generateUUID()Ljava/lang/String;

    move-result-object v0

    const-string v1, "generateUUID()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method protected final getConfig()Lcom/rokid/security/sdk/ability/bean/BaseConfig;
    .locals 1

    .line 45
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->config:Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    return-object v0
.end method

.method protected final getConnectMutex()Lkotlinx/coroutines/sync/Mutex;
    .locals 1

    .line 47
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->connectMutex:Lkotlinx/coroutines/sync/Mutex;

    return-object v0
.end method

.method public final getMEventStatus()Ljava/lang/String;
    .locals 1

    .line 52
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mEventStatus:Ljava/lang/String;

    return-object v0
.end method

.method protected final getMHeaderMap()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 57
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mHeaderMap:Ljava/util/Map;

    return-object v0
.end method

.method protected final getReConnectMutex()Lkotlinx/coroutines/sync/Mutex;
    .locals 1

    .line 48
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->reConnectMutex:Lkotlinx/coroutines/sync/Mutex;

    return-object v0
.end method

.method public onClosed(ILjava/lang/String;)V
    .locals 1
    .param p1, "code"    # I
    .param p2, "reason"    # Ljava/lang/String;

    const-string v0, "reason"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 345
    return-void
.end method

.method public onClosing(ILjava/lang/String;)V
    .locals 1
    .param p1, "code"    # I
    .param p2, "reason"    # Ljava/lang/String;

    const-string v0, "reason"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 343
    return-void
.end method

.method public onFailure(Ljava/lang/Throwable;Lokhttp3/Response;)V
    .locals 1
    .param p1, "t"    # Ljava/lang/Throwable;
    .param p2, "response"    # Lokhttp3/Response;

    const-string/jumbo v0, "t"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 347
    return-void
.end method

.method public onMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;

    const-string/jumbo v0, "text"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 337
    return-void
.end method

.method public onMessage(Lokio/ByteString;)V
    .locals 1
    .param p1, "bytes"    # Lokio/ByteString;

    const-string v0, "bytes"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 339
    return-void
.end method

.method public onOpen(Lokhttp3/Response;)V
    .locals 1
    .param p1, "response"    # Lokhttp3/Response;

    const-string v0, "response"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 341
    return-void
.end method

.method public final sendMessage(Ljava/lang/String;)Z
    .locals 4
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 303
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 304
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    const-string/jumbo v2, "sendMessage ->false"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 305
    return v1

    .line 307
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mWebSocket:Lokhttp3/WebSocket;

    if-eqz v0, :cond_1

    invoke-interface {v0, p1}, Lokhttp3/WebSocket;->send(Ljava/lang/String;)Z

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_1

    move v1, v2

    :cond_1
    move v0, v1

    .line 308
    .local v0, "sent":Z
    iget-object v1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "WebSocket message send textChars="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " accepted="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 309
    return v0
.end method

.method public final sendMessage(Lokio/ByteString;)Z
    .locals 4
    .param p1, "bytes"    # Lokio/ByteString;

    const-string v0, "bytes"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 313
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 314
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mWebSocket:Lokhttp3/WebSocket;

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lokhttp3/WebSocket;->send(Lokio/ByteString;)Z

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    move v1, v2

    :cond_0
    return v1

    .line 316
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendMessage bytes dropped: websocket not connected, size="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lokio/ByteString;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 317
    return v1
.end method

.method protected final setConfig(Lcom/rokid/security/sdk/ability/bean/BaseConfig;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    .line 45
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->config:Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    return-void
.end method

.method protected final setConnectMutex(Lkotlinx/coroutines/sync/Mutex;)V
    .locals 1
    .param p1, "<set-?>"    # Lkotlinx/coroutines/sync/Mutex;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 47
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->connectMutex:Lkotlinx/coroutines/sync/Mutex;

    return-void
.end method

.method public final setMEventStatus(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mEventStatus:Ljava/lang/String;

    return-void
.end method

.method protected final setMHeaderMap(Ljava/util/Map;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 57
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->mHeaderMap:Ljava/util/Map;

    return-void
.end method

.method protected final setReConnectMutex(Lkotlinx/coroutines/sync/Mutex;)V
    .locals 1
    .param p1, "<set-?>"    # Lkotlinx/coroutines/sync/Mutex;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 48
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->reConnectMutex:Lkotlinx/coroutines/sync/Mutex;

    return-void
.end method

.method public final setTrustAllCerts(Z)V
    .locals 1
    .param p1, "trustAll"    # Z

    .line 128
    iget-boolean v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->shouldTrustAllCerts:Z

    if-eq v0, p1, :cond_1

    .line 129
    iput-boolean p1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->shouldTrustAllCerts:Z

    .line 131
    if-eqz p1, :cond_0

    .line 132
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->createTrustAllClient()Lokhttp3/OkHttpClient;

    move-result-object v0

    goto :goto_0

    .line 134
    :cond_0
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->createDefaultClient()Lokhttp3/OkHttpClient;

    move-result-object v0

    .line 131
    :goto_0
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->client:Lokhttp3/OkHttpClient;

    .line 137
    :cond_1
    return-void
.end method

.method public final setWebSocketCallback(Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;)V
    .locals 1
    .param p1, "callback"    # Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    const-string v0, "callback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 208
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->webSocketCallback:Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    .line 209
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->isConnected:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 210
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/websocket/BaseWebsocketConnect;->webSocketCallback:Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/rokid/security/sdk/ability/bean/WebSocketCallback;->onOpen()V

    .line 212
    :cond_0
    return-void
.end method
