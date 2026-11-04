.class Lcom/rokid/aicore/ncnn/MotWrapper$2;
.super Ljava/lang/Object;
.source "MotWrapper.java"

# interfaces
.implements Lcom/rokid/aicore/ncnn/RecognizeCallback;


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

    .line 37
    iput-object p1, p0, Lcom/rokid/aicore/ncnn/MotWrapper$2;->this$0:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onRecognized(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)V
    .locals 16
    .param p1, "frameId"    # I
    .param p2, "trackId"    # I
    .param p3, "libraryName"    # Ljava/lang/String;
    .param p4, "label"    # Ljava/lang/String;
    .param p5, "prob"    # F
    .param p6, "rect"    # Lcom/rokid/aicore/ncnn/bean/MotBBox;
    .param p7, "image"    # Ljava/nio/ByteBuffer;
    .param p8, "w"    # I
    .param p9, "h"    # I
    .param p10, "personId"    # I

    .line 40
    move-object/from16 v0, p0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onFaceRecognizeCallback------>onRecognized frameId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move/from16 v13, p1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; trackId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move/from16 v14, p2

    invoke-virtual {v1, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; libraryName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v15, p3

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; label: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v12, p4

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; prob: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move/from16 v11, p5

    invoke-virtual {v1, v11}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "MotWrapper"

    invoke-static {v2, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 41
    iget-object v1, v0, Lcom/rokid/aicore/ncnn/MotWrapper$2;->this$0:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-static {v1}, Lcom/rokid/aicore/ncnn/MotWrapper;->access$100(Lcom/rokid/aicore/ncnn/MotWrapper;)Lcom/rokid/aicore/ncnn/RecognizeCallback;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 42
    iget-object v1, v0, Lcom/rokid/aicore/ncnn/MotWrapper$2;->this$0:Lcom/rokid/aicore/ncnn/MotWrapper;

    invoke-static {v1}, Lcom/rokid/aicore/ncnn/MotWrapper;->access$100(Lcom/rokid/aicore/ncnn/MotWrapper;)Lcom/rokid/aicore/ncnn/RecognizeCallback;

    move-result-object v2

    move/from16 v3, p1

    move/from16 v4, p2

    move-object/from16 v5, p3

    move-object/from16 v6, p4

    move/from16 v7, p5

    move-object/from16 v8, p6

    move-object/from16 v9, p7

    move/from16 v10, p8

    move/from16 v11, p9

    move/from16 v12, p10

    invoke-interface/range {v2 .. v12}, Lcom/rokid/aicore/ncnn/RecognizeCallback;->onRecognized(IILjava/lang/String;Ljava/lang/String;FLcom/rokid/aicore/ncnn/bean/MotBBox;Ljava/nio/ByteBuffer;III)V

    .line 44
    :cond_0
    return-void
.end method
