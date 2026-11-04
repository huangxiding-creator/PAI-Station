.class public final Lcom/fasterxml/aalto/out/Utf8XmlWriter;
.super Lcom/fasterxml/aalto/out/ByteXmlWriter;
.source "Utf8XmlWriter.java"


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/OutputStream;)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;
    .param p2, "out"    # Ljava/io/OutputStream;

    .line 35
    invoke-static {}, Lcom/fasterxml/aalto/out/OutputCharTypes;->getUtf8CharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-result-object v0

    invoke-direct {p0, p1, p2, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/OutputStream;Lcom/fasterxml/aalto/util/XmlCharTypes;)V

    .line 36
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

    .line 98
    :try_start_0
    const-string v0, "UTF-8"

    invoke-virtual {p1, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    .line 99
    .local v0, "b":[B
    new-instance v1, Lcom/fasterxml/aalto/out/ByteWName;

    invoke-direct {v1, p1, v0}, Lcom/fasterxml/aalto/out/ByteWName;-><init>(Ljava/lang/String;[B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 100
    .end local v0    # "b":[B
    :catch_0
    move-exception v0

    .line 101
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected doConstructName(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 111
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "UTF-8"

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    .line 112
    .local v0, "b":[B
    new-instance v1, Lcom/fasterxml/aalto/out/ByteWName;

    invoke-direct {v1, p1, p2, v0}, Lcom/fasterxml/aalto/out/ByteWName;-><init>(Ljava/lang/String;Ljava/lang/String;[B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 113
    .end local v0    # "b":[B
    :catch_0
    move-exception v0

    .line 114
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public getHighestEncodable()I
    .locals 1

    .line 46
    const v0, 0x10ffff

    return v0
.end method

.method protected final output2ByteChar(I)V
    .locals 3
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 142
    iget v0, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v0, v0, 0x2

    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBufferLen:I

    if-le v0, v1, :cond_0

    .line 143
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->flushBuffer()V

    .line 145
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBuffer:[B

    .line 146
    .local v0, "bbuf":[B
    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    shr-int/lit8 v2, p1, 0x6

    or-int/lit16 v2, v2, 0xc0

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 147
    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    and-int/lit8 v2, p1, 0x3f

    or-int/lit16 v2, v2, 0x80

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 148
    return-void
.end method

.method protected final outputMultiByteChar(I[CII)I
    .locals 3
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

    .line 163
    const v0, 0xd800

    if-lt p1, v0, :cond_2

    .line 164
    const v0, 0xdfff

    if-gt p1, v0, :cond_1

    .line 166
    if-lt p3, p4, :cond_0

    .line 167
    iput p1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_surrogate:I

    goto :goto_0

    .line 169
    :cond_0
    aget-char v0, p2, p3

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->outputSurrogates(II)V

    .line 170
    add-int/lit8 p3, p3, 0x1

    .line 172
    :goto_0
    return p3

    .line 175
    :cond_1
    const v0, 0xfffe

    if-lt p1, v0, :cond_2

    .line 176
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->reportInvalidChar(I)V

    .line 179
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v0, v0, 0x3

    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBufferLen:I

    if-le v0, v1, :cond_3

    .line 180
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->flushBuffer()V

    .line 182
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBuffer:[B

    .line 183
    .local v0, "bbuf":[B
    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    shr-int/lit8 v2, p1, 0xc

    or-int/lit16 v2, v2, 0xe0

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 184
    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    shr-int/lit8 v2, p1, 0x6

    and-int/lit8 v2, v2, 0x3f

    or-int/lit16 v2, v2, 0x80

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 185
    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    and-int/lit8 v2, p1, 0x3f

    or-int/lit16 v2, v2, 0x80

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 186
    return p3
.end method

.method protected final outputStrictMultiByteChar(I[CII)I
    .locals 3
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

    .line 193
    const v0, 0xd800

    if-lt p1, v0, :cond_2

    .line 194
    const v0, 0xdfff

    if-gt p1, v0, :cond_1

    .line 196
    if-lt p3, p4, :cond_0

    .line 197
    iput p1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_surrogate:I

    goto :goto_0

    .line 199
    :cond_0
    aget-char v0, p2, p3

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->outputSurrogates(II)V

    .line 200
    add-int/lit8 p3, p3, 0x1

    .line 202
    :goto_0
    return p3

    .line 205
    :cond_1
    const v0, 0xfffe

    if-lt p1, v0, :cond_2

    .line 206
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->reportInvalidChar(I)V

    .line 209
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v0, v0, 0x3

    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBufferLen:I

    if-le v0, v1, :cond_3

    .line 210
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->flushBuffer()V

    .line 212
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBuffer:[B

    .line 213
    .local v0, "bbuf":[B
    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    shr-int/lit8 v2, p1, 0xc

    or-int/lit16 v2, v2, 0xe0

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 214
    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    shr-int/lit8 v2, p1, 0x6

    and-int/lit8 v2, v2, 0x3f

    or-int/lit16 v2, v2, 0x80

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 215
    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    and-int/lit8 v2, p1, 0x3f

    or-int/lit16 v2, v2, 0x80

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 216
    return p3
.end method

.method protected final outputSurrogates(II)V
    .locals 4
    .param p1, "surr1"    # I
    .param p2, "surr2"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 128
    const-string v0, " in content"

    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->calcSurrogate(IILjava/lang/String;)I

    move-result v0

    .line 129
    .local v0, "c":I
    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v1, v1, 0x4

    iget v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBufferLen:I

    if-le v1, v2, :cond_0

    .line 130
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->flushBuffer()V

    .line 132
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    shr-int/lit8 v3, v0, 0x12

    or-int/lit16 v3, v3, 0xf0

    int-to-byte v3, v3

    aput-byte v3, v1, v2

    .line 133
    iget-object v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    shr-int/lit8 v3, v0, 0xc

    and-int/lit8 v3, v3, 0x3f

    or-int/lit16 v3, v3, 0x80

    int-to-byte v3, v3

    aput-byte v3, v1, v2

    .line 134
    iget-object v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    shr-int/lit8 v3, v0, 0x6

    and-int/lit8 v3, v3, 0x3f

    or-int/lit16 v3, v3, 0x80

    int-to-byte v3, v3

    aput-byte v3, v1, v2

    .line 135
    iget-object v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    and-int/lit8 v3, v0, 0x3f

    or-int/lit16 v3, v3, 0x80

    int-to-byte v3, v3

    aput-byte v3, v1, v2

    .line 136
    return-void
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

    .line 53
    iget-object v0, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_out:Ljava/io/OutputStream;

    if-eqz v0, :cond_7

    if-nez p3, :cond_0

    goto :goto_3

    .line 56
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_surrogate:I

    if-eqz v0, :cond_1

    .line 57
    iget v0, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_surrogate:I

    aget-char v1, p1, p2

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->outputSurrogates(II)V

    .line 58
    add-int/lit8 p2, p2, 0x1

    .line 59
    add-int/lit8 p3, p3, -0x1

    .line 62
    :cond_1
    add-int/2addr p3, p2

    .line 67
    :goto_0
    if-ge p2, p3, :cond_6

    .line 70
    :goto_1
    aget-char v0, p1, p2

    .line 71
    .local v0, "ch":I
    const/16 v1, 0x80

    if-lt v0, v1, :cond_3

    .line 72
    nop

    .line 83
    .end local v0    # "ch":I
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .local v0, "offset":I
    aget-char p2, p1, p2

    .line 84
    .local p2, "ch":C
    const/16 v1, 0x800

    if-ge p2, v1, :cond_2

    .line 85
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->output2ByteChar(I)V

    .line 86
    move p2, v0

    goto :goto_0

    .line 88
    :cond_2
    invoke-virtual {p0, p2, p1, v0, p3}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->outputMultiByteChar(I[CII)I

    move-result p2

    .line 89
    .end local v0    # "offset":I
    .local p2, "offset":I
    goto :goto_0

    .line 75
    .local v0, "ch":I
    :cond_3
    iget v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBufferLen:I

    if-lt v1, v2, :cond_4

    .line 76
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->flushBuffer()V

    .line 78
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/Utf8XmlWriter;->_outputPtr:I

    int-to-byte v3, v0

    aput-byte v3, v1, v2

    .line 79
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_5

    .line 80
    goto :goto_2

    .line 82
    .end local v0    # "ch":I
    :cond_5
    goto :goto_1

    .line 90
    :cond_6
    :goto_2
    return-void

    .line 54
    :cond_7
    :goto_3
    return-void
.end method
