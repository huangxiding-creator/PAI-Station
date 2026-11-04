.class final Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "TrackManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/track/TrackManager;->changeFaceModel(Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
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
    value = "SMAP\nTrackManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 TrackManager.kt\ncom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,411:1\n1855#2,2:412\n*S KotlinDebug\n*F\n+ 1 TrackManager.kt\ncom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2\n*L\n288#1:412,2\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.track.TrackManager$changeFaceModel$2"
    f = "TrackManager.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $faceTrackResult:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;"
        }
    .end annotation
.end field

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/track/TrackManager;",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;->$faceTrackResult:Ljava/util/ArrayList;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p3}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 3
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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;->$faceTrackResult:Ljava/util/ArrayList;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;-><init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 21

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 286
    move-object/from16 v0, p0

    iget v1, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v1, p0

    .local v1, "this":Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;
    move-object/from16 v2, p1

    .line 287
    .local v2, "$result":Ljava/lang/Object;
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getList$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 288
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;->$faceTrackResult:Ljava/util/ArrayList;

    check-cast v3, Ljava/lang/Iterable;

    .local v3, "$this$forEach$iv":Ljava/lang/Iterable;
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$changeFaceModel$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    const/4 v5, 0x0

    .line 412
    .local v5, "$i$f$forEach":I
    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    .end local v3    # "$this$forEach$iv":Ljava/lang/Iterable;
    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v7, v3

    check-cast v7, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;

    .local v7, "it":Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;
    const/4 v8, 0x0

    .line 289
    .local v8, "$i$a$-forEach-TrackManager$changeFaceModel$2$1":I
    new-instance v9, Landroid/graphics/RectF;

    invoke-virtual {v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getX1()F

    move-result v10

    invoke-virtual {v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getY1()F

    move-result v11

    invoke-virtual {v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getX2()F

    move-result v12

    invoke-virtual {v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getY2()F

    move-result v13

    invoke-direct {v9, v10, v11, v12, v13}, Landroid/graphics/RectF;-><init>(FFFF)V

    invoke-static {v4, v9}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$setRectF$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Landroid/graphics/RectF;)V

    .line 290
    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getList$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v9

    .line 292
    sget v12, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_HEIGHT:I

    .line 293
    sget v11, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_WIDTH:I

    .line 294
    invoke-virtual {v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getData()[B

    move-result-object v13

    .line 295
    sget-object v10, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->Companion:Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;

    .line 296
    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getRectF$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Landroid/graphics/RectF;

    move-result-object v14

    invoke-static {v14}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    .line 297
    sget v15, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_WIDTH:I

    .line 298
    sget v0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_HEIGHT:I

    .line 295
    invoke-virtual {v10, v14, v15, v0}, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;->toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;

    move-result-object v14

    .line 300
    invoke-virtual {v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getTrackId()J

    move-result-wide v15

    .line 301
    invoke-virtual {v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getFaceScore()F

    move-result v17

    .line 302
    invoke-virtual {v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getIqaScore()F

    move-result v18

    .line 303
    invoke-virtual {v7}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getFrameId()J

    move-result-wide v19

    .line 291
    new-instance v0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;

    .line 293
    nop

    .line 292
    nop

    .line 294
    const-string v10, "data"

    invoke-static {v13, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 295
    nop

    .line 300
    nop

    .line 301
    nop

    .line 302
    nop

    .line 303
    nop

    .line 291
    move-object v10, v0

    invoke-direct/range {v10 .. v20}, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;-><init>(II[BLandroid/graphics/Rect;JFFJ)V

    .line 290
    invoke-virtual {v9, v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 306
    nop

    .line 412
    .end local v3    # "element$iv":Ljava/lang/Object;
    .end local v7    # "it":Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;
    .end local v8    # "$i$a$-forEach-TrackManager$changeFaceModel$2$1":I
    move-object/from16 v0, p0

    goto :goto_0

    .line 413
    :cond_0
    nop

    .line 307
    .end local v5    # "$i$f$forEach":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
