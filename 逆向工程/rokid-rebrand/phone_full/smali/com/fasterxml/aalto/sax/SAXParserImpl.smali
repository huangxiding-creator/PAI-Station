.class Lcom/fasterxml/aalto/sax/SAXParserImpl;
.super Ljavax/xml/parsers/SAXParser;
.source "SAXParserImpl.java"

# interfaces
.implements Lorg/xml/sax/Parser;
.implements Lorg/xml/sax/XMLReader;
.implements Lorg/xml/sax/ext/Attributes2;
.implements Lorg/xml/sax/ext/Locator2;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;,
        Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;
    }
.end annotation


# instance fields
.field protected _attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

.field private _attrCount:I

.field protected _contentHandler:Lorg/xml/sax/ContentHandler;

.field private _declHandler:Lorg/xml/sax/ext/DeclHandler;

.field protected _dtdHandler:Lorg/xml/sax/DTDHandler;

.field private _entityResolver:Lorg/xml/sax/EntityResolver;

.field private _errorHandler:Lorg/xml/sax/ErrorHandler;

.field private _lexicalHandler:Lorg/xml/sax/ext/LexicalHandler;

.field protected _scanner:Lcom/fasterxml/aalto/in/XmlScanner;

.field final _staxFactory:Lcom/fasterxml/aalto/stax/InputFactoryImpl;


# direct methods
.method constructor <init>(Lcom/fasterxml/aalto/stax/InputFactoryImpl;)V
    .locals 0
    .param p1, "sf"    # Lcom/fasterxml/aalto/stax/InputFactoryImpl;

    .line 79
    invoke-direct {p0}, Ljavax/xml/parsers/SAXParser;-><init>()V

    .line 80
    iput-object p1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_staxFactory:Lcom/fasterxml/aalto/stax/InputFactoryImpl;

    .line 81
    return-void
.end method

.method private final fireAuxEvent(IZ)V
    .locals 5
    .param p1, "type"    # I
    .param p2, "inTree"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 496
    sparse-switch p1, :sswitch_data_0

    .line 529
    const/4 v0, -0x1

    if-ne p1, v0, :cond_3

    .line 530
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end-of-input in "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    if-eqz p2, :cond_2

    const-string/jumbo v1, "tree"

    goto :goto_1

    .line 501
    :sswitch_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_lexicalHandler:Lorg/xml/sax/ext/LexicalHandler;

    if-eqz v0, :cond_0

    .line 502
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_lexicalHandler:Lorg/xml/sax/ext/LexicalHandler;

    invoke-interface {v0}, Lorg/xml/sax/ext/LexicalHandler;->startCDATA()V

    .line 503
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->fireSaxCharacterEvents(Lorg/xml/sax/ContentHandler;)V

    .line 504
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_lexicalHandler:Lorg/xml/sax/ext/LexicalHandler;

    invoke-interface {v0}, Lorg/xml/sax/ext/LexicalHandler;->endCDATA()V

    goto :goto_0

    .line 506
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->fireSaxCharacterEvents(Lorg/xml/sax/ContentHandler;)V

    .line 508
    goto :goto_0

    .line 510
    :sswitch_1
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_lexicalHandler:Lorg/xml/sax/ext/LexicalHandler;

    if-eqz v0, :cond_1

    .line 511
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 512
    .local v0, "n":Lcom/fasterxml/aalto/in/PName;
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_lexicalHandler:Lorg/xml/sax/ext/LexicalHandler;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/XmlScanner;->getDTDPublicId()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    .line 513
    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/XmlScanner;->getDTDSystemId()Ljava/lang/String;

    move-result-object v4

    .line 512
    invoke-interface {v1, v2, v3, v4}, Lorg/xml/sax/ext/LexicalHandler;->startDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 514
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_lexicalHandler:Lorg/xml/sax/ext/LexicalHandler;

    invoke-interface {v1}, Lorg/xml/sax/ext/LexicalHandler;->endDTD()V

    .line 515
    .end local v0    # "n":Lcom/fasterxml/aalto/in/PName;
    goto :goto_0

    .line 524
    :sswitch_2
    if-eqz p2, :cond_1

    .line 525
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->fireSaxSpaceEvents(Lorg/xml/sax/ContentHandler;)V

    goto :goto_0

    .line 498
    :sswitch_3
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_lexicalHandler:Lorg/xml/sax/ext/LexicalHandler;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->fireSaxCommentEvent(Lorg/xml/sax/ext/LexicalHandler;)V

    .line 499
    goto :goto_0

    .line 518
    :sswitch_4
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->fireSaxPIEvent(Lorg/xml/sax/ContentHandler;)V

    .line 519
    nop

    .line 534
    :cond_1
    :goto_0
    return-void

    .line 530
    :cond_2
    const-string v1, "prolog"

    :goto_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->throwSaxException(Ljava/lang/String;)V

    .line 532
    :cond_3
    new-instance v0, Ljava/lang/RuntimeException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Internal error: unexpected type, "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0

    nop

    :sswitch_data_0
    .sparse-switch
        0x3 -> :sswitch_4
        0x5 -> :sswitch_3
        0x6 -> :sswitch_2
        0xb -> :sswitch_1
        0xc -> :sswitch_0
    .end sparse-switch
.end method

.method private final fireEndTag()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 546
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->fireSaxEndElement(Lorg/xml/sax/ContentHandler;)V

    .line 547
    return-void
.end method

.method private final fireEvents()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 452
    nop

    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->nextFromProlog(Z)I

    move-result v0

    move v2, v0

    .local v2, "type":I
    const/4 v3, 0x0

    if-eq v0, v1, :cond_0

    .line 453
    invoke-direct {p0, v2, v3}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->fireAuxEvent(IZ)V

    goto :goto_0

    .line 457
    :cond_0
    invoke-direct {p0}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->fireStartTag()V

    .line 459
    const/4 v0, 0x1

    .line 461
    .local v0, "depth":I
    :cond_1
    :goto_1
    iget-object v4, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/XmlScanner;->nextFromTree()I

    move-result v2

    .line 462
    if-ne v2, v1, :cond_2

    .line 463
    invoke-direct {p0}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->fireStartTag()V

    .line 464
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 465
    :cond_2
    const/4 v4, 0x2

    if-ne v2, v4, :cond_5

    .line 466
    invoke-direct {p0}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->fireEndTag()V

    .line 467
    add-int/lit8 v0, v0, -0x1

    if-ge v0, v1, :cond_1

    .line 468
    nop

    .line 479
    :goto_2
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v1, v3}, Lcom/fasterxml/aalto/in/XmlScanner;->nextFromProlog(Z)I

    move-result v2

    .line 480
    const/4 v1, -0x1

    if-ne v2, v1, :cond_3

    .line 481
    nop

    .line 491
    return-void

    .line 483
    :cond_3
    const/4 v1, 0x6

    if-ne v2, v1, :cond_4

    .line 487
    goto :goto_2

    .line 489
    :cond_4
    invoke-direct {p0, v2, v3}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->fireAuxEvent(IZ)V

    goto :goto_2

    .line 470
    :cond_5
    const/4 v4, 0x4

    if-ne v2, v4, :cond_6

    .line 471
    iget-object v4, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    iget-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-virtual {v4, v5}, Lcom/fasterxml/aalto/in/XmlScanner;->fireSaxCharacterEvents(Lorg/xml/sax/ContentHandler;)V

    goto :goto_1

    .line 473
    :cond_6
    invoke-direct {p0, v2, v1}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->fireAuxEvent(IZ)V

    goto :goto_1
.end method

.method private final fireStartTag()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 539
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrCount()I

    move-result v0

    iput v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCount:I

    .line 540
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-virtual {v0, v1, p0}, Lcom/fasterxml/aalto/in/XmlScanner;->fireSaxStartElement(Lorg/xml/sax/ContentHandler;Lorg/xml/sax/Attributes;)V

    .line 541
    return-void
.end method

.method private throwSaxException(Ljava/lang/Exception;)V
    .locals 2
    .param p1, "e"    # Ljava/lang/Exception;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 769
    new-instance v0, Lorg/xml/sax/SAXParseException;

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1, p0, p1}, Lorg/xml/sax/SAXParseException;-><init>(Ljava/lang/String;Lorg/xml/sax/Locator;Ljava/lang/Exception;)V

    .line 770
    .local v0, "se":Lorg/xml/sax/SAXParseException;
    invoke-virtual {v0}, Lorg/xml/sax/SAXParseException;->getCause()Ljava/lang/Throwable;

    move-result-object v1

    if-nez v1, :cond_0

    .line 771
    invoke-virtual {v0, p1}, Lorg/xml/sax/SAXParseException;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 773
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_errorHandler:Lorg/xml/sax/ErrorHandler;

    if-eqz v1, :cond_1

    .line 774
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_errorHandler:Lorg/xml/sax/ErrorHandler;

    invoke-interface {v1, v0}, Lorg/xml/sax/ErrorHandler;->fatalError(Lorg/xml/sax/SAXParseException;)V

    .line 776
    :cond_1
    throw v0
.end method

.method private throwSaxException(Ljava/lang/String;)V
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 782
    new-instance v0, Lorg/xml/sax/SAXParseException;

    invoke-direct {v0, p1, p0}, Lorg/xml/sax/SAXParseException;-><init>(Ljava/lang/String;Lorg/xml/sax/Locator;)V

    .line 783
    .local v0, "se":Lorg/xml/sax/SAXParseException;
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_errorHandler:Lorg/xml/sax/ErrorHandler;

    if-eqz v1, :cond_0

    .line 784
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_errorHandler:Lorg/xml/sax/ErrorHandler;

    invoke-interface {v1, v0}, Lorg/xml/sax/ErrorHandler;->fatalError(Lorg/xml/sax/SAXParseException;)V

    .line 786
    :cond_0
    throw v0
.end method


# virtual methods
.method public getColumnNumber()I
    .locals 1

    .line 717
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getCurrentColumnNr()I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, -0x1

    :goto_0
    return v0
.end method

.method public getContentHandler()Lorg/xml/sax/ContentHandler;
    .locals 1

    .line 231
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    return-object v0
.end method

.method public getDTDHandler()Lorg/xml/sax/DTDHandler;
    .locals 1

    .line 236
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_dtdHandler:Lorg/xml/sax/DTDHandler;

    return-object v0
.end method

.method public getEncoding()Ljava/lang/String;
    .locals 2

    .line 744
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 745
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getActualEncoding()Ljava/lang/String;

    move-result-object v1

    .line 746
    .local v1, "enc":Ljava/lang/String;
    if-nez v1, :cond_0

    .line 747
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getXmlDeclEncoding()Ljava/lang/String;

    move-result-object v1

    .line 748
    if-nez v1, :cond_0

    .line 749
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getExternalEncoding()Ljava/lang/String;

    move-result-object v1

    .line 752
    :cond_0
    return-object v1
.end method

.method public getEntityResolver()Lorg/xml/sax/EntityResolver;
    .locals 1

    .line 241
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_entityResolver:Lorg/xml/sax/EntityResolver;

    return-object v0
.end method

.method public getErrorHandler()Lorg/xml/sax/ErrorHandler;
    .locals 1

    .line 246
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_errorHandler:Lorg/xml/sax/ErrorHandler;

    return-object v0
.end method

.method public getFeature(Ljava/lang/String;)Z
    .locals 5
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXNotRecognizedException;
        }
    .end annotation

    .line 254
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->findStdFeature(Ljava/lang/String;)Lcom/fasterxml/aalto/sax/SAXFeature;

    move-result-object v0

    .line 255
    .local v0, "stdFeat":Lcom/fasterxml/aalto/sax/SAXFeature;
    if-eqz v0, :cond_1

    .line 257
    invoke-static {v0}, Lcom/fasterxml/aalto/sax/SAXUtil;->getFixedStdFeatureValue(Lcom/fasterxml/aalto/sax/SAXFeature;)Ljava/lang/Boolean;

    move-result-object v1

    .line 258
    .local v1, "b":Ljava/lang/Boolean;
    if-eqz v1, :cond_0

    .line 259
    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    return v2

    .line 262
    :cond_0
    sget-object v2, Lcom/fasterxml/aalto/sax/SAXParserImpl$1;->$SwitchMap$com$fasterxml$aalto$sax$SAXFeature:[I

    invoke-virtual {v0}, Lcom/fasterxml/aalto/sax/SAXFeature;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    goto :goto_0

    .line 267
    :pswitch_0
    sget-object v2, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    iget-object v3, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_staxFactory:Lcom/fasterxml/aalto/stax/InputFactoryImpl;

    const-string v4, "com.fasterxml.aalto.retainAttributeGeneralEntities"

    invoke-virtual {v3, v4}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getProperty(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v2

    return v2

    .line 265
    :pswitch_1
    const/4 v2, 0x1

    return v2

    .line 275
    .end local v1    # "b":Ljava/lang/Boolean;
    :cond_1
    :goto_0
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->reportUnknownFeature(Ljava/lang/String;)V

    .line 276
    const/4 v1, 0x0

    return v1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public getIndex(Ljava/lang/String;)I
    .locals 2
    .param p1, "qName"    # Ljava/lang/String;

    .line 582
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    if-nez v0, :cond_0

    const/4 v0, -0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    .line 583
    const/4 v1, 0x0

    invoke-virtual {v0, v1, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->findIndex(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 582
    :goto_0
    return v0
.end method

.method public getIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 589
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    if-nez v0, :cond_0

    const/4 v0, -0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    .line 590
    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/AttributeCollector;->findIndex(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 589
    :goto_0
    return v0
.end method

.method public getLength()I
    .locals 1

    .line 596
    iget v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCount:I

    return v0
.end method

.method public getLineNumber()I
    .locals 1

    .line 722
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getCurrentLineNr()I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, -0x1

    :goto_0
    return v0
.end method

.method public getLocalName(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 602
    if-ltz p1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCount:I

    if-lt p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    .line 603
    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getName(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 602
    :cond_1
    :goto_0
    const/4 v0, 0x0

    :goto_1
    return-object v0
.end method

.method public final getParser()Lorg/xml/sax/Parser;
    .locals 0

    .line 86
    return-object p0
.end method

.method public getProperty(Ljava/lang/String;)Ljava/lang/Object;
    .locals 4
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXNotRecognizedException;,
            Lorg/xml/sax/SAXNotSupportedException;
        }
    .end annotation

    .line 115
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->findStdProperty(Ljava/lang/String;)Lcom/fasterxml/aalto/sax/SAXProperty;

    move-result-object v0

    .line 116
    .local v0, "stdProp":Lcom/fasterxml/aalto/sax/SAXProperty;
    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 117
    sget-object v2, Lcom/fasterxml/aalto/sax/SAXParserImpl$1;->$SwitchMap$com$fasterxml$aalto$sax$SAXProperty:[I

    invoke-virtual {v0}, Lcom/fasterxml/aalto/sax/SAXProperty;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    goto :goto_0

    .line 128
    :pswitch_0
    return-object v1

    .line 126
    :pswitch_1
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_lexicalHandler:Lorg/xml/sax/ext/LexicalHandler;

    return-object v1

    .line 124
    :pswitch_2
    return-object v1

    .line 122
    :pswitch_3
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v1

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->getXmlDeclVersion()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 119
    :pswitch_4
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_declHandler:Lorg/xml/sax/ext/DeclHandler;

    return-object v1

    .line 131
    :cond_0
    :goto_0
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->reportUnknownProperty(Ljava/lang/String;)V

    .line 132
    return-object v1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public getPublicId()Ljava/lang/String;
    .locals 1

    .line 727
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getInputPublicId()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method public getQName(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 609
    if-ltz p1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCount:I

    if-lt p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    .line 610
    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getName(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 609
    :cond_1
    :goto_0
    const/4 v0, 0x0

    :goto_1
    return-object v0
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 1

    .line 732
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getInputSystemId()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method public getType(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 619
    if-ltz p1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCount:I

    if-lt p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    .line 620
    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrType(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 619
    :cond_1
    :goto_0
    const/4 v0, 0x0

    :goto_1
    return-object v0
.end method

.method public getType(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "qName"    # Ljava/lang/String;

    .line 626
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->getIndex(Ljava/lang/String;)I

    move-result v0

    .line 627
    .local v0, "ix":I
    if-gez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrType(I)Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method public getType(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 633
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->getIndex(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 634
    .local v0, "ix":I
    if-gez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrType(I)Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method public getURI(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 640
    if-ltz p1, :cond_2

    iget v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCount:I

    if-lt p1, v0, :cond_0

    goto :goto_1

    .line 643
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getName(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getNsUri()Ljava/lang/String;

    move-result-object v0

    .line 644
    .local v0, "uri":Ljava/lang/String;
    if-nez v0, :cond_1

    const-string v1, ""

    goto :goto_0

    :cond_1
    move-object v1, v0

    :goto_0
    return-object v1

    .line 641
    .end local v0    # "uri":Ljava/lang/String;
    :cond_2
    :goto_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public getValue(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 650
    if-ltz p1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCount:I

    if-lt p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    .line 651
    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getValue(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 650
    :cond_1
    :goto_0
    const/4 v0, 0x0

    :goto_1
    return-object v0
.end method

.method public getValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "qName"    # Ljava/lang/String;

    .line 657
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->getIndex(Ljava/lang/String;)I

    move-result v0

    .line 658
    .local v0, "ix":I
    if-gez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/in/AttributeCollector;->getValue(I)Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method public getValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 664
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->getIndex(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 665
    .local v0, "ix":I
    if-gez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/in/AttributeCollector;->getValue(I)Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method public final getXMLReader()Lorg/xml/sax/XMLReader;
    .locals 0

    .line 92
    return-object p0
.end method

.method public getXMLVersion()Ljava/lang/String;
    .locals 1

    .line 757
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getXmlDeclVersion()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public isDeclared(I)Z
    .locals 1
    .param p1, "index"    # I

    .line 681
    const/4 v0, 0x0

    return v0
.end method

.method public isDeclared(Ljava/lang/String;)Z
    .locals 1
    .param p1, "qName"    # Ljava/lang/String;

    .line 686
    const/4 v0, 0x0

    return v0
.end method

.method public isDeclared(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 691
    const/4 v0, 0x0

    return v0
.end method

.method public isNamespaceAware()Z
    .locals 1

    .line 103
    const/4 v0, 0x1

    return v0
.end method

.method public isSpecified(I)Z
    .locals 1
    .param p1, "index"    # I

    .line 696
    const/4 v0, 0x1

    return v0
.end method

.method public isSpecified(Ljava/lang/String;)Z
    .locals 1
    .param p1, "qName"    # Ljava/lang/String;

    .line 701
    const/4 v0, 0x1

    return v0
.end method

.method public isSpecified(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 706
    const/4 v0, 0x1

    return v0
.end method

.method public isValidating()Z
    .locals 1

    .line 108
    const/4 v0, 0x0

    return v0
.end method

.method public parse(Ljava/lang/String;)V
    .locals 1
    .param p1, "systemId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 429
    new-instance v0, Lorg/xml/sax/InputSource;

    invoke-direct {v0, p1}, Lorg/xml/sax/InputSource;-><init>(Ljava/lang/String;)V

    .line 430
    .local v0, "src":Lorg/xml/sax/InputSource;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->parse(Lorg/xml/sax/InputSource;)V

    .line 431
    return-void
.end method

.method public parse(Lorg/xml/sax/InputSource;)V
    .locals 9
    .param p1, "input"    # Lorg/xml/sax/InputSource;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 340
    invoke-virtual {p1}, Lorg/xml/sax/InputSource;->getEncoding()Ljava/lang/String;

    move-result-object v6

    .line 341
    .local v6, "enc":Ljava/lang/String;
    invoke-virtual {p1}, Lorg/xml/sax/InputSource;->getSystemId()Ljava/lang/String;

    move-result-object v7

    .line 347
    .local v7, "systemId":Ljava/lang/String;
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_staxFactory:Lcom/fasterxml/aalto/stax/InputFactoryImpl;

    .line 348
    invoke-virtual {p1}, Lorg/xml/sax/InputSource;->getPublicId()Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, v7

    move-object v3, v6

    invoke-virtual/range {v0 .. v5}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getNonSharedConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 353
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->doParseLazily(Z)V

    .line 356
    const/4 v2, 0x0

    .line 357
    .local v2, "is":Ljava/io/InputStream;
    invoke-virtual {p1}, Lorg/xml/sax/InputSource;->getCharacterStream()Ljava/io/Reader;

    move-result-object v3

    .line 358
    .local v3, "r":Ljava/io/Reader;
    if-nez v3, :cond_2

    .line 359
    invoke-virtual {p1}, Lorg/xml/sax/InputSource;->getByteStream()Ljava/io/InputStream;

    move-result-object v2

    .line 360
    if-nez v2, :cond_2

    .line 361
    if-eqz v7, :cond_1

    .line 365
    :try_start_0
    invoke-static {v7}, Lcom/fasterxml/aalto/util/URLUtil;->urlFromSystemId(Ljava/lang/String;)Ljava/net/URL;

    move-result-object v4

    .line 366
    .local v4, "url":Ljava/net/URL;
    invoke-static {v4}, Lcom/fasterxml/aalto/util/URLUtil;->inputStreamFromURL(Ljava/net/URL;)Ljava/io/InputStream;

    move-result-object v5
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v2, v5

    .line 373
    .end local v4    # "url":Ljava/net/URL;
    goto :goto_0

    .line 367
    :catch_0
    move-exception v1

    .line 368
    .local v1, "ioe":Ljava/io/IOException;
    new-instance v4, Lorg/xml/sax/SAXException;

    invoke-direct {v4, v1}, Lorg/xml/sax/SAXException;-><init>(Ljava/lang/Exception;)V

    .line 369
    .local v4, "saxe":Lorg/xml/sax/SAXException;
    invoke-virtual {v4}, Lorg/xml/sax/SAXException;->getCause()Ljava/lang/Throwable;

    move-result-object v5

    if-nez v5, :cond_0

    .line 370
    invoke-virtual {v4, v1}, Lorg/xml/sax/SAXException;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 372
    :cond_0
    throw v4

    .line 362
    .end local v1    # "ioe":Ljava/io/IOException;
    .end local v4    # "saxe":Lorg/xml/sax/SAXException;
    :cond_1
    new-instance v1, Lorg/xml/sax/SAXException;

    const-string v4, "Invalid InputSource passed: neither character or byte stream passed, nor system id specified"

    invoke-direct {v1, v4}, Lorg/xml/sax/SAXException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 377
    :cond_2
    :goto_0
    iget-object v4, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    if-eqz v4, :cond_3

    .line 378
    iget-object v4, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-interface {v4, p0}, Lorg/xml/sax/ContentHandler;->setDocumentLocator(Lorg/xml/sax/Locator;)V

    .line 379
    iget-object v4, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-interface {v4}, Lorg/xml/sax/ContentHandler;->startDocument()V

    .line 383
    :cond_3
    const/4 v4, 0x0

    if-eqz v3, :cond_4

    .line 384
    :try_start_1
    invoke-static {v0, v3}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;)Lcom/fasterxml/aalto/in/CharSourceBootstrapper;

    move-result-object v5

    invoke-virtual {v5}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->bootstrap()Lcom/fasterxml/aalto/in/XmlScanner;

    move-result-object v5

    iput-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    goto :goto_1

    .line 386
    :cond_4
    invoke-static {v0, v2}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;)Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;

    move-result-object v5

    invoke-virtual {v5}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->bootstrap()Lcom/fasterxml/aalto/in/XmlScanner;

    move-result-object v5

    iput-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    .line 388
    :goto_1
    iget-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrCollector()Lcom/fasterxml/aalto/in/AttributeCollector;

    move-result-object v5

    iput-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    .line 389
    invoke-direct {p0}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->fireEvents()V
    :try_end_1
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 393
    iget-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    if-eqz v5, :cond_5

    .line 394
    iget-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-interface {v5}, Lorg/xml/sax/ContentHandler;->endDocument()V

    .line 400
    :cond_5
    iget-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    if-eqz v5, :cond_6

    .line 402
    :try_start_2
    iget-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v5, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->close(Z)V
    :try_end_2
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_2 .. :try_end_2} :catch_1

    .line 410
    goto :goto_2

    .line 403
    :catch_1
    move-exception v1

    .line 411
    :goto_2
    iput-object v4, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    .line 413
    :cond_6
    if-eqz v3, :cond_7

    .line 415
    :try_start_3
    invoke-virtual {v3}, Ljava/io/Reader;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    .line 416
    :goto_3
    goto :goto_4

    :catch_2
    move-exception v1

    goto :goto_3

    .line 418
    :cond_7
    :goto_4
    if-eqz v2, :cond_b

    .line 420
    :try_start_4
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_8

    .line 421
    :catch_3
    move-exception v1

    goto :goto_8

    .line 393
    :catchall_0
    move-exception v5

    goto :goto_9

    .line 390
    :catch_4
    move-exception v5

    .line 391
    .local v5, "strex":Ljavax/xml/stream/XMLStreamException;
    :try_start_5
    invoke-direct {p0, v5}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->throwSaxException(Ljava/lang/Exception;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 393
    .end local v5    # "strex":Ljavax/xml/stream/XMLStreamException;
    iget-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    if-eqz v5, :cond_8

    .line 394
    iget-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-interface {v5}, Lorg/xml/sax/ContentHandler;->endDocument()V

    .line 400
    :cond_8
    iget-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    if-eqz v5, :cond_9

    .line 402
    :try_start_6
    iget-object v5, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v5, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->close(Z)V
    :try_end_6
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_6 .. :try_end_6} :catch_5

    .line 410
    goto :goto_5

    .line 403
    :catch_5
    move-exception v1

    .line 411
    :goto_5
    iput-object v4, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    .line 413
    :cond_9
    if-eqz v3, :cond_a

    .line 415
    :try_start_7
    invoke-virtual {v3}, Ljava/io/Reader;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_6

    .line 416
    :goto_6
    goto :goto_7

    :catch_6
    move-exception v1

    goto :goto_6

    .line 418
    :cond_a
    :goto_7
    if-eqz v2, :cond_b

    .line 420
    :try_start_8
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_3

    .line 421
    :goto_8
    nop

    .line 424
    :cond_b
    return-void

    .line 393
    :goto_9
    iget-object v8, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    if-eqz v8, :cond_c

    .line 394
    iget-object v8, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    invoke-interface {v8}, Lorg/xml/sax/ContentHandler;->endDocument()V

    .line 400
    :cond_c
    iget-object v8, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    if-eqz v8, :cond_d

    .line 402
    :try_start_9
    iget-object v8, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v8, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->close(Z)V
    :try_end_9
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_9 .. :try_end_9} :catch_7

    .line 410
    goto :goto_a

    .line 403
    :catch_7
    move-exception v1

    .line 411
    :goto_a
    iput-object v4, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    .line 413
    :cond_d
    if-eqz v3, :cond_e

    .line 415
    :try_start_a
    invoke-virtual {v3}, Ljava/io/Reader;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_8

    .line 416
    :goto_b
    goto :goto_c

    :catch_8
    move-exception v1

    goto :goto_b

    .line 418
    :cond_e
    :goto_c
    if-eqz v2, :cond_f

    .line 420
    :try_start_b
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_9

    .line 421
    :goto_d
    goto :goto_e

    :catch_9
    move-exception v1

    goto :goto_d

    .line 423
    :cond_f
    :goto_e
    throw v5
.end method

.method public parse(Lorg/xml/sax/InputSource;Lorg/xml/sax/HandlerBase;)V
    .locals 1
    .param p1, "is"    # Lorg/xml/sax/InputSource;
    .param p2, "hb"    # Lorg/xml/sax/HandlerBase;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 177
    if-eqz p2, :cond_3

    .line 182
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    if-nez v0, :cond_0

    .line 183
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->setDocumentHandler(Lorg/xml/sax/DocumentHandler;)V

    .line 185
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_entityResolver:Lorg/xml/sax/EntityResolver;

    if-nez v0, :cond_1

    .line 186
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->setEntityResolver(Lorg/xml/sax/EntityResolver;)V

    .line 188
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_errorHandler:Lorg/xml/sax/ErrorHandler;

    if-nez v0, :cond_2

    .line 189
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->setErrorHandler(Lorg/xml/sax/ErrorHandler;)V

    .line 191
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_dtdHandler:Lorg/xml/sax/DTDHandler;

    if-nez v0, :cond_3

    .line 192
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->setDTDHandler(Lorg/xml/sax/DTDHandler;)V

    .line 195
    :cond_3
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->parse(Lorg/xml/sax/InputSource;)V

    .line 196
    return-void
.end method

.method public parse(Lorg/xml/sax/InputSource;Lorg/xml/sax/helpers/DefaultHandler;)V
    .locals 1
    .param p1, "is"    # Lorg/xml/sax/InputSource;
    .param p2, "dh"    # Lorg/xml/sax/helpers/DefaultHandler;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 202
    if-eqz p2, :cond_3

    .line 207
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    if-nez v0, :cond_0

    .line 208
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->setContentHandler(Lorg/xml/sax/ContentHandler;)V

    .line 210
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_entityResolver:Lorg/xml/sax/EntityResolver;

    if-nez v0, :cond_1

    .line 211
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->setEntityResolver(Lorg/xml/sax/EntityResolver;)V

    .line 213
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_errorHandler:Lorg/xml/sax/ErrorHandler;

    if-nez v0, :cond_2

    .line 214
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->setErrorHandler(Lorg/xml/sax/ErrorHandler;)V

    .line 216
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_dtdHandler:Lorg/xml/sax/DTDHandler;

    if-nez v0, :cond_3

    .line 217
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->setDTDHandler(Lorg/xml/sax/DTDHandler;)V

    .line 220
    :cond_3
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->parse(Lorg/xml/sax/InputSource;)V

    .line 221
    return-void
.end method

.method public setContentHandler(Lorg/xml/sax/ContentHandler;)V
    .locals 0
    .param p1, "handler"    # Lorg/xml/sax/ContentHandler;

    .line 290
    iput-object p1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_contentHandler:Lorg/xml/sax/ContentHandler;

    .line 291
    return-void
.end method

.method public setDTDHandler(Lorg/xml/sax/DTDHandler;)V
    .locals 0
    .param p1, "handler"    # Lorg/xml/sax/DTDHandler;

    .line 295
    iput-object p1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_dtdHandler:Lorg/xml/sax/DTDHandler;

    .line 296
    return-void
.end method

.method public setDocumentHandler(Lorg/xml/sax/DocumentHandler;)V
    .locals 1
    .param p1, "handler"    # Lorg/xml/sax/DocumentHandler;

    .line 564
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;

    invoke-direct {v0, p1}, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;-><init>(Lorg/xml/sax/DocumentHandler;)V

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/sax/SAXParserImpl;->setContentHandler(Lorg/xml/sax/ContentHandler;)V

    .line 565
    return-void
.end method

.method public setEntityResolver(Lorg/xml/sax/EntityResolver;)V
    .locals 0
    .param p1, "resolver"    # Lorg/xml/sax/EntityResolver;

    .line 300
    iput-object p1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_entityResolver:Lorg/xml/sax/EntityResolver;

    .line 301
    return-void
.end method

.method public setErrorHandler(Lorg/xml/sax/ErrorHandler;)V
    .locals 0
    .param p1, "handler"    # Lorg/xml/sax/ErrorHandler;

    .line 305
    iput-object p1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_errorHandler:Lorg/xml/sax/ErrorHandler;

    .line 306
    return-void
.end method

.method public setFeature(Ljava/lang/String;Z)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXNotRecognizedException;
        }
    .end annotation

    .line 313
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->findStdFeature(Ljava/lang/String;)Lcom/fasterxml/aalto/sax/SAXFeature;

    move-result-object v0

    .line 314
    .local v0, "stdFeat":Lcom/fasterxml/aalto/sax/SAXFeature;
    if-eqz v0, :cond_0

    goto :goto_0

    .line 323
    :cond_0
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->reportUnknownFeature(Ljava/lang/String;)V

    .line 326
    :goto_0
    return-void
.end method

.method public setLocale(Ljava/util/Locale;)V
    .locals 0
    .param p1, "locale"    # Ljava/util/Locale;

    .line 571
    return-void
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXNotRecognizedException;,
            Lorg/xml/sax/SAXNotSupportedException;
        }
    .end annotation

    .line 139
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->findStdProperty(Ljava/lang/String;)Lcom/fasterxml/aalto/sax/SAXProperty;

    move-result-object v0

    .line 141
    .local v0, "stdProp":Lcom/fasterxml/aalto/sax/SAXProperty;
    if-eqz v0, :cond_1

    .line 142
    sget-object v1, Lcom/fasterxml/aalto/sax/SAXParserImpl$1;->$SwitchMap$com$fasterxml$aalto$sax$SAXProperty:[I

    invoke-virtual {v0}, Lcom/fasterxml/aalto/sax/SAXProperty;->ordinal()I

    move-result v2

    aget v1, v1, v2

    packed-switch v1, :pswitch_data_0

    goto :goto_1

    .line 156
    :pswitch_0
    return-void

    .line 153
    :pswitch_1
    move-object v1, p2

    check-cast v1, Lorg/xml/sax/ext/LexicalHandler;

    iput-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_lexicalHandler:Lorg/xml/sax/ext/LexicalHandler;

    .line 154
    return-void

    .line 151
    :pswitch_2
    return-void

    .line 148
    :pswitch_3
    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v1

    if-nez p2, :cond_0

    const/4 v2, 0x0

    goto :goto_0

    :cond_0
    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    :goto_0
    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/in/ReaderConfig;->setXmlVersion(Ljava/lang/String;)V

    .line 149
    return-void

    .line 144
    :pswitch_4
    move-object v1, p2

    check-cast v1, Lorg/xml/sax/ext/DeclHandler;

    iput-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl;->_declHandler:Lorg/xml/sax/ext/DeclHandler;

    .line 145
    return-void

    .line 159
    :cond_1
    :goto_1
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->reportUnknownFeature(Ljava/lang/String;)V

    .line 160
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
