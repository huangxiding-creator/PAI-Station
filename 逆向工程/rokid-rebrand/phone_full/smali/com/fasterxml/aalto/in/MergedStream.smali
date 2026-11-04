.class public final Lcom/fasterxml/aalto/in/MergedStream;
.super Ljava/io/InputStream;
.source "MergedStream.java"


# instance fields
.field private final mConfig:Lcom/fasterxml/aalto/in/ReaderConfig;

.field private mData:[B

.field private final mEnd:I

.field private final mIn:Ljava/io/InputStream;

.field private mPtr:I


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;[BII)V
    .locals 0
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "buf"    # [B
    .param p4, "start"    # I
    .param p5, "end"    # I

    .line 28
    invoke-direct {p0}, Ljava/io/InputStream;-><init>()V

    .line 29
    iput-object p1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mConfig:Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 30
    iput-object p2, p0, Lcom/fasterxml/aalto/in/MergedStream;->mIn:Ljava/io/InputStream;

    .line 31
    iput-object p3, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    .line 32
    iput p4, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    .line 33
    iput p5, p0, Lcom/fasterxml/aalto/in/MergedStream;->mEnd:I

    .line 34
    return-void
.end method

.method private freeBuffers()V
    .locals 2

    .line 143
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    if-eqz v0, :cond_0

    .line 144
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    .line 145
    .local v0, "data":[B
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    .line 146
    iget-object v1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mConfig:Lcom/fasterxml/aalto/in/ReaderConfig;

    if-eqz v1, :cond_0

    .line 147
    iget-object v1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mConfig:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->freeFullBBuffer([B)V

    .line 150
    .end local v0    # "data":[B
    :cond_0
    return-void
.end method


# virtual methods
.method public available()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 39
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    if-eqz v0, :cond_0

    .line 40
    iget v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mEnd:I

    iget v1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    sub-int/2addr v0, v1

    return v0

    .line 42
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mIn:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->available()I

    move-result v0

    return v0
.end method

.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 48
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/MergedStream;->freeBuffers()V

    .line 49
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mIn:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 50
    return-void
.end method

.method public declared-synchronized mark(I)V
    .locals 1
    .param p1, "readlimit"    # I

    monitor-enter p0

    .line 55
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    if-nez v0, :cond_0

    .line 56
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mIn:Ljava/io/InputStream;

    invoke-virtual {v0, p1}, Ljava/io/InputStream;->mark(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 58
    .end local p0    # "this":Lcom/fasterxml/aalto/in/MergedStream;
    :cond_0
    monitor-exit p0

    return-void

    .line 54
    .end local p1    # "readlimit":I
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public markSupported()Z
    .locals 1

    .line 64
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mIn:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->markSupported()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public read()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 70
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    if-eqz v0, :cond_1

    .line 71
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v0, v0, 0xff

    .line 72
    .local v0, "c":I
    iget v1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/MergedStream;->mEnd:I

    if-lt v1, v2, :cond_0

    .line 73
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/MergedStream;->freeBuffers()V

    .line 75
    :cond_0
    return v0

    .line 77
    .end local v0    # "c":I
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mIn:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->read()I

    move-result v0

    return v0
.end method

.method public read([B)I
    .locals 2
    .param p1, "b"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 83
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/in/MergedStream;->read([BII)I

    move-result v0

    return v0
.end method

.method public read([BII)I
    .locals 3
    .param p1, "b"    # [B
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 89
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    if-eqz v0, :cond_2

    .line 90
    iget v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mEnd:I

    iget v1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    sub-int/2addr v0, v1

    .line 91
    .local v0, "avail":I
    if-le p3, v0, :cond_0

    .line 92
    move p3, v0

    .line 94
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    invoke-static {v1, v2, p1, p2, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 95
    iget v1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    add-int/2addr v1, p3

    iput v1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    .line 96
    iget v1, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/MergedStream;->mEnd:I

    if-lt v1, v2, :cond_1

    .line 97
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/MergedStream;->freeBuffers()V

    .line 99
    :cond_1
    return p3

    .line 101
    .end local v0    # "avail":I
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mIn:Ljava/io/InputStream;

    invoke-virtual {v0, p1, p2, p3}, Ljava/io/InputStream;->read([BII)I

    move-result v0

    return v0
.end method

.method public declared-synchronized reset()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    monitor-enter p0

    .line 107
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    if-nez v0, :cond_0

    .line 108
    iget-object v0, p0, Lcom/fasterxml/aalto/in/MergedStream;->mIn:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->reset()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 110
    .end local p0    # "this":Lcom/fasterxml/aalto/in/MergedStream;
    :cond_0
    monitor-exit p0

    return-void

    .line 106
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public skip(J)J
    .locals 5
    .param p1, "n"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 115
    const-wide/16 v0, 0x0

    .line 117
    .local v0, "count":J
    iget-object v2, p0, Lcom/fasterxml/aalto/in/MergedStream;->mData:[B

    if-eqz v2, :cond_1

    .line 118
    iget v2, p0, Lcom/fasterxml/aalto/in/MergedStream;->mEnd:I

    iget v3, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    sub-int/2addr v2, v3

    .line 120
    .local v2, "amount":I
    int-to-long v3, v2

    cmp-long v3, v3, p1

    if-lez v3, :cond_0

    .line 121
    iget v3, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    long-to-int v4, p1

    add-int/2addr v3, v4

    iput v3, p0, Lcom/fasterxml/aalto/in/MergedStream;->mPtr:I

    .line 122
    return-wide p1

    .line 124
    :cond_0
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/MergedStream;->freeBuffers()V

    .line 125
    int-to-long v3, v2

    add-long/2addr v0, v3

    .line 126
    int-to-long v3, v2

    sub-long/2addr p1, v3

    .line 129
    .end local v2    # "amount":I
    :cond_1
    const-wide/16 v2, 0x0

    cmp-long v2, p1, v2

    if-lez v2, :cond_2

    .line 130
    iget-object v2, p0, Lcom/fasterxml/aalto/in/MergedStream;->mIn:Ljava/io/InputStream;

    invoke-virtual {v2, p1, p2}, Ljava/io/InputStream;->skip(J)J

    move-result-wide v2

    add-long/2addr v0, v2

    .line 132
    :cond_2
    return-wide v0
.end method
