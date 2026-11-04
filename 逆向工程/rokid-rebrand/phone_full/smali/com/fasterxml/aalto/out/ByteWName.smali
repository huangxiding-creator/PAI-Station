.class public final Lcom/fasterxml/aalto/out/ByteWName;
.super Lcom/fasterxml/aalto/out/WName;
.source "ByteWName.java"


# instance fields
.field final _bytes:[B


# direct methods
.method protected constructor <init>(Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "ln"    # Ljava/lang/String;
    .param p3, "bytes"    # [B

    .line 38
    invoke-direct {p0, p1, p2}, Lcom/fasterxml/aalto/out/WName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 39
    iput-object p3, p0, Lcom/fasterxml/aalto/out/ByteWName;->_bytes:[B

    .line 40
    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;[B)V
    .locals 0
    .param p1, "ln"    # Ljava/lang/String;
    .param p2, "bytes"    # [B

    .line 32
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/out/WName;-><init>(Ljava/lang/String;)V

    .line 33
    iput-object p2, p0, Lcom/fasterxml/aalto/out/ByteWName;->_bytes:[B

    .line 34
    return-void
.end method


# virtual methods
.method public appendBytes([BI)I
    .locals 3
    .param p1, "buffer"    # [B
    .param p2, "offset"    # I

    .line 51
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteWName;->_bytes:[B

    array-length v0, v0

    .line 52
    .local v0, "len":I
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteWName;->_bytes:[B

    const/4 v2, 0x0

    invoke-static {v1, v2, p1, p2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 53
    return v0
.end method

.method public appendChars([CI)I
    .locals 2
    .param p1, "buffer"    # [C
    .param p2, "offset"    # I

    .line 65
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Internal error: appendChars() should never be called"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final serializedLength()I
    .locals 1

    .line 45
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteWName;->_bytes:[B

    array-length v0, v0

    return v0
.end method

.method public writeBytes(Ljava/io/OutputStream;)V
    .locals 1
    .param p1, "out"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 59
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteWName;->_bytes:[B

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    .line 60
    return-void
.end method

.method public writeChars(Ljava/io/Writer;)V
    .locals 2
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 71
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Internal error: writeChars() should never be called"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
