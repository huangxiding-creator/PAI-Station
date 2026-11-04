.class public abstract Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;
.super Lorg/codehaus/stax2/evt/XMLEventFactory2;
.source "Stax2EventFactoryImpl.java"


# instance fields
.field protected mLocation:Ljavax/xml/stream/Location;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Lorg/codehaus/stax2/evt/XMLEventFactory2;-><init>()V

    return-void
.end method


# virtual methods
.method public createAttribute(Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/stream/events/Attribute;
    .locals 8
    .param p1, "localName"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 49
    new-instance v7, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    const/4 v4, 0x0

    const/4 v6, 0x1

    const/4 v3, 0x0

    move-object v0, v7

    move-object v2, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v6}, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    return-object v7
.end method

.method public createAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/stream/events/Attribute;
    .locals 8
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/lang/String;

    .line 55
    new-instance v7, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    const/4 v6, 0x1

    move-object v0, v7

    move-object v2, p3

    move-object v3, p2

    move-object v4, p1

    move-object v5, p4

    invoke-direct/range {v0 .. v6}, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    return-object v7
.end method

.method public createAttribute(Ljavax/xml/namespace/QName;Ljava/lang/String;)Ljavax/xml/stream/events/Attribute;
    .locals 3
    .param p1, "name"    # Ljavax/xml/namespace/QName;
    .param p2, "value"    # Ljava/lang/String;

    .line 44
    new-instance v0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    const/4 v2, 0x1

    invoke-direct {v0, v1, p1, p2, v2}, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;-><init>(Ljavax/xml/stream/Location;Ljavax/xml/namespace/QName;Ljava/lang/String;Z)V

    return-object v0
.end method

.method public createCData(Ljava/lang/String;)Ljavax/xml/stream/events/Characters;
    .locals 3
    .param p1, "content"    # Ljava/lang/String;

    .line 60
    new-instance v0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    const/4 v2, 0x1

    invoke-direct {v0, v1, p1, v2}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Z)V

    return-object v0
.end method

.method public createCharacters(Ljava/lang/String;)Ljavax/xml/stream/events/Characters;
    .locals 3
    .param p1, "content"    # Ljava/lang/String;

    .line 65
    new-instance v0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    const/4 v2, 0x0

    invoke-direct {v0, v1, p1, v2}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Z)V

    return-object v0
.end method

.method public createComment(Ljava/lang/String;)Ljavax/xml/stream/events/Comment;
    .locals 2
    .param p1, "text"    # Ljava/lang/String;

    .line 70
    new-instance v0, Lorg/codehaus/stax2/ri/evt/CommentEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-direct {v0, v1, p1}, Lorg/codehaus/stax2/ri/evt/CommentEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V

    return-object v0
.end method

.method public createDTD(Ljava/lang/String;)Ljavax/xml/stream/events/DTD;
    .locals 2
    .param p1, "dtd"    # Ljava/lang/String;

    .line 80
    new-instance v0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-direct {v0, v1, p1}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V

    return-object v0
.end method

.method public createDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/evt/DTD2;
    .locals 8
    .param p1, "rootName"    # Ljava/lang/String;
    .param p2, "sysId"    # Ljava/lang/String;
    .param p3, "pubId"    # Ljava/lang/String;
    .param p4, "intSubset"    # Ljava/lang/String;

    .line 206
    new-instance v7, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    const/4 v6, 0x0

    move-object v0, v7

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v6}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v7
.end method

.method public createDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Lorg/codehaus/stax2/evt/DTD2;
    .locals 8
    .param p1, "rootName"    # Ljava/lang/String;
    .param p2, "sysId"    # Ljava/lang/String;
    .param p3, "pubId"    # Ljava/lang/String;
    .param p4, "intSubset"    # Ljava/lang/String;
    .param p5, "processedDTD"    # Ljava/lang/Object;

    .line 213
    new-instance v7, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    move-object v0, v7

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    invoke-direct/range {v0 .. v6}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    return-object v7
.end method

.method public createEndDocument()Ljavax/xml/stream/events/EndDocument;
    .locals 2

    .line 85
    new-instance v0, Lorg/codehaus/stax2/ri/evt/EndDocumentEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/evt/EndDocumentEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    return-object v0
.end method

.method public createEndElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/stream/events/EndElement;
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;

    .line 97
    invoke-virtual {p0, p2, p3, p1}, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->createQName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->createEndElement(Ljavax/xml/namespace/QName;Ljava/util/Iterator;)Ljavax/xml/stream/events/EndElement;

    move-result-object v0

    return-object v0
.end method

.method public createEndElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Iterator;)Ljavax/xml/stream/events/EndElement;
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "ns"    # Ljava/util/Iterator;

    .line 104
    invoke-virtual {p0, p2, p3, p1}, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->createQName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;

    move-result-object v0

    invoke-virtual {p0, v0, p4}, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->createEndElement(Ljavax/xml/namespace/QName;Ljava/util/Iterator;)Ljavax/xml/stream/events/EndElement;

    move-result-object v0

    return-object v0
.end method

.method public createEndElement(Ljavax/xml/namespace/QName;Ljava/util/Iterator;)Ljavax/xml/stream/events/EndElement;
    .locals 2
    .param p1, "name"    # Ljavax/xml/namespace/QName;
    .param p2, "namespaces"    # Ljava/util/Iterator;

    .line 91
    new-instance v0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-direct {v0, v1, p1, p2}, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;-><init>(Ljavax/xml/stream/Location;Ljavax/xml/namespace/QName;Ljava/util/Iterator;)V

    return-object v0
.end method

.method public createEntityReference(Ljava/lang/String;Ljavax/xml/stream/events/EntityDeclaration;)Ljavax/xml/stream/events/EntityReference;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "decl"    # Ljavax/xml/stream/events/EntityDeclaration;

    .line 110
    new-instance v0, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-direct {v0, v1, p2}, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;-><init>(Ljavax/xml/stream/Location;Ljavax/xml/stream/events/EntityDeclaration;)V

    return-object v0
.end method

.method public createIgnorableSpace(Ljava/lang/String;)Ljavax/xml/stream/events/Characters;
    .locals 1
    .param p1, "content"    # Ljava/lang/String;

    .line 115
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-static {v0, p1}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->createIgnorableWS(Ljavax/xml/stream/Location;Ljava/lang/String;)Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;

    move-result-object v0

    return-object v0
.end method

.method public createNamespace(Ljava/lang/String;)Ljavax/xml/stream/events/Namespace;
    .locals 1
    .param p1, "nsURI"    # Ljava/lang/String;

    .line 120
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-static {v0, p1}, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;->constructDefaultNamespace(Ljavax/xml/stream/Location;Ljava/lang/String;)Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;

    move-result-object v0

    return-object v0
.end method

.method public createNamespace(Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/stream/events/Namespace;
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;

    .line 125
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;->constructNamespace(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;

    move-result-object v0

    return-object v0
.end method

.method public createProcessingInstruction(Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/stream/events/ProcessingInstruction;
    .locals 2
    .param p1, "target"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/String;

    .line 130
    new-instance v0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-direct {v0, v1, p1, p2}, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method protected abstract createQName(Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;
.end method

.method protected abstract createQName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;
.end method

.method public createSpace(Ljava/lang/String;)Ljavax/xml/stream/events/Characters;
    .locals 1
    .param p1, "content"    # Ljava/lang/String;

    .line 135
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-static {v0, p1}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->createNonIgnorableWS(Ljavax/xml/stream/Location;Ljava/lang/String;)Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;

    move-result-object v0

    return-object v0
.end method

.method public createStartDocument()Ljavax/xml/stream/events/StartDocument;
    .locals 2

    .line 140
    new-instance v0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    return-object v0
.end method

.method public createStartDocument(Ljava/lang/String;)Ljavax/xml/stream/events/StartDocument;
    .locals 2
    .param p1, "encoding"    # Ljava/lang/String;

    .line 145
    new-instance v0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-direct {v0, v1, p1}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V

    return-object v0
.end method

.method public createStartDocument(Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/stream/events/StartDocument;
    .locals 2
    .param p1, "encoding"    # Ljava/lang/String;
    .param p2, "version"    # Ljava/lang/String;

    .line 150
    new-instance v0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-direct {v0, v1, p1, p2}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method public createStartDocument(Ljava/lang/String;Ljava/lang/String;Z)Ljavax/xml/stream/events/StartDocument;
    .locals 7
    .param p1, "encoding"    # Ljava/lang/String;
    .param p2, "version"    # Ljava/lang/String;
    .param p3, "standalone"    # Z

    .line 155
    new-instance v6, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    const/4 v4, 0x1

    move-object v0, v6

    move-object v2, p1

    move-object v3, p2

    move v5, p3

    invoke-direct/range {v0 .. v5}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;ZZ)V

    return-object v6
.end method

.method public createStartElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/stream/events/StartElement;
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;

    .line 166
    invoke-virtual {p0, p2, p3, p1}, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->createQName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1, v1, v1}, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->createStartElement(Ljavax/xml/namespace/QName;Ljava/util/Iterator;Ljava/util/Iterator;Ljavax/xml/namespace/NamespaceContext;)Ljavax/xml/stream/events/StartElement;

    move-result-object v0

    return-object v0
.end method

.method public createStartElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Iterator;Ljava/util/Iterator;)Ljavax/xml/stream/events/StartElement;
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "attr"    # Ljava/util/Iterator;
    .param p5, "ns"    # Ljava/util/Iterator;

    .line 176
    invoke-virtual {p0, p2, p3, p1}, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->createQName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p4, p5, v1}, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->createStartElement(Ljavax/xml/namespace/QName;Ljava/util/Iterator;Ljava/util/Iterator;Ljavax/xml/namespace/NamespaceContext;)Ljavax/xml/stream/events/StartElement;

    move-result-object v0

    return-object v0
.end method

.method public createStartElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Iterator;Ljava/util/Iterator;Ljavax/xml/namespace/NamespaceContext;)Ljavax/xml/stream/events/StartElement;
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "attr"    # Ljava/util/Iterator;
    .param p5, "ns"    # Ljava/util/Iterator;
    .param p6, "nsCtxt"    # Ljavax/xml/namespace/NamespaceContext;

    .line 186
    invoke-virtual {p0, p2, p3, p1}, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->createQName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;

    move-result-object v0

    invoke-virtual {p0, v0, p4, p5, p6}, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->createStartElement(Ljavax/xml/namespace/QName;Ljava/util/Iterator;Ljava/util/Iterator;Ljavax/xml/namespace/NamespaceContext;)Ljavax/xml/stream/events/StartElement;

    move-result-object v0

    return-object v0
.end method

.method public createStartElement(Ljavax/xml/namespace/QName;Ljava/util/Iterator;Ljava/util/Iterator;)Ljavax/xml/stream/events/StartElement;
    .locals 1
    .param p1, "name"    # Ljavax/xml/namespace/QName;
    .param p2, "attr"    # Ljava/util/Iterator;
    .param p3, "ns"    # Ljava/util/Iterator;

    .line 161
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->createStartElement(Ljavax/xml/namespace/QName;Ljava/util/Iterator;Ljava/util/Iterator;Ljavax/xml/namespace/NamespaceContext;)Ljavax/xml/stream/events/StartElement;

    move-result-object v0

    return-object v0
.end method

.method protected createStartElement(Ljavax/xml/namespace/QName;Ljava/util/Iterator;Ljava/util/Iterator;Ljavax/xml/namespace/NamespaceContext;)Ljavax/xml/stream/events/StartElement;
    .locals 1
    .param p1, "name"    # Ljavax/xml/namespace/QName;
    .param p4, "ctxt"    # Ljavax/xml/namespace/NamespaceContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljavax/xml/namespace/QName;",
            "Ljava/util/Iterator<",
            "*>;",
            "Ljava/util/Iterator<",
            "*>;",
            "Ljavax/xml/namespace/NamespaceContext;",
            ")",
            "Ljavax/xml/stream/events/StartElement;"
        }
    .end annotation

    .line 230
    .local p2, "attr":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .local p3, "ns":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    invoke-static {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->construct(Ljavax/xml/stream/Location;Ljavax/xml/namespace/QName;Ljava/util/Iterator;Ljava/util/Iterator;Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;

    move-result-object v0

    return-object v0
.end method

.method public setLocation(Ljavax/xml/stream/Location;)V
    .locals 0
    .param p1, "loc"    # Ljavax/xml/stream/Location;

    .line 193
    iput-object p1, p0, Lorg/codehaus/stax2/ri/Stax2EventFactoryImpl;->mLocation:Ljavax/xml/stream/Location;

    .line 194
    return-void
.end method
