.class public final Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
.super Ljava/lang/Object;
.source "ImageUploadManager.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nImageUploadManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ImageUploadManager.kt\ncom/rokid/security/phone/sdk/server/inspection/ImageUploadManager\n+ 2 StateFlow.kt\nkotlinx/coroutines/flow/StateFlowKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,136:1\n230#2,5:137\n230#2,5:142\n1#3:147\n*S KotlinDebug\n*F\n+ 1 ImageUploadManager.kt\ncom/rokid/security/phone/sdk/server/inspection/ImageUploadManager\n*L\n46#1:137,5\n51#1:142,5\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000V\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u001b\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u000c\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u0005\u00a2\u0006\u0002\u0010\u0007J\u0016\u0010\u0017\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\t2\u0006\u0010\u001a\u001a\u00020\u0006J\u0006\u0010\u001b\u001a\u00020\u0018J\u0008\u0010\u001c\u001a\u00020\u001dH\u0002J\u0006\u0010\u001e\u001a\u00020\u0018J\u000e\u0010\u001f\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\tJ\u0019\u0010 \u001a\u00020\u00062\u0006\u0010\u0019\u001a\u00020\tH\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010!R\u000e\u0010\u0008\u001a\u00020\tX\u0082D\u00a2\u0006\u0002\n\u0000R\u0014\u0010\n\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0004\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u0005X\u0082\u0004\u00a2\u0006\u0002\n\u0000R \u0010\u000c\u001a\u0014\u0012\u0004\u0012\u00020\t\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00060\u000e0\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0017\u0010\u000f\u001a\u0008\u0012\u0004\u0012\u00020\u00060\u0010\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012R\u000e\u0010\u0013\u001a\u00020\u0014X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0015\u001a\u00020\u0016X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\""
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;",
        "",
        "inspectionDataManager",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;",
        "getIsInspection",
        "Lkotlin/Function0;",
        "",
        "(Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;Lkotlin/jvm/functions/Function0;)V",
        "TAG",
        "",
        "_uploadEnabled",
        "Lkotlinx/coroutines/flow/MutableStateFlow;",
        "inflightUploads",
        "Ljava/util/concurrent/ConcurrentHashMap;",
        "Lkotlinx/coroutines/CompletableDeferred;",
        "uploadEnabled",
        "Lkotlinx/coroutines/flow/StateFlow;",
        "getUploadEnabled",
        "()Lkotlinx/coroutines/flow/StateFlow;",
        "uploadMutex",
        "Lkotlinx/coroutines/sync/Mutex;",
        "uploadScope",
        "Lkotlinx/coroutines/CoroutineScope;",
        "notifyUploadResult",
        "",
        "filePath",
        "success",
        "pauseUploads",
        "startUploadLoop",
        "Lkotlinx/coroutines/Job;",
        "startUploads",
        "uploadPerFile",
        "uploadPerFileSuspend",
        "(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
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

.field private final getIsInspection:Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function0<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private final inflightUploads:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Lkotlinx/coroutines/CompletableDeferred<",
            "Ljava/lang/Boolean;",
            ">;>;"
        }
    .end annotation
.end field

.field private final inspectionDataManager:Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

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


# direct methods
.method public constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;Lkotlin/jvm/functions/Function0;)V
    .locals 3
    .param p1, "inspectionDataManager"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;
    .param p2, "getIsInspection"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;",
            "Lkotlin/jvm/functions/Function0<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    const-string v0, "inspectionDataManager"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "getIsInspection"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->inspectionDataManager:Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    .line 32
    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->getIsInspection:Lkotlin/jvm/functions/Function0;

    .line 35
    const-string v0, "ImageUploadManager"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->TAG:Ljava/lang/String;

    .line 36
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->uploadScope:Lkotlinx/coroutines/CoroutineScope;

    .line 37
    const/4 v0, 0x1

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-static {v1}, Lkotlinx/coroutines/flow/StateFlowKt;->MutableStateFlow(Ljava/lang/Object;)Lkotlinx/coroutines/flow/MutableStateFlow;

    move-result-object v1

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->_uploadEnabled:Lkotlinx/coroutines/flow/MutableStateFlow;

    .line 38
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->_uploadEnabled:Lkotlinx/coroutines/flow/MutableStateFlow;

    invoke-static {v1}, Lkotlinx/coroutines/flow/FlowKt;->asStateFlow(Lkotlinx/coroutines/flow/MutableStateFlow;)Lkotlinx/coroutines/flow/StateFlow;

    move-result-object v1

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->uploadEnabled:Lkotlinx/coroutines/flow/StateFlow;

    .line 39
    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Lkotlinx/coroutines/sync/MutexKt;->Mutex$default(ZILjava/lang/Object;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->uploadMutex:Lkotlinx/coroutines/sync/Mutex;

    .line 41
    nop

    .line 42
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->startUploadLoop()Lkotlinx/coroutines/Job;

    .line 43
    nop

    .line 79
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->inflightUploads:Ljava/util/concurrent/ConcurrentHashMap;

    .line 30
    return-void
.end method

.method public static final synthetic access$getInspectionDataManager$p(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;)Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    .line 30
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->inspectionDataManager:Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    .line 30
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getUploadMutex$p(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;)Lkotlinx/coroutines/sync/Mutex;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    .line 30
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->uploadMutex:Lkotlinx/coroutines/sync/Mutex;

    return-object v0
.end method

.method public static final synthetic access$uploadPerFileSuspend(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 30
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->uploadPerFileSuspend(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method private final startUploadLoop()Lkotlinx/coroutines/Job;
    .locals 6

    .line 55
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->uploadScope:Lkotlinx/coroutines/CoroutineScope;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;Lkotlin/coroutines/Continuation;)V

    move-object v3, v1

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    .line 77
    return-object v0
.end method

.method private final uploadPerFileSuspend(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/lang/Boolean;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;

    if-eqz v0, :cond_0

    move-object v0, p2

    check-cast v0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;

    iget v1, v0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p2, v0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->label:I

    sub-int/2addr p2, v2

    iput p2, v0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;

    invoke-direct {v0, p0, p2}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p2, v0

    .local p2, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v0, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->result:Ljava/lang/Object;

    .local v0, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 84
    iget v2, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->label:I

    const/4 v3, 0x0

    const/4 v4, 0x1

    const/4 v5, 0x0

    packed-switch v2, :pswitch_data_0

    .end local v0    # "$result":Ljava/lang/Object;
    .end local p2    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .restart local v0    # "$result":Ljava/lang/Object;
    .restart local p2    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    iget-object p1, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$2:Ljava/lang/Object;

    check-cast p1, Lkotlinx/coroutines/CompletableDeferred;

    .local p1, "deferred":Lkotlinx/coroutines/CompletableDeferred;
    iget-object v1, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$1:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    .local v1, "filePath":Ljava/lang/String;
    iget-object v2, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$0:Ljava/lang/Object;

    check-cast v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    .local v2, "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    :try_start_0
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v5, v0

    goto/16 :goto_3

    .line 117
    .end local p1    # "deferred":Lkotlinx/coroutines/CompletableDeferred;
    :catchall_0
    move-exception p1

    goto/16 :goto_6

    .line 112
    .restart local p1    # "deferred":Lkotlinx/coroutines/CompletableDeferred;
    :catch_0
    move-exception v5

    goto/16 :goto_4

    .line 84
    .end local v1    # "filePath":Ljava/lang/String;
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    .end local p1    # "deferred":Lkotlinx/coroutines/CompletableDeferred;
    :pswitch_1
    iget-object p1, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$2:Ljava/lang/Object;

    check-cast p1, Lkotlinx/coroutines/CompletableDeferred;

    .restart local p1    # "deferred":Lkotlinx/coroutines/CompletableDeferred;
    iget-object v2, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$1:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    .local v2, "filePath":Ljava/lang/String;
    iget-object v6, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$0:Ljava/lang/Object;

    check-cast v6, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    .local v6, "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    :try_start_1
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_2

    .line 117
    .end local p1    # "deferred":Lkotlinx/coroutines/CompletableDeferred;
    :catchall_1
    move-exception p1

    move-object v1, v2

    move-object v2, v6

    goto/16 :goto_6

    .line 84
    .end local v2    # "filePath":Ljava/lang/String;
    .end local v6    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    :pswitch_2
    const/4 p1, 0x0

    .local p1, "$i$a$-let-ImageUploadManager$uploadPerFileSuspend$2":I
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, v0

    goto :goto_1

    .end local p1    # "$i$a$-let-ImageUploadManager$uploadPerFileSuspend$2":I
    :pswitch_3
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v2, p0

    .line 86
    .local v2, "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    .local p1, "filePath":Ljava/lang/String;
    iget-object v6, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->inflightUploads:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v6, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lkotlinx/coroutines/CompletableDeferred;

    if-eqz v6, :cond_2

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    .end local p1    # "filePath":Ljava/lang/String;
    move-object p1, v6

    .line 147
    .local p1, "it":Lkotlinx/coroutines/CompletableDeferred;
    const/4 v2, 0x0

    .line 86
    .local v2, "$i$a$-let-ImageUploadManager$uploadPerFileSuspend$2":I
    iput v4, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->label:I

    invoke-interface {p1, p2}, Lkotlinx/coroutines/CompletableDeferred;->await(Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    .end local p1    # "it":Lkotlinx/coroutines/CompletableDeferred;
    if-ne p1, v1, :cond_1

    .line 84
    return-object v1

    .line 86
    :cond_1
    move-object v1, p1

    move p1, v2

    .line 88
    .end local v2    # "$i$a$-let-ImageUploadManager$uploadPerFileSuspend$2":I
    .local p1, "$i$a$-let-ImageUploadManager$uploadPerFileSuspend$2":I
    :goto_1
    return-object v1

    .local v2, "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    .local p1, "filePath":Ljava/lang/String;
    :cond_2
    invoke-static {v5, v4, v5}, Lkotlinx/coroutines/CompletableDeferredKt;->CompletableDeferred$default(Lkotlinx/coroutines/Job;ILjava/lang/Object;)Lkotlinx/coroutines/CompletableDeferred;

    move-result-object v6

    .line 89
    .local v6, "deferred":Lkotlinx/coroutines/CompletableDeferred;
    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->inflightUploads:Ljava/util/concurrent/ConcurrentHashMap;

    check-cast v7, Ljava/util/Map;

    invoke-interface {v7, p1, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 91
    nop

    .line 92
    :try_start_2
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v7

    check-cast v7, Lkotlin/coroutines/CoroutineContext;

    new-instance v8, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$3;

    invoke-direct {v8, p1, v5}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$3;-><init>(Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v8, Lkotlin/jvm/functions/Function2;

    iput-object v2, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$0:Ljava/lang/Object;

    iput-object p1, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$1:Ljava/lang/Object;

    iput-object v6, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$2:Ljava/lang/Object;

    const/4 v9, 0x2

    iput v9, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->label:I

    invoke-static {v7, v8, p2}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v7
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    if-ne v7, v1, :cond_3

    .line 84
    return-object v1

    .line 92
    :cond_3
    move-object v10, v2

    move-object v2, p1

    move-object p1, v6

    move-object v6, v10

    .line 108
    .local v2, "filePath":Ljava/lang/String;
    .local v6, "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    .local p1, "deferred":Lkotlinx/coroutines/CompletableDeferred;
    :goto_2
    nop

    .line 109
    :try_start_3
    new-instance v7, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$4;

    invoke-direct {v7, p1, v5}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$4;-><init>(Lkotlinx/coroutines/CompletableDeferred;Lkotlin/coroutines/Continuation;)V

    check-cast v7, Lkotlin/jvm/functions/Function2;

    iput-object v6, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$0:Ljava/lang/Object;

    iput-object v2, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$1:Ljava/lang/Object;

    iput-object p1, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->L$2:Ljava/lang/Object;

    const/4 v5, 0x3

    iput v5, p2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFileSuspend$1;->label:I

    const-wide/32 v8, 0x5b8d80

    invoke-static {v8, v9, v7, p2}, Lkotlinx/coroutines/TimeoutKt;->withTimeout(JLkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v5
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    if-ne v5, v1, :cond_4

    .line 84
    return-object v1

    .line 109
    :cond_4
    move-object v1, v2

    move-object v2, v6

    .end local v6    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    .restart local v1    # "filePath":Ljava/lang/String;
    .local v2, "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    :goto_3
    :try_start_4
    check-cast v5, Ljava/lang/Boolean;

    invoke-virtual {v5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_5

    .line 112
    .end local v1    # "filePath":Ljava/lang/String;
    .local v2, "filePath":Ljava/lang/String;
    .restart local v6    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    :catch_1
    move-exception v1

    move-object v1, v2

    move-object v2, v6

    .line 113
    .end local v6    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    .restart local v1    # "filePath":Ljava/lang/String;
    .local v2, "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    :goto_4
    :try_start_5
    invoke-static {v3}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v5

    invoke-interface {p1, v5}, Lkotlinx/coroutines/CompletableDeferred;->complete(Ljava/lang/Object;)Z

    .line 114
    move v5, v3

    .end local p1    # "deferred":Lkotlinx/coroutines/CompletableDeferred;
    :goto_5
    if-eqz v5, :cond_5

    move v3, v4

    :cond_5
    invoke-static {v3}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object p1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 117
    iget-object v3, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->inflightUploads:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v3, v1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 108
    .end local v1    # "filePath":Ljava/lang/String;
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    return-object p1

    .line 117
    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    .local p1, "filePath":Ljava/lang/String;
    :catchall_2
    move-exception v1

    move-object v10, v1

    move-object v1, p1

    move-object p1, v10

    .end local p1    # "filePath":Ljava/lang/String;
    .restart local v1    # "filePath":Ljava/lang/String;
    :goto_6
    iget-object v3, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->inflightUploads:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v3, v1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    throw p1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
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

    .line 38
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->uploadEnabled:Lkotlinx/coroutines/flow/StateFlow;

    return-object v0
.end method

.method public final notifyUploadResult(Ljava/lang/String;Z)V
    .locals 3
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "success"    # Z

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 81
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onMessage ossFileUpload "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " upload "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 82
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->inflightUploads:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lkotlinx/coroutines/CompletableDeferred;

    if-eqz v0, :cond_0

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlinx/coroutines/CompletableDeferred;->complete(Ljava/lang/Object;)Z

    .line 83
    :cond_0
    return-void
.end method

.method public final pauseUploads()V
    .locals 5

    .line 51
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->_uploadEnabled:Lkotlinx/coroutines/flow/MutableStateFlow;

    .local v0, "$this$update$iv":Lkotlinx/coroutines/flow/MutableStateFlow;
    const/4 v1, 0x0

    .line 142
    .local v1, "$i$f$update":I
    :cond_0
    nop

    .line 143
    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v2

    .line 144
    .local v2, "prevValue$iv":Ljava/lang/Object;
    move-object v3, v2

    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    .local v3, "it":Z
    const/4 v4, 0x0

    .line 51
    .local v4, "$i$a$-update-ImageUploadManager$pauseUploads$1":I
    const/4 v3, 0x0

    .end local v3    # "it":Z
    .end local v4    # "$i$a$-update-ImageUploadManager$pauseUploads$1":I
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    .line 144
    nop

    .line 145
    .local v3, "nextValue$iv":Ljava/lang/Object;
    invoke-interface {v0, v2, v3}, Lkotlinx/coroutines/flow/MutableStateFlow;->compareAndSet(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 146
    nop

    .line 52
    .end local v0    # "$this$update$iv":Lkotlinx/coroutines/flow/MutableStateFlow;
    .end local v1    # "$i$f$update":I
    .end local v2    # "prevValue$iv":Ljava/lang/Object;
    .end local v3    # "nextValue$iv":Ljava/lang/Object;
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->TAG:Ljava/lang/String;

    const-string v1, "Image uploads paused."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 53
    return-void
.end method

.method public final startUploads()V
    .locals 5

    .line 46
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->_uploadEnabled:Lkotlinx/coroutines/flow/MutableStateFlow;

    .local v0, "$this$update$iv":Lkotlinx/coroutines/flow/MutableStateFlow;
    const/4 v1, 0x0

    .line 137
    .local v1, "$i$f$update":I
    :cond_0
    nop

    .line 138
    invoke-interface {v0}, Lkotlinx/coroutines/flow/MutableStateFlow;->getValue()Ljava/lang/Object;

    move-result-object v2

    .line 139
    .local v2, "prevValue$iv":Ljava/lang/Object;
    move-object v3, v2

    check-cast v3, Ljava/lang/Boolean;

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    .local v3, "it":Z
    const/4 v4, 0x0

    .line 46
    .local v4, "$i$a$-update-ImageUploadManager$startUploads$1":I
    const/4 v3, 0x1

    .end local v3    # "it":Z
    .end local v4    # "$i$a$-update-ImageUploadManager$startUploads$1":I
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    .line 139
    nop

    .line 140
    .local v3, "nextValue$iv":Ljava/lang/Object;
    invoke-interface {v0, v2, v3}, Lkotlinx/coroutines/flow/MutableStateFlow;->compareAndSet(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 141
    nop

    .line 47
    .end local v0    # "$this$update$iv":Lkotlinx/coroutines/flow/MutableStateFlow;
    .end local v1    # "$i$f$update":I
    .end local v2    # "prevValue$iv":Ljava/lang/Object;
    .end local v3    # "nextValue$iv":Ljava/lang/Object;
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->TAG:Ljava/lang/String;

    const-string v1, "Image uploads started."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 48
    return-void
.end method

.method public final uploadPerFile(Ljava/lang/String;)V
    .locals 13
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 122
    const-string v0, "inspection"

    .line 123
    .local v0, "tag":Ljava/lang/String;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v1, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->getFileNameAsLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    goto :goto_0

    :cond_0
    const-wide/16 v1, 0x0

    :goto_0
    move-wide v5, v1

    .line 124
    .local v5, "fileTime":J
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v8

    new-instance v9, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFile$1;

    const/4 v7, 0x0

    move-object v1, v9

    move-object v2, p0

    move-object v3, p1

    move-object v4, v0

    invoke-direct/range {v1 .. v7}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$uploadPerFile$1;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;Ljava/lang/String;Ljava/lang/String;JLkotlin/coroutines/Continuation;)V

    move-object v10, v9

    check-cast v10, Lkotlin/jvm/functions/Function2;

    const/4 v11, 0x3

    const/4 v12, 0x0

    const/4 v1, 0x0

    const/4 v9, 0x0

    move-object v7, v8

    move-object v8, v1

    invoke-static/range {v7 .. v12}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 135
    return-void
.end method
