.class final Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "InspectionServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->bollEvent()Lkotlinx/coroutines/Job;
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
    c = "com.rokid.security.phone.sdk.server.inspection.InspectionServiceImpl$bollEvent$1"
    f = "InspectionServiceImpl.kt"
    i = {}
    l = {
        0x12a
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field label:I


# direct methods
.method constructor <init>(Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x2

    invoke-direct {p0, v0, p1}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 1
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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;

    invoke-direct {v0, p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 11

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 276
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v1, p0

    .local v1, "this":Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_5

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 277
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    :goto_0
    nop

    .line 278
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 279
    .local v2, "now":J
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$isInspect$p()Z

    move-result v4

    const/4 v5, 0x0

    const/4 v6, 0x1

    if-eqz v4, :cond_0

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getLastHeartbeatAt$p()J

    move-result-wide v7

    sub-long v7, v2, v7

    const-wide/16 v9, 0x36b0

    cmp-long v4, v7, v9

    if-gtz v4, :cond_0

    move v2, v6

    goto :goto_1

    .end local v2    # "now":J
    :cond_0
    move v2, v5

    .line 280
    .local v2, "inspectActive":Z
    :goto_1
    nop

    .line 281
    const-string v3, "inspectionDataManager"

    const-string v4, "inspectionVideoUploader"

    const/4 v7, 0x0

    if-eqz v2, :cond_1

    const-string/jumbo v8, "\u5de1\u68c0\u4e2d"

    goto :goto_3

    .line 283
    :cond_1
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getInspectionVideoUploader$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    move-result-object v8

    if-nez v8, :cond_2

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v8, v7

    :cond_2
    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->hasPendingUpload()Z

    move-result v8

    if-nez v8, :cond_5

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getInspectionDataManager$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    move-result-object v8

    if-nez v8, :cond_3

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v8, v7

    :cond_3
    invoke-virtual {v8}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->readInspectionData()Ljava/util/Map;

    move-result-object v8

    invoke-interface {v8}, Ljava/util/Map;->isEmpty()Z

    move-result v8

    xor-int/2addr v8, v6

    if-eqz v8, :cond_4

    goto :goto_2

    .line 286
    :cond_4
    const-string v8, "idle"

    goto :goto_3

    .line 284
    :cond_5
    :goto_2
    const-string/jumbo v8, "\u5de1\u68c0\u4e0a\u4f20\u4e2d"

    .line 280
    :goto_3
    nop

    .line 288
    .local v8, "status":Ljava/lang/String;
    if-nez v2, :cond_6

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$isInspect$p()Z

    move-result v9

    if-eqz v9, :cond_6

    .line 289
    .end local v2    # "inspectActive":Z
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-static {v5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$setInspect$p(Z)V

    .line 291
    :cond_6
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->getLastState()Ljava/lang/String;

    move-result-object v2

    invoke-static {v8, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_9

    .line 293
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "bollEvent state :"

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, " s1 "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getInspectionVideoUploader$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    move-result-object v5

    if-nez v5, :cond_7

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v5, v7

    :cond_7
    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;->hasPendingUpload()Z

    move-result v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " s2 "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->access$getInspectionDataManager$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    move-result-object v4

    if-nez v4, :cond_8

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_4

    :cond_8
    move-object v7, v4

    :goto_4
    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->readInspectionData()Ljava/util/Map;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Map;->isEmpty()Z

    move-result v3

    xor-int/2addr v3, v6

    xor-int/2addr v3, v6

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "InspectionServiceImpl"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 294
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-virtual {v2, v8}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->setLastState(Ljava/lang/String;)V

    .line 297
    :cond_9
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;

    invoke-virtual {v2, v8}, Lcom/rokid/security/phone/sdk/server/inspection/FloatingBallManager;->updateStatus(Ljava/lang/String;)V

    .line 298
    .end local v8    # "status":Ljava/lang/String;
    move-object v2, v1

    check-cast v2, Lkotlin/coroutines/Continuation;

    iput v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;->label:I

    const-wide/16 v3, 0x3e8

    invoke-static {v3, v4, v2}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2

    if-ne v2, v0, :cond_a

    .line 276
    return-object v0

    .line 298
    :cond_a
    :goto_5
    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
