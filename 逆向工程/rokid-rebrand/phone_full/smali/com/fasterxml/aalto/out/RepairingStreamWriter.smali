.class public final Lcom/fasterxml/aalto/out/RepairingStreamWriter;
.super Lcom/fasterxml/aalto/out/StreamWriterBase;
.source "RepairingStreamWriter.java"


# instance fields
.field _autoNsSeq:[I

.field final _cfgAutomaticNsPrefix:Ljava/lang/String;

.field _suggestedDefNs:Ljava/lang/String;

.field _suggestedPrefixes:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/out/WriterConfig;Lcom/fasterxml/aalto/out/XmlWriter;Lcom/fasterxml/aalto/out/WNameTable;)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;
    .param p2, "writer"    # Lcom/fasterxml/aalto/out/XmlWriter;
    .param p3, "symbols"    # Lcom/fasterxml/aalto/out/WNameTable;

    .line 81
    invoke-direct {p0, p1, p2, p3}, Lcom/fasterxml/aalto/out/StreamWriterBase;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Lcom/fasterxml/aalto/out/XmlWriter;Lcom/fasterxml/aalto/out/WNameTable;)V

    .line 59
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_autoNsSeq:[I

    .line 61
    iput-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedDefNs:Ljava/lang/String;

    .line 70
    iput-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedPrefixes:Ljava/util/HashMap;

    .line 82
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WriterConfig;->getAutomaticNsPrefix()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_cfgAutomaticNsPrefix:Ljava/lang/String;

    .line 83
    return-void
.end method

.method private final _writeStartAndVerify(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Z
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "nsURI"    # Ljava/lang/String;
    .param p4, "isEmpty"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 401
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 407
    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_verifyStartElement(Ljava/lang/String;Ljava/lang/String;)V

    .line 408
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    invoke-virtual {p0, v0, p4, p3}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeStartTag(Lcom/fasterxml/aalto/out/WName;ZLjava/lang/String;)V

    .line 409
    const/4 v0, 0x0

    return v0

    .line 402
    :cond_1
    :goto_0
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p2}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_verifyStartElement(Ljava/lang/String;Ljava/lang/String;)V

    .line 403
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    invoke-virtual {p0, v0, p4, p3}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeStartTag(Lcom/fasterxml/aalto/out/WName;ZLjava/lang/String;)V

    .line 404
    const/4 v0, 0x1

    return v0
.end method


# virtual methods
.method protected _generateAttrName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 5
    .param p1, "suggPrefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 301
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 302
    sget-object v0, Lcom/fasterxml/aalto/out/RepairingStreamWriter$1;->$SwitchMap$com$fasterxml$aalto$out$OutputElement$PrefixState:[I

    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v2, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-virtual {v1, p1, p3, v2}, Lcom/fasterxml/aalto/out/OutputElement;->checkPrefixValidity(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Lcom/fasterxml/aalto/out/OutputElement$PrefixState;

    move-result-object v1

    invoke-virtual {v1}, Lcom/fasterxml/aalto/out/OutputElement$PrefixState;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 304
    :pswitch_0
    invoke-virtual {p0, p1, p3}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    .line 305
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, p1, p3}, Lcom/fasterxml/aalto/out/OutputElement;->addPrefix(Ljava/lang/String;Ljava/lang/String;)V

    .line 308
    :pswitch_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    return-object v0

    .line 316
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-virtual {v0, p3, v1}, Lcom/fasterxml/aalto/out/OutputElement;->getExplicitPrefix(Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Ljava/lang/String;

    move-result-object v0

    .line 317
    .local v0, "prefix":Ljava/lang/String;
    if-nez v0, :cond_2

    .line 318
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_autoNsSeq:[I

    if-nez v1, :cond_1

    .line 319
    const/4 v1, 0x1

    new-array v2, v1, [I

    iput-object v2, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_autoNsSeq:[I

    .line 320
    iget-object v2, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_autoNsSeq:[I

    const/4 v3, 0x0

    aput v1, v2, v3

    .line 322
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v2, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    iget-object v3, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_cfgAutomaticNsPrefix:Ljava/lang/String;

    iget-object v4, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_autoNsSeq:[I

    invoke-virtual {v1, v2, v3, v4}, Lcom/fasterxml/aalto/out/OutputElement;->generatePrefix(Ljavax/xml/namespace/NamespaceContext;Ljava/lang/String;[I)Ljava/lang/String;

    move-result-object v0

    .line 323
    invoke-virtual {p0, v0, p3}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    .line 324
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v1, v0, p3}, Lcom/fasterxml/aalto/out/OutputElement;->addPrefix(Ljava/lang/String;Ljava/lang/String;)V

    .line 326
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v1, v0, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v1

    return-object v1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method protected final _generateElemPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 421
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedDefNs:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedDefNs:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 422
    const/4 v0, 0x0

    return-object v0

    .line 425
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedPrefixes:Ljava/util/HashMap;

    if-eqz v0, :cond_1

    .line 426
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedPrefixes:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 427
    .local v0, "prefix":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 428
    return-object v0

    .line 438
    .end local v0    # "prefix":Ljava/lang/String;
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_autoNsSeq:[I

    if-nez v0, :cond_2

    .line 439
    const/4 v0, 0x1

    new-array v1, v0, [I

    iput-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_autoNsSeq:[I

    .line 440
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_autoNsSeq:[I

    const/4 v2, 0x0

    aput v0, v1, v2

    .line 442
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    iget-object v2, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_cfgAutomaticNsPrefix:Ljava/lang/String;

    iget-object v3, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_autoNsSeq:[I

    invoke-virtual {v0, v1, v2, v3}, Lcom/fasterxml/aalto/out/OutputElement;->generatePrefix(Ljavax/xml/namespace/NamespaceContext;Ljava/lang/String;[I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected _serializeQName(Ljavax/xml/namespace/QName;)Ljava/lang/String;
    .locals 5
    .param p1, "name"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 268
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getNamespaceURI()Ljava/lang/String;

    move-result-object v0

    .line 269
    .local v0, "uri":Ljava/lang/String;
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v1

    .line 270
    .local v1, "prefix":Ljava/lang/String;
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v2

    .line 273
    .local v2, "local":Ljava/lang/String;
    iget-object v3, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v4, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-virtual {v3, v1, v0, v4}, Lcom/fasterxml/aalto/out/OutputElement;->isPrefixBoundTo(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 274
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    if-nez v3, :cond_0

    goto :goto_0

    .line 277
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ":"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 275
    :cond_1
    :goto_0
    return-object v2

    .line 284
    :cond_2
    invoke-virtual {p0, v1, v2, v0}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_generateAttrName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v3

    .line 285
    .local v3, "newName":Lcom/fasterxml/aalto/out/WName;
    invoke-virtual {v3}, Lcom/fasterxml/aalto/out/WName;->getPrefixedName()Ljava/lang/String;

    move-result-object v4

    return-object v4
.end method

.method public _setPrefix(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;

    .line 113
    if-eqz p2, :cond_2

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 124
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedPrefixes:Ljava/util/HashMap;

    if-nez v0, :cond_1

    .line 125
    new-instance v0, Ljava/util/HashMap;

    const/16 v1, 0x10

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    iput-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedPrefixes:Ljava/util/HashMap;

    .line 127
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedPrefixes:Ljava/util/HashMap;

    invoke-virtual {v0, p2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 114
    :cond_2
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedPrefixes:Ljava/util/HashMap;

    if-eqz v0, :cond_5

    .line 115
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedPrefixes:Ljava/util/HashMap;

    .line 116
    invoke-virtual {v0}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;>;"
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 117
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 118
    .local v1, "en":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 119
    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    .line 121
    .end local v1    # "en":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_3
    goto :goto_1

    .end local v0    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;>;"
    :cond_4
    nop

    .line 129
    :cond_5
    :goto_2
    return-void
.end method

.method public _writeStartOrEmpty(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 4
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "nsURI"    # Ljava/lang/String;
    .param p4, "isEmpty"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 336
    const-string v0, ""

    if-eqz p3, :cond_8

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_2

    .line 354
    :cond_0
    if-nez p1, :cond_3

    .line 355
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v1, p3}, Lcom/fasterxml/aalto/out/OutputElement;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 357
    if-eqz p1, :cond_1

    .line 358
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeStartAndVerify(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Z

    goto :goto_0

    .line 361
    :cond_1
    invoke-virtual {p0, p3}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_generateElemPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 362
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeStartAndVerify(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 363
    invoke-virtual {p0, p3}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeDefaultNamespace(Ljava/lang/String;)V

    .line 364
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v1, p3}, Lcom/fasterxml/aalto/out/OutputElement;->setDefaultNsURI(Ljava/lang/String;)V

    goto :goto_0

    .line 366
    :cond_2
    invoke-virtual {p0, p1, p3}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    .line 367
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v1, p1, p3}, Lcom/fasterxml/aalto/out/OutputElement;->addPrefix(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 371
    :cond_3
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeStartAndVerify(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v1

    .line 373
    .local v1, "isDef":Z
    iget-object v2, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v3, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-virtual {v2, p1, p3, v3}, Lcom/fasterxml/aalto/out/OutputElement;->isPrefixBoundTo(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Z

    move-result v2

    if-nez v2, :cond_5

    .line 375
    if-eqz v1, :cond_4

    .line 376
    invoke-virtual {p0, p3}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeDefaultNamespace(Ljava/lang/String;)V

    .line 377
    iget-object v2, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v2, p3}, Lcom/fasterxml/aalto/out/OutputElement;->setDefaultNsURI(Ljava/lang/String;)V

    goto :goto_0

    .line 379
    :cond_4
    invoke-virtual {p0, p1, p3}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    .line 380
    iget-object v2, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v2, p1, p3}, Lcom/fasterxml/aalto/out/OutputElement;->addPrefix(Ljava/lang/String;Ljava/lang/String;)V

    .line 386
    .end local v1    # "isDef":Z
    :cond_5
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-eqz v1, :cond_7

    .line 387
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-nez p1, :cond_6

    move-object v2, v0

    goto :goto_1

    :cond_6
    move-object v2, p1

    :goto_1
    invoke-virtual {v1, p2, v0, v2}, Lorg/codehaus/stax2/validation/XMLValidator;->validateElementStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 390
    :cond_7
    return-void

    .line 338
    :cond_8
    :goto_2
    const/4 v1, 0x0

    invoke-virtual {p0, v1, p2}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_verifyStartElement(Ljava/lang/String;Ljava/lang/String;)V

    .line 340
    iget-object v2, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v2, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v2

    .line 341
    .local v2, "name":Lcom/fasterxml/aalto/out/WName;
    invoke-virtual {p0, v2, p4, v1}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeStartTag(Lcom/fasterxml/aalto/out/WName;ZLjava/lang/String;)V

    .line 342
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/out/OutputElement;->hasEmptyDefaultNs()Z

    move-result v1

    if-nez v1, :cond_9

    .line 343
    invoke-virtual {p0, p3}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeDefaultNamespace(Ljava/lang/String;)V

    .line 345
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/out/OutputElement;->setDefaultNsURI(Ljava/lang/String;)V

    .line 347
    :cond_9
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-eqz v1, :cond_a

    .line 348
    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v1, p2, v0, v0}, Lorg/codehaus/stax2/validation/XMLValidator;->validateElementStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 350
    :cond_a
    return-void
.end method

.method public setDefaultNamespace(Ljava/lang/String;)V
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 100
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    move-object v0, p1

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x0

    :goto_1
    iput-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_suggestedDefNs:Ljava/lang/String;

    .line 101
    return-void
.end method

.method public writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 137
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_stateStartElementOpen:Z

    if-nez v0, :cond_0

    .line 138
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_ATTR_NO_ELEM:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 141
    :cond_0
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 142
    :cond_1
    nop

    .line 143
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p2, p1}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_generateAttrName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    goto :goto_1

    .line 141
    :cond_2
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    .line 142
    invoke-virtual {v0, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .line 143
    :goto_1
    nop

    .line 144
    .local v0, "name":Lcom/fasterxml/aalto/out/WName;
    invoke-virtual {p0, v0, p3}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V

    .line 145
    return-void
.end method

.method public writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 152
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_stateStartElementOpen:Z

    if-nez v0, :cond_0

    .line 153
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_ATTR_NO_ELEM:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 156
    :cond_0
    if-eqz p2, :cond_2

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 158
    :cond_1
    invoke-virtual {p0, p1, p3, p2}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_generateAttrName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    goto :goto_1

    .line 156
    :cond_2
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    .line 157
    invoke-virtual {v0, p3}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .line 158
    :goto_1
    nop

    .line 159
    .local v0, "name":Lcom/fasterxml/aalto/out/WName;
    invoke-virtual {p0, v0, p4}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V

    .line 160
    return-void
.end method

.method public writeDefaultNamespace(Ljava/lang/String;)V
    .locals 1
    .param p1, "nsURI"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 166
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_stateStartElementOpen:Z

    if-nez v0, :cond_0

    .line 167
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_NS_NO_ELEM:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 175
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/OutputElement;->hasPrefix()Z

    move-result v0

    if-nez v0, :cond_1

    .line 176
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/OutputElement;->setDefaultNsURI(Ljava/lang/String;)V

    .line 177
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeDefaultNamespace(Ljava/lang/String;)V

    .line 179
    :cond_1
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeDefaultNamespace(Ljava/lang/String;)V

    .line 180
    return-void
.end method

.method public writeEmptyElement(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 190
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-virtual {p0, v0, p2, p1, v1}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeStartOrEmpty(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 191
    return-void
.end method

.method public writeEmptyElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "nsURI"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 197
    const/4 v0, 0x1

    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeStartOrEmpty(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 198
    return-void
.end method

.method public writeNamespace(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 206
    if-eqz p1, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 210
    :cond_0
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_stateStartElementOpen:Z

    if-nez v0, :cond_1

    .line 211
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_NS_NO_ELEM:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 219
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/aalto/out/OutputElement;->isPrefixUnbound(Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 220
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/OutputElement;->addPrefix(Ljava/lang/String;Ljava/lang/String;)V

    .line 221
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    .line 223
    :cond_2
    return-void

    .line 207
    :cond_3
    :goto_0
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->writeDefaultNamespace(Ljava/lang/String;)V

    .line 208
    return-void
.end method

.method public writeStartElement(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 231
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p2, p1, v1}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeStartOrEmpty(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 232
    return-void
.end method

.method public writeStartElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "nsURI"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 238
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeStartOrEmpty(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 239
    return-void
.end method

.method public writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "enc"    # Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 253
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_stateStartElementOpen:Z

    if-nez v0, :cond_0

    .line 254
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_ATTR_NO_ELEM:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 256
    :cond_0
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 257
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    .line 258
    invoke-virtual {v0, p1, p3}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    goto :goto_1

    .line 256
    :cond_2
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    .line 257
    invoke-virtual {v0, p3}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .line 258
    :goto_1
    nop

    .line 259
    .local v0, "name":Lcom/fasterxml/aalto/out/WName;
    invoke-virtual {p0, v0, p4}, Lcom/fasterxml/aalto/out/RepairingStreamWriter;->_writeAttribute(Lcom/fasterxml/aalto/out/WName;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 260
    return-void
.end method
