.class public Lcom/rokid/aicore/api/bean/ImageInput;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Cloneable;


# instance fields
.field public data:[B

.field public frame_id:J

.field public height:I

.field public type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

.field public width:I


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static copyImageInput(Lcom/rokid/aicore/api/bean/ImageInput;)Lcom/rokid/aicore/api/bean/ImageInput;
    .locals 3

    new-instance v0, Lcom/rokid/aicore/api/bean/ImageInput;

    invoke-direct {v0}, Lcom/rokid/aicore/api/bean/ImageInput;-><init>()V

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    iget-object v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    iput-object v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    iget-wide v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    iput-wide v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    iget v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    iget v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget-object p0, p0, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    iput-object p0, v0, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    return-object v0
.end method


# virtual methods
.method public clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/rokid/aicore/api/bean/ImageInput;->copy()Lcom/rokid/aicore/api/bean/ImageInput;

    move-result-object v0

    return-object v0
.end method

.method public copy()Lcom/rokid/aicore/api/bean/ImageInput;
    .locals 5

    new-instance v0, Lcom/rokid/aicore/api/bean/ImageInput;

    invoke-direct {v0}, Lcom/rokid/aicore/api/bean/ImageInput;-><init>()V

    iget v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    iget-wide v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    iput-wide v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    iget v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget-object v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    iput-object v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    iget-object v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    array-length v2, v1

    new-array v2, v2, [B

    array-length v3, v1

    const/4 v4, 0x0

    invoke-static {v1, v4, v2, v4, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ImageInput{, width="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", height="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", type="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", frame_id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
