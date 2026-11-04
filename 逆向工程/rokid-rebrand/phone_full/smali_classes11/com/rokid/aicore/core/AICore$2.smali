.class Lcom/rokid/aicore/core/AICore$2;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/rokid/aicore/ncnn/DetectCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/core/AICore;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/rokid/aicore/core/AICore;


# direct methods
.method public constructor <init>(Lcom/rokid/aicore/core/AICore;)V
    .locals 0

    iput-object p1, p0, Lcom/rokid/aicore/core/AICore$2;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDetected(ILjava/util/List;Ljava/nio/ByteBuffer;II)V
    .locals 7
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

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DetectCallback------>onDetected frameId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; detections: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore$2;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v0}, Lcom/rokid/aicore/core/AICore;->access$000(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/api/callback/AICallback;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/aicore/core/AICore$2;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v0}, Lcom/rokid/aicore/core/AICore;->access$000(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/api/callback/AICallback;

    move-result-object v1

    move v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    move v6, p5

    invoke-interface/range {v1 .. v6}, Lcom/rokid/aicore/api/callback/AICallback;->AIFaceDetectEvent(ILjava/util/List;Ljava/nio/ByteBuffer;II)V

    :cond_0
    return-void
.end method
