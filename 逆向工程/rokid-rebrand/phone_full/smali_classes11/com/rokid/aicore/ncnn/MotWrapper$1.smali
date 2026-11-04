.class Lcom/rokid/aicore/ncnn/MotWrapper$1;
.super Ljava/lang/Object;
.source "MotWrapper.java"

# interfaces
.implements Lcom/rokid/aicore/ncnn/DetectCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/ncnn/MotWrapper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/rokid/aicore/ncnn/MotWrapper;


# direct methods
.method constructor <init>(Lcom/rokid/aicore/ncnn/MotWrapper;)V
    .locals 0
    .param p1, "this$0"    # Lcom/rokid/aicore/ncnn/MotWrapper;

    .line 27
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/MotWrapper$1;->this$0:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDetected(ILjava/util/List;Ljava/nio/ByteBuffer;II)V
    .locals 7
    .param p1, "frameId"    # I
    .param p3, "data"    # Ljava/nio/ByteBuffer;
    .param p4, "width"    # I
    .param p5, "height"    # I
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

    .line 30
    .local p2, "detections":Ljava/util/List;, "Ljava/util/List<Lcom/rokid/aicore/ncnn/bean/MotDetection;>;"
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onDetectCallback------>onDetected frameId: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "MotWrapper"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 31
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper$1;->this$0:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-static {v0}, Lcom/rokid/aicore/ncnn/MotWrapper;->access$000(Lcom/rokid/aicore/ncnn/MotWrapper;)Lcom/rokid/aicore/ncnn/DetectCallback;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 32
    iget-object v0, p0, Lcom/rokid/aicore/ncnn/MotWrapper$1;->this$0:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-static {v0}, Lcom/rokid/aicore/ncnn/MotWrapper;->access$000(Lcom/rokid/aicore/ncnn/MotWrapper;)Lcom/rokid/aicore/ncnn/DetectCallback;

    move-result-object v1

    move v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    move v6, p5

    invoke-interface/range {v1 .. v6}, Lcom/rokid/aicore/ncnn/DetectCallback;->onDetected(ILjava/util/List;Ljava/nio/ByteBuffer;II)V

    .line 34
    :cond_0
    return-void
.end method
