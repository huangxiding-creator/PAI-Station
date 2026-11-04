.class public Lorg/codehaus/stax2/ri/Stax2WriterAdapter;
.super Lorg/codehaus/stax2/util/StreamWriterDelegate;
.source "Stax2WriterAdapter.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamWriter2;
.implements Ljavax/xml/stream/XMLStreamConstants;


# instance fields
.field protected mEncoding:Ljava/lang/String;

.field protected final mNsRepairing:Z

.field protected mValueEncoder:Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;


# direct methods
.method protected constructor <init>(Ljavax/xml/stream/XMLStreamWriter;)V
    .locals 2
    .param p1, "sw"    # Ljavax/xml/stream/XMLStreamWriter;

    .line 75
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/util/StreamWriterDelegate;-><init>(Ljavax/xml/stream/XMLStreamWriter;)V

    .line 76
    iput-object p1, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    .line 77
    const-string v0, "javax.xml.stream.isRepairingNamespaces"

    invoke-interface {p1, v0}, Ljavax/xml/stream/XMLStreamWriter;->getProperty(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 78
    .local v0, "value":Ljava/lang/Object;
    instance-of v1, v0, Ljava/lang/Boolean;

    if-eqz v1, :cond_0

    move-object v1, v0

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    iput-boolean v1, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mNsRepairing:Z

    .line 79
    return-void
.end method

.method public static wrapIfNecessary(Ljavax/xml/stream/XMLStreamWriter;)Lorg/codehaus/stax2/XMLStreamWriter2;
    .locals 1
    .param p0, "sw"    # Ljavax/xml/stream/XMLStreamWriter;

    .line 91
    instance-of v0, p0, Lorg/codehaus/stax2/XMLStreamWriter2;

    if-eqz v0, :cond_0

    .line 92
    move-object v0, p0

    check-cast v0, Lorg/codehaus/stax2/XMLStreamWriter2;

    return-object v0

    .line 94
    :cond_0
    new-instance v0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;

    invoke-direct {v0, p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;-><init>(Ljavax/xml/stream/XMLStreamWriter;)V

    return-object v0
.end method


# virtual methods
.method public closeCompletely()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 534
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->close()V

    .line 535
    return-void
.end method

.method public copyEventFromReader(Lorg/codehaus/stax2/XMLStreamReader2;Z)V
    .locals 5
    .param p1, "sr"    # Lorg/codehaus/stax2/XMLStreamReader2;
    .param p2, "preserveEventData"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 433
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getEventType()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 517
    :pswitch_0
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unrecognized event type ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 518
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getEventType()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "); not sure how to copy"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 478
    :pswitch_1
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextCharacters()[C

    move-result-object v0

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextStart()I

    move-result v1

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextLength()I

    move-result v2

    invoke-virtual {p0, v0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeCData([CII)V

    .line 479
    return-void

    .line 495
    :pswitch_2
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getDTDInfo()Lorg/codehaus/stax2/DTDInfo;

    move-result-object v0

    .line 496
    .local v0, "info":Lorg/codehaus/stax2/DTDInfo;
    if-eqz v0, :cond_0

    .line 502
    invoke-interface {v0}, Lorg/codehaus/stax2/DTDInfo;->getDTDRootName()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0}, Lorg/codehaus/stax2/DTDInfo;->getDTDSystemId()Ljava/lang/String;

    move-result-object v2

    .line 503
    invoke-interface {v0}, Lorg/codehaus/stax2/DTDInfo;->getDTDPublicId()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0}, Lorg/codehaus/stax2/DTDInfo;->getDTDInternalSubset()Ljava/lang/String;

    move-result-object v4

    .line 502
    invoke-virtual {p0, v1, v2, v3, v4}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 505
    .end local v0    # "info":Lorg/codehaus/stax2/DTDInfo;
    return-void

    .line 500
    .restart local v0    # "info":Lorg/codehaus/stax2/DTDInfo;
    :cond_0
    new-instance v1, Ljavax/xml/stream/XMLStreamException;

    const-string v2, "Current state DOCTYPE, but not DTDInfo Object returned -- reader doesn\'t support DTDs?"

    invoke-direct {v1, v2}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 508
    .end local v0    # "info":Lorg/codehaus/stax2/DTDInfo;
    :pswitch_3
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getLocalName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeEntityRef(Ljava/lang/String;)V

    .line 509
    return-void

    .line 457
    :pswitch_4
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeEndDocument()V

    .line 458
    return-void

    .line 436
    :pswitch_5
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getVersion()Ljava/lang/String;

    move-result-object v0

    .line 441
    .local v0, "version":Ljava/lang/String;
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    goto :goto_0

    .line 444
    :cond_1
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->standaloneSet()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 445
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getVersion()Ljava/lang/String;

    move-result-object v1

    .line 446
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getCharacterEncodingScheme()Ljava/lang/String;

    move-result-object v2

    .line 447
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->isStandalone()Z

    move-result v3

    .line 445
    invoke-virtual {p0, v1, v2, v3}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeStartDocument(Ljava/lang/String;Ljava/lang/String;Z)V

    goto :goto_0

    .line 449
    :cond_2
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getCharacterEncodingScheme()Ljava/lang/String;

    move-result-object v1

    .line 450
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getVersion()Ljava/lang/String;

    move-result-object v2

    .line 449
    invoke-virtual {p0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeStartDocument(Ljava/lang/String;Ljava/lang/String;)V

    .line 454
    .end local v0    # "version":Ljava/lang/String;
    :cond_3
    :goto_0
    return-void

    .line 474
    :pswitch_6
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextCharacters()[C

    move-result-object v0

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextStart()I

    move-result v1

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextLength()I

    move-result v2

    invoke-virtual {p0, v0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeSpace([CII)V

    .line 475
    return-void

    .line 486
    :pswitch_7
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getText()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeComment(Ljava/lang/String;)V

    .line 487
    return-void

    .line 482
    :pswitch_8
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextCharacters()[C

    move-result-object v0

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextStart()I

    move-result v1

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextLength()I

    move-result v2

    invoke-virtual {p0, v0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeCharacters([CII)V

    .line 483
    return-void

    .line 490
    :pswitch_9
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getPITarget()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getPIData()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeProcessingInstruction(Ljava/lang/String;Ljava/lang/String;)V

    .line 491
    return-void

    .line 470
    :pswitch_a
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeEndElement()V

    .line 471
    return-void

    .line 466
    :pswitch_b
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->copyStartElement(Ljavax/xml/stream/XMLStreamReader;)V

    .line 467
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected copyStartElement(Ljavax/xml/stream/XMLStreamReader;)V
    .locals 7
    .param p1, "sr"    # Ljavax/xml/stream/XMLStreamReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 584
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceCount()I

    move-result v0

    .line 585
    .local v0, "nsCount":I
    if-lez v0, :cond_2

    .line 590
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_2

    .line 591
    invoke-interface {p1, v1}, Ljavax/xml/stream/XMLStreamReader;->getNamespacePrefix(I)Ljava/lang/String;

    move-result-object v2

    .line 592
    .local v2, "prefix":Ljava/lang/String;
    invoke-interface {p1, v1}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceURI(I)Ljava/lang/String;

    move-result-object v3

    .line 593
    .local v3, "uri":Ljava/lang/String;
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-nez v4, :cond_0

    goto :goto_1

    .line 596
    :cond_0
    invoke-virtual {p0, v2, v3}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->setPrefix(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 594
    :cond_1
    :goto_1
    invoke-virtual {p0, v3}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->setDefaultNamespace(Ljava/lang/String;)V

    .line 590
    .end local v2    # "prefix":Ljava/lang/String;
    .end local v3    # "uri":Ljava/lang/String;
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 600
    .end local v1    # "i":I
    :cond_2
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getLocalName()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceURI()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v1, v2, v3}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeStartElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 602
    if-lez v0, :cond_5

    .line 604
    const/4 v1, 0x0

    .restart local v1    # "i":I
    :goto_3
    if-ge v1, v0, :cond_5

    .line 605
    invoke-interface {p1, v1}, Ljavax/xml/stream/XMLStreamReader;->getNamespacePrefix(I)Ljava/lang/String;

    move-result-object v2

    .line 606
    .restart local v2    # "prefix":Ljava/lang/String;
    invoke-interface {p1, v1}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceURI(I)Ljava/lang/String;

    move-result-object v3

    .line 608
    .restart local v3    # "uri":Ljava/lang/String;
    if-eqz v2, :cond_4

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-nez v4, :cond_3

    goto :goto_4

    .line 611
    :cond_3
    invoke-virtual {p0, v2, v3}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_5

    .line 609
    :cond_4
    :goto_4
    invoke-virtual {p0, v3}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeDefaultNamespace(Ljava/lang/String;)V

    .line 604
    .end local v2    # "prefix":Ljava/lang/String;
    .end local v3    # "uri":Ljava/lang/String;
    :goto_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 619
    .end local v1    # "i":I
    :cond_5
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getAttributeCount()I

    move-result v1

    .line 620
    .local v1, "attrCount":I
    if-lez v1, :cond_6

    .line 621
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_6
    if-ge v2, v1, :cond_6

    .line 622
    invoke-interface {p1, v2}, Ljavax/xml/stream/XMLStreamReader;->getAttributePrefix(I)Ljava/lang/String;

    move-result-object v3

    .line 623
    invoke-interface {p1, v2}, Ljavax/xml/stream/XMLStreamReader;->getAttributeNamespace(I)Ljava/lang/String;

    move-result-object v4

    .line 624
    invoke-interface {p1, v2}, Ljavax/xml/stream/XMLStreamReader;->getAttributeLocalName(I)Ljava/lang/String;

    move-result-object v5

    .line 625
    invoke-interface {p1, v2}, Ljavax/xml/stream/XMLStreamReader;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v6

    .line 622
    invoke-virtual {p0, v3, v4, v5, v6}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 621
    add-int/lit8 v2, v2, 0x1

    goto :goto_6

    .line 628
    .end local v2    # "i":I
    :cond_6
    return-void
.end method

.method public getEncoding()Ljava/lang/String;
    .locals 1

    .line 318
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mEncoding:Ljava/lang/String;

    return-object v0
.end method

.method public getLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1

    .line 311
    const/4 v0, 0x0

    return-object v0
.end method

.method protected getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;
    .locals 1

    .line 674
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mValueEncoder:Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    if-nez v0, :cond_0

    .line 675
    new-instance v0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mValueEncoder:Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    .line 677
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mValueEncoder:Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    return-object v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 298
    const/4 v0, 0x0

    return v0
.end method

.method protected serializeQNameValue(Ljavax/xml/namespace/QName;)Ljava/lang/String;
    .locals 5
    .param p1, "name"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 640
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mNsRepairing:Z

    if-eqz v0, :cond_4

    .line 641
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getNamespaceURI()Ljava/lang/String;

    move-result-object v0

    .line 643
    .local v0, "uri":Ljava/lang/String;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v1

    .line 644
    .local v1, "ctxt":Ljavax/xml/namespace/NamespaceContext;
    if-nez v1, :cond_0

    const/4 v2, 0x0

    goto :goto_0

    :cond_0
    invoke-interface {v1, v0}, Ljavax/xml/namespace/NamespaceContext;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 645
    .local v2, "prefix":Ljava/lang/String;
    :goto_0
    if-nez v2, :cond_3

    .line 647
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v3

    .line 648
    .local v3, "origPrefix":Ljava/lang/String;
    if-eqz v3, :cond_2

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-nez v4, :cond_1

    goto :goto_1

    .line 656
    :cond_1
    move-object v2, v3

    .line 657
    invoke-virtual {p0, v2, v0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 649
    :cond_2
    :goto_1
    const-string v2, ""

    .line 654
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeDefaultNamespace(Ljava/lang/String;)V

    .line 660
    .end local v0    # "uri":Ljava/lang/String;
    .end local v1    # "ctxt":Ljavax/xml/namespace/NamespaceContext;
    .end local v3    # "origPrefix":Ljava/lang/String;
    :cond_3
    :goto_2
    goto :goto_3

    .line 661
    .end local v2    # "prefix":Ljava/lang/String;
    :cond_4
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v2

    .line 663
    .restart local v2    # "prefix":Ljava/lang/String;
    :goto_3
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v0

    .line 664
    .local v0, "local":Ljava/lang/String;
    if-eqz v2, :cond_6

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_5

    goto :goto_4

    .line 669
    :cond_5
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ":"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 665
    :cond_6
    :goto_4
    return-object v0
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 304
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "No settable property \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;
    .locals 1
    .param p1, "h"    # Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 571
    const/4 v0, 0x0

    return-object v0
.end method

.method public stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 555
    const/4 v0, 0x0

    return-object v0
.end method

.method public stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidator;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "validator"    # Lorg/codehaus/stax2/validation/XMLValidator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 562
    const/4 v0, 0x0

    return-object v0
.end method

.method public validateAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 2
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 548
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Not yet implemented"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public writeBinary(Lorg/codehaus/stax2/typed/Base64Variant;[BII)V
    .locals 2
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "value"    # [B
    .param p3, "from"    # I
    .param p4, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 186
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v1

    invoke-virtual {v1, p1, p2, p3, p4}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString(Lorg/codehaus/stax2/typed/Base64Variant;[BII)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 187
    return-void
.end method

.method public writeBinary([BII)V
    .locals 1
    .param p1, "value"    # [B
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 193
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeBinary(Lorg/codehaus/stax2/typed/Base64Variant;[BII)V

    .line 194
    return-void
.end method

.method public writeBinaryAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 6
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 277
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v1

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-virtual/range {v0 .. v5}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeBinaryAttribute(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V

    .line 278
    return-void
.end method

.method public writeBinaryAttribute(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 4
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "nsURI"    # Ljava/lang/String;
    .param p4, "localName"    # Ljava/lang/String;
    .param p5, "value"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 283
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    .line 284
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v1

    const/4 v2, 0x0

    array-length v3, p5

    invoke-virtual {v1, p1, p5, v2, v3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString(Lorg/codehaus/stax2/typed/Base64Variant;[BII)Ljava/lang/String;

    move-result-object v1

    .line 283
    invoke-interface {v0, p2, p3, p4, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 285
    return-void
.end method

.method public writeBoolean(Z)V
    .locals 2
    .param p1, "b"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 109
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    if-eqz p1, :cond_0

    const-string v1, "true"

    goto :goto_0

    :cond_0
    const-string v1, "false"

    :goto_0
    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 110
    return-void
.end method

.method public writeBooleanAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "b"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 201
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    if-eqz p4, :cond_0

    const-string v1, "true"

    goto :goto_0

    :cond_0
    const-string v1, "false"

    :goto_0
    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 202
    return-void
.end method

.method public writeCData([CII)V
    .locals 1
    .param p1, "text"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 325
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p1, p2, p3}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeCData(Ljava/lang/String;)V

    .line 326
    return-void
.end method

.method public writeDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "rootName"    # Ljava/lang/String;
    .param p2, "systemId"    # Ljava/lang/String;
    .param p3, "publicId"    # Ljava/lang/String;
    .param p4, "internalSubset"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 336
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    .line 337
    .local v0, "sb":Ljava/lang/StringBuffer;
    const-string v1, "<!DOCTYPE"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 338
    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 339
    if-eqz p2, :cond_1

    .line 340
    if-eqz p3, :cond_0

    .line 341
    const-string v1, " PUBLIC \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 342
    invoke-virtual {v0, p3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 343
    const-string v1, "\" \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_0

    .line 345
    :cond_0
    const-string v1, " SYSTEM \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 347
    :goto_0
    invoke-virtual {v0, p2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 348
    const/16 v1, 0x22

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 351
    :cond_1
    if-eqz p4, :cond_2

    invoke-virtual {p4}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_2

    .line 352
    const-string v1, " ["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 353
    invoke-virtual {v0, p4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 354
    const/16 v1, 0x5d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 356
    :cond_2
    const/16 v1, 0x3e

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 357
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeDTD(Ljava/lang/String;)V

    .line 358
    return-void
.end method

.method public writeDecimal(Ljava/math/BigDecimal;)V
    .locals 2
    .param p1, "value"    # Ljava/math/BigDecimal;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 145
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-virtual {p1}, Ljava/math/BigDecimal;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 146
    return-void
.end method

.method public writeDecimalAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/math/BigDecimal;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/math/BigDecimal;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 237
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-virtual {p4}, Ljava/math/BigDecimal;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 238
    return-void
.end method

.method public writeDouble(D)V
    .locals 2
    .param p1, "value"    # D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 133
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 134
    return-void
.end method

.method public writeDoubleArray([DII)V
    .locals 2
    .param p1, "value"    # [D
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 179
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v1

    invoke-virtual {v1, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([DII)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 180
    return-void
.end method

.method public writeDoubleArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[D)V
    .locals 4
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 270
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    .line 271
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v1

    const/4 v2, 0x0

    array-length v3, p4

    invoke-virtual {v1, p4, v2, v3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([DII)Ljava/lang/String;

    move-result-object v1

    .line 270
    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 272
    return-void
.end method

.method public writeDoubleAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 225
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-static {p4, p5}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 226
    return-void
.end method

.method public writeFloat(F)V
    .locals 2
    .param p1, "value"    # F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 127
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-static {p1}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 128
    return-void
.end method

.method public writeFloatArray([FII)V
    .locals 2
    .param p1, "value"    # [F
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 172
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v1

    invoke-virtual {v1, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([FII)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 173
    return-void
.end method

.method public writeFloatArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[F)V
    .locals 4
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 263
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    .line 264
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v1

    const/4 v2, 0x0

    array-length v3, p4

    invoke-virtual {v1, p4, v2, v3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([FII)Ljava/lang/String;

    move-result-object v1

    .line 263
    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 265
    return-void
.end method

.method public writeFloatAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 219
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-static {p4}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 220
    return-void
.end method

.method public writeFullEndElement()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 368
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    const-string v1, ""

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 369
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-interface {v0}, Ljavax/xml/stream/XMLStreamWriter;->writeEndElement()V

    .line 370
    return-void
.end method

.method public writeInt(I)V
    .locals 2
    .param p1, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 115
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 116
    return-void
.end method

.method public writeIntArray([III)V
    .locals 2
    .param p1, "value"    # [I
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 158
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v1

    invoke-virtual {v1, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([III)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 159
    return-void
.end method

.method public writeIntArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[I)V
    .locals 4
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 249
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    .line 250
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v1

    const/4 v2, 0x0

    array-length v3, p4

    invoke-virtual {v1, p4, v2, v3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([III)Ljava/lang/String;

    move-result-object v1

    .line 249
    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 251
    return-void
.end method

.method public writeIntAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 207
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-static {p4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 208
    return-void
.end method

.method public writeInteger(Ljava/math/BigInteger;)V
    .locals 2
    .param p1, "value"    # Ljava/math/BigInteger;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 139
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-virtual {p1}, Ljava/math/BigInteger;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 140
    return-void
.end method

.method public writeIntegerAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/math/BigInteger;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/math/BigInteger;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 231
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-virtual {p4}, Ljava/math/BigInteger;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 232
    return-void
.end method

.method public writeLong(J)V
    .locals 2
    .param p1, "value"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 121
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 122
    return-void
.end method

.method public writeLongArray([JII)V
    .locals 2
    .param p1, "value"    # [J
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 165
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v1

    invoke-virtual {v1, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([JII)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 166
    return-void
.end method

.method public writeLongArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[J)V
    .locals 4
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 256
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    .line 257
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v1

    const/4 v2, 0x0

    array-length v3, p4

    invoke-virtual {v1, p4, v2, v3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([JII)Ljava/lang/String;

    move-result-object v1

    .line 256
    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 258
    return-void
.end method

.method public writeLongAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 213
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-static {p4, p5}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 214
    return-void
.end method

.method public writeQName(Ljavax/xml/namespace/QName;)V
    .locals 2
    .param p1, "name"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 151
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->serializeQNameValue(Ljavax/xml/namespace/QName;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeCharacters(Ljava/lang/String;)V

    .line 152
    return-void
.end method

.method public writeQNameAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljavax/xml/namespace/QName;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "name"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 243
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->mDelegate:Ljavax/xml/stream/XMLStreamWriter;

    invoke-virtual {p0, p4}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->serializeQNameValue(Ljavax/xml/namespace/QName;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, p1, p2, p3, v1}, Ljavax/xml/stream/XMLStreamWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 244
    return-void
.end method

.method public writeRaw(Ljava/lang/String;)V
    .locals 2
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 411
    const/4 v0, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p0, p1, v0, v1}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeRaw(Ljava/lang/String;II)V

    .line 412
    return-void
.end method

.method public writeRaw(Ljava/lang/String;II)V
    .locals 2
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 419
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Not implemented"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public writeRaw([CII)V
    .locals 1
    .param p1, "text"    # [C
    .param p2, "offset"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 426
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p1, p2, p3}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeRaw(Ljava/lang/String;)V

    .line 427
    return-void
.end method

.method public writeSpace(Ljava/lang/String;)V
    .locals 0
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 381
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeRaw(Ljava/lang/String;)V

    .line 382
    return-void
.end method

.method public writeSpace([CII)V
    .locals 0
    .param p1, "text"    # [C
    .param p2, "offset"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 389
    invoke-virtual {p0, p1, p2, p3}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeRaw([CII)V

    .line 390
    return-void
.end method

.method public writeStartDocument(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 0
    .param p1, "version"    # Ljava/lang/String;
    .param p2, "encoding"    # Ljava/lang/String;
    .param p3, "standAlone"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 398
    invoke-virtual {p0, p2, p1}, Lorg/codehaus/stax2/ri/Stax2WriterAdapter;->writeStartDocument(Ljava/lang/String;Ljava/lang/String;)V

    .line 399
    return-void
.end method
