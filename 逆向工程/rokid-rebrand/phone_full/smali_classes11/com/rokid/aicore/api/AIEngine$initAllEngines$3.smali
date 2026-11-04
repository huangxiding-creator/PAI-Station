.class public final Lcom/rokid/aicore/api/AIEngine$initAllEngines$3;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/rokid/aicore/api/callback/face/FaceCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/aicore/api/AIEngine;->initAllEngines()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000-\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0012\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H\u0016J\u0012\u0010\u0006\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H\u0016J(\u0010\u0007\u001a\u00020\u00032\u0016\u0010\u0008\u001a\u0012\u0012\u0004\u0012\u00020\n0\tj\u0008\u0012\u0004\u0012\u00020\n`\u000b2\u0006\u0010\u000c\u001a\u00020\rH\u0016\u00a8\u0006\u000e"
    }
    d2 = {
        "com/rokid/aicore/api/AIEngine$initAllEngines$3",
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
        "frameId",
        "",
        "aicore_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x5,
        0x1
    }
    xi = 0x30
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/rokid/aicore/api/AIEngine;


# direct methods
.method public constructor <init>(Lcom/rokid/aicore/api/AIEngine;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/api/AIEngine$initAllEngines$3;->this$0:Lcom/rokid/aicore/api/AIEngine;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFaceRecognizeCallback(Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;)V
    .locals 4

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine$initAllEngines$3;->this$0:Lcom/rokid/aicore/api/AIEngine;

    invoke-static {v0}, Lcom/rokid/aicore/api/AIEngine;->access$getMFaceObservers$p(Lcom/rokid/aicore/api/AIEngine;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-gtz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine$initAllEngines$3;->this$0:Lcom/rokid/aicore/api/AIEngine;

    invoke-static {v0}, Lcom/rokid/aicore/api/AIEngine;->access$getMFaceObservers$p(Lcom/rokid/aicore/api/AIEngine;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/aicore/api/callback/face/FaceCallback;

    sget-object v2, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v3, "######### onFaceRecognizeCallback faceRecognizeResults\uff1a"

    invoke-static {v3, p1}, Lkotlin/jvm/internal/Intrinsics;->stringPlus(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    invoke-interface {v1, p1}, Lcom/rokid/aicore/api/callback/face/FaceCallback;->onFaceRecognizeCallback(Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method public onFaceRecognizeNotInLibCallback(Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;)V
    .locals 4

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine$initAllEngines$3;->this$0:Lcom/rokid/aicore/api/AIEngine;

    invoke-static {v0}, Lcom/rokid/aicore/api/AIEngine;->access$getMFaceObservers$p(Lcom/rokid/aicore/api/AIEngine;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-gtz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine$initAllEngines$3;->this$0:Lcom/rokid/aicore/api/AIEngine;

    invoke-static {v0}, Lcom/rokid/aicore/api/AIEngine;->access$getMFaceObservers$p(Lcom/rokid/aicore/api/AIEngine;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/aicore/api/callback/face/FaceCallback;

    sget-object v2, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v3, "######### onFaceUnRecognizeCallback faceRecognizeResults\uff1a"

    invoke-static {v3, p1}, Lkotlin/jvm/internal/Intrinsics;->stringPlus(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    invoke-interface {v1, p1}, Lcom/rokid/aicore/api/callback/face/FaceCallback;->onFaceRecognizeNotInLibCallback(Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method public onFaceTrackCallback(Ljava/util/ArrayList;J)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;J)V"
        }
    .end annotation

    const-string v0, "faceTrackResults"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine$initAllEngines$3;->this$0:Lcom/rokid/aicore/api/AIEngine;

    invoke-static {v0}, Lcom/rokid/aicore/api/AIEngine;->access$getMFaceObservers$p(Lcom/rokid/aicore/api/AIEngine;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-gtz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine$initAllEngines$3;->this$0:Lcom/rokid/aicore/api/AIEngine;

    invoke-static {v0}, Lcom/rokid/aicore/api/AIEngine;->access$getMFaceObservers$p(Lcom/rokid/aicore/api/AIEngine;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/aicore/api/callback/face/FaceCallback;

    invoke-interface {v1, p1, p2, p3}, Lcom/rokid/aicore/api/callback/face/FaceCallback;->onFaceTrackCallback(Ljava/util/ArrayList;J)V

    goto :goto_0

    :cond_1
    return-void
.end method
