.class public abstract Lcom/fasterxml/aalto/out/SingleByteXmlWriter;
.super Lcom/fasterxml/aalto/out/ByteXmlWriter;
.source "SingleByteXmlWriter.java"


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/OutputStream;Lcom/fasterxml/aalto/util/XmlCharTypes;)V
    .locals 0
    .param p1, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;
    .param p2, "out"    # Ljava/io/OutputStream;
    .param p3, "charTypes"    # Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 33
    invoke-direct {p0, p1, p2, p3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/OutputStream;Lcom/fasterxml/aalto/util/XmlCharTypes;)V

    .line 34
    return-void
.end method


# virtual methods
.method public abstract getHighestEncodable()I
.end method

.method protected final output2ByteChar(I)V
    .locals 1
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 59
    const-string v0, "content"

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/out/SingleByteXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 60
    return-void
.end method

.method protected final outputMultiByteChar(I[CII)I
    .locals 1
    .param p1, "ch"    # I
    .param p2, "cbuf"    # [C
    .param p3, "inputOffset"    # I
    .param p4, "inputLen"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 82
    const v0, 0xd800

    if-lt p1, v0, :cond_2

    .line 83
    const v0, 0xdfff

    if-gt p1, v0, :cond_1

    .line 85
    if-lt p3, p4, :cond_0

    .line 86
    iput p1, p0, Lcom/fasterxml/aalto/out/SingleByteXmlWriter;->_surrogate:I

    goto :goto_0

    .line 88
    :cond_0
    add-int/lit8 v0, p3, 0x1

    .end local p3    # "inputOffset":I
    .local v0, "inputOffset":I
    aget-char p3, p2, p3

    .line 89
    .local p3, "ch2":I
    invoke-virtual {p0, p1, p3}, Lcom/fasterxml/aalto/out/SingleByteXmlWriter;->outputSurrogates(II)V

    move p3, v0

    .line 91
    .end local v0    # "inputOffset":I
    .local p3, "inputOffset":I
    :goto_0
    return p3

    .line 92
    :cond_1
    const v0, 0xfffe

    if-lt p1, v0, :cond_2

    .line 93
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/SingleByteXmlWriter;->reportInvalidChar(I)V

    .line 96
    :cond_2
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/SingleByteXmlWriter;->writeAsEntity(I)V

    .line 97
    return p3
.end method

.method protected final outputStrictMultiByteChar(I[CII)I
    .locals 1
    .param p1, "ch"    # I
    .param p2, "cbuf"    # [C
    .param p3, "inputOffset"    # I
    .param p4, "inputLen"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 71
    const-string v0, "content"

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/out/SingleByteXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 72
    const/4 v0, 0x0

    return v0
.end method

.method protected final outputSurrogates(II)V
    .locals 1
    .param p1, "surr1"    # I
    .param p2, "surr2"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 104
    const-string v0, " in content"

    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/aalto/out/SingleByteXmlWriter;->calcSurrogate(IILjava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/SingleByteXmlWriter;->writeAsEntity(I)V

    .line 105
    return-void
.end method

.method public abstract writeRaw([CII)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method
