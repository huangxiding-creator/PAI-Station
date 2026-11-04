.class public Lorg/codehaus/stax2/io/Stax2ByteArraySource;
.super Lorg/codehaus/stax2/io/Stax2BlockSource;
.source "Stax2ByteArraySource.java"


# static fields
.field private static final DEFAULT_ENCODING:Ljava/lang/String; = "UTF-8"


# instance fields
.field final mBuffer:[B

.field final mLength:I

.field final mStart:I


# direct methods
.method public constructor <init>([BII)V
    .locals 0
    .param p1, "buf"    # [B
    .param p2, "start"    # I
    .param p3, "len"    # I

    .line 26
    invoke-direct {p0}, Lorg/codehaus/stax2/io/Stax2BlockSource;-><init>()V

    .line 27
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mBuffer:[B

    .line 28
    iput p2, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mStart:I

    .line 29
    iput p3, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mLength:I

    .line 30
    return-void
.end method


# virtual methods
.method public constructInputStream()Ljava/io/InputStream;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 57
    new-instance v0, Ljava/io/ByteArrayInputStream;

    iget-object v1, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mBuffer:[B

    iget v2, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mStart:I

    iget v3, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mLength:I

    invoke-direct {v0, v1, v2, v3}, Ljava/io/ByteArrayInputStream;-><init>([BII)V

    return-object v0
.end method

.method public constructReader()Ljava/io/Reader;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 44
    invoke-virtual {p0}, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->getEncoding()Ljava/lang/String;

    move-result-object v0

    .line 45
    .local v0, "enc":Ljava/lang/String;
    invoke-virtual {p0}, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->constructInputStream()Ljava/io/InputStream;

    move-result-object v1

    .line 46
    .local v1, "in":Ljava/io/InputStream;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_1

    .line 49
    :cond_0
    const-string v0, "UTF-8"

    .line 51
    :cond_1
    new-instance v2, Ljava/io/InputStreamReader;

    invoke-direct {v2, v1, v0}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    return-object v2
.end method

.method public getBuffer()[B
    .locals 1

    .line 67
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mBuffer:[B

    return-object v0
.end method

.method public getBufferEnd()I
    .locals 2

    .line 79
    iget v0, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mStart:I

    .line 80
    .local v0, "end":I
    iget v1, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mLength:I

    if-lez v1, :cond_0

    .line 81
    iget v1, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mLength:I

    add-int/2addr v0, v1

    .line 83
    :cond_0
    return v0
.end method

.method public getBufferLength()I
    .locals 1

    .line 75
    iget v0, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mLength:I

    return v0
.end method

.method public getBufferStart()I
    .locals 1

    .line 71
    iget v0, p0, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->mStart:I

    return v0
.end method
