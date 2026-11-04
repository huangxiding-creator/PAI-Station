.class public final Lcom/rokid/security/phone/sdk/server/track/TrackManager;
.super Ljava/lang/Object;
.source "TrackManager.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nTrackManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 TrackManager.kt\ncom/rokid/security/phone/sdk/server/track/TrackManager\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,411:1\n1855#2,2:412\n1855#2,2:414\n*S KotlinDebug\n*F\n+ 1 TrackManager.kt\ncom/rokid/security/phone/sdk/server/track/TrackManager\n*L\n214#1:412,2\n337#1:414,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u00a5\u0001\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0012\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010#\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0010 \n\u0002\u0008\n\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0003*\u0001\u0017\u0008\u0000\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010%\u001a\u00020&2\u0006\u0010\'\u001a\u00020\u001dJ)\u0010(\u001a\u00020&2\u0016\u0010)\u001a\u0012\u0012\u0004\u0012\u00020+0*j\u0008\u0012\u0004\u0012\u00020+`,H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010-J\u000e\u0010.\u001a\u00020&2\u0006\u0010/\u001a\u00020\"J\u0006\u00100\u001a\u00020&J\u0006\u00101\u001a\u00020&J\u0018\u00102\u001a\u0004\u0018\u0001032\u000c\u0010\u0014\u001a\u0008\u0012\u0004\u0012\u00020304H\u0002J\u0006\u00105\u001a\u00020\"J\u0006\u00106\u001a\u00020&J\u0008\u00107\u001a\u00020&H\u0002J\u0008\u00108\u001a\u00020&H\u0002J\u0010\u00109\u001a\u00020&2\u0006\u0010:\u001a\u00020\u0004H\u0002J\u0006\u0010;\u001a\u00020&J\u000e\u0010<\u001a\u00020&2\u0006\u0010\'\u001a\u00020\u001dJ,\u0010=\u001a\u00020&2\u001c\u0010>\u001a\u0018\u0008\u0001\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020&0@\u0012\u0006\u0012\u0004\u0018\u00010\u00010?\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010AJ\u0008\u0010B\u001a\u00020&H\u0002J\u0016\u0010C\u001a\u00020&2\u000c\u0010\u0014\u001a\u0008\u0012\u0004\u0012\u00020\u001504H\u0002J\u0010\u0010D\u001a\u00020&2\u0006\u0010E\u001a\u00020FH\u0002J\u000e\u0010G\u001a\u00020&2\u0006\u0010H\u001a\u00020\u0007R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0017\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0006\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0008\u0010\tR\u0014\u0010\n\u001a\u0008\u0012\u0004\u0012\u00020\u000c0\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\r\u001a\u00020\u000eX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000f\u001a\u00020\u0010X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0011\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0013\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0014\u001a\u0008\u0012\u0004\u0012\u00020\u00150\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0016\u001a\u00020\u0017X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0018R\u000e\u0010\u0019\u001a\u00020\u001aX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u001b\u001a\u0008\u0012\u0004\u0012\u00020\u001d0\u001cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001e\u001a\u00020\u001fX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010 \u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010!\u001a\u00020\"X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010#\u001a\u0004\u0018\u00010$X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006I"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/track/TrackManager;",
        "",
        "()V",
        "TAG",
        "",
        "eventFlow",
        "Lkotlinx/coroutines/flow/MutableSharedFlow;",
        "",
        "getEventFlow",
        "()Lkotlinx/coroutines/flow/MutableSharedFlow;",
        "faceTracklist",
        "Ljava/util/concurrent/CopyOnWriteArrayList;",
        "Lcom/rokid/security/sdk/base/common/outside/FaceTrack;",
        "frameCount",
        "Ljava/util/concurrent/atomic/AtomicLong;",
        "imageInput",
        "Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;",
        "inited",
        "",
        "isTest",
        "list",
        "Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;",
        "mScope",
        "Lkotlinx/coroutines/CoroutineScope;",
        "mTrackListeners",
        "",
        "Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;",
        "mutex",
        "Lkotlinx/coroutines/sync/Mutex;",
        "recgStop",
        "recogMode",
        "",
        "rectF",
        "Landroid/graphics/RectF;",
        "addTrackListener",
        "",
        "listener",
        "changeFaceModel",
        "faceTrackResult",
        "Ljava/util/ArrayList;",
        "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
        "Lkotlin/collections/ArrayList;",
        "(Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "changeMode",
        "mode",
        "disableRecog",
        "enableRecog",
        "getBestLPRResult",
        "Lcom/rokid/aicore/api/callback/result/LPRResult;",
        "",
        "getMode",
        "init",
        "initFace",
        "initLpr",
        "parseMessage",
        "msg",
        "release",
        "removeTrackListener",
        "runBlockSerially",
        "block",
        "Lkotlin/Function1;",
        "Lkotlin/coroutines/Continuation;",
        "(Lkotlin/jvm/functions/Function1;)V",
        "saveData",
        "sendFaceTrack",
        "sendLPRTrack",
        "lprModel",
        "Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;",
        "setFrameData",
        "data",
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

.field private final eventFlow:Lkotlinx/coroutines/flow/MutableSharedFlow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/flow/MutableSharedFlow<",
            "[B>;"
        }
    .end annotation
.end field

.field private faceTracklist:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Lcom/rokid/security/sdk/base/common/outside/FaceTrack;",
            ">;"
        }
    .end annotation
.end field

.field private final frameCount:Ljava/util/concurrent/atomic/AtomicLong;

.field private imageInput:Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

.field private inited:Z

.field private isTest:Z

.field private list:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;",
            ">;"
        }
    .end annotation
.end field

.field private final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;

.field private mScope:Lkotlinx/coroutines/CoroutineScope;

.field private final mTrackListeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;",
            ">;"
        }
    .end annotation
.end field

.field private final mutex:Lkotlinx/coroutines/sync/Mutex;

.field private recgStop:Z

.field private volatile recogMode:I

.field private rectF:Landroid/graphics/RectF;


# direct methods
.method public constructor <init>()V
    .locals 10

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 51
    const-string v0, "TrackManager"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->TAG:Ljava/lang/String;

    .line 56
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->list:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 57
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->faceTracklist:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 59
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mTrackListeners:Ljava/util/Set;

    .line 63
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recgStop:Z

    .line 64
    new-instance v1, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v2, 0x1

    invoke-direct {v1, v2, v3}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->frameCount:Ljava/util/concurrent/atomic/AtomicLong;

    .line 65
    new-instance v1, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    .line 66
    sget v5, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_WIDTH:I

    .line 67
    sget v6, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_HEIGHT:I

    .line 68
    const/16 v2, 0x4f6

    new-array v7, v2, [B

    .line 69
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->frameCount:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v8

    .line 65
    move-object v4, v1

    invoke-direct/range {v4 .. v9}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;-><init>(II[BJ)V

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->imageInput:Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    .line 73
    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Lkotlinx/coroutines/sync/MutexKt;->Mutex$default(ZILjava/lang/Object;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mutex:Lkotlinx/coroutines/sync/Mutex;

    .line 74
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mScope:Lkotlinx/coroutines/CoroutineScope;

    .line 84
    new-instance v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;

    .line 361
    const/4 v0, 0x7

    invoke-static {v1, v1, v2, v0, v2}, Lkotlinx/coroutines/flow/SharedFlowKt;->MutableSharedFlow$default(IILkotlinx/coroutines/channels/BufferOverflow;ILjava/lang/Object;)Lkotlinx/coroutines/flow/MutableSharedFlow;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->eventFlow:Lkotlinx/coroutines/flow/MutableSharedFlow;

    .line 50
    return-void
.end method

.method public static final synthetic access$getBestLPRResult(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/util/List;)Lcom/rokid/aicore/api/callback/result/LPRResult;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;
    .param p1, "list"    # Ljava/util/List;

    .line 50
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->getBestLPRResult(Ljava/util/List;)Lcom/rokid/aicore/api/callback/result/LPRResult;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getImageInput$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    .line 50
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->imageInput:Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    return-object v0
.end method

.method public static final synthetic access$getList$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/concurrent/CopyOnWriteArrayList;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    .line 50
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->list:Ljava/util/concurrent/CopyOnWriteArrayList;

    return-object v0
.end method

.method public static final synthetic access$getMTrackListeners$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/Set;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    .line 50
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mTrackListeners:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getMutex$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Lkotlinx/coroutines/sync/Mutex;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    .line 50
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mutex:Lkotlinx/coroutines/sync/Mutex;

    return-object v0
.end method

.method public static final synthetic access$getRecogMode$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    .line 50
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recogMode:I

    return v0
.end method

.method public static final synthetic access$getRectF$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Landroid/graphics/RectF;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    .line 50
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->rectF:Landroid/graphics/RectF;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    .line 50
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;
    .param p1, "msg"    # Ljava/lang/String;

    .line 50
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$sendFaceTrack(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/util/List;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;
    .param p1, "list"    # Ljava/util/List;

    .line 50
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->sendFaceTrack(Ljava/util/List;)V

    return-void
.end method

.method public static final synthetic access$sendLPRTrack(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;
    .param p1, "lprModel"    # Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;

    .line 50
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->sendLPRTrack(Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;)V

    return-void
.end method

.method public static final synthetic access$setRectF$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Landroid/graphics/RectF;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;
    .param p1, "<set-?>"    # Landroid/graphics/RectF;

    .line 50
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->rectF:Landroid/graphics/RectF;

    return-void
.end method

.method private final getBestLPRResult(Ljava/util/List;)Lcom/rokid/aicore/api/callback/result/LPRResult;
    .locals 7
    .param p1, "list"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "+",
            "Lcom/rokid/aicore/api/callback/result/LPRResult;",
            ">;)",
            "Lcom/rokid/aicore/api/callback/result/LPRResult;"
        }
    .end annotation

    .line 316
    const/4 v0, 0x0

    .line 317
    .local v0, "bestLpr":Lcom/rokid/aicore/api/callback/result/LPRResult;
    const/4 v1, 0x0

    .line 318
    .local v1, "imageData":[B
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/aicore/api/callback/result/LPRResult;

    .line 319
    .local v3, "lprResult":Lcom/rokid/aicore/api/callback/result/LPRResult;
    if-eqz v3, :cond_0

    .line 320
    if-eqz v0, :cond_1

    invoke-virtual {v3}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getScore()F

    move-result v4

    invoke-virtual {v0}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getScore()F

    move-result v5

    cmpl-float v4, v4, v5

    if-lez v4, :cond_0

    .line 321
    :cond_1
    move-object v0, v3

    .line 322
    invoke-virtual {v3}, Lcom/rokid/aicore/api/callback/result/LPRResult;->getData()[B

    move-result-object v1

    .end local v3    # "lprResult":Lcom/rokid/aicore/api/callback/result/LPRResult;
    goto :goto_0

    .line 326
    :cond_2
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getBestLPRResult candidates="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " found="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/4 v4, 0x1

    const/4 v5, 0x0

    if-eqz v0, :cond_3

    move v6, v4

    goto :goto_1

    :cond_3
    move v6, v5

    :goto_1
    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v6, " imagePresent="

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    if-eqz v1, :cond_4

    goto :goto_2

    :cond_4
    move v4, v5

    :goto_2
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 327
    if-eqz v0, :cond_6

    if-nez v1, :cond_5

    goto :goto_3

    .line 328
    :cond_5
    move-object v2, v0

    goto :goto_4

    .line 327
    :cond_6
    :goto_3
    const/4 v2, 0x0

    :goto_4
    return-object v2
.end method

.method private final initFace()V
    .locals 2

    .line 135
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->isTest:Z

    if-eqz v0, :cond_0

    .line 136
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->saveData()V

    .line 139
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;

    invoke-direct {v1, p0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;-><init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)V

    check-cast v1, Lcom/rokid/aicore/api/callback/face/FaceCallback;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->initFaceSdk(Lcom/rokid/aicore/api/callback/face/FaceCallback;)V

    .line 175
    return-void
.end method

.method private final initLpr()V
    .locals 2

    .line 230
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initLpr$1;

    invoke-direct {v1, p0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initLpr$1;-><init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)V

    check-cast v1, Lcom/rokid/aicore/api/callback/LPRCallback;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->initLprSdk(Lcom/rokid/aicore/api/callback/LPRCallback;)V

    .line 268
    return-void
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 6
    .param p1, "msg"    # Ljava/lang/String;

    .line 101
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "TRACK_ACTION"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v0, v2, v5, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 102
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 103
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 104
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    const-string v2, "extra"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-class v3, Lcom/rokid/security/sdk/base/common/TrackExtra;

    invoke-virtual {v1, v2, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/TrackExtra;

    .line 105
    .local v1, "mTrackExtra":Lcom/rokid/security/sdk/base/common/TrackExtra;
    if-eqz v1, :cond_1

    .line 106
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/TrackExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    .line 108
    const-string/jumbo v3, "start_Track"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 109
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/TrackExtra;->getMode()I

    move-result v2

    invoke-virtual {p0, v2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->changeMode(I)V

    .line 110
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->enableRecog()V

    goto :goto_0

    .line 113
    :cond_0
    const-string/jumbo v3, "stop_Track"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 114
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->disableRecog()V

    .line 121
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "mTrackExtra":Lcom/rokid/security/sdk/base/common/TrackExtra;
    :cond_1
    :goto_0
    return-void
.end method

.method private final saveData()V
    .locals 6

    .line 178
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    new-instance v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$saveData$1;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$saveData$1;-><init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Lkotlin/coroutines/Continuation;)V

    move-object v3, v1

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 210
    return-void
.end method

.method private final sendFaceTrack(Ljava/util/List;)V
    .locals 19
    .param p1, "list"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;",
            ">;)V"
        }
    .end annotation

    .line 213
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->faceTracklist:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 214
    move-object/from16 v1, p1

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 412
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;

    .local v5, "it":Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;
    const/4 v6, 0x0

    .line 215
    .local v6, "$i$a$-forEach-TrackManager$sendFaceTrack$1":I
    iget-object v7, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->faceTracklist:Ljava/util/concurrent/CopyOnWriteArrayList;

    new-instance v15, Lcom/rokid/security/sdk/base/common/outside/FaceTrack;

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->getFrameWidth()I

    move-result v9

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->getFrameHeight()I

    move-result v10

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->getRect()Landroid/graphics/Rect;

    move-result-object v11

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->getTrackId()J

    move-result-wide v12

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->getFaceScore()F

    move-result v14

    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->getFrameId()J

    move-result-wide v16

    move-object v8, v15

    move-object/from16 v18, v1

    move-object v1, v15

    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .local v18, "$this$forEach$iv":Ljava/lang/Iterable;
    move-wide/from16 v15, v16

    invoke-direct/range {v8 .. v16}, Lcom/rokid/security/sdk/base/common/outside/FaceTrack;-><init>(IILandroid/graphics/Rect;JFJ)V

    invoke-virtual {v7, v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 216
    nop

    .line 412
    .end local v5    # "it":Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;
    .end local v6    # "$i$a$-forEach-TrackManager$sendFaceTrack$1":I
    move-object/from16 v1, v18

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 413
    .end local v18    # "$this$forEach$iv":Ljava/lang/Iterable;
    .restart local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    :cond_0
    move-object/from16 v18, v1

    .line 217
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    new-instance v1, Lcom/rokid/security/sdk/base/common/TrackExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/TrackExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$sendFaceTrack_u24lambda_u241":Lcom/rokid/security/sdk/base/common/TrackExtra;
    const/4 v3, 0x0

    .line 218
    .local v3, "$i$a$-apply-TrackManager$sendFaceTrack$trackExtra$1":I
    const-string v4, "onFaceTrack"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/TrackExtra;->setMethodName(Ljava/lang/String;)V

    .line 219
    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->faceTracklist:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v4, Ljava/util/List;

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/TrackExtra;->setFaceTrack(Ljava/util/List;)V

    .line 220
    nop

    .line 217
    .end local v2    # "$this$sendFaceTrack_u24lambda_u241":Lcom/rokid/security/sdk/base/common/TrackExtra;
    .end local v3    # "$i$a$-apply-TrackManager$sendFaceTrack$trackExtra$1":I
    nop

    .line 221
    .local v1, "trackExtra":Lcom/rokid/security/sdk/base/common/TrackExtra;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 222
    .local v2, "extra":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v4, "extra"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x1c

    const/4 v10, 0x0

    const-string v4, "TRACK_ACTION"

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v5, v2

    invoke-static/range {v3 .. v10}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 223
    return-void
.end method

.method private final sendLPRTrack(Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;)V
    .locals 11
    .param p1, "lprModel"    # Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;

    .line 271
    new-instance v7, Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->getFrameWidth()I

    move-result v1

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->getFrameHeight()I

    move-result v2

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->getRect()Landroid/graphics/Rect;

    move-result-object v3

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->getScore()F

    move-result v4

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->getPlateNo()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->getColor()Ljava/lang/String;

    move-result-object v6

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/sdk/base/common/outside/LPRTrack;-><init>(IILandroid/graphics/Rect;FLjava/lang/String;Ljava/lang/String;)V

    .line 272
    .local v0, "lprTrack":Lcom/rokid/security/sdk/base/common/outside/LPRTrack;
    new-instance v1, Lcom/rokid/security/sdk/base/common/TrackExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/TrackExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$sendLPRTrack_u24lambda_u242":Lcom/rokid/security/sdk/base/common/TrackExtra;
    const/4 v3, 0x0

    .line 273
    .local v3, "$i$a$-apply-TrackManager$sendLPRTrack$trackExtra$1":I
    const-string v4, "onLPRTrack"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/TrackExtra;->setMethodName(Ljava/lang/String;)V

    .line 274
    invoke-virtual {v2, v0}, Lcom/rokid/security/sdk/base/common/TrackExtra;->setLprTrack(Lcom/rokid/security/sdk/base/common/outside/LPRTrack;)V

    .line 275
    nop

    .line 272
    .end local v2    # "$this$sendLPRTrack_u24lambda_u242":Lcom/rokid/security/sdk/base/common/TrackExtra;
    .end local v3    # "$i$a$-apply-TrackManager$sendLPRTrack$trackExtra$1":I
    nop

    .line 276
    .local v1, "trackExtra":Lcom/rokid/security/sdk/base/common/TrackExtra;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 277
    .local v2, "extra":Ljava/lang/String;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v4, "extra"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v9, 0x1c

    const/4 v10, 0x0

    const-string v4, "TRACK_ACTION"

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v5, v2

    invoke-static/range {v3 .. v10}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 278
    return-void
.end method


# virtual methods
.method public final addTrackListener(Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 392
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mTrackListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 393
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mTrackListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 395
    :cond_0
    return-void
.end method

.method public final changeFaceModel(Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 3
    .param p1, "faceTrackResult"    # Ljava/util/ArrayList;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 286
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getDefault()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;

    const/4 v2, 0x0

    invoke-direct {v1, p0, p1, v2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;-><init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)V

    check-cast v1, Lkotlin/jvm/functions/Function2;

    invoke-static {v0, v1, p2}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    if-ne v0, v1, :cond_0

    return-object v0

    :cond_0
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 308
    return-object v0
.end method

.method public final changeMode(I)V
    .locals 6
    .param p1, "mode"    # I

    .line 333
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " changeMode recogMode = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recogMode:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", mode = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 334
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recogMode:I

    if-eq v0, p1, :cond_1

    .line 335
    iput p1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recogMode:I

    .line 336
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->changeMode(I)V

    .line 337
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mTrackListeners:Ljava/util/Set;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 414
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;
    const/4 v5, 0x0

    .line 338
    .local v5, "$i$a$-forEach-TrackManager$changeMode$1":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;->onModeChange(I)V

    .line 339
    nop

    .line 414
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;
    .end local v5    # "$i$a$-forEach-TrackManager$changeMode$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 415
    :cond_0
    nop

    .line 341
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    :cond_1
    return-void
.end method

.method public final disableRecog()V
    .locals 1

    .line 351
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recgStop:Z

    .line 352
    return-void
.end method

.method public final enableRecog()V
    .locals 1

    .line 358
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recgStop:Z

    .line 359
    return-void
.end method

.method public final getEventFlow()Lkotlinx/coroutines/flow/MutableSharedFlow;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/MutableSharedFlow<",
            "[B>;"
        }
    .end annotation

    .line 361
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->eventFlow:Lkotlinx/coroutines/flow/MutableSharedFlow;

    return-object v0
.end method

.method public final getMode()I
    .locals 1

    .line 344
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recogMode:I

    return v0
.end method

.method public final init()V
    .locals 2

    .line 124
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->TAG:Ljava/lang/String;

    const-string v1, " init"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 125
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->inited:Z

    if-eqz v0, :cond_0

    .line 126
    return-void

    .line 128
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 129
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->initFace()V

    .line 130
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->initLpr()V

    .line 131
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->inited:Z

    .line 132
    return-void
.end method

.method public final release()V
    .locals 2

    .line 402
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/track/TrackManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 403
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mTrackListeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 404
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recgStop:Z

    .line 405
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->destroy()V

    .line 406
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->inited:Z

    .line 407
    iput v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recogMode:I

    .line 408
    return-void
.end method

.method public final removeTrackListener(Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 398
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mTrackListeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 399
    return-void
.end method

.method public final runBlockSerially(Lkotlin/jvm/functions/Function1;)V
    .locals 7
    .param p1, "block"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;+",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    const-string v0, "block"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 76
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->mScope:Lkotlinx/coroutines/CoroutineScope;

    new-instance v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$runBlockSerially$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, p1, v2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$runBlockSerially$1;-><init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 81
    return-void
.end method

.method public final setFrameData([B)V
    .locals 8
    .param p1, "data"    # [B

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 367
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->inited:Z

    if-eqz v0, :cond_3

    array-length v0, p1

    const/4 v1, 0x0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    if-nez v0, :cond_3

    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recgStop:Z

    if-nez v0, :cond_3

    iget v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->recogMode:I

    if-nez v0, :cond_1

    goto :goto_1

    .line 371
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->imageInput:Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    array-length v2, p1

    new-array v2, v2, [B

    invoke-virtual {v0, v2}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->setData([B)V

    .line 372
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->imageInput:Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->frameCount:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->setFrame_id(J)V

    .line 373
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->imageInput:Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    sget v2, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_HEIGHT:I

    invoke-virtual {v0, v2}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->setHeight(I)V

    .line 374
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->imageInput:Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    sget v2, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_WIDTH:I

    invoke-virtual {v0, v2}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->setWidth(I)V

    .line 375
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->imageInput:Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->getData()[B

    move-result-object v0

    array-length v2, p1

    invoke-static {p1, v1, v0, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 378
    new-instance v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$setFrameData$1;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$setFrameData$1;-><init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/jvm/functions/Function1;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->runBlockSerially(Lkotlin/jvm/functions/Function1;)V

    .line 383
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->isTest:Z

    if-eqz v0, :cond_2

    .line 384
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$setFrameData$2;

    invoke-direct {v0, p0, p1, v1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$setFrameData$2;-><init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;[BLkotlin/coroutines/Continuation;)V

    move-object v5, v0

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 388
    :cond_2
    return-void

    .line 368
    :cond_3
    :goto_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->TAG:Ljava/lang/String;

    const-string/jumbo v1, "setFrameData: --------stopFrameData"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 369
    return-void
.end method
