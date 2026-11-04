.class Lcom/rokid/aicore/core/AICore$3;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/rokid/aicore/ncnn/UnrecognizeCallback;


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

    iput-object p1, p0, Lcom/rokid/aicore/core/AICore$3;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onRecognizedNotInLib(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)V
    .locals 14

    move-object v0, p0

    sget-object v1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UnrecognizeCallback------>onRecognizedNotInLib frameId: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move v4, p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "; trackId: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v5, p2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "; label: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v7, p4

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "; prob: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v8, p5

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object v1, v0, Lcom/rokid/aicore/core/AICore$3;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v1}, Lcom/rokid/aicore/core/AICore;->access$000(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/api/callback/AICallback;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, v0, Lcom/rokid/aicore/core/AICore$3;->this$0:Lcom/rokid/aicore/core/AICore;

    invoke-static {v1}, Lcom/rokid/aicore/core/AICore;->access$000(Lcom/rokid/aicore/core/AICore;)Lcom/rokid/aicore/api/callback/AICallback;

    move-result-object v3

    move v4, p1

    move/from16 v5, p2

    move-object/from16 v6, p3

    move-object/from16 v7, p4

    move/from16 v8, p5

    move-object/from16 v9, p6

    move-object/from16 v10, p7

    move/from16 v11, p8

    move/from16 v12, p9

    move/from16 v13, p10

    invoke-interface/range {v3 .. v13}, Lcom/rokid/aicore/api/callback/AICallback;->AIUnRecogEvent(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)V

    :cond_0
    return-void
.end method
