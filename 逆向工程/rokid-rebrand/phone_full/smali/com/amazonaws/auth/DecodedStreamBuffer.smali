.class Lcom/amazonaws/auth/DecodedStreamBuffer;
.super Ljava/lang/Object;
.source "DecodedStreamBuffer.java"


# static fields
.field private static final log:Lcom/amazonaws/logging/Log;


# instance fields
.field private bufferArray:[B

.field private bufferSizeOverflow:Z

.field private byteBuffered:I

.field private maxBufferSize:I

.field private pos:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 24
    const-class v0, Lcom/amazonaws/auth/DecodedStreamBuffer;

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/auth/DecodedStreamBuffer;->log:Lcom/amazonaws/logging/Log;

    return-void
.end method

.method public constructor <init>(I)V
    .locals 1
    .param p1, "maxBufferSize"    # I

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 29
    const/4 v0, -0x1

    iput v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->pos:I

    .line 33
    new-array v0, p1, [B

    iput-object v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->bufferArray:[B

    .line 34
    iput p1, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->maxBufferSize:I

    .line 35
    return-void
.end method


# virtual methods
.method public buffer(B)V
    .locals 3
    .param p1, "read"    # B

    .line 38
    const/4 v0, -0x1

    iput v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->pos:I

    .line 39
    iget v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->byteBuffered:I

    iget v1, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->maxBufferSize:I

    if-lt v0, v1, :cond_1

    .line 40
    sget-object v0, Lcom/amazonaws/auth/DecodedStreamBuffer;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v0}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 41
    sget-object v0, Lcom/amazonaws/auth/DecodedStreamBuffer;->log:Lcom/amazonaws/logging/Log;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Buffer size "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->maxBufferSize:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " has been exceeded and the input stream will not be repeatable. Freeing buffer memory"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 45
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->bufferSizeOverflow:Z

    goto :goto_0

    .line 48
    :cond_1
    iget-object v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->bufferArray:[B

    iget v1, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->byteBuffered:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->byteBuffered:I

    aput-byte p1, v0, v1

    .line 49
    :goto_0
    return-void
.end method

.method public buffer([BII)V
    .locals 3
    .param p1, "array"    # [B
    .param p2, "offset"    # I
    .param p3, "length"    # I

    .line 52
    const/4 v0, -0x1

    iput v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->pos:I

    .line 53
    iget v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->byteBuffered:I

    add-int/2addr v0, p3

    iget v1, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->maxBufferSize:I

    if-le v0, v1, :cond_1

    .line 54
    sget-object v0, Lcom/amazonaws/auth/DecodedStreamBuffer;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v0}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 55
    sget-object v0, Lcom/amazonaws/auth/DecodedStreamBuffer;->log:Lcom/amazonaws/logging/Log;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Buffer size "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->maxBufferSize:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " has been exceeded and the input stream will not be repeatable. Freeing buffer memory"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 59
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->bufferSizeOverflow:Z

    goto :goto_0

    .line 62
    :cond_1
    iget-object v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->bufferArray:[B

    iget v1, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->byteBuffered:I

    invoke-static {p1, p2, v0, v1, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 63
    iget v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->byteBuffered:I

    add-int/2addr v0, p3

    iput v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->byteBuffered:I

    .line 65
    :goto_0
    return-void
.end method

.method public hasNext()Z
    .locals 2

    .line 68
    iget v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->pos:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->pos:I

    iget v1, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->byteBuffered:I

    if-ge v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public next()B
    .locals 3

    .line 72
    iget-object v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->bufferArray:[B

    iget v1, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->pos:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->pos:I

    aget-byte v0, v0, v1

    return v0
.end method

.method public startReadBuffer()V
    .locals 3

    .line 76
    iget-boolean v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->bufferSizeOverflow:Z

    if-nez v0, :cond_0

    .line 81
    const/4 v0, 0x0

    iput v0, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->pos:I

    .line 82
    return-void

    .line 77
    :cond_0
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "The input stream is not repeatable since the buffer size "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/amazonaws/auth/DecodedStreamBuffer;->maxBufferSize:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " has been exceeded."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
