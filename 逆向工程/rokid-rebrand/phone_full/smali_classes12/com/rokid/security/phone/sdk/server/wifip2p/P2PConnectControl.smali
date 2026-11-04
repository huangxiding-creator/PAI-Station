.class public final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;
.super Ljava/lang/Object;
.source "P2PConnectControl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/wifip2p/api/IP2PConnectControl;


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nP2PConnectControl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PConnectControl.kt\ncom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl\n+ 2 _Maps.kt\nkotlin/collections/MapsKt___MapsKt\n*L\n1#1,493:1\n215#2,2:494\n*S KotlinDebug\n*F\n+ 1 P2PConnectControl.kt\ncom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl\n*L\n486#1:494,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000q\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\t\n\u0002\u0008\u000c\n\u0002\u0018\u0002\n\u0002\u0008\u0015*\u0001\u001d\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010)\u001a\u00020\u000fH\u0002J\u0008\u0010*\u001a\u00020\u000fH\u0002J\u0008\u0010+\u001a\u00020\u000fH\u0002J\u0008\u0010,\u001a\u00020\u000fH\u0002J\u0018\u0010-\u001a\u00020\u000f2\u0006\u0010.\u001a\u00020!2\u0006\u0010/\u001a\u00020\u0006H\u0002Jc\u00100\u001a\u00020\u000f2!\u00101\u001a\u001d\u0012\u0013\u0012\u00110\u000b\u00a2\u0006\u000c\u0008\u000c\u0012\u0008\u0008\r\u0012\u0004\u0008\u0008(2\u0012\u0004\u0012\u00020\u000f0\n26\u00103\u001a2\u0012\u0013\u0012\u00110\u0006\u00a2\u0006\u000c\u0008\u000c\u0012\u0008\u0008\r\u0012\u0004\u0008\u0008(5\u0012\u0013\u0012\u00110\u0004\u00a2\u0006\u000c\u0008\u000c\u0012\u0008\u0008\r\u0012\u0004\u0008\u0008(6\u0012\u0004\u0012\u00020\u000f04H\u0016J\u0018\u00107\u001a\u00020\u000f2\u0006\u0010.\u001a\u00020!2\u0006\u0010/\u001a\u00020\u0006H\u0002J\u0006\u00108\u001a\u00020\u000fJ\u0010\u00109\u001a\u00020\u000f2\u0006\u0010:\u001a\u00020\u0006H\u0002J\u0008\u0010;\u001a\u00020\u000fH\u0002J\u0006\u0010<\u001a\u00020\u000fJ\u0008\u0010=\u001a\u00020\u000fH\u0002J\u0008\u0010>\u001a\u00020\u000fH\u0002J)\u0010?\u001a\u00020\u000f2!\u00101\u001a\u001d\u0012\u0013\u0012\u00110\u000b\u00a2\u0006\u000c\u0008\u000c\u0012\u0008\u0008\r\u0012\u0004\u0008\u0008(\u000e\u0012\u0004\u0012\u00020\u000f0\nJ,\u0010@\u001a\u00020\u000f2\u0006\u0010\u000e\u001a\u00020\u000b2\u0006\u0010A\u001a\u00020\u00062\u0008\u0008\u0002\u0010B\u001a\u00020\u00062\u0008\u0008\u0002\u0010C\u001a\u00020\u0004H\u0002J\u0008\u0010D\u001a\u00020\u000fH\u0002J\u0010\u0010E\u001a\u00020\u000f2\u0006\u0010F\u001a\u00020\u000bH\u0002J3\u0010G\u001a\u00020\u000f2\u0006\u0010F\u001a\u00020\u000b2!\u00101\u001a\u001d\u0012\u0013\u0012\u00110\u000b\u00a2\u0006\u000c\u0008\u000c\u0012\u0008\u0008\r\u0012\u0004\u0008\u0008(\u000e\u0012\u0004\u0012\u00020\u000f0\nH\u0016J\u0008\u0010H\u001a\u00020\u000fH\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082D\u00a2\u0006\u0002\n\u0000RC\u0010\u0007\u001a7\u0012\u0004\u0012\u00020\u0006\u0012-\u0012+\u0012\u001f\u0012\u001d\u0012\u0013\u0012\u00110\u000b\u00a2\u0006\u000c\u0008\u000c\u0012\u0008\u0008\r\u0012\u0004\u0008\u0008(\u000e\u0012\u0004\u0012\u00020\u000f0\n\u0012\u0006\u0012\u0004\u0018\u00010\u00100\t0\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0011\u001a\u00020\u0012X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0013\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\"\u0010\u0014\u001a\u0016\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u000b\u0012\u0004\u0012\u00020\u000f0\n\u0018\u00010\u0015X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0016\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0017\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0011\u0010\u0018\u001a\u00020\u0019\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001a\u0010\u001bR\u0010\u0010\u001c\u001a\u00020\u001dX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u001eR\u000e\u0010\u001f\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010 \u001a\u0004\u0018\u00010!X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010\"\u001a\u000e\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020!0\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010#\u001a\u0004\u0018\u00010\u0010X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010$\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\"\u0010%\u001a\u0016\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u00020\u000b\u0012\u0004\u0012\u00020\u000f0\n\u0018\u00010\u0015X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010&\u001a\u00020\'X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010(\u001a\u0004\u0018\u00010\u0010X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006I"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;",
        "Lcom/rokid/security/phone/sdk/api/wifip2p/api/IP2PConnectControl;",
        "()V",
        "MAX_RETRY_COUNT",
        "",
        "TAG",
        "",
        "connectP2pActions",
        "Ljava/util/concurrent/ConcurrentHashMap;",
        "Lkotlin/Pair;",
        "Lkotlin/Function1;",
        "",
        "Lkotlin/ParameterName;",
        "name",
        "isSuccess",
        "",
        "Lkotlinx/coroutines/Job;",
        "currentProcessingRequest",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "findDevice",
        "getKeepP2PConnectStateRef",
        "Ljava/lang/ref/WeakReference;",
        "isConnectionInProgress",
        "isNeedAutoConnect",
        "mIWifiP2PClientListener",
        "Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;",
        "getMIWifiP2PClientListener",
        "()Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mInterMessageListener$1;",
        "mRequestId",
        "mStartConnectP2PExtra",
        "Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;",
        "pendingRequests",
        "retryCheckJob",
        "retryCount",
        "setKeepP2PConnectRef",
        "startDiscoverTime",
        "",
        "timeoutJob",
        "cancelRetryCheckJob",
        "cancelTimeoutJob",
        "checkAndRetryDiscovery",
        "completeCurrentRequest",
        "connectP2p",
        "extra",
        "requestId",
        "getKeepP2PConnectState",
        "action",
        "isOpen",
        "onFail",
        "Lkotlin/Function2;",
        "errMsg",
        "code",
        "handleStartConnectP2pRequest",
        "init",
        "parseMessage",
        "msg",
        "processNextRequest",
        "release",
        "retryDiscovery",
        "scheduleRetryCheck",
        "sendConnectP2pRequest",
        "sendConnectP2pResponseMsg",
        "responseId",
        "errorMsg",
        "errorCode",
        "sendGetKeepP2PConnectStateMsg",
        "sendSetKeepP2PConnectMsg",
        "enable",
        "setKeepP2PConnect",
        "startConnectP2p",
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
.field private final MAX_RETRY_COUNT:I

.field private final TAG:Ljava/lang/String;

.field private final connectP2pActions:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Lkotlin/Pair<",
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlinx/coroutines/Job;",
            ">;>;"
        }
    .end annotation
.end field

.field private final currentProcessingRequest:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private findDevice:Z

.field private getKeepP2PConnectStateRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;>;"
        }
    .end annotation
.end field

.field private isConnectionInProgress:Z

.field private isNeedAutoConnect:Z

.field private final mIWifiP2PClientListener:Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

.field private final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mInterMessageListener$1;

.field private mRequestId:Ljava/lang/String;

.field private mStartConnectP2PExtra:Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

.field private final pendingRequests:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;",
            ">;"
        }
    .end annotation
.end field

.field private retryCheckJob:Lkotlinx/coroutines/Job;

.field private retryCount:I

.field private setKeepP2PConnectRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;>;"
        }
    .end annotation
.end field

.field private startDiscoverTime:J

.field private timeoutJob:Lkotlinx/coroutines/Job;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    const-string v0, "P2PConnectControl"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    .line 47
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mRequestId:Ljava/lang/String;

    .line 49
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->currentProcessingRequest:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 50
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->pendingRequests:Ljava/util/concurrent/ConcurrentHashMap;

    .line 55
    const/4 v0, 0x3

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->MAX_RETRY_COUNT:I

    .line 59
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->connectP2pActions:Ljava/util/concurrent/ConcurrentHashMap;

    .line 71
    new-instance v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mInterMessageListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mInterMessageListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mInterMessageListener$1;

    .line 121
    new-instance v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    check-cast v0, Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mIWifiP2PClientListener:Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

    .line 42
    return-void
.end method

.method public static final synthetic access$cancelTimeoutJob(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->cancelTimeoutJob()V

    return-void
.end method

.method public static final synthetic access$checkAndRetryDiscovery(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->checkAndRetryDiscovery()V

    return-void
.end method

.method public static final synthetic access$getConnectP2pActions$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/util/concurrent/ConcurrentHashMap;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->connectP2pActions:Ljava/util/concurrent/ConcurrentHashMap;

    return-object v0
.end method

.method public static final synthetic access$getFindDevice$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->findDevice:Z

    return v0
.end method

.method public static final synthetic access$getMRequestId$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mRequestId:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getMStartConnectP2PExtra$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mStartConnectP2PExtra:Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    return-object v0
.end method

.method public static final synthetic access$getRetryCount$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryCount:I

    return v0
.end method

.method public static final synthetic access$getStartDiscoverTime$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)J
    .locals 2
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    iget-wide v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->startDiscoverTime:J

    return-wide v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$isConnectionInProgress$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->isConnectionInProgress:Z

    return v0
.end method

.method public static final synthetic access$isNeedAutoConnect$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->isNeedAutoConnect:Z

    return v0
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;
    .param p1, "msg"    # Ljava/lang/String;

    .line 42
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$processNextRequest(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->processNextRequest()V

    return-void
.end method

.method public static final synthetic access$scheduleRetryCheck(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->scheduleRetryCheck()V

    return-void
.end method

.method public static final synthetic access$sendConnectP2pResponseMsg(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;ZLjava/lang/String;Ljava/lang/String;I)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;
    .param p1, "isSuccess"    # Z
    .param p2, "responseId"    # Ljava/lang/String;
    .param p3, "errorMsg"    # Ljava/lang/String;
    .param p4, "errorCode"    # I

    .line 42
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->sendConnectP2pResponseMsg(ZLjava/lang/String;Ljava/lang/String;I)V

    return-void
.end method

.method public static final synthetic access$setFindDevice$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;
    .param p1, "<set-?>"    # Z

    .line 42
    iput-boolean p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->findDevice:Z

    return-void
.end method

.method public static final synthetic access$setNeedAutoConnect$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;
    .param p1, "<set-?>"    # Z

    .line 42
    iput-boolean p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->isNeedAutoConnect:Z

    return-void
.end method

.method public static final synthetic access$setStartDiscoverTime$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;J)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;
    .param p1, "<set-?>"    # J

    .line 42
    iput-wide p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->startDiscoverTime:J

    return-void
.end method

.method public static final synthetic access$setTimeoutJob$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Lkotlinx/coroutines/Job;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;
    .param p1, "<set-?>"    # Lkotlinx/coroutines/Job;

    .line 42
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->timeoutJob:Lkotlinx/coroutines/Job;

    return-void
.end method

.method public static final synthetic access$startConnectP2p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    .line 42
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->startConnectP2p()V

    return-void
.end method

.method private final cancelRetryCheckJob()V
    .locals 3

    .line 367
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryCheckJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 368
    :cond_0
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryCheckJob:Lkotlinx/coroutines/Job;

    .line 369
    return-void
.end method

.method private final cancelTimeoutJob()V
    .locals 4

    .line 404
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->timeoutJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 405
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Timeout job cancelled, requestId: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mRequestId:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 406
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->timeoutJob:Lkotlinx/coroutines/Job;

    .line 407
    return-void
.end method

.method private final checkAndRetryDiscovery()V
    .locals 6

    .line 322
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->startDiscoverTime:J

    sub-long/2addr v0, v2

    .line 323
    .local v0, "elapsedTime":J
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "checkAndRetryDiscovery: elapsedTime = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "ms, retryCount = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryCount:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 325
    const-wide/16 v2, 0x1388

    cmp-long v2, v0, v2

    const-wide/16 v3, 0x4e20

    if-ltz v2, :cond_0

    cmp-long v2, v0, v3

    if-gez v2, :cond_0

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryCount:I

    iget v5, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->MAX_RETRY_COUNT:I

    if-ge v2, v5, :cond_0

    .line 326
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryDiscovery()V

    goto :goto_0

    .line 327
    :cond_0
    cmp-long v2, v0, v3

    if-ltz v2, :cond_1

    .line 328
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    const-string v3, "checkAndRetryDiscovery: \u5df2\u8d85\u65f6\uff0c\u4e0d\u8fdb\u884c\u91cd\u8bd5"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    .line 329
    :cond_1
    iget v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryCount:I

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->MAX_RETRY_COUNT:I

    if-lt v2, v3, :cond_2

    .line 330
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "checkAndRetryDiscovery: \u5df2\u8fbe\u5230\u6700\u5927\u91cd\u8bd5\u6b21\u6570("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->MAX_RETRY_COUNT:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x29

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 332
    :cond_2
    :goto_0
    return-void
.end method

.method private final completeCurrentRequest()V
    .locals 3

    .line 392
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->cancelTimeoutJob()V

    .line 393
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    check-cast v0, Lcom/rokid/security/phone/sdk/api/wifip2p/api/IWifiP2PClientOperate;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lcom/rokid/security/phone/sdk/api/wifip2p/api/IWifiP2PClientOperate$DefaultImpls;->stopPeerDiscovery$default(Lcom/rokid/security/phone/sdk/api/wifip2p/api/IWifiP2PClientOperate;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V

    .line 394
    iput-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mStartConnectP2PExtra:Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    .line 395
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mRequestId:Ljava/lang/String;

    .line 396
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->findDevice:Z

    .line 397
    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->isNeedAutoConnect:Z

    .line 398
    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->isConnectionInProgress:Z

    .line 399
    iput v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryCount:I

    .line 400
    return-void
.end method

.method private final connectP2p(Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;Ljava/lang/String;)V
    .locals 4
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;
    .param p2, "requestId"    # Ljava/lang/String;

    .line 224
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    const-string v1, "getApp()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Landroid/content/Context;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/utils/SystemStateUtils;->isWifiEnabled(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 225
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    const-string v2, "Wi-Fi is not turned on"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 226
    const/4 v0, -0x1

    invoke-direct {p0, v1, p2, v2, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->sendConnectP2pResponseMsg(ZLjava/lang/String;Ljava/lang/String;I)V

    .line 227
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->processNextRequest()V

    .line 228
    return-void

    .line 230
    :cond_0
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;->getGlass3DeviceName()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v2, 0x1

    if-eqz v0, :cond_2

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    move v0, v1

    goto :goto_1

    :cond_2
    :goto_0
    move v0, v2

    :goto_1
    if-eqz v0, :cond_3

    .line 231
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    const-string v2, "Wi-Fi glass3DeviceName is null or empty"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 232
    const/4 v0, -0x2

    invoke-direct {p0, v1, p2, v2, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->sendConnectP2pResponseMsg(ZLjava/lang/String;Ljava/lang/String;I)V

    .line 233
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->processNextRequest()V

    .line 234
    return-void

    .line 237
    :cond_3
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mStartConnectP2PExtra:Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    .line 238
    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mRequestId:Ljava/lang/String;

    .line 239
    iput-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->isConnectionInProgress:Z

    .line 241
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;

    invoke-direct {v1, p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$connectP2p$1;-><init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;Ljava/lang/String;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->isConnect(Lkotlin/jvm/functions/Function1;)V

    .line 259
    return-void
.end method

.method private final handleStartConnectP2pRequest(Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;Ljava/lang/String;)V
    .locals 3
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;
    .param p2, "requestId"    # Ljava/lang/String;

    .line 207
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mRequestId:Ljava/lang/String;

    invoke-static {v0, p2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->pendingRequests:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0, p2}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 212
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->currentProcessingRequest:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 213
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->pendingRequests:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v0, Ljava/util/Map;

    invoke-interface {v0, p2, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 214
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Request queued: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", queue size: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->pendingRequests:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v2}, Ljava/util/concurrent/ConcurrentHashMap;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 215
    return-void

    .line 218
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->currentProcessingRequest:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 219
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->connectP2p(Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;Ljava/lang/String;)V

    .line 220
    return-void

    .line 208
    :cond_2
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Duplicate request received: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 209
    return-void
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 8
    .param p1, "msg"    # Ljava/lang/String;

    .line 83
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "P2PConnectControl"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v0, v2, v5, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 84
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 85
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 86
    const-string v1, "extra"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 87
    .local v1, "extraJson":Ljava/lang/String;
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    if-eqz v2, :cond_0

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    const/4 v5, 0x1

    :cond_1
    if-nez v5, :cond_5

    .line 88
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 89
    .local v2, "extraJsonObject":Lorg/json/JSONObject;
    const-string v3, "methodName"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 90
    .local v3, "methodName":Ljava/lang/String;
    if-eqz v3, :cond_5

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    sparse-switch v4, :sswitch_data_0

    goto/16 :goto_0

    :sswitch_0
    const-string v4, "Get_Keep_P2P_Connect_State_Response"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    goto/16 :goto_0

    .line 109
    :cond_2
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    const-class v5, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;

    invoke-virtual {v4, v1, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;

    .line 110
    .local v4, "extra":Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;
    if-eqz v4, :cond_5

    .line 111
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, " mGetKeepP2PConnectStateAction --- isOpen = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;->isOpen()Z

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 112
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->getKeepP2PConnectStateRef:Ljava/lang/ref/WeakReference;

    if-eqz v5, :cond_5

    invoke-virtual {v5}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lkotlin/jvm/functions/Function1;

    if-eqz v5, :cond_5

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;->isOpen()Z

    move-result v6

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-interface {v5, v6}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_0

    .line 90
    .end local v4    # "extra":Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateResponseExtra;
    :sswitch_1
    const-string v4, "Set_Keep_P2P_Connect_Response"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_3

    goto :goto_0

    .line 101
    :cond_3
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    const-class v5, Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectResponseExtra;

    invoke-virtual {v4, v1, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectResponseExtra;

    .line 102
    .local v4, "extra":Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectResponseExtra;
    if-eqz v4, :cond_5

    .line 103
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, " mSetKeepP2PConnectAction --- isSuccess = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectResponseExtra;->isSuccess()Z

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 104
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->setKeepP2PConnectRef:Ljava/lang/ref/WeakReference;

    if-eqz v5, :cond_5

    invoke-virtual {v5}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lkotlin/jvm/functions/Function1;

    if-eqz v5, :cond_5

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectResponseExtra;->isSuccess()Z

    move-result v6

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-interface {v5, v6}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 90
    .end local v4    # "extra":Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectResponseExtra;
    :sswitch_2
    const-string v4, "Start_Connect_P2P"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_4

    goto :goto_0

    .line 93
    :cond_4
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    const-class v5, Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    invoke-virtual {v4, v1, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    .line 94
    .local v4, "extra":Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;
    if-eqz v4, :cond_5

    .line 95
    const-string v5, "requestId"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 96
    .local v6, "requestId":Ljava/lang/String;
    invoke-static {v6, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0, v4, v6}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->handleStartConnectP2pRequest(Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;Ljava/lang/String;)V

    .line 119
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "extraJson":Ljava/lang/String;
    .end local v2    # "extraJsonObject":Lorg/json/JSONObject;
    .end local v3    # "methodName":Ljava/lang/String;
    .end local v4    # "extra":Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;
    .end local v6    # "requestId":Ljava/lang/String;
    :cond_5
    :goto_0
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        -0x497222c4 -> :sswitch_2
        -0x457c6fbc -> :sswitch_1
        0x18eaa906 -> :sswitch_0
    .end sparse-switch
.end method

.method private final processNextRequest()V
    .locals 4

    .line 373
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->completeCurrentRequest()V

    .line 375
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->pendingRequests:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentHashMap;->isEmpty()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 376
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->currentProcessingRequest:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 377
    return-void

    .line 380
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->pendingRequests:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentHashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    const-string v2, "pendingRequests.entries"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Ljava/lang/Iterable;

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->firstOrNull(Ljava/lang/Iterable;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 381
    .local v0, "entry":Ljava/util/Map$Entry;
    if-eqz v0, :cond_1

    .line 382
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    const-string v2, "entry.key"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v1, Ljava/lang/String;

    .line 383
    .local v1, "requestId":Ljava/lang/String;
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    const-string v3, "entry.value"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v2, Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;

    .line 384
    .local v2, "extra":Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->pendingRequests:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v3, v1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 385
    invoke-direct {p0, v2, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->connectP2p(Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;Ljava/lang/String;)V

    .end local v1    # "requestId":Ljava/lang/String;
    .end local v2    # "extra":Lcom/rokid/security/sdk/base/common/StartConnectP2PExtra;
    goto :goto_0

    .line 387
    :cond_1
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->currentProcessingRequest:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 389
    :goto_0
    return-void
.end method

.method private final retryDiscovery()V
    .locals 3

    .line 335
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryCount:I

    .line 336
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "retryDiscovery: \u7b2c"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryCount:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string/jumbo v2, "\u6b21\u91cd\u8bd5"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 337
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$retryDiscovery$1;

    invoke-direct {v1, p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$retryDiscovery$1;-><init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->stopPeerDiscovery(Lkotlin/jvm/functions/Function1;)V

    .line 361
    return-void
.end method

.method private final scheduleRetryCheck()V
    .locals 6

    .line 307
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->cancelRetryCheckJob()V

    .line 309
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    new-instance v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$scheduleRetryCheck$1;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$scheduleRetryCheck$1;-><init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Lkotlin/coroutines/Continuation;)V

    move-object v3, v1

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->retryCheckJob:Lkotlinx/coroutines/Job;

    .line 316
    return-void
.end method

.method private final sendConnectP2pResponseMsg(ZLjava/lang/String;Ljava/lang/String;I)V
    .locals 10
    .param p1, "isSuccess"    # Z
    .param p2, "responseId"    # Ljava/lang/String;
    .param p3, "errorMsg"    # Ljava/lang/String;
    .param p4, "errorCode"    # I

    .line 411
    nop

    .line 412
    :try_start_0
    new-instance v0, Lcom/rokid/security/sdk/base/common/ConnectP2PResponseExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/ConnectP2PResponseExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendConnectP2pResponseMsg_u24lambda_u241":Lcom/rokid/security/sdk/base/common/ConnectP2PResponseExtra;
    const/4 v2, 0x0

    .line 413
    .local v2, "$i$a$-apply-P2PConnectControl$sendConnectP2pResponseMsg$connectP2PResponseExtra$1":I
    const-string v3, "Connect_P2P_Response"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/ConnectP2PResponseExtra;->setMethodName(Ljava/lang/String;)V

    .line 414
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/ConnectP2PResponseExtra;->setSuccess(Z)V

    .line 415
    invoke-virtual {v1, p3}, Lcom/rokid/security/sdk/base/common/ConnectP2PResponseExtra;->setErrorMsg(Ljava/lang/String;)V

    .line 416
    invoke-virtual {v1, p4}, Lcom/rokid/security/sdk/base/common/ConnectP2PResponseExtra;->setErrorCode(I)V

    .line 417
    nop

    .line 412
    .end local v1    # "$this$sendConnectP2pResponseMsg_u24lambda_u241":Lcom/rokid/security/sdk/base/common/ConnectP2PResponseExtra;
    .end local v2    # "$i$a$-apply-P2PConnectControl$sendConnectP2pResponseMsg$connectP2PResponseExtra$1":I
    nop

    .line 418
    .local v0, "connectP2PResponseExtra":Lcom/rokid/security/sdk/base/common/ConnectP2PResponseExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 419
    .local v1, "extra":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "P2PConnectControl"

    const-string v4, "extra"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x14

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    move-object v6, p2

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "connectP2PResponseExtra":Lcom/rokid/security/sdk/base/common/ConnectP2PResponseExtra;
    .end local v1    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 420
    :catch_0
    move-exception v0

    .line 421
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 422
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendConnectP2pResponseMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 424
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method static synthetic sendConnectP2pResponseMsg$default(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;ZLjava/lang/String;Ljava/lang/String;IILjava/lang/Object;)V
    .locals 0

    .line 410
    and-int/lit8 p6, p5, 0x4

    if-eqz p6, :cond_0

    const-string p3, ""

    :cond_0
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_1

    const/4 p4, 0x0

    :cond_1
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->sendConnectP2pResponseMsg(ZLjava/lang/String;Ljava/lang/String;I)V

    return-void
.end method

.method private final sendGetKeepP2PConnectStateMsg()V
    .locals 10

    .line 465
    nop

    .line 466
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "sendGetKeepP2PConnectStateMsg: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 467
    new-instance v0, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateRequestExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateRequestExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendGetKeepP2PConnectStateMsg_u24lambda_u243":Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateRequestExtra;
    const/4 v2, 0x0

    .line 468
    .local v2, "$i$a$-apply-P2PConnectControl$sendGetKeepP2PConnectStateMsg$getKeepP2PConnectStateRequestExtra$1":I
    const-string v3, "Get_Keep_P2P_Connect_State_Request"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateRequestExtra;->setMethodName(Ljava/lang/String;)V

    .line 469
    nop

    .line 467
    .end local v1    # "$this$sendGetKeepP2PConnectStateMsg_u24lambda_u243":Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateRequestExtra;
    .end local v2    # "$i$a$-apply-P2PConnectControl$sendGetKeepP2PConnectStateMsg$getKeepP2PConnectStateRequestExtra$1":I
    nop

    .line 470
    .local v0, "getKeepP2PConnectStateRequestExtra":Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateRequestExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 471
    .local v1, "extra":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "P2PConnectControl"

    const-string v4, "extra"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "getKeepP2PConnectStateRequestExtra":Lcom/rokid/security/sdk/base/common/GetKeepP2PConnectStateRequestExtra;
    .end local v1    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 472
    :catch_0
    move-exception v0

    .line 473
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 474
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendGetKeepP2PConnectStateMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 476
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final sendSetKeepP2PConnectMsg(Z)V
    .locals 10
    .param p1, "enable"    # Z

    .line 450
    nop

    .line 451
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "sendSetKeepP2PConnectMsg: enable = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 452
    new-instance v0, Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectRequestExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectRequestExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendSetKeepP2PConnectMsg_u24lambda_u242":Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectRequestExtra;
    const/4 v2, 0x0

    .line 453
    .local v2, "$i$a$-apply-P2PConnectControl$sendSetKeepP2PConnectMsg$setKeepP2PConnectRequestExtra$1":I
    const-string v3, "Set_Keep_P2P_Connect_Request"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectRequestExtra;->setMethodName(Ljava/lang/String;)V

    .line 454
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectRequestExtra;->setOpen(Z)V

    .line 455
    nop

    .line 452
    .end local v1    # "$this$sendSetKeepP2PConnectMsg_u24lambda_u242":Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectRequestExtra;
    .end local v2    # "$i$a$-apply-P2PConnectControl$sendSetKeepP2PConnectMsg$setKeepP2PConnectRequestExtra$1":I
    nop

    .line 456
    .local v0, "setKeepP2PConnectRequestExtra":Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectRequestExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 457
    .local v1, "extra":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "P2PConnectControl"

    const-string v4, "extra"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "setKeepP2PConnectRequestExtra":Lcom/rokid/security/sdk/base/common/SetKeepP2PConnectRequestExtra;
    .end local v1    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 458
    :catch_0
    move-exception v0

    .line 459
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 460
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendSetKeepP2PConnectMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 462
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final startConnectP2p()V
    .locals 8

    .line 262
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "startConnectP2p: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 263
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1;-><init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Lkotlin/coroutines/Continuation;)V

    move-object v5, v0

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 301
    return-void
.end method


# virtual methods
.method public getKeepP2PConnectState(Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function2;)V
    .locals 2
    .param p1, "action"    # Lkotlin/jvm/functions/Function1;
    .param p2, "onFail"    # Lkotlin/jvm/functions/Function2;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function2<",
            "-",
            "Ljava/lang/String;",
            "-",
            "Ljava/lang/Integer;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "action"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onFail"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 439
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    const-string v1, "getKeepP2PConnectState: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 440
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isConnected()Z

    move-result v0

    if-nez v0, :cond_0

    .line 441
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    const-string v1, "getKeepP2PConnectState: \u84dd\u7259\u672a\u8fde\u63a5,\u8bf7\u5148\u8fde\u63a5\u4e0a\u84dd\u7259"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 442
    const/4 v0, -0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string/jumbo v1, "\u84dd\u7259\u672a\u8fde\u63a5,\u8bf7\u5148\u8fde\u63a5\u4e0a\u84dd\u7259"

    invoke-interface {p2, v1, v0}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 443
    return-void

    .line 445
    :cond_0
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->getKeepP2PConnectStateRef:Ljava/lang/ref/WeakReference;

    .line 446
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->sendGetKeepP2PConnectStateMsg()V

    .line 447
    return-void
.end method

.method public final getMIWifiP2PClientListener()Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;
    .locals 1

    .line 121
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mIWifiP2PClientListener:Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

    return-object v0
.end method

.method public final init()V
    .locals 2

    .line 170
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 171
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mIWifiP2PClientListener:Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->addWifiP2PClientListener(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;)V

    .line 172
    return-void
.end method

.method public final release()V
    .locals 9

    .line 479
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->getKeepP2PConnectStateRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->clear()V

    .line 480
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->setKeepP2PConnectRef:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->clear()V

    .line 481
    :cond_1
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 482
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->mIWifiP2PClientListener:Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->removeWifiP2PClientListener(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PClientListener;)V

    .line 483
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->pendingRequests:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentHashMap;->clear()V

    .line 484
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->completeCurrentRequest()V

    .line 485
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->currentProcessingRequest:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 486
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->connectP2pActions:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v0, Ljava/util/Map;

    .local v0, "$this$forEach$iv":Ljava/util/Map;
    const/4 v1, 0x0

    .line 494
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .local v3, "element$iv":Ljava/util/Map$Entry;
    const/4 v4, 0x0

    .line 486
    .local v4, "$i$a$-forEach-P2PConnectControl$release$1":I
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lkotlin/Pair;

    .line 487
    .local v5, "pair":Lkotlin/Pair;
    invoke-virtual {v5}, Lkotlin/Pair;->getSecond()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lkotlinx/coroutines/Job;

    if-eqz v6, :cond_2

    const/4 v7, 0x1

    const/4 v8, 0x0

    invoke-static {v6, v8, v7, v8}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 488
    :cond_2
    nop

    .line 494
    .end local v4    # "$i$a$-forEach-P2PConnectControl$release$1":I
    .end local v5    # "pair":Lkotlin/Pair;
    nop

    .end local v3    # "element$iv":Ljava/util/Map$Entry;
    goto :goto_0

    .line 495
    :cond_3
    nop

    .line 489
    .end local v0    # "$this$forEach$iv":Ljava/util/Map;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->connectP2pActions:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentHashMap;->clear()V

    .line 490
    return-void
.end method

.method public final sendConnectP2pRequest(Lkotlin/jvm/functions/Function1;)V
    .locals 12
    .param p1, "action"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "action"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 176
    nop

    .line 178
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    .line 179
    .local v0, "requestId":Ljava/lang/String;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendConnectP2pRequest:  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 180
    sget-object v1, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isConnected()Z

    move-result v1

    if-nez v1, :cond_0

    .line 181
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    const-string/jumbo v2, "sendConnectP2pRequest: \u84dd\u7259\u672a\u8fde\u63a5,\u8bf7\u5148\u8fde\u63a5\u4e0a\u84dd\u7259"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 182
    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-interface {p1, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 183
    return-void

    .line 185
    :cond_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v2, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v0, v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;-><init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v4, v2

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v1

    move-object v9, v1

    .line 193
    .local v9, "timeoutJob2":Lkotlinx/coroutines/Job;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->connectP2pActions:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v1, Ljava/util/Map;

    new-instance v2, Lkotlin/Pair;

    invoke-direct {v2, p1, v9}, Lkotlin/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    invoke-interface {v1, v0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 194
    new-instance v1, Lcom/rokid/security/sdk/base/common/ConnectP2PRequestExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/ConnectP2PRequestExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$sendConnectP2pRequest_u24lambda_u240":Lcom/rokid/security/sdk/base/common/ConnectP2PRequestExtra;
    const/4 v3, 0x0

    .line 195
    .local v3, "$i$a$-apply-P2PConnectControl$sendConnectP2pRequest$connectP2PResponseExtra$1":I
    const-string v4, "Connect_P2P_Request"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/ConnectP2PRequestExtra;->setMethodName(Ljava/lang/String;)V

    .line 196
    nop

    .line 194
    .end local v2    # "$this$sendConnectP2pRequest_u24lambda_u240":Lcom/rokid/security/sdk/base/common/ConnectP2PRequestExtra;
    .end local v3    # "$i$a$-apply-P2PConnectControl$sendConnectP2pRequest$connectP2PResponseExtra$1":I
    move-object v10, v1

    .line 197
    .local v10, "connectP2PResponseExtra":Lcom/rokid/security/sdk/base/common/ConnectP2PRequestExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v10}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    move-object v11, v1

    .line 198
    .local v11, "extra":Ljava/lang/String;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v2, "P2PConnectControl"

    const-string v3, "extra"

    invoke-static {v11, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v7, 0x18

    const/4 v8, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v3, v11

    move-object v4, v0

    invoke-static/range {v1 .. v8}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "requestId":Ljava/lang/String;
    .end local v9    # "timeoutJob2":Lkotlinx/coroutines/Job;
    .end local v10    # "connectP2PResponseExtra":Lcom/rokid/security/sdk/base/common/ConnectP2PRequestExtra;
    .end local v11    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 199
    :catch_0
    move-exception v0

    .line 200
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 201
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "sendConnectP2pResponseMsg error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 203
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public setKeepP2PConnect(ZLkotlin/jvm/functions/Function1;)V
    .locals 3
    .param p1, "enable"    # Z
    .param p2, "action"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "action"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 428
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "setKeepP2PConnect: enable = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 429
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->isConnected()Z

    move-result v0

    if-nez v0, :cond_0

    .line 430
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "setKeepP2PConnect: \u84dd\u7259\u672a\u8fde\u63a5,\u8bf7\u5148\u8fde\u63a5\u4e0a\u84dd\u7259"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 431
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-interface {p2, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 432
    return-void

    .line 434
    :cond_0
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->setKeepP2PConnectRef:Ljava/lang/ref/WeakReference;

    .line 435
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->sendSetKeepP2PConnectMsg(Z)V

    .line 436
    return-void
.end method
