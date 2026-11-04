.class final Lcom/fasterxml/aalto/out/CharWName;
.super Lcom/fasterxml/aalto/out/WName;
.source "CharWName.java"


# instance fields
.field final _chars:[C


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "localName"    # Ljava/lang/String;

    .line 37
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/out/WName;-><init>(Ljava/lang/String;)V

    .line 38
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/CharWName;->_chars:[C

    .line 39
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 43
    invoke-direct {p0, p1, p2}, Lcom/fasterxml/aalto/out/WName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 44
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 45
    .local v0, "plen":I
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    .line 46
    .local v1, "llen":I
    add-int/lit8 v2, v0, 0x1

    add-int/2addr v2, v1

    new-array v2, v2, [C

    iput-object v2, p0, Lcom/fasterxml/aalto/out/CharWName;->_chars:[C

    .line 47
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharWName;->_chars:[C

    const/4 v3, 0x0

    invoke-virtual {p1, v3, v0, v2, v3}, Ljava/lang/String;->getChars(II[CI)V

    .line 48
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharWName;->_chars:[C

    const/16 v4, 0x3a

    aput-char v4, v2, v0

    .line 49
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharWName;->_chars:[C

    add-int/lit8 v4, v0, 0x1

    invoke-virtual {p2, v3, v1, v2, v4}, Ljava/lang/String;->getChars(II[CI)V

    .line 50
    return-void
.end method


# virtual methods
.method public appendBytes([BI)I
    .locals 2
    .param p1, "buffer"    # [B
    .param p2, "offset"    # I

    .line 61
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Internal error: appendBytes() should never be called"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public appendChars([CI)I
    .locals 3
    .param p1, "buffer"    # [C
    .param p2, "offset"    # I

    .line 73
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharWName;->_chars:[C

    array-length v0, v0

    .line 74
    .local v0, "len":I
    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharWName;->_chars:[C

    const/4 v2, 0x0

    invoke-static {v1, v2, p1, p2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 75
    return v0
.end method

.method public final serializedLength()I
    .locals 1

    .line 55
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharWName;->_chars:[C

    array-length v0, v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 87
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharWName;->_prefix:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 88
    new-instance v0, Ljava/lang/String;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharWName;->_chars:[C

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([C)V

    return-object v0

    .line 90
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharWName;->_localName:Ljava/lang/String;

    return-object v0
.end method

.method public writeBytes(Ljava/io/OutputStream;)V
    .locals 2
    .param p1, "out"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 67
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Internal error: writeBytes() should never be called"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public writeChars(Ljava/io/Writer;)V
    .locals 1
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 81
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharWName;->_chars:[C

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write([C)V

    .line 82
    return-void
.end method
