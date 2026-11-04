.class Lcom/rokid/aicore/core/AICore$5;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/aicore/core/AICore;->processAsyncV2(Lcom/rokid/aicore/api/bean/ImageInput;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/rokid/aicore/core/AICore;

.field public final synthetic val$imageInput:Lcom/rokid/aicore/api/bean/ImageInput;


# direct methods
.method public constructor <init>(Lcom/rokid/aicore/core/AICore;Lcom/rokid/aicore/api/bean/ImageInput;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/aicore/core/AICore$5;->this$0:Lcom/rokid/aicore/core/AICore;

    iput-object p2, p0, Lcom/rokid/aicore/core/AICore$5;->val$imageInput:Lcom/rokid/aicore/api/bean/ImageInput;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/rokid/aicore/core/AICore$5;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v1}, Lcom/rokid/aicore/core/AICore;->access$100(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/ncnn/MotWrapper;

    move-result-object v2

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore$5;->val$imageInput:Lcom/rokid/aicore/api/bean/ImageInput;

    iget-wide v3, v1, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    long-to-int v3, v3

    iget-object v4, v1, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    iget v5, v1, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget v6, v1, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    iget-object v7, v1, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    invoke-virtual/range {v2 .. v7}, Lcom/rokid/aicore/ncnn/MotWrapper;->processAsync(I[BIILcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;)I

    move-result v1

    sget-object v2, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "start processAsyncV2 for MotWrapper instanceId: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/rokid/aicore/core/AICore$5;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v4}, Lcom/rokid/aicore/core/AICore;->access$100(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/ncnn/MotWrapper;

    move-result-object v4

    invoke-virtual {v4}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ";  Type = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/rokid/aicore/core/AICore$5;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v4}, Lcom/rokid/aicore/core/AICore;->access$200(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/ncnn/bean/MotConfig;

    move-result-object v4

    invoke-virtual {v4}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v4

    invoke-virtual {v4}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->name()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " result = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " frameId = "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lcom/rokid/aicore/core/AICore$5;->val$imageInput:Lcom/rokid/aicore/api/bean/ImageInput;

    iget-wide v3, v3, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v1, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore$5;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v1}, Lcom/rokid/aicore/core/AICore;->access$300(Lcom/rokid/aicore/core/AICore;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    return-void

    :catchall_0
    move-exception v1

    iget-object v2, p0, Lcom/rokid/aicore/core/AICore$5;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v2}, Lcom/rokid/aicore/core/AICore;->access$300(Lcom/rokid/aicore/core/AICore;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    throw v1
.end method
