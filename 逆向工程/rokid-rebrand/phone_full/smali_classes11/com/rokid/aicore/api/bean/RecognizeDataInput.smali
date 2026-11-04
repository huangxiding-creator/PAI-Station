.class public Lcom/rokid/aicore/api/bean/RecognizeDataInput;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Cloneable;


# instance fields
.field public data:[B

.field public frameId:J

.field public height:I

.field public trackId:I

.field public type:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

.field public width:I


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static copyImageInput(Lcom/rokid/aicore/api/bean/RecognizeDataInput;)Lcom/rokid/aicore/api/bean/RecognizeDataInput;
    .locals 3

    new-instance v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;

    invoke-direct {v0}, Lcom/rokid/aicore/api/bean/RecognizeDataInput;-><init>()V

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    iget-object v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->data:[B

    iput-object v1, v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->data:[B

    iget-wide v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->frameId:J

    iput-wide v1, v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->frameId:J

    iget v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->trackId:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->trackId:I

    iget v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->height:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->height:I

    iget v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->width:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->width:I

    iget-object p0, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->type:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    iput-object p0, v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->type:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    return-object v0
.end method


# virtual methods
.method public clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->copy()Lcom/rokid/aicore/api/bean/RecognizeDataInput;

    move-result-object v0

    return-object v0
.end method

.method public copy()Lcom/rokid/aicore/api/bean/RecognizeDataInput;
    .locals 5

    new-instance v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;

    invoke-direct {v0}, Lcom/rokid/aicore/api/bean/RecognizeDataInput;-><init>()V

    iget v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->height:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->height:I

    iget-wide v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->frameId:J

    iput-wide v1, v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->frameId:J

    iget v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->trackId:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->trackId:I

    iget v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->width:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->width:I

    iget-object v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->type:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    iput-object v1, v0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->type:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    iget-object v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->data:[B

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

    const-string v1, "RecognizeDataInput{, width="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->width:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", height="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->height:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", type="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->type:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", frameId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->frameId:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", trackId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->trackId:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
