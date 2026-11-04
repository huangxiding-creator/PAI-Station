.class public final Lcom/fasterxml/aalto/out/AsciiXmlWriter;
.super Lcom/fasterxml/aalto/out/SingleByteXmlWriter;
.source "AsciiXmlWriter.java"


# static fields
.field static final LAST_VALID_CHAR:I = 0x7f


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/OutputStream;)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;
    .param p2, "out"    # Ljava/io/OutputStream;

    .line 40
    invoke-static {}, Lcom/fasterxml/aalto/out/OutputCharTypes;->getAsciiCharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-result-object v0

    invoke-direct {p0, p1, p2, v0}, Lcom/fasterxml/aalto/out/SingleByteXmlWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/OutputStream;Lcom/fasterxml/aalto/util/XmlCharTypes;)V

    .line 41
    return-void
.end method


# virtual methods
.method protected doConstructName(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 2
    .param p1, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 81
    new-instance v0, Lcom/fasterxml/aalto/out/ByteWName;

    invoke-static {p1}, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->getAscii(Ljava/lang/String;)[B

    move-result-object v1

    invoke-direct {v0, p1, v1}, Lcom/fasterxml/aalto/out/ByteWName;-><init>(Ljava/lang/String;[B)V

    return-object v0
.end method

.method protected doConstructName(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 88
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 89
    .local v0, "plen":I
    add-int/lit8 v1, v0, 0x1

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v1, v2

    new-array v1, v1, [B

    .line 90
    .local v1, "pname":[B
    const/4 v2, 0x0

    invoke-static {p1, v1, v2}, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->getAscii(Ljava/lang/String;[BI)V

    .line 91
    const/16 v2, 0x3a

    aput-byte v2, v1, v0

    .line 92
    add-int/lit8 v2, v0, 0x1

    invoke-static {p2, v1, v2}, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->getAscii(Ljava/lang/String;[BI)V

    .line 93
    new-instance v2, Lcom/fasterxml/aalto/out/ByteWName;

    invoke-direct {v2, p1, p2, v1}, Lcom/fasterxml/aalto/out/ByteWName;-><init>(Ljava/lang/String;Ljava/lang/String;[B)V

    return-object v2
.end method

.method public getHighestEncodable()I
    .locals 1

    .line 45
    const/16 v0, 0x7f

    return v0
.end method

.method public writeRaw([CII)V
    .locals 4
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 52
    iget-object v0, p0, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->_out:Ljava/io/OutputStream;

    if-eqz v0, :cond_5

    if-nez p3, :cond_0

    goto :goto_1

    .line 55
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->_surrogate:I

    if-eqz v0, :cond_1

    .line 56
    iget v0, p0, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->_surrogate:I

    aget-char v1, p1, p2

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->outputSurrogates(II)V

    .line 57
    add-int/lit8 p2, p2, 0x1

    .line 58
    add-int/lit8 p3, p3, -0x1

    .line 61
    :cond_1
    add-int/2addr p3, p2

    .line 65
    :goto_0
    if-ge p2, p3, :cond_4

    .line 66
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .local v0, "offset":I
    aget-char p2, p1, p2

    .line 67
    .local p2, "ch":C
    const/16 v1, 0x7f

    if-le p2, v1, :cond_2

    .line 68
    const-string v1, "raw content"

    invoke-virtual {p0, v1, p2}, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 70
    :cond_2
    iget v1, p0, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->_outputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->_outputBufferLen:I

    if-lt v1, v2, :cond_3

    .line 71
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->flushBuffer()V

    .line 73
    :cond_3
    iget-object v1, p0, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->_outputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->_outputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/AsciiXmlWriter;->_outputPtr:I

    int-to-byte v3, p2

    aput-byte v3, v1, v2

    .line 74
    .end local p2    # "ch":C
    move p2, v0

    goto :goto_0

    .line 75
    .end local v0    # "offset":I
    .local p2, "offset":I
    :cond_4
    return-void

    .line 53
    :cond_5
    :goto_1
    return-void
.end method
