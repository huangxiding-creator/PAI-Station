.class public Lorg/codehaus/stax2/ri/evt/Stax2EventAllocatorImpl;
.super Ljava/lang/Object;
.source "Stax2EventAllocatorImpl.java"

# interfaces
.implements Ljavax/xml/stream/util/XMLEventAllocator;
.implements Ljavax/xml/stream/XMLStreamConstants;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public allocate(Ljavax/xml/stream/XMLStreamReader;)Ljavax/xml/stream/events/XMLEvent;
    .locals 5
    .param p1, "r"    # Ljavax/xml/stream/XMLStreamReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 40
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/evt/Stax2EventAllocatorImpl;->getLocation(Ljavax/xml/stream/XMLStreamReader;)Ljavax/xml/stream/Location;

    move-result-object v0

    .line 42
    .local v0, "loc":Ljavax/xml/stream/Location;
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getEventType()I

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    packed-switch v1, :pswitch_data_0

    .line 88
    :pswitch_0
    new-instance v1, Ljavax/xml/stream/XMLStreamException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unrecognized event type "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getEventType()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 44
    :pswitch_1
    new-instance v1, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getText()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v0, v3, v2}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Z)V

    return-object v1

    .line 50
    :pswitch_2
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/evt/Stax2EventAllocatorImpl;->createDTD(Ljavax/xml/stream/XMLStreamReader;Ljavax/xml/stream/Location;)Ljavax/xml/stream/events/DTD;

    move-result-object v1

    return-object v1

    .line 73
    :pswitch_3
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/evt/Stax2EventAllocatorImpl;->createEntityReference(Ljavax/xml/stream/XMLStreamReader;Ljavax/xml/stream/Location;)Ljavax/xml/stream/events/EntityReference;

    move-result-object v1

    return-object v1

    .line 53
    :pswitch_4
    new-instance v1, Lorg/codehaus/stax2/ri/evt/EndDocumentEventImpl;

    invoke-direct {v1, v0}, Lorg/codehaus/stax2/ri/evt/EndDocumentEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    return-object v1

    .line 67
    :pswitch_5
    new-instance v1, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;

    invoke-direct {v1, v0, p1}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;-><init>(Ljavax/xml/stream/Location;Ljavax/xml/stream/XMLStreamReader;)V

    return-object v1

    .line 62
    :pswitch_6
    new-instance v1, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getText()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v0, v4, v3}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Z)V

    .line 63
    .local v1, "ch":Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;
    invoke-virtual {v1, v2}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->setWhitespaceStatus(Z)V

    .line 64
    return-object v1

    .line 48
    .end local v1    # "ch":Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;
    :pswitch_7
    new-instance v1, Lorg/codehaus/stax2/ri/evt/CommentEventImpl;

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getText()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v0, v2}, Lorg/codehaus/stax2/ri/evt/CommentEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V

    return-object v1

    .line 46
    :pswitch_8
    new-instance v1, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getText()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v0, v2, v3}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Z)V

    return-object v1

    .line 59
    :pswitch_9
    new-instance v1, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getPITarget()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getPIData()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v0, v2, v3}, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)V

    return-object v1

    .line 56
    :pswitch_a
    new-instance v1, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;

    invoke-direct {v1, v0, p1}, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;-><init>(Ljavax/xml/stream/Location;Ljavax/xml/stream/XMLStreamReader;)V

    return-object v1

    .line 70
    :pswitch_b
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/evt/Stax2EventAllocatorImpl;->createStartElement(Ljavax/xml/stream/XMLStreamReader;Ljavax/xml/stream/Location;)Ljavax/xml/stream/events/StartElement;

    move-result-object v1

    return-object v1

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

.method public allocate(Ljavax/xml/stream/XMLStreamReader;Ljavax/xml/stream/util/XMLEventConsumer;)V
    .locals 1
    .param p1, "r"    # Ljavax/xml/stream/XMLStreamReader;
    .param p2, "consumer"    # Ljavax/xml/stream/util/XMLEventConsumer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 96
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/evt/Stax2EventAllocatorImpl;->allocate(Ljavax/xml/stream/XMLStreamReader;)Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    invoke-interface {p2, v0}, Ljavax/xml/stream/util/XMLEventConsumer;->add(Ljavax/xml/stream/events/XMLEvent;)V

    .line 97
    return-void
.end method

.method protected createDTD(Ljavax/xml/stream/XMLStreamReader;Ljavax/xml/stream/Location;)Ljavax/xml/stream/events/DTD;
    .locals 10
    .param p1, "r"    # Ljavax/xml/stream/XMLStreamReader;
    .param p2, "loc"    # Ljavax/xml/stream/Location;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 137
    instance-of v0, p1, Lorg/codehaus/stax2/XMLStreamReader2;

    if-eqz v0, :cond_0

    .line 138
    move-object v0, p1

    check-cast v0, Lorg/codehaus/stax2/XMLStreamReader2;

    .line 139
    .local v0, "sr2":Lorg/codehaus/stax2/XMLStreamReader2;
    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getDTDInfo()Lorg/codehaus/stax2/DTDInfo;

    move-result-object v1

    .line 140
    .local v1, "dtd":Lorg/codehaus/stax2/DTDInfo;
    new-instance v9, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;

    .line 142
    invoke-interface {v1}, Lorg/codehaus/stax2/DTDInfo;->getDTDRootName()Ljava/lang/String;

    move-result-object v4

    .line 143
    invoke-interface {v1}, Lorg/codehaus/stax2/DTDInfo;->getDTDSystemId()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v1}, Lorg/codehaus/stax2/DTDInfo;->getDTDPublicId()Ljava/lang/String;

    move-result-object v6

    .line 144
    invoke-interface {v1}, Lorg/codehaus/stax2/DTDInfo;->getDTDInternalSubset()Ljava/lang/String;

    move-result-object v7

    .line 145
    invoke-interface {v1}, Lorg/codehaus/stax2/DTDInfo;->getProcessedDTD()Ljava/lang/Object;

    move-result-object v8

    move-object v2, v9

    move-object v3, p2

    invoke-direct/range {v2 .. v8}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    .line 140
    return-object v9

    .line 151
    .end local v0    # "sr2":Lorg/codehaus/stax2/XMLStreamReader2;
    .end local v1    # "dtd":Lorg/codehaus/stax2/DTDInfo;
    :cond_0
    new-instance v0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;

    const/4 v1, 0x0

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getText()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, p2, v1, v2}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method protected createEntityReference(Ljavax/xml/stream/XMLStreamReader;Ljavax/xml/stream/Location;)Ljavax/xml/stream/events/EntityReference;
    .locals 2
    .param p1, "r"    # Ljavax/xml/stream/XMLStreamReader;
    .param p2, "loc"    # Ljavax/xml/stream/Location;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 130
    new-instance v0, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getLocalName()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, p2, v1}, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V

    return-object v0
.end method

.method protected createStartElement(Ljavax/xml/stream/XMLStreamReader;Ljavax/xml/stream/Location;)Ljavax/xml/stream/events/StartElement;
    .locals 9
    .param p1, "r"    # Ljavax/xml/stream/XMLStreamReader;
    .param p2, "loc"    # Ljavax/xml/stream/Location;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 157
    const/4 v0, 0x0

    .line 162
    .local v0, "nsCtxt":Ljavax/xml/namespace/NamespaceContext;
    instance-of v1, p1, Lorg/codehaus/stax2/XMLStreamReader2;

    if-eqz v1, :cond_0

    .line 163
    move-object v1, p1

    check-cast v1, Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v1}, Lorg/codehaus/stax2/XMLStreamReader2;->getNonTransientNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v0

    .line 168
    :cond_0
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getAttributeCount()I

    move-result v1

    .line 169
    .local v1, "attrCount":I
    const/4 v2, 0x1

    if-ge v1, v2, :cond_1

    .line 170
    const/4 v3, 0x0

    .local v3, "attrs":Ljava/util/List;, "Ljava/util/List<Ljavax/xml/stream/events/Attribute;>;"
    goto :goto_1

    .line 172
    .end local v3    # "attrs":Ljava/util/List;, "Ljava/util/List<Ljavax/xml/stream/events/Attribute;>;"
    :cond_1
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 173
    .restart local v3    # "attrs":Ljava/util/List;, "Ljava/util/List<Ljavax/xml/stream/events/Attribute;>;"
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    if-ge v4, v1, :cond_2

    .line 174
    invoke-interface {p1, v4}, Ljavax/xml/stream/XMLStreamReader;->getAttributeName(I)Ljavax/xml/namespace/QName;

    move-result-object v5

    .line 175
    .local v5, "aname":Ljavax/xml/namespace/QName;
    new-instance v6, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;

    invoke-interface {p1, v4}, Ljavax/xml/stream/XMLStreamReader;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v7

    invoke-interface {p1, v4}, Ljavax/xml/stream/XMLStreamReader;->isAttributeSpecified(I)Z

    move-result v8

    invoke-direct {v6, p2, v5, v7, v8}, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;-><init>(Ljavax/xml/stream/Location;Ljavax/xml/namespace/QName;Ljava/lang/String;Z)V

    invoke-interface {v3, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 173
    .end local v5    # "aname":Ljavax/xml/namespace/QName;
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 181
    .end local v1    # "attrCount":I
    .end local v4    # "i":I
    :cond_2
    :goto_1
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceCount()I

    move-result v1

    .line 182
    .local v1, "nsCount":I
    if-ge v1, v2, :cond_3

    .line 183
    const/4 v2, 0x0

    .local v2, "ns":Ljava/util/List;, "Ljava/util/List<Ljavax/xml/stream/events/Namespace;>;"
    goto :goto_3

    .line 185
    .end local v2    # "ns":Ljava/util/List;, "Ljava/util/List<Ljavax/xml/stream/events/Namespace;>;"
    :cond_3
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 186
    .restart local v2    # "ns":Ljava/util/List;, "Ljava/util/List<Ljavax/xml/stream/events/Namespace;>;"
    const/4 v4, 0x0

    .restart local v4    # "i":I
    :goto_2
    if-ge v4, v1, :cond_4

    .line 187
    invoke-interface {p1, v4}, Ljavax/xml/stream/XMLStreamReader;->getNamespacePrefix(I)Ljava/lang/String;

    move-result-object v5

    invoke-interface {p1, v4}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceURI(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {p2, v5, v6}, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;->constructNamespace(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;

    move-result-object v5

    invoke-interface {v2, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 186
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 192
    .end local v1    # "nsCount":I
    .end local v4    # "i":I
    :cond_4
    :goto_3
    nop

    .line 193
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getName()Ljavax/xml/namespace/QName;

    move-result-object v1

    if-nez v3, :cond_5

    .line 194
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyIterator;->getInstance()Ljava/util/Iterator;

    move-result-object v4

    goto :goto_4

    :cond_5
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_4
    if-nez v2, :cond_6

    .line 195
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyIterator;->getInstance()Ljava/util/Iterator;

    move-result-object v5

    goto :goto_5

    :cond_6
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    .line 193
    :goto_5
    invoke-static {p2, v1, v4, v5, v0}, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->construct(Ljavax/xml/stream/Location;Ljavax/xml/namespace/QName;Ljava/util/Iterator;Ljava/util/Iterator;Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;

    move-result-object v1

    .line 192
    return-object v1
.end method

.method protected getLocation(Ljavax/xml/stream/XMLStreamReader;)Ljavax/xml/stream/Location;
    .locals 1
    .param p1, "r"    # Ljavax/xml/stream/XMLStreamReader;

    .line 118
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v0

    return-object v0
.end method

.method public newInstance()Ljavax/xml/stream/util/XMLEventAllocator;
    .locals 1

    .line 101
    new-instance v0, Lorg/codehaus/stax2/ri/evt/Stax2EventAllocatorImpl;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/evt/Stax2EventAllocatorImpl;-><init>()V

    return-object v0
.end method
