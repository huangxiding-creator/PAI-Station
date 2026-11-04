.class Lcom/rokid/aicore/core/AICore$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/aicore/core/AICore;->processAsync(Lcom/rokid/aicore/api/bean/ImageInput;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/rokid/aicore/core/AICore;

.field public final synthetic val$asyncBeginProcessing:J

.field public final synthetic val$imageInput:Lcom/rokid/aicore/api/bean/ImageInput;


# direct methods
.method public constructor <init>(Lcom/rokid/aicore/core/AICore;Lcom/rokid/aicore/api/bean/ImageInput;J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    iput-object p2, p0, Lcom/rokid/aicore/core/AICore$4;->val$imageInput:Lcom/rokid/aicore/api/bean/ImageInput;

    iput-wide p3, p0, Lcom/rokid/aicore/core/AICore$4;->val$asyncBeginProcessing:J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 11

    const/4 v0, 0x0

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-object v3, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v3}, Lcom/rokid/aicore/core/AICore;->access$100(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/ncnn/MotWrapper;

    move-result-object v4

    iget-object v3, p0, Lcom/rokid/aicore/core/AICore$4;->val$imageInput:Lcom/rokid/aicore/api/bean/ImageInput;

    iget-object v5, v3, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    iget v6, v3, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget v7, v3, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    iget-object v8, v3, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    iget-wide v9, v3, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    long-to-int v9, v9

    invoke-virtual/range {v4 .. v9}, Lcom/rokid/aicore/ncnn/MotWrapper;->process([BIILcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;I)[Lcom/rokid/aicore/ncnn/bean/MotDetection;

    move-result-object v3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    if-nez v3, :cond_1

    sget-object v1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "start processAsync for MotWrapper instanceId: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v4}, Lcom/rokid/aicore/core/AICore;->access$100(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/ncnn/MotWrapper;

    move-result-object v4

    invoke-virtual {v4}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v4

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, ";  Type = "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v4}, Lcom/rokid/aicore/core/AICore;->access$200(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/ncnn/bean/MotConfig;

    move-result-object v4

    invoke-virtual {v4}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v4

    invoke-virtual {v4}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->name()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " but result is null!!! frameId = "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, p0, Lcom/rokid/aicore/core/AICore$4;->val$imageInput:Lcom/rokid/aicore/api/bean/ImageInput;

    iget-wide v4, v4, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v2, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v1}, Lcom/rokid/aicore/core/AICore;->access$000(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/api/callback/AICallback;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v1}, Lcom/rokid/aicore/core/AICore;->access$000(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/api/callback/AICallback;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/aicore/core/AICore$4;->val$imageInput:Lcom/rokid/aicore/api/bean/ImageInput;

    invoke-interface {v1, v3, v2}, Lcom/rokid/aicore/api/callback/AICallback;->AIEvent([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)V

    :cond_0
    iget-object v1, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v1}, Lcom/rokid/aicore/core/AICore;->access$300(Lcom/rokid/aicore/core/AICore;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    :goto_0
    iget-object v1, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v1}, Lcom/rokid/aicore/core/AICore;->access$300(Lcom/rokid/aicore/core/AICore;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    return-void

    :cond_1
    :try_start_1
    const-string v6, "LOCK_LIST"

    monitor-enter v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    iget-object v7, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v7}, Lcom/rokid/aicore/core/AICore;->access$000(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/api/callback/AICallback;

    move-result-object v7

    if-eqz v7, :cond_2

    iget-object v7, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v7}, Lcom/rokid/aicore/core/AICore;->access$000(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/api/callback/AICallback;

    move-result-object v7

    iget-object v8, p0, Lcom/rokid/aicore/core/AICore$4;->val$imageInput:Lcom/rokid/aicore/api/bean/ImageInput;

    invoke-interface {v7, v3, v8}, Lcom/rokid/aicore/api/callback/AICallback;->AIEvent([Lcom/rokid/aicore/ncnn/bean/MotDetection;Lcom/rokid/aicore/api/bean/ImageInput;)V

    :cond_2
    monitor-exit v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    sget-object v3, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "start processAsync for MotWrapper instanceId: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v9}, Lcom/rokid/aicore/core/AICore;->access$100(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/ncnn/MotWrapper;

    move-result-object v9

    invoke-virtual {v9}, Lcom/rokid/aicore/ncnn/MotWrapper;->getNativeHandle()J

    move-result-wide v9

    invoke-virtual {v8, v9, v10}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " kAlgorithmName"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v9}, Lcom/rokid/aicore/core/AICore;->access$200(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/ncnn/bean/MotConfig;

    move-result-object v9

    invoke-virtual {v9}, Lcom/rokid/aicore/ncnn/bean/MotConfig;->getAlgorithmName()Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v9

    invoke-virtual {v9}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->name()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " && Algorithm processing cost time: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    sub-long/2addr v4, v1

    invoke-virtual {v8, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " && add Async total time: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-wide v4, p0, Lcom/rokid/aicore/core/AICore$4;->val$asyncBeginProcessing:J

    sub-long/2addr v6, v4

    invoke-virtual {v1, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; frameId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/aicore/core/AICore$4;->val$imageInput:Lcom/rokid/aicore/api/bean/ImageInput;

    iget-wide v4, v2, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v1, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto/16 :goto_0

    :catchall_0
    move-exception v1

    :try_start_4
    monitor-exit v6
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    throw v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :catchall_1
    move-exception v1

    iget-object v2, p0, Lcom/rokid/aicore/core/AICore$4;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v2}, Lcom/rokid/aicore/core/AICore;->access$300(Lcom/rokid/aicore/core/AICore;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    throw v1
.end method
