.class public final Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;
.super Ljava/lang/Object;
.source "TrackManager.kt"

# interfaces
.implements Lcom/rokid/aicore/api/callback/face/FaceCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/track/TrackManager;->initFace()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nTrackManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 TrackManager.kt\ncom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,411:1\n1855#2,2:412\n*S KotlinDebug\n*F\n+ 1 TrackManager.kt\ncom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1\n*L\n147#1:412,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000-\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0012\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H\u0016J\u0012\u0010\u0006\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H\u0016J,\u0010\u0007\u001a\u00020\u00032\u001a\u0010\u0008\u001a\u0016\u0012\u0004\u0012\u00020\n\u0018\u00010\tj\n\u0012\u0004\u0012\u00020\n\u0018\u0001`\u000b2\u0006\u0010\u000c\u001a\u00020\rH\u0016\u00a8\u0006\u000e"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/track/TrackManager$initFace$1",
        "Lcom/rokid/aicore/api/callback/face/FaceCallback;",
        "onFaceRecognizeCallback",
        "",
        "faceRecognizeResults",
        "Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;",
        "onFaceRecognizeNotInLibCallback",
        "onFaceTrackCallback",
        "faceTrackResults",
        "Ljava/util/ArrayList;",
        "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
        "Lkotlin/collections/ArrayList;",
        "frame_id",
        "",
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
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    .line 139
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFaceRecognizeCallback(Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;)V
    .locals 0
    .param p1, "faceRecognizeResults"    # Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;

    .line 169
    return-void
.end method

.method public onFaceRecognizeNotInLibCallback(Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;)V
    .locals 0
    .param p1, "faceRecognizeResults"    # Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;

    .line 173
    return-void
.end method

.method public onFaceTrackCallback(Ljava/util/ArrayList;J)V
    .locals 8
    .param p1, "faceTrackResults"    # Ljava/util/ArrayList;
    .param p2, "frame_id"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;J)V"
        }
    .end annotation

    .line 144
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " --------onFaceTrackCallback:  size = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/4 v2, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    goto :goto_0

    :cond_0
    move-object v3, v2

    :goto_0
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ", "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-nez p1, :cond_1

    move v5, v3

    goto :goto_1

    :cond_1
    move v5, v4

    :goto_1
    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v5, 0x20

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 145
    move-object v0, p1

    check-cast v0, Ljava/util/Collection;

    if-eqz v0, :cond_3

    invoke-interface {v0}, Ljava/util/Collection;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_2

    :cond_2
    move v3, v4

    :cond_3
    :goto_2
    if-eqz v3, :cond_5

    .line 146
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getList$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 147
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getMTrackListeners$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    const/4 v2, 0x0

    .line 412
    .local v2, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;

    .local v5, "it":Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;
    const/4 v6, 0x0

    .line 148
    .local v6, "$i$a$-forEach-TrackManager$initFace$1$onFaceTrackCallback$1":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getList$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v7

    check-cast v7, Ljava/util/List;

    invoke-interface {v5, v7}, Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;->onFaceTrack(Ljava/util/List;)V

    .line 149
    nop

    .line 412
    .end local v5    # "it":Lcom/rokid/security/phone/sdk/api/track/listener/ITrackListener;
    .end local v6    # "$i$a$-forEach-TrackManager$initFace$1$onFaceTrackCallback$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_3

    .line 413
    :cond_4
    nop

    .line 150
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$getList$p(Lcom/rokid/security/phone/sdk/server/track/TrackManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/server/track/TrackManager;->access$sendFaceTrack(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/util/List;)V

    goto :goto_4

    .line 153
    :cond_5
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    new-instance v1, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1;->this$0:Lcom/rokid/security/phone/sdk/server/track/TrackManager;

    invoke-direct {v1, v3, p1, v2}, Lcom/rokid/security/phone/sdk/server/track/TrackManager$initFace$1$onFaceTrackCallback$2;-><init>(Lcom/rokid/security/phone/sdk/server/track/TrackManager;Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)V

    move-object v5, v1

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v2, v0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 165
    :goto_4
    return-void
.end method
