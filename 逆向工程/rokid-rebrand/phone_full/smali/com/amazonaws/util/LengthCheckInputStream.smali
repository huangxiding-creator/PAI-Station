.class public Lcom/amazonaws/util/LengthCheckInputStream;
.super Lcom/amazonaws/internal/SdkFilterInputStream;
.source "LengthCheckInputStream.java"


# static fields
.field public static final EXCLUDE_SKIPPED_BYTES:Z = false

.field public static final INCLUDE_SKIPPED_BYTES:Z = true


# instance fields
.field private dataLength:J

.field private final expectedLength:J

.field private final includeSkipped:Z

.field private marked:J


# direct methods
.method public constructor <init>(Ljava/io/InputStream;JZ)V
    .locals 2
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "expectedLength"    # J
    .param p4, "includeSkipped"    # Z

    .line 67
    invoke-direct {p0, p1}, Lcom/amazonaws/internal/SdkFilterInputStream;-><init>(Ljava/io/InputStream;)V

    .line 68
    const-wide/16 v0, 0x0

    cmp-long v0, p2, v0

    if-ltz v0, :cond_0

    .line 70
    iput-wide p2, p0, Lcom/amazonaws/util/LengthCheckInputStream;->expectedLength:J

    .line 71
    iput-boolean p4, p0, Lcom/amazonaws/util/LengthCheckInputStream;->includeSkipped:Z

    .line 72
    return-void

    .line 69
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw v0
.end method

.method private checkLength(Z)V
    .locals 5
    .param p1, "eof"    # Z

    .line 128
    const-string v0, ")"

    if-eqz p1, :cond_1

    .line 129
    iget-wide v1, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    iget-wide v3, p0, Lcom/amazonaws/util/LengthCheckInputStream;->expectedLength:J

    cmp-long v1, v1, v3

    if-nez v1, :cond_0

    goto :goto_0

    .line 130
    :cond_0
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Data read ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ") has a different length than the expected ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p0, Lcom/amazonaws/util/LengthCheckInputStream;->expectedLength:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 134
    :cond_1
    iget-wide v1, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    iget-wide v3, p0, Lcom/amazonaws/util/LengthCheckInputStream;->expectedLength:J

    cmp-long v1, v1, v3

    if-gtz v1, :cond_2

    .line 138
    :goto_0
    return-void

    .line 135
    :cond_2
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "More data read ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ") than expected ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-wide v3, p0, Lcom/amazonaws/util/LengthCheckInputStream;->expectedLength:J

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v1
.end method


# virtual methods
.method public mark(I)V
    .locals 2
    .param p1, "readlimit"    # I

    .line 107
    invoke-super {p0, p1}, Lcom/amazonaws/internal/SdkFilterInputStream;->mark(I)V

    .line 108
    iget-wide v0, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    iput-wide v0, p0, Lcom/amazonaws/util/LengthCheckInputStream;->marked:J

    .line 109
    return-void
.end method

.method public read()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 83
    invoke-super {p0}, Lcom/amazonaws/internal/SdkFilterInputStream;->read()I

    move-result v0

    .line 84
    .local v0, "c":I
    if-ltz v0, :cond_0

    .line 85
    iget-wide v1, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    const-wide/16 v3, 0x1

    add-long/2addr v1, v3

    iput-wide v1, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    .line 86
    :cond_0
    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    const/4 v1, 0x1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :goto_0
    invoke-direct {p0, v1}, Lcom/amazonaws/util/LengthCheckInputStream;->checkLength(Z)V

    .line 87
    return v0
.end method

.method public read([BII)I
    .locals 5
    .param p1, "b"    # [B
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 99
    invoke-super {p0, p1, p2, p3}, Lcom/amazonaws/internal/SdkFilterInputStream;->read([BII)I

    move-result v0

    .line 100
    .local v0, "readLen":I
    iget-wide v1, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    if-ltz v0, :cond_0

    int-to-long v3, v0

    goto :goto_0

    :cond_0
    const-wide/16 v3, 0x0

    :goto_0
    add-long/2addr v1, v3

    iput-wide v1, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    .line 101
    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    const/4 v1, 0x1

    goto :goto_1

    :cond_1
    const/4 v1, 0x0

    :goto_1
    invoke-direct {p0, v1}, Lcom/amazonaws/util/LengthCheckInputStream;->checkLength(Z)V

    .line 102
    return v0
.end method

.method public reset()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 113
    invoke-super {p0}, Lcom/amazonaws/internal/SdkFilterInputStream;->reset()V

    .line 114
    invoke-super {p0}, Lcom/amazonaws/internal/SdkFilterInputStream;->markSupported()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 115
    iget-wide v0, p0, Lcom/amazonaws/util/LengthCheckInputStream;->marked:J

    iput-wide v0, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    .line 117
    :cond_0
    return-void
.end method

.method public skip(J)J
    .locals 4
    .param p1, "n"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 148
    invoke-super {p0, p1, p2}, Lcom/amazonaws/internal/SdkFilterInputStream;->skip(J)J

    move-result-wide v0

    .line 149
    .local v0, "skipped":J
    iget-boolean v2, p0, Lcom/amazonaws/util/LengthCheckInputStream;->includeSkipped:Z

    if-eqz v2, :cond_0

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-lez v2, :cond_0

    .line 150
    iget-wide v2, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    add-long/2addr v2, v0

    iput-wide v2, p0, Lcom/amazonaws/util/LengthCheckInputStream;->dataLength:J

    .line 151
    const/4 v2, 0x0

    invoke-direct {p0, v2}, Lcom/amazonaws/util/LengthCheckInputStream;->checkLength(Z)V

    .line 153
    :cond_0
    return-wide v0
.end method
