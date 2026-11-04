.class public Lcom/rokid/aicore/api/bean/BufferImageInput;
.super Ljava/lang/Object;


# instance fields
.field public data:Ljava/nio/ByteBuffer;

.field public frame_id:J

.field public height:I

.field public offset:I

.field public size:I

.field public type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

.field public width:I


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static fromRemaining(Ljava/nio/ByteBuffer;IILcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;J)Lcom/rokid/aicore/api/bean/BufferImageInput;
    .locals 3

    new-instance v0, Lcom/rokid/aicore/api/bean/BufferImageInput;

    invoke-direct {v0}, Lcom/rokid/aicore/api/bean/BufferImageInput;-><init>()V

    iput-object p0, v0, Lcom/rokid/aicore/api/bean/BufferImageInput;->data:Ljava/nio/ByteBuffer;

    const/4 v1, 0x0

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->position()I

    move-result v2

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    iput v2, v0, Lcom/rokid/aicore/api/bean/BufferImageInput;->offset:I

    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    :cond_1
    iput v1, v0, Lcom/rokid/aicore/api/bean/BufferImageInput;->size:I

    iput p1, v0, Lcom/rokid/aicore/api/bean/BufferImageInput;->width:I

    iput p2, v0, Lcom/rokid/aicore/api/bean/BufferImageInput;->height:I

    iput-object p3, v0, Lcom/rokid/aicore/api/bean/BufferImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    iput-wide p4, v0, Lcom/rokid/aicore/api/bean/BufferImageInput;->frame_id:J

    return-object v0
.end method


# virtual methods
.method public borrowedView()Ljava/nio/ByteBuffer;
    .locals 3

    invoke-virtual {p0}, Lcom/rokid/aicore/api/bean/BufferImageInput;->isValid()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->data:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->asReadOnlyBuffer()Ljava/nio/ByteBuffer;

    move-result-object v0

    iget v1, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->offset:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    iget v1, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->offset:I

    iget v2, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->size:I

    add-int/2addr v1, v2

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->asReadOnlyBuffer()Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Invalid direct image buffer"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public isValid()Z
    .locals 4

    iget-object v0, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->data:Ljava/nio/ByteBuffer;

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->width:I

    if-lez v0, :cond_2

    iget v0, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->height:I

    if-gtz v0, :cond_0

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->offset:I

    if-ltz v0, :cond_2

    iget v2, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->size:I

    if-lez v2, :cond_2

    iget-object v2, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->data:Ljava/nio/ByteBuffer;

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v2

    if-le v0, v2, :cond_1

    goto :goto_0

    :cond_1
    iget v0, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->size:I

    iget-object v2, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->data:Ljava/nio/ByteBuffer;

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v2

    iget v3, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->offset:I

    sub-int/2addr v2, v3

    if-gt v0, v2, :cond_2

    iget v0, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->size:I

    invoke-virtual {p0}, Lcom/rokid/aicore/api/bean/BufferImageInput;->requiredSize()I

    move-result v2

    if-lt v0, v2, :cond_2

    const/4 v1, 0x1

    :cond_2
    :goto_0
    return v1
.end method

.method public requiredSize()I
    .locals 6

    iget v0, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->width:I

    int-to-long v0, v0

    iget v2, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->height:I

    int-to-long v2, v2

    mul-long/2addr v0, v2

    sget-object v2, Lcom/rokid/aicore/api/bean/BufferImageInput$1;->$SwitchMap$com$rokid$aicore$ncnn$bean$MotConfig$ImageType:[I

    iget-object v3, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    invoke-virtual {v3}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->ordinal()I

    move-result v3

    aget v2, v2, v3

    const/4 v3, -0x1

    const-wide/16 v4, 0x3

    packed-switch v2, :pswitch_data_0

    return v3

    :pswitch_0
    mul-long/2addr v0, v4

    goto :goto_0

    :pswitch_1
    mul-long/2addr v0, v4

    const-wide/16 v4, 0x2

    div-long/2addr v0, v4

    :goto_0
    const-wide/16 v4, 0x0

    cmp-long v2, v0, v4

    if-lez v2, :cond_0

    const-wide/32 v4, 0x7fffffff

    cmp-long v2, v0, v4

    if-gtz v2, :cond_0

    long-to-int v3, v0

    :cond_0
    return v3

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public toMetadataImageInput()Lcom/rokid/aicore/api/bean/ImageInput;
    .locals 3

    new-instance v0, Lcom/rokid/aicore/api/bean/ImageInput;

    invoke-direct {v0}, Lcom/rokid/aicore/api/bean/ImageInput;-><init>()V

    iget v1, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->width:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    iget v1, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->height:I

    iput v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    iget-object v1, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    iput-object v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    iget-wide v1, p0, Lcom/rokid/aicore/api/bean/BufferImageInput;->frame_id:J

    iput-wide v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    const/4 v1, 0x0

    iput-object v1, v0, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    return-object v0
.end method
