.class public interface abstract Lcom/rokid/aicore/api/callback/AICallback;
.super Ljava/lang/Object;


# virtual methods
.method public abstract AIEvent([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)V
.end method

.method public abstract AIFaceDetectEvent(ILjava/util/List;Ljava/nio/ByteBuffer;II)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/List<",
            "Lcom/rokid/aicore/ncnn/bean/MotDetection;",
            ">;",
            "Ljava/nio/ByteBuffer;",
            "II)V"
        }
    .end annotation
.end method

.method public abstract AIRecogEvent(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)V
.end method

.method public abstract AIUnRecogEvent(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)V
.end method
