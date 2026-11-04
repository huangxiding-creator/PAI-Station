.class public interface abstract Lcom/rokid/aicore/api/callback/face/FaceCallback;
.super Ljava/lang/Object;


# virtual methods
.method public abstract onFaceRecognizeCallback(Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;)V
.end method

.method public abstract onFaceRecognizeNotInLibCallback(Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;)V
.end method

.method public abstract onFaceTrackCallback(Ljava/util/ArrayList;J)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/result/face/FaceTrackResult;",
            ">;J)V"
        }
    .end annotation
.end method
