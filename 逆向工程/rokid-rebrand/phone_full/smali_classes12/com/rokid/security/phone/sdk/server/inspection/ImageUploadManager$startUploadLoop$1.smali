.class final Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ImageUploadManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->startUploadLoop()Lkotlinx/coroutines/Job;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/coroutines/jvm/internal/SuspendLambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Lkotlinx/coroutines/CoroutineScope;",
        "Lkotlin/coroutines/Continuation<",
        "-",
        "Lkotlin/Unit;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nImageUploadManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ImageUploadManager.kt\ncom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1\n+ 2 Mutex.kt\nkotlinx/coroutines/sync/MutexKt\n*L\n1#1,136:1\n120#2,10:137\n*S KotlinDebug\n*F\n+ 1 ImageUploadManager.kt\ncom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1\n*L\n58#1:137,10\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\u008a@"
    }
    d2 = {
        "<anonymous>",
        "",
        "Lkotlinx/coroutines/CoroutineScope;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.security.phone.sdk.server.inspection.ImageUploadManager$startUploadLoop$1"
    f = "ImageUploadManager.kt"
    i = {
        0x0,
        0x0,
        0x1,
        0x1,
        0x1,
        0x2
    }
    l = {
        0x8e,
        0x41,
        0x4b
    }
    m = "invokeSuspend"
    n = {
        "$this$launch",
        "$this$withLock_u24default$iv",
        "$this$launch",
        "$this$withLock_u24default$iv",
        "imageInfo",
        "$this$launch"
    }
    s = {
        "L$0",
        "L$1",
        "L$0",
        "L$1",
        "L$3",
        "L$0"
    }
.end annotation


# instance fields
.field private synthetic L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p2}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/coroutines/Continuation<",
            "*>;)",
            "Lkotlin/coroutines/Continuation<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    invoke-direct {v0, v1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;Lkotlin/coroutines/Continuation;)V

    iput-object p1, v0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CoroutineScope;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 17

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 55
    move-object/from16 v1, p0

    iget v2, v1, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->label:I

    const/4 v3, 0x0

    const/4 v4, 0x1

    packed-switch v2, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v2, p0

    .local v2, "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;
    move-object/from16 v5, p1

    .local v5, "$result":Ljava/lang/Object;
    iget-object v6, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    check-cast v6, Lkotlinx/coroutines/CoroutineScope;

    .local v6, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_8

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v6    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :pswitch_1
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;
    move-object/from16 v5, p1

    .restart local v5    # "$result":Ljava/lang/Object;
    const/4 v6, 0x0

    .local v6, "$i$f$withLock":I
    const/4 v7, 0x0

    .local v7, "$i$a$-withLock$default-ImageUploadManager$startUploadLoop$1$1":I
    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$3:Ljava/lang/Object;

    check-cast v8, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    .local v8, "imageInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    iget-object v9, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$2:Ljava/lang/Object;

    check-cast v9, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    const/4 v10, 0x0

    .local v10, "owner$iv":Ljava/lang/Object;
    iget-object v11, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$1:Ljava/lang/Object;

    check-cast v11, Lkotlinx/coroutines/sync/Mutex;

    .local v11, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    iget-object v12, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    check-cast v12, Lkotlinx/coroutines/CoroutineScope;

    .local v12, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_0
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v13, v12

    move-object v12, v11

    move-object v11, v10

    move-object v10, v9

    move-object v9, v8

    move v8, v7

    move v7, v6

    move-object v6, v5

    goto/16 :goto_3

    .line 146
    .end local v7    # "$i$a$-withLock$default-ImageUploadManager$startUploadLoop$1$1":I
    .end local v8    # "imageInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    .end local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_0
    move-exception v0

    goto/16 :goto_6

    .line 55
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v6    # "$i$f$withLock":I
    .end local v10    # "owner$iv":Ljava/lang/Object;
    .end local v11    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :pswitch_2
    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;
    move-object/from16 v5, p1

    .restart local v5    # "$result":Ljava/lang/Object;
    const/4 v6, 0x0

    .restart local v6    # "$i$f$withLock":I
    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$2:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    const/4 v8, 0x0

    .local v8, "owner$iv":Ljava/lang/Object;
    iget-object v9, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$1:Ljava/lang/Object;

    check-cast v9, Lkotlinx/coroutines/sync/Mutex;

    .local v9, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    iget-object v10, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    check-cast v10, Lkotlinx/coroutines/CoroutineScope;

    .local v10, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v11, v9

    move-object v12, v10

    move-object v9, v7

    move-object v10, v8

    goto :goto_1

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v6    # "$i$f$withLock":I
    .end local v8    # "owner$iv":Ljava/lang/Object;
    .end local v9    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .end local v10    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :pswitch_3
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;
    move-object/from16 v5, p1

    .restart local v5    # "$result":Ljava/lang/Object;
    iget-object v6, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    check-cast v6, Lkotlinx/coroutines/CoroutineScope;

    .line 56
    .local v6, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_0
    invoke-static {v6}, Lkotlinx/coroutines/CoroutineScopeKt;->isActive(Lkotlinx/coroutines/CoroutineScope;)Z

    move-result v7

    if-eqz v7, :cond_9

    .line 57
    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->getUploadEnabled()Lkotlinx/coroutines/flow/StateFlow;

    move-result-object v7

    invoke-interface {v7}, Lkotlinx/coroutines/flow/StateFlow;->getValue()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Boolean;

    invoke-virtual {v7}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v7

    if-eqz v7, :cond_7

    .line 58
    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    invoke-static {v7}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->access$getUploadMutex$p(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v7

    .local v7, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->this$0:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    .line 137
    const/4 v9, 0x0

    .local v9, "owner$iv":Ljava/lang/Object;
    const/4 v10, 0x0

    .line 138
    .local v10, "$i$f$withLock":I
    nop

    .line 142
    move-object v11, v2

    check-cast v11, Lkotlin/coroutines/Continuation;

    iput-object v6, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    iput-object v7, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$1:Ljava/lang/Object;

    iput-object v8, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$2:Ljava/lang/Object;

    iput v4, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->label:I

    invoke-interface {v7, v9, v11}, Lkotlinx/coroutines/sync/Mutex;->lock(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v11

    if-ne v11, v0, :cond_0

    .line 55
    return-object v0

    .line 142
    :cond_0
    move-object v12, v6

    move-object v11, v7

    move v6, v10

    move-object v10, v9

    move-object v9, v8

    .line 143
    .end local v7    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .end local v9    # "owner$iv":Ljava/lang/Object;
    .local v6, "$i$f$withLock":I
    .local v10, "owner$iv":Ljava/lang/Object;
    .restart local v11    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .restart local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_1
    nop

    .line 144
    const/4 v7, 0x0

    .line 59
    .local v7, "$i$a$-withLock$default-ImageUploadManager$startUploadLoop$1$1":I
    :try_start_1
    invoke-static {v9}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->access$getInspectionDataManager$p(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;)Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    move-result-object v8

    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->readInspectionData()Ljava/util/Map;

    move-result-object v8

    .line 60
    .local v8, "inspectionData":Ljava/util/Map;
    nop

    .line 61
    invoke-interface {v8}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v13

    invoke-interface {v13}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v13

    .end local v8    # "inspectionData":Ljava/util/Map;
    :cond_1
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_6

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/util/Map$Entry;

    invoke-interface {v8}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/util/Map;

    .line 62
    .local v8, "imageMap":Ljava/util/Map;
    invoke-interface {v8}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v14

    invoke-interface {v14}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v14

    .end local v8    # "imageMap":Ljava/util/Map;
    :cond_2
    invoke-interface {v14}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_1

    invoke-interface {v14}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/util/Map$Entry;

    invoke-interface {v8}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    .line 63
    .local v8, "imageInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getUrl()Ljava/lang/String;

    move-result-object v15

    check-cast v15, Ljava/lang/CharSequence;

    invoke-interface {v15}, Ljava/lang/CharSequence;->length()I

    move-result v15

    if-nez v15, :cond_3

    move v15, v4

    goto :goto_2

    :cond_3
    move v15, v3

    :goto_2
    if-eqz v15, :cond_2

    .line 64
    invoke-static {v9}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;)Ljava/lang/String;

    move-result-object v13

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "Starting upload for: "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 65
    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v13

    iput-object v12, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    iput-object v11, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$1:Ljava/lang/Object;

    iput-object v9, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$2:Ljava/lang/Object;

    iput-object v8, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$3:Ljava/lang/Object;

    const/4 v14, 0x2

    iput v14, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->label:I

    invoke-static {v9, v13, v2}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->access$uploadPerFileSuspend(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v13
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-ne v13, v0, :cond_4

    .line 55
    return-object v0

    .line 65
    :cond_4
    move/from16 v16, v6

    move-object v6, v5

    move-object v5, v13

    move-object v13, v12

    move-object v12, v11

    move-object v11, v10

    move-object v10, v9

    move-object v9, v8

    move v8, v7

    move/from16 v7, v16

    .end local v5    # "$result":Ljava/lang/Object;
    .end local v10    # "owner$iv":Ljava/lang/Object;
    .local v6, "$result":Ljava/lang/Object;
    .local v7, "$i$f$withLock":I
    .local v8, "$i$a$-withLock$default-ImageUploadManager$startUploadLoop$1$1":I
    .local v9, "imageInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    .local v11, "owner$iv":Ljava/lang/Object;
    .local v12, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .local v13, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :goto_3
    :try_start_2
    check-cast v5, Ljava/lang/Boolean;

    invoke-virtual {v5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5

    .line 66
    .local v5, "success":Z
    invoke-static {v10}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;)Ljava/lang/String;

    move-result-object v10

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "Upload result for "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, ": "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    if-eqz v5, :cond_5

    move v5, v4

    goto :goto_4

    .end local v5    # "success":Z
    .end local v9    # "imageInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    :cond_5
    move v5, v3

    :goto_4
    invoke-virtual {v14, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v10, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 67
    nop

    .line 68
    move-object v5, v6

    move v6, v7

    move v7, v8

    move-object v10, v11

    move-object v11, v12

    move-object v12, v13

    goto :goto_5

    .line 146
    .end local v8    # "$i$a$-withLock$default-ImageUploadManager$startUploadLoop$1$1":I
    .end local v13    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :catchall_1
    move-exception v0

    move-object v5, v6

    move v6, v7

    move-object v10, v11

    move-object v11, v12

    goto :goto_6

    .line 73
    .local v5, "$result":Ljava/lang/Object;
    .local v6, "$i$f$withLock":I
    .local v7, "$i$a$-withLock$default-ImageUploadManager$startUploadLoop$1$1":I
    .restart local v10    # "owner$iv":Ljava/lang/Object;
    .local v11, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .local v12, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :cond_6
    :goto_5
    nop

    .end local v7    # "$i$a$-withLock$default-ImageUploadManager$startUploadLoop$1$1":I
    :try_start_3
    sget-object v7, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 144
    nop

    .line 146
    invoke-interface {v11, v10}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    .line 144
    .end local v10    # "owner$iv":Ljava/lang/Object;
    .end local v11    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    move-object v6, v12

    goto :goto_7

    .line 146
    .end local v12    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v10    # "owner$iv":Ljava/lang/Object;
    .restart local v11    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :goto_6
    invoke-interface {v11, v10}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    throw v0

    .line 75
    .end local v10    # "owner$iv":Ljava/lang/Object;
    .end local v11    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .local v6, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :cond_7
    :goto_7
    move-object v7, v2

    check-cast v7, Lkotlin/coroutines/Continuation;

    iput-object v6, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$0:Ljava/lang/Object;

    const/4 v8, 0x0

    iput-object v8, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$1:Ljava/lang/Object;

    iput-object v8, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$2:Ljava/lang/Object;

    iput-object v8, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->L$3:Ljava/lang/Object;

    const/4 v8, 0x3

    iput v8, v2, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager$startUploadLoop$1;->label:I

    const-wide/16 v8, 0x1388

    invoke-static {v8, v9, v7}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v7

    if-ne v7, v0, :cond_8

    .line 55
    return-object v0

    .line 75
    :cond_8
    :goto_8
    goto/16 :goto_0

    .line 77
    :cond_9
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
