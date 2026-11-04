.class public Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;
.super Ljava/lang/Object;


# instance fields
.field private data:Ljava/nio/ByteBuffer;

.field private frameId:J

.field private height:I

.field private label:Ljava/lang/String;

.field private libraryName:Ljava/lang/String;

.field private personId:I

.field private rect:Landroid/graphics/Rect;

.field private regScore:F

.field private trackId:I

.field private width:I


# direct methods
.method public constructor <init>(IILjava/lang/String;FLjava/lang/String;Ljava/nio/ByteBuffer;IILandroid/graphics/Rect;I)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->label:Ljava/lang/String;

    iput-object v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->libraryName:Ljava/lang/String;

    int-to-long v0, p1

    iput-wide v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->frameId:J

    iput p2, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->trackId:I

    iput p4, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->regScore:F

    iput-object p3, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->label:Ljava/lang/String;

    iput-object p5, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->libraryName:Ljava/lang/String;

    iput-object p6, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->data:Ljava/nio/ByteBuffer;

    iput p7, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->width:I

    iput p8, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->height:I

    iput-object p9, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->rect:Landroid/graphics/Rect;

    iput p10, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->personId:I

    return-void
.end method


# virtual methods
.method public getData()Ljava/nio/ByteBuffer;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->data:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getFrameId()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->frameId:J

    return-wide v0
.end method

.method public getHeight()I
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->height:I

    return v0
.end method

.method public getLabel()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->label:Ljava/lang/String;

    return-object v0
.end method

.method public getLibraryName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->libraryName:Ljava/lang/String;

    return-object v0
.end method

.method public getPersonId()I
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->personId:I

    return v0
.end method

.method public getRect()Landroid/graphics/Rect;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->rect:Landroid/graphics/Rect;

    return-object v0
.end method

.method public getRegScore()F
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->regScore:F

    return v0
.end method

.method public getTrackId()I
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->trackId:I

    return v0
.end method

.method public getWidth()I
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->width:I

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "FaceRecognizeResult[frameId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->frameId:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", libraryName=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->libraryName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", trackId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->trackId:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", regScore="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->regScore:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", personId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->personId:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", label=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;->label:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x27

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x5d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
