.class public final Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;
.super Ljava/lang/Object;
.source "InspectVideoUploadManager.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nInspectVideoUploadManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 InspectVideoUploadManager.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,259:1\n2624#2,3:260\n1#3:263\n*S KotlinDebug\n*F\n+ 1 InspectVideoUploadManager.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager\n*L\n51#1:260,3\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000d\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\u0018\u00002\u00020\u0001B\u001b\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u000c\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u0005\u00a2\u0006\u0002\u0010\u0007J\u0010\u0010\u001a\u001a\u00020\u001b2\u0006\u0010\u001c\u001a\u00020\tH\u0002J\u0016\u0010\u001d\u001a\u00020\u001b2\u0006\u0010\u001c\u001a\u00020\t2\u0006\u0010\u001e\u001a\u00020\tJ\u0006\u0010\u001f\u001a\u00020\u0006J\u0008\u0010 \u001a\u00020\u001bH\u0002J\u000e\u0010!\u001a\u00020\u001b2\u0006\u0010\u001c\u001a\u00020\tJ\u0018\u0010\"\u001a\u0004\u0018\u00010\t2\u0006\u0010\u001c\u001a\u00020\t2\u0006\u0010#\u001a\u00020\tJ\'\u0010$\u001a\u00020\u001b2\u0006\u0010%\u001a\u00020\u00192\u000c\u0010&\u001a\u0008\u0012\u0004\u0012\u00020\u00060\'H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010(J\u0010\u0010)\u001a\u00020\u001b2\u0006\u0010%\u001a\u00020\u0019H\u0002J\u0008\u0010*\u001a\u00020\u001bH\u0002J\u0006\u0010+\u001a\u00020\u001bJ\u0008\u0010,\u001a\u00020-H\u0002R\u000e\u0010\u0008\u001a\u00020\tX\u0082D\u00a2\u0006\u0002\n\u0000R\u0014\u0010\n\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u0005X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0017\u0010\u000f\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u0010\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012R\u000e\u0010\u0013\u001a\u00020\u0014X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0015\u001a\u00020\u0016X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0017\u001a\u0008\u0012\u0004\u0012\u00020\u00190\u0018X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006."
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;",
        "",
        "cacheDir",
        "Ljava/io/File;",
        "getIsInspection",
        "Lkotlin/Function0;",
        "",
        "(Ljava/io/File;Lkotlin/jvm/functions/Function0;)V",
        "TAG",
        "",
        "_uploadEnabled",
        "Lkotlinx/coroutines/flow/MutableStateFlow;",
        "gson",
        "Lcom/google/gson/Gson;",
        "queueFile",
        "uploadEnabled",
        "Lkotlinx/coroutines/flow/StateFlow;",
        "getUploadEnabled",
        "()Lkotlinx/coroutines/flow/StateFlow;",
        "uploadMutex",
        "Lkotlinx/coroutines/sync/Mutex;",
        "uploadScope",
        "Lkotlinx/coroutines/CoroutineScope;",
        "videoQueue",
        "",
        "Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;",
        "deleteVideoFromCacheJson",
        "",
        "filePath",
        "enqueueVideo",
        "sessionId",
        "hasPendingUpload",
        "loadQueueFromDisk",
        "markUploadFailed",
        "markUploadSuccess",
        "url",
        "performUpload",
        "item",
        "callback",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "removeFromQueue",
        "saveQueueToDisk",
        "shutdown",
        "startUploadLoop",
        "Lkotlinx/coroutines/Job;",
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

.field private final _uploadEnabled:Lkotlinx/coroutines/flow/MutableStateFlow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/flow/MutableStateFlow<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private final cacheDir:Ljava/io/File;

.field private final getIsInspection:Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function0<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private final gson:Lcom/google/gson/Gson;

.field private final queueFile:Ljava/io/File;

.field private final uploadEnabled:Lkotlinx/coroutines/flow/StateFlow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/flow/StateFlow<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private final uploadMutex:Lkotlinx/coroutines/sync/Mutex;

.field private final uploadScope:Lkotlinx/coroutines/CoroutineScope;

.field private final videoQueue:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/io/File;Lkotlin/jvm/functions/Function0;)V
    .locals 3
    .param p1, "cacheDir"    # Ljava/io/File;
    .param p2, "getIsInspection"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Lkotlin/jvm/functions/Function0<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    const-string v0, "cacheDir"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "getIsInspection"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->cacheDir:Ljava/io/File;

    .line 23
    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->getIsInspection:Lkotlin/jvm/functions/Function0;

    .line 26
    const-string v0, "VideoUploadManager"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    .line 27
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->gson:Lcom/google/gson/Gson;

    .line 28
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->cacheDir:Ljava/io/File;

    const-string/jumbo v2, "video_upload_queue.json"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->queueFile:Ljava/io/File;

    .line 30
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->uploadScope:Lkotlinx/coroutines/CoroutineScope;

    .line 31
    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-static {v1, v2, v0}, Lkotlinx/coroutines/sync/MutexKt;->Mutex$default(ZILjava/lang/Object;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->uploadMutex:Lkotlinx/coroutines/sync/Mutex;

    .line 33
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v0}, Lkotlinx/coroutines/flow/StateFlowKt;->MutableStateFlow(Ljava/lang/Object;)Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->_uploadEnabled:Lkotlinx/coroutines/flow/MutableStateFlow;

    .line 34
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->_uploadEnabled:Lkotlinx/coroutines/flow/MutableStateFlow;

    invoke-static {v0}, Lkotlinx/coroutines/flow/FlowKt;->asStateFlow(Lkotlinx/coroutines/flow/MutableStateFlow;)Lkotlinx/coroutines/flow/StateFlow;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->uploadEnabled:Lkotlinx/coroutines/flow/StateFlow;

    .line 36
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    .line 38
    nop

    .line 39
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->loadQueueFromDisk()V

    .line 40
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->startUploadLoop()Lkotlinx/coroutines/Job;

    .line 41
    nop

    .line 21
    return-void
.end method

.method public static final synthetic access$getGetIsInspection$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Lkotlin/jvm/functions/Function0;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    .line 21
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->getIsInspection:Lkotlin/jvm/functions/Function0;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    .line 21
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getUploadMutex$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Lkotlinx/coroutines/sync/Mutex;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    .line 21
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->uploadMutex:Lkotlinx/coroutines/sync/Mutex;

    return-object v0
.end method

.method public static final synthetic access$getVideoQueue$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;)Ljava/util/List;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    .line 21
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    return-object v0
.end method

.method public static final synthetic access$performUpload(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;
    .param p1, "item"    # Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    .param p2, "callback"    # Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .param p3, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 21
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->performUpload(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$removeFromQueue(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;
    .param p1, "item"    # Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    .line 21
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->removeFromQueue(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;)V

    return-void
.end method

.method private final deleteVideoFromCacheJson(Ljava/lang/String;)V
    .locals 11
    .param p1, "filePath"    # Ljava/lang/String;

    .line 167
    const-string v0, " from video_cache.json"

    .line 168
    :try_start_0
    new-instance v1, Ljava/io/File;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->cacheDir:Ljava/io/File;

    const-string/jumbo v3, "video_cache.json"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 169
    .local v1, "cacheJsonFile":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    .line 170
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    const-string/jumbo v3, "\ud83e\uddfe video_cache.json not found, skip delete."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 171
    return-void

    .line 174
    :cond_0
    new-instance v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$deleteVideoFromCacheJson$type$1;

    invoke-direct {v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$deleteVideoFromCacheJson$type$1;-><init>()V

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$deleteVideoFromCacheJson$type$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v2

    .line 176
    .local v2, "type":Ljava/lang/reflect/Type;
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->gson:Lcom/google/gson/Gson;

    new-instance v4, Ljava/io/FileReader;

    invoke-direct {v4, v1}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    check-cast v4, Ljava/io/Reader;

    invoke-virtual {v3, v4, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/io/Reader;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/List;

    if-nez v3, :cond_1

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    check-cast v3, Ljava/util/List;

    .line 175
    :cond_1
    nop

    .line 178
    .local v3, "cacheList":Ljava/util/List;
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    .line 179
    .local v4, "iterator":Ljava/util/Iterator;
    const/4 v5, 0x0

    .line 180
    .local v5, "removed":Z
    :cond_2
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_3

    .line 181
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    .line 182
    .local v6, "item":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getFilePath()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 183
    invoke-interface {v4}, Ljava/util/Iterator;->remove()V

    .line 184
    const/4 v5, 0x1

    .line 185
    iget-object v7, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "\ud83e\uddf9 Removed "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 186
    nop

    .line 190
    .end local v6    # "item":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    :cond_3
    if-eqz v5, :cond_4

    .line 191
    new-instance v6, Ljava/io/FileWriter;

    invoke-direct {v6, v1}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    check-cast v6, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v7, v6

    check-cast v7, Ljava/io/FileWriter;

    .local v7, "writer":Ljava/io/FileWriter;
    const/4 v8, 0x0

    .line 192
    .local v8, "$i$a$-use-InspectVideoUploadManager$deleteVideoFromCacheJson$1":I
    iget-object v9, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->gson:Lcom/google/gson/Gson;

    move-object v10, v7

    check-cast v10, Ljava/lang/Appendable;

    invoke-virtual {v9, v3, v10}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;Ljava/lang/Appendable;)V

    .line 193
    nop

    .end local v7    # "writer":Ljava/io/FileWriter;
    .end local v8    # "$i$a$-use-InspectVideoUploadManager$deleteVideoFromCacheJson$1":I
    sget-object v7, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 191
    const/4 v7, 0x0

    :try_start_2
    invoke-static {v6, v7}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    :catchall_0
    move-exception v7

    .end local v1    # "cacheJsonFile":Ljava/io/File;
    .end local v2    # "type":Ljava/lang/reflect/Type;
    .end local v3    # "cacheList":Ljava/util/List;
    .end local v4    # "iterator":Ljava/util/Iterator;
    .end local v5    # "removed":Z
    .end local p1    # "filePath":Ljava/lang/String;
    :try_start_3
    throw v7
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v1    # "cacheJsonFile":Ljava/io/File;
    .restart local v2    # "type":Ljava/lang/reflect/Type;
    .restart local v3    # "cacheList":Ljava/util/List;
    .restart local v4    # "iterator":Ljava/util/Iterator;
    .restart local v5    # "removed":Z
    .restart local p1    # "filePath":Ljava/lang/String;
    :catchall_1
    move-exception v8

    :try_start_4
    invoke-static {v6, v7}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local p1    # "filePath":Ljava/lang/String;
    throw v8
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 195
    .end local v1    # "cacheJsonFile":Ljava/io/File;
    .end local v2    # "type":Ljava/lang/reflect/Type;
    .end local v3    # "cacheList":Ljava/util/List;
    .end local v4    # "iterator":Ljava/util/Iterator;
    .end local v5    # "removed":Z
    .restart local p1    # "filePath":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 196
    .local v1, "e":Ljava/lang/Exception;
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u274c Failed to remove "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v3, v1

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v2, v0, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 198
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_4
    :goto_0
    return-void
.end method

.method private final loadQueueFromDisk()V
    .locals 8

    .line 233
    nop

    .line 234
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->queueFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 235
    new-instance v0, Ljava/io/FileReader;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->queueFile:Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    check-cast v0, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v1, v0

    check-cast v1, Ljava/io/FileReader;

    .local v1, "reader":Ljava/io/FileReader;
    const/4 v2, 0x0

    .line 236
    .local v2, "$i$a$-use-InspectVideoUploadManager$loadQueueFromDisk$1":I
    new-instance v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$loadQueueFromDisk$1$type$1;

    invoke-direct {v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$loadQueueFromDisk$1$type$1;-><init>()V

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$loadQueueFromDisk$1$type$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v3

    .line 237
    .local v3, "type":Ljava/lang/reflect/Type;
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->gson:Lcom/google/gson/Gson;

    move-object v5, v1

    check-cast v5, Ljava/io/Reader;

    invoke-virtual {v4, v5, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/io/Reader;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v4

    const-string v5, "gson.fromJson(reader, type)"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v4, Ljava/util/List;

    .line 238
    .local v4, "savedList":Ljava/util/List;
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->clear()V

    .line 239
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    move-object v6, v4

    check-cast v6, Ljava/util/Collection;

    invoke-interface {v5, v6}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 240
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "\ud83d\udcc2 Loaded "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " items from cache"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 235
    .end local v1    # "reader":Ljava/io/FileReader;
    .end local v2    # "$i$a$-use-InspectVideoUploadManager$loadQueueFromDisk$1":I
    .end local v3    # "type":Ljava/lang/reflect/Type;
    .end local v4    # "savedList":Ljava/util/List;
    const/4 v1, 0x0

    :try_start_2
    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

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
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 243
    :catch_0
    move-exception v0

    .line 244
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    const-string v2, "Failed to load queue"

    move-object v3, v0

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v1, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 246
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    return-void
.end method

.method private final performUpload(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 3
    .param p1, "item"    # Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    .param p2, "callback"    # Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .param p3, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 90
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;

    const/4 v2, 0x0

    invoke-direct {v1, p1, p0, p2, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$performUpload$2;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Lkotlin/coroutines/Continuation;)V

    check-cast v1, Lkotlin/jvm/functions/Function2;

    invoke-static {v0, v1, p3}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    if-ne v0, v1, :cond_0

    return-object v0

    :cond_0
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 125
    return-object v0
.end method

.method private final removeFromQueue(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;)V
    .locals 3
    .param p1, "item"    # Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    .line 210
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    monitor-enter v0

    const/4 v1, 0x0

    .line 211
    .local v1, "$i$a$-synchronized-InspectVideoUploadManager$removeFromQueue$1":I
    :try_start_0
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    invoke-interface {v2, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 212
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->saveQueueToDisk()V

    .line 213
    nop

    .end local v1    # "$i$a$-synchronized-InspectVideoUploadManager$removeFromQueue$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 210
    monitor-exit v0

    .line 214
    return-void

    .line 210
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private final saveQueueToDisk()V
    .locals 7

    .line 217
    nop

    .line 218
    :try_start_0
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->queueFile:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->queueFile:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".tmp"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 219
    .local v0, "tmp":Ljava/io/File;
    new-instance v1, Ljava/io/FileWriter;

    invoke-direct {v1, v0}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    check-cast v1, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v2, v1

    check-cast v2, Ljava/io/FileWriter;

    .local v2, "writer":Ljava/io/FileWriter;
    const/4 v3, 0x0

    .line 220
    .local v3, "$i$a$-use-InspectVideoUploadManager$saveQueueToDisk$1":I
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->gson:Lcom/google/gson/Gson;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    move-object v6, v2

    check-cast v6, Ljava/lang/Appendable;

    invoke-virtual {v4, v5, v6}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;Ljava/lang/Appendable;)V

    .line 221
    nop

    .end local v2    # "writer":Ljava/io/FileWriter;
    .end local v3    # "$i$a$-use-InspectVideoUploadManager$saveQueueToDisk$1":I
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 219
    const/4 v2, 0x0

    :try_start_2
    invoke-static {v1, v2}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 223
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->queueFile:Ljava/io/File;

    invoke-virtual {v0, v1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 224
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    const-string v2, "Failed to rename tmp queue file"

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 219
    :catchall_0
    move-exception v2

    .end local v0    # "tmp":Ljava/io/File;
    :try_start_3
    throw v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v0    # "tmp":Ljava/io/File;
    :catchall_1
    move-exception v3

    :try_start_4
    invoke-static {v1, v2}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v3
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 226
    .end local v0    # "tmp":Ljava/io/File;
    :catch_0
    move-exception v0

    .line 227
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    const-string v2, "Failed to save queue"

    move-object v3, v0

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v1, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 229
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    return-void
.end method

.method private final startUploadLoop()Lkotlinx/coroutines/Job;
    .locals 6

    .line 59
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->uploadScope:Lkotlinx/coroutines/CoroutineScope;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;Lkotlin/coroutines/Continuation;)V

    move-object v3, v1

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    .line 87
    return-object v0
.end method


# virtual methods
.method public final enqueueVideo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 10
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "sessionId"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "sessionId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 50
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    monitor-enter v0

    const/4 v1, 0x0

    .line 51
    .local v1, "$i$a$-synchronized-InspectVideoUploadManager$enqueueVideo$1":I
    :try_start_0
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    check-cast v2, Ljava/lang/Iterable;

    .local v2, "$this$none$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 260
    .local v3, "$i$f$none":I
    instance-of v4, v2, Ljava/util/Collection;

    const/4 v5, 0x1

    if-eqz v4, :cond_0

    move-object v4, v2

    check-cast v4, Ljava/util/Collection;

    invoke-interface {v4}, Ljava/util/Collection;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_0

    goto :goto_0

    .line 261
    :cond_0
    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_2

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    .local v6, "element$iv":Ljava/lang/Object;
    move-object v7, v6

    check-cast v7, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    .local v7, "it":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    const/4 v8, 0x0

    .line 51
    .local v8, "$i$a$-none-InspectVideoUploadManager$enqueueVideo$1$1":I
    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getFilePath()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v9

    .line 261
    .end local v7    # "it":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    .end local v8    # "$i$a$-none-InspectVideoUploadManager$enqueueVideo$1$1":I
    if-eqz v9, :cond_1

    const/4 v5, 0x0

    goto :goto_0

    .line 262
    .end local v6    # "element$iv":Ljava/lang/Object;
    :cond_2
    nop

    .line 51
    .end local v2    # "$this$none$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$none":I
    :goto_0
    if-eqz v5, :cond_3

    .line 52
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    new-instance v9, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    const/4 v7, 0x4

    const/4 v8, 0x0

    const/4 v6, 0x0

    move-object v3, v9

    move-object v4, p1

    move-object v5, p2

    invoke-direct/range {v3 .. v8}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;-><init>(Ljava/lang/String;Ljava/lang/String;ZILkotlin/jvm/internal/DefaultConstructorMarker;)V

    invoke-interface {v2, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 53
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->saveQueueToDisk()V

    .line 54
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u2705 Added to upload queue: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " [session="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x5d

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 56
    :cond_3
    nop

    .end local v1    # "$i$a$-synchronized-InspectVideoUploadManager$enqueueVideo$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 50
    monitor-exit v0

    .line 57
    return-void

    .line 50
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public final getUploadEnabled()Lkotlinx/coroutines/flow/StateFlow;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/StateFlow<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    .line 34
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->uploadEnabled:Lkotlinx/coroutines/flow/StateFlow;

    return-object v0
.end method

.method public final hasPendingUpload()Z
    .locals 3

    .line 44
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    monitor-enter v0

    const/4 v1, 0x0

    .line 45
    .local v1, "$i$a$-synchronized-InspectVideoUploadManager$hasPendingUpload$1":I
    :try_start_0
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    check-cast v2, Ljava/util/Collection;

    invoke-interface {v2}, Ljava/util/Collection;->isEmpty()Z

    move-result v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    xor-int/lit8 v2, v2, 0x1

    .line 44
    .end local v1    # "$i$a$-synchronized-InspectVideoUploadManager$hasPendingUpload$1":I
    monitor-exit v0

    return v2

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public final markUploadFailed(Ljava/lang/String;)V
    .locals 3
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 205
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u26a0\ufe0f markUploadFailed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 207
    return-void
.end method

.method public final markUploadSuccess(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "url"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "url"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 136
    const/4 v0, 0x0

    .line 137
    .local v0, "sessionId":Ljava/lang/String;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    monitor-enter v1

    .line 263
    const/4 v2, 0x0

    .line 137
    .local v2, "$i$a$-synchronized-InspectVideoUploadManager$markUploadSuccess$item$1":I
    :try_start_0
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->videoQueue:Ljava/util/List;

    check-cast v3, Ljava/lang/Iterable;

    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    move-object v5, v4

    check-cast v5, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    .line 263
    .local v5, "it":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    const/4 v6, 0x0

    .line 137
    .local v6, "$i$a$-find-InspectVideoUploadManager$markUploadSuccess$item$1$1":I
    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getFilePath()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v7

    .end local v5    # "it":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    .end local v6    # "$i$a$-find-InspectVideoUploadManager$markUploadSuccess$item$1$1":I
    if-eqz v7, :cond_0

    goto :goto_0

    :cond_1
    const/4 v4, 0x0

    :goto_0
    check-cast v4, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v2    # "$i$a$-synchronized-InspectVideoUploadManager$markUploadSuccess$item$1":I
    monitor-exit v1

    move-object v1, v4

    .line 139
    .local v1, "item":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    if-eqz v1, :cond_3

    .line 140
    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->getSessionId()Ljava/lang/String;

    move-result-object v0

    .line 141
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u2705 markUploadSuccess: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " -> "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " [session="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x5d

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 144
    invoke-direct {p0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->removeFromQueue(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;)V

    .line 147
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 148
    .local v2, "file":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 149
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    move-result v3

    .line 150
    .local v3, "deleted":Z
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\ud83d\uddd1 File deleted: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ", success="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 154
    .end local v3    # "deleted":Z
    :cond_2
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->deleteVideoFromCacheJson(Ljava/lang/String;)V

    .end local v2    # "file":Ljava/io/File;
    goto :goto_1

    .line 156
    :cond_3
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u26a0\ufe0f markUploadSuccess: item not found for filePath="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 159
    :goto_1
    return-object v0

    .line 137
    .end local v1    # "item":Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;
    :catchall_0
    move-exception v2

    monitor-exit v1

    throw v2
.end method

.method public final shutdown()V
    .locals 3

    .line 249
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->uploadScope:Lkotlinx/coroutines/CoroutineScope;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/CoroutineScopeKt;->cancel$default(Lkotlinx/coroutines/CoroutineScope;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 250
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->saveQueueToDisk()V

    .line 251
    return-void
.end method
