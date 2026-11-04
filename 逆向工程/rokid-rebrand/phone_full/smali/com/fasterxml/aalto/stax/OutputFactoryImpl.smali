.class public final Lcom/fasterxml/aalto/stax/OutputFactoryImpl;
.super Lorg/codehaus/stax2/XMLOutputFactory2;
.source "OutputFactoryImpl.java"


# instance fields
.field protected final _config:Lcom/fasterxml/aalto/out/WriterConfig;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 61
    invoke-direct {p0}, Lorg/codehaus/stax2/XMLOutputFactory2;-><init>()V

    .line 62
    new-instance v0, Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-direct {v0}, Lcom/fasterxml/aalto/out/WriterConfig;-><init>()V

    iput-object v0, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    .line 63
    return-void
.end method

.method private createSW(Ljava/io/OutputStream;Ljava/io/Writer;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamWriter2;
    .locals 4
    .param p1, "out"    # Ljava/io/OutputStream;
    .param p2, "w"    # Ljava/io/Writer;
    .param p3, "enc"    # Ljava/lang/String;
    .param p4, "forceAutoClose"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 203
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->createNonShared()Lcom/fasterxml/aalto/out/WriterConfig;

    move-result-object v0

    .line 204
    .local v0, "cfg":Lcom/fasterxml/aalto/out/WriterConfig;
    if-eqz p4, :cond_0

    .line 205
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->doAutoCloseOutput(Z)V

    .line 210
    :cond_0
    if-nez p2, :cond_6

    .line 211
    const-string v1, "US-ASCII"

    const-string v2, "ISO-8859-1"

    const-string v3, "UTF-8"

    if-nez p3, :cond_1

    .line 212
    const-string p3, "UTF-8"

    goto :goto_0

    .line 216
    :cond_1
    if-eq p3, v3, :cond_2

    if-eq p3, v2, :cond_2

    if-eq p3, v1, :cond_2

    .line 219
    invoke-static {p3}, Lcom/fasterxml/aalto/util/CharsetNames;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    .line 223
    :cond_2
    :goto_0
    invoke-virtual {v0, p3}, Lcom/fasterxml/aalto/out/WriterConfig;->setActualEncodingIfNotSet(Ljava/lang/String;)V

    .line 226
    if-ne p3, v3, :cond_3

    .line 233
    :try_start_0
    new-instance v1, Lcom/fasterxml/aalto/out/Utf8XmlWriter;

    invoke-direct {v1, v0, p1}, Lcom/fasterxml/aalto/out/Utf8XmlWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/OutputStream;)V

    .line 234
    .local v1, "xw":Lcom/fasterxml/aalto/out/XmlWriter;
    iget-object v2, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v2, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->getUtf8Symbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v2

    .local v2, "symbols":Lcom/fasterxml/aalto/out/WNameTable;
    goto :goto_1

    .line 246
    .end local v1    # "xw":Lcom/fasterxml/aalto/out/XmlWriter;
    .end local v2    # "symbols":Lcom/fasterxml/aalto/out/WNameTable;
    :catch_0
    move-exception v1

    goto :goto_2

    .line 235
    :cond_3
    if-ne p3, v2, :cond_4

    .line 236
    new-instance v1, Lcom/fasterxml/aalto/out/Latin1XmlWriter;

    invoke-direct {v1, v0, p1}, Lcom/fasterxml/aalto/out/Latin1XmlWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/OutputStream;)V

    .line 237
    .restart local v1    # "xw":Lcom/fasterxml/aalto/out/XmlWriter;
    iget-object v2, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v2, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->getLatin1Symbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v2

    .restart local v2    # "symbols":Lcom/fasterxml/aalto/out/WNameTable;
    goto :goto_1

    .line 238
    .end local v1    # "xw":Lcom/fasterxml/aalto/out/XmlWriter;
    .end local v2    # "symbols":Lcom/fasterxml/aalto/out/WNameTable;
    :cond_4
    if-ne p3, v1, :cond_5

    .line 239
    new-instance v1, Lcom/fasterxml/aalto/out/AsciiXmlWriter;

    invoke-direct {v1, v0, p1}, Lcom/fasterxml/aalto/out/AsciiXmlWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/OutputStream;)V

    .line 240
    .restart local v1    # "xw":Lcom/fasterxml/aalto/out/XmlWriter;
    iget-object v2, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v2, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->getAsciiSymbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v2

    .restart local v2    # "symbols":Lcom/fasterxml/aalto/out/WNameTable;
    goto :goto_1

    .line 242
    .end local v1    # "xw":Lcom/fasterxml/aalto/out/XmlWriter;
    .end local v2    # "symbols":Lcom/fasterxml/aalto/out/WNameTable;
    :cond_5
    new-instance v1, Ljava/io/OutputStreamWriter;

    invoke-direct {v1, p1, p3}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V

    move-object p2, v1

    .line 243
    new-instance v1, Lcom/fasterxml/aalto/out/CharXmlWriter;

    invoke-direct {v1, v0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/Writer;)V

    .line 244
    .restart local v1    # "xw":Lcom/fasterxml/aalto/out/XmlWriter;
    iget-object v2, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v2, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->getCharSymbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v2
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 248
    .restart local v2    # "symbols":Lcom/fasterxml/aalto/out/WNameTable;
    :goto_1
    goto :goto_3

    .line 247
    .end local v2    # "symbols":Lcom/fasterxml/aalto/out/WNameTable;
    .local v1, "ioe":Ljava/io/IOException;
    :goto_2
    new-instance v2, Ljavax/xml/stream/XMLStreamException;

    invoke-direct {v2, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/Throwable;)V

    throw v2

    .line 269
    .end local v1    # "ioe":Ljava/io/IOException;
    :cond_6
    if-nez p3, :cond_7

    .line 270
    invoke-static {p2}, Lcom/fasterxml/aalto/util/CharsetNames;->findEncodingFor(Ljava/io/Writer;)Ljava/lang/String;

    move-result-object p3

    .line 272
    :cond_7
    if-eqz p3, :cond_8

    .line 273
    invoke-virtual {v0, p3}, Lcom/fasterxml/aalto/out/WriterConfig;->setActualEncodingIfNotSet(Ljava/lang/String;)V

    .line 275
    :cond_8
    new-instance v1, Lcom/fasterxml/aalto/out/CharXmlWriter;

    invoke-direct {v1, v0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/Writer;)V

    .line 276
    .local v1, "xw":Lcom/fasterxml/aalto/out/XmlWriter;
    iget-object v2, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v2, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->getCharSymbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v2

    .line 279
    .restart local v2    # "symbols":Lcom/fasterxml/aalto/out/WNameTable;
    :goto_3
    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->willRepairNamespaces()Z

    move-result v3

    if-eqz v3, :cond_9

    .line 280
    new-instance v3, Lcom/fasterxml/aalto/out/RepairingStreamWriter;

    invoke-direct {v3, v0, v1, v2}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Lcom/fasterxml/aalto/out/XmlWriter;Lcom/fasterxml/aalto/out/WNameTable;)V

    return-object v3

    .line 282
    :cond_9
    new-instance v3, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;

    invoke-direct {v3, v0, v1, v2}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Lcom/fasterxml/aalto/out/XmlWriter;Lcom/fasterxml/aalto/out/WNameTable;)V

    return-object v3
.end method

.method private createSW(Ljavax/xml/transform/Result;)Lorg/codehaus/stax2/XMLStreamWriter2;
    .locals 7
    .param p1, "res"    # Ljavax/xml/transform/Result;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 287
    const/4 v0, 0x0

    .line 288
    .local v0, "out":Ljava/io/OutputStream;
    const/4 v1, 0x0

    .line 289
    .local v1, "w":Ljava/io/Writer;
    const/4 v2, 0x0

    .line 291
    .local v2, "encoding":Ljava/lang/String;
    const/4 v3, 0x0

    .line 293
    .local v3, "sysId":Ljava/lang/String;
    instance-of v4, p1, Lorg/codehaus/stax2/io/Stax2Result;

    if-eqz v4, :cond_1

    .line 294
    move-object v4, p1

    check-cast v4, Lorg/codehaus/stax2/io/Stax2Result;

    .line 296
    .local v4, "sr":Lorg/codehaus/stax2/io/Stax2Result;
    :try_start_0
    invoke-virtual {v4}, Lorg/codehaus/stax2/io/Stax2Result;->constructOutputStream()Ljava/io/OutputStream;

    move-result-object v5

    move-object v0, v5

    .line 297
    if-nez v0, :cond_0

    .line 298
    invoke-virtual {v4}, Lorg/codehaus/stax2/io/Stax2Result;->constructWriter()Ljava/io/Writer;

    move-result-object v5
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v5

    .line 302
    :cond_0
    nop

    .line 303
    const/4 v4, 0x1

    .line 304
    .local v4, "autoclose":Z
    goto :goto_0

    .line 300
    .local v4, "sr":Lorg/codehaus/stax2/io/Stax2Result;
    :catch_0
    move-exception v5

    .line 301
    .local v5, "ioe":Ljava/io/IOException;
    new-instance v6, Lcom/fasterxml/aalto/impl/StreamExceptionBase;

    invoke-direct {v6, v5}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;-><init>(Ljava/lang/Throwable;)V

    throw v6

    .line 304
    .end local v4    # "sr":Lorg/codehaus/stax2/io/Stax2Result;
    .end local v5    # "ioe":Ljava/io/IOException;
    :cond_1
    instance-of v4, p1, Ljavax/xml/transform/stream/StreamResult;

    if-eqz v4, :cond_3

    .line 305
    move-object v4, p1

    check-cast v4, Ljavax/xml/transform/stream/StreamResult;

    .line 306
    .local v4, "sr":Ljavax/xml/transform/stream/StreamResult;
    invoke-virtual {v4}, Ljavax/xml/transform/stream/StreamResult;->getSystemId()Ljava/lang/String;

    move-result-object v3

    .line 307
    invoke-virtual {v4}, Ljavax/xml/transform/stream/StreamResult;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v0

    .line 308
    if-nez v0, :cond_2

    .line 309
    invoke-virtual {v4}, Ljavax/xml/transform/stream/StreamResult;->getWriter()Ljava/io/Writer;

    move-result-object v1

    .line 311
    :cond_2
    const/4 v4, 0x0

    .line 312
    .local v4, "autoclose":Z
    goto :goto_0

    .end local v4    # "autoclose":Z
    :cond_3
    instance-of v4, p1, Ljavax/xml/transform/sax/SAXResult;

    if-eqz v4, :cond_8

    .line 313
    move-object v4, p1

    check-cast v4, Ljavax/xml/transform/sax/SAXResult;

    .line 314
    .local v4, "sr":Ljavax/xml/transform/sax/SAXResult;
    invoke-virtual {v4}, Ljavax/xml/transform/sax/SAXResult;->getSystemId()Ljava/lang/String;

    move-result-object v3

    .line 315
    if-eqz v3, :cond_7

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v5

    if-eqz v5, :cond_7

    .line 318
    const/4 v4, 0x1

    .line 319
    .local v4, "autoclose":Z
    nop

    .line 325
    :goto_0
    const/4 v5, 0x0

    if-eqz v0, :cond_4

    .line 326
    invoke-direct {p0, v0, v5, v2, v4}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createSW(Ljava/io/OutputStream;Ljava/io/Writer;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v5

    return-object v5

    .line 328
    :cond_4
    if-eqz v1, :cond_5

    .line 329
    invoke-direct {p0, v5, v1, v2, v4}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createSW(Ljava/io/OutputStream;Ljava/io/Writer;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v5

    return-object v5

    .line 331
    :cond_5
    if-eqz v3, :cond_6

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v6

    if-lez v6, :cond_6

    .line 336
    const/4 v4, 0x1

    .line 338
    :try_start_1
    invoke-static {v3}, Lcom/fasterxml/aalto/util/URLUtil;->urlFromSystemId(Ljava/lang/String;)Ljava/net/URL;

    move-result-object v6

    invoke-static {v6}, Lcom/fasterxml/aalto/util/URLUtil;->outputStreamFromURL(Ljava/net/URL;)Ljava/io/OutputStream;

    move-result-object v6
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    move-object v0, v6

    .line 341
    nop

    .line 342
    invoke-direct {p0, v0, v5, v2, v4}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createSW(Ljava/io/OutputStream;Ljava/io/Writer;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v5

    return-object v5

    .line 339
    :catch_1
    move-exception v5

    .line 340
    .restart local v5    # "ioe":Ljava/io/IOException;
    new-instance v6, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v6, v5}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v6

    .line 344
    .end local v5    # "ioe":Ljava/io/IOException;
    :cond_6
    new-instance v5, Lcom/fasterxml/aalto/impl/StreamExceptionBase;

    const-string v6, "Can not create XMLStreamWriter for passed-in Result -- neither writer, output stream nor system id (to create one) was accessible"

    invoke-direct {v5, v6}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;-><init>(Ljava/lang/String;)V

    throw v5

    .line 316
    .local v4, "sr":Ljavax/xml/transform/sax/SAXResult;
    :cond_7
    new-instance v5, Lcom/fasterxml/aalto/impl/StreamExceptionBase;

    const-string v6, "Can not create a stream writer for a SAXResult that does not have System Id (support for using SAX input source not implemented)"

    invoke-direct {v5, v6}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;-><init>(Ljava/lang/String;)V

    throw v5

    .line 319
    .end local v4    # "sr":Ljavax/xml/transform/sax/SAXResult;
    :cond_8
    instance-of v4, p1, Ljavax/xml/transform/dom/DOMResult;

    if-eqz v4, :cond_9

    .line 320
    iget-object v4, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/out/WriterConfig;->createNonShared()Lcom/fasterxml/aalto/out/WriterConfig;

    move-result-object v4

    move-object v5, p1

    check-cast v5, Ljavax/xml/transform/dom/DOMResult;

    invoke-static {v4, v5}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->createFrom(Lcom/fasterxml/aalto/out/WriterConfig;Ljavax/xml/transform/dom/DOMResult;)Lcom/fasterxml/aalto/dom/DOMWriterImpl;

    move-result-object v4

    return-object v4

    .line 322
    :cond_9
    new-instance v4, Ljava/lang/IllegalArgumentException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Can not create XMLStreamWriter for Result type "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " (unrecognized type)"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v4
.end method


# virtual methods
.method public configureForRobustness()V
    .locals 1

    .line 176
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->configureForRobustness()V

    .line 177
    return-void
.end method

.method public configureForSpeed()V
    .locals 1

    .line 182
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->configureForSpeed()V

    .line 183
    return-void
.end method

.method public configureForXmlConformance()V
    .locals 1

    .line 170
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->configureForXmlConformance()V

    .line 171
    return-void
.end method

.method public createXMLEventWriter(Ljava/io/OutputStream;)Ljavax/xml/stream/XMLEventWriter;
    .locals 1
    .param p1, "out"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 75
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createXMLEventWriter(Ljava/io/OutputStream;Ljava/lang/String;)Ljavax/xml/stream/XMLEventWriter;

    move-result-object v0

    return-object v0
.end method

.method public createXMLEventWriter(Ljava/io/OutputStream;Ljava/lang/String;)Ljavax/xml/stream/XMLEventWriter;
    .locals 3
    .param p1, "out"    # Ljava/io/OutputStream;
    .param p2, "enc"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 81
    new-instance v0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-direct {p0, p1, v1, p2, v2}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createSW(Ljava/io/OutputStream;Ljava/io/Writer;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;-><init>(Lorg/codehaus/stax2/XMLStreamWriter2;)V

    return-object v0
.end method

.method public createXMLEventWriter(Ljava/io/Writer;)Ljavax/xml/stream/XMLEventWriter;
    .locals 3
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 93
    new-instance v0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-direct {p0, v1, p1, v1, v2}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createSW(Ljava/io/OutputStream;Ljava/io/Writer;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;-><init>(Lorg/codehaus/stax2/XMLStreamWriter2;)V

    return-object v0
.end method

.method public createXMLEventWriter(Ljava/io/Writer;Ljava/lang/String;)Ljavax/xml/stream/XMLEventWriter;
    .locals 3
    .param p1, "w"    # Ljava/io/Writer;
    .param p2, "enc"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 147
    new-instance v0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-direct {p0, v1, p1, p2, v2}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createSW(Ljava/io/OutputStream;Ljava/io/Writer;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;-><init>(Lorg/codehaus/stax2/XMLStreamWriter2;)V

    return-object v0
.end method

.method public createXMLEventWriter(Ljavax/xml/stream/XMLStreamWriter;)Ljavax/xml/stream/XMLEventWriter;
    .locals 2
    .param p1, "sw"    # Ljavax/xml/stream/XMLStreamWriter;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 154
    invoke-static {p1}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->wrapIfNecessary(Ljavax/xml/stream/XMLStreamWriter;)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v0

    .line 155
    .local v0, "sw2":Lorg/codehaus/stax2/XMLStreamWriter2;
    new-instance v1, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;

    invoke-direct {v1, v0}, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;-><init>(Lorg/codehaus/stax2/XMLStreamWriter2;)V

    return-object v1
.end method

.method public createXMLEventWriter(Ljavax/xml/transform/Result;)Ljavax/xml/stream/XMLEventWriter;
    .locals 2
    .param p1, "result"    # Ljavax/xml/transform/Result;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 87
    new-instance v0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;

    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createSW(Ljavax/xml/transform/Result;)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;-><init>(Lorg/codehaus/stax2/XMLStreamWriter2;)V

    return-object v0
.end method

.method public createXMLStreamWriter(Ljava/io/OutputStream;)Ljavax/xml/stream/XMLStreamWriter;
    .locals 1
    .param p1, "out"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 99
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createXMLStreamWriter(Ljava/io/OutputStream;Ljava/lang/String;)Ljavax/xml/stream/XMLStreamWriter;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamWriter(Ljava/io/OutputStream;Ljava/lang/String;)Ljavax/xml/stream/XMLStreamWriter;
    .locals 2
    .param p1, "out"    # Ljava/io/OutputStream;
    .param p2, "enc"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 105
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, p2, v1}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createSW(Ljava/io/OutputStream;Ljava/io/Writer;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamWriter(Ljava/io/Writer;)Ljavax/xml/stream/XMLStreamWriter;
    .locals 2
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 117
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, v0, p1, v0, v1}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createSW(Ljava/io/OutputStream;Ljava/io/Writer;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamWriter(Ljavax/xml/transform/Result;)Ljavax/xml/stream/XMLStreamWriter;
    .locals 1
    .param p1, "result"    # Ljavax/xml/transform/Result;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 111
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createSW(Ljavax/xml/transform/Result;)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamWriter(Ljava/io/Writer;Ljava/lang/String;)Lorg/codehaus/stax2/XMLStreamWriter2;
    .locals 2
    .param p1, "w"    # Ljava/io/Writer;
    .param p2, "enc"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 162
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, v0, p1, p2, v1}, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->createSW(Ljava/io/OutputStream;Ljava/io/Writer;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamWriter2;

    move-result-object v0

    return-object v0
.end method

.method public getProperty(Ljava/lang/String;)Ljava/lang/Object;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 123
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->getProperty(Ljava/lang/String;Z)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 127
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WriterConfig;->isPropertySupported(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 132
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/OutputFactoryImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/WriterConfig;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    .line 133
    return-void
.end method
