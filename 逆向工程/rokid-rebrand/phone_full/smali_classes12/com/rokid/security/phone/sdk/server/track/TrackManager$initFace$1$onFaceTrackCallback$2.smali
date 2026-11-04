.class final Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "TrackManager.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;->onFaceTrackCallback(Ljava/util/ArrayList;J)V
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
    value = "SMAP\nTrackManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 TrackManager.kt\ncom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,411:1\n1855#2,2:412\n*S KotlinDebug\n*F\n+ 1 TrackManager.kt\ncom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2\n*L\n158#1:412,2\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.track.TrackManager$initFace$1$onFaceTrackCallback$2"
    f = "TrackManager.kt"
    i = {}
    l = {
        0x9b
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $faceTrackResults:Ljava/util/ArrayList;
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
            "Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->$faceTrackResults:Ljava/util/ArrayList;

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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->$faceTrackResults:Ljava/util/ArrayList;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;-><init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 8

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 153
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->label:I

    const/4 v2, 0x1

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_0

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 154
    .local v1, "this":Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;
    .restart local p1    # "$result":Ljava/lang/Object;
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getList$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 155
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->$faceTrackResults:Ljava/util/ArrayList;

    move-object v5, v1

    check-cast v5, Lkotlin/coroutines/Continuation;

    iput v2, v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->label:I

    invoke-virtual {v3, v4, v5}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->changeFaceModel(Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v3

    if-ne v3, v0, :cond_0

    .line 153
    return-object v0

    .line 155
    :cond_0
    move-object v0, v1

    .line 156
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;
    :goto_0
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getList$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;->size()I

    move-result v1

    if-eqz v1, :cond_4

    .line 157
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/lang/String;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " --------onFaceTrackCallback:   2222 size = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->$faceTrackResults:Ljava/util/ArrayList;

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    invoke-static {v4}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v4

    goto :goto_1

    :cond_1
    const/4 v4, 0x0

    :goto_1
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->$faceTrackResults:Ljava/util/ArrayList;

    const/4 v5, 0x0

    if-nez v4, :cond_2

    goto :goto_2

    :cond_2
    move v2, v5

    :goto_2
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->$faceTrackResults:Ljava/util/ArrayList;

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;

    invoke-virtual {v3}, Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;->getFaceScore()F

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 158
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getMTrackListeners$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/Set;

    move-result-object v1

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    const/4 v3, 0x0

    .line 412
    .local v3, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v4

    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    :goto_3
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .local v1, "element$iv":Ljava/lang/Object;
    move-object v5, v1

    check-cast v5, Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;

    .local v5, "it":Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;
    const/4 v6, 0x0

    .line 159
    .local v6, "$i$a$-forEach-TrackManager$initFace$1$onFaceTrackCallback$2$1":I
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getList$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v7

    check-cast v7, Ljava/util/List;

    invoke-interface {v5, v7}, Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;->onFaceTrack(Ljava/util/List;)V

    .line 160
    nop

    .line 412
    .end local v1    # "element$iv":Ljava/lang/Object;
    .end local v5    # "it":Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;
    .end local v6    # "$i$a$-forEach-TrackManager$initFace$1$onFaceTrackCallback$2$1":I
    goto :goto_3

    .line 413
    :cond_3
    nop

    .line 161
    .end local v3    # "$i$f$forEach":I
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getList$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$sendFaceTrack(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/util/List;)V

    .line 163
    :cond_4
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
