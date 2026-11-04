.class public final Lcom/fasterxml/aalto/stax/InputFactoryImpl;
.super Lcom/fasterxml/aalto/AsyncXMLInputFactory;
.source "InputFactoryImpl.java"


# instance fields
.field protected _allocator:Ljavax/xml/stream/util/XMLEventAllocator;

.field final _config:Lcom/fasterxml/aalto/in/ReaderConfig;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 81
    invoke-direct {p0}, Lcom/fasterxml/aalto/AsyncXMLInputFactory;-><init>()V

    .line 73
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_allocator:Ljavax/xml/stream/util/XMLEventAllocator;

    .line 82
    new-instance v0, Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-direct {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;-><init>()V

    iput-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 83
    return-void
.end method


# virtual methods
.method public configureForConvenience()V
    .locals 1

    .line 316
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->configureForConvenience()V

    .line 317
    return-void
.end method

.method public configureForLowMemUsage()V
    .locals 1

    .line 328
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->configureForLowMemUsage()V

    .line 329
    return-void
.end method

.method public configureForRoundTripping()V
    .locals 1

    .line 334
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->configureForRoundTripping()V

    .line 335
    return-void
.end method

.method public configureForSpeed()V
    .locals 1

    .line 322
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->configureForSpeed()V

    .line 323
    return-void
.end method

.method public configureForXmlConformance()V
    .locals 1

    .line 310
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->configureForXmlConformance()V

    .line 311
    return-void
.end method

.method public constructER(Lorg/codehaus/stax2/XMLStreamReader2;)Lorg/codehaus/stax2/XMLEventReader2;
    .locals 2
    .param p1, "sr"    # Lorg/codehaus/stax2/XMLStreamReader2;

    .line 583
    new-instance v0, Lcom/fasterxml/aalto/evt/EventReaderImpl;

    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->createEventAllocator()Ljavax/xml/stream/util/XMLEventAllocator;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Lcom/fasterxml/aalto/evt/EventReaderImpl;-><init>(Ljavax/xml/stream/util/XMLEventAllocator;Lorg/codehaus/stax2/XMLStreamReader2;)V

    return-object v0
.end method

.method protected constructSR(Ljava/io/File;Z)Lorg/codehaus/stax2/XMLStreamReader2;
    .locals 7
    .param p1, "f"    # Ljava/io/File;
    .param p2, "forEventReader"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 572
    :try_start_0
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 573
    .local v0, "in":Ljava/io/InputStream;
    invoke-static {p1}, Lcom/fasterxml/aalto/util/URLUtil;->fileToSystemId(Ljava/io/File;)Ljava/lang/String;

    move-result-object v2

    .line 575
    .local v2, "systemId":Ljava/lang/String;
    const/4 v4, 0x0

    const/4 v6, 0x1

    const/4 v3, 0x0

    move-object v1, p0

    move v5, p2

    invoke-virtual/range {v1 .. v6}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v1

    .line 576
    .local v1, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    invoke-static {v1, v0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;)Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;

    move-result-object v3

    invoke-static {v3}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v3
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    .line 577
    .end local v0    # "in":Ljava/io/InputStream;
    .end local v1    # "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    .end local v2    # "systemId":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 578
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected constructSR(Ljava/io/InputStream;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamReader2;
    .locals 6
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "enc"    # Ljava/lang/String;
    .param p3, "forEventReader"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 417
    const/4 v2, 0x0

    const/4 v5, 0x0

    const/4 v1, 0x0

    move-object v0, p0

    move-object v3, p2

    move v4, p3

    invoke-virtual/range {v0 .. v5}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 418
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    invoke-static {v0, p1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;)Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;

    move-result-object v1

    invoke-static {v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v1

    return-object v1
.end method

.method protected constructSR(Ljava/lang/String;Ljava/io/InputStream;Z)Lorg/codehaus/stax2/XMLStreamReader2;
    .locals 6
    .param p1, "systemId"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "forEventReader"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 433
    const/4 v3, 0x0

    const/4 v5, 0x0

    const/4 v1, 0x0

    move-object v0, p0

    move-object v2, p1

    move v4, p3

    invoke-virtual/range {v0 .. v5}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 434
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    invoke-static {v0, p2}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;)Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;

    move-result-object v1

    invoke-static {v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v1

    return-object v1
.end method

.method protected constructSR(Ljava/lang/String;Ljava/io/Reader;Z)Lorg/codehaus/stax2/XMLStreamReader2;
    .locals 6
    .param p1, "systemId"    # Ljava/lang/String;
    .param p2, "r"    # Ljava/io/Reader;
    .param p3, "forEventReader"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 425
    const/4 v3, 0x0

    const/4 v5, 0x0

    const/4 v1, 0x0

    move-object v0, p0

    move-object v2, p1

    move v4, p3

    invoke-virtual/range {v0 .. v5}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 426
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    invoke-static {v0, p2}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;)Lcom/fasterxml/aalto/in/CharSourceBootstrapper;

    move-result-object v1

    invoke-static {v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v1

    return-object v1
.end method

.method protected constructSR(Ljava/net/URL;Z)Lorg/codehaus/stax2/XMLStreamReader2;
    .locals 7
    .param p1, "src"    # Ljava/net/URL;
    .param p2, "forEventReader"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 559
    :try_start_0
    invoke-static {p1}, Lcom/fasterxml/aalto/util/URLUtil;->inputStreamFromURL(Ljava/net/URL;)Ljava/io/InputStream;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 562
    .local v0, "in":Ljava/io/InputStream;
    nop

    .line 564
    invoke-static {p1}, Lcom/fasterxml/aalto/util/URLUtil;->urlToSystemId(Ljava/net/URL;)Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x0

    const/4 v6, 0x1

    const/4 v3, 0x0

    move-object v1, p0

    move v5, p2

    invoke-virtual/range {v1 .. v6}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v1

    .line 565
    .local v1, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    invoke-static {v1, v0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;)Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;

    move-result-object v2

    invoke-static {v2}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v2

    return-object v2

    .line 560
    .end local v0    # "in":Ljava/io/InputStream;
    .end local v1    # "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    :catch_0
    move-exception v0

    .line 561
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected constructSR(Ljavax/xml/transform/Source;Z)Lorg/codehaus/stax2/XMLStreamReader2;
    .locals 12
    .param p1, "src"    # Ljavax/xml/transform/Source;
    .param p2, "forEventReader"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 442
    instance-of v0, p1, Lorg/codehaus/stax2/io/Stax2Source;

    if-eqz v0, :cond_0

    .line 443
    move-object v0, p1

    check-cast v0, Lorg/codehaus/stax2/io/Stax2Source;

    invoke-virtual {p0, v0, p2}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR2(Lorg/codehaus/stax2/io/Stax2Source;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    return-object v0

    .line 446
    :cond_0
    const/4 v0, 0x0

    .line 447
    .local v0, "r":Ljava/io/Reader;
    const/4 v1, 0x0

    .line 448
    .local v1, "in":Ljava/io/InputStream;
    const/4 v8, 0x0

    .line 449
    .local v8, "pubId":Ljava/lang/String;
    const/4 v9, 0x0

    .line 450
    .local v9, "sysId":Ljava/lang/String;
    const/4 v10, 0x0

    .line 453
    .local v10, "encoding":Ljava/lang/String;
    instance-of v2, p1, Ljavax/xml/transform/stream/StreamSource;

    if-eqz v2, :cond_2

    .line 454
    move-object v2, p1

    check-cast v2, Ljavax/xml/transform/stream/StreamSource;

    .line 455
    .local v2, "ss":Ljavax/xml/transform/stream/StreamSource;
    invoke-virtual {v2}, Ljavax/xml/transform/stream/StreamSource;->getSystemId()Ljava/lang/String;

    move-result-object v3

    .line 456
    .end local v9    # "sysId":Ljava/lang/String;
    .local v3, "sysId":Ljava/lang/String;
    invoke-virtual {v2}, Ljavax/xml/transform/stream/StreamSource;->getPublicId()Ljava/lang/String;

    move-result-object v4

    .line 457
    .end local v8    # "pubId":Ljava/lang/String;
    .local v4, "pubId":Ljava/lang/String;
    invoke-virtual {v2}, Ljavax/xml/transform/stream/StreamSource;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    .line 458
    if-nez v1, :cond_1

    .line 459
    invoke-virtual {v2}, Ljavax/xml/transform/stream/StreamSource;->getReader()Ljava/io/Reader;

    move-result-object v0

    .line 464
    :cond_1
    const/4 v2, 0x0

    .line 465
    .local v2, "autoCloseInput":Z
    move v8, v2

    move-object v9, v3

    move-object v11, v10

    move-object v10, v4

    goto :goto_0

    .end local v2    # "autoCloseInput":Z
    .end local v3    # "sysId":Ljava/lang/String;
    .end local v4    # "pubId":Ljava/lang/String;
    .restart local v8    # "pubId":Ljava/lang/String;
    .restart local v9    # "sysId":Ljava/lang/String;
    :cond_2
    instance-of v2, p1, Ljavax/xml/transform/sax/SAXSource;

    if-eqz v2, :cond_7

    .line 466
    move-object v2, p1

    check-cast v2, Ljavax/xml/transform/sax/SAXSource;

    .line 468
    .local v2, "ss":Ljavax/xml/transform/sax/SAXSource;
    invoke-virtual {v2}, Ljavax/xml/transform/sax/SAXSource;->getSystemId()Ljava/lang/String;

    move-result-object v3

    .line 469
    .end local v9    # "sysId":Ljava/lang/String;
    .restart local v3    # "sysId":Ljava/lang/String;
    invoke-virtual {v2}, Ljavax/xml/transform/sax/SAXSource;->getInputSource()Lorg/xml/sax/InputSource;

    move-result-object v4

    .line 470
    .local v4, "isrc":Lorg/xml/sax/InputSource;
    if-eqz v4, :cond_3

    .line 471
    invoke-virtual {v4}, Lorg/xml/sax/InputSource;->getSystemId()Ljava/lang/String;

    move-result-object v3

    .line 472
    invoke-virtual {v4}, Lorg/xml/sax/InputSource;->getPublicId()Ljava/lang/String;

    move-result-object v8

    .line 473
    invoke-virtual {v4}, Lorg/xml/sax/InputSource;->getEncoding()Ljava/lang/String;

    move-result-object v10

    .line 474
    invoke-virtual {v4}, Lorg/xml/sax/InputSource;->getByteStream()Ljava/io/InputStream;

    move-result-object v1

    .line 475
    if-nez v1, :cond_3

    .line 476
    invoke-virtual {v4}, Lorg/xml/sax/InputSource;->getCharacterStream()Ljava/io/Reader;

    move-result-object v0

    .line 482
    :cond_3
    const/4 v2, 0x0

    .line 483
    .end local v4    # "isrc":Lorg/xml/sax/InputSource;
    .local v2, "autoCloseInput":Z
    move-object v9, v3

    move-object v11, v10

    move-object v10, v8

    move v8, v2

    .line 490
    .end local v2    # "autoCloseInput":Z
    .end local v3    # "sysId":Ljava/lang/String;
    .local v8, "autoCloseInput":Z
    .restart local v9    # "sysId":Ljava/lang/String;
    .local v10, "pubId":Ljava/lang/String;
    .local v11, "encoding":Ljava/lang/String;
    :goto_0
    if-eqz v1, :cond_4

    .line 491
    move-object v2, p0

    move-object v3, v10

    move-object v4, v9

    move-object v5, v11

    move v6, p2

    move v7, v8

    invoke-virtual/range {v2 .. v7}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v2

    .line 492
    .local v2, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    invoke-static {v2, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;)Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;

    move-result-object v3

    invoke-static {v3}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v3

    return-object v3

    .line 494
    .end local v2    # "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    :cond_4
    if-eqz v0, :cond_5

    .line 495
    move-object v2, p0

    move-object v3, v10

    move-object v4, v9

    move-object v5, v11

    move v6, p2

    move v7, v8

    invoke-virtual/range {v2 .. v7}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v2

    .line 496
    .restart local v2    # "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    invoke-static {v2, v0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;)Lcom/fasterxml/aalto/in/CharSourceBootstrapper;

    move-result-object v3

    invoke-static {v3}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v3

    return-object v3

    .line 498
    .end local v2    # "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    :cond_5
    if-eqz v9, :cond_6

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_6

    .line 502
    const/4 v8, 0x1

    .line 503
    move-object v2, p0

    move-object v3, v10

    move-object v4, v9

    move-object v5, v11

    move v6, p2

    move v7, v8

    invoke-virtual/range {v2 .. v7}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v2

    .line 505
    .restart local v2    # "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    :try_start_0
    invoke-static {v9}, Lcom/fasterxml/aalto/util/URLUtil;->urlFromSystemId(Ljava/lang/String;)Ljava/net/URL;

    move-result-object v3

    .line 506
    .local v3, "url":Ljava/net/URL;
    invoke-static {v3}, Lcom/fasterxml/aalto/util/URLUtil;->inputStreamFromURL(Ljava/net/URL;)Ljava/io/InputStream;

    move-result-object v4

    move-object v1, v4

    .line 507
    invoke-static {v2, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;)Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;

    move-result-object v4

    invoke-static {v4}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v4
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v4

    .line 508
    .end local v3    # "url":Ljava/net/URL;
    :catch_0
    move-exception v3

    .line 509
    .local v3, "ioe":Ljava/io/IOException;
    new-instance v4, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v4, v3}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v4

    .line 512
    .end local v2    # "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    .end local v3    # "ioe":Ljava/io/IOException;
    :cond_6
    new-instance v2, Ljavax/xml/stream/XMLStreamException;

    const-string v3, "Can not create Stax reader for the Source passed -- neither reader, input stream nor system id was accessible; can not use other types of sources (like embedded SAX streams)"

    invoke-direct {v2, v3}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 483
    .end local v11    # "encoding":Ljava/lang/String;
    .local v8, "pubId":Ljava/lang/String;
    .local v10, "encoding":Ljava/lang/String;
    :cond_7
    instance-of v2, p1, Ljavax/xml/transform/dom/DOMSource;

    if-eqz v2, :cond_8

    .line 484
    const/4 v11, 0x0

    .line 485
    .local v11, "autoCloseInput":Z
    move-object v2, p0

    move-object v3, v8

    move-object v4, v9

    move-object v5, v10

    move v6, p2

    move v7, v11

    invoke-virtual/range {v2 .. v7}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v2

    .line 486
    .restart local v2    # "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    move-object v3, p1

    check-cast v3, Ljavax/xml/transform/dom/DOMSource;

    invoke-static {v3, v2}, Lcom/fasterxml/aalto/dom/DOMReaderImpl;->createFrom(Ljavax/xml/transform/dom/DOMSource;Lcom/fasterxml/aalto/in/ReaderConfig;)Lcom/fasterxml/aalto/dom/DOMReaderImpl;

    move-result-object v3

    return-object v3

    .line 488
    .end local v2    # "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    .end local v11    # "autoCloseInput":Z
    :cond_8
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Can not instantiate StAX reader for XML source type "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " (unrecognized type)"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method protected constructSR2(Lorg/codehaus/stax2/io/Stax2Source;Z)Lorg/codehaus/stax2/XMLStreamReader2;
    .locals 6
    .param p1, "ss"    # Lorg/codehaus/stax2/io/Stax2Source;
    .param p2, "forEventReader"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 521
    invoke-virtual {p1}, Lorg/codehaus/stax2/io/Stax2Source;->getPublicId()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lorg/codehaus/stax2/io/Stax2Source;->getSystemId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Lorg/codehaus/stax2/io/Stax2Source;->getEncoding()Ljava/lang/String;

    move-result-object v3

    const/4 v5, 0x1

    move-object v0, p0

    move v4, p2

    invoke-virtual/range {v0 .. v5}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 524
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    instance-of v1, p1, Lorg/codehaus/stax2/io/Stax2ByteArraySource;

    if-eqz v1, :cond_0

    .line 525
    move-object v1, p1

    check-cast v1, Lorg/codehaus/stax2/io/Stax2ByteArraySource;

    .line 526
    .local v1, "bs":Lorg/codehaus/stax2/io/Stax2ByteArraySource;
    nop

    .line 527
    invoke-virtual {v1}, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->getBuffer()[B

    move-result-object v2

    invoke-virtual {v1}, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->getBufferStart()I

    move-result v3

    invoke-virtual {v1}, Lorg/codehaus/stax2/io/Stax2ByteArraySource;->getBufferLength()I

    move-result v4

    invoke-static {v0, v2, v3, v4}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;[BII)Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;

    move-result-object v2

    .line 526
    invoke-static {v2}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v2

    return-object v2

    .line 529
    .end local v1    # "bs":Lorg/codehaus/stax2/io/Stax2ByteArraySource;
    :cond_0
    instance-of v1, p1, Lorg/codehaus/stax2/io/Stax2CharArraySource;

    if-eqz v1, :cond_1

    .line 530
    move-object v1, p1

    check-cast v1, Lorg/codehaus/stax2/io/Stax2CharArraySource;

    .line 531
    .local v1, "cs":Lorg/codehaus/stax2/io/Stax2CharArraySource;
    nop

    .line 532
    invoke-virtual {v1}, Lorg/codehaus/stax2/io/Stax2CharArraySource;->getBuffer()[C

    move-result-object v2

    invoke-virtual {v1}, Lorg/codehaus/stax2/io/Stax2CharArraySource;->getBufferStart()I

    move-result v3

    invoke-virtual {v1}, Lorg/codehaus/stax2/io/Stax2CharArraySource;->getBufferLength()I

    move-result v4

    invoke-static {v0, v2, v3, v4}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;[CII)Lcom/fasterxml/aalto/in/CharSourceBootstrapper;

    move-result-object v2

    .line 531
    invoke-static {v2}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v2

    return-object v2

    .line 539
    .end local v1    # "cs":Lorg/codehaus/stax2/io/Stax2CharArraySource;
    :cond_1
    :try_start_0
    invoke-virtual {p1}, Lorg/codehaus/stax2/io/Stax2Source;->constructInputStream()Ljava/io/InputStream;

    move-result-object v1

    .line 540
    .local v1, "in":Ljava/io/InputStream;
    if-eqz v1, :cond_2

    .line 541
    invoke-static {v0, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;)Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;

    move-result-object v2

    invoke-static {v2}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v2

    return-object v2

    .line 543
    :cond_2
    invoke-virtual {p1}, Lorg/codehaus/stax2/io/Stax2Source;->constructReader()Ljava/io/Reader;

    move-result-object v2

    .line 544
    .local v2, "r":Ljava/io/Reader;
    if-eqz v2, :cond_3

    .line 545
    invoke-static {v0, v2}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;)Lcom/fasterxml/aalto/in/CharSourceBootstrapper;

    move-result-object v3

    invoke-static {v3}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    move-result-object v3
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    .line 549
    .end local v1    # "in":Ljava/io/InputStream;
    .end local v2    # "r":Ljava/io/Reader;
    :cond_3
    nop

    .line 551
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Can not create stream reader for given Stax2Source: neither InputStream nor Reader available"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 547
    :catch_0
    move-exception v1

    .line 548
    .local v1, "ioe":Ljava/io/IOException;
    new-instance v2, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v2, v1}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v2
.end method

.method public createAsyncFor(Ljava/nio/ByteBuffer;)Lcom/fasterxml/aalto/AsyncXMLStreamReader;
    .locals 6
    .param p1, "input"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/nio/ByteBuffer;",
            ")",
            "Lcom/fasterxml/aalto/AsyncXMLStreamReader<",
            "Lcom/fasterxml/aalto/AsyncByteBufferFeeder;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 379
    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 380
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    const-string v1, "UTF-8"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setActualEncoding(Ljava/lang/String;)V

    .line 381
    new-instance v1, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 382
    .local v1, "scanner":Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;
    invoke-virtual {v1, p1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->feedInput(Ljava/nio/ByteBuffer;)V

    .line 383
    new-instance v2, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;

    invoke-direct {v2, v1}, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;-><init>(Lcom/fasterxml/aalto/async/AsyncByteScanner;)V

    return-object v2
.end method

.method public createAsyncFor([B)Lcom/fasterxml/aalto/AsyncXMLStreamReader;
    .locals 2
    .param p1, "input"    # [B
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Lcom/fasterxml/aalto/AsyncXMLStreamReader<",
            "Lcom/fasterxml/aalto/AsyncByteArrayFeeder;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 355
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->createAsyncFor([BII)Lcom/fasterxml/aalto/AsyncXMLStreamReader;

    move-result-object v0

    return-object v0
.end method

.method public createAsyncFor([BII)Lcom/fasterxml/aalto/AsyncXMLStreamReader;
    .locals 6
    .param p1, "input"    # [B
    .param p2, "offset"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([BII)",
            "Lcom/fasterxml/aalto/AsyncXMLStreamReader<",
            "Lcom/fasterxml/aalto/AsyncByteArrayFeeder;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 362
    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 363
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    const-string v1, "UTF-8"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setActualEncoding(Ljava/lang/String;)V

    .line 364
    new-instance v1, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 365
    .local v1, "scanner":Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;
    invoke-virtual {v1, p1, p2, p3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->feedInput([BII)V

    .line 366
    new-instance v2, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;

    invoke-direct {v2, v1}, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;-><init>(Lcom/fasterxml/aalto/async/AsyncByteScanner;)V

    return-object v2
.end method

.method public createAsyncForByteArray()Lcom/fasterxml/aalto/AsyncXMLStreamReader;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/fasterxml/aalto/AsyncXMLStreamReader<",
            "Lcom/fasterxml/aalto/AsyncByteArrayFeeder;",
            ">;"
        }
    .end annotation

    .line 347
    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 348
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    const-string v1, "UTF-8"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setActualEncoding(Ljava/lang/String;)V

    .line 349
    new-instance v1, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;

    new-instance v2, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;

    invoke-direct {v2, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    invoke-direct {v1, v2}, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;-><init>(Lcom/fasterxml/aalto/async/AsyncByteScanner;)V

    return-object v1
.end method

.method public createAsyncForByteBuffer()Lcom/fasterxml/aalto/AsyncXMLStreamReader;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/fasterxml/aalto/AsyncXMLStreamReader<",
            "Lcom/fasterxml/aalto/AsyncByteBufferFeeder;",
            ">;"
        }
    .end annotation

    .line 371
    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 372
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    const-string v1, "UTF-8"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setActualEncoding(Ljava/lang/String;)V

    .line 373
    new-instance v1, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;

    new-instance v2, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;

    invoke-direct {v2, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    invoke-direct {v1, v2}, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;-><init>(Lcom/fasterxml/aalto/async/AsyncByteScanner;)V

    return-object v1
.end method

.method protected createEventAllocator()Ljavax/xml/stream/util/XMLEventAllocator;
    .locals 1

    .line 589
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_allocator:Ljavax/xml/stream/util/XMLEventAllocator;

    if-eqz v0, :cond_0

    .line 590
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_allocator:Ljavax/xml/stream/util/XMLEventAllocator;

    invoke-interface {v0}, Ljavax/xml/stream/util/XMLEventAllocator;->newInstance()Ljavax/xml/stream/util/XMLEventAllocator;

    move-result-object v0

    return-object v0

    .line 593
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->willPreserveLocation()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 594
    invoke-static {}, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;->getDefaultInstance()Lcom/fasterxml/aalto/evt/EventAllocatorImpl;

    move-result-object v0

    goto :goto_0

    .line 595
    :cond_1
    invoke-static {}, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;->getFastInstance()Lcom/fasterxml/aalto/evt/EventAllocatorImpl;

    move-result-object v0

    .line 593
    :goto_0
    return-object v0
.end method

.method public createFilteredReader(Ljavax/xml/stream/XMLEventReader;Ljavax/xml/stream/EventFilter;)Ljavax/xml/stream/XMLEventReader;
    .locals 2
    .param p1, "reader"    # Ljavax/xml/stream/XMLEventReader;
    .param p2, "filter"    # Ljavax/xml/stream/EventFilter;

    .line 96
    new-instance v0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;

    invoke-static {p1}, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->wrapIfNecessary(Ljavax/xml/stream/XMLEventReader;)Lorg/codehaus/stax2/XMLEventReader2;

    move-result-object v1

    invoke-direct {v0, v1, p2}, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;-><init>(Lorg/codehaus/stax2/XMLEventReader2;Ljavax/xml/stream/EventFilter;)V

    return-object v0
.end method

.method public createFilteredReader(Ljavax/xml/stream/XMLStreamReader;Ljavax/xml/stream/StreamFilter;)Ljavax/xml/stream/XMLStreamReader;
    .locals 2
    .param p1, "reader"    # Ljavax/xml/stream/XMLStreamReader;
    .param p2, "filter"    # Ljavax/xml/stream/StreamFilter;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 103
    new-instance v0, Lorg/codehaus/stax2/ri/Stax2FilteredStreamReader;

    invoke-direct {v0, p1, p2}, Lorg/codehaus/stax2/ri/Stax2FilteredStreamReader;-><init>(Ljavax/xml/stream/XMLStreamReader;Ljavax/xml/stream/StreamFilter;)V

    .line 111
    .local v0, "fr":Lorg/codehaus/stax2/ri/Stax2FilteredStreamReader;
    invoke-interface {p2, v0}, Ljavax/xml/stream/StreamFilter;->accept(Ljavax/xml/stream/XMLStreamReader;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 113
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/Stax2FilteredStreamReader;->next()I

    .line 115
    :cond_0
    return-object v0
.end method

.method public createXMLEventReader(Ljava/io/InputStream;)Ljavax/xml/stream/XMLEventReader;
    .locals 1
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 126
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->createXMLEventReader(Ljava/io/InputStream;Ljava/lang/String;)Ljavax/xml/stream/XMLEventReader;

    move-result-object v0

    return-object v0
.end method

.method public createXMLEventReader(Ljava/io/InputStream;Ljava/lang/String;)Ljavax/xml/stream/XMLEventReader;
    .locals 1
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "enc"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 131
    const/4 v0, 0x1

    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/io/InputStream;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructER(Lorg/codehaus/stax2/XMLStreamReader2;)Lorg/codehaus/stax2/XMLEventReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLEventReader(Ljava/io/Reader;)Ljavax/xml/stream/XMLEventReader;
    .locals 1
    .param p1, "r"    # Ljava/io/Reader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 136
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->createXMLEventReader(Ljava/lang/String;Ljava/io/Reader;)Ljavax/xml/stream/XMLEventReader;

    move-result-object v0

    return-object v0
.end method

.method public createXMLEventReader(Ljava/lang/String;Ljava/io/InputStream;)Ljavax/xml/stream/XMLEventReader;
    .locals 1
    .param p1, "systemId"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 148
    const/4 v0, 0x1

    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/lang/String;Ljava/io/InputStream;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructER(Lorg/codehaus/stax2/XMLStreamReader2;)Lorg/codehaus/stax2/XMLEventReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLEventReader(Ljava/lang/String;Ljava/io/Reader;)Ljavax/xml/stream/XMLEventReader;
    .locals 1
    .param p1, "systemId"    # Ljava/lang/String;
    .param p2, "r"    # Ljava/io/Reader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 155
    const/4 v0, 0x1

    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/lang/String;Ljava/io/Reader;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructER(Lorg/codehaus/stax2/XMLStreamReader2;)Lorg/codehaus/stax2/XMLEventReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLEventReader(Ljavax/xml/stream/XMLStreamReader;)Ljavax/xml/stream/XMLEventReader;
    .locals 1
    .param p1, "sr"    # Ljavax/xml/stream/XMLStreamReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 162
    invoke-static {p1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->wrapIfNecessary(Ljavax/xml/stream/XMLStreamReader;)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructER(Lorg/codehaus/stax2/XMLStreamReader2;)Lorg/codehaus/stax2/XMLEventReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLEventReader(Ljavax/xml/transform/Source;)Ljavax/xml/stream/XMLEventReader;
    .locals 1
    .param p1, "source"    # Ljavax/xml/transform/Source;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 141
    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljavax/xml/transform/Source;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructER(Lorg/codehaus/stax2/XMLStreamReader2;)Lorg/codehaus/stax2/XMLEventReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLEventReader(Ljava/io/File;)Lorg/codehaus/stax2/XMLEventReader2;
    .locals 1
    .param p1, "f"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 284
    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/io/File;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructER(Lorg/codehaus/stax2/XMLStreamReader2;)Lorg/codehaus/stax2/XMLEventReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLEventReader(Ljava/net/URL;)Lorg/codehaus/stax2/XMLEventReader2;
    .locals 1
    .param p1, "src"    # Ljava/net/URL;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 277
    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/net/URL;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructER(Lorg/codehaus/stax2/XMLStreamReader2;)Lorg/codehaus/stax2/XMLEventReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamReader(Ljava/io/InputStream;)Ljavax/xml/stream/XMLStreamReader;
    .locals 2
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 175
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/io/InputStream;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamReader(Ljava/io/InputStream;Ljava/lang/String;)Ljavax/xml/stream/XMLStreamReader;
    .locals 1
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "enc"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 182
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/io/InputStream;Ljava/lang/String;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamReader(Ljava/io/Reader;)Ljavax/xml/stream/XMLStreamReader;
    .locals 2
    .param p1, "r"    # Ljava/io/Reader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 189
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, v1}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/lang/String;Ljava/io/Reader;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamReader(Ljava/lang/String;Ljava/io/InputStream;)Ljavax/xml/stream/XMLStreamReader;
    .locals 1
    .param p1, "systemId"    # Ljava/lang/String;
    .param p2, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 210
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/lang/String;Ljava/io/InputStream;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamReader(Ljava/lang/String;Ljava/io/Reader;)Ljavax/xml/stream/XMLStreamReader;
    .locals 1
    .param p1, "systemId"    # Ljava/lang/String;
    .param p2, "r"    # Ljava/io/Reader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 196
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/lang/String;Ljava/io/Reader;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamReader(Ljavax/xml/transform/Source;)Ljavax/xml/stream/XMLStreamReader;
    .locals 1
    .param p1, "src"    # Ljavax/xml/transform/Source;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 203
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljavax/xml/transform/Source;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamReader(Ljava/io/File;)Lorg/codehaus/stax2/XMLStreamReader2;
    .locals 1
    .param p1, "f"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 302
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/io/File;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    return-object v0
.end method

.method public createXMLStreamReader(Ljava/net/URL;)Lorg/codehaus/stax2/XMLStreamReader2;
    .locals 1
    .param p1, "src"    # Ljava/net/URL;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 291
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->constructSR(Ljava/net/URL;Z)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    return-object v0
.end method

.method public getEventAllocator()Ljavax/xml/stream/util/XMLEventAllocator;
    .locals 1

    .line 234
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_allocator:Ljavax/xml/stream/util/XMLEventAllocator;

    return-object v0
.end method

.method public getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;
    .locals 2
    .param p1, "systemId"    # Ljava/lang/String;
    .param p2, "publicId"    # Ljava/lang/String;
    .param p3, "extEncoding"    # Ljava/lang/String;
    .param p4, "forEventReader"    # Z
    .param p5, "forceAutoClose"    # Z

    .line 399
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0, p2, p1, p3}, Lcom/fasterxml/aalto/in/ReaderConfig;->createNonShared(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 400
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    if-eqz p4, :cond_0

    .line 405
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->doParseLazily(Z)V

    .line 407
    :cond_0
    if-eqz p5, :cond_1

    .line 408
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->doAutoCloseInput(Z)V

    .line 410
    :cond_1
    return-object v0
.end method

.method public getProperty(Ljava/lang/String;)Ljava/lang/Object;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 223
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->getProperty(Ljava/lang/String;Z)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getXMLReporter()Ljavax/xml/stream/XMLReporter;
    .locals 1

    .line 239
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getXMLReporter()Ljavax/xml/stream/XMLReporter;

    move-result-object v0

    return-object v0
.end method

.method public getXMLResolver()Ljavax/xml/stream/XMLResolver;
    .locals 1

    .line 244
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getXMLResolver()Ljavax/xml/stream/XMLResolver;

    move-result-object v0

    return-object v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 249
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->isPropertySupported(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setEventAllocator(Ljavax/xml/stream/util/XMLEventAllocator;)V
    .locals 0
    .param p1, "allocator"    # Ljavax/xml/stream/util/XMLEventAllocator;

    .line 254
    iput-object p1, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_allocator:Ljavax/xml/stream/util/XMLEventAllocator;

    .line 255
    return-void
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "propName"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 229
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/ReaderConfig;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    .line 230
    return-void
.end method

.method public setXMLReporter(Ljavax/xml/stream/XMLReporter;)V
    .locals 1
    .param p1, "r"    # Ljavax/xml/stream/XMLReporter;

    .line 259
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setXMLReporter(Ljavax/xml/stream/XMLReporter;)V

    .line 260
    return-void
.end method

.method public setXMLResolver(Ljavax/xml/stream/XMLResolver;)V
    .locals 1
    .param p1, "r"    # Ljavax/xml/stream/XMLResolver;

    .line 264
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setXMLResolver(Ljavax/xml/stream/XMLResolver;)V

    .line 265
    return-void
.end method
